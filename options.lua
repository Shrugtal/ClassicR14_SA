local _, namespace = ...
local GetSpellList = namespace.GetSpellList
local totalSize = 0
function namespace:GetOptionsFrame()
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
	scrollbar:SetMinMaxValues(1, 2300)
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

	local auraAppliedFrame = CreateFrame("Frame", "auraAppliedFrame", content)
	auraAppliedFrame:SetPoint("TOPLEFT", 0, 0)
	auraAppliedFrame.title = auraAppliedFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	auraAppliedFrame.title:SetPoint("TOPLEFT", 0, 0)
	auraAppliedFrame.title:SetText("Aura Applied")
	GenerateSpellOptionsForCategory(auraAppliedFrame, "auraApplied")
	local auraRemovedFrame = CreateFrame("Frame", "auraRemovedFrame", content)
	auraRemovedFrame:SetPoint("TOPLEFT", auraAppliedFrame, "BOTTOMLEFT", 0, -16)
	auraRemovedFrame:SetSize(300, 300)
	auraRemovedFrame.title = auraRemovedFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	auraRemovedFrame.title:SetPoint("TOPLEFT", 0, 0)
	auraRemovedFrame.title:SetText("Aura Removed")
	GenerateSpellOptionsForCategory(auraRemovedFrame, "auraRemoved")
	local castStartFrame = CreateFrame("Frame", "castStartFrame", content)
	castStartFrame:SetPoint("TOPLEFT", auraRemovedFrame, "BOTTOMLEFT", 0, -16)
	castStartFrame:SetSize(300, 300)
	castStartFrame.title = castStartFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	castStartFrame.title:SetPoint("TOPLEFT", 0, 0)
	castStartFrame.title:SetText("Cast Start")
	GenerateSpellOptionsForCategory(castStartFrame, "castStart")
	local castSuccessFrame = CreateFrame("Frame", "castSuccessFrame", content)
	castSuccessFrame:SetPoint("TOPLEFT", castStartFrame, "BOTTOMLEFT", 0, -16)
	castSuccessFrame:SetSize(300, 300)
	castSuccessFrame.title = castSuccessFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	castSuccessFrame.title:SetPoint("TOPLEFT", 0, 0)
	castSuccessFrame.title:SetText("Cast Success")
	GenerateSpellOptionsForCategory(castSuccessFrame, "castSuccess")
	
	scrollbar:SetMinMaxValues(1, totalSize - 450)
	scrollframe.content = content

	scrollframe:SetScrollChild(content)

	InterfaceOptions_AddCategory(frame)
	frame:Hide();
	return frame;
end

function GenerateSpellOptionsForCategory (categoryFrame, key)
	local array = GetSpellList()
	local pos = -16
	for spell, pair in pairs(array[key]) do
		local spellName = spell
		local checkBtn = CreateFrame("CheckButton", "cb", categoryFrame, "UICheckButtonTemplate");
		checkBtn:SetPoint("TOPLEFT", 0, pos);
		checkBtn.text:SetText(spell);
		if pair[1] == 1 then
			checkBtn:SetChecked(true)
		end
		if pair[2] ~= "" then 
			spellName = pair[2]
		end
		checkBtn:SetScript("OnClick", 
		function()
			PlaySoundFile("Interface\\AddOns\\ClassicR14_SA\\audio\\" .. spellName .. ".mp3")
			if checkBtn:GetChecked() == true then
				if ClassicR14_SAConfig[key] == nil then
					ClassicR14_SAConfig[key] = {}
				end
				ClassicR14_SAConfig[key][spell] = 1
			else
				if ClassicR14_SAConfig[key] == nil then
					ClassicR14_SAConfig[key] = {}
				end
				ClassicR14_SAConfig[key][spell] = 0
			end
		end)
		pos = pos - 24
	end
	local count = pos * -1
	categoryFrame:SetSize(300, count)
	totalSize = totalSize + count
	return count
end