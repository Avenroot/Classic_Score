HCS_PlayerCoreScore = {}

function HCS_PlayerCoreScore:GetCoreScore()
    local levelscore = HCScore_Character.scores.levelingScore
    local equippedGearScore = HCScore_Character.scores.equippedGearScore
    local questingScore = HCScore_Character.scores.questingScore
    local mobsKilledScore = HCScore_Character.scores.mobsKilledScore
    local reputationScore = HCScore_Character.scores.reputationScore
    local discoveryScore = HCScore_Character.scores.discoveryScore
    local professionsScore = HCScore_Character.scores.professionsScore
    local milestonesScore = HCScore_Character.scores.milestonesScore
    local achievementScore = HCScore_Character.scores.achievementScore
    local score =  levelscore + equippedGearScore + questingScore + 
                mobsKilledScore + reputationScore + discoveryScore +
                professionsScore + milestonesScore + achievementScore

    -- Only execute if in WoW Classic, Season of Discovery
    if HCS_SODVersion then
        score = score + HCScore_Character.scores.runeScore
    end

    HCScore_Character.scores.coreScore = score
    return score
end
