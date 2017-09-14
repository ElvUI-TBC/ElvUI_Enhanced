local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

function M:CreateUndressButtons()
	self.dressUpButton = CreateFrame("Button", "DressUpFrame_UndressButton", DressUpFrame, "UIPanelButtonTemplate")
	self.dressUpButton:Size(80, 22)
	self.dressUpButton:SetText(L["Undress"])
	self.dressUpButton:SetScript("OnClick", function(self)
		self.model:Undress()
		PlaySound("gsTitleOptionOK")
	end)
	self.dressUpButton.model = DressUpModel

	self.sideDressUpButton = CreateFrame("Button", "SideDressUpFrame_UndressButton", SideDressUpFrame, "UIPanelButtonTemplate")
	self.sideDressUpButton:Size(80, 22)
	self.sideDressUpButton:SetText(L["Undress"])
	self.sideDressUpButton:SetScript("OnClick", function(self)
		self.model:Undress()
		PlaySound("gsTitleOptionOK")
	end)
	self.sideDressUpButton.model = SideDressUpModel

	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.dressingroom) then
		DressUpFrameUndressButton:Point("RIGHT", DressUpFrameResetButton, "LEFT", 2, 0)
		SideDressUpFrameUndressButton:Point("BOTTOM", SideDressUpModelResetButton, "BOTTOM", 0, -25)
	else
		local S = E:GetModule("Skins")

		S:HandleButton(DressUpFrameUndressButton)
		DressUpFrameUndressButton:Point("RIGHT", DressUpFrameResetButton, "LEFT", -3, 0)

		S:HandleButton(SideDressUpFrameUndressButton)
		SideDressUpFrameUndressButton:Point("RIGHT", SideDressUpModelResetButton, "LEFT", -3, 0)
	end
end

function M:UndressButtonToggle()
	if E.db.enhanced.general.undressButton then
		if not (self.dressUpButton and self.dressUpButton) then
			self:CreateUndressButtons()
		end

		self.dressUpButton:Show()
		self.sideDressUpButton:Show()
	else
		if self.dressUpButton and self.dressUpButton then
			self.dressUpButton:Hide()
			self.sideDressUpButton:Hide()
		end
	end
end