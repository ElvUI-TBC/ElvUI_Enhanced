local E, L, V, P, G = unpack(ElvUI)
local EDL = E:NewModule("Enhanced_DPSLinks", "AceHook-3.0")

local find, format, gsub, split = string.find, string.format, string.gsub, string.split
local tinsert = table.insert
local ipairs, tonumber = ipairs, tonumber

local GetTime = GetTime
local ShowUIPanel = ShowUIPanel

local ItemRefTooltip = ItemRefTooltip

local channelEvents = {
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	"CHAT_MSG_SAY",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_WHISPER_INFORM",
	"CHAT_MSG_YELL",
}

local spamFirstLines = {
	"^Recount - (.*)$",	-- Recount
}

local spamNextLines = {
	"^(%d+)\. (.*)$",	-- Recount
}

function EDL:FilterLine(event, source, msg, ...)
	for _, line in ipairs(spamNextLines) do
		if msg and msg:match(line) then
			local curTime = GetTime()

			for id, meter in ipairs(self.Meters) do
				local elapsed = curTime - meter.time

				if meter.src == source and meter.evt == event and elapsed < 1 then
					local toInsert = true

					for a, b in ipairs(meter.data) do
						if b == msg then
							toInsert = false
						end
					end

					if toInsert then
						tinsert(meter.data,msg)
					end

					return true, false, nil
				end
			end
		end
	end

	for _, line in ipairs(spamFirstLines) do
		local newID = 0

		if msg and msg:match(line) then
			local curTime = GetTime()

			if find(msg, "|cff(.+)|r") then
				msg = gsub(msg, "|cff%w%w%w%w%w%w", "")
				msg = gsub(msg, "|r", "")
			end

			for id, meter in ipairs(self.Meters) do
				local elapsed = curTime - meter.time

				if meter.src == source and meter.evt == event and elapsed < 1 then
					newID = id
					return true, true, format("|HEDL:%1$d|h|cFFFFFF00[%2$s]|r|h", newID or 0, msg or "nil")
				end
			end

			tinsert(self.Meters, {src = source, evt = event, time = curTime, data = {}, title = msg})

			for id, meter in ipairs(self.Meters) do
				if meter.src == source and meter.evt == event and meter.time == curTime then
					newID = id
				end
			end

			return true, true, format("|HEDL:%1$d|h|cFFFFFF00[%2$s]|r|h", newID or 0, msg or "nil")
		end
	end

	return false, false, nil
end

function EDL:ParseChatEvent(event, msg, sender, ...)
	local isMeter, isFirstLine, newMessage = EDL:FilterLine(event, sender, msg)
	if isMeter then
		if isFirstLine then
			return false, newMessage, sender, ...
		else
			return true
		end
	end
end

function EDL:SetItemRef(link, text, button, chatframe)
	local linktype, id = split(":", link)

	if linktype == "EDL" then
		local meterID = tonumber(id)

		ShowUIPanel(ItemRefTooltip)

		if not ItemRefTooltip:IsShown() then
			ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
		end

		ItemRefTooltip:ClearLines()
		ItemRefTooltip:AddLine(self.Meters[meterID].title)
		ItemRefTooltip:AddLine(format(L["Reported by %s"], self.Meters[meterID].src))

		for _, message in ipairs(self.Meters[meterID].data) do
			ItemRefTooltip:AddLine(message, 1, 1, 1)
		end

		ItemRefTooltip:Show()

		return nil
	end

	return self.hooks.SetItemRef(link, text, button)
end

function EDL:ItemRefTooltip_SetHyperlink(self, link, ...)
	if link:sub(0, 4) == "EDL:" then return end

	return EDL.hooks[self].SetHyperlink(self, link, ...)
end

function EDL:UpdateSettings()
	if E.db.enhanced.chat.dpsLinks then
		if not self:IsHooked("SetItemRef") then
			self:RawHook("SetItemRef", true)
		end
		if not self:IsHooked(ItemRefTooltip, "SetHyperlink") then
			self:RawHook(ItemRefTooltip, "SetHyperlink", "ItemRefTooltip_SetHyperlink")
		end

		if not self.FiltersRegistered then
			for _, event in ipairs(channelEvents) do
				ChatFrame_AddMessageEventFilter(event, self.ParseChatEvent)
			end

			self.FiltersRegistered = true
		end
	else
		self:UnhookAll()

		if self.FiltersRegistered then
			for _, event in ipairs(channelEvents) do
				ChatFrame_RemoveMessageEventFilter(event, self.ParseChatEvent)
			end

			self.FiltersRegistered = false
		end
	end
end

function EDL:Initialize()
	self.Meters = {}

	self:UpdateSettings()
end

local function InitializeCallback()
	EDL:Initialize()
end

E:RegisterModule(EDL:GetName(), InitializeCallback)