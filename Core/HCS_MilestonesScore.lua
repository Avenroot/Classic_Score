HCS_MilestonesScore = {}

local milestone = {
    id = 0,
    points = 0,
}


local function CheckLeveling()
    local level = UnitLevel("player")

--    if level == 2 then 

end
    
function HCS_MilestonesScore:CheckMilestones()

    if HCScore_Character.milestones == nil then
        HCScore_Character.milestones = {}
    end

    CheckLeveling()
    
end

function HCS_MilestonesScore:GetMilestonesScore()
    return 0    
end

function HCS_MilestonesScore:GetNumberOfMilestones()
    return 0
end