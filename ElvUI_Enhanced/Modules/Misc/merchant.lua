local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local savedMerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick

function M:AltBuyMaxStack()
	if not E.db.enhanced.general.altBuyMaxStack then return end
	function MerchantItemButton_OnModifiedClick()
		if IsAltKeyDown() then
			local itemLink = GetMerchantItemLink(this:GetID())
			if not itemLink then return end
			local maxStack = select(8, GetItemInfo(itemLink))
			if maxStack and maxStack > 1 then
				BuyMerchantItem(this:GetID(), GetMerchantItemMaxStack(this:GetID()))
			end
		end
		savedMerchantItemButton_OnModifiedClick()
	end
end