local AceSerializer = LibStub("AceSerializer-3.0")
local AceComm = LibStub("AceComm-3.0")

HCS_PlayerCom = {}

local scoresComm = {
    charName = '',
    charClass = '',
    charLevel = '',
    coreScore = '',
    hasDied = false,
    lastOnline = '',
    guildName = '',
}

local function init()
    scoresComm = {
        charName = '',
        charClass = '',
        charLevel = '',
        coreScore = '',
        hasDied = false,
        lastOnline = '',
        guildName = '',
    }        
end


-- The prefix for your addon's messages. This should be a unique string that other addons are not likely to use.
local PREFIX = HCS_PREFIX  

-- Public channel helpers
local function GetPublicChannelName()
    local name = "ClassicScore"
    if Hardcore_Score and Hardcore_Score.db and Hardcore_Score.db.profile then
        name = Hardcore_Score.db.profile.publicChannelName or name
    end
    return name
end

local function GetPublicChannelId()
    local channelName = GetPublicChannelName()
    local id = GetChannelName(channelName)
    return id
end

function HCS_PlayerCom:UpdatePublicChannelSubscription()
    if not Hardcore_Score or not Hardcore_Score.db or not Hardcore_Score.db.profile then return end
    local enabled = Hardcore_Score.db.profile.sharePublic
    local channelName = GetPublicChannelName()
    if enabled then
        JoinChannelByName(channelName)
        local id = GetChannelName(channelName)
        if id and id > 0 then
            if not HCS_PublicAnnounced then
                print("|cff81b7e9Classic Score:|r Public channel '"..channelName.."' active ("..id..").")
                HCS_PublicAnnounced = true
            end
        end
    else
        LeaveChannelByName(channelName)
        HCS_PublicAnnounced = false
    end
end

local function padString(str, len)
    local length = string.len(str)
    for i = length, len do
        str = str .. " "
    end
    return str
end

-- Function to send the top 10 player's scores.
function HCS_PlayerCom:SendTopScores()

    -- Sort the leaderboard array first
    local leaderboardArray = {}
    for charName, info in pairs(HCScore_Character.leaderboard) do
        table.insert(leaderboardArray, info)
    end
    table.sort(leaderboardArray, function(a, b)
        return tonumber(a.coreScore) > tonumber(b.coreScore)
    end)

    -- Only send top 10 scores
    for i = 1, min(10, #leaderboardArray) do
        local playerInfo = leaderboardArray[i]

        local serializedScore = AceSerializer:Serialize(playerInfo)
        
        -- Send
        if IsInGroup() then
            local channel = IsInRaid() and "RAID" or "PARTY"
            C_ChatInfo.SendAddonMessage(PREFIX, serializedScore, channel)
        elseif IsInGuild() then
            C_ChatInfo.SendAddonMessage(PREFIX, serializedScore, "GUILD")
        end

        -- Also send to public channel if enabled
        if Hardcore_Score and Hardcore_Score.db and Hardcore_Score.db.profile and Hardcore_Score.db.profile.sharePublic then
            local chanId = GetPublicChannelId()
            if chanId and chanId > 0 then
                AceComm:SendCommMessage(PREFIX, serializedScore, "CHANNEL", chanId, "NORMAL")
            end
        end
    end
end


-- Function to send a player's score.
function HCS_PlayerCom:SendScore()

    if scoresComm == nil then init() end

    scoresComm.coreScore = string.format("%.2f", HCScore_Character.scores.coreScore)
    scoresComm.charName = HCScore_Character.name
    scoresComm.charClass = HCScore_Character.classid
    scoresComm.charLevel = HCScore_Character.level
    scoresComm.hasDied = HCScore_Character.deaths > 0
    scoresComm.lastOnline = date("%Y-%m-%d %H:%M:%S")
    scoresComm.guildName = HCScore_Character.guildName
    
    --scoresComm.equippedGearScore = string.format("%.2f", HCScore_Character.scores.equippedGearScore)
    --scoresComm.achievementScore = string.format("%.2f", HCScore_Character.scores.achievementScore)
    --scoresComm.levelingScore = string.format("%.2f", HCScore_Character.scores.levelingScore)
    --scoresComm.questingScore = string.format("%.2f", HCScore_Character.scores.questingScore)
    --scoresComm.mobsKilledScore = string.format("%.2f", HCScore_Character.scores.mobsKilledScore)
    --scoresComm.professionsScore = string.format("%.2f", HCScore_Character.scores.professionsScore)
    --scoresComm.dungeonsScore = string.format("%.2f", HCScore_Character.scores.dungeonsScore)
    --scoresComm.reputationScore = string.format("%.2f", HCScore_Character.scores.reputationScore)
    --scoresComm.discoveryScore = string.format("%.2f", HCScore_Character.scores.discoveryScore)
    --scoresComm.milestoneScore = string.format("%.2f", HCScore_Character.scores.milestonesScore)

    local serializedScore = AceSerializer:Serialize(scoresComm)
    --local success, _ = AceSerializer:Deserialize(serializedScore)
    --print("Is Serializtion working?", success)
    --print("serializedScore", serializedScore)


    if IsInGroup() then
        local channel = IsInRaid() and "RAID" or "PARTY"

        C_ChatInfo.SendAddonMessage(PREFIX, serializedScore, channel)
    elseif IsInGuild() then
        --print("Sending to Guild")        
        C_ChatInfo.SendAddonMessage(PREFIX, serializedScore, "GUILD")
    end

    -- Also send to public channel if enabled
    if Hardcore_Score and Hardcore_Score.db and Hardcore_Score.db.profile and Hardcore_Score.db.profile.sharePublic then
        local chanId = GetPublicChannelId()
        if chanId and chanId > 0 then
            AceComm:SendCommMessage(PREFIX, serializedScore, "CHANNEL", chanId, "NORMAL")
        end
    end
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, prefix, message, channel, sender)
    
        -- Check if the prefix is already registered
    if not C_ChatInfo.IsAddonMessagePrefixRegistered(PREFIX) then
        -- If not, try to register it
        if C_ChatInfo.RegisterAddonMessagePrefix(PREFIX) then
            print("Successfully connected to the Classic Score network")
        else
            print("Failed to connect to the Classic Score network")
        end
    else
        --print("Addon prefix already registered: " .. PREFIX)
    end
   
    --C_ChatInfo.RegisterAddonMessagePrefix(PREFIX)

    --print(event, prefix, message, channel, sender)
    --print("Received an addon message from:", sender, "Message:", message)
    
    if Hardcore_Score.db ~= nil then         
    -- if player selects to share information.
    
        if Hardcore_Score.db.profile.shareDetails then
            if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" or event == "GROUP_JOINED" then
                -- Player has entered the world or group roster has been updated, send our score
                HCS_PlayerCom:SendTopScores()   --HCS_PlayerCom:SendScore()
                -- Ensure public channel is joined if enabled
                if Hardcore_Score.db.profile.sharePublic then
                    HCS_PlayerCom:UpdatePublicChannelSubscription()
                end
            elseif event == "CHAT_MSG_ADDON" and prefix == PREFIX then

                local success, scoreReveived = AceSerializer:Deserialize(message)         

                if success then

                    local function updateLeaderboard()
                        if HCScore_Character.leaderboard[scoreReveived.charName] then
                            -- Ensure default values for coreScore
                            local incomingCoreScore = tonumber(scoreReveived.coreScore) or 0
                            
                            -- Check if incoming coreScore is higher than existing coreScore
                            if incomingCoreScore > tonumber(HCScore_Character.leaderboard[scoreReveived.charName].coreScore) then
                                HCScore_Character.leaderboard[scoreReveived.charName].coreScore = scoreReveived.coreScore
                                -- Provide default values if nil
                                HCScore_Character.leaderboard[scoreReveived.charName].hasDied = scoreReveived.hasDied or 0
                                HCScore_Character.leaderboard[scoreReveived.charName].lastOnline = scoreReveived.lastOnline or date("%Y-%m-%d %H:%M:%S")
                            end
                    
                            -- Update other fields regardless, with default values if nil
                            HCScore_Character.leaderboard[scoreReveived.charName].charClass = scoreReveived.charClass or 0
                            HCScore_Character.leaderboard[scoreReveived.charName].charLevel = tonumber(scoreReveived.charLevel) or 1
                            HCScore_Character.leaderboard[scoreReveived.charName].guildName = scoreReveived.guildName or ''

                        else
                            -- Add the new entry if charName is not already in the table
                            -- Ensure default values for all fields
                            scoreReveived.coreScore = tonumber(scoreReveived.coreScore) or 0
                            scoreReveived.hasDied = scoreReveived.hasDied or 0
                            scoreReveived.lastOnline = scoreReveived.lastOnline or date("%Y-%m-%d %H:%M:%S")
                            scoreReveived.charClass = scoreReveived.charClass or 0
                            scoreReveived.charLevel = tonumber(scoreReveived.charLevel) or 1
                            scoreReveived.guildName = scoreReveived.guildName or ''
                    
                            HCScore_Character.leaderboard[scoreReveived.charName] = scoreReveived
                        end
                        -- Mark sender as present on public channel
                        if Hardcore_Score and Hardcore_Score.db and Hardcore_Score.db.profile and Hardcore_Score.db.profile.sharePublic then
                            if sender then
                                HCS_PublicOnline[sender] = time()
                            end
                        end
                        HCS_LeaderBoardUI:RefreshData() -- Refresh or load data to UI
                    end


                    -- Execute the function and catch any errors
                    local status, err = pcall(updateLeaderboard)
                
                    -- If an error occurred, handle it
                    if not status then
                        print("Failed to update leaderboard: " .. err)
                    end
                
                    -- Optionally, you can also print the contents of the leaderboard here
                   -- Print the contents of the table
                    --for charName, info in pairs(HCScore_Character.leaderboard) do
                    --    print(charName .. " " .. info.coreScore)
                    --end
                                                 
                else
                    -- Deserialization failed
                end                             
            end
        end
    end
end)

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:RegisterEvent("GROUP_JOINED")
f:RegisterEvent("CHAT_MSG_ADDON")
