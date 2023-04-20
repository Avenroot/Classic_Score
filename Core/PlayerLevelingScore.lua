PlayerLevelingScore = {}

function PlayerLevelingScore:CalculateTimeBonus()
  -- Start time
    local startTime = GetTime()

    -- End time (example: when player levels up)        
    local endTime = GetTime()
    local timeElapsed = endTime - startTime
    local levelTime = (UnitXPMax("player") - UnitXP("player")) / (UnitXPPerMinute("player") * 60) -- Calculate estimated time to level up based on current XP rate
    local timeRatio = timeElapsed / levelTime -- Calculate percentage of level time completed
    local timeBonus = math.floor((1 - timeRatio) * 100) -- Calculate time bonus as a percentage of 100
    print("Level up time:", timeElapsed, "Level time:", levelTime, "Time bonus:", timeBonus)
    
        
end

function PlayerLevelingScore:GetLevelScore()
    
    local score = 0
    local lvlTenBonus = 10
    local lvlTwentyBonus = 20
    local lvlThirtyBonus = 30
    local lvlFortyBonus = 40
    local lvlFiftyBonus = 50
    local lvlSixtyBonus = 60
    local level = UnitLevel("player")

    if level <= 10 then
            score = level
    end

    if level > 10 and level <= 20 then
            score = (level - 10) * 2 + 10 + lvlTenBonus
    end

    if level > 20 and level <= 30 then
            score = (level - 20) * 3 + 30 + lvlTwentyBonus
    end

    if level > 30 and level <= 40 then
            score = (level - 30) *4 + 60 + lvlThirtyBonus
    end

    if level > 40 and level <= 50 then
            score = (level - 40) * 5 + 100 + lvlFortyBonus
    end

    if level > 50 and level < 60 then
            score = (level - 50) * 6 + 150 + lvlFiftyBonus
    end

    if level == 60 then
        score = (10 * 6) + 150 + lvlSixtyBonus
    end

    --print("level score = "..score)
    return score

end
