local AceDB = LibStub("AceDB-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

-- Namespaces
local _;  
Hardcore_Score = {}

-- Globals
HCS_Version = "1.2.0.0" 
HCS_Release = 20
HCScore_Character = {
    name = "",
    class = "",
    classid = 0,
    level = 0,
    race = "",
    faction = "",
    version = 0,
    release = 0,
    deaths = 0,
    guildName = '',
    scores = {
        coreScore = 0,
        equippedGearScore = 0,
        achievementScore = 0,
        levelingScore = 0,
        questingScore = 0,
        mobsKilledScore = 0,
        professionsScore = 0,
        dungeonsScore = 0,
        reputationScore = 0,
        discoveryScore = 0,
        milestonesScore = 0,
    },
    quests = {},
    professions = {
        alchemy = 0,
        blacksmithing = 0,
        enchanting = 0,
        engineering = 0,
        herbalism = 0,
        leatherworking = 0,
        mining = 0,
        skinning = 0,
        tailoring = 0,
        fishing = 0,
        cooking = 0,
        firstaid = 0,
        inscription = 0, -- WotLK
        jewelcrafting = 0, -- WotLK
    },
    reputations = {},
    mobsKilled = {},
    mobsKilledMap = {}, -- Shows difficulty, total kills, total xp, total points  (example: -1, 10, 150, 25)
    discovery = {},
    milestones = {},
    levelScores = {},
    dangerousMobsKilled = {},
    achievements = {},
    leaderboard = {},
}

-- Simple URL copy popup used for clickable links in the options UI
StaticPopupDialogs["HCS_URL_COPY"] = {
    text = "Copy this link and paste it in your browser:",
    button1 = OKAY,
    hasEditBox = true,
    editBoxWidth = 350,
    whileDead = true,
    hideOnEscape = true,
    showAlert = true,
    OnShow = function(self)
        local editBox = _G[self:GetName().."EditBox"]
        local url = self.data or ""
        editBox:SetText(url)
        editBox:SetFocus()
        editBox:HighlightText()
    end,
    OnAccept = function(self)
        -- nothing to do; user can copy from the edit box
    end,
    EditBoxOnEnterPressed = function(self)
        self:HighlightText()
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
}

-- Only execute if in WoW Classic, Season of Discovery
if HCS_SODVersion then
    -- For handling engravings/runes
    HCScore_Character.scores.runesScore = 0
    HCScore_Character.runes = {}
end

-- Define your options table
local options = {
    name = "Classic Score",
    type = "group",
    args = {
        showScore = {
            name = "Show Main Score",
            desc = "Enables / disables the main score view",
            type = "toggle",
            order = 1,
            set = function(info,val) 
                Hardcore_Score.db.profile.framePosition.show = val
                if val then
                    ScoreboardSummaryFrame:Show()
                    if Hardcore_Score.db.profile.showDetails then
                        ScoreboardSummaryDetailsFrame:Show()  
                    end
                else
                    ScoreboardSummaryFrame:Hide()
                    ScoreboardSummaryDetailsFrame:Hide()
                end
            end,  -- set
            get = function(info) return Hardcore_Score.db.profile.framePosition.show end  -- get
        },

        scoreOptions = {
            order = 6,
            name = "Sharing with others",
            type = "group",
            inline = true,
            args = {
                shareScore = {
                    name = "Share your Score",
                    desc = "Enables / disables sharing your score with others",
                    type = "toggle",
                    order = 1,
                    set = function(info,val) Hardcore_Score.db.profile.shareDetails = val end,
                    get = function(info) return Hardcore_Score.db.profile.shareDetails end,
                },
                sharePublic = {
                    order = 2,
                    name = "Public Network (channel)",
                    desc = "Share with anyone in the Classic Score public channel",
                    type = "toggle",
                    set = function(info,val)
                        Hardcore_Score.db.profile.sharePublic = val
                        if HCS_PlayerCom and HCS_PlayerCom.UpdatePublicChannelSubscription then
                            HCS_PlayerCom:UpdatePublicChannelSubscription()
                        end
                    end,
                    get = function(info) return Hardcore_Score.db.profile.sharePublic end,
                },
                publicChannelName = {
                    order = 3,
                    name = "Public Channel Name",
                    desc = "Channel to use for the public Classic Score network",
                    type = "input",
                    disabled = function() return not Hardcore_Score.db.profile.sharePublic end,
                    set = function(info, val)
                        local trimmed = (val or ""):gsub("^%s+", ""):gsub("%s+$", "")
                        if trimmed == "" then trimmed = "ClassicScore" end
                        local old = Hardcore_Score.db.profile.publicChannelName or "ClassicScore"
                        if old ~= trimmed then
                            LeaveChannelByName(old)
                        end
                        Hardcore_Score.db.profile.publicChannelName = trimmed
                        if Hardcore_Score.db.profile.sharePublic and HCS_PlayerCom and HCS_PlayerCom.UpdatePublicChannelSubscription then
                            HCS_PlayerCom:UpdatePublicChannelSubscription()
                        end
                    end,
                    get = function(info) return Hardcore_Score.db.profile.publicChannelName end,
                },
                onlyLive = {
                    order = 3.5,
                    name = "Only live (public channel)",
                    desc = "Show only players active in the public channel",
                    type = "toggle",
                    disabled = function() return not Hardcore_Score.db.profile.sharePublic end,
                    set = function(info,val) Hardcore_Score.db.profile.onlyLive = val; HCS_LeaderBoardUI:RefreshData() end,
                    get = function(info) return Hardcore_Score.db.profile.onlyLive end,
                },
                keepHistory = {
                    order = 3.6,
                    name = "Keep saved history",
                    desc = "Persist leaderboard entries between sessions",
                    type = "toggle",
                    set = function(info,val) Hardcore_Score.db.profile.keepHistory = val end,
                    get = function(info) return Hardcore_Score.db.profile.keepHistory end,
                },
                historyDays = {
                    order = 3.7,
                    name = "History retention (days)",
                    desc = "Hide entries older than this many days (0 = never)",
                    type = "range",
                    min = 0,
                    max = 90,
                    step = 1,
                    disabled = function() return not Hardcore_Score.db.profile.keepHistory end,
                    set = function(info,val) Hardcore_Score.db.profile.historyDays = val; HCS_LeaderBoardUI:RefreshData() end,
                    get = function(info) return Hardcore_Score.db.profile.historyDays end,
                },
                shareMilestones = {
                    order = 4,
                    name = "Milestones",
                    desc = "Enables / disables sharing Milestones with others",
                    type = "toggle",
                    disabled = function() return not Hardcore_Score.db.profile.shareDetails end,
                    set = function(info,val) Hardcore_Score.db.profile.shareMilestones = val end,
                    get = function(info) return Hardcore_Score.db.profile.shareMilestones end,
                },
                shareAchievements = {
                    order = 5,
                    name = "Achievements",
                    desc = "Enables / disables sharing Achievements with others",
                    type = "toggle",
                    disabled = function() return not Hardcore_Score.db.profile.shareDetails end,
                    set = function(info,val) Hardcore_Score.db.profile.shareAchievements = val end,
                    get = function(info) return Hardcore_Score.db.profile.shareAchievements end,
                },
                shareRankProgression = {
                    order = 6,
                    name = "Rank Progression",
                    desc = "Enables / disables sharing Rank Progression with others",
                    type = "toggle",
                    disabled = function() return not Hardcore_Score.db.profile.shareDetails end,
                    set = function(info,val) Hardcore_Score.db.profile.shareRankProgression = val end,
                    get = function(info) return Hardcore_Score.db.profile.shareRankProgression end,
                },
                shareLevelProgression = {
                    order = 7,
                    name = "Level Progression",
                    desc = "Enables / disables sharing Level Progression with others",
                    type = "toggle",
                    disabled = function() return not Hardcore_Score.db.profile.shareDetails end,
                    set = function(info,val) Hardcore_Score.db.profile.shareLevelProgression = val end,
                    get = function(info) return Hardcore_Score.db.profile.shareLevelProgression end,
                },
            }
        },        

        showMessages = {
            name = "Show Messages",
            desc = "Enables / disables reward messages",
            type = "toggle",
            order = 3,
            set = function(info,val) 
                    Hardcore_Score.db.profile.framePositionMsg.show = val 
                end,  -- update your set function
            get = function(info) return Hardcore_Score.db.profile.framePositionMsg.show end  -- update your get function
        },

        soundOptionAll = {
            name = "HCS Sounds",
            desc = "Turn On/Off all HCS Sounds",
            type = "toggle",
            order = 4,
            set = function(info,val) Hardcore_Score.db.profile.soundOptionALL = val end,  
            get = function(info) return Hardcore_Score.db.profile.soundOptionALL end  
        },

        showScoreboard = {
            name = "Show Scoreboard",
            desc = "Enables / Disables the Scoreboard",
            type = "toggle",
            order = 5,
            set = function(info,val) 
                Hardcore_Score.db.profile.framePositionScoreboard.show = val 
                HCS_LeaderBoardUI:SetVisibility()
            end,  -- update your set function
            get = function(info) return Hardcore_Score.db.profile.framePositionScoreboard.show end  
        },        

        Space1 = {
            name = "",
            desc = "",
            type = "description",
            fontSize = "medium",
            order = 6
        },
        PointsLogHeader = {
            name = "Points Log",
            type = "header",
            order = 7
        },
        showPointsLog = {
            name = "Show Points Log",
            desc = "Enables / disables showing Points Log",
            type = "toggle",
            order = 8,
            set = function(info,val) 
                    Hardcore_Score.db.profile.framePositionLog.show = val 
                    HCS_PointsLogUI:SetVisibility()
                end,  -- update your set function
            get = function(info) return Hardcore_Score.db.profile.framePositionLog.show end  
        },
        showPointsLogTimeStamp = {
            name = "Show Timestamp",
            desc = "Displays showing the timestamp in Points log",
            type = "toggle",
            order = 9,
            set = function(info,val) Hardcore_Score.db.profile.framePositionLog.showTimestamp = val end,
            get = function(info) return Hardcore_Score.db.profile.framePositionLog.showTimestamp end
        },

        editBoxFontSize = {
            name = "Font Size",
            desc = "Adjusts the font size in the Points Log edit box",
            type = "range",
            order = 10,
            min = 10,
            max = 24,
            step = 1,
            set = function(info,val)
                Hardcore_Score.db.profile.framePositionLog.fontSize = val
                local fontName, _, fontFlags = HCS_PointsLogUI.EditBox:GetFont()
                HCS_PointsLogUI.EditBox:SetFont(fontName, val, fontFlags)
            end,
            get = function(info) return Hardcore_Score.db.profile.framePositionLog.fontSize end
        },

        Space2 = {
            name = "",
            desc = "",
            type = "description",
            fontSize = "medium",
            order = 11
        },
        LinksHeader = {
            name = "Connect for more information",
            type = "header",
            order = 12
        },
        discordLink = {
            name = " Join our Discord server",
            desc = "https://discord.gg/j92hrVZU2Q",
            type = "execute",
            image = "Interface\\Addons\\Hardcore_Score\\Media\\DiscordLogo.blp",
            imageWidth = 48,
            imageHeight = 48,
            func = function()
                StaticPopup_Show("HCS_URL_COPY", nil, nil, "https://discord.gg/j92hrVZU2Q")
            end,
            order = 14
        },
        Space3 = {
            name = "",
            desc = "",
            type = "description",
            fontSize = "medium",
            order = 16
        },

        addonInfoHeader = {
            name = "Note from the author(s)",
            type = "header",
            order = 17
        },
        addonInfo1 = {
            name = "Thank you for trying out Classic Score. We would love your feedback. Please report feedback and bugs to our Discord.",
            desc = "Addon Information",
            type = "description",
            fontSize = "medium",
            order = 18
        },            
        Space4 = {
            name = "",
            desc = "",
            type = "description",
            fontSize = "medium",
            order = 19
        },
        addonInfo2 = {
            name = "We have a lot of things planned for Classic Score. Look for annoucements in our Discord. Enjoy challenging yourself to get the best Classic Score possible and share your results with us. Thank you and have fun!!",
            desc = "Addon Information",
            type = "description",
            fontSize = "medium",
            order = 20
        },            

        Space5 = {
            name = "",
            desc = "",
            type = "description",
            fontSize = "medium",
            order = 21
        },
        addonInfoNote = {
            name = "version 1 - authors: Avenroot, Caith, Fruze (level 60 testing)",
            desc = "Addon Information",
            type = "description",
            fontSize = "medium",
            order = 22
        },            

    },
}

-- Custom Slash Command
Hardcore_Score.commands = {

    ["help"] = function ()
        print(" ");
        Hardcore_Score:Print("List of slash commands:");
        Hardcore_Score:Print("|cff00cc66/lb show|r - shows show menu");
        Hardcore_Score:Print("|cff00cc66/lb help|r - shows help info");
        print(" ");
    end,

    ["example"] = {
        ["test"] = function(...)
            Hardcore_Score:Print("My Value:", tostringall(...));
        end
    }
};

function Hardcore_Score.HandleSlashCommands(str)
    if (#str == 0) then
        
        --User just entered "/hlb" with no additional args.
        Hardcore_Score.commands.help();
        return;
    end

    local args = {}; -- What we will iterate over using the loop (arguments).
    for _, arg in pairs({ string.split(' ', str) }) do
        if (#arg > 0) then -- if string length is greater than 0
            table.insert(args, arg);
        end
    end

    local path = Hardcore_Score.commands; -- required for updating found table

    for id, arg in ipairs(args) do
        arg = string.lower(arg);

        if (path[arg]) then
            if (type(path[arg] == "function")) then
                
                -- all remaining args passed to our function!
                path[arg] (select(id + 1, unpack(args)));
                return;

            elseif (type(path[arg]) == "table") then
                path = path[arg]; -- another sub-table found!
            else
                -- does not exist
                Hardcore_Score.commands.help();
                return;
            end
        else
            -- does not exist!
            Hardcore_Score.commands.help();
            return;
        end
    end
end

function Hardcore_Score:CreateDB()

    -- Create a new database for your addon    
    self.db = AceDB:New("Hardcore_Score_Settings", {
        profile = {
            framePosition = {
                point = "CENTER",  --"CENTER",
                relativeTo = "UIParent",
                relativePoint = "CENTER", -- "CENTER",
                xOfs = 0,
                yOfs = 0,
                show = true,
            },
            -- Points Log
            framePositionLog = {
                point = "CENTER",  --"CENTER",
                relativeTo = "UIParent",
                relativePoint = "CENTER", -- "CENTER",
                xOfs = 0,
                yOfs = 0,
                show = false,
                showTimestamp = true,
                fontSize = 14,
            },
            -- Notification / pop up Milestone Message 
            framePositionMsg = {
                point = "CENTER",  --"CENTER",
                relativeTo = "UIParent",
                relativePoint = "CENTER", -- "CENTER",
                xOfs = 0,
                yOfs = 0,
                show = true,
            },
            -- Notification / Message 
            framePositionCharsInfo = {
                point = "CENTER",  --"CENTER",
                relativeTo = "UIParent",
                relativePoint = "CENTER", -- "CENTER",
                xOfs = 0,
                yOfs = 0,
                --show = true,
            },
            framePositionScoreboard = {
                point = "CENTER",  --"CENTER",
                relativeTo = "UIParent",
                relativePoint = "CENTER", -- "CENTER",
                xOfs = 0,
                yOfs = 0,
                show = true,
            },
            
            minimap = {},
            showDetails = false,
            shareDetails = true,
            sharePublic = true,
            publicChannelName = "ClassicScore",
            onlyLive = false,
            keepHistory = true,
            historyDays = 30,
            shareMilestones = true,
            shareAchievements = true,
            shareRankProgression = true,
            shareLevelProgression = true,
            soundOptionALL = true,
            lockScoreboardSummaryUI = false,
            showScoreboard = true,
            HCS_Leaderboard_Filters = {
                includeLevel60 = true,  -- Initially set to true or false based on the checkbox state
                includeSpecificGuild = true,  -- Set to true to include only the player's guild
                includeDeadCharacters = true,  -- Set to true to include dead characters
            }
        },
        global = {
            -- Shared data...
            characterScores = {},
        }
    })

end

function Hardcore_Score:CreateMiniMapButton()
    local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("HCScoreMinimapButton", {
        type = "data source",
        icon = "Interface\\Addons\\Hardcore_Score\\Media\\MM_logo_cs.tga",
        OnClick = function(self, button)

            -- Check if left mouse button was clicked
            if button == "LeftButton" then

                --HCS_AllInfoUI.frame:Show()
                HCS_AllInfoUI:ToggleMyFrame()

                -- Check if right mouse button was clicked
            elseif button == "RightButton" then                               
                
                HCS_LeaderBoardUI:ToggleMyFrame()
                -- Open Hardcore_Score section of the options menu
                --InterfaceOptionsFrame_OpenToCategory("Classic Score");
                --InterfaceOptionsFrame_OpenToCategory("Classic Score"); -- yes, you need to call it twice.

            end
        end,

        OnTooltipShow = function(tooltip)
            --tooltip:SetText("")  -- This should help ensure the title's style isn't applied to the first line
            tooltip:AddLine("Classic Score "..tostring(HCS_Version))
            tooltip:AddLine("|cFFFFA500Left-Click|r to to see your Journey")  -- Sets "Left-Click" to grey
            tooltip:AddLine("|cFFFFA500Right-Click|r Show/Hide Scoreboard")  -- Sets "Right-Click" to grey

            if Hardcore_Score.db.profile.framePosition.show == false then
                tooltip:AddLine(" ")
                if HCScore_Character ~= nil then
                    local txt = HCS_Utils:GetTextWithClassColor(HCScore_Character.classid, HCScore_Character.name ).. "  "..string.format("%.2f", HCScore_Character.scores.coreScore)
                    tooltip:AddLine(txt)
                else
                    tooltip:AddLine("Classic Score "..tostring(HCS_Version))
                end                    
            end
        end,
    })

    local icon = LibStub("LibDBIcon-1.0")
    icon:Register("Hardcore_Score", LDB, Hardcore_Score.db.profile.minimap)
end

-- Load Saved Frame Position
function Hardcore_Score:LoadSavedFramePosition()
    local framePosition = Hardcore_Score.db.profile.framePosition
    local showDetails = Hardcore_Score.db.profile.showDetails
    local framePointsLog = Hardcore_Score.db.profile.framePositionLog
    local frameCharsInfo = Hardcore_Score.db.profile.framePositionCharsInfo
    local frameScoreboard = Hardcore_Score.db.profile.framePositionScoreboard

    if framePosition then
        local relativeTo = _G[framePosition.relativeTo]
        if relativeTo then
            ScoreboardSummaryFrame:SetPoint(framePosition.point, relativeTo, framePosition.relativePoint, framePosition.xOfs, framePosition.yOfs)
        end
        if showDetails then
            ScoreboardSummaryDetailsFrame:Show()
        end
        if framePosition.show then
            ScoreboardSummaryFrame:Show()
        else
            ScoreboardSummaryFrame:Hide()
            ScoreboardSummaryDetailsFrame:Hide()
        end
    end

    if framePointsLog then
        local relativeTo = _G[framePointsLog.relativeTo]
        if relativeTo then
            HCS_PointsLogUI.frame:SetPoint(framePointsLog.point, relativeTo, framePointsLog.relativePoint, framePointsLog.xOfs, framePointsLog.yOfs)
        end
        HCS_PointsLogUI:SetVisibility()
    end

    if frameScoreboard then
        local relativeTo = _G[frameScoreboard.relativeTo]
        if relativeTo then
            HCS_LeaderBoardUI.frame:SetPoint(frameScoreboard.point, relativeTo, frameScoreboard.relativePoint, frameScoreboard.xOfs, frameScoreboard.yOfs)
        end
        HCS_LeaderBoardUI:SetVisibility()
    end

    if frameCharsInfo then
        local relativeTo = _G[frameCharsInfo.relativeTo]
        if relativeTo then
            HCS_CharactersInfoUI.frame:SetPoint(frameCharsInfo.point, relativeTo, frameCharsInfo.relativePoint, frameCharsInfo.xOfs, frameCharsInfo.yOfs)
        end
        HCS_CharactersInfoUI.frame:Hide() --HCS_CharactersInfoUI:ToggleMyFrame()
    end
end

function Hardcore_Score:init(event, name)
    if event == "ADDON_LOADED" then
        if name ~= "Hardcore_Score" then return end

        Hardcore_Score.events:UnregisterEvent("ADDON_LOADED")

        -- allows using left and right buttons to move through chat 'edit' box
        for i = 1, NUM_CHAT_WINDOWS do
            _G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false);
        end

        -- Register Slash Commands!
        SLASH_RELOADUI1 = "/rl"; -- new slash command for reloading UI
        SlashCmdList.RELOADUI = ReloadUI;

        SLASH_FRAMESTK1 = "/fs"; -- new slash command for showing framestack tool
        SlashCmdList.FRAMESTK = function ()
            LoadAddOn("Blizzard_DebugTools");
            FrameStackTooltip_Toggle();        
        end

        -- Define a variable to track whether the reset confirmation dialog is open
        local resetConfirmationOpen = false

        SLASH_RESETLEADERBOARD1 = "/hcsresetl"; -- new slash command for resetting leaderboard
        SlashCmdList.RESETLEADERBOARD = function ()
            -- Show a confirmation dialog to the player
            StaticPopupDialogs["RESET_LEADERBOARD_CONFIRM"] = {
                text = "Are you sure you want to reset your leaderboard?",
                button1 = "Yes",
                button2 = "No",
                OnAccept = function()
                    -- Player confirmed, reset the leaderboard
                    HCScore_Character.leaderboard = {}
                    print("Classic Score: Your Leaderboard has been reset.")
                end,
                timeout = 0,
                whileDead = true,
                hideOnEscape = true,
                showAlert = true,
            }

            StaticPopup_Show("RESET_LEADERBOARD_CONFIRM")
            resetConfirmationOpen = true
        end

        -- Slash command to open the Classic Score options screen (Classic Era/SoD compatible)
        SLASH_HCS1 = "/hcs"
        SlashCmdList["HCS"] = function()
            if LibStub and LibStub("AceConfigDialog-3.0") then
                local ACD = LibStub("AceConfigDialog-3.0")
                ACD:Open("Hardcore_Score")
                print("|cff81b7e9Classic Score:|r Options panel opened.")
            else
                print("|cffff0000Classic Score: Could not load AceConfigDialog.|r")
            end
        end
        
        
        -- initalization Hardcore_Score_Settings
        if Hardcore_Score_Settings == nil then Hardcore_Score_Settings = {} end

        -- Turn printing to message window off while loading and re-calculating
        HCS_print = false

        HCS_Playerinfo:LoadCharacterData()
        
        Hardcore_Score:CreateDB()

        HCS_ScoreboardSummaryUI:Init()
        HCS_ScoreboardSummaryUI:CreateFrame()
        
        -- Hides any messages that may be shown by recalcuating tables / scores (1) - Change settings
        local saveShowMessages = Hardcore_Score.db.profile.framePositionMsg.show
        Hardcore_Score.db.profile.framePositionMsg.show = false

        -- Create minimap button
        Hardcore_Score:CreateMiniMapButton()

        -- Get frame saved position
        Hardcore_Score:LoadSavedFramePosition()    

        -- Register the options table
        AceConfig:RegisterOptionsTable("Hardcore_Score", options)

        -- Add the options table to the Blizzard interface options
        AceConfigDialog:AddToBlizOptions("Hardcore_Score", "Classic Score")

        HCS_PointsLogUI:SetVisibility()

        HCS_PlayerCompletingQuestEvent:RecalculateQuests()
        
        HCS_MilestonesScore:ClearMilestones()

        HCS_CalculateScore:RefreshScores()

        ScoreboardSummaryFrame:SetScoreboardSummaryDetailsFramePosition()

        -- Hides any messages that may be shown by recalcuating tables / scores (2) - Restores settings
        Hardcore_Score.db.profile.framePositionMsg.show = saveShowMessages
        
        -- Turn printing to message window back on
        --HCS_print = true

        -- Clear Points Log
        HCS_PointsLogUI:ClearPointsLog()   

    elseif event == "PLAYER_LOGIN" then
        
        HCS_print = true
        local playerName

        local fontSize = Hardcore_Score.db.profile.framePositionLog.fontSize or 14
        Hardcore_Score.db.profile.framePositionLog.fontSize = fontSize

        local showTimestamp = Hardcore_Score.db.profile.framePositionLog.showTimestamp
        if showTimestamp == nil then
            showTimestamp = true
            Hardcore_Score.db.profile.framePositionLog.showTimestamp = showTimestamp
        end

        local showMainScore = Hardcore_Score.db.profile.framePosition.show
        if showMainScore == nil then
            showMainScore = true
            Hardcore_Score.db.profile.framePosition.show = showTimestamp
        end

        local fontName, _, fontFlags = HCS_PointsLogUI.EditBox:GetFont()
        HCS_PointsLogUI.EditBox:SetFont(fontName, fontSize, fontFlags)

        playerName = HCS_Utils:GetTextWithClassColor(HCScore_Character.classid, HCScore_Character.name)

        -- Clear Points Log
        HCS_PointsLogUI:ClearPointsLog()

        -- Get updated character guild
        HCScore_Character.guildName = GetGuildInfo("player") or ""  

        -- Runes
        if HCS_SODVersion then
            C_Engraving.RefreshRunesList() -- Needed to refresh runes between login sessions

          -- Updates the Class Rune Achievement table    
            local runesInfo = HCS_EngravingEvent:GetAllRunesInfo()
            HCS_AchievementsDB.ClassRuneAchievementTable = HCS_AchievementsDB:CreateClassRuneAchievementTable(runesInfo)  
            
            -- Resets the runes Collected
            HCS_EngravingEvent:ResetRunesCollected()

            -- Resets Achivements collected
            HCS_AchievementScore:Reset()
        end

        -- Print fun stuff for the player
        print("|cff81b7e9".."Classic Score: ".."|r".."Welcome "..playerName.." to Classic Score v.1.2.0.0  Lets GO!")

        -- Ensure public channel subscription if enabled
        if Hardcore_Score.db and Hardcore_Score.db.profile and Hardcore_Score.db.profile.sharePublic then
            if HCS_PlayerCom and HCS_PlayerCom.UpdatePublicChannelSubscription then
                HCS_PlayerCom:UpdatePublicChannelSubscription()
            end
        end

        -- Ensure we are listed on our own leaderboard
        if HCS_PlayerCom and HCS_PlayerCom.UpsertSelfIntoLeaderboard then
            HCS_PlayerCom:UpsertSelfIntoLeaderboard()
        end

        -- Purge old leaderboard entries if retention is set, or clear if disabled
        local profile = Hardcore_Score.db and Hardcore_Score.db.profile
        if profile then
            if not profile.keepHistory then
                HCScore_Character.leaderboard = {}
            else
                local days = profile.historyDays or 0
                if days > 0 then
                    local cutoff = time() - (days * 24 * 60 * 60)
                    for name, info in pairs(HCScore_Character.leaderboard or {}) do
                        local last = info.lastOnline
                        local ts = 0
                        if type(last) == "string" then
                            local y, m, d, H, M, S = last:match("(%d%d%d%d)%-(%d%d)%-(%d%d) (%d%d):(%d%d):(%d%d)")
                            if y then ts = time({year=tonumber(y), month=tonumber(m), day=tonumber(d), hour=tonumber(H), min=tonumber(M), sec=tonumber(S)}) or 0 end
                        elseif type(last) == "number" then
                            ts = last
                        end
                        if ts > 0 and ts < cutoff then
                            HCScore_Character.leaderboard[name] = nil
                        end
                    end
                end
            end
        end

        
        --[[
        -- testing
        local categories = GetStatisticsCategoryList()
        print(categories)
        for i, id in next(categories) do
            local key, parent = GetCategoryInfo(id)
            print("The key %d has the parent %d", key, parent)
        end

        -- testing
        function GetStatisticId(StatisticTitle)
            for _, CategoryId in pairs(GetStatisticsCategoryList()) do	
                for i = 1, GetCategoryNumAchievements(CategoryId) do
                    local IDNumber, Name = GetAchievementInfo(CategoryId, i)
                    if Name == StatisticTitle then
                        return IDNumber
                    end
                end		
            end
            return -1
        end
        ]]
        
   
    end

end

Hardcore_Score.events = CreateFrame("Frame")
Hardcore_Score.events:RegisterEvent("ADDON_LOADED")
Hardcore_Score.events:RegisterEvent("PLAYER_LOGIN")
Hardcore_Score.events:SetScript("OnEvent", Hardcore_Score.init)

