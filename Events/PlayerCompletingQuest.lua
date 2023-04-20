PlayerCompletingQuest = {}

local TRIVAL = 0 -- grey
local EASY = 0.025 -- green
local MODERATE = 0.0375 -- yellow
local HARD = 0.075 -- orange
local VERYHARD = 0.125 -- red
local score = 0
local questLevel
local playerLevel
local levelMod

-- create a frame to handle events
local _playercompletingquest = CreateFrame("Frame")

-- register for the QUEST_TURNED_IN event
_playercompletingquest:RegisterEvent("QUEST_TURNED_IN")

local function between(x, a, b)
  return x >= a and x <= b
end

local function OnQuestTurnedIn(event, questEvent, questID, xpReward, moneyReward)
--  print("questID "..questID)
--  print("xpReward "..xpReward)
--  print("moneyReward "..moneyReward)

  questLevel = select(2, GetQuestLogTitle(GetQuestLogIndexByID(questID)))
  playerLevel = UnitLevel("player")
 
  levelMod = questLevel - playerLevel
  
  -- grey
  if levelMod <= -6 then
    score = 0
  end
  -- green
  if between(levelMod, -5, -1) then
    score =  xpReward * EASY         
  end 
  -- yellow
  if between(levelMod, 0, 4) then
    score = xpReward * MODERATE    
  end
  -- orange
  if between(levelMod, 5, 9) then
    score = xpReward * HARD
  end
  -- red
  if levelMod > 9 then
    score =  xpReward * VERYHARD
  end
  
  print("score: "..score.. " levelmod: "..levelMod.. " player level: "..playerLevel.. " quest level: "..questLevel)

  PlayerQuestingScore:UpdateQuestingScore(score, questID, xpReward, levelMod)
  Scoreboard.UpdateUI(nil)

end

-- set the event handler function for the myFrame
_playercompletingquest:SetScript("OnEvent", OnQuestTurnedIn)
--------------------------------------------------------------

