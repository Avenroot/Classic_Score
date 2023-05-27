HCS_PlayerCoreScore = {}

function HCS_PlayerCoreScore:GetCoreScore()
    local levelscore = HCScore_Character.scores.levelingScore
    local equippedGearScore = HCScore_Character.scores.equippedGearScore
    local questingScore = HCScore_Character.scores.questingScore
    local mobsKilledScore = HCScore_Character.scores.mobsKilledScore
    local reputationScore = HCScore_Character.scores.reputationScore
    local discoveryScore = HCScore_Character.scores.discoveryScore
    local professionsScore = HCScore_Character.scores.professionsScore
    local score =  levelscore + equippedGearScore + questingScore + 
                mobsKilledScore + reputationScore + discoveryScore +
                professionsScore

    return score
end
