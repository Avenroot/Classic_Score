HCS_Globals = {}

-- Game information
HCS_GameVersion = select(4, GetBuildInfo())  -- if over 3000 than playing Cataclysm
HCS_SODVersion, HCS_SODRealm = HCS_Utils:IsSeasonOfDiscoveryServer()

-- Scaling Percentage
HCS_LevelScalePercentage = 0

-- Leaderboard comm 
HCS_PREFIX =  "Hardcore_Score"  --"Hardcore_ScoreAddon"  

-- Player information
CurrentXP = 0
CurrentMaxXP = 0
CurrentLevel = 0  -- a work around because level doesn't get updated on PLAYER_LEVEL_UP
ZoneChanged = false
PlayerLeveled = false
HCS_OldLevel = 0
HCS_PlayerRank = {}

-- Mob information
MobCombatKill = false
MobName = ""
MobLevel = 0
MobClassification = ""

ScoringDescriptions = {
    equippedGearScore = "Equipped Gain",
    levelingScore = "Leveling Gain",
    professionsScore = "Professions Gain",
    reputationScore = "Reputation Gain",
    discoveryScore = "Discovery Gain",
    milestonesScore = "Milestones Gain",
    questingScore = "Questing Gain",
    mobsKilledScore = "Mobs Killed Gain",
    coreScore = "Core Score Gain",
    achievementScore = "Achievement Gain", 
}

-- Only execute if in WoW Classic, Season of Discovery
if HCS_SODVersion then
    ScoringDescriptions.runeScore = "Rune Score Gain"
end

-- Class Images
Img_hcs_Class_Shaman = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\hcs_shaman.blp"
Img_hcs_Class_Warlock = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\hcs_warlock.blp"
Img_hcs_Class_DeathKnight = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\hcs_deathknight.blp"
Img_hcs_Class_Druid = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\hcs_druid.blp"
Img_hcs_Class_Hunter = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\hcs_hunter.blp"
Img_hcs_Class_Mage = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\hcs_mage.blp"
Img_hcs_Class_Paladin = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\hcs_paladin.blp"
Img_hcs_Class_Priest = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\hcs_priest.blp"
Img_hcs_Class_Rogue = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\hcs_rogue.blp"
Img_hcs_Class_Warrior = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\hcs_warrior.blp"
Img_hcs_Class_None = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\hcs_class0.blp"

-- Achievement Images 
Img_hcs_achievement_frame = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-achievement-frame.blp"
Img_hcs_achievement_quest = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-quest.tga"
Img_hcs_achievement_profession = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-profession.tga"
Img_hcs_achievement_mobtypes = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-mobtypes.tga"
Img_hcs_achievement_level = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-level.tga"
Img_hcs_achievement_kill = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-kill.tga"
Img_hcs_achievement_discovery = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-discovery.tga"
Img_hcs_ahcievement_dangerous_ememey_kill = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-dangerous-enemy.tga"

--Simple Rank images
Img_hcs_Rank1 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port1.tga"
Img_hcs_Rank2 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port2.tga"
Img_hcs_Rank3 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port3.tga"
Img_hcs_Rank4 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port4.tga"
Img_hcs_Rank5 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port5.tga"
Img_hcs_Rank6 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port6.tga"
Img_hcs_Rank7 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port7.tga"

-- Rank portrait images
Current_hcs_Portrait = ""

-- Bronze
Img_hcs_Rank1_Level0 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Bronze_0.blp" 
Img_hcs_Rank1_Level1 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Bronze_1.blp"
Img_hcs_Rank1_Level2 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Bronze_2.blp"
Img_hcs_Rank1_Level3 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Bronze_3.blp"
Img_hcs_Rank1_Level4 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Bronze_4.blp"
-- Silver 
Img_hcs_Rank2_Level0 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Silver_0.blp"
Img_hcs_Rank2_Level1 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Silver_1.blp"
Img_hcs_Rank2_Level2 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Silver_2.blp"
Img_hcs_Rank2_Level3 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Silver_3.blp"
Img_hcs_Rank2_Level4 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Silver_4.blp"
-- Gold
Img_hcs_Rank3_Level0 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Gold_0.blp"
Img_hcs_Rank3_Level1 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Gold_1.blp"
Img_hcs_Rank3_Level2 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Gold_2.blp"
Img_hcs_Rank3_Level3 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Gold_3.blp"
Img_hcs_Rank3_Level4 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Gold_4.blp"
-- Platinum
Img_hcs_Rank4_Level0 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Platinum_0.blp"
Img_hcs_Rank4_Level1 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Platinum_1.blp"
Img_hcs_Rank4_Level2 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Platinum_2.blp"
Img_hcs_Rank4_Level3 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Platinum_3.blp"
Img_hcs_Rank4_Level4 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Platinum_4.blp"
-- Diamond
Img_hcs_Rank5_Level0 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Diamond_0.blp" 
Img_hcs_Rank5_Level1 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Diamond_1.blp"
Img_hcs_Rank5_Level2 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Diamond_2.blp" 
Img_hcs_Rank5_Level3 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Diamond_3.blp" 
Img_hcs_Rank5_Level4 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Diamond_4.blp" 
-- Epic
Img_hcs_Rank6_Level0 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Epic_0.blp"
Img_hcs_Rank6_Level1 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Epic_1.blp"
Img_hcs_Rank6_Level2 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Epic_2.blp"
Img_hcs_Rank6_Level3 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Epic_3.blp"
Img_hcs_Rank6_Level4 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Epic_4.blp"
--Legendary
Img_hcs_Rank7_Level0 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Legendary_0.blp"
Img_hcs_Rank7_Level1 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Legendary_1.blp"
Img_hcs_Rank7_Level2 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Legendary_2.blp"
Img_hcs_Rank7_Level3 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Legendary_3.blp"
Img_hcs_Rank7_Level4 = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Bracket_Legendary_4.blp"

-- portrait boarders
Current_hcs_Border = ""
Img_hcs_lvl_1_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Border_POW.blp"
Img_hcs_lvl_2_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Border_POW.blp"
Img_hcs_lvl_3_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Border_POW.blp"
Img_hcs_lvl_4_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Border_POW.blp"
Img_hcs_lvl_5_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Border_POW.blp"
Img_hcs_lvl_6_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Border_POW.blp"
Img_hcs_lvl_7_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\Border_POW.blp"

-- milestone text colors  
HCS_MilestonesColors = {
    EnemiesKilled = {
        red = 255 / 255,
        green = 102 / 255,
        blue = 79 / 255,
    },
    CreatureTypes = {
        red = 255 / 255,
        green = 200 / 255,
        blue = 99 / 255,
    },
    DangerousEnemiesKilled = {
        red = 255 / 255,
        green = 16 / 255,
        blue = 12 / 255,
    },
    QuestsCompleted = {
        red = 101 / 255,
        green = 255 / 255,
        blue = 81 / 255,
    },
    Discoveries = {
        red = 38 / 255,
        green = 179 / 255,
        blue = 255 / 255,
    },
    Professions = {
        red = 17 / 255,
        green = 87 / 255,
        blue = 141 / 255,
    },
    Runes = {
        red = 255 / 255,
        green = 255 / 255,
        blue = 255 / 255,
    }
}

-- Filter states should be controlled by your UI checkboxes
HCS_Leaderboard_Filters = {} 
HCS_Leaderboard_Filtered = {}

-- Public network presence tracking
HCS_PublicOnline = {}
HCS_PublicPresenceWindow = 180 -- seconds to consider someone "online" after last ping
HCS_PublicAnnounced = false