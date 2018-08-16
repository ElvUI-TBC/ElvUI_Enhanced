local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")

local select, pairs = select, pairs
local format, join = string.format, string.join

local GetItemInfo = GetItemInfo
local GetItemCount = GetItemCount
local GetAuctionItemSubClasses = GetAuctionItemSubClasses
local GetInventoryItemLink = GetInventoryItemLink
local GetInventoryItemCount = GetInventoryItemCount
local GetInventorySlotInfo = GetInventorySlotInfo
local ContainerIDToInventoryID = ContainerIDToInventoryID
local GetContainerNumSlots = GetContainerNumSlots
local GetContainerNumFreeSlots = GetContainerNumFreeSlots
local GetItemQualityColor = GetItemQualityColor
local NUM_BAG_SLOTS = NUM_BAG_SLOTS
local NUM_BAG_FRAMES = NUM_BAG_FRAMES
local INVTYPE_AMMO = INVTYPE_AMMO

local quiver = select(1, GetAuctionItemSubClasses(7))
local pouch = select(2, GetAuctionItemSubClasses(7))
local soulBag = select(2, GetAuctionItemSubClasses(3))

local iconString = "|T%s:16:16:0:0:64:64:4:55:4:55|t"
local displayString = ""

local lastPanel

local function ColorizeSettingName(settingName)
	return format("|cffff8000%s|r", settingName)
end

local function OnEvent(self)
	local name, count, link
	if E.myclass == "WARLOCK" then
		name, link = GetItemInfo(6265)
		count = GetItemCount(6265)
		if link and (count > 0) then
			self.text:SetFormattedText(displayString, name, count)
		else
			self.text:SetFormattedText(displayString, name, 0)
		end
	else
		link = GetInventoryItemLink("player", GetInventorySlotInfo("AmmoSlot"))
		count = GetInventoryItemCount("player", GetInventorySlotInfo("AmmoSlot"))
		if link and (count > 0) then
			name = GetItemInfo(link)
			self.text:SetFormattedText(displayString, INVTYPE_AMMO, count)
		else
			self.text:SetFormattedText(displayString, INVTYPE_AMMO, 0)
		end
	end

	lastPanel = self
end

local function OnEnter(self)
	DT:SetupTooltip(self)

	local r, g, b
	local item, link, count
	local _, name, quality, subclass, equipLoc, texture
	local lineAdded, quiverLineAdded, pouchLineAdded, soulBagLineAdded
	local free, total, used
	local spacer = false

	--[[for bagID = 0, NUM_BAG_FRAMES do
		for slotID = 1, GetContainerNumSlots(bagID) do
			link = GetContainerItemLink(bagID, slotID)
			if link then
				name, _, quality, _, _, _, _, _, equipLoc, texture = GetItemInfo(link)

				if equipLoc == "INVTYPE_AMMO" then
					count = GetItemCount(link)
					r, g, b = GetItemQualityColor(quality)
					if not lineAdded then
						DT.tooltip:AddLine(INVTYPE_AMMO)
						lineAdded = true
						spacer = true
					end
					DT.tooltip:AddDoubleLine(join("", format(iconString, texture), " ", name), count, r, g, b)
				end
			end
		end
	end]]

	for i = 1, NUM_BAG_SLOTS do
		link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
		if link then
			name, _, quality, _, _, _, subclass, _, _, texture = GetItemInfo(link)

			if subclass == quiver or subclass == pouch or subclass == soulBag then
				r, g, b = GetItemQualityColor(quality)

				free, total, used = 0, 0, 0
				free, total = GetContainerNumFreeSlots(i), GetContainerNumSlots(i)
				used = total - free

				if not lineAdded and spacer == true then
					DT.tooltip:AddLine(" ")
					lineAdded = true
				end

				if subclass == quiver and not quiverLineAdded then
					DT.tooltip:AddLine(subclass)
					quiverLineAdded = true
				elseif subclass == pouch and not pouchLineAdded then
					DT.tooltip:AddLine(subclass)
					pouchLineAdded = true
				elseif subclass == soulBag and not soulBagLineAdded then
					DT.tooltip:AddLine(subclass)
					soulBagLineAdded = true
				end

				DT.tooltip:AddDoubleLine(join("", format(iconString, texture), "  ", name), format("%d / %d", used, total), r, g, b)
			end
		end
	end

	DT.tooltip:Show()
end

local function OnClick(_, btn)
	if btn == "LeftButton" then
		if not E.bags then
			for i = 1, NUM_BAG_SLOTS do
				local link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
				if link then
					local subclass = select(7, GetItemInfo(link))
					if subclass == quiver or subclass == pouch or subclass == soulBag then
						ToggleBag(i)
					end
				end
			end
		else
			OpenAllBags()
		end
	end
end

local function ValueColorUpdate(hex)
	displayString = join("", "%s: ", hex, "%d|r")

	if lastPanel ~= nil then
		OnEvent(lastPanel)
	end
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true

DT:RegisterDatatext(INVTYPE_AMMO, {"PLAYER_ENTERING_WORLD", "BAG_UPDATE", "UNIT_INVENTORY_CHANGED"}, OnEvent, nil, OnClick, OnEnter, nil, ColorizeSettingName(L["Ammo / Soul Shards"]))