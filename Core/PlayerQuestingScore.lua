PlayerQuestingScore = {}

function PlayerQuestingScore:UpdateQuestingScore(score, questId, xpReward, levelMod)
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

end

