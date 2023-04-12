PlayerInfo = {}


function PlayerInfo:LoadCharacterData()

    CharacterInfo = {
            name = "",
            class = "",
            level = 0,
            scores = {
                    coreScore = 0,
                    equippedGearScore = 0,
                    hcAchievementScore = 0,
                    levelingScore = 0,
                    timeBonusScore = 0,
                    questingScore = 0,
                    mobsKilledScore = 0,
                    professionsScore = 0,
                    dungeonsScore = 0,       
            },
    }
   
    PlayerInfo:GetPlayerInfo()
    print("Got Player Info")

    PlayerLevelingScore:GetLevelScore()
    print("Got Level Score")

    PlayerEquippedGearScore:GetEquippedGearScore()
    print("Got Player GetEquippedGearScore")

    PlayerCoreScore:GetCoreScore()
    print("Got Core Score")

  --  PlayerInfo.SaveDataToSV(self)
end

function PlayerInfo:GetPlayerInfo()
        CharacterInfo.name = UnitName("player")
        CharacterInfo.class = UnitClass("player")
        CharacterInfo.level = UnitLevel("player")      
end

function PlayerInfo:GetTotalScore()        
        local total = PlayerCoreScore.GetCoreScore(self)
        return total
end

function PlayerInfo:GetHCAchievementScore()
        local score = 0
        return score;        
end

function PlayerInfo:GetTimeBonusScore()
        local score = 0
        return score
end

function PlayerInfo:GetGearBonus()
        local score = 0
        return score
end

function PlayerInfo:SaveDataToSV()
--        CharacterInfo.name = CharacterInfo.name
--        CharacterInfo.class = CharacterInfo.class
--        CharacterInfo.level = CharacterInfo.level
--        CharacterInfo.scores = CharacterInfo.scores
--        CharacterInfo.scores.coreScore = CharacterInfo.scores.coreScore
--        CharacterInfo.scores.gearbonusScore = CharacterInfo.scores.gearbonusScore
--        CharacterInfo.scores.hcAchievementScore = CharacterInfo.scores.hcAchievementScore
--        CharacterInfo.scores.levelingScore = CharacterInfo.scores.levelingScore
--        CharacterInfo.scores.timeBonusScore = CharacterInfo.scores.timeBonusScore
--        CharacterInfo.scores.questingScore = CharacterInfo.scores.questingScore       

        CharacterInfo_SavedVariables = CharacterInfo_SavedVariables or {}
        CharacterInfo_SavedVariables.mySavedData = CharacterInfo
      --  CharacterInfo_SavedVariables.SaveVariables("Hardcore_Score")

end


