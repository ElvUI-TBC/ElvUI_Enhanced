local E, L, V, P, G = unpack(ElvUI)
local RM = E:NewModule("RaidMarkerBar", "AceEvent-3.0")
local S = E:GetModule("Skins")

local format = string.format

local GameTooltip = GameTooltip
local UnregisterStateDriver = UnregisterStateDriver
local RegisterStateDriver = RegisterStateDriver

RM.VisibilityStates = {
	["DEFAULT"] = "[noexists, nogroup] hide;show",
	["INPARTY"] = "[group] show;hide",
	["ALWAYS"] = "[noexists, nogroup] show;show"
}

function RM:CreateButtons()
	for i = 1, 9 do
		local button = CreateFrame("Button", format("RaidMarkerBarButton%d", i), self.frame, "SecureActionButtonTemplate")
		button:SetHeight(self.db.buttonSize)
		button:SetWidth(self.db.buttonSize)
		button:SetTemplate("Default", true)

		local image = button:CreateTexture(nil, "ARTWORK")
		image:SetInside()
		image:SetTexture(i == 9 and "Interface\\BUTTONS\\UI-GroupLoot-Pass-Up" or format("Interface\\TargetingFrame\\UI-RaidTargetingIcon_%d", i))

		button:SetAttribute("type1", "macro")
		button:SetAttribute("macrotext1", ("/run SetRaidTargetIcon(\"target\", %d)"):format(i < 9 and i or 0))

		button:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
			GameTooltip:AddLine(i == 9 and L["Click to clear the mark."] or L["Click to mark the target."], 1, 1, 1)
			GameTooltip:Show()
		end)
		button:SetScript("OnLeave", function() GameTooltip:Hide() end)
		button:RegisterForClicks("AnyDown")

		button:HookScript("OnEnter", S.SetModifiedBackdrop)
		button:HookScript("OnLeave", S.SetOriginalBackdrop)

		self.frame.buttons[i] = button
	end
end

function RM:UpdateBar(update)
	if self.db.orientation == "VERTICAL" then
		self.frame:SetWidth(self.db.buttonSize + 4)
		self.frame:SetHeight(((self.db.buttonSize * 9) + (self.db.spacing * 8)) + 4)
	else
		self.frame:SetWidth(((self.db.buttonSize * 9) + (self.db.spacing * 8)) + 4)
		self.frame:SetHeight(self.db.buttonSize + 4)
	end

	local head, tail
	for i = 9, 1, -1 do
		local button = self.frame.buttons[i]
		local prev = self.frame.buttons[i + 1]
		button:ClearAllPoints()

		button:SetWidth(self.db.buttonSize)
		button:SetHeight(self.db.buttonSize)

		if self.db.orientation == "VERTICAL" then
			head = self.db.reverse and "BOTTOM" or "TOP"
			tail = self.db.reverse and "TOP" or "BOTTOM"
			if i == 9 then
				button:SetPoint(head, 0, (self.db.reverse and 2 or -2))
			else
				button:SetPoint(head, prev, tail, 0, self.db.spacing*(self.db.reverse and 1 or -1))
			end
		else
			head = self.db.reverse and "RIGHT" or "LEFT"
			tail = self.db.reverse and "LEFT" or "RIGHT"
			if i == 9 then
				button:SetPoint(head, (self.db.reverse and -2 or 2), 0)
			else
				button:SetPoint(head, prev, tail, self.db.spacing*(self.db.reverse and -1 or 1), 0)
			end
		end
	end

	if self.db.enable then self.frame:Show() else self.frame:Hide() end
end

function RM:Visibility()
	if self.db.enable then
		RegisterStateDriver(self.frame, "visibility", self.db.visibility == "CUSTOM" and self.db.customVisibility or RM.VisibilityStates[self.db.visibility])
		E:EnableMover(self.frame.mover:GetName())
	else
		UnregisterStateDriver(self.frame, "visibility")
		self.frame:Hide()
		E:DisableMover(self.frame.mover:GetName())
	end
end

function RM:Backdrop()
	if self.db.backdrop then
		self.frame.backdrop:Show()
	else
		self.frame.backdrop:Hide()
	end

	if self.db.transparentBackdrop then
		self.frame.backdrop:SetTemplate("Transparent")
	else
		self.frame.backdrop:SetTemplate("Default")
	end
end

function RM:ButtonBackdrop()
	for i = 1, 9 do
		local button = self.frame.buttons[i]
		if self.db.transparentButtons then
			button:SetTemplate("Transparent")
		else
			button:SetTemplate("Default", true)
		end
	end
end

function RM:Initialize()
	self.db = E.db.enhanced.raidmarkerbar

	self.frame = CreateFrame("Frame", "RaidMarkerBar", E.UIParent, "SecureStateHeaderTemplate")
	self.frame:SetResizable(false)
	self.frame:SetClampedToScreen(true)
	self.frame:SetFrameStrata("LOW")
	self.frame:CreateBackdrop()
	self.frame:ClearAllPoints()
	self.frame:Point("BOTTOMRIGHT", E.UIParent, "BOTTOMRIGHT", -1, 200)
	self.frame.buttons = {}

	self.frame.backdrop:SetAllPoints()

	E:CreateMover(self.frame, "RaidMarkerBarAnchor", L["Raid Marker Bar"])

	self:CreateButtons()

	function RM:ForUpdateAll()
		self:Visibility()
		self:Backdrop()
		self:ButtonBackdrop()
		self:UpdateBar()
	end

	self:ForUpdateAll()
end

local function InitializeCallback()
	RM:Initialize()
end

E:RegisterModule(RM:GetName(), InitializeCallback)