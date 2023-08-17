HCS_PlayerLevelingScore = {}

local data = {}

local function CreateDataTable()
    for i = 1, 80 do
        local level = i
        local bonus = (level ^ 2) / 100
        local levelTotal = level + bonus
        local total = i == 1 and levelTotal or data[#data].Total + levelTotal

        table.insert(data, {Level = level, Bonus = bonus, LevelTotal = levelTotal, Total = total})
    end    
end

CreateDataTable()  -- This creates the data table once when the script is executed

function HCS_PlayerLevelingScore:GetLevelScore()    
    local score = 0
    local level = UnitLevel("player")
    HCScore_Character.level = level
    
    score = data[level].Total

    return score
end

function HCS_PlayerLevelingScore:SaveLevelScore()
    local playerLevel = HCScore_Character.level - 1
    local isLevelfound = false

    for _, lvl in pairs(HCScore_Character.levelScores) do
        if lvl.level == playerLevel then
            isLevelfound = true
            break
        end
    end

    if not isLevelfound then
        -- add level details
        local newLevel = {
            level = playerLevel,
            points = HCScore_Character.scores.coreScore,
        }
        table.insert(HCScore_Character.levelScores, newLevel)
    end

end
