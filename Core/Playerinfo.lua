-- Load AceDB-3.0
local AceDB = LibStub("AceDB-3.0")

PlayerInfo = {}

--[[
CharacterInfo = {
        name = "",
        class = "",
        level = 0,
        scores = {
                coreScore = 0,
                gearbonusScore = 0,
                hcAchievementScore = 0,
                levelingScore = 0,
                timeBonusScore = 0,
                questingScore = 0,       

        },
}
]]

function PlayerInfo:LoadCharacterData()

    -- Create a new database for your addon
--[[
    CharacterInfo = AceDB:New("CharacterInfo", {
        data = {
                info = {
                        name = "",
                        class = "",       
                        level = 0,
                },
                scores = {
                        coreScore = 0,
                        gearbonusScore = 0,
                        hcAchievementScore = 0,
                        levelingScore = 0,
                        timeBonusScore = 0,
                        questingScore = 0,       
                },
        },

    })    
]]

    CharacterInfo = AceDB:New("CharacterInfo", nil, true)
    CharacterInfo.name = ""
    CharacterInfo.class = ""
    CharacterInfo.level = 0
    CharacterInfo.scores = {
        coreScore = 0,
        gearbonusScore = 0,
        hcAchievementScore = 0,
        levelingScore = 0,
        timeBonusScore = 0,
        questingScore = 0,       
    }
    
    print("Created CharacterInfo database")
    
    PlayerInfo:GetPlayerInfo()
    print("Got Player Info")

    PlayerLevelingScore:GetLevelScore()
    print("Got Level Score")

    PlayerCoreScore:GetCoreScore()
    print("Got Core Score")

 --   PlayerInfo.SaveDataToSV(self)
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
        CharacterInfo.profile.name = CharacterInfo.name
        CharacterInfo.profile.class = CharacterInfo.class
        CharacterInfo.profile.level = CharacterInfo.level
        CharacterInfo.profile.scores = CharacterInfo.scores
--        CharacterInfo.profile.scores.coreScore = CharacterInfo.scores.coreScore
--        CharacterInfo.profile.scores.gearbonusScore = CharacterInfo.scores.gearbonusScore
--        CharacterInfo.profile.scores.hcAchievementScore = CharacterInfo.scores.hcAchievementScore
--        CharacterInfo.profile.scores.levelingScore = CharacterInfo.scores.levelingScore
--        CharacterInfo.profile.scores.timeBonusScore = CharacterInfo.scores.timeBonusScore
--        CharacterInfo.profile.scores.questingScore = CharacterInfo.scores.questingScore       
end


