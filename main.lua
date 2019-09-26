print("ClassicR14_SA Alpha Loaded!")

local _, namespace = ...
local addon = CreateFrame("Frame")

addon:RegisterEvent("PLAYER_LOGIN")
addon:SetScript("OnEvent", function(self, event, ...)
    -- this will basically trigger addon:EVENT_NAME(arguments) on any event happening
    return self[event](self, ...)
end)

-- local variable storage
local COMBATLOG_OBJECT_TYPE_PLAYER_OR_PET = _G.COMBATLOG_OBJECT_TYPE_PLAYER + _G.COMBATLOG_OBJECT_TYPE_PET
local COMBATLOG_OBJECT_REACTION_FRIENDLY = _G.COMBATLOG_OBJECT_REACTION_FRIENDLY
local COMBATLOG_OBJECT_REACTION_HOSTILE = _G.COMBATLOG_OBJECT_REACTION_HOSTILE
local GetSpellList = namespace.GetSpellList
local bit_band = _G.bit.band
local PlaySoundFile = _G.PlaySoundFile
-- local variable storage end

--parent frame
local frame = CreateFrame("Frame", "MyFrame", UIParent)
frame.name = "ClassicR14 SA"
frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
frame.title:SetPoint("TOPLEFT", 16, -16)
frame.title:SetText("ClassicR14 SA Options")
frame:SetSize(UIParent:GetWidth(), UIParent:GetHeight())
frame:SetPoint("CENTER")

--scrollframe
scrollframe = CreateFrame("ScrollFrame", nil, frame)
scrollframe:SetPoint("TOPLEFT", 16, -40)
scrollframe:SetPoint("BOTTOMRIGHT", -10, 10)
local texture = scrollframe:CreateTexture()
texture:SetAllPoints()
texture:SetTexture(.5,.5,.5,1)
frame.scrollframe = scrollframe

--scrollbar
scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate")
scrollbar:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 4, -16)
scrollbar:SetPoint("BOTTOMLEFT", scrollframe, "BOTTOMRIGHT", 4, 16)
scrollbar:SetMinMaxValues(1, 2100)
scrollbar:SetValueStep(1)
scrollbar.scrollStep = 1
scrollbar:SetValue(0)
scrollbar:SetWidth(16)
scrollbar:SetScript("OnValueChanged",
function (self, value)
self:GetParent():SetVerticalScroll(value)
end)
local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND")
scrollbg:SetAllPoints(scrollbar)
scrollbg:SetTexture(0, 0, 0, 0.4)
frame.scrollbar = scrollbar

--content frame
local content = CreateFrame("Frame", nil, scrollframe)
content:SetSize(scrollframe:GetWidth(), scrollframe:GetHeight() * 9)

local templist = GetSpellList()

local pos = 0;
for category, array in pairs(templist) do
	for spell, pair in pairs(array) do
		local checkBtn = CreateFrame("CheckButton", "cb", content, "UICheckButtonTemplate");
		checkBtn:SetPoint("TOPLEFT", 0, pos);
		checkBtn.text:SetText(spell);
		pos = pos - 24
	end
end

scrollframe.content = content

scrollframe:SetScrollChild(content)

InterfaceOptions_AddCategory(frame)
frame:Hide();

function addon:PLAYER_LOGIN()
	if not self.spellList then
		self.spellList = GetSpellList()
	end
    self.PLAYER_GUID = UnitGUID("player")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:UnregisterEvent("PLAYER_LOGIN")
    self.PLAYER_LOGIN = nil
	print("Player logged in")
end

function addon:HandleSpell(eventType, spellName, ...)
	local fading = false
	local result = self.spellList[eventType][spellName]
	if eventType == "auraRemoved" then
		fading = true
	end
	if result then
		if result[1] == 1 then
			self:RequestSound(spellName, fading, result[2])
		end
	end
end

function addon:RequestSound(spellName, fading, altName)
	local realName = spellName
	if altName ~= "" then 
		realName = altName
	end
	if fading then
		PlaySoundFile("Interface\\AddOns\\ClassicR14_SA\\audio\\" .. realName .. "down.mp3", "Master");
	else
		PlaySoundFile("Interface\\AddOns\\ClassicR14_SA\\audio\\" .. realName .. ".mp3", "Master");
	end
end

function addon:COMBAT_LOG_EVENT_UNFILTERED()
    local _, eventType, _, srcGUID, srcName, srcFlags, _, dstGUID,  _, dstFlags, _, _, spellName = CombatLogGetCurrentEventInfo()
	local isPlayer = bit_band(srcFlags, COMBATLOG_OBJECT_TYPE_PLAYER_OR_PET) > 0
	if isPlayer then
		local isHostile = bit_band(srcFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0
		local isFriendly = bit_band(srcFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0
		if isHostile then
			if eventType == "SPELL_CAST_START" then
				self:HandleSpell("castStart", spellName);
			elseif eventType == "SPELL_CAST_SUCCESS" then
				self:HandleSpell("castSuccess", spellName);
			elseif eventType == "SPELL_AURA_APPLIED" then
				self:HandleSpell("auraApplied", spellName);
			elseif eventType == "SPELL_AURA_REMOVED" then	
				self:HandleSpell("auraRemoved", spellName);
			end
		elseif isFriendly then
			if eventType == "SPELL_CAST_START" then
				self:HandleSpell("castStart", spellName);
			elseif eventType == "SPELL_CAST_SUCCESS" then
				self:HandleSpell("castSuccess", spellName);
			elseif eventType == "SPELL_AURA_APPLIED" then
				self:HandleSpell("auraApplied", spellName);
			elseif eventType == "SPELL_AURA_REMOVED" then	
				self:HandleSpell("auraRemoved", spellName);	
			end
		end
	end
end