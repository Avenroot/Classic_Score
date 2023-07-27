HCS_PlayerCompletingQuestEvent = {}

local TRIVAL = 0 -- grey
local EASY = 0.001 -- green
local MODERATE = 0.002 -- yellow
local HARD = 0.0035 -- orange
local VERYHARD = 0.005 -- red

local score = 0
local questLevel
local playerLevel
local levelMod


-- create a frame to handle events
local _HCS_PlayerCompletingQuestEvent = CreateFrame("Frame")

-- register for the QUEST_TURNED_IN event
_HCS_PlayerCompletingQuestEvent:RegisterEvent("QUEST_TURNED_IN")

local function between(x, a, b)
  return x >= a and x <= b
end

local function OnQuestTurnedIn(event, questEvent, questID, xpReward, moneyReward)

-- a hack for Discovery until I can figure out how to detect if any xp is gained by entering a new zone.
  _G["ZoneChanged"] = false

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

  HCS_PlayerQuestingScore:UpdateQuestingScore(score, questID, xpReward, levelMod)

end

function HCS_PlayerCompletingQuestEvent:RecalculateQuests()

  --print("Recalculating Quests")
  for _, quest in pairs(HCScore_Character.quests) do
    -- grey
    if quest.difficulty <= -6 then
      quest.points = 0
    end
    -- green
    if between(quest.difficulty, -5, -1) then
      quest.points =  quest.xp * EASY         
    end 
    -- yellow
    if between(quest.difficulty, 0, 4) then
      quest.points = quest.xp * MODERATE    
    end
    -- orange
    if between(quest.difficulty, 5, 9) then
      quest.points = quest.xp * HARD
    end
    -- red
    if quest.difficulty > 9 then
      quest.points =  quest.xp * VERYHARD
    end
  end

end

-- set the event handler function for the myFrame
_HCS_PlayerCompletingQuestEvent:SetScript("OnEvent", OnQuestTurnedIn)
--------------------------------------------------------------

