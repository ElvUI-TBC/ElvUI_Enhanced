local E, L, V, P, G = unpack(ElvUI)
local DTC = E:NewModule("DataTextColors", "AceEvent-3.0")
local DT = E:GetModule("DataTexts")

local RAID_CLASS_COLORS = RAID_CLASS_COLORS

function DTC:ColorFont()
	local customColor = E.db.enhanced.datatexts.datatextColor.custom
	local valueColor = E.db.general.valuecolor
	local classColor = E.myclass == "PRIEST" and E.PriestColors or (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[E.myclass] or RAID_CLASS_COLORS[E.myclass])

	for _, panel in pairs(DT.RegisteredPanels) do
		for i = 1, panel.numPoints do
			local pointIndex = DT.PointLocation[i]

			if E.db.enhanced.datatexts.datatextColor.enable then
				if E.db.enhanced.datatexts.datatextColor.color == "CLASS" then
					panel.dataPanels[pointIndex].text:SetTextColor(classColor.r, classColor.g, classColor.b)
				elseif E.db.enhanced.datatexts.datatextColor.color == "CUSTOM" then
					panel.dataPanels[pointIndex].text:SetTextColor(customColor.r, customColor.g, customColor.b)
				else
					panel.dataPanels[pointIndex].text:SetTextColor(valueColor.r, valueColor.g, valueColor.b)
				end
			else
				panel.dataPanels[pointIndex].text:SetTextColor(1, 1, 1)
			end
		end
	end
end

function DTC:PLAYER_ENTERING_WORLD(...)
	self:ColorFont()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

function DTC:Initialize()
	if not E.db.enhanced.datatexts.datatextColor.enable then return end

	self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

local function InitializeCallback()
	DTC:Initialize()
end

E:RegisterModule(DTC:GetName(), InitializeCallback)