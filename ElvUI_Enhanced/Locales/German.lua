local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "deDE")
if not L then return end

-- DESC locales
L["ENH_LOGIN_MSG"] = "Sie verwenden |cff1784d1ElvUI|r |cff1784d1Enhanced|r |cffff8000(TBC)|r Version %s%s|r."
L["EQUIPMENT_DESC"] = "Passen Sie die Einstellungen für das Ändern Ihrer Ausrüstung an, wenn Sie Ihre Talentspezialisierung ändern oder ein Schlachtfeld betreten."
L["DURABILITY_DESC"] = "Passen Sie die Einstellungen für die Haltbarkeit im Charakterfenster an."
L["ITEMLEVEL_DESC"] = "Passen Sie die Einstellungen für die Anzeige von Gegenstandsstufen im Charakterfenster an."
L["WATCHFRAME_DESC"] = "Passen Sie die Einstellungen des Watchframe (Questlog) nach ihren Wünschen an."

-- Actionbars
L["AutoCast Border"] = true
L["Checked Border"] = true
L["Equipped Item Border"] = "Rahmen der angelegten Items"
L["Sets actionbars backgrounds to transparent template."] = "Setzt den Aktionsleisten Hintergrund transparent."
L["Sets actionbars buttons backgrounds to transparent template."] = "Setzt die Aktionsleisten-Tasten transparent."
L["Replaces the checked textures with colored borders."] = true
L["Replaces the auto cast textures with colored borders."] = true
L["Transparent ActionBars"] = "Transparente Aktionsleisten"
L["Transparent Backdrop"] = "Transparenter Hintergrund"
L["Transparent s"] = "Transparente Tasten"

-- AddOn List
L["Enable All"] = "Alle aktivieren"
L["Dependencies: "] = "Abhängigkeiten"
L["Disable All"] = "Alle deaktivieren"
L["Load AddOn"] = "Lade AddOn"
L["Requires Reload"] = "Benötigt Reload"

-- Animated Loss
L["Animated Loss"] = true
L["Pause Delay"] = true
L["Start Delay"] = true
L["Postpone Delay"] = true

-- Chat
L["Filter DPS meters Spam"] = "Spam von DPS-Metern filtern"
L["Replaces long reports from damage meters with a clickable hyperlink to reduce chat spam.\nWorks correctly only with general reports such as DPS or HPS. May fail to filter te report of other things"] = true

-- Character Frame
L["Character"] = "Charakter"
L["Damaged Only"] = "Nur Beschädigte"
L["Desaturate"] = true
L["Enable/Disable the display of durability information on the character screen."] = "Anzeige der Haltbarkeit im Charakterfenster."
L["Enable/Disable the display of item levels on the character screen."] = "Anzeige von Gegenstandsstufen im Charakterfenster aktivieren/deaktivieren."
L["Enhanced Character Frame"] = "Erweitertes Charakterfenster"
L["Equipment"] = "Ausrüstung"
L["Only show durabitlity information for items that are damaged."] = "Nur die Haltbarkeit für beschädigte Ausrüstungsteile anzeigen."
L["Paperdoll Backgrounds"] = "Paperdoll-Hintergrund"
L["Pet"] = "Begleiter"
L["Quality Color"] = "Qualitätsfarbe"

-- Datatext
L["Combat Indicator"] = "Kampfanzeige"
L["DataText Color"] = true
L["Enhanced Time Color"] = "Erweiterte Zeit-Färbung"
L["Equipped"] = "Angelegt"
L["In Combat"] = "Im Kampf"
L["New Mail"] = "Neue Post"
L["No Mail"] = "Keine Post"
L["Out of Combat"] = "Außerhalb des Kampfes"
L["Reincarnation"] = "Wiederbelebung"
L["Shards"] = "Splitter"
L["Soul Shards"] = "Seelensplitter"
L["Target Range"] = "Zielreichweite"
L["Total"] = "Gesamt"
L["Value Color"] = true
L["You are not playing a |cff0070DEShaman|r, datatext disabled."] = "Du spielst keinen |cff0070DEShaman|r, Infotext deaktiviert."

-- Death Recap
L["%s %s"] = true
L["%s by %s"] = "%s durch %s"
L["%s sec before death at %s%% health."] = "%s Sekunden vor Tod bei %s%% Gesundheit."
L["(%d Absorbed)"] = "(%d Absorbiert)"
L["(%d Blocked)"] = "(%d Geblockt)"
L["(%d Resisted)"] = "(%d Widerstanden)"
L["Critical"] = true
L["Crushing"] = true
L["Death Recap unavailable."] = "Todesursache nicht verfügbar."
L["Death Recap"] = "Todesursache"
L["Killing blow at %s%% health."] = "Todesstoß bei %s%% Gesundheit."
L["Recap"] = "Zusammenfassung"
L["You died."] = "Du bist gestorben."

-- Error Frame
L["Error Frame"] = true
L["Set the width of Error Frame. Too narrow frame may cause messages to be split in several lines"] = true
L["Set the height of Error Frame. Higher frame can show more lines at once."] = true

-- General
L["Add button to Dressing Room frame with ability to undress model."] = true
L["Add button to Trainer frame with ability to train all available skills in one click."] = true
L["Alt-Click Merchant"] = true
L["Already Known"] = true
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "Ändere automatisch die beobachtete Fraktion auf der Erfahrungsleiste zu der Fraktion für die Sie grade Rufpunkte erhalten haben."
L["Automatically release body when killed inside a battleground."] = "Gibt automatisch Ihren Geist frei, wenn Sie auf dem Schlachtfeld getötet wurden."
L["Automatically select the quest reward with the highest vendor sell value."] = "Wählt automatisch die Questbelohnung mit dem höchsten Wiederverkaufswert beim Händler"
L["Auto decline all duels"] = "Auto-Ablehnen von allen Duellen"
L["Auto decline party invites"] = true
L["Changes the transparency of all the movers."] = "Ändere die Transparenz aller Ankerpukte"
L["Colorize the WorldMap party/raid icons with class colors"] = true
L["Colorizes recipes that are already known"] = true
L["Decline Duel"] = "Duell ablehnen"
L["Decline Party"] = true
L["Declined duel request from "] = "Duellaufforderung abgelehnt von "
L["Declined party request from "] = true
L["Display the item level on the MerchantFrame, to change the font you have to set it in ElvUI - Bags - ItemLevel"] = "Zeigt das ItemLevel bei den Händlern an, um die Schriftart zu ändern, musst du sie in ElvUI - Taschen - ItemLevel ändern."
L["Display the item level on the Quest frames, to change the font you have to set it in ElvUI - Bags - ItemLevel"] = true
L["Display quest levels at Quest Log."] = "Questlevel im Questlog anzeigen."
L["Hide Zone Text"] = "Zonentext verstecken"
L["Holding Alt key while buying something from vendor will now buy an entire stack."] = true
L["Merchant ItemLevel"] = "Zeige ItemLevel beim Händlern"
L["Mover Transparency"] = "Transparenz Ankerpunkte"
L["Original Close Button"] = "Originaler Schließen-Button"
L["PvP Autorelease"] = "Automatische Freigabe im PvP"
L["Quest ItemLevel"] = true
L["Select Quest Reward"] = true
L["Show Quest Level"] = "Zeige Questlevel"
L["Track Reputation"] = "Ruf beobachten"
L["Train All Button"] = true
L["Undress Button"] = true
L["WorldMap Blips"] = true

-- Model Frames
L["Drag"] = "Ziehen"
L["Left-click on character and drag to rotate."] = "Linksklicken und ziehen, um den Charakter zu drehen."
L["Model Frames"] = true
L["Mouse Wheel Down"] = "Mausrad nach unten"
L["Mouse Wheel Up"] = "Mausrad nach oben"
L["Right-click on character and drag to move it within the window."] = "Rechtsklicken und ziehen, um den Charakter im Fenster zu verschieben."
L["Rotate Left"] = "Linksdrehung"
L["Rotate Right"] = "Rechtsdrehung"

-- Nameplates
L["Bars will transition smoothly."] = "Balken werden sanft übergehen"
L["Smooth Bars"] = "Sanfte Balken"

-- Minimap
L["Above Minimap"] = "Oberhalb der Minimap"
L["Always"] = "Immer"
L["Combat Hide"] = true
L["FadeIn Delay"] = "Einblendungsverzögerung"
L["Hide minimap while in combat."] = "Ausblenden der Minimap während des Kampfes."
L["Location Digits"] = "Koordinaten Nachkommastellen"
L["Location Panel"] = "Standort-Panel"
L["Number of digits for map location."] = "Anzahl der Nachkommastellen der Koordinaten."
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "Die Zeit vor dem wieder Einblenden der Minimap nach dem Kampf. (0 = deaktiviert)"
L["Toggle Location Panel."] = "Umschalten des Standort-Panels"

-- Tooltip
L["Item Border Color"] = "Gegenstandsrahmen-Farbe"
L["Colorize the tooltip border based on item quality."] = "Färbe den Tooltip-Rahmen basierend auf der Gegenstandsqualität"
L["Show/Hides an Icon for Items on the Tooltip."] = "Icon für Gegenstände am Tooltip anzeigen oder ausblenden."
L["Show/Hides an Icon for Spells on the Tooltip."] = "Icon für Zauber am Tooltip anzeigen oder ausblenden."
L["Show/Hides an Icon for Spells and Items on the Tooltip."] = "Icon für Zauber oder Gegenstände am Tooltip anzeigen oder ausblenden."
L["Spells"] = "Zauber"
L["Tooltip Icon"] = true

-- Misc
L["Enhanced Frames"] = true
L["Miscellaneous"] = "Verschiedenes"
L["Skin Animations"] = "Skin-Animationen"
L["Total cost:"] = true
L["Undress"] = "Ausziehen"

-- Character Frame
L["Character Stats"] = "Charakterstatistiken"
L["Damage Per Second"] = "DPS"
L["Hide Character Information"] = "Verstecke Charakter-Informationen"
L["Hide Pet Information"] = "Verstecke Begleiter-Informationen"
L["Item Level"] = true
L["Resistance"] = "Widerstände"
L["Show Character Information"] = "Zeige Charakter-Informationen"
L["Show Pet Information"] = "Zeige Begleiter-Informationen"
L["Titles"] = "Titel"

-- Movers
L["Loss Control Icon"] = "Kontrollverlust-Icon"
L["Player Portrait"] = "Spieler-Portrait"
L["Target Portrait"] = "Ziel-Portrait"

-- Loss Control
L["CC"] = "CC"
L["Disarm"] = "Entwaffnen"
L["Lose Control"] = true
L["PvE"] = "PvE"
L["Root"] = "Wurzeln"
L["Silence"] = "Stille"
L["Snare"] = "Verlangsamung"
L["Type"] = "Typ"

-- Raid Marks
L["Raid Markers"] = true
L["Click to clear the mark."] = true
L["Click to mark the target."] = true
L["In Party"] = true
L["Raid Marker Bar"] = true
L["Reverse"] = true

-- Unitframes
L["Class Icons"] = "Klassensymbole"
L["Detached Height"] = "Höhe loslösen"
L["Energy Tick"] = true
L["Show class icon for units."] = "Zeige Klassensymbole für Einheiten"
L["Target"] = "Ziel"

-- WatchFrame
L["Arena"] = "Arena"
L["City (Resting)"] = "Stadt (erholend)"
L["Hidden"] = "Versteckt"
L["Party"] = "Gruppe"
L["PvP"] = "PvP"
L["Raid"] = "Schlachtzug"