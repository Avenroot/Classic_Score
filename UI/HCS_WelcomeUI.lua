HCS_WelcomeUI = {}

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
title:SetText("Welcome to Hardcore Score")

-- Make the frame movable and resizable
frame:SetMovable(true)
frame:SetResizable(true)
frame:SetMinResize(100, 100)  -- set minimum size
frame:SetMaxResize(500, 500)  -- set maximum size
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
editBox:SetText("Welcome, adventurer, to the Hardcore Score addon! Designed to highlight your skill and dedication in World of Warcraft Classic Hardcore, this tool captures the essence of YOUR hard work, turning your character, "..playername..", into a true Hardcore legend."..
                "As fresh as a "..newSubzone.." recruit, our addon may still have some creases to iron out; we thank you in advance for your patience."..
                "Embrace your journey,  ".."|cFF6FA8DC"..playername.."|r".."! We're cheering you on every step of your epic quest. Here's to writing your own Hardcore history together in the expansive realm of Azeroth!")
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
