local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "deDE")
if not L then return end

-- DESC locales
L["ENH_LOGIN_MSG"] = "Sie verwenden |cff1784d1ElvUI|r |cff1784d1Enhanced|r |cffff8000(TBC)|r Version %s%s|r."
L["EQUIPMENT_DESC"] = "Passen Sie die Einstellungen für das Ändern Ihrer Ausrüstung an, wenn Sie Ihre Talentspezialisierung ändern oder ein Schlachtfeld betreten."
L["DURABILITY_DESC"] = "Passen Sie die Einstellungen für die Haltbarkeit im Charakterfenster an."
L["ITEMLEVEL_DESC"] = "Passen Sie die Einstellungen für die Anzeige von Gegenstandsstufen im Charakterfenster an."
L["WATCHFRAME_DESC"] = "Adjust the settings for the visibility of the watchframe (questlog) to your personal preference."

-- Actionbars
L["Sets actionbars' backgrounds to transparent template."] = "Setzt den Aktionsleisten Hintergrund transparent."
L["Sets actionbars buttons' backgrounds to transparent template."] = "Setzt die Aktionsleisten Tasten transparent."
L["Transparent ActionBars"] = true;
L["Transparent Backdrop"] = "Transparenter Hintergrund"
L["Transparent Buttons"] = "Transparente Tasten"

-- Animated Loss
L["Animated Loss"] = true;
L["Pause Delay"] = true;
L["Start Delay"] = true;
L["Postpone Delay"] = true;

-- Chat
L["Replaces long reports from damage meters with a clickeble hyperlink to reduce chat spam."] = "Ersetzt lange Berichte von Damage Metern mit einem klickbaren Hyperlink um Chatspam zu vermeiden."

-- Character Frame
L["Damaged Only"] = "Nur Beschädigte"
L["Enable/Disable the display of durability information on the character screen."] = "Anzeige der Haltbarkeit im Charakterfenster."
L["Enable/Disable the display of item levels on the character screen."] = "Anzeige von Gegenstandsstufen im Charakterfenster aktivieren / deaktivieren."
L["Enhanced Character Frame"] = true;
L["Equipment"] = "Ausrüstung"
L["Inspect Paperdoll Background"] = true;
L["Only show durabitlity information for items that are damaged."] = "Nur die Haltbarkeit für beschädigte Ausrüstungsteile anzeigen."
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
L["New Mail"] = "Neue Post"
L["No Mail"] = "Keine Post"
L["Out of Combat"] = true;
L["Reincarnation"] = true;
L["Target Range"] = true;
L["Total"] = "Gesamt"
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
L["Death Recap"] = "Todesursache"
L["Killing blow at %s%% health."] = true;
L["Recap"] = true;
L["You died."] = true;

-- Decline Duels
L["Auto decline all duels"] = true;
L["Decline Duel"] = true;
L["Declined duel request from "] = "Duellaufforderung abgelehnt von "

-- General
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "Ändere automatisch die beobachtete Fraktion auf der Erfahrungsleiste zu der Fraktion für die Sie grade Rufpunkte erhalten haben."
L["Automatically release body when killed inside a battleground."] = "Gibt automatisch Ihren Geist frei, wenn Sie auf dem Schlachtfeld getötet wurden."
L["Automatically select the quest reward with the highest vendor sell value."] = "Wählt automatisch die Questbelohnung mit dem höchsten Wiederverkaufswert beim Händler"
L["Changes the transparency of all the movers."] = "Konfiguriere die Einstellungen der Transparenz der Ankerpukte"
L["Colorizes recipes, mounts & pets that are already known"] = true;
L["Display quest levels at Quest Log."] = true;
L["Hide Zone Text"] = true;
L["Mover Transparency"] = "Transparenz Ankerpunkte"
L["Original Close Button"] = true;
L["PvP Autorelease"] = "Automatische Freigabe im PvP"
L["Show Quest Level"] = true;
L["Track Reputation"] = "Ruf beobachten"

-- Model Frames
L["Drag"] = "Ziehen"
L["Left-click on character and drag to rotate."] = "Linksklicken und ziehen, um den Charakter zu drehen."
L["Model Frames"] = true;
L["Mouse Wheel Down"] = "Mausrad nach unten"
L["Mouse Wheel Up"] = "Mausrad nach oben"
L["Right-click on character and drag to move it within the window."] = "Rechtsklicken und ziehen, um den Charakter im Fenster zu verschieben."
L["Rotate Left"] = "Linksdrehung"
L["Rotate Right"] = "Rechtsdrehung"
L["Zoom In"] = "Hereinzoomen"
L["Zoom Out"] = "Herauszoomen"

-- Nameplates
L["Bars will transition smoothly."] = true;
L["Smooth Bars"] = true;

-- Minimap
L["Above Minimap"] = "Oberhalb der Minimap"
L["FadeIn Delay"] = "Einblendungsverzögerung"
L["Hide minimap while in combat."] = "Ausblenden der Minimap während des Kampfes."
L["Location Digits"] = "Koordinaten Nachkommastellen"
L["Location Panel"] = true;
L["Number of digits for map location."] = "Anzahl der Nachkommastellen der Koordinaten."
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "Die Zeit vor dem wieder Einblenden der Minimap nach dem Kampf. (0 = deaktiviert)"
L["Toggle Location Panel."] = true;

-- Tooltip
L["Item Border Color"] = true
L["Colorize the tooltip border based on item quality."] = true
L["Show/Hides an Icon for Items on the Tooltip."] = "Icon für Gegenstände am Tooltip anzeigen oder ausblenden."
L["Show/Hides an Icon for Spells on the Tooltip."] = "Icon für Zauber am Tooltip anzeigen oder ausblenden."
L["Show/Hides an Icon for Spells and Items on the Tooltip."] = "Icon für Zauber oder Gegenstände am Tooltip anzeigen oder ausblenden."
L["Tooltip Icon"] = true;

-- Misc
L["Skin Animations"] = true;
L["Undress"] = "Ausziehen"

-- Character Frame
L["Character Stats"] = true;
L["Damage Per Second"] = "DPS";
L["Hide Character Information"] = true;
L["Hide Pet Information"] = true;
L["Show Character Information"] = true;
L["Show Pet Information"] = true;

-- Movers
L["Loss Control Icon"] = "Kontrollverlustsymbol"
L["Player Portrait"] = true;
L["Target Portrait"] = true;

-- Loss Control
L["CC"] = "CC"
L["Disarm"] = "Entwaffnen"
L["Lose Control"] = true;
L["PvE"] = "PvE"
L["Root"] = "Wurzeln"
L["Silence"] = "Stille"
L["Snare"] = "Verlangsamung"

-- Unitframes
L["All role icons (Damage/Healer/Tank) on the unit frames are hidden when you go into combat."] = "Alle Rollensymbole (Schaden/Heiler/Tank) auf den Einheitenfenstern werden versteckt, wenn der Charakter sich im Kampf befindet."
L["Detached Height"] = true;
L["Hide Role Icon in combat"] = "Verstecke Rollensymbol im Kampf"
L["Show class icon for units."] = "Zeige Klassensymbole für Einheiten"

-- WatchFrame
L["Arena"] = "Arena"
L["City (Resting)"] = "Stadt (erholend)"
L["Hidden"] = "Versteckt"
L["Party"] = "Gruppe"
L["PvP"] = "PvP"
L["Raid"] = "Schlachtzug"