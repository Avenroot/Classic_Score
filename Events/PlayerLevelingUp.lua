PlayerLevelingUp = {}

-- create a frame to handle events
local _playerlevelingup = CreateFrame("Frame")

-- register for the PLAYER_LEVEL_UP event
_playerlevelingup:RegisterEvent("PLAYER_LEVEL_UP")

-- event handler function for the PLAYER_LEVEL_UP event
local function OnPlayerLevelUp(event, arg1, arg2, arg3, arg4)
  -- get the player's new level
  -- local level = arg1
  
  Scoreboard.UpdateUI(nil)

  print("executed _playerlevelingup code")
end

-- set the event handler function for the myFrame
_playerlevelingup:SetScript("OnEvent", OnPlayerLevelUp)
