HCS_WelcomeUI = {}

local message = [[
    Rank / Level
    
    Bronze RANK 1
    Bronze RANK 1 LEVEL 1
    Bronze RANK 1 LEVEL 2
    Bronze RANK 1 LEVEL 3
    Bronze RANK 1 LEVEL 4
    
    Silver RANK 2
    Silver RANK 2 LEVEL 1
    Silver RANK 2 LEVEL 2
    Silver RANK 2 LEVEL 3
    Silver RANK 2 LEVEL 4
    
    Gold RANK 3
    Gold RANK 3 LEVEL 1
    Gold RANK 3 LEVEL 2
    Gold RANK 3 LEVEL 3
    Gold RANK 3 LEVEL 4
    
    Platinum RANK 4
    Platinum RANK 4 LEVEL 1
    Platinum RANK 4 LEVEL 2
    Platinum RANK 4 LEVEL 3
    Platinum RANK 4 LEVEL 4
    
    Diamond RANK 5
    Diamond RANK 5 LEVEL 1
    Diamond RANK 5 LEVEL 2
    Diamond RANK 5 LEVEL 3
    Diamond RANK 5 LEVEL 4
    
    Epic RANK 6
    Epic RANK 6 LEVEL 1
    Epic RANK 6 LEVEL 2
    Epic RANK 6 LEVEL 3
    Epic RANK 6 LEVEL 4
    
    Legendary RANK 7
    Legendary RANK 7 LEVEL 1
    Legendary RANK 7 LEVEL 2
    Legendary RANK 7 LEVEL 3
    Legendary RANK 7 LEVEL 4
    ]]    

-- Create the frame
local frame = CreateFrame("Frame", "MyFrame", UIParent, "DialogBoxFrame")
frame:SetPoint("CENTER")
frame:SetSize(300, 200)

-- Create a background for the title
local titleBackground = frame:CreateTexture(nil, "BACKGROUND")
titleBackground:SetColorTexture(0, 0, 1, 0.5)  -- Set the color to semi-transparent blue
titleBackground:SetPoint("TOPLEFT", 8, -8)
titleBackground:SetPoint("TOPRIGHT", -8, -8)
titleBackground:SetHeight(24)  -- Set the height

-- Create a title for the frame
local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
title:SetPoint("LEFT", titleBackground, "LEFT", 4, 0)

--local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
--title:SetPoint("TOPLEFT", 8, -8)
title:SetText("Rank / Level system")

-- Make the frame movable and resizable
frame:SetMovable(true)
frame:SetResizable(true)
--frame:SetMinResize(100, 100)  -- set minimum size
--frame:SetMaxResize(500, 500)  -- set maximum size
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:SetScript("OnSizeChanged", function(self, width, height)
    -- Update scrollframe and editbox size here if necessary
end)

-- Create a close button
local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT")

-- Create a scrollframe
local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 16, -32)  -- Adjust the position to leave space for the title
scrollFrame:SetPoint("BOTTOMRIGHT", -30, 16)

-- Create an edit box for multi-line text
local playername = UnitName("player")
local newSubzone = GetSubZoneText()

if newSubzone == "" then 
    newSubzone = GetZoneText()
end


local editBox = CreateFrame("EditBox", nil, scrollFrame)
editBox:SetMultiLine(true)
editBox:SetFontObject(ChatFontNormal)
editBox:SetWidth(250)
editBox:SetText(message)
editBox:Disable()  -- This makes the text read-only
scrollFrame:SetScrollChild(editBox)

-- Remove the OK button from the DialogBoxFrame
for _, child in ipairs({frame:GetChildren()}) do
    if child:GetObjectType() == "Button" and child:GetText() == OKAY then
        child:Hide()
    end
end

-- Function to toggle frame visibility
function HCS_WelcomeUI:ToggleMyFrame()
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end
