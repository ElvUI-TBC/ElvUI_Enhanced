local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local FauxScrollFrame_GetOffset = FauxScrollFrame_GetOffset
local GetNumQuestLogEntries = GetNumQuestLogEntries
local GetQuestLogTitle = GetQuestLogTitle

local function ShowLevel()
	local scrollOffset = FauxScrollFrame_GetOffset(QuestLogListScrollFrame)
	local numEntries = GetNumQuestLogEntries()
	local questIndex, questLogTitle, questCheck, title, level, isHeader, _

	for i = 1, QUESTS_DISPLAYED do
		questIndex = i + scrollOffset
		questLogTitle = _G["QuestLogTitle"..i]
		questCheck = _G["QuestLogTitle"..i.."Check"]

		if questIndex <= numEntries then
			title, level, _, _, isHeader = GetQuestLogTitle(questIndex)

			if not isHeader then
				questLogTitle:SetText("[" .. level .. "] " .. title)
				questCheck:Point("LEFT", 5, 0)
			end
		end
	end
end

function M:QuestLevelToggle()
	if E.db.enhanced.general.showQuestLevel then
		self:SecureHook("QuestLog_Update", ShowLevel)
		self:SecureHookScript(QuestLogListScrollFrameScrollBar, "OnValueChanged", ShowLevel)
	else
		self:Unhook("QuestLog_Update")
		self:Unhook(QuestLogListScrollFrameScrollBar, "OnValueChanged")
	end

	QuestLog_Update()
end