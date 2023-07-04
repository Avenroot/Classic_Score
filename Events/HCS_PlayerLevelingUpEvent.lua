HCS_PlayerLevelingUpEvent = {}

-- create a frame to handle events
local _HCS_PlayerLevelingUpEvent = CreateFrame("Frame")

-- register for the PLAYER_LEVEL_UP event
_HCS_PlayerLevelingUpEvent:RegisterEvent("PLAYER_LEVEL_UP")

local function OnPlayerLevelUp(event, arg1, arg2, arg3, arg4)
  PlayerLeveled = true
end

_HCS_PlayerLevelingUpEvent:SetScript("OnEvent", function(self, event, ...)
  if event == "PLAYER_LEVEL_UP" then
      OnPlayerLevelUp(...)
  end
end)

