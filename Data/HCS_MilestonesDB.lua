local levelPoints = 5
local mobKillsPoints = 5
local questPoints = 5
local discoveryPoints = 5
local professionTotal = 10
local professionPoints = 5
local imgLeveling = Img_hcs_milestone_level
local imgKillingMobs = Img_hcs_milestone_kill
local imgKillingMobsType = Img_hcs_milestone_mobtypes
local imgQuests = Img_hcs_milestone_quest
local imgDiscovery = Img_hcs_milestone_discovery
local imgProfessionTotal = Img_hcs_milestone_profession
local imgProfession = Img_hcs_milestone_profession

HCS_MilestonesDB = {

    -- Leveling Milestones
    {
      id = "lvl_1",
      name = "Level 5",
      desc = "Milestone! Congrats! You reached for level 5",
      shortdesc = "Level 5",
      points = levelPoints,
      image = imgLeveling,
    }, 
    {
      id = "lvl_2",
      name = "Level 10",
      desc = "Milestone! Congrats! You reached for level 10",
      shortdesc = "Level 10",
      points = levelPoints,
      image = imgLeveling,
    }, 
    {
      id = "lvl_3",
      name = "Level 15",
      desc = "Milestone! Congrats! You reached for level 15",
      shortdesc = "Level 15",
      points = levelPoints,
      image = imgLeveling,
    }, 
    {
      id = "lvl_4",
      name = "Level 20",
      desc = "Milestone! Congrats! You reached for level 20",
      shortdesc = "Level 20",
      points = levelPoints,
      image = imgLeveling,
    }, 
    {
      id = "lvl_5",
      name = "Level 25",
      desc = "Milestone! Congrats! You reached for level 25",
      shortdesc = "Level 25",
      points = levelPoints,
      image = imgLeveling,
    }, 
    {
      id = "lvl_6",
      name = "Level 30",
      desc = "Milestone! Congrats! You reached for level 30",
      shortdesc = "Level 30",
      points = levelPoints,
      image = imgLeveling,
    }, 
    {
      id = "lvl_7",
      name = "Level 35",
      desc = "Milestone! Congrats! You reached for level 35",
      shortdesc = "Level 35",
      points = levelPoints,
      image = imgLeveling,
    }, 
    {
      id = "lvl_8",
      name = "Level 40",
      desc = "Milestone! Congrats! You reached for level 40",
      shortdesc = "Level 40",
      points = levelPoints,
      image = imgLeveling,
    }, 
    {
      id = "lvl_9",
      name = "Level 45",
      desc = "Milestone! Congrats! You reached for level 45",
      shortdesc = "Level 45",
      points = levelPoints,
      image = imgLeveling,
    }, 
    {
      id = "lvl_10",
      name = "Level 50",
      desc = "Milestone! Congrats! You reached for level 50",
      shortdesc = "Level 50",
      points = levelPoints,
      image = imgLeveling,
    }, 
    {
      id = "lvl_11",
      name = "Level 55",
      desc = "Milestone! Congrats! You reached for level 55",
      shortdesc = "Level 55",
      points = levelPoints,
      image = imgLeveling,
    }, 
    {
      id = "lvl_12",
      name = "Level 60",
      desc = "Milestone! Congrats! You reached for level 60",
      shortdesc = "Level 60",
      points = 10,
      image = imgLeveling,
    }, 
    {
      id = "lvl_13",
      name = "Level 65",
      desc = "Milestone! Congrats! You've reached level 65",
      shortdesc = "Level 65",
      points = 10,
      image = imgLeveling,
    }, 
    {
      id = "lvl_14",
      name = "Level 70",
      desc = "Milestone! Congrats! You've reached level 70",
      shortdesc = "Level 70",
      points = 10,
      image = imgLeveling,
    },
    {
      id = "lvl_15",
      name = "Level 75",
      desc = "Milestone! Congrats! You've reached level 75",
      shortdesc = "Level 75",
      points = 10,
      image = imgLeveling,
    }, 
    {
      id = "lvl_16",
      name = "Level 80",
      desc = "Milestone! Congrats! You've reached level 80",
      shortdesc = "Level 80",
      points = 10,
      image = imgLeveling,
    }, 

    -- Killing Mobs Milestones
    {
      id = "mobk_1",
      name = "Killed 50 mobs",
      desc = "Milestone! Congrats! You've killed 50 mobs",
      shortdesc = "Killed 50 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_2",
      name = "Killed 100 mobs",
      desc = "Milestone! Congrats! You've killed 100 mobs",
      shortdesc = "Killed 100 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_3",
      name = "Killed 250 mobs",
      desc = "Milestone! Congrats! You've killed 250 mobs",
      shortdesc = "Killed 250 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_4",
      name = "Killed 500 mobs",
      desc = "Milestone! Congrats! You've killed 500 mobs",
      shortdesc = "Killed 500 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_5",
      name = "Killed 1000 mobs",
      desc = "Milestone! Congrats! You've killed 1000 mobs",
      shortdesc = "Killed 1000 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_6",
      name = "Killed 2000 mobs",
      desc = "Milestone! Congrats! You've killed 2000 mobs",
      shortdesc = "Killed 2000 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_7",
      name = "Killed 3000 mobs",
      desc = "Milestone! Congrats! You've killed 3000 mobs",
      shortdesc = "Killed 3000 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_8",
      name = "Killed 4000 mobs",
      desc = "Milestone! Congrats! You've killed 4000 mobs",
      shortdesc = "Killed 4000 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_9",
      name = "Killed 5000 mobs",
      desc = "Milestone! Congrats! You've killed 5000 mobs",
      shortdesc = "Killed 5000 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    },

    -- Added in version 0.9.9
    {
      id = "mobk_10",
      name = "Killed 5 mobs",
      desc = "Milestone! Congrats! You've killed 5 mobs",
      shortdesc = "Killed 5 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_11",
      name = "Killed 750 mobs",
      desc = "Milestone! Congrats! You've killed 750 mobs",
      shortdesc = "Killed 750 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_12",
      name = "Killed 1250 mobs",
      desc = "Milestone! Congrats! You've killed 1250 mobs",
      shortdesc = "Killed 1250 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_13",
      name = "Killed 1500 mobs",
      desc = "Milestone! Congrats! You've killed 1500 mobs",
      shortdesc = "Killed 1500 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_14",
      name = "Killed 1750 mobs",
      desc = "Milestone! Congrats! You've killed 1750 mobs",
      shortdesc = "Killed 1750 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    },
    {
      id = "mobk_15",
      name = "Killed 2250 mobs",
      desc = "Milestone! Congrats! You've killed 2250 mobs",
      shortdesc = "Killed 2250 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_16",
      name = "Killed 2500 mobs",
      desc = "Milestone! Congrats! You've killed 2500 mobs",
      shortdesc = "Killed 2500 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_17",
      name = "Killed 2750 mobs",
      desc = "Milestone! Congrats! You've killed 2750 mobs",
      shortdesc = "Killed 2750 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_18",
      name = "Killed 3500 mobs",
      desc = "Milestone! Congrats! You've killed 3500 mobs",
      shortdesc = "Killed 3500 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_19",
      name = "Killed 4500 mobs",
      desc = "Milestone! Congrats! You've killed 4500 mobs",
      shortdesc = "Killed 4500 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_20",
      name = "Killed 5500 mobs",
      desc = "Milestone! Congrats! You've killed 5500 mobs",
      shortdesc = "Killed 5500 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobk_21",
      name = "Killed 6000 mobs",
      desc = "Milestone! Congrats! You've killed 6000 mobs",
      shortdesc = "Killed 6000 mobs",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 

    -- Killing Mob Types Milestones
    {
      id = "mobkt_1",
      name = "Killed 5 mobs types",
      desc = "Milestone! Congrats! You've killed 5 mob types",
      shortdesc = "Killed 5 mob types",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobkt_2",
      name = "Killed 10 mobs types",
      desc = "Milestone! Congrats! You've killed 10 mob types",
      shortdesc = "Killed 10 mob types",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobkt_3",
      name = "Killed 20 mobs types",
      desc = "Milestone! Congrats! You've killed 20 mob types",
      shortdesc = "Killed 20 mob types",
      points = mobKillsPoints,
      image = imgKillingMobs,
    },
    {
      id = "mobkt_4",
      name = "Killed 30 mobs types",
      desc = "Milestone! Congrats! You've killed 30 mob types",
      shortdesc = "Killed 30 mob types",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobkt_5",
      name = "Killed 40 mobs types",
      desc = "Milestone! Congrats! You've killed 40 mob types",
      shortdesc = "Killed 40 mob types",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobkt_6",
      name = "Killed 50 mobs types",
      desc = "Milestone! Congrats! You've killed 50 mob types",
      shortdesc = "Killed 50 mob types",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobkt_7",
      name = "Killed 60 mobs types",
      desc = "Milestone! Congrats! You've killed 60 mob types",
      shortdesc = "Killed 60 mob types",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobkt_8",
      name = "Killed 70 mobs types",
      desc = "Milestone! Congrats! You've killed 70 mob types",
      shortdesc = "Killed 70 mob types",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobkt_9",
      name = "Killed 80 mobs types",
      desc = "Milestone! Congrats! You've killed 80 mob types",
      shortdesc = "Killed 80 mob types",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobkt_10",
      name = "Killed 90 mobs types",
      desc = "Milestone! Congrats! You've killed 90 mob types",
      shortdesc = "Killed 90 mob types",
      points = mobKillsPoints,
      image = imgKillingMobs,
    }, 
    {
      id = "mobkt_11",
      name = "Killed 100 mobs types",
      desc = "Milestone! Congrats! You've killed 100 mob types",
      shortdesc = "Killed 100 mob types",
      points = mobKillsPoints,
      image = imgKillingMobs,
    },

    -- Added in version 0.9.9
    {
      id = "mobkt_12",
      name = "Killed 110 mobs types",
      desc = "Milestone! Congrats! You've killed 110 mob types",
      shortdesc = "Killed 110 mob types",
      points = mobKillsPoints,
      image = imgKillingMobs,
    },
    {
      id = "mobkt_13",
      name = "Killed 120 mobs types",
      desc = "Milestone! Congrats! You've killed 120 mob types",
      shortdesc = "Killed 120 mob types",
      points = mobKillsPoints,
      image = imgKillingMobs,
    },

    -- Total Quests Milestones
    {
      id = "qtot_1",
      name = "Completed 5 Quests",
      desc = "Milestone! Congrats! You've Completed 5 Quests",
      shortdesc = "Completed 5 Quests",
      points = questPoints,
      image = imgQuests,
    }, 
    {
      id = "qtot_2",
      name = "Completed 15 Quests",
      desc = "Milestone! Congrats! You've Completed 15 Quests",
      shortdesc = "Completed 15 Quests",
      points = questPoints,
      image = imgQuests,
    }, 
    {
      id = "qtot_3",
      name = "Completed 30 Quests",
      desc = "Milestone! Congrats! You've Completed 30 Quests",
      shortdesc = "Completed 30 Quests",
      points = questPoints,
      image = imgQuests,
    }, 
    {
      id = "qtot_4",
      name = "Completed 50 Quests",
      desc = "Milestone! Congrats! You've Completed 50 Quests",
      shortdesc = "Completed 50 Quests",
      points = questPoints,
      image = imgQuests,
    }, 
    {
      id = "qtot_5",
      name = "Completed 100 Quests",
      desc = "Milestone! Congrats! You've Completed 100 Quests",
      shortdesc = "Completed 100 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_6",
      name = "Completed 200 Quests",
      desc = "Milestone! Congrats! You've Completed 200 Quests",
      shortdesc = "Completed 200 Quests",
      points = questPoints,
      image = imgQuests,
    }, 
    {
      id = "qtot_7",
      name = "Completed 300 Quests",
      desc = "Milestone! Congrats! You've Completed 300 Quests",
      shortdesc = "Completed 300 Quests",
      points = questPoints,
      image = imgQuests,
    }, 
    {
      id = "qtot_8",
      name = "Completed 400 Quests",
      desc = "Milestone! Congrats! You've Completed 400 Quests",
      shortdesc = "Completed 400 Quests",
      points = questPoints,
      image = imgQuests,
    }, 
    {
      id = "qtot_9",
      name = "Completed 500 Quests",
      desc = "Milestone! Congrats! You've Completed 500 Quests",
      shortdesc = "Completed 500 Quests",
      points = questPoints,
      image = imgQuests,
    }, 
    {
      id = "qtot_10",
      name = "Completed 700 Quests",
      desc = "Milestone! Congrats! You've Completed 700 Quests",
      shortdesc = "Completed 700 Quests",
      points = questPoints,
      image = imgQuests,
    }, 
    {
      id = "qtot_11",
      name = "Completed 1000 Quests",
      desc = "Milestone! Congrats! You've Completed 1000 Quests",
      shortdesc = "Completed 1000 Quests",
      points = questPoints,
      image = imgQuests,
    }, 
    
    -- Added version 0.9.9
    {
      id = "qtot_12",
      name = "Completed 75 Quests",
      desc = "Milestone! Congrats! You've Completed 75 Quests",
      shortdesc = "Completed 75 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_13",
      name = "Completed 125 Quests",
      desc = "Milestone! Congrats! You've Completed 125 Quests",
      shortdesc = "Completed 125 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_14",
      name = "Completed 150 Quests",
      desc = "Milestone! Congrats! You've Completed 150 Quests",
      shortdesc = "Completed 150 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_15",
      name = "Completed 175 Quests",
      desc = "Milestone! Congrats! You've Completed 175 Quests",
      shortdesc = "Completed 175 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_16",
      name = "Completed 225 Quests",
      desc = "Milestone! Congrats! You've Completed 225 Quests",
      shortdesc = "Completed 225 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_17",
      name = "Completed 250 Quests",
      desc = "Milestone! Congrats! You've Completed 250 Quests",
      shortdesc = "Completed 250 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_18",
      name = "Completed 275 Quests",
      desc = "Milestone! Congrats! You've Completed 275 Quests",
      shortdesc = "Completed 275 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_19",
      name = "Completed 325 Quests",
      desc = "Milestone! Congrats! You've Completed 325 Quests",
      shortdesc = "Completed 325 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_20",
      name = "Completed 350 Quests",
      desc = "Milestone! Congrats! You've Completed 350 Quests",
      shortdesc = "Completed 350 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_21",
      name = "Completed 375 Quests",
      desc = "Milestone! Congrats! You've Completed 375 Quests",
      shortdesc = "Completed 375 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_22",
      name = "Completed 425 Quests",
      desc = "Milestone! Congrats! You've Completed 425 Quests",
      shortdesc = "Completed 425 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_23",
      name = "Completed 450 Quests",
      desc = "Milestone! Congrats! You've Completed 450 Quests",
      shortdesc = "Completed 450 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_24",
      name = "Completed 475 Quests",
      desc = "Milestone! Congrats! You've Completed 475 Quests",
      shortdesc = "Completed 475 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_25",
      name = "Completed 600 Quests",
      desc = "Milestone! Congrats! You've Completed 600 Quests",
      shortdesc = "Completed 600 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_26",
      name = "Completed 800 Quests",
      desc = "Milestone! Congrats! You've Completed 800 Quests",
      shortdesc = "Completed 800 Quests",
      points = questPoints,
      image = imgQuests,
    },
    {
      id = "qtot_27",
      name = "Completed 900 Quests",
      desc = "Milestone! Congrats! You've Completed 900 Quests",
      shortdesc = "Completed 900 Quests",
      points = questPoints,
      image = imgQuests,
    },

    -- Discovery
    {
      id = "disc_1",
      name = "Completed 5 Discoveries",
      desc = "Milestone! Congrats! You've made 5 Discoveries",
      shortdesc = "5 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    }, 
    {
      id = "disc_2",
      name = "Completed 10 Discoveries",
      desc = "Milestone! Congrats! You've made 10 Discoveries",
      shortdesc = "10 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    }, 
    {
      id = "disc_3",
      name = "Completed 25 Discoveries",
      desc = "Milestone! Congrats! You've made 25 Discoveries",
      shortdesc = "25 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    }, 
    {
      id = "disc_4",
      name = "Completed 50 Discoveries",
      desc = "Milestone! Congrats! You've made 50 Discoveries",
      shortdesc = "50 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    }, 
    {
      id = "disc_5",
      name = "Completed 100 Discoveries",
      desc = "Milestone! Congrats! You've made 100 Discoveries",
      shortdesc = "100 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    }, 
    {
      id = "disc_6",
      name = "Completed 150 Discoveries",
      desc = "Milestone! Congrats! You've made 150 Discoveries",
      shortdesc = "150 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    }, 
    {
      id = "disc_7",
      name = "Completed 200 Discoveries",
      desc = "Milestone! Congrats! You've made 200 Discoveries",
      shortdesc = "200 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    }, 
    {
      id = "disc_8",
      name = "Completed 250 Discoveries",
      desc = "Milestone! Congrats! You've made 250 Discoveries",
      shortdesc = "250 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    }, 
    {
      id = "disc_9",
      name = "Completed 300 Discoveries",
      desc = "Milestone! Congrats! You've made 300 Discoveries",
      shortdesc = "300 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    }, 
    {
      id = "disc_10",
      name = "Completed 350 Discoveries",
      desc = "Milestone! Congrats! You've made 350 Discoveries",
      shortdesc = "350 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    }, 
    {
      id = "disc_11",
      name = "Completed 400 Discoveries",
      desc = "Milestone! Congrats! You've made 400 Discoveries",
      shortdesc = "400 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    },

    -- Added in version 0.9.9
    {
      id = "disc_12",
      name = "Completed 75 Discoveries",
      desc = "Milestone! Congrats! You've made 75 Discoveries",
      shortdesc = "75 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    },
    {
      id = "disc_13",
      name = "Completed 125 Discoveries",
      desc = "Milestone! Congrats! You've made 125 Discoveries",
      shortdesc = "125 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    },
    {
      id = "disc_14",
      name = "Completed 175 Discoveries",
      desc = "Milestone! Congrats! You've made 175 Discoveries",
      shortdesc = "175 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    },
    {
      id = "disc_15",
      name = "Completed 225 Discoveries",
      desc = "Milestone! Congrats! You've made 225 Discoveries",
      shortdesc = "225 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    },
    {
      id = "disc_16",
      name = "Completed 275 Discoveries",
      desc = "Milestone! Congrats! You've made 275 Discoveries",
      shortdesc = "275 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    },
    {
      id = "disc_17",
      name = "Completed 325 Discoveries",
      desc = "Milestone! Congrats! You've made 325 Discoveries",
      shortdesc = "325 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    },
    {
      id = "disc_18",
      name = "Completed 375 Discoveries",
      desc = "Milestone! Congrats! You've made 375 Discoveries",
      shortdesc = "375 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    },
    {
      id = "disc_19",
      name = "Completed 425 Discoveries",
      desc = "Milestone! Congrats! You've made 425 Discoveries",
      shortdesc = "425 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    },
    {
      id = "disc_20",
      name = "Completed 450 Discoveries",
      desc = "Milestone! Congrats! You've made 450 Discoveries",
      shortdesc = "450 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    },
    {
      id = "disc_21",
      name = "Completed 475 Discoveries",
      desc = "Milestone! Congrats! You've made 475 Discoveries",
      shortdesc = "475 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    },
    {
      id = "disc_22",
      name = "Completed 500 Discoveries",
      desc = "Milestone! Congrats! You've made 500 Discoveries",
      shortdesc = "500 Discoveries",
      points = discoveryPoints,
      image = imgDiscovery,
    },

    -- Professions Total (Started)
    {
      id = "proft_1",
      name = "Started 5 Professions",
      desc = "Milestone! Congrats! You've started 5 professions",
      shortdesc = "Started 5 professions",
      points = professionTotal,
      image = imgProfessionTotal,
    },
    {
      id = "proft_2",
      name = "Started 10 Professions",
      desc = "Milestone! Congrats! You've started 10 professions",
      shortdesc = "Started 10 professions",
      points = professionTotal,
      image = imgProfessionTotal,
    },

    -- Profession points
    {
      id = "profp_1",
      name = "5 Profession Points",
      desc = "Milestone! Congrats! You've 5 Profession Points",
      shortdesc = "5 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_2",
      name = "15 Profession Points",
      desc = "Milestone! Congrats! You've 15 Profession Points",
      shortdesc = "15 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_3",
      name = "50 Profession Points",
      desc = "Milestone! Congrats! You've 50 Profession Points",
      shortdesc = "50 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_4",
      name = "100 Profession Points",
      desc = "Milestone! Congrats! You've 100 Profession Points",
      shortdesc = "100 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_5",
      name = "150 Profession Points",
      desc = "Milestone! Congrats! You've 150 Profession Points",
      shortdesc = "150 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_6",
      name = "200 Profession Points",
      desc = "Milestone! Congrats! You've 200 Profession Points",
      shortdesc = "200 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_7",
      name = "250 Profession Points",
      desc = "Milestone! Congrats! You've 250 Profession Points",
      shortdesc = "250 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_8",
      name = "300 Profession Points",
      desc = "Milestone! Congrats! You've 300 Profession Points",
      shortdesc = "300 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_9",
      name = "350 Profession Points",
      desc = "Milestone! Congrats! You've 350 Profession Points",
      shortdesc = "350 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_10",
      name = "400 Profession Points",
      desc = "Milestone! Congrats! You've 400 Profession Points",
      shortdesc = "400 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_11",
      name = "450 Profession Points",
      desc = "Milestone! Congrats! You've 450 Profession Points",
      shortdesc = "450 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_12",
      name = "500 Profession Points",
      desc = "Milestone! Congrats! You've 500 Profession Points",
      shortdesc = "500 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_13",
      name = "600 Profession Points",
      desc = "Milestone! Congrats! You've 600 Profession Points",
      shortdesc = "600 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_14",
      name = "700 Profession Points",
      desc = "Milestone! Congrats! You've 700 Profession Points",
      shortdesc = "700 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_15",
      name = "800 Profession Points",
      desc = "Milestone! Congrats! You've 800 Profession Points",
      shortdesc = "800 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_16",
      name = "900 Profession Points",
      desc = "Milestone! Congrats! You've 900 Profession Points",
      shortdesc = "900 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_17",
      name = "1000 Profession Points",
      desc = "Milestone! Congrats! You've 1000 Profession Points",
      shortdesc = "1000 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_18",
      name = "1100 Profession Points",
      desc = "Milestone! Congrats! You've 1100 Profession Points",
      shortdesc = "1100 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_19",
      name = "1200 Profession Points",
      desc = "Milestone! Congrats! You've 1200 Profession Points",
      shortdesc = "1200 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_20",
      name = "1300 Profession Points",
      desc = "Milestone! Congrats! You've 1300 Profession Points",
      shortdesc = "1300 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_21",
      name = "1400 Profession Points",
      desc = "Milestone! Congrats! You've 1400 Profession Points",
      shortdesc = "1400 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },
    {
      id = "profp_22",
      name = "1500 Profession Points",
      desc = "Milestone! Congrats! You've 1500 Profession Points",
      shortdesc = "1500 Profession Points",
      points = professionPoints,
      image = imgProfession,
    },

}