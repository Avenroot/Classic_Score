HCS_KillingMobsScore = {}

function HCS_KillingMobsScore:UpdateMobsKilled(mobScore)
    local currentMobScore = HCScore_Character.scores.mobsKilledScore
    HCScore_Character.scores.mobsKilledScore = currentMobScore + mobScore    
end