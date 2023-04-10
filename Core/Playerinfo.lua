PlayerInfo = {}

function PlayerInfo:GetPlayerInfo()


        local name = UnitName("player")
        local class = UnitClass("player")
        local info =  name.. " (".. class..")"  --.." Score"

        return info
end

function PlayerInfo:GetTotalScore()        
        local total = PlayerCoreScore.GetCoreScore(self)
        return total
end

function PlayerInfo:GetHCAchievementScore()
        local score = 0
        return score;        
end

function PlayerInfo:GetTimeBonusScore()
        local score = 0
        return score
end

function PlayerInfo:GetGearBonus()
        local score = 0
        return score
end

--[[
local function PlayerData(name, guild, source_id, race_id, class_id, level, instance_id, map_id, map_pos, date, last_words, rank, score)
        return {
          ["name"] = name,
          ["guild"] = guild,
          ["source_id"] = source_id,
          ["race_id"] = race_id,
          ["class_id"] = class_id,
          ["level"] = level,
          ["instance_id"] = instance_id,
          ["map_id"] = map_id,
          ["map_pos"] = map_pos,
          ["date"] = date,
          ["last_words"] = last_words,
          ["rank"] = rank,
          ["score"] = score,
        }
    end
]]    