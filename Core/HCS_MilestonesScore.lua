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
            end
        end   
    end
    
end

local function CheckLeveling()
    local level = UnitLevel("player")

    if level >= 5 then AddMilestone(1) end
    if level >= 10 then AddMilestone(2) end
    if level >= 15 then AddMilestone(3) end
    if level >= 20 then AddMilestone(4) end    
    if level >= 25 then AddMilestone(5) end    
    if level >= 30 then AddMilestone(6) end
    if level >= 35 then AddMilestone(7) end    
    if level >= 40 then AddMilestone(8) end
    if level >= 45 then AddMilestone(9) end
    if level >= 50 then AddMilestone(10) end
    if level >= 55 then AddMilestone(11) end
    if level == 60 then AddMilestone(12) end    

end

local function CheckMobKillsByType()
    local mobskilled = #HCScore_Character.mobsKilled
    
    if mobskilled >= 5 then AddMilestone(22) end
    if mobskilled >= 10 then AddMilestone(23) end
    if mobskilled >= 20 then AddMilestone(24) end
    if mobskilled >= 30 then AddMilestone(25) end
    if mobskilled >= 40 then AddMilestone(26) end
    if mobskilled >= 50 then AddMilestone(27) end
    if mobskilled >= 60 then AddMilestone(28) end
    if mobskilled >= 70 then AddMilestone(29) end
    if mobskilled >= 80 then AddMilestone(30) end
    if mobskilled >= 90 then AddMilestone(31) end
    if mobskilled >= 100 then AddMilestone(32) end
end

local function CheckMobKillsTotal()

    local total = 0

    for _, mob in pairs(HCScore_Character.mobsKilled) do
        total = total + mob.kills
    end   
  
    if total >= 50 then AddMilestone(13) end
    if total >= 100 then AddMilestone(14) end
    if total >= 250 then AddMilestone(15) end
    if total >= 500 then AddMilestone(16) end
    if total >= 1000 then AddMilestone(17) end
    if total >= 2000 then AddMilestone(18) end
    if total >= 3000 then AddMilestone(19) end
    if total >= 4000 then AddMilestone(20) end
    if total >= 5000 then AddMilestone(21) end

end

local function CheckQuestTotals()

    local total = #HCScore_Character.quests
    
    if total >= 5 then AddMilestone(33) end
    if total >= 15 then AddMilestone(34) end
    if total >= 30 then AddMilestone(35) end
    if total >= 50 then AddMilestone(36) end
    if total >= 100 then AddMilestone(37) end
    if total >= 200 then AddMilestone(38) end
    if total >= 300 then AddMilestone(39) end
    if total >= 400 then AddMilestone(40) end
    if total >= 500 then AddMilestone(41) end
    if total >= 750 then AddMilestone(42) end
    if total >= 1000 then AddMilestone(43) end
    
end
    
local function CheckDiscoveryTotals()

    local total = #HCScore_Character.discovery
    
    if total >= 5 then AddMilestone(44) end
    if total >= 10 then AddMilestone(45) end
    if total >= 25 then AddMilestone(46) end
    if total >= 50 then AddMilestone(47) end
    if total >= 100 then AddMilestone(48) end
    if total >= 150 then AddMilestone(49) end
    if total >= 200 then AddMilestone(50) end
    if total >= 250 then AddMilestone(51) end
    if total >= 300 then AddMilestone(52) end
    if total >= 350 then AddMilestone(53) end
    if total >= 400 then AddMilestone(54) end

end

function HCS_MilestonesScore:CheckMilestones()

    CheckLeveling()
    CheckMobKillsByType()
    CheckMobKillsTotal()
    CheckQuestTotals()
    CheckDiscoveryTotals()
    
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