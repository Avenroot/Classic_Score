PlayerCoreScore = {}

function PlayerCoreScore:GetCoreScore()
    local levelscore = HCScore_Character.scores.levelingScore
    local equippedGearScore = HCScore_Character.scores.equippedGearScore
    local questingScore = HCScore_Character.scores.questingScore
    local mobsKilledScore = HCScore_Character.scores.mobsKilledScore
    local score =  levelscore + equippedGearScore + questingScore + mobsKilledScore
    

    --print("score = "..score)
    return score
end
