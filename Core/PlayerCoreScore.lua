PlayerCoreScore = {}

function PlayerCoreScore:GetAttackPower()
    local value = UnitAttackPower("player")
 --   print("attackPower = "..value)

    return value
end

function PlayerCoreScore.GetArmorValue()

    local value = UnitArmor("player")
--    print("armor = "..value)

    return value
end

function PlayerCoreScore:GetCoreScore()

    local levelscore = PlayerLevelingScore.GetLevelScore(self)
    local attackPower = PlayerCoreScore.GetAttackPower(self)
    local armorValue = PlayerCoreScore.GetArmorValue(self)
    local score =  levelscore + attackPower + armorValue

    print("score = "..score)
    return score
end
