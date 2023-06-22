HCS_PointsLogUI = {}

-- Create a table to store chat history
HCS_PointsLogUI.chatHistory = {}

-- Create the frame
local frame = CreateFrame("Frame", "MyFrame", UIParent, "BackdropTemplate")
frame:SetPoint("CENTER")
frame:SetSize(300, 200)
frame:SetFrameStrata("LOW")
frame:SetClampedToScreen(true)

-- Set backdrop with gradient background and border
frame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
})
frame:SetBackdropColor(0, 0, 0, 1)
frame:SetBackdropBorderColor(1, 1, 1)

-- Create a title for the frame
local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
title:SetPoint("LEFT", frame, "TOPLEFT", 10, -15)
title:SetText("Hardcore Score Points Log")
title:SetTextColor(241/255, 194/255, 50/255)

-- Make the frame movable and resizable
frame:SetMovable(true)
frame:SetResizable(true)
frame:SetMinResize(100, 100)  -- set minimum size
frame:SetMaxResize(500, 500)  -- set maximum size
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)

frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    -- Save the new position
    local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()

    Hardcore_Score.db.profile.framePositionLog = {
        point = point,
        relativeTo = relativeTo,
        relativePoint = relativePoint,
        xOfs = xOfs,
        yOfs = yOfs,
    }        
end)

-- Create a close button
local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT")

-- Create a scrollframe
local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 16, -32)  -- Adjust the position to leave space for the title
scrollFrame:SetPoint("BOTTOMRIGHT", -30, 16)

-- Create an edit box for multi-line text
local editBox = CreateFrame("EditBox", nil, scrollFrame)
editBox:SetMultiLine(true)
editBox:SetFontObject(ChatFontNormal)
editBox:SetWidth(250)
editBox:Disable()  -- This makes the text read-only
scrollFrame:SetScrollChild(editBox)

-- Function to toggle frame visibility
function HCS_PointsLogUI:ToggleMyFrame()
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end

-- Function to toggle frame visibility
function HCS_PointsLogUI:SetVisibility()
    if Hardcore_Score.db.profile.framePositionLog.show  then
        frame:Show()
    else
        frame:Hide()
    end
end

-- Function to add a new message to the chat history
function HCS_PointsLogUI:AddMessage(msg)
    -- Add new message to the chat history
    table.insert(self.chatHistory, msg)
    
    -- Limit the chat history to the last 100 messages
    if #self.chatHistory > 100 then
        table.remove(self.chatHistory, 1)
    end

    -- Update the text in the editBox
    editBox:SetText(table.concat(self.chatHistory, "\n"))

    -- Scroll to the bottom
    C_Timer.After(0.1, function()  -- Slightly delay to let the UI update first
        scrollFrame:UpdateScrollChildRect()  -- Update scroll child rectangle
        local _, maxScroll = scrollFrame.ScrollBar:GetMinMaxValues()
        scrollFrame.ScrollBar:SetValue(maxScroll)
    end)
end



-- Set the script for resizing
frame:SetScript("OnSizeChanged", function(self, width, height)
    scrollFrame:SetWidth(width - 36)
    scrollFrame:SetHeight(height - 50)
    editBox:SetWidth(width - 36)
    editBox:SetHeight(height - 50)
end)

-- Create a resize button
local resizeButton = CreateFrame("Button", nil, frame)
resizeButton:SetPoint("BOTTOMRIGHT", -5, 5)
resizeButton:SetSize(16, 16)
resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
resizeButton:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        frame:StartSizing("BOTTOMRIGHT")
        self:SetButtonState("PUSHED", true)
    end
end)
resizeButton:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        frame:StopMovingOrSizing()
        self:SetButtonState("NORMAL", false)
    end
end)