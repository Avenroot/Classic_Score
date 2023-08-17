HCS_Globals = {}

-- Game information
HCS_GameVersion = select(4, GetBuildInfo())  -- if over 3000 than playing WOTLK

-- Scaling Percentage
HCS_LevelScalePercentage = 0

-- Player information
CurrentXP = 0
CurrentMaxXP = 0
CurrentLevel = 0  -- a work around because level doesn't get updated on PLAYER_LEVEL_UP
ZoneChanged = false
PlayerLeveled = false
HCS_OldLevel = 0

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

-- images 
Img_hcs_achievement_frame = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-achievement-frame.blp"
Img_hcs_achievement_quest = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-quest.tga"
Img_hcs_achievement_profession = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-profession.tga"
Img_hcs_achievement_mobtypes = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-mobtypes.tga"
Img_hcs_achievement_level = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-level.tga"
Img_hcs_achievement_kill = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-kill.tga"
Img_hcs_achievement_discovery = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-discovery.tga"
Img_hcs_ahcievement_dangerous_ememey_kill = "Interface\\Addons\\Hardcore_Score\\Media\\Achievements\\hcs-dangerous-enemy.tga"

-- portrait images
Current_hcs_Portrait = ""
Img_hcs_lvl_1_portrait = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port1.tga"
Img_hcs_lvl_2_portrait = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port2.tga"
Img_hcs_lvl_3_portrait = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port3.tga"
Img_hcs_lvl_4_portrait = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port4.tga"
Img_hcs_lvl_5_portrait = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port5.tga"
Img_hcs_lvl_6_portrait = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port6.tga"
Img_hcs_lvl_7_portrait = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\port7.tga"

-- portrait boarders
Current_hcs_Border = ""
Img_hcs_lvl_1_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\border1.blp"
Img_hcs_lvl_2_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\border2.blp"
Img_hcs_lvl_3_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\border3.blp"
Img_hcs_lvl_4_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\border4.blp"
Img_hcs_lvl_5_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\border5.blp"
Img_hcs_lvl_6_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\border6.blp"
Img_hcs_lvl_7_border = "Interface\\Addons\\Hardcore_Score\\Media\\Portraits\\Default\\border7.blp"

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
}
