HCS_ScoreboardSummaryUI = {};

-- Frame 1
local txtCoreScore1
local txtCoreScore2
local progressBar 
local imgPortrait

-- Frame 2
local txt_charactername
local txt_rank
local txt_nextlevel
local imageportait
local imagedivider
local txt_equippedgear
local txt_equippedgear_score
local txt_leveling
local txt_leveling_score
local txt_mobskilled
local txt_mobskilled_score
local txt_professions
local txt_professions_score
local txt_questing
local txt_questing_score
local txt_reputation
local txt_reputation_score
local txt_discovery
local txt_discovery_score
local txt_milestones
local txt_milestones_score
local txt_achievements
local txt_achievements_score

local frame2scoreposition = -20
local labelwidth = 125
local ranklabelwidth = 130
local labelwidthscore = 75
local isFrame2Visible = false
local txtNumberColor = {
    red = 217 / 255,
    green = 190 / 255,
    blue = 132 / 255,
}

local fontPath = "Interface\\Addons\\Hardcore_Score\\Fonts\\BebasNeue-Regular.ttf"
--local fontPath = "Fonts\\FRIZQT__.TTF"
local fontSize = 14  

function HCS_ScoreboardSummaryUI:Init()
    frameLocked = Hardcore_Score.db.profile.lockScoreboardSummaryUI or false
end
  
-- Create the frame
function HCS_ScoreboardSummaryUI:CreateFrame()

    ScoreboardSummaryFrame = CreateFrame("Frame", "MainScoreFrame", UIParent, "BackdropTemplate")    
    ScoreboardSummaryFrame:SetWidth(254)
    ScoreboardSummaryFrame:SetHeight(42)
    ScoreboardSummaryFrame:SetPoint("CENTER")
    ScoreboardSummaryFrame:SetClampedToScreen(true)
    
    -- Set backdrop with gradient background and border
    ScoreboardSummaryFrame:SetBackdrop({
       -- bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = Current_hcs_Border,
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    ScoreboardSummaryFrame:SetBackdropColor(0, 0, 0, 1)
    ScoreboardSummaryFrame:SetBackdropBorderColor(1, 1, 1)
    
    ScoreboardSummaryFrame:SetMovable(true)
    ScoreboardSummaryFrame:EnableMouse(true)
    ScoreboardSummaryFrame:RegisterForDrag("LeftButton")
    ScoreboardSummaryFrame:SetScript("OnDragStart", function(self)
        if not frameLocked then 
            self:StartMoving() 
        end
    end)

    ScoreboardSummaryFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        -- Save the new position
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()

        Hardcore_Score.db.profile.framePosition = {
            point = point,
            relativeTo = (relativeTo and relativeTo:GetName() and relativeTo:GetName() ~= "") and relativeTo:GetName() or "UIParent", --relativeTo, --"UIParent",
            relativePoint = relativePoint,
            xOfs = xOfs,
            yOfs = yOfs,
            show = true,
        }        
    end)

    -- Create the round image (Portrait)
    imgPortrait = ScoreboardSummaryFrame:CreateTexture(nil, "OVERLAY")
    local originalWidth = 256
    local originalHeight = 256
    local scaleFactor = 0.25
    local newWidth = originalWidth * scaleFactor
    local newHeight = originalHeight * scaleFactor

    imgPortrait:SetSize(newWidth, newHeight)
    imgPortrait:SetTexture(Current_hcs_Portrait)
    imgPortrait:SetPoint("TOPLEFT", ScoreboardSummaryFrame, "TOPLEFT", -30, 11)

    
    -- Create logo image
    imgTitle = ScoreboardSummaryFrame:CreateTexture(nil, "OVERLAY")
    imgTitle:SetSize(128, 32)
    local imgLogo = "Interface\\Addons\\Hardcore_Score\\Media\\Text-logo.blp"
    imgTitle:SetTexture(imgLogo)
    imgTitle:SetPoint("TOPLEFT", ScoreboardSummaryFrame, "TOPLEFT", 30, -5)

    -- Score
    txtCoreScore2 = ScoreboardSummaryFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txtCoreScore2:SetPoint("LEFT", imgTitle, "RIGHT", 5, 0)
    txtCoreScore2:SetJustifyH("RIGHT")
    txtCoreScore2:SetWidth(80)
    local font, _, flags = txtCoreScore2:GetFont()
    txtCoreScore2:SetFont(fontPath, 16, flags) 
    txtCoreScore2:SetTextColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue) -- Red color
      
    --  ScoreboardSummaryDetailsFrame
    ScoreboardSummaryDetailsFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    ScoreboardSummaryDetailsFrame:SetWidth(200)
    ScoreboardSummaryDetailsFrame:SetHeight(246)
    ScoreboardSummaryDetailsFrame:SetPoint("TOP", ScoreboardSummaryFrame, "BOTTOM", 22, -10)
    
    -- Set backdrop with gradient background and border
    ScoreboardSummaryDetailsFrame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = Current_hcs_Border,
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    ScoreboardSummaryDetailsFrame:SetBackdropColor(0, 0, 0, 1)
    ScoreboardSummaryDetailsFrame:SetBackdropBorderColor(1, 1, 1)
    
    ScoreboardSummaryDetailsFrame:SetMovable(false)
    ScoreboardSummaryDetailsFrame:EnableMouse(true)
    ScoreboardSummaryDetailsFrame:RegisterForDrag("LeftButton")
       
    -- Character Name
    txt_charactername = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_charactername:SetPoint("TOPLEFT",  10, -10)
    txt_charactername:SetJustifyH("LEFT")
    txt_charactername:SetWidth(ranklabelwidth)    
    local font, _, flags = txt_charactername:GetFont()
    txt_charactername:SetFont(fontPath, fontSize, flags) 

    -- Rank
    txt_rank = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_rank:SetPoint("TOPLEFT", txt_charactername, "BOTTOMLEFT", 0, -5)
    txt_rank:SetJustifyH("LEFT")
    txt_rank:SetWidth(ranklabelwidth)    
    local font, _, flags = txt_rank:GetFont()
    txt_rank:SetFont(fontPath, fontSize, flags) 

    -- Next Level
    txt_nextlevel = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_nextlevel:SetPoint("TOPLEFT", txt_rank, "BOTTOMLEFT", 0, -5)    
    txt_nextlevel:SetJustifyH("LEFT")
    txt_nextlevel:SetWidth(labelwidth)    
    local font, _, flags = txt_nextlevel:GetFont()
    txt_nextlevel:SetFont(fontPath, fontSize, flags) 

    -- Class Image
    imageClass = ScoreboardSummaryDetailsFrame:CreateTexture(nil, "OVERLAY")
    local originalWidth = 64
    local originalHeight = 64
    local scaleFactor = 0.75
    local newWidth = originalWidth * scaleFactor
    local newHeight = originalHeight * scaleFactor
    
    imageClass:SetSize(newWidth, newHeight)
    imageClass:SetPoint("LEFT", txt_nextlevel, "RIGHT", 5, 20)
    imageClass:SetTexture("Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\hcs_hunter.blp")
    
    -- Image divider
    imagedivider = ScoreboardSummaryDetailsFrame:CreateTexture(nil, "OVERLAY")
    imagedivider:SetSize(170, 1)  -- Thin line image at the top    
    imagedivider:SetPoint("TOPLEFT", txt_nextlevel, "BOTTOMLEFT", 0, -5)    
    imagedivider:SetTexture("Interface\\Addons\\Hardcore_Score\\Media\\hcs-line2a.blp"  )

    -- Equipped Gear
    txt_equippedgear = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_equippedgear:SetPoint("TOPLEFT", imagedivider, "BOTTOMLEFT", 0, -5)
    txt_equippedgear:SetText("Equipped Gear")
    txt_equippedgear:SetJustifyH("LEFT")
    txt_equippedgear:SetWidth(labelwidth)    
    local font, _, flags = txt_equippedgear:GetFont()
    txt_equippedgear:SetFont(fontPath, fontSize, flags) 

    -- Equipped Gear Score
    txt_equippedgear_score = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_equippedgear_score:SetPoint("LEFT", txt_equippedgear, "RIGHT", frame2scoreposition, 0)
    txt_equippedgear_score:SetJustifyH("RIGHT")
    txt_equippedgear_score:SetWidth(labelwidthscore)
    local font, _, flags = txt_equippedgear_score:GetFont()
    txt_equippedgear_score:SetFont(fontPath, fontSize, flags) 
    txt_equippedgear_score:SetTextColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue) -- Red color    


    -- Leveling
    txt_leveling = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_leveling:SetPoint("TOPLEFT", txt_equippedgear, "BOTTOMLEFT", 0, -5)
    txt_leveling:SetJustifyH("LEFT")
    txt_leveling:SetWidth(labelwidth)
    local font, _, flags = txt_leveling:GetFont()
    txt_leveling:SetFont(fontPath, fontSize, flags)

    -- Leveling Score
    txt_leveling_score = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_leveling_score:SetPoint("LEFT", txt_leveling, "RIGHT", frame2scoreposition, 0)
    txt_leveling_score:SetJustifyH("RIGHT")
    txt_leveling_score:SetWidth(labelwidthscore)
    local font, _, flags = txt_leveling_score:GetFont()
    txt_leveling_score:SetFont(fontPath, fontSize, flags) 
    txt_leveling_score:SetTextColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue) 

    -- Questing
    txt_questing = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_questing:SetPoint("TOPLEFT", txt_leveling, "BOTTOMLEFT", 0, -5)
    txt_questing:SetJustifyH("LEFT")
    txt_questing:SetWidth(labelwidth)
    local font, _, flags = txt_questing:GetFont()
    txt_questing:SetFont(fontPath, fontSize, flags) 

    -- Questing Score
    txt_questing_score = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_questing_score:SetPoint("LEFT", txt_questing, "RIGHT", frame2scoreposition, 0)
    txt_questing_score:SetJustifyH("RIGHT")
    txt_questing_score:SetWidth(labelwidthscore)
    local font, _, flags = txt_questing_score:GetFont()
    txt_questing_score:SetFont(fontPath, fontSize, flags) 
    txt_questing_score:SetTextColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue) -- Red color    

    -- Mobs Killed

    -- Create a wrapper frame for txt_mobskilled
    local txt_mobskilledWrapper = CreateFrame("Frame", nil, ScoreboardSummaryDetailsFrame)
    txt_mobskilledWrapper:SetPoint("TOPLEFT", txt_questing, "BOTTOMLEFT", 0, -5)

    -- Mobs Killed font string
    txt_mobskilled = txt_mobskilledWrapper:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_mobskilled:SetJustifyH("LEFT")
    txt_mobskilled:SetWidth(labelwidth)
    txt_mobskilled:SetText("Mobs Killed")  -- seems to be needed to set the proper place to trigger the tooltip.  
    local font, _, flags = txt_mobskilled:GetFont()
    txt_mobskilled:SetFont(fontPath, fontSize, flags) 


    -- Set the position of txt_mobskilled within its wrapper frame
    txt_mobskilled:SetPoint("TOPLEFT", txt_mobskilledWrapper, "TOPLEFT", 0, 0)

    -- Calculate and set the size of the wrapper frame after the font string has been created
    txt_mobskilledWrapper:SetSize(labelwidth, txt_mobskilled:GetHeight())

    -- Create a tooltip for txt_mobskilledWrapper
    txt_mobskilledWrapper:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:SetText("Mobs Killed", 1, 1, 1, true)
        
        HCS_KillingMobsScore:GetToolTip(GameTooltip)
        GameTooltip:Show()
    end)

    txt_mobskilledWrapper:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- Mobs Killed Score
    txt_mobskilled_score = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_mobskilled_score:SetPoint("LEFT", txt_mobskilled, "RIGHT", frame2scoreposition, 0)
    txt_mobskilled_score:SetJustifyH("RIGHT")
    txt_mobskilled_score:SetWidth(labelwidthscore)
    local font, _, flags = txt_mobskilled_score:GetFont()
    txt_mobskilled_score:SetFont(fontPath, fontSize, flags) 
    txt_mobskilled_score:SetTextColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue) 

    -- Professions
    txt_professions = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_professions:SetPoint("TOPLEFT", txt_mobskilled, "BOTTOMLEFT", 0, -5)
    txt_professions:SetJustifyH("LEFT")
    txt_professions:SetWidth(labelwidth)
    local font, _, flags = txt_professions:GetFont()
    txt_professions:SetFont(fontPath, fontSize, flags) 

    -- Professions Score
    txt_professions_score = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_professions_score:SetPoint("LEFT", txt_professions, "RIGHT", frame2scoreposition, 0)
    txt_professions_score:SetJustifyH("RIGHT")
    txt_professions_score:SetWidth(labelwidthscore)
    local font, _, flags = txt_professions_score:GetFont()
    txt_professions_score:SetFont(fontPath, fontSize, flags) 
    txt_professions_score:SetTextColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue) 

    -- Reputations (Factions)
    txt_reputation = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_reputation:SetPoint("TOPLEFT", txt_professions, "BOTTOMLEFT", 0, -5)
    txt_reputation:SetJustifyH("LEFT")
    txt_reputation:SetWidth(labelwidth)
    local font, _, flags = txt_reputation:GetFont()
    txt_reputation:SetFont(fontPath, fontSize, flags) 

    -- Reputations Score
    txt_reputation_score = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_reputation_score:SetPoint("LEFT", txt_reputation, "RIGHT", frame2scoreposition, 0)
    txt_reputation_score:SetJustifyH("RIGHT")
    txt_reputation_score:SetWidth(labelwidthscore)
    local font, _, flags = txt_reputation_score:GetFont()
    txt_reputation_score:SetFont(fontPath, fontSize, flags) 
    txt_reputation_score:SetTextColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue) 

    -- Discovery
    txt_discovery = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_discovery:SetPoint("TOPLEFT", txt_reputation, "BOTTOMLEFT", 0, -5)
    txt_discovery:SetJustifyH("LEFT")
    txt_discovery:SetWidth(labelwidth)
    local font, _, flags = txt_discovery:GetFont()
    txt_discovery:SetFont(fontPath, fontSize, flags) 

    -- Discovery Score
    txt_discovery_score = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_discovery_score:SetPoint("LEFT", txt_discovery, "RIGHT", frame2scoreposition, 0)
    txt_discovery_score:SetJustifyH("RIGHT")
    txt_discovery_score:SetWidth(labelwidthscore)
    local font, _, flags = txt_discovery_score:GetFont()
    txt_discovery_score:SetFont(fontPath, fontSize, flags) 
    txt_discovery_score:SetTextColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)     

    -- Milestones

    -- Create a wrapper frame for txt_milestones
    local txt_milestonesWrapper = CreateFrame("Frame", nil, ScoreboardSummaryDetailsFrame)
    txt_milestonesWrapper:SetPoint("TOPLEFT", txt_discovery, "BOTTOMLEFT", 0, -5)

    -- Milestones font string
    txt_milestones = txt_milestonesWrapper:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_milestones:SetJustifyH("LEFT")
    txt_milestones:SetWidth(labelwidth)
    txt_milestones:SetText("Milestones")  -- seems to be needed to set the proper place to trigger the tooltip.  
    local font, _, flags = txt_milestones:GetFont()
    txt_milestones:SetFont(fontPath, fontSize, flags) 

    -- Set the position of txt_milestones within its wrapper frame
    txt_milestones:SetPoint("TOPLEFT", txt_milestonesWrapper, "TOPLEFT", 0, 0)

    -- Calculate and set the size of the wrapper frame after the font string has been created
    txt_milestonesWrapper:SetSize(labelwidth, txt_milestones:GetHeight())

    -- Create a tooltip for txt_milestonesWrapper
    txt_milestonesWrapper:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:SetText(string.format("%.2f", HCScore_Character.scores.milestonesScore).. " Milestone Points", 1, 1, 1, true)
        
        HCS_MilestonesScore:GetToolTip(GameTooltip)
       
        GameTooltip:Show()
    end)

    txt_milestonesWrapper:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- Milestones Score
    txt_milestones_score = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_milestones_score:SetPoint("LEFT", txt_milestones, "RIGHT", frame2scoreposition, 0)
    txt_milestones_score:SetJustifyH("RIGHT")
    txt_milestones_score:SetWidth(labelwidthscore)
    local font, _, flags = txt_milestones_score:GetFont()
    txt_milestones_score:SetFont(fontPath, fontSize, flags) 
    txt_milestones_score:SetTextColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue) 

    ScoreboardSummaryDetailsFrame:Hide()


    -- Achievements

    -- Create a wrapper frame for txt_milestones
    local txt_achievementsWrapper = CreateFrame("Frame", nil, ScoreboardSummaryDetailsFrame)
    txt_achievementsWrapper:SetPoint("TOPLEFT", txt_milestones, "BOTTOMLEFT", 0, -5)

    -- Achievements font string
    txt_achievements = txt_achievementsWrapper:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_achievements:SetJustifyH("LEFT")
    txt_achievements:SetWidth(labelwidth)
    txt_achievements:SetText("Achievements")  -- seems to be needed to set the proper place to trigger the tooltip.  
    local font, _, flags = txt_achievements:GetFont()
    txt_achievements:SetFont(fontPath, fontSize, flags) 

    -- Set the position of txt_milestones within its wrapper frame
    txt_achievements:SetPoint("TOPLEFT", txt_achievementsWrapper, "TOPLEFT", 0, 0)

    -- Calculate and set the size of the wrapper frame after the font string has been created
    txt_achievementsWrapper:SetSize(labelwidth, txt_achievements:GetHeight())

    -- Create a tooltip for txt_milestonesWrapper
    txt_achievementsWrapper:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:SetText(string.format("%.2f", HCScore_Character.scores.achievementScore).. " Achievement Points", 1, 1, 1, true)           
        GameTooltip:Show()
    end)

    txt_achievementsWrapper:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- Achievements Score
    txt_achievements_score = ScoreboardSummaryDetailsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    txt_achievements_score:SetPoint("LEFT", txt_achievements, "RIGHT", frame2scoreposition, 0)
    txt_achievements_score:SetJustifyH("RIGHT")
    txt_achievements_score:SetWidth(labelwidthscore)
    local font, _, flags = txt_achievements_score:GetFont()
    txt_achievements_score:SetFont(fontPath, fontSize, flags) 
    txt_achievements_score:SetTextColor(txtNumberColor.red, txtNumberColor.green, txtNumberColor.blue)    

    ScoreboardSummaryDetailsFrame:Hide()

    local function CreateDropDown(frame)
        local info = UIDropDownMenu_CreateInfo()
        info.isTitle = 1
        info.text = "Options"
        info.notCheckable = 1
        UIDropDownMenu_AddButton(info)
    
        info = UIDropDownMenu_CreateInfo()
        info.text = frameLocked and "Unlock Frame" or "Lock Frame"
        info.func = function()
            frameLocked = not frameLocked
            Hardcore_Score.db.profile.lockScoreboardSummaryUI = frameLocked
        end
        info.notCheckable = 1
        UIDropDownMenu_AddButton(info)
    end

    function ScoreboardSummaryFrame:SetScoreboardSummaryDetailsFramePosition()
        local bottom = ScoreboardSummaryFrame:GetBottom()
        local screenHeight = GetScreenHeight()
        local frameHeight = ScoreboardSummaryDetailsFrame:GetHeight()
        
        ScoreboardSummaryDetailsFrame:ClearAllPoints()
        
        -- Default position (below the ScoreboardSummaryFrame)
        local defaultPoint = "TOP"
        local relativeTo = ScoreboardSummaryFrame
        local relativePoint = "BOTTOM"
        local xOffset = 22
        local yOffset = -10
        
        -- Check if placing below would go off the screen
        if bottom - frameHeight < 0 then
            -- Not enough space below, place above
            defaultPoint = "BOTTOM"
            relativePoint = "TOP"
            yOffset = 10
        end
        
        ScoreboardSummaryDetailsFrame:SetPoint(defaultPoint, relativeTo, relativePoint, xOffset, yOffset)
    end
    
    -- mouseover show/hide frame2
    ScoreboardSummaryFrame:SetScript("OnEnter", function()
        -- Set the position based on screen space
        ScoreboardSummaryFrame:SetScoreboardSummaryDetailsFramePosition()
        ScoreboardSummaryDetailsFrame:Show()
    end)

    ScoreboardSummaryFrame:SetScript("OnLeave", function()
        if not isFrame2Visible then
            ScoreboardSummaryDetailsFrame:Hide()
        end
    end)

    ScoreboardSummaryFrame:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" then
            isFrame2Visible = not isFrame2Visible
            if isFrame2Visible then
                ScoreboardSummaryDetailsFrame:Show()
            else
                ScoreboardSummaryDetailsFrame:Hide()
            end
    
            Hardcore_Score.db.profile.showDetails = isFrame2Visible
        elseif button == "RightButton" then
            local menuFrame = CreateFrame("Frame", "ScoreboardDropdownMenu", UIParent, "UIDropDownMenuTemplate")
            UIDropDownMenu_Initialize(menuFrame, function() CreateDropDown(ScoreboardSummaryFrame) end, "MENU")
            ToggleDropDownMenu(1, nil, menuFrame, "cursor", 3, -3)
        end
    end)

end

local function GetPlayerInfoText()
    local playerInfoText = ""
    local factionText = ""
    
    local name = HCS_Utils:GetTextWithClassColor(HCScore_Character.classid, HCScore_Character.name)
    local race = HCS_Utils:GetTextWithClassColor(HCScore_Character.classid, HCScore_Character.race)
    local class = HCS_Utils:GetTextWithClassColor(HCScore_Character.classid, HCScore_Character.class)

    playerInfoText = name.. "  "..race.."  "..class --..factionText 

    return playerInfoText 
end

function HCS_ScoreboardSummaryUI:UpdateUI()
    local totProfessions = HCS_ProfessionsScore:GetNumberOfProfessions()
    local totReputations = HCS_ReputationScore:GetNumFactions()
    local totMobTypesKilled = HCS_KillingMobsScore:GetTotalMobsKilled()  --HCS_KillingMobsScore:GetNumMobTypes()
    local totQuests = HCS_PlayerQuestingScore:GetNumberOfQuests()
    local totDiscovery = HCS_DiscoveryScore:GetNumberOfDiscovery()
    local totMilestones = HCS_MilestonesScore:GetNumberOfMilestones()
    local totAchievements = HCS_AchievementScore:GetNumberOfAchievements()
    local leveling = UnitLevel("player")
    local playerInfoText = GetPlayerInfoText()
    
    local equippedgearScore = HCScore_Character.scores.equippedGearScore
    local levelingScore = HCScore_Character.scores.levelingScore
    local questingScore = HCScore_Character.scores.questingScore
    local mobskilledScore = HCScore_Character.scores.mobsKilledScore
    local professionsScore = HCScore_Character.scores.professionsScore
    local reputationScore = HCScore_Character.scores.reputationScore
    local discoveryScore = HCScore_Character.scores.discoveryScore
    local milestonesScore = HCScore_Character.scores.milestonesScore
    local achievementsScore = HCScore_Character.scores.achievementScore

    local coreScore = HCScore_Character.scores.coreScore

    --ScoreboardSummaryFrame
    txtCoreScore2:SetText(HCS_Utils:AddThousandsCommas(string.format("%.2f", coreScore)))
    
    -- Set Portrait
    imgPortrait:SetTexture(Current_hcs_Portrait)
    imageClass:SetTexture(HCS_Utils:GetClassImage(HCScore_Character.classid))

    -- Summary Frame
    ScoreboardSummaryFrame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = Current_hcs_Border,
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    ScoreboardSummaryFrame:SetBackdropColor(0, 0, 0, 1)
    ScoreboardSummaryFrame:SetBackdropBorderColor(1, 1, 1)

    -- Summary Details Frame
    ScoreboardSummaryDetailsFrame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = Current_hcs_Border,
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    ScoreboardSummaryDetailsFrame:SetBackdropColor(0, 0, 0, 1)
    ScoreboardSummaryDetailsFrame:SetBackdropBorderColor(1, 1, 1)
   
    --ScoreboardDetailsFrame
    txt_charactername:SetText("Name: " ..HCS_Utils:GetTextWithClassColor(HCScore_Character.classid, HCScore_Character.name))
    txt_rank:SetText("Rank: " ..HCS_Utils:GetRankLevelText(HCS_PlayerRank.Rank, HCS_PlayerRank.Level))
    txt_nextlevel:SetText("LVL Completed: |cffff8000"..HCS_Utils:GetPercentageToNextLevelAsText())
    txt_equippedgear_score:SetText(string.format("%.2f", equippedgearScore))    
    txt_leveling:SetText("Leveling: |cffff8000".. leveling)  -- txt_leveling:SetText("Leveling: "..leveling)
    txt_leveling_score:SetText(string.format("%.2f",levelingScore))
    txt_questing:SetText("Questing: |cffff8000"..totQuests)
    txt_questing_score:SetText(string.format("%.2f", questingScore))
    txt_mobskilled:SetText("Mobs Killed: |cffff8000"..totMobTypesKilled)
    txt_mobskilled_score:SetText(string.format("%.2f", mobskilledScore))
    txt_professions:SetText("Professions: |cffff8000"..totProfessions)
    txt_professions_score:SetText(string.format("%.2f", professionsScore))
    txt_reputation:SetText("Reputation: |cffff8000"..totReputations)
    txt_reputation_score:SetText(string.format("%.2f", reputationScore))
    txt_discovery:SetText("Discovery: |cffff8000"..totDiscovery)
    txt_discovery_score:SetText(string.format("%.2f", discoveryScore))
    txt_milestones:SetText("Milestones: |cffff8000"..totMilestones)
    txt_milestones_score:SetText(string.format("%.2f", milestonesScore))
    txt_achievements:SetText("Achievements: |cffff8000"..totAchievements)
    txt_achievements_score:SetText(string.format("%.2f", achievementsScore))

end

