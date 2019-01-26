local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "koKR")
if not L then return end

-- DESC locales
L["ENH_LOGIN_MSG"] = "You are using |cff1784d1ElvUI Enhanced|r |cffff8000(TBC)|r version %s%s|r."
L["EQUIPMENT_DESC"] = "Adjust the settings for switching your gear set when you change specialization or enter a battleground."
L["DURABILITY_DESC"] = "Adjust the settings for the durability information on the character screen."
L["ITEMLEVEL_DESC"] = "Adjust the settings for the item level information on the character screen."
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
L["Character"] = "캐릭터"
L["Damaged Only"] = true
L["Desaturate"] = true
L["Enable/Disable the display of durability information on the character screen."] = true
L["Enable/Disable the display of item levels on the character screen."] = true
L["Enhanced Character Frame"] = true
L["Equipment"] = true
L["Only show durabitlity information for items that are damaged."] = true
L["Paperdoll Backgrounds"] = true
L["Pet"] = "소환수"
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
L["Total"] = "합계"
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
L["Death Recap"] = true
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
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = true
L["Automatically release body when killed inside a battleground."] = true
L["Automatically select the quest reward with the highest vendor sell value."] = true
L["Auto decline all duels"] = true
L["Auto decline party invites"] = true
L["Changes the transparency of all the movers."] = true
L["Colorize the WorldMap party/raid icons with class colors"] = true
L["Colorizes recipes that are already known"] = true
L["Decline Duel"] = true
L["Decline Party"] = true
L["Declined duel request from "] = true
L["Declined party request from "] = true
L["Display the item level on the MerchantFrame, to change the font you have to set it in ElvUI - Bags - ItemLevel"] = true
L["Display the item level on the Quest frames, to change the font you have to set it in ElvUI - Bags - ItemLevel"] = true
L["Display quest levels at Quest Log."] = true
L["Hide Zone Text"] = true
L["Holding Alt key while buying something from vendor will now buy an entire stack."] = true
L["Merchant ItemLevel"] = true
L["Mover Transparency"] = true
L["Original Close Button"] = true
L["PvP Autorelease"] = true
L["Quest ItemLevel"] = true
L["Select Quest Reward"] = true
L["Show Quest Level"] = true
L["Track Reputation"] = true
L["Train All Button"] = true
L["Undress Button"] = true
L["WorldMap Blips"] = true

-- Model Frames
L["Drag"] = "끌기"
L["Left-click on character and drag to rotate."] = "마우스 왼쪽 버튼으로 클릭 후 드래그하면 캐릭터를 회전할 수 있습니다."
L["Model Frames"] = true
L["Mouse Wheel Down"] = "마우스 휠 아래로"
L["Mouse Wheel Up"] = "마우스 휠 위로"
L["Right-click on character and drag to move it within the window."] = "마우스 오른쪽 버튼으로 클릭 후 드래그하면 캐릭터를 창 안에서 이동할 수 있습니다."
L["Rotate Left"] = "왼쪽으로 회전"
L["Rotate Right"] = "오른쪽으로 회전"

-- Nameplates
L["Bars will transition smoothly."] = true
L["Smooth Bars"] = true

-- Minimap
L["Above Minimap"] = true
L["Always"] = "항상"
L["Combat Hide"] = true
L["FadeIn Delay"] = true
L["Hide minimap while in combat."] = true
L["Location Digits"] = true
L["Location Panel"] = true
L["Number of digits for map location."] = true
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = true
L["Toggle Location Panel."] = true

-- Tooltip
L["Item Border Color"] = true
L["Colorize the tooltip border based on item quality."] = true
L["Show/Hides an Icon for Items on the Tooltip."] = true
L["Show/Hides an Icon for Spells on the Tooltip."] = true
L["Show/Hides an Icon for Spells and Items on the Tooltip."] = true
L["Spells"] = "주문"
L["Tooltip Icon"] = true

-- Misc
L["Enhanced Frames"] = true
L["Miscellaneous"] = "기타 설정"
L["Skin Animations"] = true
L["Total cost:"] = true
L["Undress"] = true

-- Character Frame
L["Character Stats"] = true
L["Damage Per Second"] = "DPS"
L["Hide Character Information"] = true
L["Hide Pet Information"] = true
L["Item Level"] = true
L["Resistance"] = true
L["Show Character Information"] = true
L["Show Pet Information"] = true
L["Titles"] = "칭호"

-- Movers
L["Loss Control Icon"] = "제어손실 표시"
L["Player Portrait"] = true
L["Target Portrait"] = true

-- Loss Control
L["CC"] = "군중제어"
L["Disarm"] = "무장 해제"
L["Lose Control"] = true
L["PvE"] = "PvE"
L["Root"] = "뿌리묶기"
L["Silence"] = "침묵"
L["Snare"] = "덫"
L["Type"] = "종류"

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
L["Target"] = true

-- WatchFrame
L["Hidden"] = true
L["City (Resting)"] = true
L["PvP"] = true
L["Arena"] = true
L["Party"] = true
L["Raid"] = true