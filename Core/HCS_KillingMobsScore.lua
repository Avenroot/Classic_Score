HCS_KillingMobsScore = {}

local TRIVAL = 0 -- grey
local EASY = 0.0005 -- green
local MODERATE = 0.00075 -- yellow
local HARD = 0.001 -- orange
local VERYHARD = 0.00125 -- red

local function between(x, a, b)
    return x >= a and x <= b
  end
  
function GetMobKillHCScore(mobLevel)
    local xpGain = HCS_XPUpdateEvent:GetXPGain()
    local score = 0

    local playerLevel = UnitLevel("player")
    local mobDifficulty = mobLevel - playerLevel
  
    -- grey
    if mobDifficulty <= -6 then
        score = 0
    end
    -- green
    if between(mobDifficulty, -5, -1) then
        score =  xpGain * EASY         
    end 
    -- yellow
    if between(mobDifficulty, 0, 3) then
        score = xpGain * MODERATE    
    end
    -- orange
    if between(mobDifficulty, 4, 5) then
        score = xpGain * HARD
    end
    -- red
    if mobDifficulty > 6 then
        score =  xpGain * VERYHARD
    end
    
    -- overrides all the other calculations above.  if mobLevel is 0 it means the mob could not be determined so 
    -- the player get a default multiplier of EASY
    if mobLevel == 0 then
        score = xpGain * EASY
    end

    return {score, mobDifficulty} 
end

function HCS_KillingMobsScore:UpdateMobsKilled()

    local currentMobScore = HCScore_Character.scores.mobsKilledScore
    local mobScore = GetMobKillHCScore(_G["MobLevel"])
    local mobName = _G["MobName"]

    HCScore_Character.scores.mobsKilledScore = currentMobScore + mobScore[1]

    if not HCScore_Character.mobsKilled then
        HCScore_Character.mobsKilled = {}  -- Create an empty table
    end

    if mobName == "" then
        mobName = "None"
        _G["MobName"] = mobName
    end

    local found = false

    for _, mob in pairs(HCScore_Character.mobsKilled) do
        if mob.id == mobName then
            mob.kills = mob.kills + 1
            mob.score = mob.score + mobScore[1]
            found = true
            break
        end
    end

    if not found then
        -- add mob details
        local newMob = {
            id = mobName,
            kills = 1,
            score = mobScore[1],
        }
        table.insert(HCScore_Character.mobsKilled, newMob)
    end

    local desc = mobName.." killed"

    HCS_CalculateScore:RefreshScores(desc)    
end

function HCS_KillingMobsScore:GetNumMobTypes()
    return #HCScore_Character.mobsKilled
end

function HCS_KillingMobsScore:GetMobsKilledScore()
    local score = 0

    for _, mob in pairs(HCScore_Character.mobsKilled) do
        score = score + mob.score
    end   
    
    return score

end