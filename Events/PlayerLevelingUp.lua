PlayerLevelingUp = {}

-- create a frame to handle events
local _playerlevelingup = CreateFrame("Frame")

-- register for the PLAYER_LEVEL_UP event
_playerlevelingup:RegisterEvent("PLAYER_LEVEL_UP")

local function OnPlayerLevelUp(event, arg1, arg2, arg3, arg4)
  Scoreboard.UpdateUI(nil)
  --print("executed _playerlevelingup code")
end

-- set the event handler function for the myFrame
_playerlevelingup:SetScript("OnEvent", OnPlayerLevelUp)
