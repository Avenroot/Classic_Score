HCS_PlayerQuestingScore = {}

function HCS_PlayerQuestingScore:UpdateQuestingScore(score, questId, xpReward, levelMod)
    local currentscore = HCScore_Character.scores.questingScore
    
    HCScore_Character.scores.questingScore = currentscore + score

    -- define the new quest
    local newQuest = {
        id = questId,
        points = score,
        xp = xpReward,
        difficulty = levelMod,               
    }

    table.insert(HCScore_Character.quests, newQuest)

    HCS_CalculateScore:RefreshScores()
end

function HCS_PlayerQuestingScore:GetNumberOfQuests()
    return #HCScore_Character.quests
end

function HCS_PlayerQuestingScore:GetQuestingScore()
    return HCScore_Character.scores.questingScore
end
