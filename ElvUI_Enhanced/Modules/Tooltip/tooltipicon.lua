local E, L, V, P, G = unpack(ElvUI);

local _G = _G
local select, type = select, type
local strmatch = string.match

local CreateFrame = CreateFrame
local GetItemIcon = GetItemIcon
local GetSpellInfo = GetSpellInfo

local function AddIcon(self, icon)
	if E.db.enhanced.tooltip.tooltipIcon.enable ~= true then return; end

	if icon then
		local title = _G[self:GetName() .. "TextLeft1"]
		if title and not title:GetText():find("|T" .. icon) then
			title:SetFormattedText("|T%s:48:48:0:0:64:64:5:59:5:59:%d|t %s", icon, 48, title:GetText())
		end
	end
end

local function hookItem(tip)
	tip:HookScript2("OnTooltipSetItem", function(self)
		if not E.db.enhanced.tooltip.tooltipIcon.tooltipIconItems then return end

		local link = self:GetItem()
		local icon = link and GetItemIcon(link)
		AddIcon(self, icon)
	end)
end
hookItem(GameTooltip)
hookItem(ItemRefTooltip)
hookItem(ShoppingTooltip1)
hookItem(ShoppingTooltip2)

local function hookSpell(tip)
	tip:HookScript2("OnTooltipSetSpell", function(self)
	if not  E.db.enhanced.tooltip.tooltipIcon.tooltipIconSpells then return end

		local id = self:GetSpell()
		if id then
			AddIcon(self, select(3, GetSpellInfo(id)))
		end
	end)
end
hookSpell(GameTooltip)
hookSpell(ItemRefTooltip)

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(_, event)
	if event == "PLAYER_ENTERING_WORLD" then
		AddIcon()
		f:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end)