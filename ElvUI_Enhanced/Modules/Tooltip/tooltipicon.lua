local E, L, V, P, G = unpack(ElvUI)
local TI = E:NewModule("Enhanced_TooltipIcon", "AceHook-3.0")

local _G = _G
local select = select
local find = string.find

local GetItemIcon = GetItemIcon
local GetSpellInfo = GetSpellInfo

local itemTooltips = {
	GameTooltip,
	ItemRefTooltip,
	ShoppingTooltip1,
	ShoppingTooltip2
}

local spellTooltips = {
	GameTooltip,
	ItemRefTooltip
}

local function AddIcon(self, icon)
	if not icon then return end

	local title = _G[self:GetName() .. "TextLeft1"]
	if title and not find(title:GetText(), "|T" .. icon) then
		title:SetFormattedText("|T%s:48:48:0:0:64:64:5:59:5:59|t %s", icon, title:GetText())
	end
end

local function ItemIcon(self)
	local link = self:GetItem()
	local icon = link and GetItemIcon(link)
	AddIcon(self, icon)
end

local function SpellIcon(self)
	local id = self:GetSpell()
	if id then
		AddIcon(self, select(3, GetSpellInfo(id)))
	end
end

function TI:ToggleItemsState()
	local state = E.db.enhanced.tooltip.tooltipIcon.tooltipIconItems and E.db.enhanced.tooltip.tooltipIcon.enable

	for _, tooltip in pairs(itemTooltips) do
		if state then
			if not self:IsHooked(tooltip, "OnTooltipSetItem", ItemIcon) then
				self:SecureHookScript(tooltip, "OnTooltipSetItem", ItemIcon)
			end
		else
			self:Unhook(tooltip, "OnTooltipSetItem")
		end
	end
end

function TI:ToggleSpellsState()
	local state = E.db.enhanced.tooltip.tooltipIcon.tooltipIconSpells and E.db.enhanced.tooltip.tooltipIcon.enable

	for _, tooltip in pairs(spellTooltips) do
		if state then
			if not self:IsHooked(tooltip, "OnTooltipSetSpell", SpellIcon) then
				self:SecureHookScript(tooltip, "OnTooltipSetSpell", SpellIcon)
			end
		else
			self:Unhook(tooltip, "OnTooltipSetSpell")
		end
	end
end

function TI:Initialize()
	if not E.db.enhanced.tooltip.tooltipIcon.enable then return end

	self:ToggleItemsState()
	self:ToggleSpellsState()
end

local function InitializeCallback()
	TI:Initialize()
end

E:RegisterModule(TI:GetName(), InitializeCallback)