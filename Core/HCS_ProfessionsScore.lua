HCS_ProfessionsScore = {}

local ALCHEMY = 171
local ALCHEMY_ELIXIR_MASTER = 286
local ALCHEMY_POTION_MASTER = 285
local ALCHEMY_TRANSMUTATION_MASTER = 287
local BLACKSMITHING = 164
local BLACKSMITHING_ARMORSMITH = 9788
local BLACKSMITHING_WEAPONSMITH = 9787
local ENCHANTING = 333
local ENGINEERING = 202
local ENGINEERING_GNOMISH = 20219
local ENGINEERING_GOBLIN = 20222
local HERBALISM = 182
local LEATHERWORKING = 165
local LEATHERWORKING_DRAGONSCALE = 10656
local LEATHERWORKING_ELEMENTAL = 10658
local LEATHERWORKING_TRIBAL = 10660
local MINING = 186
local SKINNING = 393
local TAILORING = 197
local TAILORING_MOONCLOTH = 26798
local TAILORING_SHADOWEAVE = 26801
local TAILORING_SPELLFIRE = 26797
local FISHING = 356
local COOKING = 185
local FISTAID = 129

local LEVEL1 = 10
local LEVEL2 = 25
local LEVEL3 = 50
local LEVEL4 = 75
local LEVEL5 = 100
local LEVEL6 = 150

local function between(x, a, b)
    return x >= a and x <= b
end

local function CalcScore(skilllevel, special)
    local score

    if between(skilllevel, 0, 50) then score = LEVEL1 end
    if between(skilllevel, 51, 100) then score = LEVEL2 end
    if between(skilllevel, 101, 150) then score = LEVEL3 end
    if between(skilllevel, 151, 200) then score = LEVEL4 end
    if between(skilllevel, 201, 250) then score = LEVEL5 end
    if between(skilllevel, 251, 300) then score = LEVEL6 end
    if between(skilllevel, 2, 300) then score = score + skilllevel end
    if special then score = score * 2 end

    return score
end

function HCS_ProfessionsScore:UpdateProfessionScore(professionid, skilllevel)

    if professionid == ALCHEMY then 
        HCScore_Character.professions.alchemy = CalcScore(skilllevel, false)
    elseif professionid == ALCHEMY_ELIXIR_MASTER then 
        HCScore_Character.professions.alchemyElixirmaster = CalcScore(skilllevel, true) 
    elseif professionid == ALCHEMY_POTION_MASTER then 
        HCScore_Character.professions.alchemyPotionmaster = CalcScore(skilllevel, true)
    elseif professionid == ALCHEMY_TRANSMUTATION_MASTER then 
        HCScore_Character.professions.alchemy = CalcScore(skilllevel, true)
    elseif professionid == BLACKSMITHING then 
        HCScore_Character.professions.blacksmithing = CalcScore(skilllevel, false)
    elseif professionid == BLACKSMITHING_ARMORSMITH then 
        HCScore_Character.professions.blacksmithingArmorsmith = CalcScore(skilllevel, true)
    elseif professionid == BLACKSMITHING_WEAPONSMITH then 
        HCScore_Character.professions.blacksmithingWeaponsmith = CalcScore(skilllevel, true)
    elseif professionid == ENCHANTING then 
        HCScore_Character.professions.enchanting = CalcScore(skilllevel, false)
    elseif professionid == ENGINEERING then 
        HCScore_Character.professions.engineering = CalcScore(skilllevel, false)
    elseif professionid == ENGINEERING_GNOMISH then 
        HCScore_Character.professions.engineeringGnomish = CalcScore(skilllevel, true)
    elseif professionid == ENGINEERING_GOBLIN then 
        HCScore_Character.professions.engineeringGoblin = CalcScore(skilllevel, true)
    elseif professionid == HERBALISM then 
        HCScore_Character.professions.herbalism = CalcScore(skilllevel, false)
    elseif professionid == LEATHERWORKING then 
        HCScore_Character.professions.leatherworking = CalcScore(skilllevel, false)
    elseif professionid == LEATHERWORKING_DRAGONSCALE then 
        HCScore_Character.professions.leatherworkingDragonscale = CalcScore(skilllevel, true)
    elseif professionid == LEATHERWORKING_ELEMENTAL then 
        HCScore_Character.professions.leatherworkingElemental = CalcScore(skilllevel, true)
    elseif professionid == LEATHERWORKING_TRIBAL then 
        HCScore_Character.professions.leatherworkingTribal = CalcScore(skilllevel, true)
    elseif professionid == MINING then 
        HCScore_Character.professions.mining = CalcScore(skilllevel, false)
    elseif professionid == SKINNING then 
        HCScore_Character.professions.skinning = CalcScore(skilllevel, false)
    elseif professionid == TAILORING then 
        HCScore_Character.professions.tailoring = CalcScore(skilllevel, false)
    elseif professionid == TAILORING_MOONCLOTH then 
        HCScore_Character.professions.tailoringMooncloth = CalcScore(skilllevel, true)
    elseif professionid == TAILORING_SHADOWEAVE then 
        HCScore_Character.professions.tailoringShadoweave = CalcScore(skilllevel, true)
    elseif professionid == TAILORING_SPELLFIRE then 
        HCScore_Character.professions.tailoringSpellfire = CalcScore(skilllevel, true)
    elseif professionid == FISHING then 
        HCScore_Character.professions.fishing = CalcScore(skilllevel, false)
    elseif professionid == COOKING then 
        HCScore_Character.professions.cooking = CalcScore(skilllevel, false)
    elseif professionid == FISTAID then 
        HCScore_Character.professions.firstaid = CalcScore(skilllevel, false)
    end    
end

function HCS_ProfessionsScore:GetScore()
    local char = HCScore_Character.professions
    local score = 0
  
    score = char.alchemy +
            char.alchemyElixirmaster +
            char.alchemyPotionmaster +
            char.alchemyTransmutationmaster +
            char.blacksmithing +
            char.blacksmithingArmorsmith +
            char.blacksmithingWeaponsmith +
            char.cooking +
            char.enchanting +
            char.engineering +
            char.engineeringGnomish +
            char.engineeringGoblin +
            char.firstaid +
            char.fishing +
            char.herbalism +
            char.leatherworking +
            char.leatherworkingDragonscale +
            char.leatherworkingElemental +
            char.leatherworkingTribal +
            char.mining +
            char.skinning +
            char.tailoring +
            char.tailoringMooncloth +
            char.tailoringShadoweave +
            char.tailoringSpellfire

    HCScore_Character.scores.professionsScore = score
end

function HCS_ProfessionsScore:GetNumberOfProfessions()
    local numskills = 0
    for i = 1, GetNumSkillLines() do
        local skillName, isHeader, _, skillRank, _, _, skillMaxRank, _, _, skillLineID = GetSkillLineInfo(i)
        
        print("skillName: "..skillName)        
        
        if not isHeader then
            if skillLineID ~= nil then
                print("skillLineID: "..skillLineID)
                local _, _, _, _, _, _, skillID = GetProfessionInfo(skillLineID)
                
                if skillID then
                    numskills = numskills + 1
                end
            end
        end
    end
    
    return numskills
end