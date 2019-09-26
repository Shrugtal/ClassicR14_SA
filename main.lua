local _, namespace = ...
local addon = CreateFrame("Frame")

addon:RegisterEvent("PLAYER_LOGIN")
addon:RegisterEvent("ADDON_LOADED")
addon:SetScript("OnEvent", function(self, event, ...)
    -- this will basically trigger addon:EVENT_NAME(arguments) on any event happening
    return self[event](self, ...)
end)

-- local variable storage
local COMBATLOG_OBJECT_TYPE_PLAYER_OR_PET = _G.COMBATLOG_OBJECT_TYPE_PLAYER + _G.COMBATLOG_OBJECT_TYPE_PET
local COMBATLOG_OBJECT_REACTION_FRIENDLY = _G.COMBATLOG_OBJECT_REACTION_FRIENDLY
local COMBATLOG_OBJECT_REACTION_HOSTILE = _G.COMBATLOG_OBJECT_REACTION_HOSTILE
local GetSpellList = namespace.GetSpellList
local GetOptionsFrame = namespace.GetOptionsFrame
local bit_band = _G.bit.band
local PlaySoundFile = _G.PlaySoundFile
local defaults = {
    auraApplied = {
	},
	castSuccess = {
	},
	castStart = {
	},
	auraRemoved = {
	},
}
-- local variable storage end

function addon:PLAYER_LOGIN()
    self.PLAYER_GUID = UnitGUID("player")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:UnregisterEvent("PLAYER_LOGIN")
	
    self.PLAYER_LOGIN = nil
end

function addon:ADDON_LOADED()
	self:UnregisterEvent("ADDON_LOADED")
	ClassicR14_SAConfig = ClassicR14_SAConfig or defaults
	if not self.spellList then
		self.spellList = GetSpellList("ClassicR14_SA Alpha Loaded!")
	end
	namespace.GetOptionsFrame("ClassicR14_SA Alpha Loaded!")
	print("ClassicR14_SA Alpha Loaded! Please report any bugs or suggestions to |cffF08CE0https://github.com/Shrugtal/ClassicR14_SA/issues")
end

function addon:HandleSpell(eventType, spellName, ...)
  --  ClassicR14_SAConfig.variable = ClassicR14_SAConfig.variable + 1
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
			--	self:HandleSpell("castStart", spellName); --DEBUG
			elseif eventType == "SPELL_CAST_SUCCESS" then
			--	self:HandleSpell("castSuccess", spellName); --DEBUG
			elseif eventType == "SPELL_AURA_APPLIED" then
			--	self:HandleSpell("auraApplied", spellName); --DEBUG
			elseif eventType == "SPELL_AURA_REMOVED" then	
			--	self:HandleSpell("auraRemoved", spellName);	 --DEBUG
			end
		end
	end
end