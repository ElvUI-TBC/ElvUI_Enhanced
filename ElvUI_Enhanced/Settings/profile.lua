local E, L, V, P, G = unpack(ElvUI)

-- Minimap
P.general.minimap.locationText = "MOUSEOVER"

-- Unitframes
P.unitframe.units.player.portrait.detachFromFrame = false
P.unitframe.units.player.portrait.detachedWidth = 54
P.unitframe.units.player.portrait.detachedHeight = 54

P.unitframe.units.target.portrait.detachFromFrame = false
P.unitframe.units.target.portrait.detachedWidth = 54
P.unitframe.units.target.portrait.detachedHeight = 54

P.unitframe.units.player.animatedLoss = {
	enable = false,
	duration = .75,
	startDelay = .2,
	pauseDelay = .05,
	postponeDelay = .05
}

-- Enhanced
P.enhanced = {
	general = {
		pvpAutoRelease = false,
		autoRepChange = false,
		merchant = false,
		moverTransparancy = 1,
		showQuestLevel = false,
		selectQuestReward = false,
		declineduel = false,
		hideZoneText = false,
		originalCloseButton = false,
		trainAllButton = false,
		undressButton = false,
		alreadyKnown = false
	},
	actionbars = {
		equipped = false,
		equippedColor = {r = 0, g = 1.0, b = 0},
		transparentActionbars = {
			transparentBackdrops = false,
			transparentButtons = false
		}
	},
	chat = {
		dpsLinks = false,
	},
	character = {
		background = false,
		petBackground = false,
		inspectBackground = false,
		collapsed = false,
		player = {
			orderName = "",
			collapsedName = {
				ITEM_LEVEL = false,
				BASE_STATS = false,
				MELEE_COMBAT = false,
				RANGED_COMBAT = false,
				SPELL_COMBAT = false,
				DEFENSES = false,
				RESISTANCE = false
			}
		},
		pet = {
			orderName = "",
			collapsedName = {
				ITEM_LEVEL = false,
				BASE_STATS = false,
				MELEE_COMBAT = false,
				RANGED_COMBAT = false,
				SPELL_COMBAT = false,
				DEFENSES = false,
				RESISTANCE = false
			}
		}
	},
	datatexts = {
		timeColorEnch = false
	},
	equipment = {
		enable = false,
		font = "Homespun",
		fontSize = 10,
		fontOutline = "MONOCHROMEOUTLINE",
		durability = {
			enable = true,
			onlydamaged = true,
			position = "TOPLEFT",
			xOffset = 1,
			yOffset = 0
		},
		itemlevel = {
			enable = true,
			qualityColor = true,
			position = "BOTTOMLEFT",
			xOffset = 1,
			yOffset = 4
		}
	},
	minimap = {
		location = false,
		locationdigits = 1,
		hideincombat = false,
		fadeindelay = 5
	},
	nameplates = {
		smooth = false,
		smoothSpeed = 0.3
	},
	tooltip = {
		itemQualityBorderColor = false,
		tooltipIcon = {
			enable = false,
			tooltipIconSpells  = true,
			tooltipIconItems  = true,
		}
	},
	loseofcontrol = {
		CC = true,
		PvE = true,
		Silence = true,
		Disarm = true,
		Root = false,
		Snare = true
	},
	unitframe = {
		units = {
			target = {
				classicon = {
					enable = false,
					size = 28,
					xOffset = -58,
					yOffset = -22
				}
			}
		}
	},
	watchframe = {
		enable = false,
		city = "HIDDEN",
		pvp = "HIDDEN",
		arena = "HIDDEN",
		party = "HIDDEN",
		raid = "HIDDEN"
	},
	raidmarkerbar = {
		["enable"] = false,
		["backdrop"] = true,
		["transparentButtons"] = false,
		["transparentBackdrop"] = false,
		["buttonSize"] = 22,
		["spacing"] = 1,
		["orientation"] = "HORIZONTAL",
		["reverse"] = false,
		["visibility"] = "DEFAULT",
		["customVisibility"] = "[noexists, nogroup] hide;show"
	}
}