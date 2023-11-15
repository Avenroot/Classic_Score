HCS_XPUpdateEvent = {}

function HCS_XPUpdateEvent:GetXPGain()
    
    local currentXP = _G["CurrentXP"]
    local newXP = UnitXP("player")
    local xpGain = newXP - currentXP
    if xpGain < 0 then
        xpGain = (_G["CurrentMaxXP"] - currentXP) + newXP 
    end
    _G["CurrentXP"] = newXP

    return xpGain
end

function HCS_XPUpdateEvent:UpdateScoresBasedOnEvents()
    local mobCombatKill = _G["MobCombatKill"]
    local zoneChanged = _G["ZoneChanged"]
    local mobName = _G["MobName"]
    local mobLevel = _G["MobLevel"]
    local mobClassification = _G["MobClassification"]
    
    if mobCombatKill == true then
        --print("In MobCombatKill" )
        HCS_KillingMobsScore:UpdateMobsKilled()
        mobCombatKill = false
        mobName = ""
        mobLevel = 0
        mobClassification = ""
        
        -- a hack for Discovery until I can figure out how to detect if any xp is gained by entering a new zone.
        zoneChanged = false 
    end    

    if zoneChanged == true then       
        HCS_DiscoveryScore:UpdateDiscoveryScore()
        zoneChanged = false
    end

    _G["MobCombatKill"] = mobCombatKill
    _G["ZoneChanged"] = zoneChanged
    _G["MobName"] = mobName
    _G["MobLevel"] = mobLevel
    _G["MobClassification"] = mobClassification
end

local _xpupdate_event = CreateFrame("Frame")
_xpupdate_event:RegisterEvent("PLAYER_XP_UPDATE")
_xpupdate_event:SetScript("OnEvent", function(event, ...)
    HCS_XPUpdateEvent:UpdateScoresBasedOnEvents()
end)

