HCS_CalculateScore = {}

local levelScalePercentage = 0

-- Portrait Level Points
local GREY = 0
local GREEN = 100
local BLUE = 1000
local PURPLE = 2500
local ORANGE = 5000
local RED = 10000
local GOLD = 15000

local beforeStats = {
    equippedGearScore = 0,
    levelingScore = 0,
    professionsScore = 0,
    reputationScore = 0,
    discoveryScore = 0,
    milestonesScore = 0,
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
    beforeStats.coreScore = HCScore_Character.scores.coreScore
end

local function CompareStats(beforeStats, scores, descriptions)
    for key, value in pairs(beforeStats) do
        local desc = descriptions[key] or key -- Use the matched description if available, otherwise use the key itself

        
        if key ~= "coreScore" and beforeStats[key] ~= scores[key]  then
            -- Values are different, do something            
            local difference = scores[key] - beforeStats[key]
            local formatted_time = date("%H:%M:%S")
            local msg = "[" .. formatted_time .. "] " .. (desc) .. " " .. string.format("%.3f", difference) .. " pts"
            HCS_PointsLogUI:AddMessage(msg)
        end
    end
end

function GetCurrentPortrait()
    local playerLevel = UnitLevel("player")
    local playerScore = HCScore_Character.scores.coreScore
    local currentPortrait = Img_hcs_greyframe_32 -- default

    -- Gold Crown
    if playerLevel == 60 and playerScore > GOLD then
        currentPortrait = Img_hcs_gold_crown_portrait_32
    -- Red Diamond
    elseif playerLevel >= 50 and playerScore >= RED then
        currentPortrait = Img_hcs_red_diamond_portrait_32
    -- Orange
    elseif playerLevel >= 40 and playerScore >= ORANGE then
        currentPortrait = Img_hcs_orange_portrait_32
    -- Purple
    elseif playerLevel >= 30 and playerScore >= PURPLE then
        currentPortrait = Img_hcs_purple_portrait_32
    -- Blue
    elseif playerLevel >= 20 and playerScore >= BLUE then
        currentPortrait = Img_hcs_blue_portrait_32
    -- Green
    elseif playerLevel >= 10 and playerScore >= GREEN then
        currentPortrait = Img_hcs_green_portrait_32
    -- Grey
    elseif playerLevel >= 1 and playerScore >= GREY then
        currentPortrait = Img_hcs_grey_portrait_32
    end

    return currentPortrait
end

local function RefreshUI()
    HCS_ScoreboardSummaryUI:UpdateUI()

    if HCS_PlayerCom ~= nil then
        HCS_PlayerCom:SendScore()       
    end
end

local function LeveledUp(points)

    if Hardcore_Score.db.profile.framePositionMsg.show then    
        local playerLevel = UnitLevel("player")
        local msg = "Level Up! You reached level "..playerLevel

        local frame = HCS_MessageFrameUI.DisplayMessage(msg, 10, Img_hcs_levelupframe_32)
        frame:ShowMessage() 

       -- local msg = "You just gained "..string.format("%.3f",points).." pts by leveling!"
       -- local frame = HCS_MessageFrameUI.DisplayMessage(msg, 10, Img_hcs_levelupframe_32)
       -- frame:ShowMessage()     
      end
    
    HCS_PlayerLevelingScore:SaveLevelScore()
    PlayerLeveled = false

end

function HCS_CalculateScore:RefreshScores(desc)

    levelScalePercentage = (UnitLevel("player")  / 60) --* 100
    _G["CurrentXP"] = UnitXP("player")  -- CurrentXP
    _G["CurrentMaxXP"] = UnitXPMax("player") -- CurrentMaxXP

    SetBeforeStats()

    HCS_MilestonesScore:CheckMilestones()

    HCScore_Character.scores.equippedGearScore = HCS_PlayerEquippedGearScore:GetEquippedGearScore() * levelScalePercentage
    HCScore_Character.scores.levelingScore = HCS_PlayerLevelingScore:GetLevelScore() * levelScalePercentage
    HCScore_Character.scores.professionsScore = HCS_ProfessionsScore:GetProfessionsScore() * levelScalePercentage
    HCScore_Character.scores.reputationScore = HCS_ReputationScore:GetReputationScore() * (levelScalePercentage ^ 2)
    HCScore_Character.scores.discoveryScore = HCS_DiscoveryScore:GetDiscoveryScore() * levelScalePercentage
    HCScore_Character.scores.milestonesScore = HCS_MilestonesScore:GetMilestonesScore() * levelScalePercentage
    HCScore_Character.scores.questingScore = HCS_PlayerQuestingScore:GetQuestingScore()
    HCScore_Character.scores.mobsKilledScore = HCS_KillingMobsScore:GetMobsKilledScore()
    HCScore_Character.scores.coreScore = HCS_PlayerCoreScore:GetCoreScore()

    RefreshUI()
    CurrentPortrait = GetCurrentPortrait()

    if desc ~= nil then
        CompareStats(beforeStats, HCScore_Character.scores, desc)
    end

    if PlayerLeveled then 
      local scorebefore = beforeStats.coreScore
      local scoreafter = HCScore_Character.scores.coreScore
      local scorediff = scoreafter - scorebefore
      LeveledUp(scorediff)
    end

end

