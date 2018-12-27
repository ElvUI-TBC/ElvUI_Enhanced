local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "zhCN")
if not L then return end

-- DESC locales
L["ENH_LOGIN_MSG"] = "您正在使用 |cff1784d1ElvUI|r |cff1784d1Enhanced|r |cffff8000(TBC)|r version %s%s|r."
L["EQUIPMENT_DESC"] = "当你切换专精或进入战场时自动更换装备, 你可以在选项中选择相关的装备模组."
L["DURABILITY_DESC"] = "调整设置人物窗口装备耐久度显示."
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
L["Character"] = "角色"
L["Damaged Only"] = "受损显示"
L["Desaturate"] = true
L["Enable/Disable the display of durability information on the character screen."] = "开启/关闭 人物窗口装备耐久度显示."
L["Enable/Disable the display of item levels on the character screen."] = true
L["Enhanced Character Frame"] = true
L["Equipment"] = "自动换装"
L["Only show durabitlity information for items that are damaged."] = "只在装备受损时显示耐久度."
L["Paperdoll Backgrounds"] = true
L["Pet"] = "宠物"
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
L["Death Recap"] = "死亡回放"
L["Killing blow at %s%% health."] = true
L["Recap"] = true
L["You died."] = true

-- Decline Duels
L["Auto decline all duels"] = "自动拒绝决斗请求"
L["Decline Duel"] = true
L["Declined duel request from "] = "已拒绝决斗请求自"

-- Error Frame
L["Error Frame"] = true
L["Set the width of Error Frame. Too narrow frame may cause messages to be split in several lines"] = true
L["Set the height of Error Frame. Higher frame can show more lines at once."] = true

-- General
L["Add button to Dressing Room frame with ability to undress model."] = true
L["Add button to Trainer frame with ability to train all available skills in one click."] = true
L["Alt-Click Merchant"] = true
L["Already Known"] = true
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "当你获得某个阵营的声望时, 将自动追踪此阵营的声望至经验栏位."
L["Automatically release body when killed inside a battleground."] = "在战场死亡后自动释放灵魂."
L["Automatically select the quest reward with the highest vendor sell value."] = true
L["Changes the transparency of all the movers."] = true
L["Colorize the WorldMap party/raid icons with class colors"] = true
L["Colorizes recipes, mounts & pets that are already known"] = true
L["Display the item level on the MerchantFrame, to change the font you have to set it in ElvUI - Bags - ItemLevel"] = true
L["Display quest levels at Quest Log."] = true
L["Hide Zone Text"] = true
L["Holding Alt key while buying something from vendor will now buy an entire stack."] = true
L["Merchant ItemLevel"] = true
L["Mover Transparency"] = true
L["Original Close Button"] = true
L["PvP Autorelease"] = "PVP自动释放灵魂"
L["Select Quest Reward"] = true
L["Show Quest Level"] = true
L["Track Reputation"] = "声望追踪"
L["Train All Button"] = true
L["Undress Button"] = true
L["WorldMap Blips"] = true

-- Model Frames
L["Drag"] = "拖曳"
L["Left-click on character and drag to rotate."] = "左键点击并拖曳以旋转角色"
L["Model Frames"] = true
L["Mouse Wheel Down"] = "鼠标滚轮向下滚动"
L["Mouse Wheel Up"] = "鼠标滚轮向上滚动"
L["Right-click on character and drag to move it within the window."] = "右键点击并拖曳角色，使其在窗口内移动。"
L["Rotate Left"] = "左转"
L["Rotate Right"] = "右转"

-- Nameplates
L["Bars will transition smoothly."] = true
L["Smooth Bars"] = true

-- Minimap
L["Above Minimap"] = true
L["Always"] = "总是"
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
L["Spells"] = "法术"
L["Tooltip Icon"] = true

-- Misc
L["Enhanced Frames"] = true
L["Miscellaneous"] = "杂项"
L["Skin Animations"] = true
L["Total cost:"] = true
L["Undress"] = "无装备"

-- Character Frame
L["Character Stats"] = true
L["Damage Per Second"] = "DPS"
L["Hide Character Information"] = true
L["Hide Pet Information"] = true
L["Item Level"] = true
L["Resistance"] = true
L["Show Character Information"] = true
L["Show Pet Information"] = true
L["Titles"] = true

-- Movers
L["Loss Control Icon"] = "失去控制图标"
L["Player Portrait"] = true
L["Target Portrait"] = true

-- Lose Control
L["CC"] = "控制类技能"
L["Disarm"] = "缴械类技能"
L["Lose Control"] = true
L["PvE"] = "PvE"
L["Root"] = "定身类技能"
L["Silence"] = "沉默类技能"
L["Snare"] = "减速类技能"
L["Type"] = "类型"

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
L["Target"] = "目标"

-- WatchFrame
L["Hidden"] = true
L["City (Resting)"] = true
L["PvP"] = true
L["Arena"] = true
L["Party"] = true
L["Raid"] = true