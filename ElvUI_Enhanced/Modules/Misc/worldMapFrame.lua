local _G =_G
local select = select

local GetNumRaidMembers = GetNumRaidMembers
local GetPlayerMapPosition = GetPlayerMapPosition
local UnitClass = UnitClass
local UnitInParty = UnitInParty
local UnitIsUnit = UnitIsUnit
local MAX_PARTY_MEMBERS = MAX_PARTY_MEMBERS
local MAX_RAID_MEMBERS = MAX_RAID_MEMBERS

local BLIP_TEX_COORDS = {
	["WARRIOR"] = {0, 0.125, 0, 0.25},
	["PALADIN"] = {0.125, 0.25, 0, 0.25},
	["HUNTER"] = {0.25, 0.375, 0, 0.25},
	["ROGUE"] = {0.375, 0.5, 0, 0.25},
	["PRIEST"] = {0.5, 0.625, 0, 0.25},
	["SHAMAN"] = {0.75, 0.875, 0, 0.25},
	["MAGE"] = {0.875, 1, 0, 0.25},
	["WARLOCK"] = {0, 0.125, 0.25, 0.5},
	["DRUID"] = {0.25, 0.375, 0.25, 0.5}
}

local BLIP_RAID_Y_OFFSET = 0.5

for i = 1, MAX_PARTY_MEMBERS do
	_G["WorldMapParty"..i.."Icon"]:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PartyRaidBlips")
end

for i = 1, MAX_RAID_MEMBERS do
	_G["WorldMapRaid"..i.."Icon"]:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PartyRaidBlips")
end

WorldMapButton:HookScript("OnUpdate", function(self, elapsed)
	local unit, class, icon
	local playerCount, partyX, partyY

	if GetNumRaidMembers() > 0 then
		playerCount = 0

		for i = 1, MAX_RAID_MEMBERS do
			unit = "raid"..i
			partyX, partyY = GetPlayerMapPosition(unit)

			if (partyX ~= 0 and partyY ~= 0) or not UnitIsUnit(unit, "player") then
				icon = _G["WorldMapRaid"..(playerCount + 1).."Icon"]
				class = select(2, UnitClass(unit))

				if class then
					if UnitInParty(unit) then
						icon:SetTexCoord(BLIP_TEX_COORDS[class][1], BLIP_TEX_COORDS[class][2], BLIP_TEX_COORDS[class][3], BLIP_TEX_COORDS[class][4])
					else
						icon:SetTexCoord(BLIP_TEX_COORDS[class][1], BLIP_TEX_COORDS[class][2], BLIP_TEX_COORDS[class][3] + BLIP_RAID_Y_OFFSET, BLIP_TEX_COORDS[class][4] + BLIP_RAID_Y_OFFSET)
					end
				end
				playerCount = playerCount + 1
			end
		end
	else
		for i = 1, MAX_PARTY_MEMBERS do
			unit = "party"..i
			partyX, partyY = GetPlayerMapPosition(unit)

			if partyX ~= 0 and partyY ~= 0 then
				class = select(2, UnitClass(unit))
				icon = _G["WorldMapParty"..i.."Icon"]

				if class then
					icon:SetTexCoord(BLIP_TEX_COORDS[class][1], BLIP_TEX_COORDS[class][2], BLIP_TEX_COORDS[class][3], BLIP_TEX_COORDS[class][4])
				end
			end
		end
	end
end)