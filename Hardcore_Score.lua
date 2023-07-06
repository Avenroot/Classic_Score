local AceDB = LibStub("AceDB-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

-- Namespaces
local _;  
Hardcore_Score = {}

-- Globals
HCS_Version = "0.9.7" --GetAddOnMetadata("Hardcore Score", "Version")
HCScore_Character = {
    name = "",
    class = "",
    level = 0,
    race = "",
    faction = "",
    version = 0,
    deaths = 0,
    scores = {
        coreScore = 0,
        equippedGearScore = 0,
        hcAchievementScore = 0,
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
        lockpicking = 0,
        mining = 0,
        skinning = 0,
        tailoring = 0,
        fishing = 0,
        cooking = 0,
        firstaid = 0,
    },
    reputations = {},
    mobsKilled = {},
    discovery = {},
    milestones = {},
    levelScores = {},
}    

-- Define your options table
local options = {
    name = "Hardcore Score",
    type = "group",
    args = {
        shareScore = {
            name = "Share your score",
            desc = "Enables / disables sharing your score with others",
            type = "toggle",
            order = 1,
            set = function(info,val) Hardcore_Score.db.profile.shareDetails = val end,  -- update your set function
            get = function(info) return Hardcore_Score.db.profile.shareDetails end  -- update your get function
        },
        showMessages = {
            name = "Show Messages",
            desc = "Enables / disables reward messages",
            type = "toggle",
            order = 2,
            set = function(info,val) 
                    Hardcore_Score.db.profile.framePositionMsg.show = val 
                end,  -- update your set function
            get = function(info) return Hardcore_Score.db.profile.framePositionMsg.show end  -- update your get function
        },
        Space1 = {
            name = "",
            desc = "",
            type = "description",
            fontSize = "medium",
            order = 3
        },
        PointsLogHeader = {
            name = "Points Log",
            type = "header",
            order = 4
        },
        showPointsLog = {
            name = "Show Points Log",
            desc = "Enables / disables showing Points Log",
            type = "toggle",
            order = 5,
            set = function(info,val) 
                    Hardcore_Score.db.profile.framePositionLog.show = val 
                    HCS_PointsLogUI:SetVisibility()
                end,  -- update your set function
            get = function(info) return Hardcore_Score.db.profile.framePositionLog.show end  -- update your get function
        },
        showPointsLogTimeStamp = {
            name = "Show Timestamp",
            desc = "Displays showing the timestamp in Points log",
            type = "toggle",
            order = 6,
            set = function(info,val) Hardcore_Score.db.profile.framePositionLog.showTimestamp = val end,
            get = function(info) return Hardcore_Score.db.profile.framePositionLog.showTimestamp end
        },

        editBoxFontSize = {
            name = "Font Size",
            desc = "Adjusts the font size in the Points Log edit box",
            type = "range",
            order = 7,
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
            order = 8
        },
        LinksHeader = {
            name = "Connect for more information",
            type = "header",
            order = 9
        },
        twitterLink = {
            name = " Follow us on Twitter at https://twitter.com//HardcoreScore",
            desc = "https://twitter.com//HardcoreScore",
            type = "description",
            fontSize = "medium",
            image = "Interface\\Addons\\Hardcore_Score\\Media\\TwitterLogo.blp",
            order = 10
        },
        discordLink = {
            name = " Join our Discord server at https://discord.gg/j92hrVZU2Q",
            desc = "https://discord.gg/j92hrVZU2Q",
            type = "description",
            fontSize = "medium",
            image = "Interface\\Addons\\Hardcore_Score\\Media\\DiscordLogo.blp",
            order = 11
        },
        websiteLink = {
            name = " Website  https://avenroothcs.wixsite.com/hardcore-score",
            desc = "https://avenroothcs.wixsite.com/hardcore-score",
            type = "description",
            fontSize = "medium",
            image = "Interface\\Addons\\Hardcore_Score\\Media\\www_icon.blp",
            order = 12
        },
        Space3 = {
            name = "",
            desc = "",
            type = "description",
            fontSize = "medium",
            order = 13
        },

        addonInfoHeader = {
            name = "Note from the author",
            type = "header",
            order = 14
        },
        addonInfo1 = {
            name = "Thank you for trying out Hardcore Score. We are still in beta process and are aware of a few issues we are ironing out. We wanted to get this into your hands to get some feedback on what you think and let us know what changes you would like. If you find a bug please report it to our Discord.",
            desc = "Addon Information",
            type = "description",
            fontSize = "medium",
            order = 15
        },            
        Space4 = {
            name = "",
            desc = "",
            type = "description",
            fontSize = "medium",
            order = 16
        },
        addonInfo2 = {
            name = "We have a lot of things we would like to do with Hardcore Score. We are excited to share those with you soon. Please be patient with us as we work out any issues in this beta. Enjoy challenging yourself to get the best Hardcore Score possible and share your results with us. Thank you and have fun!!",
            desc = "Addon Information",
            type = "description",
            fontSize = "medium",
            order = 17
        },            

        Space5 = {
            name = "",
            desc = "",
            type = "description",
            fontSize = "medium",
            order = 18
        },
        addonInfoNote = {
            name = "* Note - Although we encourage you to use the Hardcore Addon with Hardcore Score, we are not accociated with the Hardcore Addon team.",
            desc = "Addon Information",
            type = "description",
            fontSize = "medium",
            order = 19
        },            

    },
}

-- Custom Slash Command
Hardcore_Score.commands = {
 --   ["show"] = Hardcore_Score.HCS_ScoreboardUI.Toggle, -- this is a function (no knowledge of Config object)

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

function Hardcore_Score:Print(...)
--    local hex = select(4, HCS_ScoreboardUI:GetThemeColor());
--    local prefix = string.format("|cff%s%s|r", hex:upper(), "Hardcore HCS_ScoreboardUI:");
--    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, tostringall(...)));    
    local debugging = true
    
    if debugging then
        print(...)        
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
            -- Notification / Message 
            framePositionMsg = {
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
        },
    })

end

function Hardcore_Score:CreateMiniMapButton()   
 
    local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("HCScoreMinimapButton", {
        type = "launcher",
        icon = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-minimap-16.blp",  -- XP_ICON, Spell_Nature_Polymorph
        OnClick = function(self, button)
            -- Add OnClick code here          
            HCS_PointsLogUI:ToggleMyFrame()
        end,        

        OnTooltipShow = function(tooltip)
            tooltip:SetText("Hardcore Score BETA v."..tostring(HCS_Version))
        end,
    })

    local icon = LibStub("LibDBIcon-1.0")
    icon:Register("Hardcore_Score", LDB, Hardcore_Score.db.profile.minimap) 
end

-- Load Saved Frame Position
function Hardcore_Score:LoadSavedFramePosition()
    local framePosition = Hardcore_Score.db.profile.framePosition
    local showDetails = Hardcore_Score.db.profile.showDetails
    if framePosition then
        local relativeTo = _G[framePosition.relativeTo]
        if relativeTo then
            ScoreboardSummaryFrame:SetPoint(framePosition.point, relativeTo, framePosition.relativePoint, framePosition.xOfs, framePosition.yOfs)
        end
        if showDetails then
            ScoreboardSummaryDetailsFrame:Show()
        end
    end
end

function Hardcore_Score:init(event, name)
    if event == "ADDON_LOADED" then
        if name ~= "Hardcore_Score" then return end

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

        -- initalization Hardcore_Score_Settings
        if Hardcore_Score_Settings == nil then Hardcore_Score_Settings = {} end

        HCS_Playerinfo:LoadCharacterData()
        --print("LoadCharacterData")

        HCS_ScoreboardSummaryUI:CreateFrame()
        --print("HCS_ScoreboardSummaryUI:Create")

        Hardcore_Score:CreateDB()
        --print("CreateDB")

        -- Create minimap button
        Hardcore_Score:CreateMiniMapButton()
        --print("CreateMiniMapButton")

        -- Get frame saved position
        Hardcore_Score:LoadSavedFramePosition()    
        --print("LoadSavedFramePosition")

        -- Register the options table
        AceConfig:RegisterOptionsTable("Hardcore_Score", options)
        --print("RegisterOptionsTable")

        -- Add the options table to the Blizzard interface options
        AceConfigDialog:AddToBlizOptions("Hardcore_Score", "Hardcore Score")
        --print("AddToBlizOptions")

        HCS_PointsLogUI:SetVisibility()

        HCS_PlayerCompletingQuestEvent:RecalculateQuests()

        HCS_CalculateScore:RefreshScores()

    elseif event == "PLAYER_LOGIN" then
        local playerName
        local fontSize = Hardcore_Score.db.profile.framePositionLog.fontSize
        local showTimestamp = Hardcore_Score.db.profile.framePositionLog.showTimestamp
        if fontSize == nil then
            fontSize = 14  -- save the default value 
            Hardcore_Score.db.profile.framePositionLog.fontSize = fontSize  -- save the default value
        end
        if showTimestamp == nil then
            Hardcore_Score.db.profile.framePositionLog.showTimestamp = true
        end
        local fontName, _, fontFlags = HCS_PointsLogUI.EditBox:GetFont()
        HCS_PointsLogUI.EditBox:SetFont(fontName, fontSize, fontFlags)


        if HCScore_Character.class == "Druid" then 
            playerName = "|cFFFF7C0A"..HCScore_Character.name.."|r"
        elseif HCScore_Character.class == "Hunter" then
            playerName = "|cFFAAD372"..HCScore_Character.name.."|r"
        elseif HCScore_Character.class == "Mage" then
            playerName = "|cFF3FC7EB"..HCScore_Character.name.."|r"
        elseif HCScore_Character.class == "Paladin" then
            playerName = "|cFFF48CBA"..HCScore_Character.name.."|r"
        elseif HCScore_Character.class == "Priest" then
            playerName = "|cFFFFFFFF"..HCScore_Character.name.."|r"
        elseif HCScore_Character.class == "Rouge" then
            playerName = "|cFFFFF468"..HCScore_Character.name.."|r"
        elseif HCScore_Character.class == "Shaman" then
            playerName = "|cFF0070DD"..HCScore_Character.name.."|r"
        elseif HCScore_Character.class == "Warlock" then
            playerName = "|cFF8788EE"..HCScore_Character.name.."|r"
        elseif HCScore_Character.class == "Warrior" then
            playerName = "|cFFC69B6D"..HCScore_Character.name.."|r"
        end

        -- Print fun stuff for the player
        print("|cff81b7e9".."Hardcore Score: ".."|r".."Welcome "..playerName.." to Hardcore Score v0.9.7.  Lets GO!")
        --print("|cff81b7e9".."Hardcore Score: ".."|r".."Psst,", playerName.. "! "..  string.format("%.2f", HCS_PlayerCoreScore:GetCoreScore()).. " is a great score!");   

    end

end

local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:RegisterEvent("PLAYER_LOGIN")
events:SetScript("OnEvent", Hardcore_Score.init);

