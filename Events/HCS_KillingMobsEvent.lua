HCS_KillingMobsEvent = {}
local targetInfo = {}

function GetXPGain()
    local newXP = UnitXP("player")
    local xpGain = newXP - CurrentXP
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
function OnCombatEvent(_, event, _, sourceGUID, _, _, _, destGUID, _, _, _, _, spellID)
    local   _, event, _, sourceGUID, _, _, _, destGUID, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()

    if event == "PARTY_KILL" and sourceGUID == UnitGUID("player") then

--        local xpGain = GetXPGain()
--        print("You gained " .. xpGain .. " experience.")
--        local xp = UnitXP("player")
--        print("current xp: "..xp)
        
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
end

-- Register the OnCombatEvent function to be called when a combat event is triggered
local frame2 = CreateFrame("FRAME")
frame2:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame2:SetScript("OnEvent", OnCombatEvent)

local frame3 = CreateFrame("Frame")
frame3:RegisterEvent("PLAYER_XP_UPDATE")
frame3:SetScript("OnEvent", function(event, ...)
    
    local type, amount, total = ...

    if MobCombatKill == true then
        local mobScore = GetMobKillHCScore()
        HCS_KillingMobsScore:UpdateMobsKilled(mobScore)
        print("Points for killing mob:", mobScore)
        MobCombatKill = false
    end    

    Scoreboard.UpdateUI(nil)
    
end)

--if eventType == "PARTY_KILL" and sourceGUID == UnitGUID("player") and bit.band(destFlags, COMBATLOG_OBJECT_TYPE_NPC) ~= 0 then