HCS_KillingMobsEvent = {}

-- This function will be called when a combat event is triggered
function OnCombatEvent(_, event, _, sourceGUID, _, _, _, destGUID, destName, _, _, _, spellID)
    	local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName,
            destFlags, destRaidFlags, damage_spellid, overkill_spellname, school_spellSchool, resisted_amount, blocked_overkill = CombatLogGetCurrentEventInfo()
   -- local   _, event, _, sourceGUID, _, _, _, destGUID, destName, _, _, _, spellID = CombatLogGetCurrentEventInfo()

    if destGUID ~= nil and sourceGUID ~= nil
    then
        local guidType = select(1,strsplit("-", destGUID))
        local sourceType = select(1,strsplit("-", sourceGUID))
        local playerCharacter = HCScore_Character.name

        if playerCharacter == sourceName then
            if (guidType ~= "Player" and guidType ~= "Pet")
            then
                -- When any damage is done by player or player's pet, record the mob
                if (subEvent == "SWING_DAMAGE" or subEvent == "SPELL_DAMAGE")
                then
                    local mobDifficulty = UnitLevel("target") - UnitLevel("player")

                    if mobDifficulty > -6 then
                       -- print("--------- SWING DAMAGE ---------")
                        _G["MobCombatKill"] = true
                        _G["MobName"] = destName
                        _G["MobLevel"] = UnitLevel("target")    
                        
                       -- print(destName.. " - level ".. _G["MobLevel"].. " ("..guidType..")")
                       -- print(sourceName.. " - ".. " ("..sourceType..")")                                                       
                    end  
    
                elseif (subEvent=="PARTY_KILL")
                then

                    local mobDifficulty = UnitLevel("target") - UnitLevel("player")

                    if mobDifficulty > -6 then
                        _G["MobCombatKill"] = true
                        _G["MobName"] = destName
                        _G["MobLevel"] = UnitLevel("target")                        
        
                       -- print("--------- PARTY KILL ---------")
                       -- print("MobCombatKill = "..tostring(_G["MobCombatKill"]))
                       -- print(destName.. " - level ".. _G["MobLevel"].. " ("..guidType..")")                                
                    end      
     
                elseif (subEvent=="UNIT_DIED" and destGUID ~= nil)
                then                                
                    
                    local mobDifficulty = UnitLevel("target") - UnitLevel("player")
                    
                    if mobDifficulty > -6 then
                        _G["MobCombatKill"] = true
                        _G["MobName"] = destName
                        _G["MobLevel"] = UnitLevel("target")
        
                       -- print("--------- UNIT DIED ----------")
                       -- print("MobCombatKill = "..tostring(_G["MobCombatKill"]))
                       -- print(destName.. " - level ".. _G["MobLevel"].. " ("..guidType..")")                                                    
                    end
                end
            end  
        end
    end
end

-- Register the OnCombatEvent function to be called when a combat event is triggered
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", OnCombatEvent)

