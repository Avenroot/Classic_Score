
local levelPoints = 5
local mobKillsPoints = 10
local mobKillsTypePoints = 10
local questPoints = 10
local discoveryPoints = 10
local dangerousEnemiesPoints = 10
local imgLeveling = Img_hcs_achievement_level
local imgKillingMobs = Img_hcs_achievement_kill
local imgKillingMobsType = Img_hcs_achievement_mobtypes
local imgDangerousEnemeyKill = Img_hcs_ahcievement_dangerous_ememey_kill
local imgQuests = Img_hcs_achievement_quest
local imgDiscovery = Img_hcs_achievement_discovery
local imgProfessionTotal = Img_hcs_achievement_profession
local imgProfession = Img_hcs_achievement_profession

HCS_AchievementsDB = {

    -- Leveling Achievements
      {
        id = "ach_lvl_1",
        name = "Level 10",
        desc = "Achievement! Congrats! You reached for level 10",
        shortdesc = "Level 10",
        points = levelPoints,
        image = imgLeveling,
      }, 
      {
        id = "ach_lvl_2",
        name = "Level 20",
        desc = "Achievement! Congrats! You reached for level 20",
        shortdesc = "Level 20",
        points = levelPoints,
        image = imgLeveling,
      }, 
      {
        id = "ach_lvl_3",
        name = "Level 30",
        desc = "Achievement! Congrats! You reached for level 30",
        shortdesc = "Level 30",
        points = levelPoints,
        image = imgLeveling,
      }, 
      {
        id = "ach_lvl_4",
        name = "Level 40",
        desc = "Achievement! Congrats! You reached for level 40",
        shortdesc = "Level 40",
        points = levelPoints,
        image = imgLeveling,
      }, 
      {
        id = "ach_lvl_5",
        name = "Level 50",
        desc = "Achievement! Congrats! You reached for level 50",
        shortdesc = "Level 50",
        points = levelPoints,
        image = imgLeveling,
      }, 
      {
        id = "ach_lvl_6",
        name = "Level 60",
        desc = "Achievement! Congrats! You reached for level 60",
        shortdesc = "Level 60",
        points = 10,
        image = imgLeveling,
      }, 
      {
        id = "ach_lvl_7",
        name = "Level 70",
        desc = "Achievement! Congrats! You've reached level 70",
        shortdesc = "Level 70",
        points = 10,
        image = imgLeveling,
      },
      {
        id = "ach_lvl_8",
        name = "Level 80",
        desc = "Achievement! Congrats! You've reached level 80",
        shortdesc = "Level 80",
        points = 10,
        image = imgLeveling,
      }, 

      -- Killing Mobs
      {
        id = "ach_mobk_1",
        name = "Killed 1,000 enemies",
        desc = "Achievement! Congrats! You've killed 1,000 enemies",
        shortdesc = "1,000 enemies killed",
        points = mobKillsPoints, 
        image = imgKillingMobs ,
      }, 
      {
        id = "ach_mobk_2",
        name = "Killed 5,000 enemies",
        desc = "Achievement! Congrats! You've killed 5,000 enemies",
        shortdesc = "5,000 enemies killed",
        points = mobKillsPoints, 
        image = imgKillingMobs ,
      }, 
      {
        id = "ach_mobk_3",
        name = "Killed 10,000 enemies",
        desc = "Achievement! Congrats! You've killed 10,000 enemies",
        shortdesc = "10,000 enemies killed",
        points = mobKillsPoints, 
        image = imgKillingMobs ,
      }, 

      -- Killing Mob Types Milestones
    {
      id = "ach_mobkt_1",
      name = "Killed 100 creature types",
      desc = "Achievement! Congrats! You've killed 100 creature types",
      shortdesc = "100 creature types killed",
      points = mobKillsTypePoints,
      image = imgKillingMobsType,
    }, 
    {
      id = "ach_mobkt_2",
      name = "Killed 200 creature types",
      desc = "Achievement! Congrats! You've killed 200 creature types",
      shortdesc = "200 creature types killed",
      points = mobKillsTypePoints,
      image = imgKillingMobsType,
    }, 

    -- Total Quests Achievements
    {
      id = "ach_qtot_1",
      name = "Completed 100 quests",
      desc = "Achievement! Congrats! You've completed 100 Quests",
      shortdesc = "100 quests completed",
      points = questPoints,
      image = imgQuests,
    }, 
    {
      id = "ach_qtot_2",
      name = "Completed 500 quests",
      desc = "Achievement! Congrats! You've completed 500 Quests",
      shortdesc = "500 quests completed",
      points = questPoints,
      image = imgQuests,
    }, 
    {
      id = "ach_qtot_3",
      name = "Completed 1,000 quests",
      desc = "Achievement! Congrats! You've completed 1,000 Quests",
      shortdesc = "1,000 quests completed",
      points = questPoints,
      image = imgQuests,
    }, 

    -- Discovery
    {
      id = "ach_disc_1",
      name = "Completed 100 Discoveries",
      desc = "Achievement! Congrats! You've made 100 Discoveries",
      shortdesc = "100 discoveries made",
      points = discoveryPoints,
      image = imgDiscovery,
    }, 
    {
      id = "ach_disc_2",
      name = "Completed 500 Discoveries",
      desc = "Achievement! Congrats! You've made 500 Discoveries",
      shortdesc = "500 discoveries made",
      points = discoveryPoints,
      image = imgDiscovery,
    }, 
    {
      id = "ach_disc_3",
      name = "Completed 1,000 Discoveries",
      desc = "Achievement! Congrats! You've made 1,000 Discoveries",
      shortdesc = "1,000 discoveries made",
      points = discoveryPoints,
      image = imgDiscovery,
    }, 

    -- Dangerous Enemies Killed
    {
      id = "ach_dek_1",
      name = "Killed 1 dangerous enemey",
      desc = "Achievement! Congrats! You've killed 1 dangerous enemey",
      shortdesc = "1 dangerous enemey killed",
      points = dangerousEnemiesPoints,
      image = imgDangerousEnemeyKill,
    }, 
    {
      id = "ach_dek_2",
      name = "Killed 100 dangerous enemies",
      desc = "Achievement! Congrats! You've killed 100 dangerous enemies",
      shortdesc = "100 dangerous enemies killed",
      points = dangerousEnemiesPoints,
      image = imgDangerousEnemeyKill,
    }, 
    {
      id = "ach_dek_3",
      name = "Killed 500 dangerous enemies",
      desc = "Achievement! Congrats! You've killed 500 dangerous enemies",
      shortdesc = "500 dangerous enemies killed",
      points = dangerousEnemiesPoints,
      image = imgDangerousEnemeyKill,
    }, 
    {
      id = "ach_dek_4",
      name = "Killed 1,000 dangerous enemies",
      desc = "Achievement! Congrats! You've killed 1,000 dangerous enemies",
      shortdesc = "1,000 dangerous enemies killed",
      points = dangerousEnemiesPoints,
      image = imgDangerousEnemeyKill,
    }, 

}