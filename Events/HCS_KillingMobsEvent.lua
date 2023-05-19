HCS_KillingMobsEvent = {}
local targetInfo = {}

function GetXPGain()
    local newXP = UnitXP("player")
    local xpGain = newXP - CurrentXP
    if xpGain < 0 then
        xpGain = (CurrentMaxXP - CurrentXP) + newXP 
    end
    CurrentXP = newXP
    print("xp gained: "..xpGain)
    return xpGain
end

function GetMobKillHCScore()
    local xpGain = GetXPGain()
    local score = xpGain * 0.005
    return score    
end

-- This function will be called when the player targets a new mob
function OnTargetChanged()
    if UnitExists("target") then
        -- Save the target's information to the targetInfo table
        targetInfo.name = UnitName("target")
        targetInfo.level = UnitLevel("target")
        targetInfo.id = UnitGUID("target")
        targetInfo.rarity = UnitClassification("target")
        print("Saved target")
        print("targetInfo.name: ".. targetInfo.name)
        print("targetInfo.level: ".. targetInfo.level)
        print("targetInfo.id: ".. targetInfo.id)
        print("targetInfo.rarity: ".. targetInfo.rarity)
    else
        -- Clear the targetInfo table if the player has no target
        wipe(targetInfo)
    end
end

-- Register the OnTargetChanged function to be called when the player targets a new unit
local frame = CreateFrame("FRAME")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
--frame:SetScript("OnEvent", OnTargetChanged)

-- This function will be called when a combat event is triggered
function OnCombatEvent(_, event, _, sourceGUID, _, _, _, destGUID, destName, _, _, _, spellID)
    	local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName,
            destFlags, destRaidFlags, damage_spellid, overkill_spellname, school_spellSchool, resisted_amount, blocked_overkill = CombatLogGetCurrentEventInfo()
   -- local   _, event, _, sourceGUID, _, _, _, destGUID, destName, _, _, _, spellID = CombatLogGetCurrentEventInfo()

    if destGUID ~= nil
    then
        local guidType = select(1,strsplit("-", destGUID))
        if (guidType ~= "Player" and guidType ~= "Pet")
        then
            -- When any damage is done by player or player's pet, record the mob
            if (subEvent == "SWING_DAMAGE" or subEvent == "SPELL_DAMAGE")
            then
                MobCombatKill = false
                MobName = ""
            elseif (subEvent=="PARTY_KILL")
            then
                MobCombatKill = true
                MobName = destName

                print(MobCombatKill)
                print(destName)

            elseif (subEvent=="UNIT_DIED" and destGUID ~= nil)
            then
                --MobCombatKill = true
                --MobName = destName
                --print(MobCombatKill)
                --print(destName)

            end
        end
    end
end
--[[
    if event == "PARTY_KILL" and (sourceGUID == UnitGUID("player") or sourceGUID == UnitGUID("pet")) then

--        local xpGain = GetXPGain()
--        print("You gained " .. xpGain .. " experience.")
--        local xp = UnitXP("player")
--        print("current xp: "..xp)


        local mobName = destName

        print("mobName="..mobName)

        MobCombatKill = true


        -- Loop through the targetInfo table to find a matching ID
        for id, info in pairs(targetInfo) do
            print("id: "..id.."destGUID: "..destGUID)
            if id == destGUID then
                -- We found a matching ID, so we can use the saved targetInfo to get its information
                local name = info.name
                local level = info.level
                local rarity = info.rarity

                -- Do something with the mob info here
               -- print(name .. " (level " .. level .. ", " .. rarity .. ") was killed.")
                break
            end
        end
    end
]]
-- Register the OnCombatEvent function to be called when a combat event is triggered
local frame2 = CreateFrame("Frame")
frame2:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame2:SetScript("OnEvent", OnCombatEvent)

local frame3 = CreateFrame("Frame")
frame3:RegisterEvent("PLAYER_XP_UPDATE")
frame3:SetScript("OnEvent", function(event, ...)

    print("In XP Update")
    print(MobCombatKill)

    if MobCombatKill == true then
        local mobScore = GetMobKillHCScore()
        HCS_KillingMobsScore:UpdateMobsKilled(mobScore, MobName)
        print("Points for killing mob:", mobScore)
        MobCombatKill = false
        MobName = ""
    end    

    Scoreboard.UpdateUI(nil)
    
end)

--if eventType == "PARTY_KILL" and sourceGUID == UnitGUID("player") and bit.band(destFlags, COMBATLOG_OBJECT_TYPE_NPC) ~= 0 then