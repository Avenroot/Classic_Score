local AceSerializer = LibStub("AceSerializer-3.0")
local AceComm = LibStub("AceComm-3.0")
-- We avoid using ChatThrottleLib for public channel sends to prevent taint issues.

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
local PUBLIC_MSG_PREFIX = "[HCS]"

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

local function GetBaseName(name)
    if type(name) ~= "string" then return name end
    local dash = string.find(name, "-")
    if dash then
        return string.sub(name, 1, dash - 1)
    end
    return name
end

-- Ensure the current player is present in the local leaderboard
function HCS_PlayerCom:UpsertSelfIntoLeaderboard()
    if not HCScore_Character or not HCScore_Character.name or HCScore_Character.name == '' then return end
    if not HCScore_Character.leaderboard then HCScore_Character.leaderboard = {} end

    local playerName = HCScore_Character.name
    local entry = HCScore_Character.leaderboard[playerName] or {}
    entry.charName = playerName
    entry.coreScore = tonumber(HCScore_Character.scores and HCScore_Character.scores.coreScore) or 0
    entry.hasDied = (HCScore_Character.deaths or 0) > 0
    entry.lastOnline = date("%Y-%m-%d %H:%M:%S")
    entry.charClass = HCScore_Character.classid or 0
    entry.charLevel = tonumber(HCScore_Character.level) or UnitLevel("player") or 1
    entry.guildName = HCScore_Character.guildName or ''
    HCScore_Character.leaderboard[playerName] = entry

    if HCS_LeaderBoardUI and HCS_LeaderBoardUI.RefreshData then
        HCS_LeaderBoardUI:RefreshData()
    end
end

-- Ensure addon message prefix is registered before any send
local function EnsurePrefixRegistered()
    if not C_ChatInfo.IsAddonMessagePrefixRegistered(PREFIX) then
        C_ChatInfo.RegisterAddonMessagePrefix(PREFIX)
    end
end

-- Public heartbeat ticker
local publicTicker = nil
local publicSendsReadyAt = 0

-- Public send queue (user-input driven dispatch to avoid taint)
local publicSendQueue = {}
local function EnqueuePublic(payload)
    if not payload or payload == "" then return end
    -- Cap the queue to avoid unbounded growth
    if #publicSendQueue > 100 then
        table.remove(publicSendQueue, 1)
    end
    table.insert(publicSendQueue, payload)
end

local function DrainOnePublic()
    if not Hardcore_Score or not Hardcore_Score.db or not Hardcore_Score.db.profile or not Hardcore_Score.db.profile.sharePublic then
        return
    end
    if GetTime and GetTime() < (publicSendsReadyAt or 0) then return end
    if #publicSendQueue == 0 then return end
    local chanId = GetPublicChannelId()
    if not (chanId and chanId > 0) then return end
    local payload = table.remove(publicSendQueue, 1)
    SendChatMessage(payload, "CHANNEL", nil, tostring(chanId))
end

-- Bind dispatch to mouse/key input (similar to DeathNotificationLib)
local function BindInputDispatch()
    if not _G.WorldFrame then return end
    if not _G.HCS_PublicInputFrame then
        _G.WorldFrame:HookScript("OnMouseDown", function() DrainOnePublic() end)
        local f = CreateFrame("Frame", "HCS_PublicInputFrame", UIParent)
        f:SetScript("OnKeyDown", function() DrainOnePublic() end)
        f:SetPropagateKeyboardInput(true)
    end
end

local function StopPublicHeartbeat()
    if publicTicker and publicTicker.Cancel then
        publicTicker:Cancel()
    end
    publicTicker = nil
end

local function StartPublicHeartbeat()
    StopPublicHeartbeat()
    -- Send a lightweight presence/update every 120 seconds
    if C_Timer and C_Timer.NewTicker then
        publicTicker = C_Timer.NewTicker(120, function()
            if Hardcore_Score and Hardcore_Score.db and Hardcore_Score.db.profile and Hardcore_Score.db.profile.sharePublic then
                if not GetTime or GetTime() >= publicSendsReadyAt then
                    -- Enqueue a presence update (current score)
                    if scoresComm == nil then init() end
                    local payload = PUBLIC_MSG_PREFIX .. AceSerializer:Serialize({
                        charName = HCScore_Character.name,
                        coreScore = string.format("%.2f", HCScore_Character.scores.coreScore),
                        charClass = HCScore_Character.classid,
                        charLevel = HCScore_Character.level,
                        hasDied = HCScore_Character.deaths > 0,
                        lastOnline = date("%Y-%m-%d %H:%M:%S"),
                        guildName = HCScore_Character.guildName,
                    })
                    EnqueuePublic(payload)
                end
            else
                StopPublicHeartbeat()
            end
        end)
    end
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
            -- Kick off heartbeat and send an immediate update (small delay to ensure channel ready)
            StartPublicHeartbeat()
            if C_Timer and C_Timer.After then
                local delaySeconds = 8
                if GetTime and publicSendsReadyAt and publicSendsReadyAt > 0 then
                    local remain = publicSendsReadyAt - GetTime()
                    if remain and remain > delaySeconds then delaySeconds = remain end
                end
                C_Timer.After(delaySeconds, function() HCS_PlayerCom:SendScore() end)
            else
                HCS_PlayerCom:SendScore()
            end
            -- Hide channel from default chat windows to avoid clutter
            for i = 1, NUM_CHAT_WINDOWS do
                local frame = _G["ChatFrame"..i]
                if frame and frame.RemoveMessageGroup then
                    -- Nothing to remove by group, but ensure channel not shown
                    ChatFrame_RemoveChannel(frame, channelName)
                end
            end
            BindInputDispatch()
        end
    else
        LeaveChannelByName(channelName)
        HCS_PublicAnnounced = false
        StopPublicHeartbeat()
    end
    -- Always ensure our own character is present in the leaderboard
    HCS_PlayerCom:UpsertSelfIntoLeaderboard()
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

        -- Also enqueue to public channel if enabled
        if Hardcore_Score and Hardcore_Score.db and Hardcore_Score.db.profile and Hardcore_Score.db.profile.sharePublic then
            local chanId = GetPublicChannelId()
            if chanId and chanId > 0 then
                EnsurePrefixRegistered()
                local payload = PUBLIC_MSG_PREFIX .. serializedScore
                if HCS_DebugCom then print("Classic Score: enqueue top for CHAT CHANNEL id=", tostring(chanId)) end
                EnqueuePublic(payload)
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

    -- Also enqueue to public channel if enabled
    if Hardcore_Score and Hardcore_Score.db and Hardcore_Score.db.profile and Hardcore_Score.db.profile.sharePublic then
        local chanId = GetPublicChannelId()
        if chanId and chanId > 0 then
            EnsurePrefixRegistered()
            local payload = PUBLIC_MSG_PREFIX .. serializedScore
            if HCS_DebugCom then print("Classic Score: enqueue score for CHAT CHANNEL id=", tostring(chanId)) end
            EnqueuePublic(payload)
        end
    end
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...)
    
        -- Check if the prefix is already registered
    EnsurePrefixRegistered()
   
    --C_ChatInfo.RegisterAddonMessagePrefix(PREFIX)

    --print(event, prefix, message, channel, sender)
    --print("Received an addon message from:", sender, "Message:", message)
    
    if Hardcore_Score.db ~= nil then         
    -- if player selects to share information.
    
        if Hardcore_Score.db.profile.shareDetails then
            if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" or event == "GROUP_JOINED" then
                if event == "PLAYER_ENTERING_WORLD" then
                    if GetTime then publicSendsReadyAt = GetTime() + 8 else publicSendsReadyAt = 8 end
                end
                -- Player has entered the world or group roster has been updated, send our score
                HCS_PlayerCom:SendTopScores()   --HCS_PlayerCom:SendScore()
                -- Ensure public channel is joined if enabled
                if Hardcore_Score.db.profile.sharePublic then
                    HCS_PlayerCom:UpdatePublicChannelSubscription()
                end
            elseif event == "CHAT_MSG_ADDON" then
                local prefix, message, distribution, sender = ...
                if prefix ~= PREFIX then return end

                -- Optional debug print
                if HCS_DebugCom then print("Classic Score: recv prefix=", prefix, "dist=", tostring(distribution), "sender=", tostring(sender), "chanIdx=", tostring(channelIndex), "chanName=", tostring(channelName)) end

                local success, scoreReveived = AceSerializer:Deserialize(message)
                
                if HCS_DebugCom then
                    local _, _, _, senderDbg, _, _, _, channelIndexDbg, channelNameDbg = ...
                    print("Classic Score: recv ADDON dist=", tostring(distribution), "sender=", tostring(senderDbg), "chanIdx=", tostring(channelIndexDbg), "chanName=", tostring(channelNameDbg))
                end

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
                                HCS_PublicOnline[GetBaseName(sender)] = time()
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
            elseif event == "CHAT_MSG_CHANNEL" then
                local text, sender, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, localID, name, lineID, guid = ...
                -- Only handle our configured channel (strip leading index like "1. ClassicScore")
                local expected = GetPublicChannelName()
                if not expected then return end
                if type(channelName) ~= "string" then return end
                local short = channelName
                local dotPos = string.find(short, "%.")
                if dotPos then
                    short = string.sub(short, dotPos + 1)
                    short = (short:gsub("^%s+", ""))
                end
                if string.lower(short) ~= string.lower(expected) then return end
                if type(text) ~= "string" then return end
                if text:sub(1, #PUBLIC_MSG_PREFIX) ~= PUBLIC_MSG_PREFIX then return end
                local payload = text:sub(#PUBLIC_MSG_PREFIX + 1)
                local success, scoreReveived = AceSerializer:Deserialize(payload)
                if not success then return end

                local function updateLeaderboard()
                    -- Normalize sender and charName to base name (strip realm)
                    local senderBase = GetBaseName(sender)
                    if type(scoreReveived.charName) == "string" then
                        scoreReveived.charName = GetBaseName(scoreReveived.charName)
                    end
                    if HCScore_Character.leaderboard[scoreReveived.charName] then
                        local incomingCoreScore = tonumber(scoreReveived.coreScore) or 0
                        if incomingCoreScore > tonumber(HCScore_Character.leaderboard[scoreReveived.charName].coreScore) then
                            HCScore_Character.leaderboard[scoreReveived.charName].coreScore = scoreReveived.coreScore
                            HCScore_Character.leaderboard[scoreReveived.charName].hasDied = scoreReveived.hasDied or 0
                            HCScore_Character.leaderboard[scoreReveived.charName].lastOnline = scoreReveived.lastOnline or date("%Y-%m-%d %H:%M:%S")
                        end
                        HCScore_Character.leaderboard[scoreReveived.charName].charClass = scoreReveived.charClass or 0
                        HCScore_Character.leaderboard[scoreReveived.charName].charLevel = tonumber(scoreReveived.charLevel) or 1
                        HCScore_Character.leaderboard[scoreReveived.charName].guildName = scoreReveived.guildName or ''
                    else
                        scoreReveived.coreScore = tonumber(scoreReveived.coreScore) or 0
                        scoreReveived.hasDied = scoreReveived.hasDied or 0
                        scoreReveived.lastOnline = scoreReveived.lastOnline or date("%Y-%m-%d %H:%M:%S")
                        scoreReveived.charClass = scoreReveived.charClass or 0
                        scoreReveived.charLevel = tonumber(scoreReveived.charLevel) or 1
                        scoreReveived.guildName = scoreReveived.guildName or ''
                        HCScore_Character.leaderboard[scoreReveived.charName] = scoreReveived
                    end
                    HCS_PublicOnline[senderBase] = time()
                    HCS_LeaderBoardUI:RefreshData()
                end

                local status, err = pcall(updateLeaderboard)
                if not status then
                    print("Failed to update leaderboard (channel): " .. err)
                end
            end
        end
    end
end)

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:RegisterEvent("GROUP_JOINED")
f:RegisterEvent("CHAT_MSG_ADDON")
f:RegisterEvent("CHAT_MSG_CHANNEL")
