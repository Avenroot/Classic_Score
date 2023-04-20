PlayerInfo = {}

CurrentXP = 0
CurrentMaxXP = 0
MobCombatKill = false

function PlayerInfo:LoadCharacterData()  
    
    PlayerInfo:GetPlayerInfo()
--    print("Got Player Info")

    HCScore_Character.scores.levelingScore = PlayerLevelingScore:GetLevelScore()
--    print("Got Level Score")

    HCScore_Character.scores.equippedGearScore = PlayerEquippedGearScore:GetEquippedGearScore()
--    print("Got Player GetEquippedGearScore")

    --HCScore_Character.scores.questingScore = PlayerQuestingScore:GetQuestingScore();
    --print("Got Questing Score")

    HCScore_Character.scores.coreScore = PlayerCoreScore:GetCoreScore()
--    print("Got Core Score")

    --SaveHCScoreData:SaveVariables()
    --  SaveVariables("HCScore_StoredVariables")
    -- Scoreboard:UpdateUI()

end

function PlayerInfo:GetPlayerInfo()
    HCScore_Character.name = UnitName("player")
    HCScore_Character.class = UnitClass("player")
    HCScore_Character.level = UnitLevel("player")      
    CurrentXP = UnitXP("player")
    CurrentMaxXP = UnitXPMax("player")

    --print("CurrentXP: "..CurrentXP)

end




