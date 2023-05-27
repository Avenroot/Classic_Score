HCS_DiscoveryScore = {}

function HCS_DiscoveryScore:UpdateDiscoveryScore()
    local mapID = C_Map.GetBestMapForUnit("player")
    local newZone = GetZoneText()
    local newSubzone = GetSubZoneText()
    local zoneChanged = _G["ZoneChanged"]

    if zoneChanged == true then
        
        local xpGained = HCS_XPUpdateEvent:GetXPGain()

        if xpGained > 0 then
  
            print("Experience gained in", newZone, ":", xpGained)
            local newxp = xpGained * 0.01
            
            local newDiscovery = {
                mapID = mapID,
                zone = newZone,
                subzone = newSubzone,
                xp = newxp,
            }

            table.insert(HCScore_Character.discovery, newDiscovery)
            HCScore_Character.scores.discoveryScore = HCScore_Character.scores.discoveryScore + newxp
        end 
    end
end

function HCS_DiscoveryScore:GetNumberOfDiscovery()
--    if HCScore_Character.discovery == nil then HCScore_Character.discovery = {} end
    return #HCScore_Character.discovery
end
