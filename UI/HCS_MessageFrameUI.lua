HCS_MessageFrameUI = {}

local messageStack = {}
local MESSAGE_FRAME_HEIGHT = 50
local MESSAGE_FRAME_MARGIN = 5
local FADE_OUT_TIME = 2

local function StackMessageFrame(frame)
    if #messageStack > 0 then
        local prevFrame = messageStack[#messageStack]
        frame:SetPoint("TOPLEFT", prevFrame, "BOTTOMLEFT", 0, -MESSAGE_FRAME_MARGIN)
    else
        frame:SetPoint("TOP", UIParent, "TOP", 0, -150) -- Adjust the vertical starting position here
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
                messageStack[i]:SetPoint("TOP", UIParent, "TOP", 0, -150) -- Adjust the vertical position here
            else
                local prevFrame = messageStack[i - 1]
                messageStack[i]:SetPoint("TOPLEFT", prevFrame, "BOTTOMLEFT", 0, -MESSAGE_FRAME_MARGIN)
            end
        end
    end
end

-- Function to display a message and auto-hide the frame with fading effect
function HCS_MessageFrameUI.DisplayMessage(msg, delay, imagePath)
    local frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    frame:SetSize(300, MESSAGE_FRAME_HEIGHT)
    frame:SetFrameStrata("MEDIUM")
    frame:Hide()

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

    local defaultImagePath = Img_hcs_greyframe_32
    local image = frame:CreateTexture(nil, "OVERLAY")
    image:SetSize(32, 32)
    image:SetPoint("LEFT", 10, 0) -- Adjust the horizontal positioning here

    if imagePath then
        image:SetTexture(imagePath)
    else
        image:SetTexture(defaultImagePath)
    end

    frame.Text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.Text:SetPoint("LEFT", image, "RIGHT", 10, 0) -- Adjust the horizontal positioning here
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
