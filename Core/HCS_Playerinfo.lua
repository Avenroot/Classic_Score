HCS_Playerinfo = {}

function HCS_Playerinfo:LoadCharacterData()  
    -- Check to make sure this is not a new character with the same name.  If it is reset all points.
    local playerLevel = UnitLevel("player")
    if HCScore_Character.level ~= nil and HCScore_Character.level > playerLevel then ResetCharacterStats() end

    HCS_Playerinfo:GetHCS_Playerinfo()
    --HCScore_Character.scores.levelingScore = HCS_PlayerLevelingScore:GetLevelScore()
    --HCScore_Character.scores.equippedGearScore = HCS_PlayerEquippedGearScore:GetEquippedGearScore()
    --HCScore_Character.scores.coreScore = HCS_PlayerCoreScore:GetCoreScore()
    --HCS_ReputationScore:UpdateRepScore()

end

function HCS_Playerinfo:GetHCS_Playerinfo()

    -- initialization HCScore_Character
    if HCScore_Character.name == nil then HCScore_Character.name = UnitName("player") end
    if HCScore_Character.class == nil then HCScore_Character.class = UnitClass("player") end
    if HCScore_Character.classid == nil then _, _, HCScore_Character.classid = UnitClass("player") end
    if HCScore_Character.level == nil then HCScore_Character.level = UnitLevel("player") end
    if HCScore_Character.race == nil then HCScore_Character.race = UnitRace("player") end
    if HCScore_Character.faction == nil then HCScore_Character.faction = UnitFactionGroup("player") end
    if HCScore_Character.version == nil then HCScore_Character.version = HCS_Version end
    if HCScore_Character.deaths == nil then HCScore_Character.deaths = 0 end
    if HCScore_Character.quests == nil then HCScore_Character.quests = {} end
    if HCScore_Character.scores == nil then HCScore_Character.scores = {} end
    if HCScore_Character.scores.coreScore == nil then HCScore_Character.scores.coreScore = 0 end
    if HCScore_Character.scores.discoveryScore == nil then HCScore_Character.scores.discoveryScore = 0 end
    if HCScore_Character.scores.dungeonsScore == nil then HCScore_Character.scores.dungeonsScore = 0 end
    if HCScore_Character.scores.equippedGearScore == nil then HCScore_Character.scores.equippedGearScore = 0 end
    if HCScore_Character.scores.achievementScore == nil then HCScore_Character.scores.achievementScore = 0 end
    if HCScore_Character.scores.levelingScore == nil then HCScore_Character.scores.levelingScore = 0 end
    if HCScore_Character.scores.mobsKilledScore == nil then HCScore_Character.scores.mobsKilledScore = 0 end
    if HCScore_Character.scores.professionsScore == nil then HCScore_Character.scores.professionsScore = 0 end
    if HCScore_Character.scores.questingScore == nil then HCScore_Character.scores.questingScore = 0 end
    if HCScore_Character.scores.reputationScore == nil then HCScore_Character.scores.reputationScore = 0 end
    if HCScore_Character.scores.milestonesScore == nil then HCScore_Character.scores.milestonesScore = 0 end
    if HCScore_Character.professions == nil then HCScore_Character.professions = {} end
    if HCScore_Character.professions.alchemy == nil then HCScore_Character.professions.alchemy = 0 end
    if HCScore_Character.professions.blacksmithing == nil then HCScore_Character.professions.blacksmithing = 0 end
    if HCScore_Character.professions.enchanting == nil then HCScore_Character.professions.enchanting = 0 end
    if HCScore_Character.professions.engineering == nil then HCScore_Character.professions.engineering = 0 end
    if HCScore_Character.professions.herbalism == nil then HCScore_Character.professions.herbalism = 0 end
    if HCScore_Character.professions.leatherworking == nil then HCScore_Character.professions.leatherworking = 0 end
    if HCScore_Character.professions.lockpicking == nil then HCScore_Character.professions.lockpicking = 0 end
    if HCScore_Character.professions.mining == nil then HCScore_Character.professions.mining = 0 end
    if HCScore_Character.professions.skinning == nil then HCScore_Character.professions.skinning = 0 end
    if HCScore_Character.professions.tailoring == nil then HCScore_Character.professions.tailoring = 0 end
    if HCScore_Character.professions.fishing == nil then HCScore_Character.professions.fishing = 0 end
    if HCScore_Character.professions.cooking == nil then HCScore_Character.professions.cooking = 0 end
    if HCScore_Character.professions.firstaid == nil then HCScore_Character.professions.firstaid = 0 end
    if HCScore_Character.reputations == nil then HCScore_Character.reputations = {} end
    if HCScore_Character.mobsKilled == nil then HCScore_Character.mobsKilled = {} end
    if HCScore_Character.discovery == nil then HCScore_Character.discovery = {} end
    if HCScore_Character.milestones == nil then HCScore_Character.milestones = {} end
    if HCScore_Character.levelScores == nil then HCScore_Character.levelScores = {} end
    if HCScore_Character.dangerousMobsKilled == nil then HCScore_Character.dangerousMobsKilled = {} end
    if HCScore_Character.achievements == nil then HCScore_Character.achievements = {} end

    HCScore_Character.name = UnitName("player")
    HCScore_Character.class = UnitClass("player")
    _, _, HCScore_Character.classid = UnitClass("player")
    HCScore_Character.level = UnitLevel("player")
    HCScore_Character.race = UnitRace("player")

    HCScore_Character.faction = UnitFactionGroup("player")
    HCScore_Character.version = HCS_Version

end

function ResetCharacterStats()

    if HCScore_Character.name ~= nil then HCScore_Character.name = UnitName("player") end
    if HCScore_Character.class ~= nil then HCScore_Character.class = UnitClass("player") end
    if HCScore_Character.classid == nil then _, _, HCScore_Character.classid = UnitClass("player") end
    if HCScore_Character.level ~= nil then HCScore_Character.level = UnitLevel("player") end
    if HCScore_Character.race ~= nil then HCScore_Character.race = UnitRace("player") end
    if HCScore_Character.faction ~= nil then HCScore_Character.faction = UnitFactionGroup("player") end
    if HCScore_Character.version ~= nil then HCScore_Character.version = HCS_Version end
    if HCScore_Character.deaths ~= nil then HCScore_Character.deaths = 0 end
    if HCScore_Character.quests ~= nil then HCScore_Character.quests = {} end
    if HCScore_Character.scores ~= nil then HCScore_Character.scores = {} end
    if HCScore_Character.scores.coreScore ~= nil then HCScore_Character.scores.coreScore = 0 end
    if HCScore_Character.scores.discoveryScore ~= nil then HCScore_Character.scores.discoveryScore = 0 end
    if HCScore_Character.scores.dungeonsScore ~= nil then HCScore_Character.scores.dungeonsScore = 0 end
    if HCScore_Character.scores.equippedGearScore ~= nil then HCScore_Character.scores.equippedGearScore = 0 end
    if HCScore_Character.scores.achievementScore ~= nil then HCScore_Character.scores.achievementScore = 0 end
    if HCScore_Character.scores.levelingScore ~= nil then HCScore_Character.scores.levelingScore = 0 end
    if HCScore_Character.scores.mobsKilledScore ~= nil then HCScore_Character.scores.mobsKilledScore = 0 end
    if HCScore_Character.scores.professionsScore ~= nil then HCScore_Character.scores.professionsScore = 0 end
    if HCScore_Character.scores.questingScore ~= nil then HCScore_Character.scores.questingScore = 0 end
    if HCScore_Character.scores.reputationScore ~= nil then HCScore_Character.scores.reputationScore = 0 end
    if HCScore_Character.scores.milestonesScore ~= nil then HCScore_Character.scores.milestonesScore = 0 end        
    if HCScore_Character.professions ~= nil then HCScore_Character.professions = {} end
    if HCScore_Character.professions.alchemy ~= nil then HCScore_Character.professions.alchemy = 0 end
    if HCScore_Character.professions.blacksmithing ~= nil then HCScore_Character.professions.blacksmithing = 0 end
    if HCScore_Character.professions.enchanting ~= nil then HCScore_Character.professions.enchanting = 0 end
    if HCScore_Character.professions.engineering ~= nil then HCScore_Character.professions.engineering = 0 end
    if HCScore_Character.professions.herbalism ~= nil then HCScore_Character.professions.herbalism = 0 end
    if HCScore_Character.professions.leatherworking ~= nil then HCScore_Character.professions.leatherworking = 0 end
    if HCScore_Character.professions.lockpicking ~= nil then HCScore_Character.professions.lockpicking = 0 end
    if HCScore_Character.professions.mining ~= nil then HCScore_Character.professions.mining = 0 end
    if HCScore_Character.professions.skinning ~= nil then HCScore_Character.professions.skinning = 0 end
    if HCScore_Character.professions.tailoring ~= nil then HCScore_Character.professions.tailoring = 0 end
    if HCScore_Character.professions.fishing ~= nil then HCScore_Character.professions.fishing = 0 end
    if HCScore_Character.professions.cooking ~= nil then HCScore_Character.professions.cooking = 0 end
    if HCScore_Character.professions.firstaid ~= nil then HCScore_Character.professions.firstaid = 0 end
    if HCScore_Character.reputations ~= nil then HCScore_Character.reputations = {} end
    if HCScore_Character.mobsKilled ~= nil then HCScore_Character.mobsKilled = {} end
    if HCScore_Character.discovery ~= nil then HCScore_Character.discovery = {} end
    if HCScore_Character.milestones ~= nil then HCScore_Character.milestones = {} end
    if HCScore_Character.levelScores ~= nil then HCScore_Character.levelScores = {} end
    if HCScore_Character.dangerousMobsKilled == nil then HCScore_Character.dangerousMobsKilled = {} end
    if HCScore_Character.achievements == nil then HCScore_Character.achievements = {} end

end


