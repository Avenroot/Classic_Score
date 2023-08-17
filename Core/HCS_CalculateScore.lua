HCS_CalculateScore = {}

--local levelScalePercentage = 0

-- Portrait Level Points Classic
local GREY = 0
local GREEN = 100
local BLUE = 1000
local PURPLE = 2500
local ORANGE = 5000
local RED = 10000
local GOLD = 15000

-- Portrait Level Points WOTLK - increased by 33.33%
local GREY_wotlk = 0
local GREEN_wotlk = 133  
local BLUE_wotlk = 1333  
local PURPLE_wotlk = 3333 
local ORANGE_wotlk = 6667
local RED_wotlk = 13333
local GOLD_wotlk = 20000

local beforeStats = {
    equippedGearScore = 0,
    levelingScore = 0,
    professionsScore = 0,
    reputationScore = 0,
    discoveryScore = 0,
    milestonesScore = 0,
    achievementScore = 0,
    questingScore = 0,
    mobsKilledScore = 0,
    coreScore = 0,
}

local function SetBeforeStats()
    beforeStats.equippedGearScore = HCScore_Character.scores.equippedGearScore
    beforeStats.levelingScore = HCScore_Character.scores.levelingScore
    beforeStats.professionsScore = HCScore_Character.scores.professionsScore
    beforeStats.reputationScore = HCScore_Character.scores.reputationScore
    beforeStats.discoveryScore = HCScore_Character.scores.discoveryScore
    beforeStats.milestonesScore = HCScore_Character.scores.milestonesScore
    beforeStats.questingScore = HCScore_Character.scores.questingScore
    beforeStats.mobsKilledScore = HCScore_Character.scores.mobsKilledScore
    beforeStats.achievementScore = HCScore_Character.scores.achievementScore
    beforeStats.coreScore = HCScore_Character.scores.coreScore
end

local function CompareStats(beforeStats, scores, descriptions)
    for key, value in pairs(beforeStats) do
        local desc = descriptions[key] or key -- Use the matched description if available, otherwise use the key itself

        if key ~= "coreScore" and beforeStats[key] ~= scores[key]  then
            -- Values are different, do something            
            local difference = scores[key] - beforeStats[key]
            local formatted_time = date("%H:%M:%S")
            local msg = ""
            local showTimestamp = Hardcore_Score.db.profile.framePositionLog.showTimestamp
            if showTimestamp then
                msg = "[" .. formatted_time .. "] " .. (desc) .. " " .. string.format("%.3f", difference) .. " pts"
            else
                msg = (desc) .. " " .. string.format("%.3f", difference) .. " pts"
            end
            HCS_PointsLogUI:AddMessage(msg)
        end
    end
end

function GetCurrentPortrait()
    local playerLevel = UnitLevel("player")
    local playerScore = HCScore_Character.scores.coreScore
    local currentPortrait = Img_hcs_lvl_1_portrait -- default 
    local currentBorder = Img_hcs_lvl_1_border -- default  

    if HCS_GameVersion < 30000 then -- Classic
        -- Gold Crown
        if playerLevel == 60 and playerScore > GOLD then
            currentPortrait = Img_hcs_lvl_7_portrait
            currentBorder = Img_hcs_lvl_7_border
        -- Red Diamond
        elseif playerLevel >= 50 and playerScore >= RED then
            currentPortrait = Img_hcs_lvl_6_portrait
            currentBorder = Img_hcs_lvl_6_border
        -- Orange
        elseif playerLevel >= 40 and playerScore >= ORANGE then
            currentPortrait = Img_hcs_lvl_5_portrait
            currentBorder = Img_hcs_lvl_5_border
        -- Purple
        elseif playerLevel >= 30 and playerScore >= PURPLE then
            currentPortrait = Img_hcs_lvl_4_portrait
            currentBorder = Img_hcs_lvl_4_border
        -- Blue
        elseif playerLevel >= 20 and playerScore >= BLUE then
            currentPortrait = Img_hcs_lvl_3_portrait
            currentBorder = Img_hcs_lvl_3_border
        -- Green
        elseif playerLevel >= 10 and playerScore >= GREEN then
            currentPortrait = Img_hcs_lvl_2_portrait
            currentBorder = Img_hcs_lvl_2_border
        -- Grey
        elseif playerLevel >= 1 and playerScore >= GREY then
            currentPortrait = Img_hcs_lvl_1_portrait
            currentBorder = Img_hcs_lvl_1_border
        end
    else  -- WOTLK
        -- Gold Crown
        if playerLevel == 80 and playerScore > GOLD_wotlk then  -- Level increased to 80
            currentPortrait = Img_hcs_lvl_7_portrait
            currentBorder = Img_hcs_lvl_7_border
        -- Red Diamond
        elseif playerLevel >= 67 and playerScore >= RED_wotlk then  -- Level increased to 67
            currentPortrait = Img_hcs_lvl_6_portrait
            currentBorder = Img_hcs_lvl_6_border
        -- Orange
        elseif playerLevel >= 53 and playerScore >= ORANGE_wotlk then  -- Level increased to 53
            currentPortrait = Img_hcs_lvl_5_portrait
            currentBorder = Img_hcs_lvl_5_border
        -- Purple
        elseif playerLevel >= 40 and playerScore >= PURPLE_wotlk then  -- Level increased to 40
            currentPortrait = Img_hcs_lvl_4_portrait
            currentBorder = Img_hcs_lvl_4_border
        -- Blue
        elseif playerLevel >= 27 and playerScore >= BLUE_wotlk then  -- Level increased to 27
            currentPortrait = Img_hcs_lvl_3_portrait
            currentBorder = Img_hcs_lvl_3_border
        -- Green
        elseif playerLevel >= 13 and playerScore >= GREEN_wotlk then  -- Level increased to 13
            currentPortrait = Img_hcs_lvl_2_portrait
            currentBorder = Img_hcs_lvl_2_border
        -- Grey
        elseif playerLevel >= 1 and playerScore >= GREY_wotlk then
            currentPortrait = Img_hcs_lvl_1_portrait
            currentBorder = Img_hcs_lvl_1_border
        end                
    end

    return currentPortrait, currentBorder
end

local function RefreshUI()
    HCS_ScoreboardSummaryUI:UpdateUI()
    HCS_CharactersInfoUI:LoadData()

    if HCS_PlayerCom ~= nil then
        HCS_PlayerCom:SendScore()       
    end
end

local function LeveledUp(points)

    local playerLevel = UnitLevel("player")

    if Hardcore_Score.db.profile.framePositionMsg.show then       
        local msg = "Level "..playerLevel
        local frame = HCS_MessageFrameUI.DisplayLevelingMessage(msg, 5)
        frame:ShowMessage()
      end
    
    HCS_PlayerLevelingScore:SaveLevelScore()
    HCS_OldLevel = PlayerLevel
    PlayerLeveled = false
end

local function UpdateProfileScores()    
    Hardcore_Score.db.global.characterScores[HCScore_Character.name] = {
        charClass = HCScore_Character.class,
        coreScore = HCScore_Character.scores.coreScore,
        equippedGearScore = HCScore_Character.scores.equippedGearScore,
        levelingScore = HCScore_Character.scores.levelingScore,
        questingScore = HCScore_Character.scores.questingScore,
        mobsKilledScore = HCScore_Character.scores.mobsKilledScore,
        professionsScore = HCScore_Character.scores.professionsScore,
        reputationScore = HCScore_Character.scores.reputationScore,
        discoveryScore = HCScore_Character.scores.discoveryScore,
        milestonesScore = HCScore_Character.scores.milestonesScore,
        achievementScore = HCScore_Character.scores.achievementScore,
    }
end

function HCS_CalculateScore:RefreshScores(desc)
    
    if HCS_OldLevel == nil or HCS_OldLevel == 0 then HCS_OldLevel = UnitLevel("player") end -- makes sure HCS_OldLevel is set correctly when logging in.
   
    -- Update Scaling Percentage
    if HCS_GameVersion < 30000 then
        HCS_LevelScalePercentage = (UnitLevel("player")  / 60) -- Classic
    else
        HCS_LevelScalePercentage = (UnitLevel("player")  / 80) -- WOTLK
    end

    _G["CurrentXP"] = UnitXP("player")  -- CurrentXP
    _G["CurrentMaxXP"] = UnitXPMax("player") -- CurrentMaxXP

    SetBeforeStats()
    HCS_MilestonesScore:CheckMilestones()
    HCS_AchievementScore:CheckAchievements()

    HCScore_Character.scores.levelingScore = HCS_PlayerLevelingScore:GetLevelScore() * HCS_LevelScalePercentage
    HCScore_Character.scores.equippedGearScore = HCS_PlayerEquippedGearScore:GetEquippedGearScore() * HCS_LevelScalePercentage
    HCScore_Character.scores.professionsScore = HCS_ProfessionsScore:GetProfessionsScore() * HCS_LevelScalePercentage
    HCScore_Character.scores.reputationScore = HCS_ReputationScore:GetReputationScore() * (HCS_LevelScalePercentage ^ 2)
    HCScore_Character.scores.discoveryScore = HCS_DiscoveryScore:GetDiscoveryScore() * HCS_LevelScalePercentage
    HCScore_Character.scores.milestonesScore = HCS_MilestonesScore:GetMilestonesScore() * HCS_LevelScalePercentage
    HCScore_Character.scores.achievementScore = HCS_AchievementScore:GetAchievementsScore() * HCS_LevelScalePercentage
    HCScore_Character.scores.questingScore = HCS_PlayerQuestingScore:GetQuestingScore()
    HCScore_Character.scores.mobsKilledScore = HCS_KillingMobsScore:GetMobsKilledScore()
    HCScore_Character.scores.coreScore = HCS_PlayerCoreScore:GetCoreScore()

    UpdateProfileScores()
    RefreshUI()
    Current_hcs_Portrait, Current_hcs_Border = GetCurrentPortrait()
    --Current_hcs_Portrait = Img_hcs_lvl_7_portrait
    --Current_hcs_Border = Img_hcs_lvl_7_border

    if desc ~= nil then
        CompareStats(beforeStats, HCScore_Character.scores, desc)
    end
 
    if HCS_OldLevel <  UnitLevel("player") then -- player has leveled
      local scorebefore = beforeStats.coreScore
      local scoreafter = HCScore_Character.scores.coreScore
      local scorediff = scoreafter - scorebefore
      LeveledUp(scorediff)
    end

end

