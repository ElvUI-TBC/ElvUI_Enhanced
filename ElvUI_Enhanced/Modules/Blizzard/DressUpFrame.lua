local E, L, V, P, G = unpack(ElvUI)
local mod = E:GetModule("Enhanced_Blizzard")
local S = E:GetModule("Skins")

function mod:UpdateDressUpFrame()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.dressingroom ~= true then return end

	if E.db.enhanced.blizzard.dressUpFrame.enable then
		DressUpFrameResizeButton:Show()

		local mult = E.db.enhanced.blizzard.dressUpFrame.multiplier
		if ElvCharacterDB.Enhanced.ResizeDressUp then
			DressUpFrame:SetSize(384 * mult, 512 * mult)

			DressUpFrameResizeButton.text:SetText("-")
		else
			DressUpFrame:SetSize(384, 512)

			DressUpFrameResizeButton.text:SetText("+")
		end
	else
		DressUpFrame:SetSize(384, 512)

		DressUpFrameResizeButton:Hide()
	end

	local desaturate = E.db.enhanced.blizzard.dressUpFrame.desaturate and true or false
	local background = E.db.enhanced.blizzard.dressUpFrame.background and 1 or 0

	DressUpModel.backdrop:SetAlpha(background)
	DressUpFrame.ModelBackground:SetAlpha(background)
	DressUpFrame.ModelBackground:SetDesaturated(desaturate)

	UpdateUIPanelPositions(DressUpFrame)
end

function mod:DressUpFrame()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.dressingroom ~= true then return end

	if not ElvCharacterDB.Enhanced then
		ElvCharacterDB.Enhanced = {}
	end

	local resizeButton = CreateFrame("Button", "DressUpFrameResizeButton", DressUpFrame)
	resizeButton:SetSize(32, 32)
	resizeButton:SetPoint("RIGHT", DressUpFrameCloseButton, "LEFT", 10, 0)
	S:HandleCloseButton(resizeButton, nil, "+")
	resizeButton:SetScript("OnClick", function()
		if not ElvCharacterDB.Enhanced.ResizeDressUp then
			ElvCharacterDB.Enhanced.ResizeDressUp = true
		else
			ElvCharacterDB.Enhanced.ResizeDressUp = false
		end

		mod.UpdateDressUpFrame()
	end)

	DressUpModel:ClearAllPoints()
	DressUpModel:SetPoint("TOPLEFT", 22, -77)
	DressUpModel:SetPoint("BOTTOMRIGHT", -47, 106)
	DressUpModel.backdrop:SetOutside()

	DressUpBackgroundBotLeft:SetAlpha(0)
	DressUpBackgroundTopRight:SetAlpha(0)
	DressUpBackgroundTopLeft:SetAlpha(0)
	DressUpBackgroundBotRight:SetAlpha(0)

	DressUpFrame.ModelBackground = DressUpFrame:CreateTexture()
	DressUpFrame.ModelBackground:SetAllPoints(DressUpModel)
	DressUpFrame.ModelBackground:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\DressUpFrame\\DressingRoom"..E.myclass)
	DressUpFrame.ModelBackground:SetTexCoord(0.00195312, 0.935547, 0.00195312, 0.978516)

	DressUpFrameCancelButton:ClearAllPoints()
	DressUpFrameCancelButton:SetPoint("BOTTOMRIGHT", -39, 79)

	self:UpdateDressUpFrame()
end