local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins")

-- Dressing Room Undress Button
local DressUpFrameUndressButton = CreateFrame("Button", "DressUpFrameUndressButton", DressUpFrame, "UIPanelButtonTemplate");
DressUpFrameUndressButton:SetText(L["Undress"]);
DressUpFrameUndressButton:Size(80, 22);
DressUpFrameUndressButton:SetParent(DressUpFrame);
DressUpFrameUndressButton:HookScript("OnClick", function(self)
	self.model:Undress();
	PlaySound("gsTitleOptionOK");
end)
DressUpFrameUndressButton.model = DressUpModel;

-- Side Dressing Room Undress Button
local SideDressUpFrameUndressButton = CreateFrame("Button", "SideDressUpFrameUndressButton", SideDressUpFrame, "UIPanelButtonTemplate");
SideDressUpFrameUndressButton:SetText(L["Undress"]);
SideDressUpFrameUndressButton:Size(80, 22);
SideDressUpFrameUndressButton:SetParent(SideDressUpModel);

SideDressUpFrameUndressButton:HookScript("OnClick", function(self)
	self.model:Undress();
	PlaySound("gsTitleOptionOK");
end)
SideDressUpFrameUndressButton.model = SideDressUpModel;

if(E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.dressingroom ~= true) then
	DressUpFrameUndressButton:Point("RIGHT", DressUpFrameResetButton, "LEFT", 2, 0);
	SideDressUpFrameUndressButton:Point("BOTTOM", SideDressUpModelResetButton, "BOTTOM", 0, -25);
else
	S:HandleButton(DressUpFrameUndressButton);
	DressUpFrameUndressButton:Point("RIGHT", DressUpFrameResetButton, "LEFT", -3, 0);

	S:HandleButton(SideDressUpFrameUndressButton);
	SideDressUpFrameUndressButton:Point("RIGHT", SideDressUpModelResetButton, "LEFT", -3, 0);
end
