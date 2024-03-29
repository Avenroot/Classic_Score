HCS_PlayerDiscoveryEvent = {}


function CheckZoneStatus()

    local mapID = C_Map.GetBestMapForUnit("player")
    local newZone = GetZoneText()
    local newSubzone = GetSubZoneText()
    local zoneChanged = _G["ZoneChanged"]

    local found = false

    if HCScore_Character.discovery == nil then
        HCScore_Character.discovery = {}
    end
    for _, map in pairs(HCScore_Character.discovery) do
        if map.zone == newZone and map.subzone == newSubzone then
            found = true
            break
        end
    end

    if not found then

        if UnitLevel("player") == 60 then 
            HCS_DiscoveryScore:UpdateDiscoveryScore()
        else
            local xpGained = HCS_XPUpdateEvent:GetXPGain()
        end

        if xpGained == 0 then
            
            local newxp = 1.2
            
            local newDiscovery = {
                mapID = mapID,
                zone = newZone,
                subzone = newSubzone,
                xp = newxp,
                xpZone = false,
            }

            table.insert(HCScore_Character.discovery, newDiscovery)
            --HCScore_Character.scores.discoveryScore = HCScore_Character.scores.discoveryScore + newxp
            _G["ScoringDescriptions"].discoveryScore = "Discovery"
            HCS_CalculateScore:RefreshScores(ScoringDescriptions)
        end
    end

    zoneChanged = not found
    _G["ZoneChanged"] = zoneChanged;  
end

local _playerdiscovery3 = CreateFrame("Frame")
_playerdiscovery3:RegisterEvent("ZONE_CHANGED_NEW_AREA")
_playerdiscovery3:SetScript("OnEvent", function (self, event, ...)

     CheckZoneStatus()
end)

local _playerdiscovery2 = CreateFrame("Frame")
_playerdiscovery2:RegisterEvent("ZONE_CHANGED")
_playerdiscovery2:SetScript("OnEvent", function (self, event, ...)

     CheckZoneStatus()
end)