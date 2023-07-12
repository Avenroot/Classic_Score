-- Globals / Namespace
HCS_PointsLogUI = {}

-- Create a table to store chat history
HCS_PointsLogUI.chatHistory = {}

-- Create the frame
HCS_PointsLogUI.frame = CreateFrame("Frame", "PointsLogFrame", UIParent, "BackdropTemplate")
HCS_PointsLogUI.frame:SetPoint("CENTER")
HCS_PointsLogUI.frame:SetSize(300, 200)
HCS_PointsLogUI.frame:SetFrameStrata("LOW")
HCS_PointsLogUI.frame:SetClampedToScreen(true)

-- Set backdrop with gradient background and border
HCS_PointsLogUI.frame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
})

HCS_PointsLogUI.frame:SetBackdropColor(0, 0, 0, 1)
HCS_PointsLogUI.frame:SetBackdropBorderColor(1, 1, 1)

-- Create a title for the frame
local title = HCS_PointsLogUI.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
title:SetPoint("LEFT", HCS_PointsLogUI.frame, "TOPLEFT", 10, -15)
title:SetText("Hardcore Score Points Log")
title:SetTextColor(241/255, 194/255, 50/255)

-- Make the frame movable and resizable
HCS_PointsLogUI.frame:SetMovable(true)
HCS_PointsLogUI.frame:SetResizable(true)
if HCS_PointsLogUI.frame.SetResizeBounds then -- Support for 1.4.14
    HCS_PointsLogUI.frame:SetResizeBounds(200, 100) -- 
else
    HCS_PointsLogUI.frame:SetMinResize(200, 100) -- Support for 1.4.13
    HCS_PointsLogUI.frame:SetMaxResize(500, 500)
end
HCS_PointsLogUI.frame:EnableMouse(true)
HCS_PointsLogUI.frame:RegisterForDrag("LeftButton")
HCS_PointsLogUI.frame:SetScript("OnDragStart", HCS_PointsLogUI.frame.StartMoving)
HCS_PointsLogUI.frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    -- Save the new position
    local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()

    Hardcore_Score.db.profile.framePositionLog = {
        point = point,
        relativeTo = relativeTo and relativeTo:GetName() or "UIParent",
        relativePoint = relativePoint,
        xOfs = xOfs,
        yOfs = yOfs,
        show = true,
    }
end)

-- Create a close button
local closeButton = CreateFrame("Button", nil, HCS_PointsLogUI.frame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT")
closeButton:Hide()

-- Create a scrollframe
HCS_PointsLogUI.scrollFrame = CreateFrame("ScrollFrame", nil, HCS_PointsLogUI.frame, "UIPanelScrollFrameTemplate")
HCS_PointsLogUI.scrollFrame:SetPoint("TOPLEFT", 16, -32)  -- Adjust the position to leave space for the title
HCS_PointsLogUI.scrollFrame:SetPoint("BOTTOMRIGHT", -30, 16)

-- Create an edit box for multi-line text
HCS_PointsLogUI.EditBox = CreateFrame("EditBox", nil, HCS_PointsLogUI.scrollFrame)
HCS_PointsLogUI.EditBox:SetMultiLine(true)
HCS_PointsLogUI.EditBox:SetFontObject(ChatFontNormal)
HCS_PointsLogUI.EditBox:SetWidth(250)
HCS_PointsLogUI.EditBox:Disable()  -- This makes the text read-only
HCS_PointsLogUI.scrollFrame:SetScrollChild(HCS_PointsLogUI.EditBox)

-- Function to toggle frame visibility
function HCS_PointsLogUI:ToggleMyFrame()
    if HCS_PointsLogUI.frame:IsShown() then
        HCS_PointsLogUI.frame:Hide()
    else
        HCS_PointsLogUI.frame:Show()
    end
end

-- Function to toggle frame visibility
function HCS_PointsLogUI:SetVisibility()
    if Hardcore_Score.db.profile.framePositionLog.show  then
        HCS_PointsLogUI.frame:Show()
    else
        HCS_PointsLogUI.frame:Hide()
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
    HCS_PointsLogUI.EditBox:SetText(table.concat(self.chatHistory, "\n"))

    -- Scroll to the bottom
    C_Timer.After(0.1, function()  -- Slightly delay to let the UI update first
        HCS_PointsLogUI.scrollFrame:UpdateScrollChildRect()  -- Update scroll child rectangle
        local _, maxScroll = HCS_PointsLogUI.scrollFrame.ScrollBar:GetMinMaxValues()
        HCS_PointsLogUI.scrollFrame.ScrollBar:SetValue(maxScroll)
    end)
end

-- Set the script for resizing
HCS_PointsLogUI.frame:SetScript("OnSizeChanged", function(self, width, height)
    HCS_PointsLogUI.scrollFrame:SetWidth(width - 36)
    HCS_PointsLogUI.scrollFrame:SetHeight(height - 50)
    HCS_PointsLogUI.EditBox:SetWidth(width - 36)
    HCS_PointsLogUI.EditBox:SetHeight(height - 50)
end)

-- Create a resize button
local resizeButton = CreateFrame("Button", nil, HCS_PointsLogUI.frame)
resizeButton:SetPoint("BOTTOMRIGHT", -5, 5)
resizeButton:SetSize(16, 16)
resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
resizeButton:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        HCS_PointsLogUI.frame:StartSizing("BOTTOMRIGHT")
        self:SetButtonState("PUSHED", true)
    end
end)
resizeButton:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        HCS_PointsLogUI.frame:StopMovingOrSizing()
        self:SetButtonState("NORMAL", false)
    end
end)