HCS_ProfessionsScore = {}

---- Load AceLocale-3.0
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")

---- Get the localization instance
local L = AceLocale:GetLocale("Hardcore_Score")

local ALCHEMY = L["Alchemy"]
local BLACKSMITHING = L["Blacksmithing"]
local ENCHANTING = L["Enchanting"]
local ENGINEERING = L["Engineering"]
local HERBALISM = L["Herbalism"]
local LEATHERWORKING = L["Leatherworking"]
local MINING = L["Mining"]
local SKINNING = L["Skinning"]
local TAILORING = L["Tailoring"]
local FISHING = L["Fishing"]
local COOKING = L["Cooking"]
local FIRSTAID = L["First Aid"]
-- WOTLK
local JEWELCRAFTING = L["Jewelcrafting"]
local INSCRIPTION = L["Inscription"]

local LEVEL1 = 0
local LEVEL2 = 25
local LEVEL3 = 50
local LEVEL4 = 75
local LEVEL5 = 100
local LEVEL6 = 150
-- WOTLK
local LEVEL7 = 175
local LEVEL8 = 200
-- Cataclysm
local LEVEL9 = 225

local function between(x, a, b)
    return x >= a and x <= b
end

local function CalcScore(skilllevel)
    local score = 0

    if between(skilllevel, 0, 50) then score = LEVEL1 end
    if between(skilllevel, 51, 100) then score = LEVEL2 end
    if between(skilllevel, 101, 150) then score = LEVEL3 end
    if between(skilllevel, 151, 200) then score = LEVEL4 end
    if between(skilllevel, 201, 250) then score = LEVEL5 end
    if between(skilllevel, 251, 300) then score = LEVEL6 end
    if between(skilllevel, 301, 375) then score = LEVEL7 end -- WOTLK
    if between(skilllevel, 376, 450) then score = LEVEL8 end -- WOTLK
    if between(skilllevel, 451, 525) then score = LEVEL9 end -- Cataclysm
    if between(skilllevel, 2, 450) then score = score + skilllevel end

    return score
end

function UpdateProfessionScore(professionid, skilllevel)
    local score = CalcScore(skilllevel)

    if professionid == ALCHEMY then 
      if score > HCScore_Character.professions.alchemy then
            HCScore_Character.professions.alchemy = score    
      end
    elseif professionid == BLACKSMITHING then 
        if score > HCScore_Character.professions.blacksmithing then
            HCScore_Character.professions.blacksmithing = score
        end
    elseif professionid == ENCHANTING then 
        if score > HCScore_Character.professions.enchanting then
            HCScore_Character.professions.enchanting = score
        end
    elseif professionid == ENGINEERING then 
        if score > HCScore_Character.professions.engineering then
            HCScore_Character.professions.engineering = score
        end
    elseif professionid == HERBALISM then 
        if score > HCScore_Character.professions.herbalism then
            HCScore_Character.professions.herbalism = score
        end
    elseif professionid == LEATHERWORKING then 
        if score > HCScore_Character.professions.leatherworking then
            HCScore_Character.professions.leatherworking = score
        end
    elseif professionid == MINING then 
        if score > HCScore_Character.professions.mining then
            HCScore_Character.professions.mining = score
        end
    elseif professionid == SKINNING then 
        if score > HCScore_Character.professions.skinning then
            HCScore_Character.professions.skinning = score
        end
    elseif professionid == TAILORING then 
        if score > HCScore_Character.professions.tailoring then
            HCScore_Character.professions.tailoring = score
        end
    elseif professionid == FISHING then 
        if score > HCScore_Character.professions.fishing then
            HCScore_Character.professions.fishing = score
        end
    elseif professionid == COOKING then 
        if score > HCScore_Character.professions.cooking then
            HCScore_Character.professions.cooking = score
        end
    elseif professionid == FIRSTAID then 
        if score > HCScore_Character.professions.firstaid then
            HCScore_Character.professions.firstaid = score
        end
    elseif professionid == JEWELCRAFTING then 
        if score > HCScore_Character.professions.jewelcrafting then
            HCScore_Character.professions.jewelcrafting = score
        end
    elseif professionid == INSCRIPTION then 
        if score > HCScore_Character.professions.inscription then
            HCScore_Character.professions.inscription = score
        end        
    end
end

local function GetScore()
    local char = HCScore_Character.professions
    local score = 0
  
    local score = char.alchemy +
            char.blacksmithing +
            char.cooking +
            char.enchanting +
            char.engineering +
            char.firstaid +
            char.fishing +
            char.herbalism +
            char.leatherworking +
            char.mining +
            char.skinning +
            char.tailoring +
            char.jewelcrafting + -- WOTLK
            char.inscription -- WOTLK

    return score
end

function HCS_ProfessionsScore:GetProfessionsScore()

    -- TODO: we need to introduce localization
    
    for i = 1, GetNumSkillLines() do
        local skillName, isHeader, _, skillRank, _, _, skillMaxRank, _, _, skillLineID = GetSkillLineInfo(i)
        
        if not isHeader then
           UpdateProfessionScore(skillName, skillRank)
         end
    end

    local score = GetScore()

    return score
end

function HCS_ProfessionsScore:GetNumberOfProfessions()
    local numskills = 0
    local professions = HCScore_Character.professions
  
    for k, v in pairs(professions) do
        if v > 0 then numskills = numskills + 1 end
    end

    return numskills
end
