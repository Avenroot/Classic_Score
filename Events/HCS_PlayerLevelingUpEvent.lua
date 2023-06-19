HCS_PlayerLevelingUpEvent = {}

-- create a frame to handle events
local _HCS_PlayerLevelingUpEvent = CreateFrame("Frame")

-- register for the PLAYER_LEVEL_UP event
_HCS_PlayerLevelingUpEvent:RegisterEvent("PLAYER_LEVEL_UP")

local function OnPlayerLevelUp(event, arg1, arg2, arg3, arg4)
  HCS_CalculateScore:RefreshScores()  
end

-- set the event handler function for the myFrame
_HCS_PlayerLevelingUpEvent:SetScript("OnEvent", OnPlayerLevelUp)
