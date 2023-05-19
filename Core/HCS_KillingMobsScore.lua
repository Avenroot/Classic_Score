HCS_KillingMobsScore = {}

function HCS_KillingMobsScore:UpdateMobsKilled(mobScore, mobName)

    local currentMobScore = HCScore_Character.scores.mobsKilledScore
    HCScore_Character.scores.mobsKilledScore = currentMobScore + mobScore

    if not HCScore_Character.mobsKilled then
        HCScore_Character.mobsKilled = {}  -- Create an empty table
    end

    -- if the mobName is blank exit the function and do not record the kill
    if mobName == "" then return end

    local found = false

    for _, mob in pairs(HCScore_Character.mobsKilled) do
        if mob.id == mobName then
            mob.kills = mob.kills + 1
            mob.score = mob.score + mobScore
            found = true
            break
        end
    end

    if not found then
        -- add mob details
        local newMob = {
            id = mobName,
            kills = 1,
            score = mobScore
        }
        table.insert(HCScore_Character.mobsKilled, newMob)
    end
end

function HCS_KillingMobsScore:GetNumMobTypes()
    return #HCScore_Character.mobsKilled
end