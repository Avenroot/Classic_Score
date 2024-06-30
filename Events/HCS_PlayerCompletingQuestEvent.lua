HCS_PlayerCompletingQuestEvent = {}

local multipliers = {
  [-6] = 0.0000,
  [-5] = 0.0010,  -- Easy (green)
  [-4] = 0.0012,
  [-3] = 0.0014,
  [-2] = 0.0016,
  [-1] = 0.0018,
  [0]  = 0.0020,
  [1]  = 0.0023,
  [2]  = 0.0025,
  [3]  = 0.0027,
  [4]  = 0.0029,
  [5]  = 0.0031,
  [6]  = 0.0035,  -- Very Hard (red)
}


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

  playerLevel = UnitLevel("player")

  local questIndex = GetQuestLogIndexByID(questID)
  questLevel = questIndex and select(2, GetQuestLogTitle(questIndex)) or nil

  if not questLevel or questLevel == 0 then
      questLevel = playerLevel  -- Handles nil or 0 level quests, assuming playerLevel is defined
  end

  levelMod = questLevel - playerLevel

  -- Set the XP reward based on the player's level and game version
  if HCS_GameVersion < 30000 then
    -- Classic version
    if playerLevel == 60 then
        xpReward = 1000
    end
  elseif HCS_SODVersion == true then
    -- Classic - Season of Discovery
    if playerLevel == 25 and xpReward == 0 then 
        xpReward = math.random(50, 150)
    end
  elseif HCS_GameVersion >= 30000 then
    -- Cataclysm
    if playerLevel == 85 then
        xpReward = 1200
    end
  end

    -- Look up the multiplier and apply it to the score.
  if multipliers[levelMod] then
      score = xpReward * multipliers[levelMod] 
  elseif levelMod > 6 then
      score = xpReward * multipliers[6] 
  elseif levelMod < -6 then
      score = xpReward * multipliers[-6] 
  end

  HCS_PlayerQuestingScore:UpdateQuestingScore(score, questID, xpReward, levelMod)

end

function HCS_PlayerCompletingQuestEvent:RecalculateQuests()

  --print("Recalculating Quests")
  for _, quest in pairs(HCScore_Character.quests) do

    -- Look up the multiplier and apply it to the score.
    if multipliers[quest.difficulty ] then
      quest.points =  quest.xp * multipliers[quest.difficulty ] 
    elseif quest.difficulty  > 6 then
      quest.points =  quest.xp * multipliers[6] 
    elseif quest.difficulty  < -6 then
      quest.points =  quest.xp * multipliers[-6] 
    end

  end

end

-- set the event handler function for the myFrame
_HCS_PlayerCompletingQuestEvent:SetScript("OnEvent", OnQuestTurnedIn)
--------------------------------------------------------------

