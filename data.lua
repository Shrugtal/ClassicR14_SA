local _, namespace = ...
function namespace:GetSpellList ()
	return {
		auraApplied = {
			-- gen
			-- druid
			["Barkskin"] = {1, ""},
			["Nature's Grasp"] = {1, ""},
			["Innervate"] = {1, ""},
			-- hunter
			["Deterrence"] = {1, ""},
			["Feign Death"] = {1, ""},
			["Rapid Fire"] = {1, ""},
			-- mage
			["Ice Block"] = {1, ""},
			["Presence of Mind"] = {1, ""},
			["Arcane Power"] = {1, ""},
			-- paladin
			["Divine Shield"] = {1, ""},
			["Blessing of Protection"] = {1, ""},
			["Blessing of Freedom"] = {1, "Freedom"},
			["Divine Intervention"] = {1, ""},
			["Divine Protection"] = {1, ""},
			-- priest
			["Fear Ward"] = {1, ""},
			["Power Word: Shield"] = {1, "Power Word Shield"},
			["Power Infusion"] = {1, ""},
			-- rogue
			["Evasion"] = {1, ""},
			["Adrenaline Rush"] = {1, ""},
			-- warlock
			["Sacrifice"] = {1, ""},
			["Demonic Sacrifice"] = {1, ""},
			-- warrior
			["Shield Wall"] = {1, ""},
			["Retaliation"] = {1, ""},
			["Recklessness"] = {1, ""},
		},
		auraRemoved = {
			["Ice Block"] = {1, ""},
			["Divine Shield"] = {1, ""},
			["Blessing of Protection"] = {1, ""},
			["Evasion"] = {1, ""},
			["Shield Wall"] = {1, ""},
			["Retaliation"] = {1, ""},
			["Recklessness"] = {1, ""},
			["Deterrence"] = {1, ""},
		},
		castStart = {
			-- gen
			["Escape Artist"] = {1, ""},
			-- big heals
			["Heal"] = {1,  "Big Heal"},
			["Greater Heal"] = {1,  "Big Heal"},
			["Holy Light"] = {1,  "Big Heal"},
			["Healing Touch"] = {1,  "Big Heal"},
			["Healing Wave"] = {1,  "Big Heal"},
			-- resurrection
			["Resurrection"] = {1, ""},
			["Redemption"] = {1, ""},
			["Rebirth"] = {1, ""}, --combat res
			["Ancestral Spirit"] = {1, ""},
			-- druid
			["Entangling Roots"] = {1, ""},
			["Tranquility"] = {1, ""},
			-- hunter
			["Revive Pet"] = {1, ""},
			["Bestial Wrath"] = {1, ""},
			["Wyvern Sting"] = {1, ""},
			["Scatter Shot"] = {1, ""},
			-- mage
			["Polymorph"] = {1, ""},
			["Evocation"] = {1, ""},
			-- paladin
			["Lay on Hands"] = {1, ""},
			["Divine Favor"] = {1, ""},
			["Repentance"] = {1, ""},
			-- priest
			["Mind Control"] = {1, ""},
			-- shaman
			-- rogue
			-- warlock
			["Fear"] = {1, ""},
			["Banish"] = {1, ""},
			["Howl of Terror"] = {1, ""},
			["Seduction"] = {1, ""},
			["Summon Imp"] = {1, ""},
			["Summon Felhunter"] = {1, ""},
			["Summon Succubus"] = {1, ""},
			["Summon Voidwalker"] = {1, ""},
			["Inferno"] = {1, ""},
			-- warrior
		},
		castSuccess = {
			-- gen
			["First Aid"] = {1, ""}, --why does this spell not call Cast Start when it has a channel bar?
			["Shadowmeld"] = {1, ""},
			["Stoneform"] = {1, ""},
			["Will of the Forsaken"] = {1, ""},
			["Insignia of the Alliance"] = {1, ""},
			["Insignia of the Horde"] = {1, ""},
			-- druid
			["Bash"] = {1, ""},
			["Feral Charge"] = {1, ""},
			-- hunter
			["Freezing Trap"] = {1, ""},
			["Scatter Shot"] = {1, ""},
			["Intimidation"] = {1, ""},
			-- mage
			["Cold Snap"] = {1, ""},
			["Combustion"] = {1, ""},
			["Counterspell"] = {1, ""},
			-- paladin
			["Hammer of Justice"] = {1, ""},
			-- priest
			["Silence"] = {1, ""},
			["Desperate Prayer"] = {1, ""},
			["Psychic Scream"] = {1, ""},
			["Dispel Magic"] = {1, ""},
			-- shaman
			["Windfury Totem"] = {1, ""},
			["Grounding Totem"] = {1, ""},
			["Tremor Totem"] = {1, ""},
			["Earthbind Totem"] = {1, ""},
			["Mana Tide Totem"] = {1, ""},
			["Purge"] = {1, ""},
			-- rogue
			["Cheap Shot"] = {1, ""},
			["Kidney Shot"] = {1, ""},
			["Sap"] = {1, ""},
			["Gouge"] = {1, ""},
			["Cold Blood"] = {1, ""},
			["Vanish"] = {1, ""},
			["Blind"] = {1, ""},
			["Preperation"] = {1, ""},
			["Kick"] = {1, ""},
			["Sprint"] = {1, ""},
			-- warlock
			["Death Coil"] = {1, ""},
			["Spell Lock"] = {1, ""},
			-- warrior
			["Disarm"] = {1, ""},
			["Beserker Rage"] = {1, ""},
			["Charge"] = {1, ""},
			["Intercept"] = {1, ""},
			["Pummel"] = {1, ""},
			["Shield Bash"] = {1, ""},
			["Concussion Blow"] = {1, ""},
			["Death Wish"] = {1, ""},
		},
	}
end