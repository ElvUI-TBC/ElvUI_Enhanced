local E, L, V, P, G = unpack(ElvUI);
local UF = E:GetModule("UnitFrames");

if not E.private.unitframe.enable then return end

ElvUF_Player.AnimatedLoss = CreateFrame("StatusBar", nil, ElvUF_Player);
UF["statusbars"][ElvUF_Player.AnimatedLoss] = true;
ElvUF_Player.AnimatedLoss:Hide();

hooksecurefunc(UF, "Configure_HealthBar", function(self, frame)
	if(frame.unitframeType == "player") then
		if(frame.db.animatedLoss and frame.db.animatedLoss.enable) then
			if(not frame:IsElementEnabled("AnimatedLoss")) then
				frame:EnableElement("AnimatedLoss");
			end

			local animatedLoss = frame.AnimatedLoss;
			animatedLoss:SetParent(frame.Health);

			animatedLoss.duration = frame.db.animatedLoss.duration;
			animatedLoss.startDelay = frame.db.animatedLoss.startDelay;
			animatedLoss.pauseDelay = frame.db.animatedLoss.pauseDelay;
			animatedLoss.postponeDelay = frame.db.animatedLoss.postponeDelay;

			animatedLoss.PostUpdate = function(self)
				self:SetPoint("TOPLEFT", frame.Health.texturePointer, "TOPRIGHT");
				self:SetPoint("BOTTOMLEFT", frame.Health.texturePointer, "BOTTOMRIGHT");

				local totalWidth = frame.Health:GetSize();
				self:SetWidth(totalWidth);
			end
		else
			if(frame:IsElementEnabled("AnimatedLoss")) then
				frame:DisableElement("AnimatedLoss");
			end
		end
	end
end);

hooksecurefunc(UF, "Configure_Portrait", function(self, frame)
	if(frame.unitframeType == "player" or frame.unitframeType == "target") then
		frame.PORTRAIT_DETACHED = frame.USE_PORTRAIT and frame.db.portrait.detachFromFrame and not frame.USE_PORTRAIT_OVERLAY;
		frame.PORTRAIT_WIDTH = (frame.USE_PORTRAIT_OVERLAY or frame.PORTRAIT_DETACHED or not frame.USE_PORTRAIT) and 0 or frame.db.portrait.width;
		frame.CLASSBAR_WIDTH = frame.UNIT_WIDTH - ((frame.BORDER+frame.SPACING)*2) - frame.PORTRAIT_WIDTH  - frame.POWERBAR_OFFSET;

		if(frame.USE_PORTRAIT) then
			local portrait = frame.Portrait;
			if(frame.PORTRAIT_DETACHED and frame.db.portrait.style == "3D") then
				if(not portrait.Holder or (portrait.Holder and not portrait.Holder.mover)) then
					portrait.Holder = CreateFrame("Frame", nil, UIParent);
					portrait.Holder:Size(frame.db.portrait.detachedWidth, frame.db.portrait.detachedHeight);

					if(frame.ORIENTATION == "LEFT") then
						portrait.Holder:Point("RIGHT", frame, "LEFT", -frame.BORDER, 0);
					elseif(frame.ORIENTATION == "RIGHT") then
						portrait.Holder:Point("LEFT", frame, "RIGHT", frame.BORDER, 0);
					end

					portrait:SetInside(portrait.Holder);
					portrait.backdrop:SetOutside(portrait);

					if(frame.unitframeType == "player") then
						E:CreateMover(portrait.Holder, "PlayerPortraitMover", L["Player Portrait"], nil, nil, nil, "ALL,SOLO");
					elseif(frame.unitframeType == "target") then
						E:CreateMover(portrait.Holder, "TargetPortraitMover", L["Target Portrait"], nil, nil, nil, "ALL,SOLO");
					end
				else
					portrait.Holder:Size(frame.db.portrait.detachedWidth, frame.db.portrait.detachedHeight);
					portrait:SetInside(portrait.Holder);
					portrait.backdrop:SetOutside(portrait);
					E:EnableMover(portrait.Holder.mover:GetName());
				end
			end

			if(not frame.PORTRAIT_DETACHED) then
				if(portrait.Holder and portrait.Holder.mover) then
					E:DisableMover(portrait.Holder.mover:GetName());
				end
			end
			self:Configure_HealthBar(frame);
			self:Configure_Power(frame);
		end
	end
end);

-- Energy Tick
if not (E.myclass == "DRUID" or E.myclass == "ROGUE") then return end

ElvUF_Player.Power.EnergyTick = CreateFrame("Frame", nil, ElvUF_Player.Power)
ElvUF_Player.Power.EnergyTick:RegisterEvent("PLAYER_LOGIN")
ElvUF_Player.Power.EnergyTick:RegisterEvent("PLAYER_ENTERING_WORLD")
ElvUF_Player.Power.EnergyTick:RegisterEvent("UNIT_DISPLAYPOWER")

ElvUF_Player.Power.EnergyTick.Spark = ElvUF_Player.Power:CreateTexture(nil, "OVERLAY")
ElvUF_Player.Power.EnergyTick.Spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
ElvUF_Player.Power.EnergyTick.Spark:SetBlendMode("ADD")

hooksecurefunc(UF, "Configure_Power", function(_, frame)
	if frame.unitframeType == "player" then
		local power = frame.Power
		local db = frame.db.power

		if db.energyTickEnable then
			power.EnergyTick.Spark:Show()
			power.EnergyTick.Spark:Size(frame.POWERBAR_HEIGHT * 1.6, 22)

			local color = E.db.unitframe.units.player.power.energyTickColor
			power.EnergyTick.Spark:SetVertexColor(color.r, color.g, color.b)

			power.EnergyTick:SetScript("OnEvent", function(self)
				if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LOGIN" or (event == "UNIT_DISPLAYPOWER" and arg1 == "player") then
					if UnitPowerType("player") ~= 3 then
						self.Spark:Hide()
					else
						self.Spark:Show()
					end
				end
			end)

			if not power.EnergyTick.lastTick then
				power.EnergyTick.lastTick = GetTime()
			end

			power.EnergyTick:SetScript("OnUpdate", function(self)
				if UnitPowerType("player") ~= 3 then return end

				if not self.energy then
					self.energy = UnitMana("player")
				end

				if UnitMana("player") > self.energy or GetTime() >= self.lastTick + 2 then
					self.lastTick = GetTime()
				end

				self.energy = UnitMana("player")

				local tickPosition = (frame.POWERBAR_WIDTH / 200 * floor((GetTime() - self.lastTick) * 100) + 0.5)
				self.Spark:Point("LEFT", power, tickPosition - 12, 0)
			end)
		else
			power.EnergyTick.Spark:Hide()
		end
	end
end)