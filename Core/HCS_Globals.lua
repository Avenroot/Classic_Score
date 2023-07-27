HCS_Globals = {}

-- Game information
HCS_GameVersion = select(4, GetBuildInfo())  -- if over 3000 than playing WOTLK

-- Player information
CurrentXP = 0
CurrentMaxXP = 0
CurrentLevel = 0  -- a work around because level doesn't get updated on PLAYER_LEVEL_UP
MobCombatKill = false
MobName = ""
MobLevel = 0
ZoneChanged = false
PlayerLeveled = false
HCS_OldLevel = 0

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
}

-- images 
Img_hcs_milestoneframe = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-milestone-frame.tga"
Img_hcs_milestone_quest = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-quest.tga"
Img_hcs_milestone_profession = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-profession.tga"
Img_hcs_milestone_mobtypes = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-mobtypes.tga"
Img_hcs_milestone_level = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-level.tga"
Img_hcs_milestone_kill = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-kill.tga"
Img_hcs_milestone_discovery = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-discovery.tga"

-- portrait images
CurrentPortrait = ""
Img_hcs_grey_portrait_32 = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-grey-portrait-32.blp"
Img_hcs_green_portrait_32 = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-green-portrait-32.blp"
Img_hcs_blue_portrait_32 = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-blue-portrait-32.blp"
Img_hcs_purple_portrait_32 = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-purple-portrait-32.blp"
Img_hcs_orange_portrait_32 = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-orange-portrait-32.blp"
Img_hcs_red_diamond_portrait_32 = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-red-diamond-portrait-32.blp"
Img_hcs_gold_crown_portrait_32 = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-gold-crown-portrait-32.blp"