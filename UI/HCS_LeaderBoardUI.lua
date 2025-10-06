HCS_LeaderBoardUI = {}
HCS_LeaderBoardUI.rows = {}

local fontPath = "Interface\\Addons\\Hardcore_Score\\Fonts\\BebasNeue-Regular.ttf"
--local fontPath = "Fonts\\FRIZQT__.TTF"
local fontSize = 14  
local txtNumberColor = {
    red = 217 / 255,
    green = 190 / 255,
    blue = 132 / 255,
}

-- Create the frame
HCS_LeaderBoardUI.frame = CreateFrame("Frame", "LeaderBoardFrame", UIParent, "BackdropTemplate")
HCS_LeaderBoardUI.frame:Hide()  -- Hide!  In development
HCS_LeaderBoardUI.frame:SetPoint("CENTER")
HCS_LeaderBoardUI.frame:SetSize(200, 285)
HCS_LeaderBoardUI.frame:SetFrameStrata("LOW")
HCS_LeaderBoardUI.frame:SetClampedToScreen(true)
HCS_LeaderBoardUI.frame:SetScript("OnDragStart", HCS_LeaderBoardUI.frame.StartMoving)
HCS_LeaderBoardUI.frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    -- Save the new position
    local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()

    Hardcore_Score.db.profile.framePositionScoreboard = {
        point = point,
        relativeTo = relativeTo and relativeTo:GetName() or "UIParent",
        relativePoint = relativePoint,
        xOfs = xOfs,
        yOfs = yOfs,
        show = true,
    }
end)

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

-- Create an image at the top of the frame
--local topImage = HCS_LeaderBoardUI.frame:CreateTexture(nil, "BACKGROUND")

HCS_LeaderBoardUI.viewMode = "top"  -- 'top' for top scores, 'near' for scores near character

function HCS_LeaderBoardUI:RefreshData()
    if self.viewMode == "top" then
        self:LoadData() -- This method fetches the top 10
    else
        -- Check if the character is in the top 10
        local isCharInTop10 = false
        for i = 1, 10 do
            if HCS_LeaderBoardUI.rows[i] and HCS_LeaderBoardUI.rows[i][3] and HCS_LeaderBoardUI.rows[i][3]:GetText() == UnitName("player") then
                isCharInTop10 = true
                break
            end
        end

        -- If the character is not in the top 10, load data near character
        if not isCharInTop10 then
            self:LoadDataNearChar()
        end
    end
end

local topImageFrame = CreateFrame("Frame", nil, HCS_LeaderBoardUI.frame)
topImageFrame:SetPoint("TOP", HCS_LeaderBoardUI.frame, "TOP", 0, -5)
topImageFrame:SetSize(200, 40)
topImageFrame:EnableMouse(true)

local topImage = topImageFrame:CreateTexture(nil, "OVERLAY")
topImage:SetTexture("Interface\\Addons\\Hardcore_Score\\Media\\Scoreboard-Leaderboard.blp")
topImage:SetAllPoints(topImageFrame)

topImageFrame:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        if HCS_LeaderBoardUI.viewMode == "top" then
            HCS_LeaderBoardUI.viewMode = "near"
        else
            HCS_LeaderBoardUI.viewMode = "top"
        end
        HCS_LeaderBoardUI:RefreshData()
    end
end)

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
local columnSpacing = { 50, 80, 40 }  -- specify the spacing for each column

-- Create the header text objects
for i, header in ipairs(headers) do
    local offset = 50
    for j = 1, i - 1 do  -- calculate the total offset for this column
        offset = offset + columnSpacing[j]
    end
    if i == 1 then  -- Check if it's the "Score" column
        offset = offset - 10  -- Move 10 pixels to the left
    elseif i == 3 then  -- Check if it's the "Lvl" column
        offset = offset - 5  -- Move 5 pixels to the left
    end
    local text = HCS_LeaderBoardUI.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    text:SetPoint("TOPLEFT", HCS_LeaderBoardUI.frame, "TOPLEFT", offset, -50)
    text:SetText(header)
    local font, _, flags = text:GetFont()    
    text:SetFont(fontPath, fontSize, flags) -- Akira_Jimbo.ttf

end

-- Function to create/update a row
local function CreateRowForLeaderBoard(row, position, name, score, level, classid)
    local isPlayer = (name == UnitName("player"))

    local coloredName = HCS_Utils:GetTextWithClassColor(classid, name)
    local coloredLevel = "|cffff8000" .. tostring(level) .. "|r"

    if isPlayer then
       --coloredName = "|cffffff00" .. name .. "|r" -- |cffffff00 is the color code for yellow
       coloredLevel = "|cffffff00" .. tostring(level) .. "|r"
    end

    local dataPoints = { 
        HCS_Utils:AddThousandsCommas(tostring(score)),
        coloredName, 
        coloredLevel
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
        positionText:SetFont(fontPath, fontSize, flags) -- Set the desired font size (14 in this example)
    
        rowTable[0] = positionText
    end
    positionText:SetPoint("TOPLEFT", HCS_LeaderBoardUI.frame, "TOPLEFT", 15, -60 -row * 20)
    positionText:SetText(tostring(position))

    for i, data in ipairs(dataPoints) do
        local offset = 50
        for j = 1, i - 1 do
            offset = offset + columnSpacing[j]
        end
        if i == 1 then  -- Check if it's the "Score" column
            offset = offset - 10  -- Move 10 pixels to the left            
        elseif i == 3 then  -- Check if it's the "Lvl" column
            offset = offset - 5  -- Move 5 pixels to the left
        end
        local text = rowTable[i]
        if not text then
            text = HCS_LeaderBoardUI.frame:CreateFontString(nil, "OVERLAY")
            --text:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
            local font, _, flags = text:GetFont()
            text:SetFont(fontPath, fontSize, 14, flags) -- Set the desired font size (14 in this example)                
            rowTable[i] = text
        end
        text:SetPoint("TOPLEFT", HCS_LeaderBoardUI.frame, "TOPLEFT", offset, -60 -row * 20)
        text:SetText(data)

        if isPlayer then
            text:SetTextColor(1, 1, 0, 1) -- Yellow color for player
            positionText:SetTextColor(1, 1, 0, 1) -- Yellow color for player position          
        else
            if i == 1 then -- Score
                text:SetTextColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue, 1)
            end

            positionText:SetTextColor(1, 1, 1, 1) -- Assuming white is the default color for the position
        end
    end
end

-- Function to toggle frame visibility
function HCS_LeaderBoardUI:ToggleMyFrame()

    if HCS_LeaderBoardUI.frame:IsShown() then
        Hardcore_Score.db.profile.framePositionScoreboard.show = false
        HCS_LeaderBoardUI.frame:Hide()
    else
        Hardcore_Score.db.profile.framePositionScoreboard.show = true
        HCS_LeaderBoardUI.frame:Show()
    end
end

-- Function to toggle frame visibility
function HCS_LeaderBoardUI:SetVisibility()
    if Hardcore_Score.db.profile.framePositionScoreboard.show  then
        HCS_LeaderBoardUI.frame:Show()
    else
        HCS_LeaderBoardUI.frame:Hide()
    end
end

-- Function to load the data
function HCS_LeaderBoardUI:LoadData()
    -- Hide all rows
    for _, row in ipairs(HCS_LeaderBoardUI.rows) do
        for _, text in ipairs(row) do
            text:SetText("")
        end
    end

    -- Convert the leaderboard to an array
    local leaderboardArray = {}
    for charName, info in pairs(HCScore_Character.leaderboard) do
        --print("charName: " .. charName)
        info.charName = charName -- Add charName to each entry for later
        table.insert(leaderboardArray, info)
    end
    
    -- Filter by history retention if configured
    local profile = Hardcore_Score.db and Hardcore_Score.db.profile
    local now = time()
    if profile then
        local days = profile.keepHistory and (profile.historyDays or 0) or 0
        if days > 0 then
            local cutoff = now - (days * 24 * 60 * 60)
            local filtered = {}
            for _, info in ipairs(leaderboardArray) do
                local last = info.lastOnline
                local ts = 0
                if type(last) == "string" then
                    local y, m, d, H, M, S = last:match("(%d%d%d%d)%-(%d%d)%-(%d%d) (%d%d):(%d%d):(%d%d)")
                    if y then ts = time({year=tonumber(y), month=tonumber(m), day=tonumber(d), hour=tonumber(H), min=tonumber(M), sec=tonumber(S)}) or 0 end
                elseif type(last) == "number" then
                    ts = last
                end
                if days == 0 or ts == 0 or ts >= cutoff then
                    table.insert(filtered, info)
                end
            end
            leaderboardArray = filtered
        elseif not profile.keepHistory then
            leaderboardArray = {}
        end
    end

    -- Only-live filter and online-first sorting
    local function isOnlineNow(name)
        if not HCS_PublicOnline or not profile or not profile.sharePublic then return false end
        local seen = HCS_PublicOnline[name]
        if not seen then return false end
        return (now - seen) <= (HCS_PublicPresenceWindow or 180)
    end

    if profile and profile.sharePublic and profile.onlyLive then
        local filtered = {}
        for _, info in ipairs(leaderboardArray) do
            if isOnlineNow(info.charName) then
                table.insert(filtered, info)
            end
        end
        leaderboardArray = filtered
    end

    table.sort(leaderboardArray, function(a, b)
        local aOnline = isOnlineNow(a.charName) and 1 or 0
        local bOnline = isOnlineNow(b.charName) and 1 or 0
        if aOnline ~= bOnline then return aOnline > bOnline end
        return tonumber(a.coreScore) > tonumber(b.coreScore)
    end)

    local leaderboard = leaderboardArray

    -- Display only the top 10 scores, always include the player if present
    local maxRows = 10
    local added = 0
    for i = 1, #leaderboard do
        if added >= maxRows then break end
        local data = leaderboard[i]
        CreateRowForLeaderBoard(added + 1, i, data.charName, string.format("%.2f", data.coreScore), data.charLevel, data.charClass)
        added = added + 1
    end
    -- If the player wasn't in the displayed slice but exists, append them as the last row
    local me = HCScore_Character and HCScore_Character.name
    if me and HCScore_Character.leaderboard and HCScore_Character.leaderboard[me] then
        local present = false
        for r = 1, added do
            local row = HCS_LeaderBoardUI.rows[r]
            if row and row[2] and row[2]:GetText() and row[2]:GetText():find(me, 1, true) then
                present = true
                break
            end
        end
        if not present and added < maxRows then
            local data = HCScore_Character.leaderboard[me]
            CreateRowForLeaderBoard(added + 1, "-", data.charName, string.format("%.2f", data.coreScore), data.charLevel, data.charClass)
        end
    end
end

local function ClearRow(row)
    local rowTable = HCS_LeaderBoardUI.rows[row]
    if rowTable then
        for _, text in ipairs(rowTable) do
            text:SetText("")
        end
        if rowTable[0] then
            rowTable[0]:SetText("") -- Clearing the position number
        end
    end
end



-- Function to load the data centered around the character
function HCS_LeaderBoardUI:LoadDataNearChar()

    -- Hide all existing rows
    for _, row in ipairs(HCS_LeaderBoardUI.rows) do
        for _, text in ipairs(row) do
            text:SetText("")
        end
    end

    for i = 1, #HCS_LeaderBoardUI.rows do
        ClearRow(i)
    end    

    -- Convert the leaderboard to an array
    local leaderboardArray = {}
    for charName, info in pairs(HCScore_Character.leaderboard) do
        info.charName = charName
        table.insert(leaderboardArray, info)
    end

    -- Sort the array by score
    table.sort(leaderboardArray, function(a, b)
        return tonumber(a.coreScore) > tonumber(b.coreScore)
    end)

    -- Find the player's rank
    local playerRank = nil
    for i, data in ipairs(leaderboardArray) do
        if data.charName == HCScore_Character.name then
            playerRank = i
            break
        end
    end

    if playerRank == nil then
        return  -- Player not found in the leaderboard
    end

    -- Calculate the range of scores to display
    local startRank = math.max(1, playerRank - 5)
    local endRank = math.min(#leaderboardArray, playerRank + 4)

    -- Display the scores
    local rowIndex = 1
    for i = startRank, endRank do
        local data = leaderboardArray[i]
        CreateRowForLeaderBoard(rowIndex, i, data.charName, string.format("%.2f", data.coreScore), data.charLevel, data.charClass)
        rowIndex = rowIndex + 1
    end

end
