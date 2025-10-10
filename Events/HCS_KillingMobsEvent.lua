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
        local petCharacter = UnitName("pet")

        if playerCharacter == sourceName or petCharacter == sourceName then 
            if (guidType ~= "Player" and guidType ~= "Pet")
            then
                -- When any damage is done by player or player's pet, record the mob
                if (subEvent == "SWING_DAMAGE" or subEvent == "SPELL_DAMAGE" or subEvent == "RANGE_DAMAGE" or subEvent == "SPELL_PERIODIC_DAMAGE")
                then
                    local playerLevel = UnitLevel("player")
                    local targetLevel = UnitLevel("target") or 0
                    -- Treat skull-level (??) targets as +3 difficulty relative to player
                    if targetLevel == -1 then
                        -- For gating purposes only
                        targetLevel = playerLevel + 3
                    end
                    -- If level is unknown (0 or nil), allow processing by assuming equal level for gating
                    local gatingLevel = targetLevel
                    if gatingLevel <= 0 then gatingLevel = playerLevel end
                    local mobDifficulty = gatingLevel - playerLevel

                    if mobDifficulty > -6 then
                        --print("--------- SWING DAMAGE ---------")
                        _G["MobCombatKill"] = true
                        _G["MobName"] = destName
                        -- Store raw level (can be 0 or -1); scoring will normalize when needed
                        _G["MobLevel"] = UnitLevel("target") or 0
                        _G["MobClassification"] = UnitClassification("target")    
                        
                        --print(destName.. " - level ".. _G["MobLevel"].. " ("..guidType..")")
                        --print(sourceName.. " - ".. " ("..sourceType..")")                                                       
                    end  
    
                elseif (subEvent=="PARTY_KILL")
                then

                    local playerLevel = UnitLevel("player")
                    local rawLevel = UnitLevel("target") or 0
                    local gatingLevel = rawLevel
                    if rawLevel == -1 then gatingLevel = playerLevel + 3 end
                    if gatingLevel <= 0 then gatingLevel = playerLevel end
                    local mobDifficulty = gatingLevel - playerLevel

                    if mobDifficulty > -6 then
                        _G["MobCombatKill"] = true
                        _G["MobName"] = destName
                        _G["MobLevel"] = rawLevel or 0                 
                        _G["MobClassification"] = UnitClassification("target")      
        
                        --print("--------- PARTY KILL ---------")
                        --print("MobCombatKill = "..tostring(_G["MobCombatKill"]))
                        --print(destName.. " - level ".. _G["MobLevel"].. " ("..guidType..")")                                
                        -- At Classic max level (60), PLAYER_XP_UPDATE won't fire; process immediately
                        if UnitLevel("player") == 60 and HCS_GameVersion < 30000 then
                            HCS_XPUpdateEvent:UpdateScoresBasedOnEvents()
                        end
                    end      
     
                elseif (subEvent=="UNIT_DIED" and destGUID ~= nil)
                then                                
                    
                    local mobDifficulty = UnitLevel("target") - UnitLevel("player")
                    
                    if mobDifficulty > -6 then
                      --  _G["MobCombatKill"] = true
                      --  _G["MobName"] = destName
                      --  _G["MobLevel"] = UnitLevel("target")
                      --  _G["MobClassification"] = UnitClassification("target")
        
                        --print("--------- UNIT DIED ----------")
                        --print("MobCombatKill = "..tostring(_G["MobCombatKill"]))
                        --print(destName.. " - level ".. _G["MobLevel"].. " ("..guidType..")")                                                    
                      --  if UnitLevel("player") == 60 then HCS_XPUpdateEvent:UpdateScoresBasedOnEvents() end
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

