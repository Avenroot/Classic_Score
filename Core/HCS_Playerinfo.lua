HCS_Playerinfo = {}

CurrentXP = 0
CurrentMaxXP = 0
MobCombatKill = false
MobName = ""
MobLevel = 0
ZoneChanged = false
LevelScalePercentage = (UnitLevel("player")  / 60) --* 100

function HCS_Playerinfo:LoadCharacterData()  
    
    HCS_Playerinfo:GetHCS_Playerinfo()
--    print("Got Player Info")

    HCScore_Character.scores.levelingScore = HCS_PlayerLevelingScore:GetLevelScore()
--    print("Got Level Score")

    HCScore_Character.scores.equippedGearScore = HCS_PlayerEquippedGearScore:GetEquippedGearScore()
--    print("Got Player GetEquippedGearScore")

    --HCScore_Character.scores.questingScore = HCS_PlayerQuestingScore:GetQuestingScore();
    --print("Got Questing Score")

    HCScore_Character.scores.coreScore = HCS_PlayerCoreScore:GetCoreScore()
--    print("Got Core Score")

    HCS_ReputationScore:UpdateRepScore()
    --SaveHCScoreData:SaveVariables()
    --  SaveVariables("HCScore_StoredVariables")
    -- HCS_ScoreboardUI:UpdateUI()

end

function HCS_Playerinfo:GetHCS_Playerinfo()
    HCScore_Character.name = UnitName("player")
    HCScore_Character.class = UnitClass("player")
    HCScore_Character.level = UnitLevel("player")
    HCScore_Character.faction = UnitFactionGroup("player")
    CurrentXP = UnitXP("player")
    CurrentMaxXP = UnitXPMax("player")

    --print("CurrentXP: "..CurrentXP)

end




