local E, L, V, P, G = unpack(ElvUI);

local function questlevel()
	if not E.db.general.showQuestLevel then return; end

	QUESTS_DISPLAYED = 25

	local scrollOffset = FauxScrollFrame_GetOffset(QuestLogListScrollFrame);
	local numEntries, numQuests = GetNumQuestLogEntries();

	for i = 7, 25 do
		local questLogTitle = CreateFrame("Button", "QuestLogTitle" .. i, QuestLogFrame, "QuestLogTitleButtonTemplate")

		questLogTitle:SetID(i)
		questLogTitle:Hide()
		questLogTitle:Point("TOPLEFT", _G["QuestLogTitle" .. i - 1], "BOTTOMLEFT", 0, 1)
	end

	for i = 1, QUESTS_DISPLAYED do
		local questIndex = i + scrollOffset;
		local questLogTitle = _G["QuestLogTitle" .. i]
		if(questIndex <= numEntries) then
			local title, level, _, _, isHeader = GetQuestLogTitle(questIndex);
			if(not isHeader) then
				questLogTitle:SetText("[" .. level .. "] " .. title);
			end
		end
	end
end

hooksecurefunc("QuestLog_Update", questlevel)
QuestLogListScrollFrameScrollBar:HookScript("OnValueChanged", questlevel)