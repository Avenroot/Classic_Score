PlayerQuestingScore = {}

--[[
function PlayerQuestingScore:GetQuestingScore ()

    return 150
    
end
]]

function PlayerQuestingScore:UpdateQuestingScore(score, questId, xpReward, levelMod)
    local currentscore = HCScore_Character.scores.questingScore
    
    HCScore_Character.scores.questingScore = currentscore + score

    -- define the new quest
    local newQuest = {
        id = questId,
        difficulty = levelMod,
        xp = xpReward,
        point = score
    }

    table.insert(HCScore_Character.quests, newQuest)

end

