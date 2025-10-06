HCS_AllInfoUI = {}


local AceGUI = LibStub("AceGUI-3.0")

--local fontPath = "Interface\\Addons\\Hardcore_Score\\Fonts\\BebasNeue-Regular.ttf"
local fontPath = "Fonts\\FRIZQT__.TTF"
local fontSize = 11  
local txtNumberColor = {
    red = 217 / 255,
    green = 190 / 255,
    blue = 132 / 255,
}
local txtColumnColor = {
    red = 255 / 255,
    green = 223 / 255,
    blue = 0 / 255,
}
local wowGreenColor = {
    red = 30 / 255,
    green = 255 / 255,
    blue = 0 / 255,
}

local difficultyNames = {
    [-6] = "Trivial",
    [-5] = "Laughable",
    [-4] = "Easy",
    [-3] = "Routine",
    [-2] = "Unchallenging",
    [-1] = "Slightly Tough",
    [0]  = "Standard",
    [1]  = "Challenging",
    [2]  = "Dangerous",
    [3]  = "Formidable",
    [4]  = "Deadly",
    [5]  = "Heroic",
    [6]  = "Legendary"
}

-- Define the color structure based on difficulty
local difficultyColors = {
    [6]  = "|cffFF0000",  -- Red (Legendary)
    [5]  = "|cffFF4500",  -- Red-Orange (Heroic)
    [4]  = "|cffFF4500",  -- Orange (Deadly)
    [3]  = "|cffFFA500",  -- Orange (Formidable)
    [2]  = "|cffFFA500",  -- Orange (Dangerous)
    [1]  = "|cffFFD700",  -- Yellow (Challenging)
    [0]  = "|cffFFD700",  -- Yellow (Standard)
    [-1] = "|cffFFD700",  -- Yellow (Slightly Tough)
    [-2] = "|cffFFD700",  -- Green (Unchallenging)
    [-3] = "|cff32CD32",  -- Green (Routine)
    [-4] = "|cff32CD32",  -- Green (Easy)
    [-5] = "|cffA9A9A9",  -- Grey (Laughable)
    [-6] = "|cffA9A9A9",  -- Grey (Trivial)
}


HCS_AllInfoUI.frame = CreateFrame("Frame", "LeaderBoardFrame", UIParent, "BackdropTemplate")
HCS_AllInfoUI.frame:Hide()
HCS_AllInfoUI.frame:SetFrameStrata("MEDIUM")
HCS_AllInfoUI.frame:SetSize(850, 475) -- Change as needed
HCS_AllInfoUI.frame:SetPoint("CENTER")
HCS_AllInfoUI.frame:SetClampedToScreen(true)

-- Set backdrop with gradient background and border
HCS_AllInfoUI.frame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Border_POW.blp", --"Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
})
HCS_AllInfoUI.frame:SetBackdropColor(0, 0, 0, 1)
HCS_AllInfoUI.frame:SetBackdropBorderColor(1, 1, 1)

-- Make the frame movable
HCS_AllInfoUI.frame:SetMovable(true)
HCS_AllInfoUI.frame:EnableMouse(true)
HCS_AllInfoUI.frame:RegisterForDrag("LeftButton")
HCS_AllInfoUI.frame:SetScript("OnDragStart", HCS_AllInfoUI.frame.StartMoving)
HCS_AllInfoUI.frame:SetScript("OnDragStop", HCS_AllInfoUI.frame.StopMovingOrSizing)

-- Make the frame resizable
HCS_AllInfoUI.frame:SetResizable(true)
HCS_AllInfoUI.frame:SetResizeBounds(300, 200) 
HCS_AllInfoUI.frame:SetScript("OnSizeChanged", function(self, width, height)
    -- This callback can be used to adjust internal UI elements when the frame is resized.
    -- For now, it does nothing, but you can use it later if needed. 
    
end)

-- Create a basic font string for the label on top of the frame
local tabLabel = HCS_AllInfoUI.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
--tabLabel:SetPoint("TOP", HCS_AllInfoUI.frame, "TOP", 0, -10) -- Adjust the Y-offset if needed for precise positioning
tabLabel:SetPoint("TOPLEFT", HCS_AllInfoUI.frame, "TOPLEFT", 10, -10)  -- This sets the text to the top left
local _, _, classid = UnitClass("player")
tabLabel:SetText("Classic Score - This is "..HCS_Utils:GetTextWithClassColor(classid, UnitName("player").."'s Journey"))

local frameContainer = AceGUI:Create("SimpleGroup")
frameContainer:SetLayout("Fill") -- So child elements can take up the whole space
frameContainer:SetFullWidth(true)
frameContainer:SetFullHeight(true)
frameContainer.frame:SetParent(HCS_AllInfoUI.frame)

-- Define separate padding values for each side
local paddingLeft = 10
local paddingRight = 10
local paddingTop = 40
local paddingBottom = 20

-- Adjust the anchoring of the frameContainer using the separate padding values
frameContainer.frame:SetPoint("TOPLEFT", paddingLeft, -paddingTop)
frameContainer.frame:SetPoint("BOTTOMRIGHT", -paddingRight, paddingBottom)

-- Add the close button
local closeButton = CreateFrame("Button", nil, HCS_AllInfoUI.frame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", HCS_AllInfoUI.frame, "TOPRIGHT", -5, -5)
closeButton:SetScript("OnClick", function()
    HCS_AllInfoUI.frame:Hide()
end)

-- Create the TabGroup
local tabGroup = AceGUI:Create("TabGroup")
tabGroup:SetLayout("Flow") -- The layout inside the tabs
local _, _, classid = UnitClass("player")
local charName = HCS_Utils:GetTextWithClassColor(classid, UnitName("player"))

tabGroup:SetTabs({
    {text=charName, value="Info"},
    {text="Achievements", value="Achievements"},
    {text="Milestones", value="Milestones"},
    {text="Characters", value="Characters"},
    {text="Leaderboard", value="Leaderboard"},
    {text="Mobs Killed Info", value="MobsKilledInfo"},

})

local currentPage = 1
local itemsPerPage = 10  -- or whatever number works best 

-- Function to populate the Milestones content
local function PopulateMilestonesContent(container)
    container:ReleaseChildren()

    -- Header Group
    local headerGroup = AceGUI:Create("SimpleGroup")
    headerGroup:SetFullWidth(true)
    headerGroup:SetLayout("Flow")

    -- Placeholder for icon width
    local iconPlaceholder = AceGUI:Create("Label")
    iconPlaceholder:SetText("")
    iconPlaceholder:SetWidth(50)  
    headerGroup:AddChild(iconPlaceholder)

    -- Header Widgets
    local pointsHeader = AceGUI:Create("Label")
    pointsHeader:SetFont(fontPath, fontSize, "OUTLINE")
    pointsHeader:SetText("Points")
    pointsHeader:SetWidth(80)
    headerGroup:AddChild(pointsHeader)

    local shortdescHeader = AceGUI:Create("Label")
    shortdescHeader:SetFont(fontPath, fontSize, "OUTLINE")
    shortdescHeader:SetText("Milestone")
    shortdescHeader:SetWidth(200)
    headerGroup:AddChild(shortdescHeader)

    local descHeader = AceGUI:Create("Label")
    descHeader:SetFont(fontPath, fontSize, "OUTLINE")
    descHeader:SetText("Description")
    descHeader:SetWidth(400)
    headerGroup:AddChild(descHeader)

    container:AddChild(headerGroup)

    -- Data Rows
    local scrollframe = AceGUI:Create("ScrollFrame")
    scrollframe:SetLayout("List")
    scrollframe:SetFullWidth(true)
    scrollframe:SetFullHeight(false)
    scrollframe:SetHeight(308)

    local startIndex = (currentPage - 1) * itemsPerPage + 1
    local endIndex = math.min(startIndex + itemsPerPage - 1, #HCS_MilestonesDB)

    for i = startIndex, endIndex do
        local milestone = HCS_MilestonesDB[i]
        if not milestone then break end  -- exit if we've run out of data

        local completed = HCS_MilestonesScore:AchievedMilestone(milestone.id)

        -- Parsing achievement.id to get the part of the string between underscores.
        local header = milestone.name  --achievement.id:match("ach_(.-)_")

        -- If the parsed header has changed, create a new Heading widget.
        if header ~= lastHeader then
            local heading = AceGUI:Create("Heading")
            heading:SetText(header:upper())  -- uppercasing the header
            heading:SetFullWidth(true)
            scrollframe:AddChild(heading)
            lastHeader = header
        end        
        
        local rowGroup = AceGUI:Create("SimpleGroup")
        rowGroup:SetLayout("Flow")
        rowGroup:SetFullWidth(true)
        
        local icon = AceGUI:Create("Icon")
        icon:SetImage("Interface\\RaidFrame\\ReadyCheck-Ready")
        icon:SetImageSize(24,24)
        icon:SetLabel("")
        icon:SetWidth(50)
        icon:SetDisabled(true)
        if completed then icon:SetDisabled(false) end
        rowGroup:AddChild(icon)


        local pointsLabel = AceGUI:Create("Label")
        pointsLabel:SetFont(fontPath, fontSize, "OUTLINE")
        pointsLabel:SetText(milestone.points .. " points")
        if completed then pointsLabel:SetColor(wowGreenColor.red, wowGreenColor.green, wowGreenColor.blue) end
        pointsLabel:SetWidth(80)
        rowGroup:AddChild(pointsLabel)

        local shortdescLabel = AceGUI:Create("Label")
        shortdescLabel:SetFont(fontPath, fontSize, "OUTLINE")
        shortdescLabel:SetText(milestone.shortdesc)
        if completed then shortdescLabel:SetColor(wowGreenColor.red, wowGreenColor.green, wowGreenColor.blue) end
        shortdescLabel:SetWidth(200)
        rowGroup:AddChild(shortdescLabel)

        local descLabel = AceGUI:Create("Label")
        descLabel:SetFont(fontPath, fontSize, "OUTLINE")
        descLabel:SetText(milestone.desc)
        if completed then descLabel:SetColor(wowGreenColor.red, wowGreenColor.green, wowGreenColor.blue) end
        descLabel:SetWidth(400)
        rowGroup:AddChild(descLabel)

        scrollframe:AddChild(rowGroup)
    end

    container:AddChild(scrollframe)

    -- Add navigation buttons
    local buttonWidth = 80  
    local buttonHeight = 20 
    
    local navGroup = AceGUI:Create("SimpleGroup")
    navGroup:SetFullWidth(true)
    navGroup:SetLayout("Flow")

    local prevButton = AceGUI:Create("Button")
    prevButton:SetText("< Previous")
    prevButton:SetWidth(buttonWidth)
    prevButton:SetHeight(buttonHeight)
    prevButton:SetCallback("OnClick", function()
        if currentPage > 1 then
            currentPage = currentPage - 1
            PopulateMilestonesContent(container)
        end
    end)
    prevButton:SetDisabled(currentPage == 1) -- Disables "Previous" button on the first page

    navGroup:AddChild(prevButton)

    local nextButton = AceGUI:Create("Button")
    nextButton:SetText("Next >")
    nextButton:SetWidth(buttonWidth)
    nextButton:SetHeight(buttonHeight)    
    nextButton:SetCallback("OnClick", function()
        if currentPage * itemsPerPage < #HCS_MilestonesDB then
            currentPage = currentPage + 1
            PopulateMilestonesContent(container)
        end
    end)
    nextButton:SetDisabled(currentPage * itemsPerPage >= #HCS_MilestonesDB) -- Disables "Next" button on the last page  

    navGroup:AddChild(nextButton)  

    -- Add a spacer at the bottom
    local spacer = AceGUI:Create("Label")
    spacer:SetText("") -- Empty text
    spacer:SetHeight(20) -- Acts as bottom padding
    spacer:SetFullWidth(true)
    container:AddChild(spacer)   


    container:AddChild(navGroup)

end

local function PopulateAchievementsContent(container)
   
    -- Header Group
    local headerGroup = AceGUI:Create("SimpleGroup")
    headerGroup:SetFullWidth(true)
    headerGroup:SetLayout("Flow")

    -- Placeholder for icon width
    local iconPlaceholder = AceGUI:Create("Label")
    iconPlaceholder:SetText("")
    iconPlaceholder:SetWidth(50)  -- The same width as the checkbox
    headerGroup:AddChild(iconPlaceholder)

    local pointsHeader = AceGUI:Create("Label")
    pointsHeader:SetFont(fontPath, fontSize, "OUTLINE")
    pointsHeader:SetText("Points")
    pointsHeader:SetWidth(80)  -- Adjust this value as needed
    headerGroup:AddChild(pointsHeader)

    local shortdescHeader = AceGUI:Create("Label")
    shortdescHeader:SetFont(fontPath, fontSize, "OUTLINE")
    shortdescHeader:SetText("Achievement")
    shortdescHeader:SetWidth(150)  -- Adjust this value as needed
    headerGroup:AddChild(shortdescHeader)

    local descHeader = AceGUI:Create("Label")
    descHeader:SetFont(fontPath, fontSize, "OUTLINE")
    descHeader:SetText("Description")
    descHeader:SetWidth(350)  -- Adjust this value as needed
    headerGroup:AddChild(descHeader)
    
    -- Add the header to the container
    container:AddChild(headerGroup)

    -- Scroll Frame
    local scrollframe = AceGUI:Create("ScrollFrame")
    scrollframe:SetLayout("List")
    scrollframe:SetFullWidth(true)
    scrollframe:SetFullHeight(true)    

    
    -- Function to process each achievement and add it to the scroll frame
    local function ProcessAchievement(achievement, scrollframe, lastHeader)
        local completed = HCS_AchievementScore:AchievedAchivement(achievement.id)
        local header = achievement.name

        -- Check if the heading has changed
        if header ~= lastHeader then
            local heading = AceGUI:Create("Heading")
            heading:SetText(header:upper())
            heading:SetFullWidth(true)
            scrollframe:AddChild(heading)
            lastHeader = header
        end

        -- [Rest of your code for creating the rowGroup, icon, labels, etc.]
        -- ...
        local rowGroup = AceGUI:Create("SimpleGroup")
        rowGroup:SetFullWidth(true)
        rowGroup:SetLayout("Flow")

        local icon = AceGUI:Create("Icon")
        icon:SetImage(achievement.image)
        icon:SetImageSize(24,24)
        icon:SetLabel("")
        icon:SetWidth(50)
        --icon:SetDisabled(true) -- Make it non-clickable
        rowGroup:AddChild(icon)

        local pointsLabel = AceGUI:Create("Label")
        if completed then pointsLabel:SetColor(wowGreenColor.red, wowGreenColor.green, wowGreenColor.blue) end
        pointsLabel:SetFont(fontPath, fontSize, "OUTLINE")
        pointsLabel:SetText(achievement.points .. " points")
        pointsLabel:SetWidth(80)  
        rowGroup:AddChild(pointsLabel)

        local shortdescLabel = AceGUI:Create("Label")
        if completed then shortdescLabel:SetColor(wowGreenColor.red, wowGreenColor.green, wowGreenColor.blue) end
        shortdescLabel:SetFont(fontPath, fontSize, "OUTLINE")
        shortdescLabel:SetText(achievement.shortdesc)
        shortdescLabel:SetWidth(150)  
        rowGroup:AddChild(shortdescLabel)

        local descLabel = AceGUI:Create("Label")
        if completed then descLabel:SetColor(wowGreenColor.red, wowGreenColor.green, wowGreenColor.blue) end
        descLabel:SetFont(fontPath, fontSize, "OUTLINE")
        descLabel:SetText(achievement.desc)
        descLabel:SetWidth(350)  
        rowGroup:AddChild(descLabel)
        
        scrollframe:AddChild(rowGroup)

        return lastHeader
    end

    -- Iterate over the main achievements
    local lastHeader = ""
    for _, achievement in ipairs(HCS_AchievementsDB) do
        if type(achievement) == "table" then  -- Ensure it's a table before processing
            lastHeader = ProcessAchievement(achievement, scrollframe, lastHeader)
        end
    end

    -- Iterate over the Class Rune Achievements if they exist
    if HCS_SODVersion then 
        if HCS_AchievementsDB.ClassRuneAchievementTable then
            for _, runeAchievement in ipairs(HCS_AchievementsDB.ClassRuneAchievementTable) do
                lastHeader = ProcessAchievement(runeAchievement, scrollframe, lastHeader)
            end
        end
    end
    
    -- Add scroll frame to the container
    container:AddChild(scrollframe)
end

local function PopulateCharactersContent(container)
    -- Header Group
    local headerGroup = AceGUI:Create("SimpleGroup")
    headerGroup:SetFullWidth(true)
    headerGroup:SetLayout("Flow")

    -- Placeholder for checkbox width
    local nameHeader = AceGUI:Create("Label")
    nameHeader:SetFont(fontPath, fontSize, "OUTLINE")
    nameHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    nameHeader:SetText("Name")
    nameHeader:SetWidth(100)  -- The same width as the checkbox
    headerGroup:AddChild(nameHeader)

    local scoreHeader = AceGUI:Create("Label")
    scoreHeader:SetFont(fontPath, fontSize, "OUTLINE")
    scoreHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    scoreHeader:SetText("Score")
    scoreHeader:SetWidth(60)  -- Adjust this value as needed
    headerGroup:AddChild(scoreHeader)

    local gearHeader = AceGUI:Create("Label")
    gearHeader:SetFont(fontPath, fontSize, "OUTLINE")
    gearHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    gearHeader:SetText("Gear")
    gearHeader:SetWidth(60)  -- Adjust this value as needed
    headerGroup:AddChild(gearHeader)

    local levelHeader = AceGUI:Create("Label")
    levelHeader:SetFont(fontPath, fontSize, "OUTLINE")
    levelHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    levelHeader:SetText("Level")
    levelHeader:SetWidth(60)  -- Adjust this value as needed
    headerGroup:AddChild(levelHeader)
    
    local questHeader = AceGUI:Create("Label")
    questHeader:SetFont(fontPath, fontSize, "OUTLINE")
    questHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    questHeader:SetText("Quests")
    questHeader:SetWidth(60)  -- Adjust this value as needed
    headerGroup:AddChild(questHeader)

    local mobsHeader = AceGUI:Create("Label")
    mobsHeader:SetFont(fontPath, fontSize, "OUTLINE")
    mobsHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    mobsHeader:SetText("Mobs")
    mobsHeader:SetWidth(60)  -- Adjust this value as needed
    headerGroup:AddChild(mobsHeader)

    local profHeader = AceGUI:Create("Label")
    profHeader:SetFont(fontPath, fontSize, "OUTLINE")
    profHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    profHeader:SetText("Prof")
    profHeader:SetWidth(60)  -- Adjust this value as needed
    headerGroup:AddChild(profHeader)

    local repHeader = AceGUI:Create("Label")
    repHeader:SetFont(fontPath, fontSize, "OUTLINE")
    repHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    repHeader:SetText("Rep")
    repHeader:SetWidth(60)  -- Adjust this value as needed
    headerGroup:AddChild(repHeader)

    local discoveryHeader = AceGUI:Create("Label")
    discoveryHeader:SetFont(fontPath, fontSize, "OUTLINE")
    discoveryHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    discoveryHeader:SetText("Disc")
    discoveryHeader:SetWidth(60)  -- Adjust this value as needed
    headerGroup:AddChild(discoveryHeader)

    local milestonesHeader = AceGUI:Create("Label")
    milestonesHeader:SetFont(fontPath, fontSize, "OUTLINE")
    milestonesHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    milestonesHeader:SetText("Mile")
    milestonesHeader:SetWidth(60)  -- Adjust this value as needed
    headerGroup:AddChild(milestonesHeader)

    local AchivementsHeader = AceGUI:Create("Label")    
    AchivementsHeader:SetFont(fontPath, fontSize, "OUTLINE")
    AchivementsHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    AchivementsHeader:SetText("Ach")
    AchivementsHeader:SetWidth(60)  -- Adjust this value as needed
    headerGroup:AddChild(AchivementsHeader)


    -- Add the header to the container
    container:AddChild(headerGroup)

    -- Scroll Frame
    local scrollframe = AceGUI:Create("ScrollFrame")
    scrollframe:SetLayout("List")
    scrollframe:SetFullWidth(true)
    scrollframe:SetFullHeight(true)    

    -- Load Data
    local charactersArray = {}
    for charName, info in pairs(Hardcore_Score.db.global.characterScores) do
        info.charName = charName -- Add charName to each entry for later
        table.insert(charactersArray, info)
    end

    -- Sort the array
    table.sort(charactersArray, function(a, b)
        return a.coreScore > b.coreScore
    end)

    local characters = charactersArray --Hardcore_Score.db.global.characterScores
    local allDataPoints = {} -- Collect data points for all characters
    
    for index, characterScores in ipairs(characters) do   --for characterName, characterScores in pairs(characters) do
        if characterScores ~= nil then
            local dataPoints = { 
                name = HCS_Utils:GetTextWithClassColor(characterScores.charClassId, characterScores.charName),
                score = string.format("%.2f", characterScores.coreScore),
                equip = string.format("%.2f", characterScores.equippedGearScore), 
                level = string.format("%.2f", characterScores.levelingScore), 
                quest = string.format("%.2f", characterScores.questingScore), 
                mobs = string.format("%.2f", characterScores.mobsKilledScore), 
                prof = string.format("%.2f", characterScores.professionsScore),
                rep = string.format("%.2f", characterScores.reputationScore),
                disc = string.format("%.2f", characterScores.discoveryScore),
                mile = string.format("%.2f", characterScores.milestonesScore),
                ach = string.format("%.2f", characterScores.achievementScore or 0)

            }
            table.insert(allDataPoints, dataPoints) -- Add this character's dataPoints to the allDataPoints table
        end
    end    

    for _, dataPoints in ipairs(allDataPoints) do
        local rowGroup = AceGUI:Create("SimpleGroup")
        rowGroup:SetFullWidth(true)
        rowGroup:SetLayout("Flow")
    
        local nameLabel = AceGUI:Create("Label")
        nameLabel:SetFont(fontPath, fontSize, "OUTLINE")
        nameLabel:SetText(dataPoints.name)
        nameLabel:SetWidth(100)  
        rowGroup:AddChild(nameLabel)

        local scoreLabel = AceGUI:Create("Label")
        scoreLabel:SetText(dataPoints.score)
        scoreLabel:SetFont(fontPath, fontSize, "OUTLINE")
        scoreLabel:SetColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)
        scoreLabel:SetWidth(60)  
        rowGroup:AddChild(scoreLabel)

        local equipLabel = AceGUI:Create("Label")
        equipLabel:SetText(dataPoints.equip)
        equipLabel:SetFont(fontPath, fontSize, "OUTLINE")
        equipLabel:SetColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)
        equipLabel:SetWidth(60)  
        rowGroup:AddChild(equipLabel)
    
        local levelLabel = AceGUI:Create("Label")
        levelLabel:SetText(dataPoints.level)
        levelLabel:SetFont(fontPath, fontSize, "OUTLINE")
        levelLabel:SetColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)
        levelLabel:SetWidth(60)  
        rowGroup:AddChild(levelLabel)

        local questLabel = AceGUI:Create("Label")
        questLabel:SetText(dataPoints.quest)
        questLabel:SetFont(fontPath, fontSize, "OUTLINE")
        questLabel:SetColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)
        questLabel:SetWidth(60)  
        rowGroup:AddChild(questLabel)

        local mobsLabel = AceGUI:Create("Label")
        mobsLabel:SetText(dataPoints.mobs)
        mobsLabel:SetFont(fontPath, fontSize, "OUTLINE")
        mobsLabel:SetColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)
        mobsLabel:SetWidth(60)  
        rowGroup:AddChild(mobsLabel)

        local profLabel = AceGUI:Create("Label")
        profLabel:SetText(dataPoints.prof)
        profLabel:SetFont(fontPath, fontSize, "OUTLINE")
        profLabel:SetColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)
        profLabel:SetWidth(60)  
        rowGroup:AddChild(profLabel)

        local repLabel = AceGUI:Create("Label")
        repLabel:SetText(dataPoints.rep)
        repLabel:SetFont(fontPath, fontSize, "OUTLINE")
        repLabel:SetColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)
        repLabel:SetWidth(60)  
        rowGroup:AddChild(repLabel)

        local discLabel = AceGUI:Create("Label")
        discLabel:SetText(dataPoints.disc)
        discLabel:SetFont(fontPath, fontSize, "OUTLINE")
        discLabel:SetColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)
        discLabel:SetWidth(60)  
        rowGroup:AddChild(discLabel)

        local mileLabel = AceGUI:Create("Label")
        mileLabel:SetText(dataPoints.mile)
        mileLabel:SetFont(fontPath, fontSize, "OUTLINE")
        mileLabel:SetColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)
        mileLabel:SetWidth(60)  
        rowGroup:AddChild(mileLabel)

        local achLabel = AceGUI:Create("Label")
        achLabel:SetText(dataPoints.ach)
        achLabel:SetFont(fontPath, fontSize, "OUTLINE")
        achLabel:SetColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)
        achLabel:SetWidth(60)  
        rowGroup:AddChild(achLabel)

        scrollframe:AddChild(rowGroup)
    end
    
    -- Add scroll frame to the container
    container:AddChild(scrollframe)

end

local function PopulateLeaderboardContent(container)
    -- Header Group
    local headerGroup = AceGUI:Create("SimpleGroup")
    headerGroup:SetFullWidth(true)
    headerGroup:SetLayout("Flow")

    local rankHeader = AceGUI:Create("Label")
    rankHeader:SetFont(fontPath, fontSize, "OUTLINE")
    rankHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    rankHeader:SetText("#")
    rankHeader:SetWidth(30)  
    headerGroup:AddChild(rankHeader)

    local nameHeader = AceGUI:Create("Label")
    nameHeader:SetFont(fontPath, fontSize, "OUTLINE")
    nameHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    nameHeader:SetText("Name")
    nameHeader:SetWidth(100) 
    headerGroup:AddChild(nameHeader)

    local classIconHeader = AceGUI:Create("Label")
    classIconHeader:SetFont(fontPath, fontSize, "OUTLINE")
    classIconHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    classIconHeader:SetText("Class")
    classIconHeader:SetWidth(60) 
    headerGroup:AddChild(classIconHeader)

    local levelHeader = AceGUI:Create("Label")
    levelHeader:SetFont(fontPath, fontSize, "OUTLINE")
    levelHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    levelHeader:SetText("Lvl")
    levelHeader:SetWidth(50)  
    headerGroup:AddChild(levelHeader)

    local rankHeader = AceGUI:Create("Label")
    rankHeader:SetFont(fontPath, fontSize, "OUTLINE")
    rankHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    rankHeader:SetText("Rank")
    rankHeader:SetWidth(120)  
    headerGroup:AddChild(rankHeader)

    local scoreHeader = AceGUI:Create("Label")
    scoreHeader:SetFont(fontPath, fontSize, "OUTLINE")
    scoreHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    scoreHeader:SetText("Score")
    scoreHeader:SetWidth(80)  
    headerGroup:AddChild(scoreHeader)
    
    -- Add the header to the container
    container:AddChild(headerGroup)

    -- Scroll Frame
    local scrollframe = AceGUI:Create("ScrollFrame")
    scrollframe:SetLayout("List")
    scrollframe:SetFullWidth(true)
    scrollframe:SetFullHeight(true)   
    
    -- Load Data
    
    -- Convert the leaderboard to an array
    local leaderboardArray = {}
    for charName, info in pairs(HCScore_Character.leaderboard) do
        info.charName = charName -- Add charName to each entry for later
        table.insert(leaderboardArray, info)
    end

    -- Sort the array
    table.sort(leaderboardArray, function(a, b)
        return tonumber(a.coreScore) > tonumber(b.coreScore)
    end)

    local rankCounter = 0

    for _, info in ipairs(leaderboardArray) do

        rankCounter = rankCounter + 1

        local rowGroup = AceGUI:Create("SimpleGroup")
        rowGroup:SetFullWidth(true)
        rowGroup:SetLayout("Flow")

        local rankLabel = AceGUI:Create("Label")
        rankLabel:SetFont(fontPath, fontSize, "OUTLINE")
        rankLabel:SetText(rankCounter)
        rankLabel:SetWidth(30)  
        rowGroup:AddChild(rankLabel)
    
        local nameLabel = AceGUI:Create("Label")
        nameLabel:SetFont(fontPath, fontSize, "OUTLINE")
        --nameLabel:SetText(HCS_Utils:GetTextWithClassColor(info.charClass, charName))
        nameLabel:SetText(info.charName)
        nameLabel:SetWidth(100)  
        rowGroup:AddChild(nameLabel)

        local classLabel = AceGUI:Create("Label")
        classLabel:SetFont(fontPath, fontSize, "OUTLINE")
        classLabel:SetText(HCS_Utils:GetClassColorText(info.charClass))
        classLabel:SetWidth(60)  
        rowGroup:AddChild(classLabel)

        local levelLabel = AceGUI:Create("Label")
        levelLabel:SetText(info.charLevel)
        levelLabel:SetFont(fontPath, fontSize, "OUTLINE")
        levelLabel:SetColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)
        levelLabel:SetWidth(50)  
        rowGroup:AddChild(levelLabel)

        --TODO: This needs to be put into a seperate function
        local function between(x, a, b)
            return x >= a and x <= b
        end

        -- look up players Rank in HCS_RanksDB
        local playerRank
        for _, Rank in pairs(HCS_RanksDB) do
            if between(tonumber(info.coreScore), Rank.MinPoints, Rank.MaxPoints) then
                playerRank = Rank
                break
            end
        end        

        local rankLabel = AceGUI:Create("Label")
        rankLabel:SetText(HCS_Utils:GetRankLevelText(playerRank.Rank, playerRank.Level))
        rankLabel:SetFont(fontPath, fontSize, "OUTLINE")
        rankLabel:SetColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)
        rankLabel:SetWidth(120)  
        rowGroup:AddChild(rankLabel)

        local scoreLabel = AceGUI:Create("Label")
        scoreLabel:SetText(HCS_Utils:AddThousandsCommas(info.coreScore))
        scoreLabel:SetFont(fontPath, fontSize, "OUTLINE")
        scoreLabel:SetColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)
        scoreLabel:SetWidth(80)  
        rowGroup:AddChild(scoreLabel)

        scrollframe:AddChild(rowGroup)
    end
    
    -- Add scroll frame to the container
    container:AddChild(scrollframe)
end

local currentPageMobs = 1
local itemsPerPageMobs = 25 -- Display 20 rows per page
local currentMobFilter = ""
local shouldRefocusMobSearch = false
local mobSearchCursor = 0
local mobsLeftScrollFrame = nil
local mobsNavPrevButton = nil
local mobsNavNextButton = nil

-- Helpers for Mobs Killed tab
local function GetFilteredSortedMobs()
    local mobsKilled = HCScore_Character.mobsKilled or {}
    local filteredMobs = {}
    if currentMobFilter ~= nil and currentMobFilter ~= "" then
        local needle = string.lower(currentMobFilter)
        for _, mob in ipairs(mobsKilled) do
            local nameLower = string.lower(tostring(mob.id or ""))
            if string.find(nameLower, needle, 1, true) then
                table.insert(filteredMobs, mob)
            end
        end
    else
        filteredMobs = mobsKilled
    end

    table.sort(filteredMobs, function(a, b)
        return a.kills > b.kills
    end)

    return filteredMobs
end

local function RebuildMobsKilledRows()
    if not mobsLeftScrollFrame then return end

    mobsLeftScrollFrame:ReleaseChildren()

    local filteredMobs = GetFilteredSortedMobs()

    local startIndex = (currentPageMobs - 1) * itemsPerPageMobs + 1
    local endIndex = math.min(startIndex + itemsPerPageMobs - 1, #filteredMobs)

    for i = startIndex, endIndex do
        local mob = filteredMobs[i]
        if not mob then break end

        local rowGroup = AceGUI:Create("SimpleGroup")
        rowGroup:SetLayout("Flow")
        rowGroup:SetFullWidth(true)

        local mobNameLabel = AceGUI:Create("Label")
        mobNameLabel:SetFont(fontPath, fontSize, "OUTLINE")
        mobNameLabel:SetText(mob.id)
        mobNameLabel:SetWidth(175)
        rowGroup:AddChild(mobNameLabel)

        local killsLabel = AceGUI:Create("Label")
        killsLabel:SetFont(fontPath, fontSize, "OUTLINE")
        killsLabel:SetText(mob.kills)
        killsLabel:SetWidth(70)
        rowGroup:AddChild(killsLabel)

        local scoreLabel = AceGUI:Create("Label")
        scoreLabel:SetFont(fontPath, fontSize, "OUTLINE")
        scoreLabel:SetText(string.format("%.2f", mob.score))
        scoreLabel:SetWidth(70)
        rowGroup:AddChild(scoreLabel)

        local xpLabel = AceGUI:Create("Label")
        xpLabel:SetFont(fontPath, fontSize, "OUTLINE")
        xpLabel:SetText(mob.xp)
        xpLabel:SetWidth(70)
        rowGroup:AddChild(xpLabel)

        mobsLeftScrollFrame:AddChild(rowGroup)
    end

    if mobsNavPrevButton then
        mobsNavPrevButton:SetDisabled(currentPageMobs == 1)
    end
    if mobsNavNextButton then
        mobsNavNextButton:SetDisabled(currentPageMobs * itemsPerPageMobs >= #filteredMobs)
    end
end

local function PopulateMobsKilledInfoContent(container)
    container:ReleaseChildren() -- Clear existing widgets

    -- Parent Group: Horizontal layout for two tables
    local parentGroup = AceGUI:Create("SimpleGroup")
    parentGroup:SetLayout("Flow")
    parentGroup:SetFullWidth(true)
    parentGroup:SetFullHeight(true)

    -- ==== LEFT TABLE: Mobs Killed ====
    local leftGroup = AceGUI:Create("InlineGroup")
    leftGroup:SetTitle("Mobs Killed")
    leftGroup:SetLayout("Flow") -- Use Flow to keep the scroll and nav buttons aligned
    leftGroup:SetWidth(452)
    leftGroup:SetHeight(425)
    parentGroup:AddChild(leftGroup)

	-- Search/filter row for left table
	local leftSearchGroup = AceGUI:Create("SimpleGroup")
	leftSearchGroup:SetFullWidth(true)
	leftSearchGroup:SetLayout("Flow")

	local searchLabel = AceGUI:Create("Label")
	searchLabel:SetFont(fontPath, fontSize, "OUTLINE")
	searchLabel:SetText("Search")
	searchLabel:SetWidth(60)
	leftSearchGroup:AddChild(searchLabel)

	local searchBox = AceGUI:Create("EditBox")
	searchBox:SetLabel("")
	searchBox:SetText(currentMobFilter or "")
	searchBox:SetWidth(250)
	searchBox:DisableButton(true)
	searchBox:SetCallback("OnTextChanged", function(widget, event, text)
		currentMobFilter = text or ""
		currentPageMobs = 1
		RebuildMobsKilledRows()
	end)
	leftSearchGroup:AddChild(searchBox)

	local clearBtn = AceGUI:Create("Button")
	clearBtn:SetText("Clear")
	clearBtn:SetWidth(60)
	clearBtn:SetCallback("OnClick", function()
		if currentMobFilter ~= "" then
			currentMobFilter = ""
			currentPageMobs = 1
			searchBox:SetText("")
			RebuildMobsKilledRows()
		end
	end)
	leftSearchGroup:AddChild(clearBtn)

	leftGroup:AddChild(leftSearchGroup)


    -- Left Table Header Group
    local leftHeaderGroup = AceGUI:Create("SimpleGroup")
    leftHeaderGroup:SetFullWidth(true)
    leftHeaderGroup:SetLayout("Flow")

    local mobNameHeader = AceGUI:Create("Label")
    mobNameHeader:SetFont(fontPath, fontSize, "OUTLINE")
    mobNameHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    mobNameHeader:SetText("Mob")
    mobNameHeader:SetWidth(175)
    leftHeaderGroup:AddChild(mobNameHeader)

    local killsHeader = AceGUI:Create("Label")
    killsHeader:SetFont(fontPath, fontSize, "OUTLINE")
    killsHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    killsHeader:SetText("Kills")
    killsHeader:SetWidth(70)
    leftHeaderGroup:AddChild(killsHeader)

    local scoreHeader = AceGUI:Create("Label")
    scoreHeader:SetFont(fontPath, fontSize, "OUTLINE")
    scoreHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    scoreHeader:SetText("Score")
    scoreHeader:SetWidth(70)
    leftHeaderGroup:AddChild(scoreHeader)

    local xpHeader = AceGUI:Create("Label")
    xpHeader:SetFont(fontPath, fontSize, "OUTLINE")
    xpHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
    xpHeader:SetText("XP")
    xpHeader:SetWidth(70)
    leftHeaderGroup:AddChild(xpHeader)

    leftGroup:AddChild(leftHeaderGroup)

    -- ScrollFrame for Left Table Rows
    local leftScrollFrame = AceGUI:Create("ScrollFrame")
    leftScrollFrame:SetLayout("List")
    leftScrollFrame:SetFullWidth(true)
    leftScrollFrame:SetHeight(270) -- Adjust height to leave space for buttons
    leftGroup:AddChild(leftScrollFrame)
	mobsLeftScrollFrame = leftScrollFrame

	-- Initial build of rows
	RebuildMobsKilledRows()

    -- Navigation Buttons (Below ScrollFrame)
    local navGroup = AceGUI:Create("SimpleGroup")
    navGroup:SetFullWidth(true)
    navGroup:SetLayout("Flow")

	local prevButton = AceGUI:Create("Button")
    prevButton:SetText("< Previous")
    prevButton:SetWidth(80)
    prevButton:SetCallback("OnClick", function()
        if currentPageMobs > 1 then
            currentPageMobs = currentPageMobs - 1
			RebuildMobsKilledRows()
        end
    end)
    prevButton:SetDisabled(currentPageMobs == 1)
    navGroup:AddChild(prevButton)
	mobsNavPrevButton = prevButton

	local nextButton = AceGUI:Create("Button")
    nextButton:SetText("Next >")
    nextButton:SetWidth(80)
    nextButton:SetCallback("OnClick", function()
		local filteredMobs = GetFilteredSortedMobs()
		if currentPageMobs * itemsPerPageMobs < #filteredMobs then
            currentPageMobs = currentPageMobs + 1
			RebuildMobsKilledRows()
        end
    end)
	nextButton:SetDisabled(false)
    navGroup:AddChild(nextButton)
	mobsNavNextButton = nextButton

    leftGroup:AddChild(navGroup)

  -- ==== RIGHT TABLE: Mobs Killed Map ====
  local rightGroup = AceGUI:Create("InlineGroup")
  rightGroup:SetTitle("Mobs Killed Map")
  rightGroup:SetLayout("Fill")
  rightGroup:SetWidth(352) -- Fixed width
  rightGroup:SetHeight(340) -- Fixed height

  -- Add a tooltip to the "Mobs Killed Map" title
  rightGroup.frame:SetScript("OnEnter", function()
      GameTooltip:SetOwner(rightGroup.frame, "ANCHOR_TOP")
      GameTooltip:ClearLines()
      GameTooltip:AddLine("Difficulty Legend (Levels above your character)", 1, 1, 0) -- Gold text
      -- Color-coded difficulty lines
      GameTooltip:AddLine("|cffFF0000+6|r - Legendary (Incredibly Hard)", 1, 1, 1) -- Red
      GameTooltip:AddLine("|cffFF4500+5|r - Heroic (Very Hard)", 1, 1, 1)          -- Red-Orange
      GameTooltip:AddLine("|cffFF4500+4|r - Deadly (Hard)", 1, 1, 1)                -- Orange-Red
      GameTooltip:AddLine("|cffFFA500+3|r - Formidable (Challenging)", 1, 1, 1)    -- Orange
      GameTooltip:AddLine("|cffFFA500+2|r - Dangerous (Slightly Tough)", 1, 1, 1)  -- Orange
      GameTooltip:AddLine("|cffFFD700+1|r - Challenging (Moderate)", 1, 1, 1)      -- Yellow
      GameTooltip:AddLine("|cffFFD700  0|r  - Standard (Default Difficulty)", 1, 1, 1) -- Yellow
      GameTooltip:AddLine("|cffFFD700-1|r - Slightly Tough (Easy)", 1, 1, 1)       -- Yellow
      GameTooltip:AddLine("|cffFFD700-2|r - Unchallenging (Easier)", 1, 1, 1)      -- Yellow
      GameTooltip:AddLine("|cff32CD32-3|r - Routine (Very Easy)", 1, 1, 1)         -- Green
      GameTooltip:AddLine("|cff32CD32-4|r - Easy (Trivial)", 1, 1, 1)              -- Green
      GameTooltip:AddLine("|cffA9A9A9-5|r - Laughable (Extremely Easy)", 1, 1, 1)  -- Grey
      GameTooltip:AddLine("|cffA9A9A9-6|r - Trivial (No Challenge)", 1, 1, 1)      -- Grey

      GameTooltip:Show()
  end)

  rightGroup.frame:SetScript("OnLeave", function()
      GameTooltip:Hide()
  end)

  parentGroup:AddChild(rightGroup)


  -- ScrollFrame for Right Table
  local rightScrollFrame = AceGUI:Create("ScrollFrame")
  rightScrollFrame:SetLayout("List")
  rightGroup:AddChild(rightScrollFrame)

  -- Right Table Header Group
  local rightHeaderGroup = AceGUI:Create("SimpleGroup")
  rightHeaderGroup:SetFullWidth(true)
  rightHeaderGroup:SetLayout("Flow")

  local difficultyHeader = AceGUI:Create("Label")
  difficultyHeader:SetFont(fontPath, fontSize, "OUTLINE")
  difficultyHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
  difficultyHeader:SetText("Difficulty")
  difficultyHeader:SetWidth(100)
  rightHeaderGroup:AddChild(difficultyHeader)

  local killsHeader = AceGUI:Create("Label")
  killsHeader:SetFont(fontPath, fontSize, "OUTLINE")
  killsHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
  killsHeader:SetText("Kills")
  killsHeader:SetWidth(70)
  rightHeaderGroup:AddChild(killsHeader)

  local scoreHeader = AceGUI:Create("Label")
  scoreHeader:SetFont(fontPath, fontSize, "OUTLINE")
  scoreHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
  scoreHeader:SetText("Score")
  scoreHeader:SetWidth(70)
  rightHeaderGroup:AddChild(scoreHeader)

  local xpHeader = AceGUI:Create("Label")
  xpHeader:SetFont(fontPath, fontSize, "OUTLINE")
  xpHeader:SetColor(txtColumnColor.red, txtColumnColor.green, txtColumnColor.blue)
  xpHeader:SetText("XP")
  xpHeader:SetWidth(70)
  rightHeaderGroup:AddChild(xpHeader)

  rightScrollFrame:AddChild(rightHeaderGroup)

  -- Right Table Data Rows
  local mobsKilledMap = HCScore_Character.mobsKilledMap or {}


  -- Sort the mobsKilledMap by difficulty in descending order
  table.sort(mobsKilledMap, function(a, b)
      return a.difficulty > b.difficulty
  end)

  -- Create a lookup table for existing difficulties
  local difficultyLookup = {}
  for _, mob in ipairs(mobsKilledMap) do
      difficultyLookup[mob.difficulty] = mob
  end

  -- Iterate over all difficulty levels from +6 to -6
  for difficulty = 6, -6, -1 do
      local rowGroup = AceGUI:Create("SimpleGroup")
      rowGroup:SetLayout("Flow")
      rowGroup:SetFullWidth(true)

      -- Get mob data if it exists; otherwise, use default values
      local mob = difficultyLookup[difficulty] or { kills = 0, score = 0, xp = 0 }
      local difficultyName = difficultyNames[difficulty] or "Unknown"

      -- Determine the color for the difficulty
      local colorCode = difficultyColors[difficulty] or "|cffFFFFFF"  -- Default to white if not found
      local coloredDifficultyName = colorCode .. difficultyName .. "|r"

      -- Difficulty Label
      local difficultyLabel = AceGUI:Create("Label")
      difficultyLabel:SetFont(fontPath, fontSize, "OUTLINE")
      difficultyLabel:SetText(coloredDifficultyName)
      difficultyLabel:SetWidth(100)
      rowGroup:AddChild(difficultyLabel)

      -- Kills Label
      local killsLabel = AceGUI:Create("Label")
      killsLabel:SetFont(fontPath, fontSize, "OUTLINE")
      killsLabel:SetText(mob.kills)
      killsLabel:SetWidth(70)
      rowGroup:AddChild(killsLabel)

      -- Score Label
      local scoreLabel = AceGUI:Create("Label")
      scoreLabel:SetFont(fontPath, fontSize, "OUTLINE")
      scoreLabel:SetText(string.format("%.2f", mob.score))
      scoreLabel:SetWidth(70)
      rowGroup:AddChild(scoreLabel)

      -- XP Label
      local xpLabel = AceGUI:Create("Label")
      xpLabel:SetFont(fontPath, fontSize, "OUTLINE")
      xpLabel:SetText(mob.xp)
      xpLabel:SetWidth(70)
      rowGroup:AddChild(xpLabel)

      -- Add the row to the right scroll frame
      rightScrollFrame:AddChild(rowGroup)
  end


  -- Add Parent Group to Container
  container:AddChild(parentGroup)
end

-- Function to populate the content of each tab
tabGroup:SetCallback("OnGroupSelected", function(container, event, group)
    container:ReleaseChildren() -- This is important. It releases the current widgets before adding new ones.
    if group == "Info" then
        -- Add widgets for the Info tab
        local infoLabel = AceGUI:Create("Label")
        infoLabel:SetText("Character Information is coming soon..") 
        container:AddChild(infoLabel)
    elseif group == "Achievements" then
        PopulateAchievementsContent(container)
    elseif group == "Milestones" then
        PopulateMilestonesContent(container)
    elseif group == "Characters" then
        PopulateCharactersContent(container)
    elseif group == "Leaderboard" then
        PopulateLeaderboardContent(container)           
    elseif group == "MobsKilledInfo" then
        PopulateMobsKilledInfoContent(container)           

    end   
end)

-- Add the tab group to the main frame
frameContainer:AddChild(tabGroup)

-- Select the default tab
tabGroup:SelectTab("Info")

-- Function to toggle frame visibility
function HCS_AllInfoUI:ToggleMyFrame()
    if HCS_AllInfoUI.frame:IsShown() then
        HCS_AllInfoUI.frame:Hide()
    else
        HCS_AllInfoUI.frame:Show()
    end
end





