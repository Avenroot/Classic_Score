HCS_CalculateScore = {}

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

local function between(x, a, b)
    return x >= a and x <= b
end


function GetPlayerRank()
    local playerScore = HCScore_Character.scores.coreScore
    local oldRank = HCS_PlayerRank.Rank
    local oldLevel = HCS_PlayerRank.Level

    -- look up players Rank in HCS_RanksDB
    for _, Rank in pairs(HCS_RanksDB) do
        if between(playerScore, Rank.MinPoints, Rank.MaxPoints) then
            HCS_PlayerRank = Rank
            break
        end
    end

    if HCS_print then
        if HCS_PlayerRank.Rank > oldRank or HCS_PlayerRank.Level > oldLevel then
            if Hardcore_Score.db.profile.framePositionMsg.show then                 
                local shouldDisplayRankChangeImage = oldRank ~= HCS_PlayerRank.Rank
                local frame = HCS_MessageFrameUI.DisplayHCSRankLevelingMessage(delay, shouldDisplayRankChangeImage)
                frame:EnqueueMessage()   
                
                if shouldDisplayRankChangeImage then
                    if IsInGuild() then
                        if Hardcore_Score.db.profile.shareDetails and Hardcore_Score.db.profile.shareRankProgression then
                            local rank = string.upper(HCS_PlayerRank.LevelText)
                            local score = string.format("%.2f", HCScore_Character.scores.coreScore)
                            local message = "I have reached "..rank.." Rank - Hardcore SCORE "..score
                            SendChatMessage(message, "GUILD")  -- Send the message to guild chat                         
                        end                        
                    end
                end
            end    
        end            
    end
end

local function RefreshUI()
    HCS_ScoreboardSummaryUI:UpdateUI()
    HCS_CharactersInfoUI:LoadData()
    HCS_LeaderBoardUI:RefreshData() --HCS_LeaderBoardUI:LoadData()

    if HCS_PlayerCom ~= nil then
        HCS_PlayerCom:SendScore()       
    end
end

-- Function to check if a value exists in a table
local function tableContains(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

local function LeveledUp(points)

    local playerLevel = UnitLevel("player")

    if Hardcore_Score.db.profile.framePositionMsg.show then       
        local msg = "Level "..playerLevel
        local frame = HCS_MessageFrameUI.DisplayLevelingMessage(msg, 5)
        frame:EnqueueMessage()
      end
    
    HCS_PlayerLevelingScore:SaveLevelScore()
    HCS_OldLevel = playerLevel
    PlayerLeveled = false


    if Hardcore_Score.db.profile.shareDetails and Hardcore_Score.db.profile.shareLevelProgression then
        if IsInGuild() then
            local score = string.format("%.2f", HCScore_Character.scores.coreScore)
            local validLevels = {10, 20, 30, 40, 50, 60}
        
            -- Check if the player's level is in the list of valid levels
            if tableContains(validLevels, playerLevel) then
                local message = "I have reached lvl " .. playerLevel .. " - Hardcore Score " .. score
                SendChatMessage(message, "GUILD")  -- Send the message to guild chat
            end            
        end
    end
    
end

local function UpdateProfileScores()    
    Hardcore_Score.db.global.characterScores[HCScore_Character.name] = {
        charClass = HCScore_Character.class,
        charClassId = HCScore_Character.classid,
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

local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function CalculateScore()

    local equippmentScore = HCScore_Character.scores.equippedGearScore -- Equipment Score can go backwards
    local coreScore = HCScore_Character.scores.coreScore

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

    -- Set scores back if coreScore goes backwards
    local equippmentScoreRounded = round(equippmentScore, 3)
    local equippedGearScoreRounded = round(HCScore_Character.scores.equippedGearScore, 3)
    local diff = equippmentScoreRounded - equippedGearScoreRounded
    local threshold = 0.0001 -- Adjust this threshold as needed
    
    if diff > threshold then    
        HCScore_Character.scores.equippedGearScore = equippmentScore
        if HCScore_Character.scores.coreScore < coreScore then
            HCScore_Character.scores.coreScore = HCScore_Character.scores.coreScore  + diff  
        end
        
    end
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
    CalculateScore()
    UpdateProfileScores()
    GetPlayerRank()
    RefreshUI()
    Current_hcs_Portrait = HCS_PlayerRank.PortraitImage
    Current_hcs_Border = HCS_PlayerRank.PortraitBoarderImage

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

