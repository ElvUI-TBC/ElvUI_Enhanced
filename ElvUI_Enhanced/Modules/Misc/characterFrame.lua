local E, L, V, P, G = unpack(ElvUI)
local module = E:NewModule("Enhanced_CharacterFrame", "AceHook-3.0", "AceEvent-3.0")
local S = E:GetModule("Skins")

local _G = _G
local next, pairs, tonumber, assert, getmetatable = next, pairs, tonumber, assert, getmetatable

local lower = string.lower
local find, format, sub, gsub, gmatch, trim = string.find, string.format, string.sub, string.gsub, string.gmatch, string.trim
local abs, floor, max, min = math.abs, math.floor, math.max, math.min
local wipe, sort, tinsert, tremove = table.wipe, table.sort, table.insert, table.remove

local CharacterRangedDamageFrame_OnEnter = CharacterRangedDamageFrame_OnEnter
local CharacterSpellCritChance_OnEnter = CharacterSpellCritChance_OnEnter
local CreateFrame = CreateFrame
local GetAttackPowerForStat = GetAttackPowerForStat
local GetBlockChance = GetBlockChance
local GetCombatRating = GetCombatRating
local GetCombatRatingBonus = GetCombatRatingBonus
local GetContainerItemLink = GetContainerItemLink
local GetContainerNumSlots = GetContainerNumSlots
local GetCritChance = GetCritChance
local GetCritChanceFromAgility = GetCritChanceFromAgility
local GetCurrentTitle = GetCurrentTitle
local GetCursorPosition = GetCursorPosition
local GetDodgeChance = GetDodgeChance
local GetInventoryItemLink = GetInventoryItemLink
local GetInventoryItemTexture = GetInventoryItemTexture
local GetInventorySlotInfo = GetInventorySlotInfo
local GetItemInfo = GetItemInfo
local GetNumTitles = GetNumTitles
local GetParryChance = GetParryChance
local GetShieldBlock = GetShieldBlock
local GetSpellCritChanceFromIntellect = GetSpellCritChanceFromIntellect
local GetTitleName = GetTitleName
local GetUnitHealthModifier = GetUnitHealthModifier
local GetUnitHealthRegenRateFromSpirit = GetUnitHealthRegenRateFromSpirit
local GetUnitManaRegenRateFromSpirit = GetUnitManaRegenRateFromSpirit
local GetUnitMaxHealthModifier = GetUnitMaxHealthModifier
local GetUnitPowerModifier = GetUnitPowerModifier
local IsTitleKnown = IsTitleKnown
local PaperDollFrame_SetDefense = PaperDollFrame_SetDefense
local PaperDollFrame_SetExpertise = PaperDollFrame_SetExpertise
local PaperDollFrame_SetRangedAttackPower = PaperDollFrame_SetRangedAttackPower
local PaperDollFrame_SetRangedAttackSpeed = PaperDollFrame_SetRangedAttackSpeed
local PaperDollFrame_SetRangedCritChance = PaperDollFrame_SetRangedCritChance
local PaperDollFrame_SetRangedDamage = PaperDollFrame_SetRangedDamage
local PaperDollFrame_SetRating = PaperDollFrame_SetRating
local PaperDollFrame_SetSpellBonusDamage = PaperDollFrame_SetSpellBonusDamage
local PaperDollFrame_SetSpellBonusHealing = PaperDollFrame_SetSpellBonusHealing
local PaperDollFrame_SetSpellCritChance = PaperDollFrame_SetSpellCritChance
local PaperDollFrame_SetSpellHaste = PaperDollFrame_SetSpellHaste
local PlaySound = PlaySound
local SetPortraitTexture = SetPortraitTexture
local UnitAttackSpeed = UnitAttackSpeed
local UnitClass = UnitClass
local UnitDamage = UnitDamage
local UnitLevel = UnitLevel
local UnitRace = UnitRace
local UnitResistance = UnitResistance
local UnitStat = UnitStat

local ARMOR_PER_AGILITY = ARMOR_PER_AGILITY
local CR_CRIT_TAKEN_MELEE = CR_CRIT_TAKEN_MELEE
local CR_CRIT_TAKEN_RANGED = CR_CRIT_TAKEN_RANGED
local CR_CRIT_TAKEN_SPELL = CR_CRIT_TAKEN_SPELL
local HEALTH_PER_STAMINA = HEALTH_PER_STAMINA

local slotName = {
	"Head","Neck","Shoulder","Back","Chest",
	"Shirt","Tabard","Wrist","Waist","Legs","Feet",
	"Finger0","Finger1","Trinket0","Trinket1",
	"MainHand", "SecondaryHand", "Ranged", "Ammo"
}

local CHARACTERFRAME_COLLAPSED_WIDTH = 348 + 37
local CHARACTERFRAME_EXPANDED_WIDTH = 540 + 42
local STATCATEGORY_MOVING_INDENT = 4

MOVING_STAT_CATEGORY = nil

PAPERDOLL_SIDEBARS = {
	{
		name = L["Character Stats"];
		frame = "CharacterStatsPane";
		icon = nil;
		texCoords = {0.109375, 0.890625, 0.09375, 0.90625};
	},
	{
		name = L["Titles"];
		frame = "PaperDollTitlesPane";
		icon = "Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PaperDollSidebarTabs";
		texCoords = {0.01562500, 0.53125000, 0.32421875, 0.46093750};
	}
}

PAPERDOLL_STATINFO = {
	["ITEM_LEVEL"] = {
		updateFunc = function(statFrame, unit) module:ItemLevel(statFrame, unit) end
	},
	["STRENGTH"] = {
		updateFunc = function(statFrame, unit) module:SetStat(statFrame, unit, 1) end
	},
	["AGILITY"] = {
		updateFunc = function(statFrame, unit) module:SetStat(statFrame, unit, 2) end
	},
	["STAMINA"] = {
		updateFunc = function(statFrame, unit) module:SetStat(statFrame, unit, 3) end
	},
	["INTELLECT"] = {
		updateFunc = function(statFrame, unit) module:SetStat(statFrame, unit, 4) end
	},
	["SPIRIT"] = {
		updateFunc = function(statFrame, unit) module:SetStat(statFrame, unit, 5) end
	},

	["MELEE_DAMAGE"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetDamage(statFrame, unit) end,
		updateFunc2 = function(statFrame) CharacterDamageFrame_OnEnter(statFrame) end
	},
	["MELEE_DPS"] = {
		updateFunc = function(statFrame, unit) module:SetMeleeDPS(statFrame, unit) end
	},
	["MELEE_AP"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetAttackPower(statFrame, unit) end
	},
	["MELEE_ATTACKSPEED"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetAttackSpeed(statFrame, unit) end
	},
	["HITCHANCE"] = {
		updateFunc = function(statFrame) PaperDollFrame_SetRating(statFrame, CR_HIT_MELEE) end
	},
	["CRITCHANCE"] = {
		updateFunc = function(statFrame, unit) module:SetMeleeCritChance(statFrame, unit) end
	},
	["EXPERTISE"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetExpertise(statFrame, unit) end
	},

	["RANGED_COMBAT1"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetRangedDamage(statFrame, unit) end,
		updateFunc2 = function(statFrame) CharacterRangedDamageFrame_OnEnter(statFrame) end
	},
	["RANGED_COMBAT2"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetRangedAttackSpeed(statFrame, unit) end
	},
	["RANGED_COMBAT3"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetRangedAttackPower(statFrame, unit) end
	},
	["RANGED_COMBAT4"] = {
		updateFunc = function(statFrame) PaperDollFrame_SetRating(statFrame, CR_HIT_RANGED) end
	},
	["RANGED_COMBAT5"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetRangedCritChance(statFrame, unit) end
	},

	["SPELL_COMBAT1"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetSpellBonusDamage(statFrame, unit) end,
		updateFunc2 = function(statFrame) CharacterSpellBonusDamage_OnEnter(statFrame) end
	},
	["SPELL_COMBAT2"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetSpellBonusHealing(statFrame, unit) end
	},
	["SPELL_COMBAT3"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetRating(statFrame, CR_HIT_SPELL) end
	},
	["SPELL_COMBAT4"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetSpellCritChance(statFrame, unit) end,
		updateFunc2 = function(statFrame) CharacterSpellCritChance_OnEnter(statFrame) end
	},
	["SPELL_COMBAT5"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetSpellHaste(statFrame, unit) end
	},
	["SPELL_COMBAT6"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetManaRegen(statFrame, unit) end
	},

	["DEFENSES1"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetArmor(statFrame, unit) end
	},
	["DEFENSES2"] = {
		updateFunc = function(statFrame, unit) PaperDollFrame_SetDefense(statFrame, unit) end
	},
	["DEFENSES3"] = {
		updateFunc = function(statFrame, unit) module:SetDodge(statFrame, unit) end
	},
	["DEFENSES4"] = {
		updateFunc = function(statFrame, unit) module:SetParry(statFrame, unit) end
	},
	["DEFENSES5"] = {
		updateFunc = function(statFrame, unit) module:SetBlock(statFrame, unit) end
	},
	["DEFENSES6"] = {
		updateFunc = function(statFrame, unit) module:SetResilience(statFrame, unit) end
	},

	["ARCANE"] = {
		updateFunc = function(statFrame, unit) module:SetResistance(statFrame, unit, 6) end
	},
	["FIRE"] = {
		updateFunc = function(statFrame, unit) module:SetResistance(statFrame, unit, 2) end
	},
	["FROST"] = {
		updateFunc = function(statFrame, unit) module:SetResistance(statFrame, unit, 4) end
	},
	["NATURE"] = {
		updateFunc = function(statFrame, unit) module:SetResistance(statFrame, unit, 3) end
	},
	["SHADOW"] = {
		updateFunc = function(statFrame, unit) module:SetResistance(statFrame, unit, 5) end
	},
}

PAPERDOLL_STATCATEGORIES = {
	["ITEM_LEVEL"] = {
		id = 1,
		stats = {
			"ITEM_LEVEL"
		}
	},
	["BASE_STATS"] = {
		id = 2,
		stats = {
			"STRENGTH",
			"AGILITY",
			"STAMINA",
			"INTELLECT",
			"SPIRIT"
		}
	},
	["MELEE_COMBAT"] = {
		id = 3,
		stats = {
			"MELEE_DAMAGE",
			"MELEE_DPS",
			"MELEE_AP",
			"MELEE_ATTACKSPEED",
			"HITCHANCE",
			"CRITCHANCE",
			"EXPERTISE",
		}
	},
	["RANGED_COMBAT"] = {
		id = 4,
		stats = {
			"RANGED_COMBAT1",
			"RANGED_COMBAT2",
			"RANGED_COMBAT3",
			"RANGED_COMBAT4",
			"RANGED_COMBAT5",
		}
	},
	["SPELL_COMBAT"] = {
		id = 5,
		stats = {
			"SPELL_COMBAT1",
			"SPELL_COMBAT2",
			"SPELL_COMBAT3",
			"SPELL_COMBAT4",
			"SPELL_COMBAT5",
			"SPELL_COMBAT6"
		}
	},
	["DEFENSES"] = {
		id = 6,
		stats = {
			"DEFENSES1",
			"DEFENSES2",
			"DEFENSES3",
			"DEFENSES4",
			"DEFENSES5",
			"DEFENSES6",
		}
	},
	["RESISTANCE"] = {
		id = 7,
		stats = {
			"ARCANE",
			"FIRE",
			"FROST",
			"NATURE",
			"SHADOW",
		}
	},
}

PAPERDOLL_STATCATEGORY_DEFAULTORDER = {
	"ITEM_LEVEL",
	"BASE_STATS",
	"MELEE_COMBAT",
	"RANGED_COMBAT",
	"SPELL_COMBAT",
	"DEFENSES",
	"RESISTANCE",
}

PETPAPERDOLL_STATCATEGORY_DEFAULTORDER = {
	"BASE_STATS",
	"MELEE_COMBAT",
	"RANGED_COMBAT",
	"SPELL_COMBAT",
	"DEFENSES",
	"RESISTANCE",
}

local locale = GetLocale()
local classTextFormat =
locale == "deDE" and "Stufe %s %s%s %s" or
locale == "ruRU" and "%2$s%4$s (%3$s)|r %1$s-го уровня" or
locale == "frFR" and "%2$s%4$s %3$s|r de niveau %1$s" or
locale == "koKR" and "%s 레벨 %s%s %s|r" or
locale == "zhCN" and "等级%s %s%s %s|r" or
locale == "zhTW" and "等級%s%s%s%s|r" or
locale == "esES" and "%2$s%4$s %3$s|r de nivel %1$s" or
locale == "ptBR" and "%2$s%4$s (%3$s)|r Nível %1$s" or
"Level %s %s%s %s|r"

function module:PaperDollFrame_SetLevel()
	local talentTree = E:GetTalentSpecInfo()
	local classColor = RAID_CLASS_COLORS[E.myclass]
	local classColorString = format("|cFF%02x%02x%02x", classColor.r*255, classColor.g*255, classColor.b*255)
	local specName

	if talentTree then
		specName = GetTalentTabInfo(talentTree)
	end

	if specName and specName ~= "" then
		CharacterLevelText:SetFormattedText(classTextFormat, UnitLevel("player"), classColorString, specName, E.myLocalizedClass)
	else
		CharacterLevelText:SetFormattedText(PLAYER_LEVEL, UnitLevel("player"), classColorString, E.myLocalizedClass)
	end

	if CharacterLevelText:GetWidth() > 210 then
		if PaperDollSidebarTab1:IsVisible() then
			CharacterLevelText:SetPoint("TOP", CharacterNameText, "BOTTOM", -10, -6)
		else
			CharacterLevelText:SetPoint("TOP", CharacterNameText, "BOTTOM", 10, -6)
		end
	else
		CharacterLevelText:SetPoint("TOP", CharacterNameText, "BOTTOM", 0, -6)
	end
end

function module:PaperDollSidebarTab(button)
	button:SetSize(33, 35)
	button:SetTemplate("Default")

	button.Icon = button:CreateTexture(nil, "ARTWORK")
	button.Icon:SetInside()
	button.Icon:SetTexture(PAPERDOLL_SIDEBARS[button:GetID()].icon)
	local tcoords = PAPERDOLL_SIDEBARS[button:GetID()].texCoords
	button.Icon:SetTexCoord(tcoords[1], tcoords[2], tcoords[3], tcoords[4])

	button.Hider = button:CreateTexture(nil, "OVERLAY")
	button.Hider:SetTexture(0, 0, 0, 0.8)
	button.Hider:SetInside()

	button.Highlight = button:CreateTexture(nil, "HIGHLIGHT")
	button.Highlight:SetTexture(1, 1, 1, 0.3)
	button.Highlight:SetInside()

	button:SetScript("OnClick", function(self)
		module:PaperDollFrame_SetSidebar(self:GetID())
		PlaySound("igMainMenuOption")
	end)

	button:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(PAPERDOLL_SIDEBARS[self:GetID()].name, 1, 1, 1)
	end)

	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
end

function module:CharacterFrame_Collapse()
	CharacterFrame:Width(CHARACTERFRAME_COLLAPSED_WIDTH)
	CharacterFrame.Expanded = false

	S:SquareButton_SetIcon(CharacterFrameExpandButton, "RIGHT")
	for i = 1, #PAPERDOLL_SIDEBARS do
		_G[PAPERDOLL_SIDEBARS[i].frame]:Hide()
	end
	PaperDollSidebarTabs:Hide()

	if not InCombatLockdown() then
		CharacterFrame:SetAttribute("UIPanelLayout-width", E:Scale(CHARACTERFRAME_COLLAPSED_WIDTH))
		UpdateUIPanelPositions(CharacterFrame)
	end
end

function module:CharacterFrame_Expand()
	CharacterFrame:Width(CHARACTERFRAME_EXPANDED_WIDTH)
	CharacterFrame.Expanded = true

	S:SquareButton_SetIcon(CharacterFrameExpandButton, "LEFT")
	if PaperDollFrame:IsShown() and PaperDollFrame.currentSideBar then
		CharacterStatsPane:Hide()
		PaperDollFrame.currentSideBar:Show()
	else
		CharacterStatsPane:Show()
	end
	self:PaperDollFrame_UpdateSidebarTabs()
	PaperDollSidebarTabs:Show()

	if not InCombatLockdown() then
		CharacterFrame:SetAttribute("UIPanelLayout-width", E:Scale(CHARACTERFRAME_EXPANDED_WIDTH))
		UpdateUIPanelPositions(CharacterFrame)
	end
end

local StatCategoryFrames = {}

function module:ItemLevel(statFrame, unit)
	local label = _G[statFrame:GetName().."Label"]
	if PersonalGearScore then
		local myGearScore = GearScore_GetScore(UnitName("player"), "player")
		label:SetText(myGearScore)
		local r, b, g = GearScore_GetQuality(myGearScore)
		label:SetTextColor(r, g, b)
	else
		local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel()
		if avgItemLevelEquipped == avgItemLevel then
			label:SetText(format("%.2f", avgItemLevelEquipped))
		else
			label:SetText(format("%.2f / %.2f", avgItemLevelEquipped, avgItemLevel))
		end
		label:SetTextColor(GetItemLevelColor())
	end
end

function module:SetStat(statFrame, unit, statIndex)
	local label = _G[statFrame:GetName().."Label"]
	local text = _G[statFrame:GetName().."StatText"]
	local stat, effectiveStat, posBuff, negBuff = UnitStat(unit, statIndex)
	local statName = _G["SPELL_STAT"..statIndex.."_NAME"]
	label:SetText(format("%s:", statName))

	local tooltipText = HIGHLIGHT_FONT_COLOR_CODE..format("%s", statName).." "
	if (posBuff == 0) and (negBuff == 0) then
		text:SetText(effectiveStat)
		statFrame.tooltip = tooltipText..effectiveStat..FONT_COLOR_CODE_CLOSE
	else
		tooltipText = tooltipText..effectiveStat
		if posBuff > 0 or negBuff < 0 then
			tooltipText = tooltipText.." ("..(stat - posBuff - negBuff)..FONT_COLOR_CODE_CLOSE
		end
		if posBuff > 0 then
			tooltipText = tooltipText..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE
		end
		if negBuff < 0 then
			tooltipText = tooltipText..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE
		end
		if posBuff > 0 or negBuff < 0 then
			tooltipText = tooltipText..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE
		end
		statFrame.tooltip = tooltipText

		if negBuff < 0 then
			text:SetText(RED_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE)
		else
			text:SetText(GREEN_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE)
		end
	end
	statFrame.tooltip2 = _G["DEFAULT_STAT"..statIndex.."_TOOLTIP"]

	if unit == "player" then
		if statIndex == 1 then
			local attackPower = GetAttackPowerForStat(statIndex,effectiveStat)
			statFrame.tooltip2 = format(statFrame.tooltip2, attackPower)
			if E.myclass == "WARRIOR" or E.myclass == "SHAMAN" or E.myclass == "PALADIN" then
				statFrame.tooltip2 = statFrame.tooltip2.."\n"..format(STAT_BLOCK_TOOLTIP, max(0, effectiveStat * BLOCK_PER_STRENGTH - 10))
			end
		elseif statIndex == 3 then
			local baseStam = min(20, effectiveStat)
			local moreStam = effectiveStat - baseStam
			statFrame.tooltip2 = format(statFrame.tooltip2, (baseStam + (moreStam * HEALTH_PER_STAMINA)) * GetUnitMaxHealthModifier("player"))
			local petStam = ComputePetBonus("PET_BONUS_STAM", effectiveStat )
			if petStam > 0 then
				statFrame.tooltip2 = statFrame.tooltip2.."\n"..format(PET_BONUS_TOOLTIP_STAMINA,petStam)
			end
		elseif statIndex == 2 then
			local attackPower = GetAttackPowerForStat(statIndex,effectiveStat)
			if attackPower > 0 then
				statFrame.tooltip2 = format(STAT_ATTACK_POWER, attackPower)..format(statFrame.tooltip2, GetCritChanceFromAgility("player"), effectiveStat * ARMOR_PER_AGILITY)
			else
				statFrame.tooltip2 = format(statFrame.tooltip2, GetCritChanceFromAgility("player"), effectiveStat * ARMOR_PER_AGILITY)
			end
		elseif statIndex == 4 then
			local baseInt = min(20, effectiveStat)
			local moreInt = effectiveStat - baseInt
			if UnitHasMana("player") then
				statFrame.tooltip2 = format(statFrame.tooltip2, baseInt + moreInt * MANA_PER_INTELLECT, GetSpellCritChanceFromIntellect("player"))
			else
				statFrame.tooltip2 = nil
			end
			local petInt = ComputePetBonus("PET_BONUS_INT", effectiveStat)
			if petInt > 0 then
				if not statFrame.tooltip2 then
					statFrame.tooltip2 = ""
				end
				statFrame.tooltip2 = statFrame.tooltip2.."\n"..format(PET_BONUS_TOOLTIP_INTELLECT, petInt)
			end
		elseif statIndex == 5 then
			statFrame.tooltip2 = format(statFrame.tooltip2, GetUnitHealthRegenRateFromSpirit("player"))
			if UnitHasMana("player") then
				local regen = GetUnitManaRegenRateFromSpirit("player")
				regen = floor(regen * 5.0)
				statFrame.tooltip2 = statFrame.tooltip2.."\n"..format(MANA_REGEN_FROM_SPIRIT, regen)
			end
		end
	elseif unit == "pet" then
		if statIndex == 1 then
			local attackPower = effectiveStat - 20
			statFrame.tooltip2 = format(statFrame.tooltip2, attackPower)
		elseif statIndex == 3 then
			local expectedHealthGain = (((stat - posBuff - negBuff) - 20) * 10 + 20) * GetUnitHealthModifier("pet")
			local realHealthGain = ((effectiveStat - 20) * 10 + 20) * GetUnitHealthModifier("pet")
			local healthGain = (realHealthGain - expectedHealthGain) * GetUnitMaxHealthModifier("pet")
			statFrame.tooltip2 = format(statFrame.tooltip2, healthGain)
		elseif statIndex == 2 then
			local newLineIndex = find(statFrame.tooltip2, "|n") + 1
			statFrame.tooltip2 = sub(statFrame.tooltip2, 1, newLineIndex)
			statFrame.tooltip2 = format(statFrame.tooltip2, GetCritChanceFromAgility("pet"))
		elseif statIndex == 4 then
			if UnitHasMana("pet") then
				local manaGain = ((effectiveStat-20) * 15 + 20) * GetUnitPowerModifier("pet")
				statFrame.tooltip2 = format(statFrame.tooltip2, manaGain, GetSpellCritChanceFromIntellect("pet"))
			else
				local newLineIndex = find(statFrame.tooltip2, "|n") + 2
				statFrame.tooltip2 = sub(statFrame.tooltip2, newLineIndex)
				statFrame.tooltip2 = format(statFrame.tooltip2, GetSpellCritChanceFromIntellect("pet"))
			end
		elseif statIndex == 5 then
			statFrame.tooltip2 = format(statFrame.tooltip2, GetUnitHealthRegenRateFromSpirit("pet"))
			if UnitHasMana("pet") then
				statFrame.tooltip2 = statFrame.tooltip2.."\n"..format(MANA_REGEN_FROM_SPIRIT, GetUnitManaRegenRateFromSpirit("pet"))
			end
		end
	end
	statFrame:Show()
end

function module:SetResistance(statFrame, unit, resistanceIndex)
	local base, resistance, positive, negative = UnitResistance(unit, resistanceIndex)
	local petBonus = ComputePetBonus("PET_BONUS_RES", resistance)
	local resistanceNameShort = _G["SPELL_SCHOOL"..resistanceIndex.."_CAP"]
	local resistanceName = _G["RESISTANCE"..resistanceIndex.."_NAME"]
	local resistanceIconCode = "|TInterface\\PaperDollInfoFrame\\SpellSchoolIcon"..(resistanceIndex + 1)..":18:18:0:0|t"
	_G[statFrame:GetName().."Label"]:SetText(resistanceIconCode.." "..format("%s:", resistanceNameShort))
	local text = _G[statFrame:GetName().."StatText"]
	PaperDollFormatStat(resistanceName, base, positive, negative, statFrame, text)
	statFrame.tooltip = resistanceIconCode.." "..HIGHLIGHT_FONT_COLOR_CODE..format("%s", resistanceName).." "..resistance..FONT_COLOR_CODE_CLOSE

	if positive ~= 0 or negative ~= 0 then
		statFrame.tooltip = statFrame.tooltip.." ( "..HIGHLIGHT_FONT_COLOR_CODE..base
		if positive > 0 then
			statFrame.tooltip = statFrame.tooltip..GREEN_FONT_COLOR_CODE.." +"..positive
		end
		if negative < 0 then
			statFrame.tooltip = statFrame.tooltip.." "..RED_FONT_COLOR_CODE..negative
		end
		statFrame.tooltip = statFrame.tooltip..FONT_COLOR_CODE_CLOSE.." )"
	end

	local resistanceLevel
	local unitLevel = UnitLevel(unit)
	unitLevel = max(unitLevel, 20)
	local magicResistanceNumber = resistance / unitLevel
	if magicResistanceNumber > 5 then
		resistanceLevel = RESISTANCE_EXCELLENT
	elseif magicResistanceNumber > 3.75 then
		resistanceLevel = RESISTANCE_VERYGOOD
	elseif magicResistanceNumber > 2.5 then
		resistanceLevel = RESISTANCE_GOOD
	elseif magicResistanceNumber > 1.25 then
		resistanceLevel = RESISTANCE_FAIR
	elseif magicResistanceNumber > 0 then
		resistanceLevel = RESISTANCE_POOR
	else
		resistanceLevel = RESISTANCE_NONE
	end
	statFrame.tooltip2 = format(RESISTANCE_TOOLTIP_SUBTEXT, _G["RESISTANCE_TYPE"..resistanceIndex], unitLevel, resistanceLevel)

	if petBonus > 0 then
		statFrame.tooltip2 = statFrame.tooltip2.."\n"..format(PET_BONUS_TOOLTIP_RESISTANCE, petBonus)
	end
end

function module:SetDodge(statFrame, unit)
	if unit ~= "player" then statFrame:Hide() return end

	local chance = GetDodgeChance()
	PaperDollFrame_SetLabelAndText(statFrame, STAT_DODGE, chance, 1)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format("%s", DODGE_CHANCE).." "..format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = format(CR_DODGE_TOOLTIP, GetCombatRating(CR_DODGE), GetCombatRatingBonus(CR_DODGE))
	statFrame:Show()
end

function module:SetBlock(statFrame, unit)
	if unit ~= "player" then statFrame:Hide() return end

	local chance = GetBlockChance()
	PaperDollFrame_SetLabelAndText(statFrame, STAT_BLOCK, chance, 1)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format("%s", BLOCK_CHANCE).." "..format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = format(CR_BLOCK_TOOLTIP, GetCombatRating(CR_BLOCK), GetCombatRatingBonus(CR_BLOCK), GetShieldBlock())
	statFrame:Show()
end

function module:SetParry(statFrame, unit)
	if unit ~= "player" then statFrame:Hide() return end

	local chance = GetParryChance()
	PaperDollFrame_SetLabelAndText(statFrame, STAT_PARRY, chance, 1)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format("%s", PARRY_CHANCE).." "..format("%.02f", chance).."%"..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = format(CR_PARRY_TOOLTIP, GetCombatRating(CR_PARRY), GetCombatRatingBonus(CR_PARRY))
	statFrame:Show()
end

function module:SetResilience(statFrame, unit)
	if unit ~= "player" then statFrame:Hide() return end

	local melee = GetCombatRating(CR_CRIT_TAKEN_MELEE)
	local ranged = GetCombatRating(CR_CRIT_TAKEN_RANGED)
	local spell = GetCombatRating(CR_CRIT_TAKEN_SPELL)

	local minResilience = min(melee, ranged)
	minResilience = min(minResilience, spell)

	local lowestRating = CR_CRIT_TAKEN_MELEE
	if melee == minResilience then
		lowestRating = CR_CRIT_TAKEN_MELEE
	elseif ranged == minResilience then
		lowestRating = CR_CRIT_TAKEN_RANGED
	else
		lowestRating = CR_CRIT_TAKEN_SPELL
	end

	local lowestRatingBonus = GetCombatRatingBonus(lowestRating)

	PaperDollFrame_SetLabelAndText(statFrame, STAT_RESILIENCE, minResilience)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format("%s", STAT_RESILIENCE).." "..minResilience..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = format(RESILIENCE_TOOLTIP, lowestRatingBonus, min(lowestRatingBonus * 2, 25.00), lowestRatingBonus)

	statFrame:Show()
end

function module:SetMeleeDPS(statFrame, unit)
	_G[statFrame:GetName().."Label"]:SetText(format("%s:", L["Damage Per Second"]))
	local speed, offhandSpeed = UnitAttackSpeed(unit)
	local minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = UnitDamage(unit)

	minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg
	maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg

	local baseDamage = (minDamage + maxDamage) * 0.5
	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent
	local totalBonus = (fullDamage - baseDamage)
	local damagePerSecond = (max(fullDamage,1) / speed)

	local colorPos = "|cff20ff20"
	local colorNeg = "|cffff2020"
	local text

	if totalBonus < 0.1 and totalBonus > -0.1 then
		totalBonus = 0.0
	end

	if totalBonus == 0 then
		text = format("%.1f", damagePerSecond)
	else
		local color
		if totalBonus > 0 then
			color = colorPos
		else
			color = colorNeg
		end
		text = color..format("%.1f", damagePerSecond).."|r"
	end

	if offhandSpeed then
		minOffHandDamage = (minOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg
		maxOffHandDamage = (maxOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg

		local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5
		local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent
		local offhandDamagePerSecond = (max(offhandFullDamage, 1) / offhandSpeed)
		local offhandTotalBonus = (offhandFullDamage - offhandBaseDamage)

		if offhandTotalBonus < 0.1 and offhandTotalBonus > -0.1 then
			offhandTotalBonus = 0.0
		end
		local separator = " / "
		if damagePerSecond > 1000 and offhandDamagePerSecond > 1000 then
			separator = "/"
		end
		if offhandTotalBonus == 0 then
			text = text..separator..format("%.1f", offhandDamagePerSecond)
		else
			local color
			if offhandTotalBonus > 0 then
				color = colorPos
			else
				color = colorNeg
			end
			text = text..separator..color..format("%.1f", offhandDamagePerSecond).."|r"
		end
	end

	_G[statFrame:GetName().."StatText"]:SetText(text)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..DAMAGE_PER_SECOND..FONT_COLOR_CODE_CLOSE
	statFrame:Show()
end

function module:SetMeleeCritChance(statFrame, unit)
	if unit ~= "player" then statFrame:Hide() return end

	_G[statFrame:GetName().."Label"]:SetText(format("%s:", MELEE_CRIT_CHANCE))
	local text = _G[statFrame:GetName().."StatText"]
	local critChance = GetCritChance()
	critChance = format("%.2f%%", critChance)
	text:SetText(critChance)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format("%s", MELEE_CRIT_CHANCE).." "..critChance..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = format(CR_CRIT_MELEE_TOOLTIP, GetCombatRating(CR_CRIT_MELEE), GetCombatRatingBonus(CR_CRIT_MELEE))
end

function PaperDollFrame_CollapseStatCategory(categoryFrame)
	if not categoryFrame.collapsed then
		categoryFrame.collapsed = true
		--_G[categoryFrame:GetName().."Toolbar"]:SetTemplate("Default", true)
		local index = 1
		while _G[categoryFrame:GetName().."Stat"..index] do
			_G[categoryFrame:GetName().."Stat"..index]:Hide()
			index = index + 1
		end
		categoryFrame:SetHeight(18)
		module:PaperDollFrame_UpdateStatScrollChildHeight()
	end
end

function PaperDollFrame_ExpandStatCategory(categoryFrame)
	if categoryFrame.collapsed then
		categoryFrame.collapsed = false
		--_G[categoryFrame:GetName().."Toolbar"]:SetTemplate("Default", true)
		module:PaperDollFrame_UpdateStatCategory(categoryFrame)
		module:PaperDollFrame_UpdateStatScrollChildHeight()
	end
end

function module:PaperDollFrame_UpdateStatCategory(categoryFrame)
	if not categoryFrame.Category then categoryFrame:Hide() return end

	local categoryInfo = PAPERDOLL_STATCATEGORIES[categoryFrame.Category]
	if categoryInfo == PAPERDOLL_STATCATEGORIES["RESISTANCE"] then
		categoryFrame.NameText:SetText(L["Resistance"])
	elseif categoryInfo == PAPERDOLL_STATCATEGORIES["ITEM_LEVEL"] then
		if PersonalGearScore then
			categoryFrame.NameText:SetText("Gear Score")
		else
			categoryFrame.NameText:SetText(L["Item Level"])
		end
	else
		categoryFrame.NameText:SetText(_G["PLAYERSTAT_"..categoryFrame.Category])
	end

	if categoryFrame.collapsed then return end

	local totalHeight = categoryFrame.NameText:GetHeight() + 10
	local numVisible = 0
	if categoryInfo then
		local prevStatFrame = nil
		for index, stat in next, categoryInfo.stats do
			local statInfo = PAPERDOLL_STATINFO[stat]
			if statInfo then
				local statFrame = _G[categoryFrame:GetName().."Stat"..numVisible + 1]
				if not statFrame then
					statFrame = CreateFrame("FRAME", categoryFrame:GetName().."Stat"..numVisible + 1, categoryFrame, "CharacterStatFrameTemplate")
					if prevStatFrame then
						statFrame:SetPoint("TOPLEFT", prevStatFrame, "BOTTOMLEFT", 0, 0)
						statFrame:SetPoint("TOPRIGHT", prevStatFrame, "BOTTOMRIGHT", 0, 0)
					end
				end
				statFrame:Show()

				if stat == "ITEM_LEVEL" then
					statFrame:Height(30)
					local label = _G[statFrame:GetName().."Label"]
					label:ClearAllPoints()
					label:SetPoint("CENTER")
					label:SetSize(187, 30)
					label:FontTemplate(nil, 20)
					label:SetJustifyH("CENTER")
					_G[statFrame:GetName().."StatText"]:SetText("")

					if statFrame.leftGrad then
						statFrame.leftGrad:Show()
						statFrame.rightGrad:Show()
					end
				else
					if statFrame:GetHeight() == 30 then
						statFrame:Height(15)
						local label = _G[statFrame:GetName().."Label"]
						label:ClearAllPoints()
						label:SetPoint("LEFT", 7, 0)
						label:SetSize(122, 15)
						label:FontTemplate()
						label:SetJustifyH("LEFT")
						label:SetTextColor(1, 0.82, 0)

						if statFrame.leftGrad then
							statFrame.leftGrad:Hide()
							statFrame.rightGrad:Hide()
						end
					end
				end

				if statInfo.updateFunc2 then
					statFrame:SetScript("OnEnter", PaperDollStatTooltip)
					statFrame:SetScript("OnEnter", statInfo.updateFunc2)
				else
					statFrame:SetScript("OnEnter", PaperDollStatTooltip)
				end
				statFrame.tooltip = nil
				statFrame.tooltip2 = nil
				statFrame.UpdateTooltip = nil
				statFrame:SetScript("OnUpdate", nil)
				statInfo.updateFunc(statFrame, CharacterStatsPane.unit)
				if statFrame:IsShown() then
					numVisible = numVisible + 1
					totalHeight = totalHeight + statFrame:GetHeight()
					prevStatFrame = statFrame

					if GameTooltip:GetOwner() == statFrame then
						statFrame:GetScript("OnEnter")(statFrame)
					end
				end
			end
		end
	end

	for index = 1, numVisible do
		if index%2 == 0 or categoryInfo == PAPERDOLL_STATCATEGORIES["ITEM_LEVEL"] then
			local statFrame = _G[categoryFrame:GetName().."Stat"..index]
			if not statFrame.leftGrad then
				statFrame.leftGrad = statFrame:CreateTexture(nil, "BACKGROUND")
				statFrame.leftGrad:SetWidth(80)
				statFrame.leftGrad:SetHeight(statFrame:GetHeight())
				statFrame.leftGrad:SetPoint("LEFT", statFrame, "CENTER")
				statFrame.leftGrad:SetTexture(E.media.blankTex)
				statFrame.leftGrad:SetGradientAlpha("Horizontal", 0.8,0.8,0.8,0.35, 0.8,0.8,0.8,0)

				statFrame.rightGrad = statFrame:CreateTexture(nil, "BACKGROUND")
				statFrame.rightGrad:SetWidth(80)
				statFrame.rightGrad:SetHeight(statFrame:GetHeight())
				statFrame.rightGrad:SetPoint("RIGHT", statFrame, "CENTER")
				statFrame.rightGrad:SetTexture(E.media.blankTex)
				statFrame.rightGrad:SetGradientAlpha("Horizontal", 0.8,0.8,0.8,0, 0.8,0.8,0.8,0.35)
  			end
		end
	end

	local index = numVisible + 1
	while _G[categoryFrame:GetName().."Stat"..index] do
		_G[categoryFrame:GetName().."Stat"..index]:Hide()
		index = index + 1
	end

	categoryFrame:SetHeight(totalHeight)
end

function module:PaperDollFrame_UpdateStats()
	local index = 1
	while _G["CharacterStatsPaneCategory"..index] do
		self:PaperDollFrame_UpdateStatCategory(_G["CharacterStatsPaneCategory"..index])
		index = index + 1
	end
	self:PaperDollFrame_UpdateStatScrollChildHeight()
end

function module:PaperDollFrame_UpdateStatScrollChildHeight()
	local index = 1
	local totalHeight = 0
	while _G["CharacterStatsPaneCategory"..index] do
		if _G["CharacterStatsPaneCategory"..index]:IsShown() then
			totalHeight = totalHeight + _G["CharacterStatsPaneCategory"..index]:GetHeight() + 6
		end
		index = index + 1
	end
	CharacterStatsPaneScrollChild:SetHeight(totalHeight + 10 -(CharacterStatsPane.initialOffsetY or 0))
end

function module:PaperDoll_FindCategoryById(id)
	for categoryName, category in pairs(PAPERDOLL_STATCATEGORIES) do
		if category.id == id then
			return categoryName
		end
	end
	return nil
end

function module:PaperDoll_InitStatCategories(defaultOrder, orderData, collapsedData, unit)
	local order = defaultOrder

	local orderString = orderData
	local savedOrder = {}
	if orderString and orderString ~= "" then
		for i in gmatch(orderString, "%d+,?") do
			i = gsub(i, ",", "")
			i = tonumber(i)
			if i then
				local categoryName = self:PaperDoll_FindCategoryById(i)
				if categoryName then
					tinsert(savedOrder, categoryName)
				end
			end
		end

		local valid = true
		if #savedOrder == #defaultOrder then
			for i, category1 in next, defaultOrder do
				local found = false
				for j, category2 in next, savedOrder do
					if category1 == category2 then
						found = true
						break
					end
				end
				if not found then
					valid = false
					break
				end
			end
		else
			valid = false
		end

		if valid then
			order = savedOrder
		else
			orderData = ""
		end
	end

	wipe(StatCategoryFrames)
	for index = 1, #order do
		local frame = _G["CharacterStatsPaneCategory"..index]
		assert(frame)
		tinsert(StatCategoryFrames, frame)
		frame.Category = order[index]
		frame:Show()

		local categoryInfo = PAPERDOLL_STATCATEGORIES[frame.Category]
		if categoryInfo and collapsedData[frame.Category] then
			PaperDollFrame_CollapseStatCategory(frame)
		else
			PaperDollFrame_ExpandStatCategory(frame)
		end
	end

	local index = #order + 1
	while _G["CharacterStatsPaneCategory"..index] do
		_G["CharacterStatsPaneCategory"..index]:Hide()
		_G["CharacterStatsPaneCategory"..index].Category = nil
		index = index + 1
	end

	CharacterStatsPane.defaultOrder = defaultOrder
	CharacterStatsPane.orderData = orderData
	CharacterStatsPane.collapsedData = collapsedData
	CharacterStatsPane.unit = unit

	self:PaperDoll_UpdateCategoryPositions()
	self:PaperDollFrame_UpdateStats()
end

function PaperDoll_SaveStatCategoryOrder()
	if CharacterStatsPane.defaultOrder and #CharacterStatsPane.defaultOrder == #StatCategoryFrames then
		local same = true
		for index = 1, #StatCategoryFrames do
			if StatCategoryFrames[index].Category ~= CharacterStatsPane.defaultOrder[index] then
				same = false
				break
			end
		end
		if same then
			E.db.enhanced.character[CharacterStatsPane.unit].orderName = ""
			return
		end
	end

	local string = ""
	for index = 1, #StatCategoryFrames do
		if index ~= #StatCategoryFrames then
			string = string..PAPERDOLL_STATCATEGORIES[StatCategoryFrames[index].Category].id..","
		else
			string = string..PAPERDOLL_STATCATEGORIES[StatCategoryFrames[index].Category].id
		end
	end
	E.db.enhanced.character[CharacterStatsPane.unit].orderName = string
end

function module:PaperDoll_UpdateCategoryPositions()
	local prevFrame = nil
	for index = 1, #StatCategoryFrames do
		local frame = StatCategoryFrames[index]
		frame:ClearAllPoints()
	end

	for index = 1, #StatCategoryFrames do
		local frame = StatCategoryFrames[index]

		local xOffset = 0
		if frame == MOVING_STAT_CATEGORY then
			xOffset = STATCATEGORY_MOVING_INDENT
		elseif prevFrame and prevFrame == MOVING_STAT_CATEGORY then
			xOffset = -STATCATEGORY_MOVING_INDENT
		end

		if prevFrame then
			frame:SetPoint("TOPLEFT", prevFrame, "BOTTOMLEFT", 0 + xOffset, -6)
		else
			frame:SetPoint("TOPLEFT", 1 + xOffset, -6 + (CharacterStatsPane.initialOffsetY or 0))
		end
		prevFrame = frame
	end
end

function PaperDoll_MoveCategoryUp(self)
	for index = 2, #StatCategoryFrames do
		if StatCategoryFrames[index] == self then
			tremove(StatCategoryFrames, index)
			tinsert(StatCategoryFrames, index-1, self)
			break
		end
	end

	module:PaperDoll_UpdateCategoryPositions()
	PaperDoll_SaveStatCategoryOrder()
end

function PaperDoll_MoveCategoryDown(self)
	for index = 1, #StatCategoryFrames - 1 do
		if StatCategoryFrames[index] == self then
			tremove(StatCategoryFrames, index)
			tinsert(StatCategoryFrames, index + 1, self)
			break
		end
	end
	module:PaperDoll_UpdateCategoryPositions()
	PaperDoll_SaveStatCategoryOrder()
end

function PaperDollStatCategory_OnDragUpdate(self)
	local _, cursorY = GetCursorPosition()
	cursorY = cursorY * GetScreenHeightScale()

	local myIndex = nil
	local insertIndex = nil
	local closestPos

	for index = 1, #StatCategoryFrames + 1 do
		if StatCategoryFrames[index] == self then
			myIndex = index
		end

		local frameY
		if index <= #StatCategoryFrames then
			frameY = StatCategoryFrames[index]:GetTop()
		else
			frameY = StatCategoryFrames[#StatCategoryFrames]:GetBottom()
		end
		frameY = frameY - 8
		if myIndex and index > myIndex then
			frameY = frameY + self:GetHeight()
		end
		if not closestPos or abs(cursorY - frameY)<closestPos then
			insertIndex = index
			closestPos = abs(cursorY-frameY)
		end
	end

	if insertIndex > myIndex then
		insertIndex = insertIndex - 1
	end

	if myIndex ~= insertIndex then
		tremove(StatCategoryFrames, myIndex)
		tinsert(StatCategoryFrames, insertIndex, self)
		module:PaperDoll_UpdateCategoryPositions()
	end
end

function PaperDollStatCategory_OnDragStart(self)
	MOVING_STAT_CATEGORY = self
	module:PaperDoll_UpdateCategoryPositions()
	GameTooltip:Hide()
	self:SetScript("OnUpdate", PaperDollStatCategory_OnDragUpdate)

	for i, frame in next, StatCategoryFrames do
		if frame ~= self then
			UIFrameFadeIn(frame, 0.2, 1, 0.6)
		end
	end
end

function PaperDollStatCategory_OnDragStop(self)
	MOVING_STAT_CATEGORY = nil
	module:PaperDoll_UpdateCategoryPositions()
	self:SetScript("OnUpdate", nil)

	for i, frame in next, StatCategoryFrames do
		if frame ~= self then
			UIFrameFadeOut(frame, 0.2, 0.6, 1)
		end
	end
	PaperDoll_SaveStatCategoryOrder()
end

function module:PaperDollFrame_UpdateSidebarTabs()
	for i = 1, #PAPERDOLL_SIDEBARS do
		local tab = _G["PaperDollSidebarTab"..i]
		if tab then
			if _G[PAPERDOLL_SIDEBARS[i].frame]:IsShown() then
				tab.Hider:Hide()
				tab.Highlight:Hide()
			else
				tab.Hider:Show()
				tab.Highlight:Show()
			end
		end
	end
end

function module:PaperDollFrame_SetSidebar(index)
	if not _G[PAPERDOLL_SIDEBARS[index].frame]:IsShown() then
		for i = 1, #PAPERDOLL_SIDEBARS do
			_G[PAPERDOLL_SIDEBARS[i].frame]:Hide()
		end
		_G[PAPERDOLL_SIDEBARS[index].frame]:Show()
		PaperDollFrame.currentSideBar = _G[PAPERDOLL_SIDEBARS[index].frame]
		self:PaperDollFrame_UpdateSidebarTabs()
	end
end

function module:PaperDollTitlesPane_UpdateScrollFrame()
	local buttons = PaperDollTitlesPane.buttons
	local playerTitles = PaperDollTitlesPane.titles
	local numButtons = #buttons
	local scrollOffset = HybridScrollFrame_GetOffset(PaperDollTitlesPane)
	local button, playerTitle
	for i = 1, numButtons do
		button = buttons[i]
		playerTitle = playerTitles[i + scrollOffset]
		if playerTitle then
			button:Show()
			button.text:SetText(playerTitle.name)
			button.titleId = playerTitle.id
			if PaperDollTitlesPane.selected == playerTitle.id  then
				button.Check:SetAlpha(1)
				button.SelectedBar:Show()
			else
				button.Check:SetAlpha(0)
				button.SelectedBar:Hide()
			end

			if (i + scrollOffset) % 2 == 0 then
				button.Stripe:SetTexture(0.9, 0.9, 1)
				button.Stripe:SetAlpha(0.1)
				button.Stripe:Show()
			else
				button.Stripe:Hide()
			end
		else
			button:Hide()
		end
	end
end

local function PlayerTitleSort(a, b) return a.name < b.name end

function module:PaperDollTitlesPane_Update()
	local playerTitles = {}
	local currentTitle = GetCurrentTitle()
	local titleCount = 1
	local buttons = PaperDollTitlesPane.buttons
	local fontstringText = buttons[1].text

	PaperDollTitlesPane.selected = -1
	playerTitles[1] = {}
	playerTitles[1].name = "       "
	playerTitles[1].id = -1

	for i = 1, GetNumTitles() do
		if IsTitleKnown(i) ~= 0 then
			titleCount = titleCount + 1
			playerTitles[titleCount] = playerTitles[titleCount] or { }
			playerTitles[titleCount].name = trim(GetTitleName(i))
			playerTitles[titleCount].id = i
			if i == currentTitle then
				PaperDollTitlesPane.selected = i
			end
			fontstringText:SetText(playerTitles[titleCount].name)
		end
	end

	sort(playerTitles, PlayerTitleSort)
	playerTitles[1].name = NONE
	PaperDollTitlesPane.titles = playerTitles

	HybridScrollFrame_Update(PaperDollTitlesPane, (titleCount * 22) + 20 , PaperDollTitlesPane:GetHeight())
	if not PaperDollTitlesPane.scrollBar.thumbTexture:IsShown() then
		PaperDollTitlesPane.scrollBar.thumbTexture:Show()
	end

	self:PaperDollTitlesPane_UpdateScrollFrame()
end

function module:UpdateCharacterModelFrame()
	if E.db.enhanced.character.characterBackground then
		CharacterModelFrame.backdrop:Show()
		
		local desaturate = E.db.enhanced.character.desaturateCharacter and true or false

		CharacterModelFrame.textureTopLeft:Show()
		CharacterModelFrame.textureTopLeft:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PaperDoll\\"..lower(E.myrace).."_1.blp")
		CharacterModelFrame.textureTopLeft:SetDesaturated(desaturate)

		CharacterModelFrame.textureTopRight:Show()
		CharacterModelFrame.textureTopRight:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PaperDoll\\"..lower(E.myrace).."_2.blp")
		CharacterModelFrame.textureTopRight:SetDesaturated(desaturate)

		CharacterModelFrame.textureBotLeft:Show()
		CharacterModelFrame.textureBotLeft:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PaperDoll\\"..lower(E.myrace).."_3.blp")
		CharacterModelFrame.textureBotLeft:SetDesaturated(desaturate)

		CharacterModelFrame.textureBotRight:Show()
		CharacterModelFrame.textureBotRight:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PaperDoll\\"..lower(E.myrace).."_4.blp")
		CharacterModelFrame.textureBotRight:SetDesaturated(desaturate)

		CharacterModelFrame.backgroundOverlay:Show()
		CharacterModelFrame.backgroundOverlay:SetTexture(0, 0, 0)

		if strupper(E.myrace) == "SCOURGE" then
			CharacterModelFrame.backgroundOverlay:SetAlpha(0.2)
		elseif strupper(E.myrace) == "BLOODELF" then
			CharacterModelFrame.backgroundOverlay:SetAlpha(0.7)
		elseif strupper(E.myrace) == "ORC" or strupper(E.myrace) == "TROLL" then
			CharacterModelFrame.backgroundOverlay:SetAlpha(0.5)
		else
			CharacterModelFrame.backgroundOverlay:SetAlpha(0.6)
		end
	else
		CharacterModelFrame.backdrop:Hide()
		CharacterModelFrame.textureTopLeft:Hide()
		CharacterModelFrame.textureTopRight:Hide()
		CharacterModelFrame.textureBotLeft:Hide()
		CharacterModelFrame.textureBotRight:Hide()
		CharacterModelFrame.backgroundOverlay:Hide()
	end
end

function module:UpdateInspectModelFrame()
	if E.db.enhanced.character.inspectBackground then
		InspectModelFrame.backdrop:Show()

		local _, fileName = UnitRace(InspectFrame.unit)
		local desaturate = E.db.enhanced.character.desaturateInspect and true or false

		InspectModelFrame.textureTopLeft:Show()
		InspectModelFrame.textureTopLeft:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PaperDoll\\"..lower(fileName).."_1.blp")
		InspectModelFrame.textureTopLeft:SetDesaturated(desaturate)

		InspectModelFrame.textureTopRight:Show()
		InspectModelFrame.textureTopRight:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PaperDoll\\"..lower(fileName).."_2.blp")
		InspectModelFrame.textureTopRight:SetDesaturated(desaturate)

		InspectModelFrame.textureBotLeft:Show()
		InspectModelFrame.textureBotLeft:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PaperDoll\\"..lower(fileName).."_3.blp")
		InspectModelFrame.textureBotLeft:SetDesaturated(desaturate)

		InspectModelFrame.textureBotRight:Show()
		InspectModelFrame.textureBotRight:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PaperDoll\\"..lower(fileName).."_4.blp")
		InspectModelFrame.textureBotRight:SetDesaturated(desaturate)

		InspectModelFrame.backgroundOverlay:Show()
		InspectModelFrame.backgroundOverlay:SetTexture(0, 0, 0)

		if strupper(fileName) == "SCOURGE" then
			InspectModelFrame.backgroundOverlay:SetAlpha(0.2)
		elseif strupper(fileName) == "BLOODELF" then
			InspectModelFrame.backgroundOverlay:SetAlpha(0.7)
		elseif strupper(fileName) == "ORC" or strupper(fileName) == "TROLL" then
			InspectModelFrame.backgroundOverlay:SetAlpha(0.5)
		else
			InspectModelFrame.backgroundOverlay:SetAlpha(0.6)
		end
	else
		InspectModelFrame.backdrop:Hide()
		InspectModelFrame.textureTopLeft:Hide()
		InspectModelFrame.textureTopRight:Hide()
		InspectModelFrame.textureBotLeft:Hide()
		InspectModelFrame.textureBotRight:Hide()
		InspectModelFrame.backgroundOverlay:Hide()
	end
end

function module:UpdatePetModelFrame()
	if E.db.enhanced.character.petBackground then
		PetModelFrame.backdrop:Show()

		PetModelFrame.petPaperDollPetModelBg:Show()
		if E.myclass == "HUNTER" then
			PetModelFrame.petPaperDollPetModelBg:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PetPaperDoll\\petHunter.blp")
			PetModelFrame.backgroundOverlay:SetAlpha(0.4)
		elseif E.myclass == "WARLOCK" then
			PetModelFrame.petPaperDollPetModelBg:SetTexture("Interface\\AddOns\\ElvUI_Enhanced\\Media\\Textures\\PetPaperDoll\\petWarlock.blp")
			PetModelFrame.backgroundOverlay:SetAlpha(0.2)
		else
			PetModelFrame.petPaperDollPetModelBg:Hide()
		end

		if E.db.enhanced.character.desaturatePet then
			PetModelFrame.petPaperDollPetModelBg:SetDesaturated(true)
		else
			PetModelFrame.petPaperDollPetModelBg:SetDesaturated(false)
		end

		PetModelFrame.backgroundOverlay:Show()
		PetModelFrame.backgroundOverlay:SetTexture(0, 0, 0)
	else
		PetModelFrame.backdrop:Hide()
		PetModelFrame.petPaperDollPetModelBg:Hide()
		PetModelFrame.backgroundOverlay:Hide()
	end
end

function module:ADDON_LOADED(_, addon)
	if addon ~= "Blizzard_InspectUI" then return end
	self:UnregisterEvent("ADDON_LOADED")

	InspectModelFrame:CreateBackdrop("Default")
	InspectModelFrame:Size(231, 320)
	InspectModelFrame:Point("TOPLEFT", InspectPaperDollFrame, "TOPLEFT", 66, -78)

	local inspectSlots = {"Head", "Neck", "Shoulder", "Back", "Chest", "Shirt", "Tabard", "Wrist", "Waist", "Legs", "Feet", "Finger0", "Finger1", "Trinket0", "Trinket1", "MainHand", "SecondaryHand", "Ranged"}
	for _, name in ipairs(inspectSlots) do
		_G[format("Inspect%sSlot", name)]:SetFrameLevel(InspectModelFrame:GetFrameLevel() + 3)
	end

	InspectModelFrame.textureTopLeft = InspectModelFrame:CreateTexture("$parentTextureTopLeft", "BACKGROUND")
	InspectModelFrame.textureTopLeft:Point("TOPLEFT")
	InspectModelFrame.textureTopLeft:Size(212, 244)
	InspectModelFrame.textureTopLeft:SetTexCoord(0.171875, 1, 0.0392156862745098, 1)

	InspectModelFrame.textureTopRight = InspectModelFrame:CreateTexture("$parentTextureTopRight", "BACKGROUND")
	InspectModelFrame.textureTopRight:Point("TOPLEFT", InspectModelFrame.textureTopLeft, "TOPRIGHT")
	InspectModelFrame.textureTopRight:Size(19, 244)
	InspectModelFrame.textureTopRight:SetTexCoord(0, 0.296875, 0.0392156862745098, 1)

	InspectModelFrame.textureBotLeft = InspectModelFrame:CreateTexture("$parentTextureBotLeft", "BACKGROUND")
	InspectModelFrame.textureBotLeft:Point("TOPLEFT", InspectModelFrame.textureTopLeft, "BOTTOMLEFT")
	InspectModelFrame.textureBotLeft:Size(212, 128)
	InspectModelFrame.textureBotLeft:SetTexCoord(0.171875, 1, 0, 1)

	InspectModelFrame.textureBotRight = InspectModelFrame:CreateTexture("$parentTextureBotRight", "BACKGROUND")
	InspectModelFrame.textureBotRight:Point("TOPLEFT", InspectModelFrame.textureTopLeft, "BOTTOMRIGHT")
	InspectModelFrame.textureBotRight:Size(19, 128)
	InspectModelFrame.textureBotRight:SetTexCoord(0, 0.296875, 0, 1)

	InspectModelFrame.backgroundOverlay = InspectModelFrame:CreateTexture("$parentBackgroundOverlay", "BORDER")
	InspectModelFrame.backgroundOverlay:Point("TOPLEFT", InspectModelFrame.textureTopLeft)
	InspectModelFrame.backgroundOverlay:Point("BOTTOMRIGHT", InspectModelFrame.textureBotRight, 0, 52)

	self:SecureHook("InspectFrame_UpdateTalentTab", "UpdateInspectModelFrame")
end

local slots = {
	["HeadSlot"] = "INVTYPE_HEAD",
	["NeckSlot"] = "INVTYPE_NECK",
	["ShoulderSlot"] = "INVTYPE_SHOULDER",
	["BackSlot"] = "INVTYPE_CLOAK",
	["ChestSlot"] = "INVTYPE_ROBE",
	["WristSlot"] = "INVTYPE_WRIST",
	["HandsSlot"] = "INVTYPE_HAND",
	["WaistSlot"] = "INVTYPE_WAIST",
	["LegsSlot"] = "INVTYPE_LEGS",
	["FeetSlot"] = "INVTYPE_FEET",
	["Finger0Slot"] = "INVTYPE_FINGER",
	["Finger1Slot"] = "INVTYPE_FINGER",
	["Trinket0Slot"] = "INVTYPE_TRINKET",
	["Trinket1Slot"] = "INVTYPE_TRINKET",
	["MainHandSlot"] = "INVTYPE_WEAPONMAINHAND",
	["SecondaryHandSlot"] = "INVTYPE_HOLDABLE",
	["RangedSlot"] = "INVTYPE_RANGEDRIGHT",
}

local bagsTable = {}
function GetAverageItemLevel()
	local itemLink, itemLevel, itemEquipLoc
	local total, totalBag, item, bagItem, isBagItemLevel = 0, 0, 0, 0

	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			itemLink = GetContainerItemLink(bag, slot)
			if itemLink then
				_, _, _, itemLevel, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
				if itemEquipLoc and itemEquipLoc ~= "" then
					if not bagsTable[itemEquipLoc] then
						bagsTable[itemEquipLoc] = itemLevel
					else
						if itemLevel > bagsTable[itemEquipLoc] then
							bagsTable[itemEquipLoc] = itemLevel
						end
					end
				end
			end
		end
	end

	for slotName, itemLoc in pairs(slots) do
		itemLink = GetInventoryItemLink("player", GetInventorySlotInfo(slotName))
		if itemLink then
			_, _, _, itemLevel, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
			if itemLevel and itemLevel > 0 then
				item = item + 1
				bagItem = bagItem + 1

				isBagItemLevel = bagsTable[itemEquipLoc]
				if isBagItemLevel and isBagItemLevel > itemLevel then
					totalBag = totalBag + isBagItemLevel
				else
					totalBag = totalBag + itemLevel
				end

				total = total + itemLevel
			end
		else
			isBagItemLevel = bagsTable[itemLoc]
			if isBagItemLevel then
				bagItem = bagItem + 1
				totalBag = totalBag + isBagItemLevel
			end
		end
	end

	wipe(bagsTable)

	if total < 1 then
		return 0, 0
	end

	return (totalBag / bagItem), (total / item)
end

function GetItemLevelColor(unit)
	if not unit then unit = "player" end

	local i = 0
	local sumR, sumG, sumB = 0, 0, 0
	for slotName, _ in pairs(slots) do
		local slotID = GetInventorySlotInfo(slotName)
		if GetInventoryItemTexture(unit, slotID) then
			local itemLink = GetInventoryItemLink(unit, slotID)
			if itemLink then
				local quality = select(3, GetItemInfo(itemLink))
				if quality then
					i = i + 1
					local r, g, b = GetItemQualityColor(quality)
					sumR = sumR + r
					sumG = sumG + g
					sumB = sumB + b
				end
			end
		end
	end

	if i > 0 then
		return (sumR / i), (sumG / i), (sumB / i)
	else
		return 1, 1, 1
	end
end

function module:Initialize()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.character ~= true then return end
	if not E.private.enhanced.character.enable then return end

	if PersonalGearScore then
		PersonalGearScore:Hide()
	end
	if GearScore2 then
		GearScore2:Hide()
	end

	local function FixHybridScrollBarSize(frame, w1, w2, h1, h2)
		local name = frame:GetName()

		if not frame.fixed then
			if _G[name.."ScrollUpButton"] and _G[name.."ScrollDownButton"] then
				_G[name.."ScrollUpButton"]:Width(_G[name.."ScrollUpButton"]:GetWidth() + 2)
				_G[name.."ScrollDownButton"]:Width(_G[name.."ScrollDownButton"]:GetWidth() + 2)
			end
			frame.fixed = true
		end

		if frame.thumbbg then
			frame.thumbTexture:Size(16, 28)
			frame.thumbbg:Point("TOPLEFT", frame:GetThumbTexture(), "TOPLEFT", w1, h1)
			frame.thumbbg:Point("BOTTOMRIGHT", frame:GetThumbTexture(), "BOTTOMRIGHT", w2, h2)
		end
	end

	PlayerTitleDropDown:Kill()
	CharacterAttributesFrame:Kill()
	CharacterResistanceFrame:Kill()

	CharacterNameFrame:ClearAllPoints()
	CharacterNameFrame:SetPoint("TOP", CharacterFrame, -10, -25)

	local expandButton = CreateFrame("Button", "CharacterFrameExpandButton", CharacterFrame)
	expandButton:Size(25)
	expandButton:SetPoint("BOTTOMLEFT", CharacterFrame, 315, 84)
	expandButton:SetFrameLevel(CharacterFrame:GetFrameLevel() + 5)
	S:HandleNextPrevButton(CharacterFrameExpandButton)

	expandButton:SetScript("OnClick", function(self)
		if CharacterFrame.Expanded then
			E.db.enhanced.character.collapsed = true
			module:CharacterFrame_Collapse()
			PlaySound("igCharacterInfoClose")
		else
			E.db.enhanced.character.collapsed = false
			module:CharacterFrame_Expand()
			PlaySound("igCharacterInfoOpen")
		end
		if GameTooltip:GetOwner() == self then
			self:GetScript("OnEnter")(self)
		end
	end)

	expandButton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if CharacterFrame.Expanded then
			GameTooltip:SetText(self.collapseTooltip)
		else
			GameTooltip:SetText(self.expandTooltip)
		end

		self:SetBackdropBorderColor(unpack(E["media"].rgbvaluecolor))
	end)

	expandButton:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
		self:SetBackdropBorderColor(unpack(E["media"].bordercolor))
	end)

	local sidebarTabs = CreateFrame("Frame", "PaperDollSidebarTabs", PaperDollFrame)
	sidebarTabs:Hide()
	sidebarTabs:Size(112, 35)
	sidebarTabs:SetPoint("BOTTOMRIGHT", CharacterFrame, "TOPRIGHT", -75,-73)

	local sidebarTabs2 = CreateFrame("Button", "PaperDollSidebarTab2", sidebarTabs)
	sidebarTabs2:SetID(2)
	sidebarTabs2:SetPoint("BOTTOMRIGHT", -30, 0)
	self:PaperDollSidebarTab(sidebarTabs2)

	local sidebarTabs1 = CreateFrame("Button", "PaperDollSidebarTab1", sidebarTabs)
	sidebarTabs1:SetID(1)
	sidebarTabs1:SetPoint("RIGHT", "PaperDollSidebarTab2", "LEFT", -4, 0)
	self:PaperDollSidebarTab(sidebarTabs1)

	local tcoords = PAPERDOLL_SIDEBARS[1].texCoords
	sidebarTabs1.Icon:SetTexCoord(tcoords[1], tcoords[2], tcoords[3], tcoords[4])

	sidebarTabs1:RegisterEvent("UNIT_PORTRAIT_UPDATE")
	sidebarTabs1:RegisterEvent("PLAYER_ENTERING_WORLD")
	sidebarTabs1:SetScript("OnEvent", function(self, event, ...)
		if event == "UNIT_PORTRAIT_UPDATE" then
			local unit = ...
			if not unit or unit == "player" then
				SetPortraitTexture(self.Icon, "player")
			end
		elseif event == "PLAYER_ENTERING_WORLD" then
			SetPortraitTexture(self.Icon, "player")
		end
	end)

	local titlePane = CreateFrame("ScrollFrame", "PaperDollTitlesPane", PaperDollFrame, "HybridScrollFrameTemplate")
	titlePane:Hide()
	titlePane:Size(172, 354)
	titlePane:Point("TOPRIGHT", -57, -75)

	titlePane.scrollBar = CreateFrame("Slider", "$parentScrollBar", titlePane, "HybridScrollBarTemplate")
	titlePane.scrollBar:Width(20)
	titlePane.scrollBar:ClearAllPoints()
	titlePane.scrollBar:SetPoint("TOPLEFT", titlePane, "TOPRIGHT", 1, -14)
	titlePane.scrollBar:SetPoint("BOTTOMLEFT", titlePane, "BOTTOMRIGHT", 1, 14)
	S:HandleScrollBar(titlePane.scrollBar)
	FixHybridScrollBarSize(titlePane.scrollBar, 1, -1, -5, 5)

	titlePane.scrollBar.Show = function(self)
		titlePane:Width(172)
		titlePane:Point("TOPRIGHT", -57, -75)
		for _, button in next, titlePane.buttons do
			button:Width(172)

			button.Stripe:SetInside()
			button.SelectedBar:SetTexture(1, 0.80, 0.10, 0.3)
			button.SelectedBar:SetInside()

			button:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
			button:GetHighlightTexture():SetInside()
		end
		getmetatable(self).__index.Show(self)
	end

	titlePane.scrollBar.Hide = function(self)
		titlePane:Width(190)
		titlePane:Point("TOPRIGHT", -39, -75)
		for _, button in next, titlePane.buttons do
			button:Width(190)
		end
		getmetatable(self).__index.Hide(self)
	end

	titlePane:SetFrameLevel(CharacterFrame:GetFrameLevel() + 1)

	HybridScrollFrame_OnLoad(titlePane)
	titlePane.update = self.PaperDollTitlesPane_UpdateScrollFrame
	HybridScrollFrame_CreateButtons(PaperDollTitlesPane, "PlayerTitleButtonTemplate2", 2, -4)

	local statsPane = CreateFrame("ScrollFrame", "CharacterStatsPane", CharacterFrame, "UIPanelScrollFrameTemplate")
	statsPane:Hide()
	statsPane:Height(354)
	statsPane.buttons = {}

	CharacterStatsPaneScrollBar:ClearAllPoints()
	CharacterStatsPaneScrollBar:SetPoint("TOPLEFT", statsPane, "TOPRIGHT", 3, -16)
	CharacterStatsPaneScrollBar:SetPoint("BOTTOMLEFT", statsPane, "BOTTOMRIGHT", 3, 16)
	S:HandleScrollBar(CharacterStatsPaneScrollBar)

	CharacterStatsPaneScrollBar.scrollStep = 50
	statsPane.scrollBarHideable = 1
	statsPane.offset = 0

	local statsPaneScrollChild = CreateFrame("Frame", "CharacterStatsPaneScrollChild", statsPane)
	statsPaneScrollChild:SetSize(170, 0)
	statsPaneScrollChild:SetPoint("TOPLEFT")

	for i = 1, 8 do
		local button = CreateFrame("Frame", "CharacterStatsPaneCategory"..i, statsPaneScrollChild, "StatGroupTemplate")
		button.Toolbar:SetTemplate("Default", true)
		button.Toolbar:HookScript2("OnEnter", S.SetModifiedBackdrop)
		button.Toolbar:HookScript2("OnLeave", S.SetOriginalBackdrop)

		button.NameText:SetParent(button.Toolbar)
		button.NameText:ClearAllPoints()
		button.NameText:SetPoint("CENTER", button.Toolbar)
		statsPane.buttons[i] = button
	end

	statsPane:SetScrollChild(statsPaneScrollChild)

	CharacterStatsPaneScrollBar.Show = function(self)
		statsPane:Width(177)
		statsPane:Point("TOPRIGHT", -57, -75)
		for _, button in next, statsPane.buttons do
			button:Width(177)
			button.Toolbar:Width(150 - 18)
		end
		getmetatable(self).__index.Show(self)
	end

	CharacterStatsPaneScrollBar.Hide = function(self)
		statsPane:Width(177 + 18)
		statsPane:Point("TOPRIGHT", -39, -75)
		for _, button in next, statsPane.buttons do
			button:Width(177 + 18)
			button.Toolbar:Width(150)
		end
		getmetatable(self).__index.Hide(self)
	end

	statsPane:Width(177)
	statsPane:Point("TOPRIGHT", -39, -75)
	for _, button in next, statsPane.buttons do
		button:Width(177)
		button.Toolbar:Width(150 - 18)
	end

	statsPane:SetScript("OnShow", function(self)
		module:PaperDollTitlesPane_Update()
	end)

	CharacterModelFrame:CreateBackdrop("Default")
	CharacterModelFrame:Size(231, 320)
	CharacterModelFrame:Point("TOPLEFT", PaperDollFrame, "TOPLEFT", 66, -78)

	for _, name in ipairs(slotName) do
		_G[format("Character%sSlot", name)]:SetFrameLevel(CharacterModelFrame:GetFrameLevel() + 3)
	end

	CharacterModelFrame.textureTopLeft = CharacterModelFrame:CreateTexture("$parentTextureTopLeft", "BACKGROUND")
	CharacterModelFrame.textureTopLeft:Size(212, 244)
	CharacterModelFrame.textureTopLeft:Point("TOPLEFT")
	CharacterModelFrame.textureTopLeft:SetTexCoord(0.171875, 1, 0.0392156862745098, 1)

	CharacterModelFrame.textureTopRight = CharacterModelFrame:CreateTexture("$parentTextureTopRight", "BACKGROUND")
	CharacterModelFrame.textureTopRight:Size(19, 244)
	CharacterModelFrame.textureTopRight:Point("TOPLEFT", CharacterModelFrame.textureTopLeft, "TOPRIGHT")
	CharacterModelFrame.textureTopRight:SetTexCoord(0, 0.296875, 0.0392156862745098, 1)

	CharacterModelFrame.textureBotLeft = CharacterModelFrame:CreateTexture("$parentTextureBotLeft", "BACKGROUND")
	CharacterModelFrame.textureBotLeft:Size(212, 128)
	CharacterModelFrame.textureBotLeft:Point("TOPLEFT", CharacterModelFrame.textureTopLeft, "BOTTOMLEFT")
	CharacterModelFrame.textureBotLeft:SetTexCoord(0.171875, 1, 0, 1)

	CharacterModelFrame.textureBotRight = CharacterModelFrame:CreateTexture("$parentTextureBotRight", "BACKGROUND")
	CharacterModelFrame.textureBotRight:Size(19, 128)
	CharacterModelFrame.textureBotRight:Point("TOPLEFT", CharacterModelFrame.textureTopLeft, "BOTTOMRIGHT")
	CharacterModelFrame.textureBotRight:SetTexCoord(0, 0.296875, 0, 1)

	CharacterModelFrame.backgroundOverlay = CharacterModelFrame:CreateTexture("$parentBackgroundOverlay", "BORDER")
	CharacterModelFrame.backgroundOverlay:Point("TOPLEFT", CharacterModelFrame.textureTopLeft)
	CharacterModelFrame.backgroundOverlay:Point("BOTTOMRIGHT", CharacterModelFrame.textureBotRight, 0, 52)

	self:UpdateCharacterModelFrame()

	self:PaperDoll_InitStatCategories(PAPERDOLL_STATCATEGORY_DEFAULTORDER, E.db.enhanced.character.player.orderName, E.db.enhanced.character.player.collapsedName, "player")

	PaperDollFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
	PaperDollFrame:HookScript2("OnEvent", function(self, event, ...)
		if not self:IsVisible() then return end

		local unit = ...
		if event == "KNOWN_TITLES_UPDATE" or (event == "UNIT_NAME_UPDATE" and unit == "player") then
			if PaperDollTitlesPane:IsShown() then
				module:PaperDollTitlesPane_Update()
			end
		end

		if unit == "player" then
			if event == "UNIT_LEVEL" then
				module:PaperDollFrame_SetLevel()
			elseif event == "UNIT_DAMAGE" or event == "PLAYER_DAMAGE_DONE_MODS" or event == "UNIT_ATTACK_SPEED" or event == "UNIT_RANGEDDAMAGE" or event == "UNIT_ATTACK" or event == "UNIT_STATS" or event == "UNIT_RANGED_ATTACK_POWER" then
				module:PaperDollFrame_UpdateStats()
			elseif event == "UNIT_RESISTANCES" then
				module:PaperDollFrame_UpdateStats()
			end
		end

		if event == "COMBAT_RATING_UPDATE" then
			module:PaperDollFrame_UpdateStats()
		elseif event == "PLAYER_TALENT_UPDATE" then
			module:PaperDollFrame_SetLevel()
		end
	end)

	PaperDollFrame:HookScript2("OnShow", function()
		if E.db.enhanced.character.collapsed then
			module:CharacterFrame_Collapse()
		else
			module:CharacterFrame_Expand()
		end

		module:PaperDoll_InitStatCategories(PAPERDOLL_STATCATEGORY_DEFAULTORDER, E.db.enhanced.character.player.orderName, E.db.enhanced.character.player.collapsedName, "player")
		CharacterFrameExpandButton:Show()
		CharacterFrameExpandButton.collapseTooltip = L["Hide Character Information"]
		CharacterFrameExpandButton.expandTooltip = L["Show Character Information"]
		module:PaperDollFrame_SetLevel()
	end)

	PaperDollFrame:HookScript2("OnHide", function(self)
		if not self:IsShown() then
			module:CharacterFrame_Collapse()
		end
		CharacterFrameExpandButton:Hide()
	end)

	if E.db.enhanced.character.collapsed then
		self:CharacterFrame_Collapse()
	else
		self:CharacterFrame_Expand()
	end

	PetNameText:SetPoint("CENTER", CharacterFrame, 0, 200)
	PetLevelText:SetPoint("TOP", CharacterFrame, 0, -20)
	PetPaperDollPetInfo:SetPoint("TOPLEFT", 25, -78)

	PetTrainingPointText:ClearAllPoints()
	PetTrainingPointText:SetPoint("BOTTOMRIGHT", PetModelFrame, "BOTTOMRIGHT", -31, -26)
	PetTrainingPointLabel:SetPoint("RIGHT", PetTrainingPointText, "LEFT", -5, 1)

	PetPaperDollCloseButton:Kill()
	PetAttributesFrame:Kill()
	PetResistanceFrame:Kill()

	PetModelFrame:CreateBackdrop("Default")
	PetModelFrame:SetSize(310, 320)

	PetModelFrame.petPaperDollPetModelBg = PetModelFrame:CreateTexture("$parentPetPaperDollPetModelBg", "BACKGROUND")
	PetModelFrame.petPaperDollPetModelBg:Size(494, 461)
	PetModelFrame.petPaperDollPetModelBg:Point("TOPLEFT")

	PetModelFrame.backgroundOverlay = PetModelFrame:CreateTexture("$parentBackgroundOverlay", "BORDER")
	PetModelFrame.backgroundOverlay:SetAllPoints()

	self:UpdatePetModelFrame()

	PetPaperDollFrame:HookScript2("OnShow", function(self)
		if E.db.enhanced.character.collapsed then
			module:CharacterFrame_Collapse()
		else
			module:CharacterFrame_Expand()
		end

		module:PaperDoll_InitStatCategories(PETPAPERDOLL_STATCATEGORY_DEFAULTORDER, E.db.enhanced.character.pet.orderName, E.db.enhanced.character.pet.collapsedName, "pet")

		CharacterFrameExpandButton:Show()
		CharacterFrameExpandButton.collapseTooltip = L["Hide Pet Information"]
		CharacterFrameExpandButton.expandTooltip = L["Show Pet Information"]

		module:PaperDollFrame_UpdateStats()
	end)

	PetPaperDollFrame:HookScript2("OnHide", function(self)
		if PaperDollFrame:IsShown() then return end
		module:CharacterFrame_Collapse()

		CharacterFrameExpandButton:Hide()
	end)

	self:PaperDoll_InitStatCategories(PETPAPERDOLL_STATCATEGORY_DEFAULTORDER, E.db.enhanced.character.pet.orderName, E.db.enhanced.character.pet.collapsedName, "pet")

	self:RegisterEvent("ADDON_LOADED")
end

local function InitializeCallback()
	module:Initialize()
end

E:RegisterModule(module:GetName(), InitializeCallback)