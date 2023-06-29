HCS_CalculateScore = {}

LevelScalePercentage = 0

-- Portrait Level Points
local GREY = 0
local GREEN = 100
local BLUE = 1000
local PURPLE = 2500
local ORANGE = 5000
local RED = 10000
local GOLD = 15000

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

function HCS_CalculateScore:RefreshScores(desc)

    LevelScalePercentage = (UnitLevel("player")  / 60) --* 100
    _G["CurrentXP"] = UnitXP("player")  -- CurrentXP
    _G["CurrentMaxXP"] = UnitXPMax("player") -- CurrentMaxXP

    HCS_MilestonesScore:CheckMilestones()

    local scorebefore = HCScore_Character.scores.coreScore

    HCScore_Character.scores.equippedGearScore = HCS_PlayerEquippedGearScore:GetEquippedGearScore() * LevelScalePercentage
    HCScore_Character.scores.levelingScore = HCS_PlayerLevelingScore:GetLevelScore() * LevelScalePercentage
    HCScore_Character.scores.professionsScore = HCS_ProfessionsScore:GetProfessionsScore() * LevelScalePercentage
    HCScore_Character.scores.reputationScore = HCS_ReputationScore:GetReputationScore() * LevelScalePercentage
    HCScore_Character.scores.discoveryScore = HCS_DiscoveryScore:GetDiscoveryScore() * LevelScalePercentage
    HCScore_Character.scores.milestonesScore = HCS_MilestonesScore:GetMilestonesScore() * LevelScalePercentage
    HCScore_Character.scores.questingScore = HCS_PlayerQuestingScore:GetQuestingScore()
    HCScore_Character.scores.mobsKilledScore = HCS_KillingMobsScore:GetMobsKilledScore()
    HCScore_Character.scores.coreScore = HCS_PlayerCoreScore:GetCoreScore()
    
    RefreshUI()
    CurrentPortrait = GetCurrentPortrait()

    local scoreafter = HCScore_Character.scores.coreScore
    local scorediff = scoreafter - scorebefore
--    print(scorebefore)
--    print(scoreafter)
--    print(scorediff)
    if scorediff ~= 0 and desc ~= nil then
        local formatted_time = date("%H:%M:%S")
        local msg = "["..formatted_time.."]".."  "..desc.."  ".. string.format("%.3f",scorediff).." pts"
        HCS_PointsLogUI:AddMessage(msg)
    end

end

function RefreshUI()
    HCS_ScoreboardSummaryUI:UpdateUI()
    
    if HCS_PlayerCom ~= nil then
        HCS_PlayerCom:SendScore()       
    end
end