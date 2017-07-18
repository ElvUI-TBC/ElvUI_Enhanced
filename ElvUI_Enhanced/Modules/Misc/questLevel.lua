local E, L, V, P, G = unpack(ElvUI);

local function questlevel()
	if not E.db.general.showQuestLevel then return; end

	local scrollOffset = FauxScrollFrame_GetOffset(QuestLogListScrollFrame)
	local numEntries = GetNumQuestLogEntries()

	for i = 1, QUESTS_DISPLAYED do
		local questIndex = i + scrollOffset;
		local questLogTitle = _G["QuestLogTitle" .. i]
		local questCheck = _G["QuestLogTitle"..i.."Check"]

		if questIndex <= numEntries then
			local title, level, _, _, isHeader = GetQuestLogTitle(questIndex)
			if not isHeader then
				questLogTitle:SetText("[" .. level .. "] " .. title)
				questCheck:Point("LEFT", 5, 0)
			end
		end
	end
end

hooksecurefunc("QuestLog_Update", questlevel)
QuestLogListScrollFrameScrollBar:HookScript("OnValueChanged", questlevel)