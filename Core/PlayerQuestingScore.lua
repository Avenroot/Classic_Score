PlayerQuestingScore = {}

--[[
function PlayerQuestingScore:GetQuestingScore ()

    return 150
    
end
]]

function PlayerQuestingScore:UpdateQuestingScore(score, questId)
    local currentscore = HCScore_Character.scores.questingScore
    HCScore_Character.scores.questingScore = currentscore + score

    -- add a quest 
end

