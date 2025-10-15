HCS_UpdateMessageUI = {}

-- Simple modal-like update popup that the user closes explicitly
-- API:
--   HCS_UpdateMessageUI.Show(versionText, highlights)
--   HCS_UpdateMessageUI.Hide()
--   HCS_UpdateMessageUI.IsShown()

local frame

local function CreateFrameOnce()
    if frame then return end

    frame = CreateFrame("Frame", "HCS_UpdateMessageFrame", UIParent, "BackdropTemplate")
    frame:SetSize(480, 260)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 120)
    frame:SetFrameStrata("DIALOG")
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

    -- Backdrop
    frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    frame:SetBackdropColor(0, 0, 0, 0.9)

    -- Title
    frame.Title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    local tFont, _, tFlags = frame.Title:GetFont()
    frame.Title:SetFont("Interface\\Addons\\Hardcore_Score\\Fonts\\Akira_Jimbo.ttf", 18, tFlags)
    frame.Title:SetPoint("TOP", frame, "TOP", 0, -18)
    frame.Title:SetTextColor(1, 0.82, 0)

    -- Highlights text
    frame.Text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    local fName, _, fFlags = frame.Text:GetFont()
    frame.Text:SetFont(fName, 12, fFlags)
    frame.Text:SetJustifyH("LEFT")
    frame.Text:SetWidth(420)
    frame.Text:SetPoint("TOP", frame.Title, "BOTTOM", 0, -16)

    -- Close button
    frame.CloseButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.CloseButton:SetSize(100, 24)
    frame.CloseButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 16)
    frame.CloseButton:SetText(CLOSE)
    frame.CloseButton:SetScript("OnClick", function()
        HCS_UpdateMessageUI.Hide()
    end)

    -- Optional: ESC to close
    frame:EnableKeyboard(true)
    frame:SetPropagateKeyboardInput(true)
    frame:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            HCS_UpdateMessageUI.Hide()
        end
    end)

    frame:Hide()
end

function HCS_UpdateMessageUI.Show(versionText, highlights)
    CreateFrameOnce()

    local title = string.format("Classic Score Update %s", tostring(versionText or ""))
    frame.Title:SetText(title)

    local msg = highlights or "Thanks for updating Classic Score!"
    frame.Text:SetText(msg)

    frame:Show()
end

function HCS_UpdateMessageUI.Hide()
    if frame then frame:Hide() end
end

function HCS_UpdateMessageUI.IsShown()
    return frame and frame:IsShown() or false
end
