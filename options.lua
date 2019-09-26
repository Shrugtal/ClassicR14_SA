local _, namespace = ...
local GetSpellList = namespace.GetSpellList

function namespace:GetOptionsFrame ()
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
	return frame;
end