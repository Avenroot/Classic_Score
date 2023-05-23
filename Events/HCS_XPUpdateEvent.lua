HCS_XPUpdateEvent = {}

function HCS_XPUpdateEvent:GetXPGain()
    local currentXP = _G["CurrentXP"]
    local newXP = UnitXP("player")
    local xpGain = newXP - currentXP
    if xpGain < 0 then
        xpGain = (_G["CurrentMaxXP"] - currentXP) + newXP 
    end
    _G["CurrentXP"] = newXP
    print("xp gained: "..xpGain)
    return xpGain
end


local _xpupdate_event = CreateFrame("Frame")
_xpupdate_event:RegisterEvent("PLAYER_XP_UPDATE")
_xpupdate_event:SetScript("OnEvent", function(event, ...)

    local mobCombatKill = _G["MobCombatKill"]
    local zoneChanged = _G["ZoneChanged"]
    local mobName = _G["MobName"]
    local mobLevel = _G["MobLevel"]
    
    print("----- PLAYER_XP_UPDATE -----")
    print("MobCombatKill = "..tostring(mobCombatKill))
    print("ZoneChanged = "..tostring(zoneChanged))

    if mobCombatKill == true then
        print("----- PLAYER_XP_UPDATE - MOB KILL -----")
        HCS_KillingMobsScore:UpdateMobsKilled()
        mobCombatKill = false
        mobName = ""
        mobLevel = 0
        
        -- a hack for Discovery until I can figure out how to detect if any xp is gained by entering a new zone.
        zoneChanged = false 
    end    

    print("ZoneChanged = "..tostring(zoneChanged))
    if zoneChanged == true then       
        print("----- PLAYER_XP_UPDATE - ZONE CHANGED -----")
        HCS_DiscoverScore:UpdateDiscoveryScore()
        zoneChanged = false
    end
   
    Scoreboard:UpdateUI()

    print("MobCombatKill = "..tostring(mobCombatKill))
    print("ZoneChanged = "..tostring(zoneChanged))
    _G["MobCombatKill"] = mobCombatKill
    _G["ZoneChanged"] = zoneChanged
    _G["MobName"] = mobName
    _G["MobLevel"] = mobLevel

    print("Out XP Update")
    
end)
