PlayerCompletingQuest = {}

local TRIVAL = 0 -- grey
local EASY = 1 -- green
local MODERATE = 2 -- yellow
local HARD = 3 -- orange
local VERYHARD = 5 -- red
local score = 0


-- create a frame to handle events
local _playercompletingquest = CreateFrame("Frame")

-- register for the QUEST_TURNED_IN event
_playercompletingquest:RegisterEvent("QUEST_TURNED_IN")

local function OnQuestTurnedIn(event, questEvent, questID, xpReward, moneyReward)
  -- find the completed quest in the quest log
  print("processing turned in quest.  questEvent: "..questEvent.." questID: "..questID.. " xpReward: "..xpReward, " moneyReward: ".. moneyReward)

  for i = 1, GetNumQuestLogEntries() do
    local title, _, _, _, isComplete = GetQuestLogTitle(i)
    
    if isComplete and GetQuestID(i) == questEvent then
      -- get the quest rewards
     -- local numRewards = GetNumQuestRewards()
     -- local numChoices = GetNumQuestChoices()
     -- local rewards = {}
      
      -- get difficulty
      --local questDifficulty, questDifficultyColor = GetQuestDifficultyColor(questLevel)

      print("processing quest: "..questID)
      local questLevel = select(2, GetQuestLogInfo(questEvent))

      if questLevel ==  1 then
        score = 0
      end
      if questLevel == 2 then 
        score = EASY + (xpReward * 0.1)         
      end
      if questLevel == 3 then
        score = MODERATE + (xpReward * 0.15)
      end
      if questLevel == 4 then
        score = HARD + (xpReward * 0.25)
      end
      if questLevel == 5 then
        score = VERYHARD + (xpReward * 0.50)
      end


      --local r, g, b, a = GetQuestDifficultyColor(questLevel)


      --for j = 1, numRewards do
      --  local itemName, _, _, _, _, _, _, _, _, itemTexture = GetQuestLogRewardInfo(j)
      --  rewards[#rewards + 1] = "|T" .. itemTexture .. ":0|t " .. itemName
      --end
      
      --if numChoices > 0 then
      --  rewards[#rewards + 1] = numChoices .. " choices"
      --end
      
      
      -- print the quest information
      print("Turned in quest: " .. title .. " - Level: "..questLevel..", Points: "..score)
      break
    end
  end
  PlayerQuestingScore:UpdateQuestingScore(score, questID)
  Scoreboard.UpdateUI(nil)
  print("executed _playercompletingquest code")
end


-- set the event handler function for the myFrame
_playercompletingquest:SetScript("OnEvent", OnQuestTurnedIn)

--------------------------------------------------------------

--[[
local function OnQuestTurnedIn(event, questID, xpReward, moneyReward)
  -- find the completed quest in the quest log
  for i = 1, GetNumQuestLogEntries() do
    local title, _, _, _, isComplete, _, _, questID = GetQuestLogTitle(i)

    if isComplete and GetQuestID(i) == questID then
      -- get the quest difficulty
      local questDifficulty, questDifficultyColor = GetQuestDifficultyColor(questLevel)

      -- print the quest information
      print("Turned in quest: " .. title .. " - Difficulty: " .. questDifficulty .. " (" .. questDifficultyColor.r .. ", " .. questDifficultyColor.g .. ", " .. questDifficultyColor.b .. ")")
      break
    end
  end
end

local function OnQuestTurnIn()
  local xpReward = GetRewardXP()
  print("You received " .. xpReward .. " experience points.")
end

-- Register for the QUEST_TURNED_IN event
local frame = CreateFrame("Frame")
frame:RegisterEvent("QUEST_TURNED_IN")
frame:SetScript("OnEvent", OnQuestTurnIn)
]]
