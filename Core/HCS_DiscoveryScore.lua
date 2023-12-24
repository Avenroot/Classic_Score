HCS_DiscoveryScore = {}

function HCS_DiscoveryScore:UpdateDiscoveryScore()
    local mapID = C_Map.GetBestMapForUnit("player")
    local newZone = GetZoneText()
    local newSubzone = GetSubZoneText()
    local zoneChanged = _G["ZoneChanged"]
    local found = false
    local xpGained = 0

    if zoneChanged == true then
        
        -- Initialize xpGained with the default method
        xpGained = HCS_XPUpdateEvent:GetXPGain()

        -- Modify the XP gained based on player's level and game version
        if HCS_GameVersion < 30000 and UnitLevel("player") == 60 then
            xpGained = 150
        elseif HCS_SODVersion == true and UnitLevel("player") == 25 then  -- Current level 25 for Season of Discovery
            xpGained = math.random(10, 50)
        elseif HCS_GameVersion >= 30000 and UnitLevel("player") == 80 then
            xpGained = 250
        end

        if xpGained > 0 then
  
            --print("Experience gained in", newZone, ":", xpGained)
            local newxp = xpGained * 0.012

            for _, map in pairs(HCScore_Character.discovery) do
                if map.zone == newZone and map.subzone == newSubzone then
                    found = true
                    map.xp = map.xp + newxp
                    map.xpZone = true
                    break
                end
            end            
           
            if not found then
                local newDiscovery = {
                    mapID = mapID,
                    zone = newZone,
                    subzone = newSubzone,
                    xp = newxp,
                    xpZone = true,
                }
    
                table.insert(HCScore_Character.discovery, newDiscovery)                    
            end

            --HCScore_Character.scores.discoveryScore = HCScore_Character.scores.discoveryScore + newxp
            _G["ScoringDescriptions"].discoveryScore = "Discovery"
            HCS_CalculateScore:RefreshScores(ScoringDescriptions)
        end 
    end
end

function HCS_DiscoveryScore:GetNumberOfDiscovery()
--    if HCScore_Character.discovery == nil then HCScore_Character.discovery = {} end
    return #HCScore_Character.discovery
end

function  HCS_DiscoveryScore:GetDiscoveryScore()
    local score = 0
    
    for _, map in pairs(HCScore_Character.discovery) do
        score = score + map.xp
    end
    
    return score
end