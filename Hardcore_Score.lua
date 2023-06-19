local AceDB = LibStub("AceDB-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

-- Namespaces
local _;  
Hardcore_Score = {}

-- Globals
HCS_Version = "0.9.0.1" --GetAddOnMetadata("Hardcore Score", "Version")
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
}    

-- Define your options table
local options = {
    name = "Hardcore Score",
    type = "group",
    args = {
        enable = {
            name = "Share your score",
            desc = "Enables / disables sharing your score with others",
            type = "toggle",
            set = function(info,val) Hardcore_Score.db.profile.shareDetails = val end,  -- update your set function
            get = function(info) return Hardcore_Score.db.profile.shareDetails end  -- update your get function
        },
        twitterLink = {
            name = "Follow us on Twitter at https://twitter.com//HardcoreScore",
            desc = "https://twitter.com//HardcoreScore",
            type = "description",
            order = 1
        },
        discordLink = {
            name = "Join our Discord server at https://discord.gg/hWhhEryF",
            desc = "https://discord.gg/hWhhEryF",
            type = "description",
            order = 2
        },
        addonInfo = {
            name = "Addon Information",
            desc = "Here you can put any other info about the addon...",
            type = "description",
            order = 3
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
            --HCS_MessageFrameUI.DisplayMessage("This is a test message!")
            HCS_WelcomeUI:ToggleMyFrame()            
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

-- WARNING: self automatically becomes events frame!
function Hardcore_Score:init(event, name)
    if (name ~= "Hardcore_Score") then return end

    -- allows using left and right buttons to move through chat 'edit' box
    for i = 1, NUM_CHAT_WINDOWS do
        _G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false);
    end

    -- Register Slash Commands!
    SLASH_RELOADUI1 = "/rl"; -- new slash command for reloading UI
    SlashCmdList.RELOADUI = ReloadUI;

    -- Register Slash Commands!
--    SLASH_GETGEARINFO1 = "/gearinfo"; -- new slash command for getting gearinfo
--    SlashCmdList.SLASH_GETGEARINFO = HCS_PlayerEquippedGearScore:GetEquippedGearScore()
    
    SLASH_FRAMESTK1 = "/fs"; -- new slash command for showing framestack tool
    SlashCmdList.FRAMESTK = function ()
        LoadAddOn("Blizzard_DebugTools");
        FrameStackTooltip_Toggle();        
    end

--    SLASH_HCS_ScoreboardUI1 = "/lb";
--    SlashCmdList.HCS_ScoreboardUI = HandleSlashCommands;

    -- Load the saved variables data for your addon
 --   HCScore_Character = _G[ADDON_NAMESPACE] or {}

    -- Set the default values for your addon's saved variables
--    HCScore_StoredVariables = HCScore_StoredVariables or {}

    -- Save the updated values back to the store variables file
--    _G[ADDON_NAMESPACE] = HCScore_StoredVariables
 --   CharacterInfo = HCScore_StoredVariables.CharacterInfo
    
    -- initalization Hardcore_Score_Settings
    if Hardcore_Score_Settings == nil then Hardcore_Score_Settings = {} end

    HCS_Playerinfo:LoadCharacterData()
    print("LoadCharacterData")

    HCS_ScoreboardSummaryUI:CreateFrame()
    print("HCS_ScoreboardSummaryUI:Create")

    Hardcore_Score:CreateDB()
    print("CreateDB")

    -- Create minimap button
    Hardcore_Score:CreateMiniMapButton()
    print("CreateMiniMapButton")

    -- Get frame saved position
    Hardcore_Score:LoadSavedFramePosition()    
    print("LoadSavedFramePosition")

    -- Register the options table
    AceConfig:RegisterOptionsTable("Hardcore_Score", options)
    print("RegisterOptionsTable")

    -- Add the options table to the Blizzard interface options
    AceConfigDialog:AddToBlizOptions("Hardcore_Score", "Hardcore Score")
    print("AddToBlizOptions")

    HCS_CalculateScore:RefreshScores()
    print("RefreshScores")

    -- Print fun stuff for the player    
--    Hardcore_Score:Print("Psst, ", UnitName("player").. "! "..  string.format("%.2f", HCScore_Character.scores.coreScore).. " is a great score! LET'S GO!");
    print("Psst, ", UnitName("player").. "! "..  string.format("%.2f", HCS_PlayerCoreScore:GetCoreScore()).. " is a great score! LET'S GO!");   
end

local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", Hardcore_Score.init);

