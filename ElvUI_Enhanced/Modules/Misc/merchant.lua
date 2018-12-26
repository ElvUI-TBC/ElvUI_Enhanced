local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local _G = _G
local select = select

local BuyMerchantItem = BuyMerchantItem
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local GetMerchantItemLink = GetMerchantItemLink
local GetMerchantItemMaxStack = GetMerchantItemMaxStack
local GetMerchantNumItems = GetMerchantNumItems
local ARMOR, ENCHSLOT_WEAPON = ARMOR, ENCHSLOT_WEAPON

function M:MerchantItemButton_OnModifiedClick()
	if IsAltKeyDown() then
		local maxStack = select(8, GetItemInfo(GetMerchantItemLink(this:GetID())))

		if maxStack and maxStack > 1 then
			BuyMerchantItem(this:GetID(), GetMerchantItemMaxStack(this:GetID()))
		end
	end
end

function M:BuyStackToggle()
	if E.db.enhanced.general.merchantItemLevel then
		if not self:IsHooked("MerchantItemButton_OnModifiedClick") then
			self:SecureHook("MerchantItemButton_OnModifiedClick")
		end
	else
		if self:IsHooked("MerchantItemButton_OnModifiedClick") then
			self:Unhook("MerchantItemButton_OnModifiedClick")
		end
	end
end

local function MerchantItemlevel()
	local numMerchantItems = GetMerchantNumItems()
	local index, button, itemLink, buybackName
	local _, quality, itemlevel, itemType
	local r, g, b

	for i = 1, BUYBACK_ITEMS_PER_PAGE do
		index = ((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i
		button = _G["MerchantItem"..i.."ItemButton"]

		if not button.text then
			button.text = button:CreateFontString(nil, "OVERLAY")
			button.text:FontTemplate(E.LSM:Fetch("font", E.db.bags.itemLevelFont), E.db.bags.itemLevelFontSize, E.db.bags.itemLevelFontOutline)
			button.text:SetPoint("BOTTOMRIGHT", 0, 3)
		end
		button.text:SetText("")

		if index <= numMerchantItems then
			itemLink = GetMerchantItemLink(index)
			if itemLink then
				_, _, quality, itemlevel, _, itemType = GetItemInfo(itemLink)
				r, g, b = GetItemQualityColor(quality)

				if (itemlevel and itemlevel > 1) and (quality and quality > 1) and (itemType == ENCHSLOT_WEAPON or itemType == ARMOR) then
					if E.db.enhanced.general.merchantItemLevel then
						button.text:SetText(itemlevel)
						button.text:SetTextColor(r, g, b)
					else
						button.text:SetText("")
					end
				end
			end
		end

		if not MerchantBuyBackItemItemButton.text then
			MerchantBuyBackItemItemButton.text = MerchantBuyBackItemItemButton:CreateFontString(nil, "OVERLAY")
			MerchantBuyBackItemItemButton.text:FontTemplate(E.LSM:Fetch("font", E.db.bags.itemLevelFont), E.db.bags.itemLevelFontSize, E.db.bags.itemLevelFontOutline)
			MerchantBuyBackItemItemButton.text:SetPoint("BOTTOMRIGHT", 0, 3)
		end
		MerchantBuyBackItemItemButton.text:SetText("")

		buybackName = GetBuybackItemInfo(GetNumBuybackItems())
		if buybackName then
			_, _, quality, itemlevel, _, itemType = GetItemInfo(buybackName)
			r, g, b = GetItemQualityColor(quality)

			if (itemlevel and itemlevel > 1) and (quality and quality > 1) and (itemType == ENCHSLOT_WEAPON or itemType == ARMOR) then
				if E.db.enhanced.general.merchantItemLevel then
					MerchantBuyBackItemItemButton.text:SetText(itemlevel)
					MerchantBuyBackItemItemButton.text:SetTextColor(r, g, b)
				else
					MerchantBuyBackItemItemButton.text:SetText("")
				end
			end
		end
	end
end
hooksecurefunc("MerchantFrame_UpdateMerchantInfo", MerchantItemlevel)

local function MerchantBuybackItemlevel()
	local numBuybackItems = GetNumBuybackItems()
	local button, buybackName
	local _, quality, itemlevel, itemType
	local r, g, b

	for i = 1, BUYBACK_ITEMS_PER_PAGE do
		button = _G["MerchantItem"..i.."ItemButton"]

		if not button.text then
			button.text = button:CreateFontString(nil, "OVERLAY")
			button.text:FontTemplate(E.LSM:Fetch("font", E.db.bags.itemLevelFont), E.db.bags.itemLevelFontSize, E.db.bags.itemLevelFontOutline)
			button.text:SetPoint("BOTTOMRIGHT", 0, 3)
		end
		button.text:SetText("")

		if i <= numBuybackItems then
			buybackName = GetBuybackItemInfo(i)
			if buybackName then
				_, _, quality, itemlevel, _, itemType = GetItemInfo(buybackName)
				r, g, b = GetItemQualityColor(quality)

				if (itemlevel and itemlevel > 1) and (quality and quality > 1) and (itemType == ENCHSLOT_WEAPON or itemType == ARMOR) then
					if E.db.enhanced.general.merchantItemLevel then
						button.text:SetText(itemlevel)
						button.text:SetTextColor(r, g, b)
					else
						button.text:SetText("")
					end
				end
			end
		end
	end
end
hooksecurefunc("MerchantFrame_UpdateBuybackInfo", MerchantBuybackItemlevel)