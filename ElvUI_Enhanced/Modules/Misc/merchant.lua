local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local _G = _G
local select = select

local BuyMerchantItem = BuyMerchantItem
local GetBuybackItemInfo = GetBuybackItemInfo
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local GetNumBuybackItems = GetNumBuybackItems
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
	if E.db.enhanced.general.altBuyMaxStack then
		if not self:IsHooked("MerchantItemButton_OnModifiedClick") then
			self:SecureHook("MerchantItemButton_OnModifiedClick")
		end
	else
		if self:IsHooked("MerchantItemButton_OnModifiedClick") then
			self:Unhook("MerchantItemButton_OnModifiedClick")
		end
	end
end

function M:MerchantFrame_UpdateMerchantInfo()
	local index, button, itemLink
	local _, quality, itemlevel, itemType, r, g, b

	for i = 1, BUYBACK_ITEMS_PER_PAGE do
		index = ((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i
		button = _G["MerchantItem"..i.."ItemButton"]

		if not button.text then
			button.text = button:CreateFontString(nil, "OVERLAY")
			button.text:FontTemplate(E.LSM:Fetch("font", E.db.bags.itemLevelFont), E.db.bags.itemLevelFontSize, E.db.bags.itemLevelFontOutline)
			button.text:SetPoint("BOTTOMRIGHT", 0, 3)
		end

		if index <= GetMerchantNumItems() then
			itemLink = GetMerchantItemLink(index)

			if itemLink then
				_, _, quality, itemlevel, _, itemType = GetItemInfo(itemLink)
				r, g, b = GetItemQualityColor(quality)

				button.text:SetText("")

				if (itemlevel and itemlevel > 1) and (quality and quality > 1) and (itemType == ENCHSLOT_WEAPON or itemType == ARMOR) then
					button.text:SetText(itemlevel)
					button.text:SetTextColor(r, g, b)
				end
			end
		end

		if not MerchantBuyBackItemItemButton.text then
			MerchantBuyBackItemItemButton.text = MerchantBuyBackItemItemButton:CreateFontString(nil, "OVERLAY")
			MerchantBuyBackItemItemButton.text:FontTemplate(E.LSM:Fetch("font", E.db.bags.itemLevelFont), E.db.bags.itemLevelFontSize, E.db.bags.itemLevelFontOutline)
			MerchantBuyBackItemItemButton.text:SetPoint("BOTTOMRIGHT", 0, 3)
		end

		if GetBuybackItemInfo(GetNumBuybackItems()) then
			_, _, quality, itemlevel, _, itemType = GetItemInfo(GetBuybackItemInfo(GetNumBuybackItems()))
			r, g, b = GetItemQualityColor(quality)

			MerchantBuyBackItemItemButton.text:SetText("")

			if (itemlevel and itemlevel > 1) and (quality and quality > 1) and (itemType == ENCHSLOT_WEAPON or itemType == ARMOR) then
				MerchantBuyBackItemItemButton.text:SetText(itemlevel)
				MerchantBuyBackItemItemButton.text:SetTextColor(r, g, b)
			end
		end
	end
end

function M:MerchantFrame_UpdateBuybackInfo()
	local _, button, quality, itemlevel, itemType, r, g, b

	for i = 1, BUYBACK_ITEMS_PER_PAGE do
		button = _G["MerchantItem"..i.."ItemButton"]

		if not button.text then
			button.text = button:CreateFontString(nil, "OVERLAY")
			button.text:FontTemplate(E.LSM:Fetch("font", E.db.bags.itemLevelFont), E.db.bags.itemLevelFontSize, E.db.bags.itemLevelFontOutline)
			button.text:SetPoint("BOTTOMRIGHT", 0, 3)
		end

		if i <= GetNumBuybackItems() then
			if GetBuybackItemInfo(i) then
				_, _, quality, itemlevel, _, itemType = GetItemInfo(GetBuybackItemInfo(i))
				r, g, b = GetItemQualityColor(quality)

				button.text:SetText("")

				if (itemlevel and itemlevel > 1) and (quality and quality > 1) and (itemType == ENCHSLOT_WEAPON or itemType == ARMOR) then
					button.text:SetText(itemlevel)
					button.text:SetTextColor(r, g, b)
				end
			end
		end
	end
end

function M:MerchantItemLevel()
	if E.db.enhanced.general.merchantItemLevel then
		if not self:IsHooked("MerchantFrame_UpdateMerchantInfo") then
			self:SecureHook("MerchantFrame_UpdateMerchantInfo")
		end
		if not self:IsHooked("MerchantFrame_UpdateBuybackInfo") then
			self:SecureHook("MerchantFrame_UpdateBuybackInfo")
		end
	else
		if self:IsHooked("MerchantFrame_UpdateMerchantInfo") then
			self:Unhook("MerchantFrame_UpdateMerchantInfo")
		end
		if self:IsHooked("MerchantFrame_UpdateBuybackInfo") then
			self:Unhook("MerchantFrame_UpdateBuybackInfo")
		end

		for i = 1, BUYBACK_ITEMS_PER_PAGE do
			if _G["MerchantItem"..i.."ItemButton"].text then
				_G["MerchantItem"..i.."ItemButton"].text:SetText("")
			end
		end
		if MerchantBuyBackItemItemButton.text then
			MerchantBuyBackItemItemButton.text:SetText("")
		end
	end
end