local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins")
local Cost

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(_, _, addon)
	if(addon == "Blizzard_TrainerUI") then
		local ClassTrainerTrainAllButton = CreateFrame("Button", "ClassTrainerTrainAllButton", ClassTrainerFrame, "UIPanelButtonTemplate")
		ClassTrainerTrainAllButton:SetParent(ClassTrainerFrame)
		ClassTrainerTrainAllButton:SetText(L["Train All"])
		ClassTrainerTrainAllButton:Size(80, 22)

		if(E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.trainer ~= true) then
			ClassTrainerTrainAllButton:Point("TOPRIGHT", ClassTrainerTrainButton, "TOPLEFT", 0, 0)
		else
			S:HandleButton(ClassTrainerTrainAllButton)
			ClassTrainerTrainAllButton:Point("TOPRIGHT", ClassTrainerTrainButton, "TOPLEFT", -3, 0)
		end

		ClassTrainerTrainAllButton:HookScript2("OnClick", function()
			for i = 1, GetNumTrainerServices() do
				if(select(3, GetTrainerServiceInfo(i)) == "available") then
					BuyTrainerService(i)
				end
			end
		end)

		ClassTrainerTrainAllButton:HookScript2("OnEnter", function()
			Cost = 0
			for i = 1, GetNumTrainerServices() do
				if(select(3, GetTrainerServiceInfo(i)) == "available") then
					Cost=Cost+GetTrainerServiceCost(i)
					GameTooltip:SetOwner(ClassTrainerTrainAllButton,"ANCHOR_TOPRIGHT", 0, 4)
					GameTooltip:SetText("|cffffffff"..L["Total cost:"].."|r "..E:FormatMoney(Cost, E.db.datatexts.goldFormat or "BLIZZARD", not E.db.datatexts.goldCoins))
				end
			end
		end)

		ClassTrainerTrainAllButton:HookScript2("OnLeave", function()
			GameTooltip:Hide()
		end)

		hooksecurefunc("ClassTrainerFrame_Update", function()
			for i = 1, GetNumTrainerServices() do
				if(select(3, GetTrainerServiceInfo(i)) == "available") then
					ClassTrainerTrainAllButton:Enable()
					return
				end
			end
			ClassTrainerTrainAllButton:Disable()
		end)
	end
end)