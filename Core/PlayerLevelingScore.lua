PlayerLevelingScore = {}

function PlayerLevelingScore:GetLevelScore()

    --[[
            Points for each level

            1-10 - 1 point for each level (10 max)

            11-20 - 2 points for each level (20 max)

            21-30 - 3 points for each level (30 max)

            31-40 - 4 points for each level (40 max)

            41-50 - 5 points for each level (50 max)

            51-60 - 6 points for each level (60 max)
    ]]
    
    local score = 0
    local level = UnitLevel("player")

    if level <= 10 then
            score = level
    end

    if level > 10 and level <= 20 then
            score = (level - 10) * 2 + 10
    end

    if level > 20 and level <= 30 then
            score = (level - 20) * 3 + 30
    end

    if level > 30 and level <= 40 then
            score = (level - 30) *4 + 60
    end

    if level > 40 and level <= 50 then
            score = (level - 40) * 5 + 100
    end

    if level > 50 and level <= 60 then
            score = (level - 50) * 6 + 150
    end

--    print("level score = "..score)
    CharacterInfo.scores.levelingScore = score

end
