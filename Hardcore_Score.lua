local AceDB = LibStub("AceDB-3.0")
--local AceConfigDialog = LibStub("AceConfigDialog-3.0")

-- Namespaces
local _;  
Hardcore_Score = {}

-- Globals
HCS_Version = "0.9.0.1" --GetAddOnMetadata("Hardcore Score", "Version")
HCScore_Character = {
    name = "",
    class = "",
    level = 0,
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
        },
    })
end

function Hardcore_Score:CreateMiniMapButton()   
 
    local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("HCScoreMinimapButton", {
        type = "launcher",
        icon = "Interface\\Addons\\Hardcore_Score\\Media\\hcs-minimap-16.blp",  -- XP_ICON, Spell_Nature_Polymorph
        OnClick = function(self, button)
            -- Add OnClick code here
            HCS_MessageFrameUI.DisplayMessage("This is a test message!")
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
    --print("saving location of frame")
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
    
    -- initialization HCScore_Character
    if HCScore_Character.name == nil then HCScore_Character.name = "" end
    if HCScore_Character.class == nil then HCScore_Character.class = "" end
    if HCScore_Character.level == nil then HCScore_Character.level = 0 end
    if HCScore_Character.faction == nil then HCScore_Character.faction = "" end
    if HCScore_Character.version == nil then HCScore_Character.version = HCS_Version end
    if HCScore_Character.deaths == nil then HCScore_Character.version = 0 end
    if HCScore_Character.quests == nil then HCScore_Character.quests = {} end
    if HCScore_Character.scores == nil then HCScore_Character.scores = {} end
    if HCScore_Character.scores.coreScore == nil then HCScore_Character.scores.coreScore = 0 end
    if HCScore_Character.scores.discoveryScore == nil then HCScore_Character.scores.discoveryScore = 0 end
    if HCScore_Character.scores.dungeonsScore == nil then HCScore_Character.scores.dungeonsScore = 0 end
    if HCScore_Character.scores.equippedGearScore == nil then HCScore_Character.scores.equippedGearScore = 0 end
    if HCScore_Character.scores.hcAchievementScore == nil then HCScore_Character.scores.hcAchievementScore = 0 end
    if HCScore_Character.scores.levelingScore == nil then HCScore_Character.scores.levelingScore = 0 end
    if HCScore_Character.scores.mobsKilledScore == nil then HCScore_Character.scores.mobsKilledScore = 0 end
    if HCScore_Character.scores.professionsScore == nil then HCScore_Character.scores.professionsScore = 0 end
    if HCScore_Character.scores.questingScore == nil then HCScore_Character.scores.questingScore = 0 end
    if HCScore_Character.scores.reputationScore == nil then HCScore_Character.scores.reputationScore = 0 end
    if HCScore_Character.scores.milestonesScore == nil then HCScore_Character.scores.milestonesScore = 0 end        
    if HCScore_Character.professions == nil then HCScore_Character.professions = {} end
    if HCScore_Character.professions.alchemy == nil then HCScore_Character.professions.alchemy = 0 end
    if HCScore_Character.professions.blacksmithing == nil then HCScore_Character.professions.blacksmithing = 0 end
    if HCScore_Character.professions.enchanting == nil then HCScore_Character.professions.enchanting = 0 end
    if HCScore_Character.professions.engineering == nil then HCScore_Character.professions.engineering = 0 end
    if HCScore_Character.professions.herbalism == nil then HCScore_Character.professions.herbalism = 0 end
    if HCScore_Character.professions.leatherworking == nil then HCScore_Character.professions.leatherworking = 0 end
    if HCScore_Character.professions.lockpicking == nil then HCScore_Character.professions.lockpicking = 0 end
    if HCScore_Character.professions.mining == nil then HCScore_Character.professions.mining = 0 end
    if HCScore_Character.professions.skinning == nil then HCScore_Character.professions.skinning = 0 end
    if HCScore_Character.professions.tailoring == nil then HCScore_Character.professions.tailoring = 0 end
    if HCScore_Character.professions.fishing == nil then HCScore_Character.professions.fishing = 0 end
    if HCScore_Character.professions.cooking == nil then HCScore_Character.professions.cooking = 0 end
    if HCScore_Character.professions.firstaid == nil then HCScore_Character.professions.firstaid = 0 end
    if HCScore_Character.reputations == nil then HCScore_Character.reputations = {} end
    if HCScore_Character.mobsKilled == nil then HCScore_Character.mobsKilled = {} end
    if HCScore_Character.discovery == nil then HCScore_Character.discovery = {} end
    if HCScore_Character.milestones == nil then HCScore_Character.milestones = {} end


    HCS_Playerinfo:LoadCharacterData()


    HCS_ScoreboardSummaryUI:CreateFrame()

    HCS_CalculateScore:RefreshScores()
    Hardcore_Score:CreateDB()

    -- Create minimap button
    Hardcore_Score:CreateMiniMapButton()

    -- Get frame saved position
    Hardcore_Score:LoadSavedFramePosition()    

--[[    
    -- Load Tooltip to see other players scores
    local playerScores = _G["HCScore_Character"] or {}

    -- Hook the tooltip after the saved variables have been loaded

    GameTooltip:HookScript("OnTooltipSetUnit", function(self)
        -- Get the unit's information
        print("Trying to setup tooltip..")
        local name, unit = self:GetUnit()
       
        print(UnitIsPlayer(unit))
        print(playerScores.coreScore)
        -- If this unit is a player, and you have a score stored for them, then display it
        if UnitIsPlayer(unit) and playerScores then
            self:AddLine("Hardcore Score: " .. string.format("%.2f", playerScores.scores.coreScore) )
            print('Setup tooltip')
        end
    end)    
]]

    -- Print fun stuff for the player    
--    Hardcore_Score:Print("Psst, ", UnitName("player").. "! "..  string.format("%.2f", HCScore_Character.scores.coreScore).. " is a great score! LET'S GO!");
    print("Psst, ", UnitName("player").. "! "..  string.format("%.2f", HCScore_Character.scores.coreScore).. " is a great score! LET'S GO!");   
end

local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", Hardcore_Score.init);

