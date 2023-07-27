HCS_MessageFrameUI = {}

local messageStack = {}
local MESSAGE_FRAME_HEIGHT = 110
local MESSAGE_FRAME_MARGIN = 5
local FADE_OUT_TIME = 2

local function StackMessageFrame(frame)
    if #messageStack > 0 then
        local prevFrame = messageStack[#messageStack]
        frame:SetPoint("TOPLEFT", prevFrame, "BOTTOMLEFT", 0, -MESSAGE_FRAME_MARGIN)
    else
        frame:SetPoint("TOP", UIParent, "TOP", 0, -200) -- Adjust the vertical starting position here
    end
    table.insert(messageStack, frame)
end

local function UnstackMessageFrame(frame)
    local index = 0
    for i, f in ipairs(messageStack) do
        if f == frame then
            index = i
            break
        end
    end
    if index > 0 then
        table.remove(messageStack, index)
        for i = index, #messageStack do
            if i == 1 then
                messageStack[i]:SetPoint("TOP", UIParent, "TOP", 0, -200) -- Adjust the vertical position here
            else
                local prevFrame = messageStack[i - 1]
                messageStack[i]:SetPoint("TOPLEFT", prevFrame, "BOTTOMLEFT", 0, -MESSAGE_FRAME_MARGIN)
            end
        end
    end
end

-- Function to display a message and auto-hide the frame with fading effect
function HCS_MessageFrameUI.DisplaySingleMessage(msg, delay)
    local frame = CreateFrame("Frame", nil, UIParent)
    frame:SetSize(384, MESSAGE_FRAME_HEIGHT)
    frame:SetFrameStrata("MEDIUM")
    frame:Hide()

    -- Remove the backdrop to achieve borderless alpha blending
    -- frame:SetBackdrop({})

    local topImage, bottomImage = frame:CreateTexture(nil, "OVERLAY"), frame:CreateTexture(nil, "OVERLAY")
    topImage:SetSize(300, 1)  -- Thin line image at the top
    bottomImage:SetSize(300, 1)  -- Thin line image at the bottom
    topImage:SetPoint("TOP", frame, "TOP")
    bottomImage:SetPoint("BOTTOM", frame, "BOTTOM")

    local topImagePath = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-line2a.blp"
    local bottomImagePath = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-line2a.blp"

    if topImagePath then
        topImage:SetTexture(topImagePath)
    else
        topImage:SetColorTexture(1,1,1)  -- Default to a white line if no image is provided
    end

    if bottomImagePath then
        bottomImage:SetTexture(bottomImagePath)
    else
        bottomImage:SetColorTexture(1,1,1)  -- Default to a white line if no image is provided
    end

    frame.Text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.Text:SetPoint("CENTER", frame, "CENTER")
    frame.Text:SetText(msg)

    frame.ShowMessage = function()
        frame:Show()
        StackMessageFrame(frame)
        C_Timer.After(delay or 5, function()
            UIFrameFadeOut(frame, FADE_OUT_TIME, 1, 0)
            C_Timer.After(FADE_OUT_TIME, function()
                frame:Hide()
                UnstackMessageFrame(frame)
            end)
        end)
    end

    frame:Hide()

    return frame
end

function HCS_MessageFrameUI.DisplayLevelingMessage(lvlMsg, delay)
    local frame = CreateFrame("Frame", nil, UIParent)
    frame:SetSize(384, MESSAGE_FRAME_HEIGHT)
    frame:SetFrameStrata("MEDIUM")
    frame:Hide()

    local backgroundImage = frame:CreateTexture(nil, "BACKGROUND")
    backgroundImage:SetAllPoints(frame)
    backgroundImage:SetTexture("Interface\\Addons\\Hardcore_Score\\Media\\hcs-message-frame-background.blp")

    frame.Text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.Text:SetPoint("TOP", frame, "TOP", 0, -38)  -- Position it closer to the top of the frame
    frame.Text:SetText("You've Reached")
    frame.Text:SetTextColor(1, 1, 1)  -- Set the color to white

    frame.BigText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")  -- Larger font
    local fontName, _, fontFlags = frame.BigText:GetFont()
    frame.BigText:SetFont(fontName, 24, fontFlags)  -- Set the font size to 30
    frame.BigText:SetPoint("TOP", frame.Text, "BOTTOM", 0, -5)  -- Position it closer to the first text
    frame.BigText:SetText(lvlMsg or "")  -- The message to display
    frame.BigText:SetTextColor(1, 1, 0)  -- Set the color to yellow

    frame.ShowMessage = function()
        frame:Show()
        StackMessageFrame(frame)
        C_Timer.After(delay or 5, function()
            UIFrameFadeOut(frame, FADE_OUT_TIME, 1, 0)
            C_Timer.After(FADE_OUT_TIME, function()
                frame:Hide()
                UnstackMessageFrame(frame)
            end)
        end)
    end

    frame:Hide()

    return frame
end

function HCS_MessageFrameUI.DisplayMilestoneMessage(milestonemsg, milestoneimage, delay)
    local frame = CreateFrame("Frame", nil, UIParent)
    frame:SetSize(384, 96) --MESSAGE_FRAME_HEIGHT
    frame:SetFrameStrata("MEDIUM")
    frame:Hide()

    local milestoneFrame = frame:CreateTexture(nil, "BACKGROUND")
    milestoneFrame:SetAllPoints(frame)
    milestoneFrame:SetTexture("Interface\\Addons\\Hardcore_Score\\Media\\hcs-milestone-frame.tga")

    local milestoneImage = frame:CreateTexture(nil, "OVERLAY")
    milestoneImage:SetPoint("LEFT", frame, "LEFT", 42, 0) -- Adjust the position as needed
    milestoneImage:SetSize(48, 48) -- Adjust the size as needed
    milestoneImage:SetTexture(milestoneimage)

    frame.Text = frame:CreateFontString(nil, "OVERLAY")
    frame.Text:SetFont("Interface\\Addons\\Hardcore_Score\\Fonts\\LEMONMILK-Regular.otf", 10) -- Set the font to LEMONMILK-Regular and size to 16
    frame.Text:SetPoint("TOP", milestoneFrame, "TOP", 0, -44)  -- Position it closer to the top of the frame
    frame.Text:SetText(milestonemsg or "")  -- Set the milestone message
    frame.Text:SetTextColor(1, 1, 0)  -- Set the color to white

    frame.ShowMessage = function()
        frame:Show()
        StackMessageFrame(frame)
        -- Play the sound file when the frame is shown
        PlaySoundFile("Interface\\Addons\\Hardcore_Score\\Media\\achievement_sound.ogg", "Master")
        C_Timer.After(delay or 5, function()
            UIFrameFadeOut(frame, FADE_OUT_TIME, 1, 0)
            C_Timer.After(FADE_OUT_TIME, function()
                frame:Hide()
                UnstackMessageFrame(frame)
            end)
        end)
    end

    frame:Hide()

    return frame
end