HCS_ProfessionsScore = {}

local ALCHEMY = "Alchemy"
local BLACKSMITHING = "Blacksmithing"
local ENCHANTING = "Enchanting"
local ENGINEERING = "Engineering"
local HERBALISM = "Herbalism"
local LEATHERWORKING = "Leatherworking"
local LOCKPICKING = "Lockpicking"
local MINING = "Mining"
local SKINNING = "Skinning"
local TAILORING = "Tailoring"
local FISHING = "Fishing"
local COOKING = "Cooking"
local FISTAID = "First Aid"

local LEVEL1 = 0
local LEVEL2 = 25
local LEVEL3 = 50
local LEVEL4 = 75
local LEVEL5 = 100
local LEVEL6 = 150

local function between(x, a, b)
    return x >= a and x <= b
end

local function CalcScore(skilllevel)
    local score

    if between(skilllevel, 0, 50) then score = LEVEL1 end
    if between(skilllevel, 51, 100) then score = LEVEL2 end
    if between(skilllevel, 101, 150) then score = LEVEL3 end
    if between(skilllevel, 151, 200) then score = LEVEL4 end
    if between(skilllevel, 201, 250) then score = LEVEL5 end
    if between(skilllevel, 251, 300) then score = LEVEL6 end
    if between(skilllevel, 2, 300) then score = score + skilllevel end

    return score
end

function UpdateProfessionScore(professionid, skilllevel)

    if professionid == ALCHEMY then 
        HCScore_Character.professions.alchemy = CalcScore(skilllevel)
    elseif professionid == BLACKSMITHING then 
        HCScore_Character.professions.blacksmithing = CalcScore(skilllevel)
    elseif professionid == ENCHANTING then 
        HCScore_Character.professions.enchanting = CalcScore(skilllevel)
    elseif professionid == ENGINEERING then 
        HCScore_Character.professions.engineering = CalcScore(skilllevel)
    elseif professionid == HERBALISM then 
        HCScore_Character.professions.herbalism = CalcScore(skilllevel)
    elseif professionid == LEATHERWORKING then 
        HCScore_Character.professions.leatherworking = CalcScore(skilllevel)
    elseif professionid == LOCKPICKING then 
        HCScore_Character.professions.lockpicking = CalcScore(skilllevel)
    elseif professionid == MINING then 
        HCScore_Character.professions.mining = CalcScore(skilllevel)
    elseif professionid == SKINNING then 
        HCScore_Character.professions.skinning = CalcScore(skilllevel)
    elseif professionid == TAILORING then 
        HCScore_Character.professions.tailoring = CalcScore(skilllevel)
    elseif professionid == FISHING then 
        HCScore_Character.professions.fishing = CalcScore(skilllevel)
    elseif professionid == COOKING then 
        HCScore_Character.professions.cooking = CalcScore(skilllevel)
    elseif professionid == FISTAID then 
        HCScore_Character.professions.firstaid = CalcScore(skilllevel)
    end    
end

function HCS_ProfessionsScore:GetScore()
    local char = HCScore_Character.professions
    local score = 0
  
    score = char.alchemy +
            char.blacksmithing +
            char.cooking +
            char.enchanting +
            char.engineering +
            char.firstaid +
            char.fishing +
            char.herbalism +
            char.leatherworking +
            char.lockpicking +
            char.mining +
            char.skinning +
            char.tailoring

    HCScore_Character.scores.professionsScore = score
end

function HCS_ProfessionsScore:GetNumberOfProfessions()
    local numskills = 0
    local professions = HCScore_Character.professions

    for i = 1, GetNumSkillLines() do
        local skillName, isHeader, _, skillRank, _, _, skillMaxRank, _, _, skillLineID = GetSkillLineInfo(i)
        
        if not isHeader then
            --print(i, GetSkillLineInfo(i))
            UpdateProfessionScore(skillName, skillRank)
            --print("skillName: "..skillName.."skillRank: "..skillRank)
        end
    end

    self:GetScore()

    for k, v in pairs(professions) do
        if v > 0 then numskills = numskills + 1 end
    end

    return numskills
end