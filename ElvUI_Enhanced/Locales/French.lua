local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "frFR")
if not L then return end

-- DESC locales
L["ENH_LOGIN_MSG"] = "Vous utilisez |cff1784d1ElvUI|r |cff1784d1Enhanced|r |cffff8000(TBC)|r version %s%s|r."
L["EQUIPMENT_DESC"] = "Ajustez les réglages pour passer d'un équipement à l'autre lorsque vous changez de spécialisation ou lorsque que vous effectuez un Champs de Bataille."
L["DURABILITY_DESC"] = "Ajustez les réglages pour afficher la durabilité sur l'écran d'infos de personnage."
L["ITEMLEVEL_DESC"] = "Réglez les paramètres pour afficher le niveau d'objet sur l'écran d'infos de personnage."
L["WATCHFRAME_DESC"] = "Adjust the settings for the visibility of the watchframe (questlog) to your personal preference."

-- Actionbars
L["AutoCast Border"] = true
L["Checked Border"] = true
L["Equipped Item Border"] = true
L["Sets actionbars backgrounds to transparent template."] = true
L["Sets actionbars buttons backgrounds to transparent template."] = true
L["Replaces the checked textures with colored borders."] = true
L["Replaces the auto cast textures with colored borders."] = true
L["Transparent ActionBars"] = true
L["Transparent Backdrop"] = true
L["Transparent Buttons"] = true

-- AddOn List
L["Enable All"] = true
L["Dependencies: "] = true
L["Disable All"] = true
L["Load AddOn"] = true
L["Requires Reload"] = true

-- Animated Loss
L["Animated Loss"] = true
L["Pause Delay"] = true
L["Start Delay"] = true
L["Postpone Delay"] = true

-- Chat
L["Filter DPS meters Spam"] = true
L["Replaces long reports from damage meters with a clickable hyperlink to reduce chat spam.\nWorks correctly only with general reports such as DPS or HPS. May fail to filter te report of other things"] = true

-- Character Frame
L["Character"] = "Personnage"
L["Damaged Only"] = "Dégâts seulement"
L["Desaturate"] = true
L["Enable/Disable the display of durability information on the character screen."] = "Activer / Désactiver l'affichage des informations de durabilité sur l'écran d'infos de personnage."
L["Enable/Disable the display of item levels on the character screen."] = "Activer / Désactiver l'affichage des informations du niveau d'objet sur l'écran d'infos de personnage."
L["Enhanced Character Frame"] = true
L["Equipment"] = "Équipement"
L["Only show durabitlity information for items that are damaged."] = "Afficher la durabilité seulement quand l'équipement est endommagé."
L["Paperdoll Backgrounds"] = true
L["Pet"] = "Familier"
L["Quality Color"] = true

-- Datatext
L["Combat Indicator"] = true
L["DataText Color"] = true
L["Enhanced Time Color"] = true
L["Equipped"] = true
L["In Combat"] = true
L["New Mail"] = true
L["No Mail"] = true
L["Out of Combat"] = true
L["Reincarnation"] = true
L["Shards"] = true
L["Soul Shards"] = true
L["Target Range"] = true
L["Total"] = true
L["Value Color"] = true
L["You are not playing a |cff0070DEShaman|r, datatext disabled."] = true

-- Death Recap
L["%s %s"] = true
L["%s by %s"] = true
L["%s sec before death at %s%% health."] = true
L["(%d Absorbed)"] = true
L["(%d Blocked)"] = true
L["(%d Resisted)"] = true
L["Critical"] = true
L["Crushing"] = true
L["Death Recap unavailable."] = true
L["Death Recap"] = "Récapitulatif lors de la mort"
L["Killing blow at %s%% health."] = true
L["Recap"] = true
L["You died."] = true

-- Error Frame
L["Error Frame"] = true
L["Set the width of Error Frame. Too narrow frame may cause messages to be split in several lines"] = true
L["Set the height of Error Frame. Higher frame can show more lines at once."] = true

-- General
L["Add button to Dressing Room frame with ability to undress model."] = true
L["Add button to Trainer frame with ability to train all available skills in one click."] = true
L["Alt-Click Merchant"] = true
L["Already Known"] = true
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "Change automatiquement la réputation suivie sur la barre de réputation avec la faction que vous êtes en train de faire."
L["Automatically release body when killed inside a battleground."] = "Libère automatiquement votre corps quand vous êtes tué en Champs de Bataille."
L["Automatically select the quest reward with the highest vendor sell value."] = "Sélectionne automatiquement la récompense de quête qui vaut la plus chère chez le vendeur."
L["Auto decline all duels"] = true
L["Auto decline party invites"] = true
L["Changes the transparency of all the movers."] = "Change la transparence des Ancres"
L["Colorize the WorldMap party/raid icons with class colors"] = true
L["Colorizes recipes that are already known"] = true
L["Decline Duel"] = true
L["Decline Party"] = true
L["Declined duel request from "] = "Décliné les invites en duel de "
L["Declined party request from "] = true
L["Display the item level on the MerchantFrame, to change the font you have to set it in ElvUI - Bags - ItemLevel"] = true
L["Display the item level on the Quest frames, to change the font you have to set it in ElvUI - Bags - ItemLevel"] = true
L["Display quest levels at Quest Log."] = true
L["Hide Zone Text"] = true
L["Holding Alt key while buying something from vendor will now buy an entire stack."] = true
L["Merchant ItemLevel"] = true
L["Mover Transparency"] = "Transparence des Ancres"
L["Original Close Button"] = true
L["PvP Autorelease"] = "Libération automatique en PVP"
L["Quest ItemLevel"] = true
L["Select Quest Reward"] = true
L["Show Quest Level"] = true
L["Track Reputation"] = "Suivre la Réputation"
L["Train All Button"] = true
L["Undress Button"] = true
L["WorldMap Blips"] = true

-- Model Frames
L["Drag"] = "Glisser"
L["Left-click on character and drag to rotate."] = "Cliquez-gauche sur le personnage et faites glisser la souris pour le faire pivoter."
L["Model Frames"] = true
L["Mouse Wheel Down"] = "Molette vers le bas"
L["Mouse Wheel Up"] = "Molette vers le haut"
L["Right-click on character and drag to move it within the window."] = "Cliquez-droit sur le personnage et faites glisser la souris pour le déplacer."
L["Rotate Left"] = "Pivoter à gauche"
L["Rotate Right"] = "Pivoter à droite"

-- Nameplates
L["Bars will transition smoothly."] = true
L["Smooth Bars"] = true

-- Minimap
L["Above Minimap"] = "Sous la minicarte"
L["Always"] = "Toujours"
L["Combat Hide"] = true
L["FadeIn Delay"] = "Délais d'estompage"
L["Hide minimap while in combat."] = "Cacher la minicarte quand vous êtes en combat"
L["Location Digits"] = "Chiffres d'emplacement"
L["Location Panel"] = true
L["Number of digits for map location."] = "Nombre de chiffres pour l'emplacement."
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "Le temps à attendre avant que la minicarte s'estompe avec que le combat ait commencé. (0 = désactié)"
L["Toggle Location Panel."] = true

-- Tooltip
L["Item Border Color"] = true
L["Colorize the tooltip border based on item quality."] = true
L["Show/Hides an Icon for Items on the Tooltip."] = true
L["Show/Hides an Icon for Spells on the Tooltip."] = true
L["Show/Hides an Icon for Spells and Items on the Tooltip."] = true
L["Spells"] = "Sorts"
L["Tooltip Icon"] = true

-- Misc
L["Enhanced Frames"] = true
L["Miscellaneous"] = "Divers"
L["Skin Animations"] = true
L["Total cost:"] = true
L["Undress"] = "Déshabillé"

-- Character Frame
L["Character Stats"] = true
L["Damage Per Second"] = "DPS"
L["Hide Character Information"] = true
L["Hide Pet Information"] = true
L["Item Level"] = true
L["Resistance"] = "Résistance"
L["Show Character Information"] = true
L["Show Pet Information"] = true
L["Titles"] = "Titres"

-- Movers
L["Loss Control Icon"] = "Icône de la perte de contrôle"
L["Player Portrait"] = true
L["Target Portrait"] = true

-- Loss Control
L["CC"] = "CC"
L["Disarm"] = "Désarmement"
L["Lose Control"] = true
L["PvE"] = "PvE"
L["Root"] = "Immobilisation"
L["Silence"] = "Silence"
L["Snare"] = "Ralentissement"
L["Type"] = "Type"

-- Raid Marks
L["Raid Markers"] = true
L["Click to clear the mark."] = true
L["Click to mark the target."] = true
L["In Party"] = true
L["Raid Marker Bar"] = true
L["Reverse"] = true

-- Unitframes
L["Class Icons"] = true
L["Detached Height"] = true
L["Energy Tick"] = true
L["Show class icon for units."] = true
L["Target"] = "Cibler"

-- WatchFrame
L["Hidden"] = "Caché"
L["City (Resting)"] = "Ville (repos)"
L["PvP"] = "PvP"
L["Arena"] = "Arêne"
L["Party"] = "Groupe"
L["Raid"] = "Raid"