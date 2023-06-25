local AceSerializer = LibStub("AceSerializer-3.0")

HCS_PlayerCom = {}

local scoresComm = {
    coreScore = '',
    equippedGearScore = '',
    hcAchievementScore = '',
    levelingScore = '',
    questingScore = '',
    mobsKilledScore = '',
    professionsScore = '',
    dungeonsScore = '',
    reputationScore = '',
    discoveryScore = '',
    milestoneScore = '',
}

local function init()
    scoresComm = {
        coreScore = '',
        equippedGearScore = '',
        hcAchievementScore = '',
        levelingScore = '',
        questingScore = '',
        mobsKilledScore = '',
        professionsScore = '',
        dungeonsScore = '',
        reputationScore = '',
        discoveryScore = '',
        milestoneScore = '',
    }        
end

-- The prefix for your addon's messages. This should be a unique string that other addons are not likely to use.
local PREFIX = "HardcoreAddon"  -- Replace with your addon prefix

-- Table to store scores received from other players.
local playerScores = {}

local function padString(str, len)
    local length = string.len(str)
    for i = length, len do
        str = str .. " "
    end
    return str
end

-- Function to send a player's score.
function HCS_PlayerCom:SendScore()

    if scoresComm == nil then init() end

    --print(scoresComm.coreScore)
    --print(HCScore_Character.scores.coreScore)
    --print(string.format("%.2f", HCScore_Character.scores.coreScore))

    scoresComm.coreScore = string.format("%.2f", HCScore_Character.scores.coreScore)
    scoresComm.equippedGearScore = string.format("%.2f", HCScore_Character.scores.equippedGearScore)
    scoresComm.hcAchievementScore = string.format("%.2f", HCScore_Character.scores.hcAchievementScore)
    scoresComm.levelingScore = string.format("%.2f", HCScore_Character.scores.levelingScore)
    scoresComm.questingScore = string.format("%.2f", HCScore_Character.scores.questingScore)
    scoresComm.mobsKilledScore = string.format("%.2f", HCScore_Character.scores.mobsKilledScore)
    scoresComm.professionsScore = string.format("%.2f", HCScore_Character.scores.professionsScore)
    scoresComm.dungeonsScore = string.format("%.2f", HCScore_Character.scores.dungeonsScore)
    scoresComm.reputationScore = string.format("%.2f", HCScore_Character.scores.reputationScore)
    scoresComm.discoveryScore = string.format("%.2f", HCScore_Character.scores.discoveryScore)
    scoresComm.milestoneScore = string.format("%.2f", HCScore_Character.scores.milestonesScore)

    local serializedScore = AceSerializer:Serialize(scoresComm)

    if IsInGroup() then
        local channel = IsInRaid() and "RAID" or "PARTY"
        
        C_ChatInfo.SendAddonMessage(PREFIX, serializedScore, channel)
    elseif IsInGuild() then
        C_ChatInfo.SendAddonMessage(PREFIX, serializedScore, "GUILD")
    end
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, prefix, message, channel, sender)

    -- if player selects to share information.
    if Hardcore_Score.db.profile.shareDetails then
        if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" or event == "GROUP_JOINED" then
            -- Player has entered the world or group roster has been updated, send our score
            HCS_PlayerCom:SendScore()
    
        elseif event == "CHAT_MSG_ADDON" and prefix == PREFIX then
        
            local success, scoreReveived = AceSerializer:Deserialize(message)
    
            if success then     
                playerScores[sender] = scoreReveived --tonumber(message)
            
            else
                --print("Deserialization failed:", scoreReveived)
            end                 
        end
    end
end)

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:RegisterEvent("GROUP_JOINED")
f:RegisterEvent("CHAT_MSG_ADDON")

-- Function to add a player's score to their tooltip.
local function ModifyTooltip(self)
    local unit = select(2, self:GetUnit())

    if not unit then
        return
    end

    local name, server = UnitFullName(unit)
    if server == nil then
      server = GetNormalizedRealmName()
    end
    local fullname = name..'-'..server
    local score = playerScores[fullname]

    if score then
        self:AddLine(padString("Hardcore Score", 15) .. string.format("%.2f", score.coreScore))

        local equippedGear = score.equippedGearScore
        local leveling = score.levelingScore
        local questing = score.questingScore
        local mobsKilled = score.mobsKilledScore
        local professions = score.professionsScore
        local reputation = score.reputationScorez
        local discovery = score.discoveryScore
        local milestones = score.milestoneScore

        self:AddLine(padString("Equipped Gear", 15) .. string.format("%.2f", equippedGear))
        self:AddLine(padString("Leveling     ", 15) .. string.format("%.2f", leveling))
        self:AddLine(padString("Questing     ", 15) .. string.format("%.2f", questing))
        self:AddLine(padString("Mobs Killed  ", 15) .. string.format("%.2f", mobsKilled))
        self:AddLine(padString("Professions  ", 15) .. string.format("%.2f", professions))
        self:AddLine(padString("Reputation   ", 15) .. string.format("%.2f", reputation))
        self:AddLine(padString("Discovery    ", 15) .. string.format("%.2f", discovery))
        self:AddLine(padString("Milestones   ", 15) .. string.format("%.2f", milestones))
    else
      --  print("No score found for player " .. fullname)
    end
end


GameTooltip:HookScript("OnTooltipSetUnit", ModifyTooltip)
