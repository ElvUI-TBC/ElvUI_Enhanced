local E, L, V, P, G = unpack(ElvUI);
local ETAB = E:NewModule("Enhanced_TransparentActionbars")

local _G = _G
local pairs = pairs

function ETAB:BarsBackdrop()
	if(E.db.enhanced.actionbars.transparentActionbars.transparentBackdrops) then
		for i = 1, 10 do
			local transBars = {_G["ElvUI_Bar"..i]}
			for _, frame in pairs(transBars) do
				if(frame.backdrop) then
					frame.backdrop:SetTemplate("Transparent");
				end
			end
		end

		local transOtherBars = {ElvUI_BarPet, ElvUI_StanceBar, ElvUIBags}
		for _, frame in pairs(transOtherBars) do
			if(frame.backdrop) then
				frame.backdrop:SetTemplate("Transparent");
			end
		end
	else
		for i = 1, 10 do
			local transBars = {_G["ElvUI_Bar"..i]}
			for _, frame in pairs(transBars) do
				if(frame.backdrop) then
					frame.backdrop:SetTemplate("Default");
				end
			end
		end

		local transOtherBars = {ElvUI_BarPet, ElvUI_StanceBar, ElvUIBags}
		for _, frame in pairs(transOtherBars) do
			if(frame.backdrop) then
				frame.backdrop:SetTemplate("Default");
			end
		end
	end
end

function ETAB:ButtonsBackdrop()
	if(E.db.enhanced.actionbars.transparentActionbars.transparentButtons) then
		for i = 1, 10 do
			for k = 1, 12 do
				local buttonBars = {_G["ElvUI_Bar"..i.."Button"..k]}
				for _, button in pairs(buttonBars) do
					if(button.backdrop) then
						button.backdrop:SetTemplate("Transparent");
					end
				end
			end
		end

		for i = 1, NUM_PET_ACTION_SLOTS do
			local petButtons = {_G["PetActionButton"..i]}
			for _, button in pairs(petButtons) do
				if(button.backdrop) then
					button.backdrop:SetTemplate("Transparent");
				end
			end
		end
	else
		for i = 1, 10 do
			for k = 1, 12 do
				local buttonBars = {_G["ElvUI_Bar"..i.."Button"..k]}
				for _, button in pairs(buttonBars) do
					if(button.backdrop) then
						button.backdrop:SetTemplate("Default", true);
					end
				end
			end
		end

		for i = 1, NUM_PET_ACTION_SLOTS do
			local petButtons = {_G["PetActionButton"..i]}
			for _, button in pairs(petButtons) do
				if(button.backdrop) then
					button.backdrop:SetTemplate("Default", true);
				end
			end
		end
	end
end

function ETAB:Initialize()
	E:Delay(0.3, ETAB.BarsBackdrop);
	E:Delay(0.3, ETAB.ButtonsBackdrop);
end

local function InitializeCallback()
	ETAB:Initialize()
end

E:RegisterModule(ETAB:GetName(), InitializeCallback)