local E, L, V, P, G = unpack(ElvUI);
local LOS = E:NewModule("LoseOfControl", "AceEvent-3.0");
local LSM = LibStub("LibSharedMedia-3.0");

local function SpellName(id)
	local name, _, _, _, _, _, _, _, _ = GetSpellInfo(id)
	if(not name) then
		print('|cff1784d1ElvUI:|r SpellID is not valid: '..id..'. Please check for an updated version, if none exists report to ElvUI author.')
		return "Impale"
	else
		return name
	end
end

G.loseofcontrol = {
-- Druid
	[SpellName(8983)]  = "CC",		-- Bash (also Shaman Spirit Wolf ability)
	[SpellName(33786)] = "CC",		-- Cyclone
	[SpellName(18658)] = "CC",		-- Hibernate
	[SpellName(22570)] = "CC",		-- Maim
	[SpellName(27006)] = "CC",		-- Pounce
	[SpellName(16922)] = "CC",		-- Starfire Stun
	[SpellName(339)]   = "Root",	-- Entangling Roots
	[SpellName(19675)] = "Root",	-- Feral Charge Effect
-- Hunter
	[SpellName(27753)] = "CC",		-- Freezing Trap Effect
	[SpellName(19577)] = "CC",		-- Intimidation
	[SpellName(14327)] = "CC",		-- Scare Beast
	[SpellName(19503)] = "CC",		-- Scatter Shot
	[SpellName(27068)] = "CC",		-- Wyvern Sting
	[SpellName(19410)] = "CC",		-- Improved Concussive Shot
	[SpellName(34490)] = "Silence",	-- Silencing Shot
	[SpellName(19306)] = "Root",	-- Counterattack
	[SpellName(5116)]  = "Snare",	-- Concussive Shot
	[SpellName(13810)] = "Snare",	-- Frost Trap Aura
	[SpellName(2974)]  = "Snare",	-- Wing Clip
-- Hunter Pets
	[SpellName(4167)]  = "Root",	-- Web (Spider)
-- Mage
	[SpellName(33043)] = "CC",		-- Dragon"s Breath
	[SpellName(11103)] = "CC",		-- Impact
	[SpellName(44301)] = "CC",		-- Improved Polymorph
	[SpellName(44302)] = "CC",		-- Improved Polymorph
	[SpellName(12826)] = "CC",		-- Polymorph
	[SpellName(18469)] = "Silence",	-- Silenced - Improved Counterspell
	[SpellName(33395)] = "Root",	-- Freeze (Water Elemental)
	[SpellName(10230)] = "Root",	-- Frost Nova
	[SpellName(11113)] = "Snare",	-- Blast Wave
	[SpellName(6136)]  = "Snare",	-- Chilled (generic effect, used by lots of spells [looks weird on Improved Blizzard, might want to comment out])
	[SpellName(120)]   = "Snare",	-- Cone of Cold
	[SpellName(116)]   = "Snare",	-- Frostbolt
	[SpellName(31589)] = "Snare",	-- Slow
-- Paladin
	[SpellName(10308)] = "CC",		-- Hammer of Justice
	[SpellName(20066)] = "CC",		-- Repentance
	[SpellName(10326)] = "CC",		-- Turn Evil
	[SpellName(20164)] = "Snare",	-- Seal of Justice (100% movement snare; druids and shamans might want this though)
-- Priest
	[SpellName(10912)] = "CC",		-- Mind Control
	[SpellName(10890)] = "CC",		-- Psychic Scream
	[SpellName(9484)]  = "CC",		-- Shackle Undead
	[SpellName(15487)] = "Silence",	-- Silence
	[SpellName(15407)] = "Snare",	-- Mind Flay
-- Rogue
	[SpellName(2094)]  = "CC",		-- Blind
	[SpellName(1833)]  = "CC",		-- Cheap Shot
	[SpellName(38764)] = "CC",		-- Gouge
	[SpellName(8643)]  = "CC",		-- Kidney Shot
	[SpellName(11297)] = "CC",		-- Sap
	[SpellName(1330)]  = "Silence",	-- Garrote - Silence
	[SpellName(13754)] = "Silence",	-- Silenced - Improved Kick
	[SpellName(31124)] = "Snare",	-- Blade Twisting
	[SpellName(3409)]  = "Snare",	-- Crippling Poison
	[SpellName(26679)] = "Snare",	-- Deadly Throw
-- Shaman
	[SpellName(39796)] = "CC",		-- Stoneclaw Stun
	[SpellName(3600)]  = "Snare",	-- Earthbind (5 second duration per pulse, but will keep re-applying the debuff as long as you stand within the pulse radius)
	[SpellName(8056)]  = "Snare",	-- Frost Shock
	[SpellName(8034)]  = "Snare",	-- Frostbrand Attack
-- Warlock
	[SpellName(27223)] = "CC",		-- Death Coil
	[SpellName(6215)]  = "CC",		-- Fear
	[SpellName(17928)] = "CC",		-- Howl of Terror
	[SpellName(6358)]  = "CC",		-- Seduction (Succubus)
	[SpellName(30414)] = "CC",		-- Shadowfury
	[SpellName(19244)] = "Silence",	-- Spell Lock (Felhunter)
	[SpellName(30108)] = "Silence",	-- Unstable Affliction
	[SpellName(18118)] = "Snare",	-- Aftermath
	[SpellName(18223)] = "Snare",	-- Curse of Exhaustion
-- Warrior
	[SpellName(7922)]  = "CC",		-- Charge Stun
	[SpellName(12809)] = "CC",		-- Concussion Blow
	[SpellName(25274)] = "CC",		-- Intercept
	[SpellName(5246)]  = "CC",		-- Intimidating Shout
	[SpellName(676)]   = "Disarm",	-- Disarm
	[SpellName(12289)] = "Root",	-- Improved Hamstring
	[SpellName(1715)]  = "Snare",	-- Hamstring
	[SpellName(12323)] = "Snare",	-- Piercing Howl
-- Other
	[SpellName(30217)] = "CC",		-- Adamantite Grenade
	[SpellName(30216)] = "CC",		-- Fel Iron Bomb
	[SpellName(13327)] = "CC",		-- Reckless Charge
	[SpellName(56)]    = "CC",		-- Stun
	[SpellName(19482)] = "CC",		-- War Stomp
	[SpellName(25046)] = "Silence",	-- Arcane Torrent
	[SpellName(39965)] = "Root",	-- Frost Grenade
	[SpellName(13099)] = "Root",	-- Net-o-Matic
	[SpellName(29703)] = "Snare",	-- Dazed
-- PvE
	[SpellName(11428)] = "PvE",		-- Knockdown (generic)
};

local abilities = {};

function LOS:OnUpdate(elapsed)
	if(self.timeLeft) then
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= 0.01 then
			local _, _, _, _, _, duration, timeLeft = UnitAura("player", self.index, "HARMFUL")
			if timeLeft and timeLeft > self.timeLeft then
				LOS.Cooldown:SetCooldown(GetTime() + (timeLeft - duration), duration)
			end
			self.timeLeft = timeLeft
			if(timeLeft >= 10) then
				self.NumberText:SetFormattedText("%d", timeLeft)
			elseif(timeLeft < 9.95) then
				self.NumberText:SetFormattedText("%.1f", timeLeft)
			end
			self.elapsed = 0
		end
	end
end

function LOS:UNIT_AURA()
	local maxExpirationTime = 0;
	local Icon, Duration, Index;

	for i = 1, 40 do
		local name, _, icon, _, _, duration, expirationTime = UnitAura("player", i, "HARMFUL");

		if(E.db.enhanced.loseofcontrol[abilities[name]] and expirationTime > maxExpirationTime) then
			maxExpirationTime = expirationTime;
			Icon = icon;
			Duration = duration;
			Index = i;

			self.AbilityName:SetText(name);
		end
	end

	if(maxExpirationTime == 0) then
		self.maxExpirationTime = 0;
		self.frame.timeLeft = nil;
		self.frame.index = nil;
		self.frame:SetScript("OnUpdate", nil);
		self.frame:Hide();
	elseif(maxExpirationTime ~= self.maxExpirationTime) then
		self.maxExpirationTime = maxExpirationTime;
		self.frame.index = Index;

		self.Icon:SetTexture(Icon);

		self.Cooldown:SetCooldown(GetTime() + (maxExpirationTime - Duration), Duration);

		if(not self.frame.timeLeft) then
			self.frame.timeLeft = maxExpirationTime;

			self.frame:SetScript("OnUpdate", self.OnUpdate);
		else
			self.frame.timeLeft = maxExpirationTime;
		end

		self.frame:Show();
	end
end

function LOS:Initialize()
	if(not E.private.loseofcontrol.enable) then return; end

	self.frame = CreateFrame("Frame", "ElvUI_LoseOfControlFrame", UIParent);
	self.frame:Point("CENTER", 0, 0);
	self.frame:Size(54);
	self.frame:SetTemplate();
	self.frame:Hide();

	for name, v in pairs(G.loseofcontrol) do
		if(name) then
			abilities[name] = v;
		end
	end

	E:CreateMover(self.frame, "LossControlMover", L["Loss Control Icon"]);

	self.Icon = self.frame:CreateTexture(nil, "ARTWORK");
	self.Icon:SetInside();
	self.Icon:SetTexCoord(.1, .9, .1, .9);

	self.AbilityName = self.frame:CreateFontString(nil, "OVERLAY");
	self.AbilityName:FontTemplate(E["media"].normFont, 20, "OUTLINE");
	self.AbilityName:SetPoint("BOTTOM", self.frame, 0, -28);

	self.Cooldown = CreateFrame("Cooldown", self.frame:GetName().."Cooldown", self.frame, "CooldownFrameTemplate");
	self.Cooldown:SetInside();

	self.frame.NumberText = self.frame:CreateFontString(nil, "OVERLAY");
	self.frame.NumberText:FontTemplate(E["media"].normFont, 20, "OUTLINE");
	self.frame.NumberText:SetPoint("BOTTOM", self.frame, 0, -58);

	self.SecondsText = self.frame:CreateFontString(nil, "OVERLAY");
	self.SecondsText:FontTemplate(E["media"].normFont, 20, "OUTLINE");
	self.SecondsText:SetPoint("BOTTOM", self.frame, 0, -80);
	self.SecondsText:SetText(L["seconds"]);

	self:RegisterEvent("UNIT_AURA");
end

local function InitializeCallback()
	LOS:Initialize()
end

E:RegisterModule(LOS:GetName(), InitializeCallback)