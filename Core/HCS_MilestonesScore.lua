HCS_MilestonesScore = {}


local newMilestone = {
    id = 0,
    points = 0,
  }

local function AddMilestone(id)

    local found = false

  -- look up if milestone has been achieved
    for _, milestone in pairs(HCScore_Character.milestones) do
        if milestone.id == id then
            found = true
            break
        end
    end

    if not found then
        -- add milestone
        for _, milestone in pairs(HCS_MilestonesDB) do
            if milestone.id == id then
                newMilestone = {
                    id = milestone.id,
                    points = milestone.points,
                }
--                DEFAULT_CHAT_FRAME:AddMessage("|cffADD8E6This is light blue text!|r")

                HCS_Utils:Print("|cff81b7e9"..milestone.desc.."|r")                

                --print("|cff81b7e9"..milestone.desc.."|r")     
                table.insert(HCScore_Character.milestones, newMilestone)
                
                HCS_PointsLogUI:AddMessage(milestone.desc)                

                if Hardcore_Score.db.profile.framePositionMsg.show then
                    local desc = string.upper(milestone.shortdesc)
                    local frame = HCS_MessageFrameUI.DisplayMilestoneMessage(desc, 5, milestone.textcolor)                    
                    frame:EnqueueMessage() 
                end
            end
        end
    end
end

local function CheckLeveling()
    local level = UnitLevel("player")

    if level >= 5 then AddMilestone("lvl_1") end
    if level >= 10 then AddMilestone("lvl_2") end
    if level >= 15 then AddMilestone("lvl_3") end
    if level >= 20 then AddMilestone("lvl_4") end
    if level >= 25 then AddMilestone("lvl_5") end
    if level >= 30 then AddMilestone("lvl_6") end
    if level >= 35 then AddMilestone("lvl_7") end
    if level >= 40 then AddMilestone("lvl_8") end
    if level >= 45 then AddMilestone("lvl_9") end
    if level >= 50 then AddMilestone("lvl_10") end
    if level >= 55 then AddMilestone("lvl_11") end
    if level >= 60 then AddMilestone("lvl_12") end
    if level >= 65 then AddMilestone("lvl_13") end
    if level >= 70 then AddMilestone("lvl_14") end    
    if level >= 75 then AddMilestone("lvl_15") end
    if level == 80 then AddMilestone("lvl_16") end

end

local function CheckMobKillsByType()
    local mobskilled = #HCScore_Character.mobsKilled

    if mobskilled >= 10 then AddMilestone("mobkt_1") end
    if mobskilled >= 20 then AddMilestone("mobkt_2") end
    if mobskilled >= 30 then AddMilestone("mobkt_3") end
    if mobskilled >= 40 then AddMilestone("mobkt_4") end
    if mobskilled >= 50 then AddMilestone("mobkt_5") end
    if mobskilled >= 60 then AddMilestone("mobkt_6") end
    if mobskilled >= 70 then AddMilestone("mobkt_7") end
    if mobskilled >= 80 then AddMilestone("mobkt_8") end
    if mobskilled >= 90 then AddMilestone("mobkt_9") end
    if mobskilled >= 110 then AddMilestone("mobkt_10") end
    if mobskilled >= 120 then AddMilestone("mobkt_11") end
    if mobskilled >= 130 then AddMilestone("mobkt_12") end
    if mobskilled >= 140 then AddMilestone("mobkt_13") end
    if mobskilled >= 150 then AddMilestone("mobkt_14") end
    if mobskilled >= 160 then AddMilestone("mobkt_15") end
    if mobskilled >= 170 then AddMilestone("mobkt_16") end
    if mobskilled >= 180 then AddMilestone("mobkt_17") end
    if mobskilled >= 190 then AddMilestone("mobkt_18") end

end

local function CheckMobKillsTotal()

    local total = 0

    for _, mob in pairs(HCScore_Character.mobsKilled) do
        total = total + mob.kills
    end

    if total >= 100 then AddMilestone("mobk_1") end
    if total >= 200 then AddMilestone("mobk_2") end
    if total >= 300 then AddMilestone("mobk_3") end
    if total >= 400 then AddMilestone("mobk_4") end
    if total >= 500 then AddMilestone("mobk_5") end
    if total >= 600 then AddMilestone("mobk_6") end
    if total >= 700 then AddMilestone("mobk_7") end
    if total >= 800 then AddMilestone("mobk_8") end
    if total >= 900 then AddMilestone("mobk_9") end
    if total >= 1500 then AddMilestone("mobk_10") end
    if total >= 2000 then AddMilestone("mobk_11") end
    if total >= 2500 then AddMilestone("mobk_12") end
    if total >= 3000 then AddMilestone("mobk_13") end
    if total >= 3500 then AddMilestone("mobk_14") end
    if total >= 4000 then AddMilestone("mobk_15") end
    if total >= 4500 then AddMilestone("mobk_16") end
    if total >= 5500 then AddMilestone("mobk_17") end
    if total >= 6000 then AddMilestone("mobk_18") end
    if total >= 6500 then AddMilestone("mobk_19") end
    if total >= 7000 then AddMilestone("mobk_20") end
    if total >= 7500 then AddMilestone("mobk_21") end
    if total >= 8000 then AddMilestone("mobk_22") end
    if total >= 8500 then AddMilestone("mobk_23") end
    if total >= 9000 then AddMilestone("mobk_24") end
    if total >= 9500 then AddMilestone("mobk_25") end

end

local function CheckQuestTotals()

    local total = #HCScore_Character.quests

    if total >= 10 then AddMilestone("qtot_1") end
    if total >= 50 then AddMilestone("qtot_2") end
    if total >= 150 then AddMilestone("qtot_3") end
    if total >= 200 then AddMilestone("qtot_4") end
    if total >= 250 then AddMilestone("qtot_5") end
    if total >= 300 then AddMilestone("qtot_6") end
    if total >= 350 then AddMilestone("qtot_7") end
    if total >= 400 then AddMilestone("qtot_8") end
    if total >= 450 then AddMilestone("qtot_9") end
    if total >= 550 then AddMilestone("qtot_10") end
    if total >= 600 then AddMilestone("qtot_11") end
    if total >= 650 then AddMilestone("qtot_12") end
    if total >= 700 then AddMilestone("qtot_13") end
    if total >= 750 then AddMilestone("qtot_14") end
    if total >= 800 then AddMilestone("qtot_15") end
    if total >= 850 then AddMilestone("qtot_16") end
    if total >= 900 then AddMilestone("qtot_17") end
    if total >= 950 then AddMilestone("qtot_18") end

end

local function CheckDiscoveryTotals()

    local total = #HCScore_Character.discovery

    if total >= 10 then AddMilestone("disc_1") end
    if total >= 50 then AddMilestone("disc_2") end
    if total >= 150 then AddMilestone("disc_3") end
    if total >= 200 then AddMilestone("disc_4") end
    if total >= 250 then AddMilestone("disc_5") end
    if total >= 300 then AddMilestone("disc_6") end
    if total >= 350 then AddMilestone("disc_7") end
    if total >= 400 then AddMilestone("disc_8") end
    if total >= 450 then AddMilestone("disc_9") end
    if total >= 550 then AddMilestone("disc_10") end
    if total >= 600 then AddMilestone("disc_11") end
    if total >= 650 then AddMilestone("disc_12") end
    if total >= 700 then AddMilestone("disc_13") end
    if total >= 750 then AddMilestone("disc_14") end
    if total >= 800 then AddMilestone("disc_15") end
    if total >= 850 then AddMilestone("disc_16") end
    if total >= 900 then AddMilestone("disc_17") end
    if total >= 950 then AddMilestone("disc_18") end

end

local function CheckProfessionsTotals()

    local total = HCS_ProfessionsScore:GetNumberOfProfessions()

    if total >= 1 then AddMilestone("proft_1") end
    if total >= 5 then AddMilestone("proft_2") end
    if total >= 10 then AddMilestone("proft_3") end

end

local function CheckProfessionsPoints()

    local total = HCScore_Character.scores.professionsScore

    if total >= 10 then AddMilestone("profp_1") end
    if total >= 50 then AddMilestone("profp_2") end
    if total >= 100 then AddMilestone("profp_3") end
    if total >= 200 then AddMilestone("profp_4") end
    if total >= 300 then AddMilestone("profp_5") end
    if total >= 400 then AddMilestone("profp_6") end
    if total >= 500 then AddMilestone("profp_7") end
    if total >= 750 then AddMilestone("profp_8") end
    if total >= 1000 then AddMilestone("profp_9") end
    if total >= 1500 then AddMilestone("profp_10") end
    if total >= 2000 then AddMilestone("profp_11") end
    if total >= 2500 then AddMilestone("profp_12") end

end

local function CheckDangerousEnemiesKilled()

    local total = 0

    for _, mob in pairs(HCScore_Character.dangerousMobsKilled) do
        total = total + mob.kills
    end

    if total >= 5 then AddMilestone("dek_1") end
    if total >= 25 then AddMilestone("dek_2") end
    if total >= 50 then AddMilestone("dek_3") end
    if total >= 75 then AddMilestone("dek_4") end
    if total >= 125 then AddMilestone("dek_5") end
    if total >= 150 then AddMilestone("dek_6") end
    if total >= 175 then AddMilestone("dek_7") end
    if total >= 200 then AddMilestone("dek_8") end
    if total >= 225 then AddMilestone("dek_9") end
    if total >= 250 then AddMilestone("dek_10") end
    if total >= 275 then AddMilestone("dek_11") end
    if total >= 300 then AddMilestone("dek_12") end
    if total >= 325 then AddMilestone("dek_13") end
    if total >= 350 then AddMilestone("dek_14") end
    if total >= 375 then AddMilestone("dek_15") end
    if total >= 400 then AddMilestone("dek_16") end
    if total >= 425 then AddMilestone("dek_17") end
    if total >= 450 then AddMilestone("dek_18") end
    if total >= 475 then AddMilestone("dek_19") end
    if total >= 525 then AddMilestone("dek_20") end
    if total >= 550 then AddMilestone("dek_21") end
    if total >= 575 then AddMilestone("dek_22") end
    if total >= 600 then AddMilestone("dek_23") end
    if total >= 625 then AddMilestone("dek_24") end
    if total >= 650 then AddMilestone("dek_25") end
    if total >= 675 then AddMilestone("dek_26") end
    if total >= 700 then AddMilestone("dek_27") end
    if total >= 725 then AddMilestone("dek_28") end
    if total >= 750 then AddMilestone("dek_29") end
    if total >= 775 then AddMilestone("dek_30") end
    if total >= 800 then AddMilestone("dek_31") end
    if total >= 825 then AddMilestone("dek_32") end
    if total >= 850 then AddMilestone("dek_33") end
    if total >= 875 then AddMilestone("dek_34") end
    if total >= 900 then AddMilestone("dek_35") end
    if total >= 925 then AddMilestone("dek_36") end
    if total >= 950 then AddMilestone("dek_37") end
    if total >= 975 then AddMilestone("dek_38") end

end

function HCS_MilestonesScore:CheckMilestones()

    CheckMobKillsByType()
    CheckMobKillsTotal()
    CheckQuestTotals()
    CheckDiscoveryTotals()
    CheckProfessionsTotals()
    CheckProfessionsPoints()
    CheckDangerousEnemiesKilled()

end

function HCS_MilestonesScore:GetMilestonesScore()

    local score = 0

    for _, milestone in pairs(HCScore_Character.milestones) do
        score = score + milestone.points
    end   
    
    return score
end

function HCS_MilestonesScore:GetNumberOfMilestones()
    return #HCScore_Character.milestones
end

function HCS_MilestonesScore:ClearMilestones()
    HCScore_Character.milestones = {}
end

function HCS_MilestonesScore:GetToolTip(tooltip)
    local totalKills = 0
    local totalKilltypes = 0
    local totalQuests = 0
    local totalDiscoveries = 0
    local totalProfessions = 0
    local totalProfessionPoints = 0
    local totalDangerousEnemiesKilled = 0

    for _, milestone in pairs(HCScore_Character.milestones) do
        local inputString = milestone.id
        local id = inputString:match("([^_]+)")
        
        if id == "mobk" then
            totalKills = totalKills + milestone.points
        elseif id == "mobkt" then
            totalKilltypes = totalKilltypes + milestone.points
        elseif id == "qtot" then
            totalQuests = totalQuests + milestone.points
        elseif id == "disc" then
            totalDiscoveries = totalDiscoveries + milestone.points
        elseif id == "proft" then
            totalProfessions = totalProfessions + milestone.points
        elseif id == "profp" then
            totalProfessionPoints = totalProfessionPoints + milestone.points
        elseif id == "dek" then
            totalDangerousEnemiesKilled = totalDangerousEnemiesKilled + milestone.points
        end
    end      

    tooltip:AddLine(string.format("%.2f", (totalKills * HCS_LevelScalePercentage)) .. " Kills", nil, nil, nil, true)
    tooltip:AddLine(string.format("%.2f", (totalKilltypes * HCS_LevelScalePercentage)) .. " Kill Types", nil, nil, nil, true)
    tooltip:AddLine(string.format("%.2f", (totalQuests * HCS_LevelScalePercentage)) .. " Quests", nil, nil, nil, true)
    tooltip:AddLine(string.format("%.2f", (totalDiscoveries * HCS_LevelScalePercentage)) .. " Discoveries", nil, nil, nil, true)
    tooltip:AddLine(string.format("%.2f", (totalProfessions * HCS_LevelScalePercentage)) .. " Professions", nil, nil, nil, true)
    tooltip:AddLine(string.format("%.2f", (totalProfessionPoints * HCS_LevelScalePercentage)) .. " Profession Points", nil, nil, nil, true)
    tooltip:AddLine(string.format("%.2f", (totalDangerousEnemiesKilled * HCS_LevelScalePercentage)) .. " Dangerous Enemies Killed", nil, nil, nil, true)
end
