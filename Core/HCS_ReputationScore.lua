HCS_ReputationScore = {}

-- bonus for reaching a level of rep status.  1% of rep paltoo
local NEUTRAL_BONUS = 0
local FRIENDLY_BONUS = 30 -- 30
local HONORED_BONUS = 90 -- 60 added
local REVERED_BONUS = 210 --120 added
local EXALTED_BONUS = 420 -- 210 added
local NEUTRAL = 4
local FRIENDLY = 5
local HONORED = 6
local REVERED = 7
local EXALTED = 8

local function CalcScore(repEarned, standing)
    local score = 0
    score = repEarned * 0.01

    if standing == NEUTRAL then 
        score = score + NEUTRAL_BONUS
    elseif standing == FRIENDLY then
        score = score + FRIENDLY_BONUS
    elseif standing == HONORED then
        score = score + HONORED_BONUS
    elseif standing == REVERED then
        score = score + REVERED_BONUS
    elseif standing == EXALTED then
        score = score + EXALTED_BONUS        
    end

    return score
end

function HCS_ReputationScore:UpdateRepScore()
    local repScore = 0
    local calcScore = 0

    for factionIndex = 1, GetNumFactions() do
        local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar,
            isHeader, isCollapsed, hasRep, isWatched, isChild, factionID = GetFactionInfo(factionIndex)
        if hasRep or not isHeader then

            calcScore = CalcScore(earnedValue, standingId)
            repScore = repScore + calcScore

            if not HCScore_Character.reputations then
                HCScore_Character.reputations = {}  -- Create an empty table
            end

            local found = false

            for _, faction in pairs(HCScore_Character.reputations) do
                if faction.id == factionID then
                    faction.score = calcScore
                    found = true
                    break
                end
            end

            if not found then
                -- add faction details
                local newFaction = {
                    id = factionID,
                    points = earnedValue,
                    standing = standingId,
                    fname = name,
                    desc = description,
                    score = calcScore
                }
                table.insert(HCScore_Character.reputations, newFaction)
            end

            --  DEFAULT_CHAT_FRAME:AddMessage("Faction: " .. name .. " - " .. earnedValue.." StandingID: "..standingId .. " Score: ".. CalcScore(earnedValue, standingId))
        end        
    end
    return repScore
end

function HCS_ReputationScore:GetNumFactions()
  return #HCScore_Character.reputations
end

function HCS_ReputationScore:GetReputationScore()    
    local score =  HCS_ReputationScore:UpdateRepScore()
    return score
end