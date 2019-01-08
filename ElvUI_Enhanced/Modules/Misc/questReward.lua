local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")
local LIP = LibStub("ItemPrice-1.1")

local _G = _G
local format = string.format

local function SelectQuestReward(index)
	local btn = _G[("QuestRewardItem%d"):format(index)]

	if btn.type == "choice" then
		if E.private.skins.blizzard.enable and E.private.skins.blizzard.quest then
			_G[btn:GetName()]:SetBackdropBorderColor(1, 0.80, 0.10)
			_G[btn:GetName()].backdrop:SetBackdropBorderColor(1, 0.80, 0.10)
			_G[btn:GetName().."Name"]:SetTextColor(1, 0.80, 0.10)
		else
			QuestRewardItemHighlight:ClearAllPoints()
			QuestRewardItemHighlight:Point("TOPLEFT", btn, "TOPLEFT", -8, 7)
			QuestRewardItemHighlight:Show()
		end

		QuestFrameRewardPanel.itemChoice = btn:GetID()
	end
end

function M:QUEST_COMPLETE()
	if not E.db.enhanced.general.selectQuestReward then return end

	local choice, price = 1, 0
	local num = GetNumQuestChoices()

	if num <= 0 then return end

	for index = 1, num do
		local link = GetQuestItemLink("choice", index)
		if link then
			local itemPrice = LIP:GetSellValue(link)
			if itemPrice and itemPrice > price then
				price = itemPrice
				choice = index
			end
		end
	end

	SelectQuestReward(choice)
end

function M:LoadQuestReward()
	self:RegisterEvent("QUEST_COMPLETE")
end