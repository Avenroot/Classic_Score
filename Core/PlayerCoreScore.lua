PlayerCoreScore = {}

function PlayerCoreScore:GetCoreScore()
    local levelscore = HCScore_Character.scores.levelingScore
    local equippedGearScore = HCScore_Character.scores.equippedGearScore
    local questingScore = HCScore_Character.scores.questingScore
    local mobsKilledScore = HCScore_Character.scores.mobsKilledScore
    local reputationScore = HCScore_Character.scores.reputationScore
    local discoveryScore = HCScore_Character.scores.discoveryScore
    local score =  levelscore + equippedGearScore + questingScore + 
                mobsKilledScore + reputationScore + discoveryScore
    

    --print("score = "..score)
    return score
end
