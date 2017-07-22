local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("ElvUI", "frFR");
if not L then return; end

-- DESC locales
L["ENH_LOGIN_MSG"] = "Vous utilisez |cff1784d1ElvUI|r |cff1784d1Enhanced|r |cffff8000(TBC)|r version %s%s|r."
L["EQUIPMENT_DESC"] = "Ajustez les réglages pour passer d'un équipement à l'autre lorsque vous changez de spécialisation ou lorsque que vous effectuez un Champs de Bataille."
L["DURABILITY_DESC"] = "Ajustez les réglages pour afficher la durabilité sur l'écran d'infos de personnage."
L["ITEMLEVEL_DESC"] = "Réglez les paramètres pour afficher le niveau d'objet sur l'écran d'infos de personnage."
L["WATCHFRAME_DESC"] = "Adjust the settings for the visibility of the watchframe (questlog) to your personal preference."

-- Actionbars
L["Sets actionbars' backgrounds to transparent template."] = true;
L["Sets actionbars buttons' backgrounds to transparent template."] = true;
L["Transparent ActionBars"] = true;
L["Transparent Backdrop"] = true;
L["Transparent Buttons"] = true;

-- Animated Loss
L["Animated Loss"] = true;
L["Pause Delay"] = true;
L["Start Delay"] = true;
L["Postpone Delay"] = true;

-- Chat
L["Replaces long reports from damage meters with a clickeble hyperlink to reduce chat spam."] = true;

-- Character Frame
L["Damaged Only"] = "Dégâts seulement"
L["Enable/Disable the display of durability information on the character screen."] = "Activer / Désactiver l'affichage des informations de durabilité sur l'écran d'infos de personnage."
L["Enable/Disable the display of item levels on the character screen."] = "Activer / Désactiver l'affichage des informations du niveau d'objet sur l'écran d'infos de personnage."
L["Enhanced Character Frame"] = true;
L["Equipment"] = "Équipement"
L["Inspect Paperdoll Background"] = true;
L["Only show durabitlity information for items that are damaged."] = "Afficher la durabilité seulement quand l'équipement est endommagé."
L["Paperdoll Background"] = true;
L["Pet Paperdoll Background"] = true;
L["Quality Color"] = true;

-- Datatext
L["Combat Indicator"] = true;
L["Datatext Disabled"] = true;
L["Distance"] = true;
L["Enhanced Time Color"] = true;
L["Equipped"] = true;
L["In Combat"] = true;
L["New Mail"] = true;
L["No Mail"] = true;
L["Out of Combat"] = true;
L["Reincarnation"] = true;
L["Target Range"] = true;
L["Total"] = true;
L["You are not playing a |cff0070DEShaman|r, datatext disabled."] = true;

-- Death Recap
L["%s %s"] = true;
L["%s by %s"] = true;
L["%s sec before death at %s%% health."] = true;
L["(%d Absorbed)"] = true;
L["(%d Blocked)"] = true;
L["(%d Overkill)"] = true;
L["(%d Resisted)"] = true;
L["Death Recap unavailable."] = true;
L["Death Recap"] = "Récapitulatif lors de la mort"
L["Killing blow at %s%% health."] = true;
L["Recap"] = true;
L["You died."] = true;

-- Decline Duels
L["Auto decline all duels"] = true;
L["Decline Duel"] = true;
L["Declined duel request from "] = "Décliné les invites en duel de "

-- General
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "Change automatiquement la réputation suivie sur la barre de réputation avec la faction que vous êtes en train de faire."
L["Automatically release body when killed inside a battleground."] = "Libère automatiquement votre corps quand vous êtes tué en Champs de Bataille."
L["Automatically select the quest reward with the highest vendor sell value."] = "Sélectionne automatiquement la récompense de quête qui vaut la plus chère chez le vendeur."
L["Changes the transparency of all the movers."] = "Change la transparence des Ancres"
L["Colorizes recipes, mounts & pets that are already known"] = true;
L["Display quest levels at Quest Log."] = true;
L["Hide Zone Text"] = true;
L["Mover Transparency"] = "Transparence des Ancres"
L["Original Close Button"] = true;
L["PvP Autorelease"] = "Libération automatique en PVP"
L["Show Quest Level"] = true;
L["Track Reputation"] = "Suivre la Réputation"

-- Model Frames
L["Drag"] = true;
L["Left-click on character and drag to rotate."] = true;
L["Model Frames"] = true;
L["Mouse Wheel Down"] = true;
L["Mouse Wheel Up"] = true;
L["Right-click on character and drag to move it within the window."] = true;
L["Rotate Left"] = true;
L["Rotate Right"] = true;
L["Zoom In"] = true;
L["Zoom Out"] = true;

-- Nameplates
L["Bars will transition smoothly."] = true;
L["Smooth Bars"] = true;

-- Minimap
L["Above Minimap"] = "Sous la minicarte"
L["FadeIn Delay"] = "Délais d'estompage"
L["Hide minimap while in combat."] = "Cacher la minicarte quand vous êtes en combat"
L["Location Digits"] = "Chiffres d'emplacement"
L["Location Panel"] = true;
L["Number of digits for map location."] = "Nombre de chiffres pour l'emplacement."
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "Le temps à attendre avant que la minicarte s'estompe avec que le combat ait commencé. (0 = désactié)"
L["Toggle Location Panel."] = true;

-- Tooltip
L["Item Border Color"] = true
L["Colorize the tooltip border based on item quality."] = true
L["Show/Hides an Icon for Items on the Tooltip."] = true;
L["Show/Hides an Icon for Spells on the Tooltip."] = true;
L["Show/Hides an Icon for Spells and Items on the Tooltip."] = true;
L["Tooltip Icon"] = true;

-- Misc
L["Skin Animations"] = true;
L["Undress"] = "Déshabillé"

-- Character Frame
L["Character Stats"] = true;
L["Damage Per Second"] = "DPS";
L["Hide Character Information"] = true;
L["Hide Pet Information"] = true;
L["Show Character Information"] = true;
L["Show Pet Information"] = true;

-- Movers
L["Loss Control Icon"] = "Icône de la perte de contrôle"
L["Player Portrait"] = true;
L["Target Portrait"] = true;

-- Loss Control
L["CC"] = "CC"
L["Disarm"] = "Désarmement"
L["Lose Control"] = true;
L["PvE"] = "PvE"
L["Root"] = "Immobilisation"
L["Silence"] = "Silence"
L["Snare"] = "Ralentissement"

-- Unitframes
L["All role icons (Damage/Healer/Tank) on the unit frames are hidden when you go into combat."] = "Cachez toutes les icônes de rôle (Dommages/Healer/Tank) sur les cadres d'unité quand vous serait en combat."
L["Detached Height"] = true;
L["Hide Role Icon in combat"] = "Cachez les icônes de rôle en combat"
L["Show class icon for units."] = true;

-- WatchFrame
L["Hidden"] = "Caché"
L["City (Resting)"] = "Ville (repos)"
L["PvP"] = "PvP"
L["Arena"] = "Arêne"
L["Party"] = "Groupe"
L["Raid"] = "Raid"