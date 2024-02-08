local AceGUI = LibStub("AceGUI-3.0")

HCS_MainInfoFrameUI = {}
HCS_MainInfoFrameUI.frame = CreateFrame("Frame", "HCS_MainInfoFrame", UIParent, "BackdropTemplate")
HCS_MainInfoFrameUI.frame:SetSize(500, 500) -- Change this to the size you want
HCS_MainInfoFrameUI.frame:SetPoint("CENTER") -- Place the frame at the center

-- Make it draggable and resizable
HCS_MainInfoFrameUI.frame:EnableMouse(true)
HCS_MainInfoFrameUI.frame:SetMovable(true)
HCS_MainInfoFrameUI.frame:SetResizable(true)
HCS_MainInfoFrameUI.frame:RegisterForDrag("LeftButton")
HCS_MainInfoFrameUI.frame:SetScript("OnDragStart", HCS_MainInfoFrameUI.frame.StartMoving)
HCS_MainInfoFrameUI.frame:SetScript("OnDragStop", HCS_MainInfoFrameUI.frame.StopMovingOrSizing)
HCS_MainInfoFrameUI.frame:Hide()

-- Create a resize button
local resizeButton = CreateFrame("Button", nil, HCS_MainInfoFrameUI.frame)
resizeButton:SetSize(16, 16) -- You can change the size if you want
resizeButton:SetPoint("BOTTOMRIGHT") 
resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

resizeButton:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then 
        HCS_MainInfoFrameUI.frame:StartSizing("BOTTOMRIGHT")
        self:GetHighlightTexture():Hide() -- Hide highlight texture when dragging
    end 
end)

resizeButton:SetScript("OnMouseUp", function(self, button)
    HCS_MainInfoFrameUI.frame:StopMovingOrSizing()
    self:GetHighlightTexture():Show() -- Show highlight texture again
end)

-- Set backdrop with gradient background and border
HCS_MainInfoFrameUI.frame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
})
HCS_MainInfoFrameUI.frame:SetBackdropColor(0, 0, 0, 1)
HCS_MainInfoFrameUI.frame:SetBackdropBorderColor(1, 1, 1)

-- Create a close button
local closeButton = CreateFrame("Button", nil, HCS_MainInfoFrameUI.frame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", HCS_MainInfoFrameUI.frame, "TOPRIGHT", 0, 0)
closeButton:SetSize(32, 32) -- Adjust the size as needed
closeButton:SetScript("OnClick", function()
    HCS_MainInfoFrameUI.frame:Hide() -- Hide the frame when the button is clicked
end)

-- Create a title for the frame
local title = HCS_MainInfoFrameUI.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
title:SetPoint("LEFT", HCS_MainInfoFrameUI.frame, "TOPLEFT", 12, -15)
title:SetText("Classic Score")
title:SetTextColor(241/255, 194/255, 50/255)



local tabs = {"Milestones", "Scores", "Tab 3"} -- replace with your tabs
HCS_MainInfoFrameUI.tabs = {}

-- Add a panel for each tab
for i, tab in ipairs(tabs) do
    local panel = AceGUI:Create("SimpleGroup")
    panel:SetFullWidth(true)
    panel:SetFullHeight(true)
    panel:SetLayout("Fill")
    panel.frame:SetParent(HCS_MainInfoFrameUI.frame)
    panel.frame:SetPoint("TOPLEFT", 10, -30)
    panel.frame:SetPoint("BOTTOMRIGHT", -10, 10)
    panel.frame:Hide()

    HCS_MainInfoFrameUI[tab] = panel
end

-- Add the tabs
for i, tab in ipairs(tabs) do
    local tabFrame = CreateFrame("Button", "$parentTab"..i, HCS_MainInfoFrameUI.frame, "CharacterFrameTabButtonTemplate")
    tabFrame:SetPoint("BOTTOMLEFT", HCS_MainInfoFrameUI.frame, "BOTTOMLEFT", (i-1) * 90, -30)
    tabFrame:SetID(i)
    tabFrame:SetText(tab)

    tabFrame:SetScript("OnClick", function(self)
        PanelTemplates_SetTab(HCS_MainInfoFrameUI.frame, self:GetID())
        for j, tab in ipairs(tabs) do
            if j == self:GetID() then
                HCS_MainInfoFrameUI[tab].frame:Show()
            else
                HCS_MainInfoFrameUI[tab].frame:Hide()
            end
        end
    end)

    PanelTemplates_TabResize(tabFrame, 0)
    HCS_MainInfoFrameUI.tabs[i] = tabFrame
end

-- Set the number of tabs
HCS_MainInfoFrameUI.frame.numTabs = #tabs

-- Select the first tab
PanelTemplates_SetTab(HCS_MainInfoFrameUI.frame, 1)
HCS_MainInfoFrameUI[tabs[1]].frame:Show()

-- End of tab structure --