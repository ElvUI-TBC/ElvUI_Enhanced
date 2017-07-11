local E, L, V, P, G, _ = unpack(ElvUI);
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
-- Death Knight
	[SpellName(47481)] = "CC",		-- Gnaw (Ghoul)
	[SpellName(49203)] = "CC",		-- Hungering Cold
	[SpellName(91797)] = "CC",		-- Monstrous Blow (Super ghoul)
	[SpellName(47476)] = "Silence",	-- Strangulate
	[SpellName(45524)] = "Snare",	-- Chains of Ice
	[SpellName(55666)] = "Snare",	-- Desecration
	[SpellName(50040)] = "Snare",	-- Chilblains
-- Druid
	[SpellName(5211)]  = "CC",		-- Bash (also Shaman Spirit Wolf ability)
	[SpellName(33786)] = "CC",		-- Cyclone
	[SpellName(2637)]  = "CC",		-- Hibernate
	[SpellName(22570)] = "CC",		-- Maim
	[SpellName(9005)]  = "CC",		-- Pounce
	[SpellName(81261)] = "Silence",	-- Solar Beam
	[SpellName(339)]   = "Root",	-- Entangling Roots
	[SpellName(45334)] = "Root",	-- Feral Charge Effect
	[SpellName(58179)] = "Snare",	-- Infected Wounds
	[SpellName(61391)] = "Snare",	-- Typhoon
-- Hunter
	[SpellName(3355)]  = "CC",		-- Freezing Trap Effect
	[SpellName(24394)] = "CC",		-- Intimidation
	[SpellName(1513)]  = "CC",		-- Scare Beast
	[SpellName(19503)] = "CC",		-- Scatter Shot
	[SpellName(19386)] = "CC",		-- Wyvern Sting
	[SpellName(34490)] = "Silence",	-- Silencing Shot
	[SpellName(19306)] = "Root",	-- Counterattack
	[SpellName(19185)] = "Root",	-- Entrapment
	[SpellName(35101)] = "Snare",	-- Concussive Barrage
	[SpellName(5116)]  = "Snare",	-- Concussive Shot
	[SpellName(13810)] = "Snare",	-- Frost Trap Aura
	[SpellName(61394)] = "Snare",	-- Glyph of Freezing Trap
	[SpellName(2974)]  = "Snare",	-- Wing Clip
-- Hunter Pets
	[SpellName(50519)] = "CC",		-- Sonic Blast (Bat)
	[SpellName(90337)] = "CC",		-- Bad Manner (Monkey)
	[SpellName(50541)] = "Disarm",	-- Snatch (Bird of Prey)
	[SpellName(54706)] = "Root",	-- Venom Web Spray (Silithid)
	[SpellName(4167)]  = "Root",	-- Web (Spider)
	[SpellName(50245)] = "Root",	-- Pin (Crab)
	[SpellName(54644)] = "Snare",	-- Froststorm Breath (Chimera)
	[SpellName(50271)] = "Snare",	-- Tendon Rip (Hyena)
-- Mage
	[SpellName(44572)] = "CC",		-- Deep Freeze
	[SpellName(31661)] = "CC",		-- Dragon"s Breath
	[SpellName(12355)] = "CC",		-- Impact
	[SpellName(83047)] = "CC",		-- Improved Polymorph
	[SpellName(118)]   = "CC",		-- Polymorph
	[SpellName(82691)] = "CC",		-- Ring of Frost
	[SpellName(18469)] = "Silence",	-- Silenced - Improved Counterspell
	[SpellName(64346)] = "Disarm",	-- Fiery Payback
	[SpellName(33395)] = "Root",	-- Freeze (Water Elemental)
	[SpellName(122)]   = "Root",	-- Frost Nova
	[SpellName(83302)] = "Root",	-- Improved Cone of Cold
	[SpellName(55080)] = "Root",	-- Shattered Barrier
	[SpellName(11113)] = "Snare",	-- Blast Wave
	[SpellName(6136)]  = "Snare",	-- Chilled (generic effect, used by lots of spells [looks weird on Improved Blizzard, might want to comment out])
	[SpellName(120)]   = "Snare",	-- Cone of Cold
	[SpellName(116)]   = "Snare",	-- Frostbolt
	[SpellName(44614)] = "Snare",	-- Frostfire Bolt
	[SpellName(31589)] = "Snare",	-- Slow
-- Paladin
	[SpellName(853)]   = "CC",		-- Hammer of Justice
	[SpellName(2812)]  = "CC",		-- Holy Wrath
	[SpellName(20066)] = "CC",		-- Repentance
	[SpellName(10326)] = "CC",		-- Turn Evil
	[SpellName(31935)] = "Silence",	-- Avenger's Shield
	[SpellName(63529)] = "Snare",	-- Dazed - Avenger's Shield
	[SpellName(20170)] = "Snare",	-- Seal of Justice (100% movement snare; druids and shamans might want this though)
-- Priest
	[SpellName(605)]   = "CC",		-- Mind Control
	[SpellName(64044)] = "CC",		-- Psychic Horror
	[SpellName(8122)]  = "CC",		-- Psychic Scream
	[SpellName(9484)]  = "CC",		-- Shackle Undead
	[SpellName(87204)] = "CC",		-- Sin and Punishment
	[SpellName(15487)] = "Silence",	-- Silence
	[SpellName(64058)] = "Disarm",	-- Psychic Horror
	[SpellName(87194)] = "Root",	-- Paralysis
	[SpellName(15407)] = "Snare",	-- Mind Flay
-- Rogue
	[SpellName(2094)]  = "CC",		-- Blind
	[SpellName(1833)]  = "CC",		-- Cheap Shot
	[SpellName(1776)]  = "CC",		-- Gouge
	[SpellName(408)]   = "CC",		-- Kidney Shot
	[SpellName(6770)]  = "CC",		-- Sap
	[SpellName(76577)] = "CC",		-- Smoke Bomb
	[SpellName(1330)]  = "Silence",	-- Garrote - Silence
	[SpellName(18425)] = "Silence",	-- Silenced - Improved Kick
	[SpellName(51722)] = "Disarm",	-- Dismantle
	[SpellName(31125)] = "Snare",	-- Blade Twisting
	[SpellName(3409)]  = "Snare",	-- Crippling Poison
	[SpellName(26679)] = "Snare",	-- Deadly Throw
-- Shaman
	[SpellName(76780)] = "CC",		-- Bind Elemental
	[SpellName(61882)] = "CC",		-- Earthquake
	[SpellName(51514)] = "CC",		-- Hex
	[SpellName(39796)] = "CC",		-- Stoneclaw Stun
	[SpellName(64695)] = "Root",	-- Earthgrab (Earth"s Grasp)
	[SpellName(63685)] = "Root",	-- Freeze (Frozen Power)
	[SpellName(3600)]  = "Snare",	-- Earthbind (5 second duration per pulse, but will keep re-applying the debuff as long as you stand within the pulse radius)
	[SpellName(8056)]  = "Snare",	-- Frost Shock
	[SpellName(8034)]  = "Snare",	-- Frostbrand Attack
-- Warlock
	[SpellName(93986)] = "CC",		-- Aura of Foreboding
	[SpellName(89766)] = "CC",		-- Axe Toss (Felguard)
	[SpellName(710)]   = "CC",		-- Banish
	[SpellName(6789)]  = "CC",		-- Death Coil
	[SpellName(54786)] = "CC",		-- Demon Leap
	[SpellName(5782)]  = "CC",		-- Fear
	[SpellName(5484)]  = "CC",		-- Howl of Terror
	[SpellName(6358)]  = "CC",		-- Seduction (Succubus)
	[SpellName(30283)] = "CC",		-- Shadowfury
	[SpellName(24259)] = "Silence",	-- Spell Lock (Felhunter)
	[SpellName(31117)] = "Silence",	-- Unstable Affliction
	[SpellName(93974)] = "Root",	-- Aura of Foreboding
	[SpellName(18118)] = "Snare",	-- Aftermath
	[SpellName(18223)] = "Snare",	-- Curse of Exhaustion
	[SpellName(63311)] = "Snare",	-- Shadowsnare (Glyph of Shadowflame)
-- Warrior
	[SpellName(7922)]  = "CC",		-- Charge Stun
	[SpellName(12809)] = "CC",		-- Concussion Blow
	[SpellName(6544)]  = "CC",		-- Heroic Leap
	[SpellName(20253)] = "CC",		-- Intercept
	[SpellName(5246)]  = "CC",		-- Intimidating Shout
	[SpellName(46968)] = "CC",		-- Shockwave
	[SpellName(85388)] = "CC",		-- Throwdown
	[SpellName(18498)] = "Silence",	-- Silenced - Gag Order
	[SpellName(676)]   = "Disarm",	-- Disarm
	[SpellName(23694)] = "Root",	-- Improved Hamstring
	[SpellName(1715)]  = "Snare",	-- Hamstring
	[SpellName(12323)] = "Snare",	-- Piercing Howl
-- Other
	[SpellName(30217)] = "CC",		-- Adamantite Grenade
	[SpellName(67769)] = "CC",		-- Cobalt Frag Bomb
	[SpellName(30216)] = "CC",		-- Fel Iron Bomb
	[SpellName(13327)] = "CC",		-- Reckless Charge
	[SpellName(56)]    = "CC",		-- Stun
	[SpellName(20549)] = "CC",		-- War Stomp
	[SpellName(25046)] = "Silence",	-- Arcane Torrent
	[SpellName(39965)] = "Root",	-- Frost Grenade
	[SpellName(55536)] = "Root",	-- Frostweave Net
	[SpellName(13099)] = "Root",	-- Net-o-Matic
	[SpellName(29703)] = "Snare",	-- Dazed
-- PvE
	[SpellName(11428)] = "PvE",		-- Knockdown (generic)
	[SpellName(28169)] = "PvE",		-- Mutating Injection (Grobbulus)
	[SpellName(28059)] = "PvE",		-- Positive Charge (Thaddius)
	[SpellName(28084)] = "PvE",		-- Negative Charge (Thaddius)
	[SpellName(27819)] = "PvE",		-- Detonate Mana (Kel'Thuzad)
	[SpellName(63024)] = "PvE",		-- Gravity Bomb (XT-002 Deconstructor)
	[SpellName(63018)] = "PvE",		-- Light Bomb (XT-002 Deconstructor)
	[SpellName(62589)] = "PvE",		-- Nature's Fury (Freya, via Ancient Conservator)
	[SpellName(63276)] = "PvE",		-- Mark of the Faceless (General Vezax)
	[SpellName(66770)] = "PvE",		-- Ferocious Butt (Icehowl)
	[SpellName(71340)] = "PvE",		-- Pact of the Darkfallen  (Blood-Queen Lana'thel)
	[SpellName(70126)] = "PvE"		-- Frost Beacon  (Sindragosa)
};

local abilities = {};

function LOS:OnUpdate(elapsed)
	if(self.timeLeft) then
		self.timeLeft = self.timeLeft - elapsed;

		if(self.timeLeft >= 10) then
			self.NumberText:SetFormattedText("%d", self.timeLeft);
		elseif(self.timeLeft < 9.95) then
			self.NumberText:SetFormattedText("%.1f", self.timeLeft);
		end
	end
end

function LOS:UNIT_AURA()
	local maxExpirationTime = 0;
	local Icon, Duration;

	for i = 1, 40 do
		local name, _, icon, _, _, duration, expirationTime = UnitDebuff("player", i);

		if(E.db.enhanced.loseofcontrol[abilities[name]] and expirationTime > maxExpirationTime) then
			maxExpirationTime = expirationTime;
			Icon = icon;
			Duration = duration;

			self.AbilityName:SetText(name);
		end
	end

	if(maxExpirationTime == 0) then
		self.maxExpirationTime = 0;
		self.frame.timeLeft = nil;
		self.frame:SetScript("OnUpdate", nil);
		self.frame:Hide();
	elseif(maxExpirationTime ~= self.maxExpirationTime) then
		self.maxExpirationTime = maxExpirationTime;

		self.Icon:SetTexture(Icon);

		self.Cooldown:SetCooldown(maxExpirationTime - Duration, Duration);

		local timeLeft = maxExpirationTime - GetTime();
		if(not self.frame.timeLeft) then
			self.frame.timeLeft = timeLeft;

			self.frame:SetScript("OnUpdate", self.OnUpdate);
		else
			self.frame.timeLeft = timeLeft;
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