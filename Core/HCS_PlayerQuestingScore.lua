HCS_PlayerQuestingScore = {}

function HCS_PlayerQuestingScore:UpdateQuestingScore(score, questId, xpReward, levelMod)
    local currentscore = HCScore_Character.scores.questingScore
    
    -- define the new quest
    local newQuest = {
        id = questId,
        points = score,
        xp = xpReward,
        difficulty = levelMod,               
    }

    table.insert(HCScore_Character.quests, newQuest)
    _G["ScoringDescriptions"].questingScore = "Completed Quest"
    HCS_CalculateScore:RefreshScores(ScoringDescriptions)
end

function HCS_PlayerQuestingScore:GetNumberOfQuests()
    return #HCScore_Character.quests
end

function HCS_PlayerQuestingScore:GetQuestingScore()
    local score = 0

    for _, quest in pairs(HCScore_Character.quests) do
        score = score + quest.points
    end

    return score
end
