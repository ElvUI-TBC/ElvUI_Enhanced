local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local select = select

local buttons = {
	"UI-Panel-MinimizeButton-Disabled",
	"UI-Panel-MinimizeButton-Up",
	"UI-Panel-SmallerButton-Up",
	"UI-Panel-BiggerButton-Up"
}

function S:HandleCloseButton(f, point, text)
	if E.db.enhanced.general.originalCloseButton then
		for i = 1, f:GetNumRegions() do
			local region = select(i, f:GetRegions())
			if region:GetObjectType() == "Texture" then
				region:SetDesaturated(1)
				for n = 1, #buttons do
					local texture = buttons[n]
					if region:GetTexture() == "Interface\\Buttons\\"..texture then
						f.noBackdrop = true
					end
				end
				if region:GetTexture() == "Interface\\DialogFrame\\UI-DialogBox-Corner" then
					region:Kill()
				end
			end
		end
	else
		f:StripTextures()

		if f:GetNormalTexture() then
			f:SetNormalTexture("")
			f.SetNormalTexture = E.noop
		end

		if f:GetPushedTexture() then
			f:SetPushedTexture("")
			f.SetPushedTexture = E.noop
		end

		if not text then
			text = "x"
		end
	end

	if not f.backdrop and not f.noBackdrop then
		f:CreateBackdrop("Default", true)
		f.backdrop:Point("TOPLEFT", 7, -8)
		f.backdrop:Point("BOTTOMRIGHT", -8, 8)
		f:HookScript2("OnEnter", S.SetModifiedBackdrop)
		f:HookScript2("OnLeave", S.SetOriginalBackdrop)
	end

	if not f.text then
		f.text = f:CreateFontString(nil, "OVERLAY")
		f.text:SetFont([[Interface\AddOns\ElvUI\media\fonts\PT_Sans_Narrow.ttf]], 16, "OUTLINE")
		f.text:SetText(text)
		f.text:SetJustifyH("CENTER")
		f.text:SetPoint("CENTER", f, "CENTER", -1, 1)
	end

	if f.text and f.noBackdrop then
		f.text:SetAlpha(0)
	end

	if point then
		f:Point("TOPRIGHT", point, "TOPRIGHT", 2, 2)
	end
end