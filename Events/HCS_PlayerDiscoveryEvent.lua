HCS_PlayerDiscoveryEvent = {}


function CheckZoneStatus()
    print("Zone changed to ".. GetZoneText())
    print("Subzone - ".. GetSubZoneText())
    print("Map id -".. C_Map.GetBestMapForUnit("player"))

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

    zoneChanged = not found
    print("Zone changed = "..tostring(zoneChanged))  
    _G["ZoneChanged"] = zoneChanged;  
end

local _playerdiscovery3 = CreateFrame("Frame")
_playerdiscovery3:RegisterEvent("ZONE_CHANGED_NEW_AREA")
_playerdiscovery3:SetScript("OnEvent", function (self, event, ...)

    print("----- ZONE_CHANGED_NEW_AREA -----")
    CheckZoneStatus()
end)

local _playerdiscovery2 = CreateFrame("Frame")
_playerdiscovery2:RegisterEvent("ZONE_CHANGED")
_playerdiscovery2:SetScript("OnEvent", function (self, event, ...)

    print("----- ZONE_CHANGED -----")
    CheckZoneStatus()
end)