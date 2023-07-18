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

                print("|cff81b7e9"..milestone.desc.."|r")     
                table.insert(HCScore_Character.milestones, newMilestone)
                HCS_PointsLogUI:AddMessage(milestone.desc)

                if Hardcore_Score.db.profile.framePositionMsg.show then
                    local frame = HCS_MessageFrameUI.DisplayMessage(milestone.shortdesc, 7, milestone.image)
                    frame:ShowMessage() 
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
    if level == 60 then AddMilestone("lvl_12") end

end

local function CheckMobKillsByType()
    local mobskilled = #HCScore_Character.mobsKilled

    if mobskilled >= 5 then AddMilestone("mobkt_1") end
    if mobskilled >= 10 then AddMilestone("mobkt_2") end
    if mobskilled >= 20 then AddMilestone("mobkt_3") end
    if mobskilled >= 30 then AddMilestone("mobkt_4") end
    if mobskilled >= 40 then AddMilestone("mobkt_5") end
    if mobskilled >= 50 then AddMilestone("mobkt_6") end
    if mobskilled >= 60 then AddMilestone("mobkt_7") end
    if mobskilled >= 70 then AddMilestone("mobkt_8") end
    if mobskilled >= 80 then AddMilestone("mobkt_9") end
    if mobskilled >= 90 then AddMilestone("mobkt_10") end
    if mobskilled >= 100 then AddMilestone("mobkt_11") end
    if mobskilled >= 110 then AddMilestone("mobkt_12") end
    if mobskilled >= 120 then AddMilestone("mobkt_13") end

end

local function CheckMobKillsTotal()

    local total = 0

    for _, mob in pairs(HCScore_Character.mobsKilled) do
        total = total + mob.kills
    end

    if total >= 5 then AddMilestone("mobk_10") end
    if total >= 50 then AddMilestone("mobk_1") end
    if total >= 100 then AddMilestone("mobk_2") end
    if total >= 250 then AddMilestone("mobk_3") end
    if total >= 500 then AddMilestone("mobk_4") end
    if total >= 750 then AddMilestone("mobk_11") end
    if total >= 1000 then AddMilestone("mobk_5") end
    if total >= 1250 then AddMilestone("mobk_12") end
    if total >= 1500 then AddMilestone("mobk_13") end
    if total >= 1750 then AddMilestone("mobk_14") end
    if total >= 2000 then AddMilestone("mobk_6") end
    if total >= 2250 then AddMilestone("mobk_15") end
    if total >= 2500 then AddMilestone("mobk_16") end
    if total >= 2750 then AddMilestone("mobk_17") end
    if total >= 3000 then AddMilestone("mobk_7") end
    if total >= 3500 then AddMilestone("mobk_18") end
    if total >= 4000 then AddMilestone("mobk_8") end
    if total >= 4500 then AddMilestone("mobk_19") end
    if total >= 5000 then AddMilestone("mobk_9") end
    if total >= 5500 then AddMilestone("mobk_20") end
    if total >= 6000 then AddMilestone("mobk_21") end

end

local function CheckQuestTotals()

    local total = #HCScore_Character.quests

    if total >= 5 then AddMilestone("qtot_1") end
    if total >= 15 then AddMilestone("qtot_2") end
    if total >= 30 then AddMilestone("qtot_3") end
    if total >= 50 then AddMilestone("qtot_4") end
    if total >= 75 then AddMilestone("qtot_12") end
    if total >= 100 then AddMilestone("qtot_5") end
    if total >= 125 then AddMilestone("qtot_13") end
    if total >= 150 then AddMilestone("qtot_14") end
    if total >= 175 then AddMilestone("qtot_15") end
    if total >= 200 then AddMilestone("qtot_6") end
    if total >= 225 then AddMilestone("qtot_16") end
    if total >= 250 then AddMilestone("qtot_17") end
    if total >= 275 then AddMilestone("qtot_18") end
    if total >= 300 then AddMilestone("qtot_7") end
    if total >= 325 then AddMilestone("qtot_19") end
    if total >= 350 then AddMilestone("qtot_20") end
    if total >= 375 then AddMilestone("qtot_21") end
    if total >= 400 then AddMilestone("qtot_8") end
    if total >= 425 then AddMilestone("qtot_22") end
    if total >= 450 then AddMilestone("qtot_23") end
    if total >= 475 then AddMilestone("qtot_24") end
    if total >= 500 then AddMilestone("qtot_9") end
    if total >= 600 then AddMilestone("qtot_25") end
    if total >= 700 then AddMilestone("qtot_10") end
    if total >= 800 then AddMilestone("qtot_26") end
    if total >= 900 then AddMilestone("qtot_27") end
    if total >= 1000 then AddMilestone("qtot_11") end

end

local function CheckDiscoveryTotals()

    local total = #HCScore_Character.discovery

    if total >= 5 then AddMilestone("disc_1") end
    if total >= 10 then AddMilestone("disc_2") end
    if total >= 25 then AddMilestone("disc_3") end
    if total >= 50 then AddMilestone("disc_4") end
    if total >= 75 then AddMilestone("disc_12") end
    if total >= 100 then AddMilestone("disc_5") end
    if total >= 125 then AddMilestone("disc_13") end
    if total >= 150 then AddMilestone("disc_6") end
    if total >= 175 then AddMilestone("disc_14") end
    if total >= 200 then AddMilestone("disc_7") end
    if total >= 225 then AddMilestone("disc_15") end
    if total >= 250 then AddMilestone("disc_8") end
    if total >= 275 then AddMilestone("disc_16") end
    if total >= 300 then AddMilestone("disc_9") end
    if total >= 325 then AddMilestone("disc_17") end
    if total >= 350 then AddMilestone("disc_10") end
    if total >= 375 then AddMilestone("disc_18") end
    if total >= 400 then AddMilestone("disc_11") end
    if total >= 425 then AddMilestone("disc_19") end
    if total >= 450 then AddMilestone("disc_20") end
    if total >= 475 then AddMilestone("disc_21") end
    if total >= 500 then AddMilestone("disc_22") end

end

local function CheckProfessionsTotals()

    local total = HCS_ProfessionsScore:GetNumberOfProfessions()

    if total >= 5 then AddMilestone("proft_1") end
    if total >= 10 then AddMilestone("proft_2") end

end

local function CheckProfessionsPoints()

    local total = HCScore_Character.scores.professionsScore

    if total >= 5 then AddMilestone("profp_1") end
    if total >= 15 then AddMilestone("profp_2") end
    if total >= 50 then AddMilestone("profp_3") end
    if total >= 100 then AddMilestone("profp_4") end
    if total >= 150 then AddMilestone("profp_5") end
    if total >= 200 then AddMilestone("profp_6") end
    if total >= 250 then AddMilestone("profp_7") end
    if total >= 300 then AddMilestone("profp_8") end
    if total >= 350 then AddMilestone("profp_9") end
    if total >= 400 then AddMilestone("profp_10") end
    if total >= 450 then AddMilestone("profp_11") end
    if total >= 500 then AddMilestone("profp_12") end
    if total >= 600 then AddMilestone("profp_13") end
    if total >= 700 then AddMilestone("profp_14") end
    if total >= 800 then AddMilestone("profp_15") end
    if total >= 900 then AddMilestone("profp_16") end
    if total >= 1000 then AddMilestone("profp_17") end
    if total >= 1100 then AddMilestone("profp_18") end
    if total >= 1200 then AddMilestone("profp_19") end
    if total >= 1300 then AddMilestone("profp_20") end
    if total >= 1400 then AddMilestone("profp_21") end
    if total >= 1500 then AddMilestone("profp_22") end

end

function HCS_MilestonesScore:CheckMilestones()

    CheckLeveling()
    CheckMobKillsByType()
    CheckMobKillsTotal()
    CheckQuestTotals()
    CheckDiscoveryTotals()
    CheckProfessionsTotals()
    CheckProfessionsPoints()

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

function HCS_MilestonesScore:RecalculateMilestones()

    if HCScore_Character.milestones ~= nil then

        local milestones = HCScore_Character.milestones

        for i = #milestones, 1, -1 do
            if type(milestones[i].id) == "number" then
                -- id is a number, remove the entry
                table.remove(milestones, i)
            end
        end
    end

end
