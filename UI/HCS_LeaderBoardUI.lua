HCS_LeaderBoardUI = {}
HCS_LeaderBoardUI.rows = {}

-- Create the frame
HCS_LeaderBoardUI.frame = CreateFrame("Frame", "LeaderBoardFrame", UIParent, "BackdropTemplate")
HCS_LeaderBoardUI.frame:Hide()  -- Hide!  In development
HCS_LeaderBoardUI.frame:SetPoint("CENTER")
HCS_LeaderBoardUI.frame:SetSize(200, 265)
HCS_LeaderBoardUI.frame:SetFrameStrata("LOW")
HCS_LeaderBoardUI.frame:SetClampedToScreen(true)
-- ... (The rest of your frame configuration can remain the same)

-- Set backdrop with gradient background and border
HCS_LeaderBoardUI.frame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Border_POW.blp", --"Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
})
HCS_LeaderBoardUI.frame:SetBackdropColor(0, 0, 0, 1)
HCS_LeaderBoardUI.frame:SetBackdropBorderColor(1, 1, 1)

--[[
-- Create a close button
local closeButton = CreateFrame("Button", nil, HCS_LeaderBoardUI.frame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", HCS_LeaderBoardUI.frame, "TOPRIGHT", 0, 0)
closeButton:SetSize(32, 32) -- Adjust the size as needed
closeButton:SetScript("OnClick", function()
    HCS_LeaderBoardUI.frame:Hide() -- Hide the frame when the button is clicked
end)

-- Create a title for the frame
local title = HCS_LeaderBoardUI.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
title:SetPoint("LEFT", HCS_LeaderBoardUI.frame, "TOPLEFT", 12, -15)
title:SetText("HCS Leaderboard")
title:SetTextColor(241/255, 194/255, 50/255)

]]

-- Make the frame movable and resizable
HCS_LeaderBoardUI.frame:SetMovable(true)

HCS_LeaderBoardUI.frame:EnableMouse(true)
HCS_LeaderBoardUI.frame:RegisterForDrag("LeftButton")
HCS_LeaderBoardUI.frame:SetScript("OnDragStart", HCS_LeaderBoardUI.frame.StartMoving)
HCS_LeaderBoardUI.frame:SetScript("OnDragStop", function(self)
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

-- Update headers and columnSpacing
local headers = { "Score", "Name", "Lvl" }
local columnSpacing = { 40, 80, 40 }  -- specify the spacing for each column

-- Create the header text objects
for i, header in ipairs(headers) do
    local offset = 50
    for j = 1, i - 1 do  -- calculate the total offset for this column
        offset = offset + columnSpacing[j]
    end
    local text = HCS_LeaderBoardUI.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    text:SetPoint("TOPLEFT", HCS_LeaderBoardUI.frame, "TOPLEFT", offset, -30)
    text:SetText(header)
    local font, _, flags = text:GetFont()
    text:SetFont("Interface\\Addons\\Hardcore_Score\\Fonts\\Akira_Jimbo.ttf", 14, flags) -- Set the desired font size (14 in this example)

end

-- Function to create/update a row
local function CreateRowForLeaderBoard(row, position, name, score, level)
    local dataPoints = { 
        tostring(score),
        name, 
        tostring(level)
    }
    local rowTable = HCS_LeaderBoardUI.rows[row]
    if not rowTable then
        rowTable = {}
        HCS_LeaderBoardUI.rows[row] = rowTable
    end

    -- Create position text
    local positionText = rowTable[0]
    if not positionText then
        positionText = HCS_LeaderBoardUI.frame:CreateFontString(nil, "OVERLAY")
        --positionText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
        local font, _, flags = positionText:GetFont()
        positionText:SetFont("Interface\\Addons\\Hardcore_Score\\Fonts\\Akira_Jimbo.ttf", 14, flags) -- Set the desired font size (14 in this example)
    
        rowTable[0] = positionText
    end
    positionText:SetPoint("TOPLEFT", HCS_LeaderBoardUI.frame, "TOPLEFT", 15, -40 -row * 20)
    positionText:SetText(tostring(position))

    for i, data in ipairs(dataPoints) do
        local offset = 50
        for j = 1, i - 1 do
            offset = offset + columnSpacing[j]
        end
        local text = rowTable[i]
        if not text then
            text = HCS_LeaderBoardUI.frame:CreateFontString(nil, "OVERLAY")
            --text:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
            local font, _, flags = text:GetFont()
            text:SetFont("Interface\\Addons\\Hardcore_Score\\Fonts\\Akira_Jimbo.ttf", 14, flags) -- Set the desired font size (14 in this example)                
            rowTable[i] = text
        end
        text:SetPoint("TOPLEFT", HCS_LeaderBoardUI.frame, "TOPLEFT", offset, -40 -row * 20)
        text:SetText(data)
    end
end

-- Function to load the data (with test data)
function HCS_LeaderBoardUI:LoadData()
    -- Hide all rows
    for _, row in ipairs(HCS_LeaderBoardUI.rows) do
        for _, text in ipairs(row) do
            text:SetText("")
        end
    end

    -- Example test data for 1-10 positions
    local exampleData = {
        { name = "Player1", score = 1000, level = 60 },
        { name = "Player2", score = 900, level = 59 },
        { name = "Player3", score = 850, level = 58 },
        { name = "Player4", score = 800, level = 57 },
        { name = "Player5", score = 750, level = 56 },
        { name = "Player6", score = 700, level = 55 },
        { name = "Player7", score = 650, level = 54 },
        { name = "Player8", score = 600, level = 53 },
        { name = "Player9", score = 550, level = 52 },
        { name = "Player10", score = 500, level = 51 }
    }

    for i, data in ipairs(exampleData) do
        CreateRowForLeaderBoard(i, i, data.name, data.score, data.level)
    end

end

-- ... (The rest of your code can remain the same)
-- Function to toggle frame visibility
function HCS_LeaderBoardUI:ToggleMyFrame()

--    if HCS_LeaderBoardUI.frame:IsShown() then
--        HCS_LeaderBoardUI.frame:Hide()
--    else
--        HCS_LeaderBoardUI.frame:Show()
--    end
end



