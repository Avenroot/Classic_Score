HCS_CharactersInfoUI = {}
HCS_CharactersInfoUI.rows = {}

-- Create the frame
HCS_CharactersInfoUI.frame = CreateFrame("Frame", "CharactersInfoFrame", UIParent, "BackdropTemplate")
HCS_CharactersInfoUI.frame:SetPoint("CENTER")
HCS_CharactersInfoUI.frame:SetSize(700, 200)
HCS_CharactersInfoUI.frame:SetFrameStrata("LOW")
HCS_CharactersInfoUI.frame:SetClampedToScreen(true)

-- Set backdrop with gradient background and border
HCS_CharactersInfoUI.frame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Border_POW.blp", --"Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
})
HCS_CharactersInfoUI.frame:SetBackdropColor(0, 0, 0, 1)
HCS_CharactersInfoUI.frame:SetBackdropBorderColor(1, 1, 1)

-- Create a close button
local closeButton = CreateFrame("Button", nil, HCS_CharactersInfoUI.frame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", HCS_CharactersInfoUI.frame, "TOPRIGHT", 0, 0)
closeButton:SetSize(32, 32) -- Adjust the size as needed
closeButton:SetScript("OnClick", function()
    HCS_CharactersInfoUI.frame:Hide() -- Hide the frame when the button is clicked
end)

-- Create a title for the frame
local title = HCS_CharactersInfoUI.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
title:SetPoint("LEFT", HCS_CharactersInfoUI.frame, "TOPLEFT", 12, -15)
title:SetText("HCS Characters Summary")
title:SetTextColor(241/255, 194/255, 50/255)

-- Make the frame movable and resizable
HCS_CharactersInfoUI.frame:SetMovable(true)
HCS_CharactersInfoUI.frame:SetResizable(true)
if HCS_CharactersInfoUI.frame.SetResizeBounds then -- Support for 1.14.4
    HCS_CharactersInfoUI.frame:SetResizeBounds(700, 200) -- 
else
    HCS_CharactersInfoUI.frame:SetMinResize(700, 200) -- Support for 1.14.3
end
HCS_CharactersInfoUI.frame:EnableMouse(true)
HCS_CharactersInfoUI.frame:RegisterForDrag("LeftButton")
HCS_CharactersInfoUI.frame:SetScript("OnDragStart", HCS_CharactersInfoUI.frame.StartMoving)
HCS_CharactersInfoUI.frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    -- Save the new position
    local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()

    Hardcore_Score.db.profile.framePositionCharsInfo = {
        point = point,
        relativeTo = (relativeTo and relativeTo:GetName() and relativeTo:GetName() ~= "") and relativeTo:GetName() or "UIParent", --relativeTo = relativeTo and relativeTo:GetName() or "UIParent",
        relativePoint = relativePoint,
        xOfs = xOfs,
        yOfs = yOfs,
    }
end)

-- Create a resize frame
local resizeFrame = CreateFrame("Frame", nil, HCS_CharactersInfoUI.frame)
resizeFrame:SetPoint("BOTTOMRIGHT", HCS_CharactersInfoUI.frame, "BOTTOMRIGHT", 0, 0)
resizeFrame:SetSize(16, 16)
resizeFrame:SetFrameLevel(HCS_CharactersInfoUI.frame:GetFrameLevel() + 1)

-- Create a resize button
local resizeButton = CreateFrame("Button", nil, resizeFrame)
resizeButton:SetPoint("BOTTOMRIGHT", resizeFrame, "BOTTOMRIGHT", 0, 0)
resizeButton:SetSize(16, 16)
resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
resizeButton:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        HCS_CharactersInfoUI.frame:StartSizing("BOTTOMRIGHT")
        self:SetButtonState("PUSHED", true)
    end
end)
resizeButton:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        HCS_CharactersInfoUI.frame:StopMovingOrSizing()
        self:SetButtonState("NORMAL", false)
    end
end)

-- Create the scroll frame
local scrollFrame = CreateFrame("ScrollFrame", nil, HCS_CharactersInfoUI.frame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 16, -32)  --scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -50) -- adjust these as needed
scrollFrame:SetPoint("BOTTOMRIGHT", -30, 16) --scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -25, 5) -- adjust these as needed

-- Create the frame to hold the content (the rows)
local contentFrame = CreateFrame("Frame", nil, scrollFrame)
contentFrame:SetSize(scrollFrame:GetSize())
scrollFrame:SetScrollChild(contentFrame)

-- Update the frame script to adjust the scroll and content frames when the frame is resized
HCS_CharactersInfoUI.frame:SetScript("OnSizeChanged", function(self, width, height)
    -- Resize the scroll frame
    scrollFrame:SetWidth(width - 30) -- Adjust as needed
    scrollFrame:SetHeight(height - 70) -- Adjust as needed

    -- Resize the content frame
    contentFrame:SetWidth(scrollFrame:GetWidth())
end)

local headers = { "Name", "Gear", "Level", "Quest", "Mobs", "Prof", "Rep", "Disc", "Mile", "Score" }

local columnSpacing = { 85, 65, 65, 65, 65, 65, 65, 65, 65, 70 }  -- specify the spacing for each column

-- Create the header text objects
for i, header in ipairs(headers) do
    local offset = 14
    for j = 1, i - 1 do  -- calculate the total offset for this column
        offset = offset + columnSpacing[j]
    end
    local text = HCS_CharactersInfoUI.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    text:SetPoint("TOPLEFT", HCS_CharactersInfoUI.frame, "TOPLEFT", offset, -30)
    text:SetText(header)
end

-- Function to create/update a row
local function CreateRowForCharacter(row, characterName, characterScores)
    -- ...
    local dataPoints = { 
        HCS_Utils:GetTextWithClassColor(characterScores.charClassId, characterName),
        string.format("%.2f", characterScores.equippedGearScore), 
        string.format("%.2f", characterScores.levelingScore), 
        string.format("%.2f", characterScores.questingScore), 
        string.format("%.2f", characterScores.mobsKilledScore), 
        string.format("%.2f", characterScores.professionsScore),
        string.format("%.2f", characterScores.reputationScore),
        string.format("%.2f", characterScores.discoveryScore),
        string.format("%.2f", characterScores.milestonesScore),
        string.format("%.2f", characterScores.coreScore), 
    }

    local rowTable = HCS_CharactersInfoUI.rows[row]
    if not rowTable then
        rowTable = {}
        HCS_CharactersInfoUI.rows[row] = rowTable
    end

    for i, data in ipairs(dataPoints) do
        local offset = -2 --10
        for j = 1, i - 1 do  -- calculate the total offset for this column
            offset = offset + columnSpacing[j]
        end

        local text = rowTable[i]
        if not text then
            text = contentFrame:CreateFontString(nil, "OVERLAY")
            text:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
            rowTable[i] = text
        end

        text:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", offset, -row * 20)
        text:SetText(data)
    end
end

-- Function to load the data
function HCS_CharactersInfoUI:LoadData()
    -- Hide all rows
    for _, row in ipairs(HCS_CharactersInfoUI.rows) do
        for _, text in ipairs(row) do
            text:SetText("")
        end
    end

    local characters = Hardcore_Score.db.global.characterScores
    local i = 1
    for characterName, characterScores in pairs(characters) do
        if characterScores ~= nil then
            CreateRowForCharacter(i, characterName, characterScores)
            i = i + 1
        end
    end
    contentFrame:SetHeight(i * 20) -- adjust the contentFrame height
end

-- Function to toggle frame visibility
function HCS_CharactersInfoUI:ToggleMyFrame()
    if HCS_CharactersInfoUI.frame:IsShown() then
        HCS_CharactersInfoUI.frame:Hide()
    else
        HCS_CharactersInfoUI.frame:Show()
    end
end

