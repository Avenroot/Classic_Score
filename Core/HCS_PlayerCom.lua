HCS_PlayerCom = {}
local AceSerializer = LibStub("AceSerializer-3.0")

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
}


-- The prefix for your addon's messages. This should be a unique string that other addons are not likely to use.
local PREFIX = "HardcoreAddon"  -- Replace with your addon prefix

-- Table to store scores received from other players.
local playerScores = {}

local function PrintTotalRecords()
    local count = 0
    for _ in pairs(playerScores) do
      count = count + 1
    end
    
    print("playerScores = "..count)  -- Output: total number of records in the table
    
end

local function PrintTable(tbl)
    if tbl then 
        for key, value in pairs(tbl) do
            print(key, value)
        end
    
    end

end


local function padString(str, len)
    local length = string.len(str)
    for i = length, len do
        str = str .. " "
    end
    return str
end


-- Function to send a player's score.
function HCS_PlayerCom:SendScore(score)
    print("SendScore")
    --PrintTable(score)
    for key, value in pairs(score) do
        print(key, value)
    end

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


    local serializedScore = AceSerializer:Serialize(scoresComm)

    if IsInGroup() then
        print("In a group")
        local channel = IsInRaid() and "RAID" or "PARTY"
        print(channel)
        
        C_ChatInfo.SendAddonMessage(PREFIX, serializedScore, channel)
    elseif IsInGuild() then
        C_ChatInfo.SendAddonMessage(PREFIX, serializedScore, "GUILD")
    end
end

-- Frame to handle events.
local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, prefix, message, channel, sender)
    print("Comm frame event")
    HCS_PlayerCom:SendScore(HCScore_Character.scores)
    print(event)
--    print(message)
    print(prefix)
    print(PREFIX)
    print(sender)
    if event == "CHAT_MSG_ADDON" and prefix == PREFIX then
        print("updating playerScores")
    
            local success, scoreReveived = AceSerializer:Deserialize(message)
    
            --print(message)
           -- print(tonumber(message))
            --print(sender)
            if success then     
                print("Adding Score to playerScore table")
                PrintTable(scoreReveived)    
                playerScores[sender] = scoreReveived --tonumber(message)
            
            else
                print("Deserialization failed:", scoreReveived)
            end
            


        --PrintTable(playerScores)

    end
end)
f:RegisterEvent("CHAT_MSG_ADDON")

-- Function to add a player's score to their tooltip.
local function ModifyTooltip(self)
    print("ModifyTooltip")
    local unit = select(2, self:GetUnit())
    print(unit)
    if not unit then
        return
    end

    --local name = GetUnitName(unit, true)
    local name, server = UnitFullName(unit)
    if server == nil then
      server = GetNormalizedRealmName()
    end
    local fullname = name..'-'..server
    local score = playerScores[fullname]

    print(fullname)
--    print("PRINTING TABLE")
    PrintTable(score) 
--    print(score)

    if score then
        print(score)
        self:AddLine(padString("Hardcore Score", 15) .. string.format("%.2f", score.coreScore))

        -- I'm assuming the rest of these values are properties of the score.
        -- Replace these with the actual values.
        local equippedGear = score.equippedGearScore
        local leveling = score.levelingScore
        local questing = score.questingScore
        local mobsKilled = score.mobsKilledScore
        local professions = score.professionsScore
        local reputation = score.reputationScore
        local discovery = score.discoveryScore

        self:AddLine(padString("Equipped Gear", 15) .. string.format("%.2f", equippedGear))
        self:AddLine(padString("Leveling", 15) .. string.format("%.2f", leveling))
        self:AddLine(padString("Questing", 15) .. string.format("%.2f", questing))
        self:AddLine(padString("Mobs Killed", 15) .. string.format("%.2f", mobsKilled))
        self:AddLine(padString("Professions", 15) .. string.format("%.2f", professions))
        self:AddLine(padString("Reputation", 15) .. string.format("%.2f", reputation))
        self:AddLine(padString("Discovery", 15) .. string.format("%.2f", discovery))
    else
        print("No score found for player " .. fullname)
    end


       -- self:AddLine("Hardcore Score: " .. string.format("%.2f", score))
    --end
end


GameTooltip:HookScript("OnTooltipSetUnit", ModifyTooltip)
