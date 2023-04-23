
-- Namespaces
local _, Hardcore_Score = ...; 
-- Define your addon's namespace

-- Globals
HCScore_Character = {
    name = "",
    class = "",
    level = 0,
    scores = {
        coreScore = 0,
        equippedGearScore = 0,
        hcAchievementScore = 0,
        levelingScore = 0,
        timeBonusScore = 0,
        questingScore = 0,
        mobsKilledScore = 0,
        professionsScore = 0,
        dungeonsScore = 0,
        reputationScore = 0,
        discoveryScore = 0,
    },
    quests = {},
    professions = {
        alchemy = 0,
        alchemyElixirmaster = 0,
        alchemyPotionmaster = 0,
        alchemyTransmutationmaster = 0,
        blacksmithing = 0,
        blacksmithingArmorsmith = 0,
        blacksmithingWeaponsmith = 0,
        enchanting = 0,
        engineering = 0,
        engineeringGnomish = 0,
        engineeringGoblin = 0,
        herbalism = 0,
        leatherworking = 0,
        leatherworkingDragonscale = 0,
        leatherworkingElemental = 0,
        leatherworkingTribal = 0,
        mining = 0,
        skinning = 0,
        tailoring = 0,
        tailoringMooncloth = 0,
        tailoringShadoweave = 0,
        tailoringSpellfire = 0,
        fishing = 0,
        cooking = 0,
        firstaid = 0,
    }
}    


-- Custom Slash Command
Hardcore_Score.commands = {
 --   ["show"] = Hardcore_Score.Scoreboard.Toggle, -- this is a function (no knowledge of Config object)

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
    local hex = select(4, Scoreboard:GetThemeColor());
    local prefix = string.format("|cff%s%s|r", hex:upper(), "Hardcore Scoreboard:");
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, tostringall(...)));    
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
--    SlashCmdList.SLASH_GETGEARINFO = PlayerEquippedGearScore:GetEquippedGearScore()
    
    SLASH_FRAMESTK1 = "/fs"; -- new slash command for showing framestack tool
    SlashCmdList.FRAMESTK = function ()
        LoadAddOn("Blizzard_DebugTools");
        FrameStackTooltip_Toggle();        
    end

--    SLASH_Scoreboard1 = "/lb";
--    SlashCmdList.Scoreboard = HandleSlashCommands;

    -- Load the saved variables data for your addon
 --   HCScore_Character = _G[ADDON_NAMESPACE] or {}

    -- Set the default values for your addon's saved variables
--    HCScore_StoredVariables = HCScore_StoredVariables or {}

    -- Save the updated values back to the store variables file
--    _G[ADDON_NAMESPACE] = HCScore_StoredVariables
 --   CharacterInfo = HCScore_StoredVariables.CharacterInfo

    -- initialization HCScore_Character
    if HCScore_Character.name == nil then HCScore_Character.name = "" end
    if HCScore_Character.class == nil then HCScore_Character.class = "" end
    if HCScore_Character.level == nil then HCScore_Character.level = 0 end
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
    if HCScore_Character.scores.timeBonusScore == nil then HCScore_Character.scores.timeBonusScore = 0 end
    if HCScore_Character.professions == nil then HCScore_Character.professions = {} end
    if HCScore_Character.professions.alchemy == nil then HCScore_Character.professions.alchemy = 0 end
    if HCScore_Character.professions.alchemyElixirmaster == nil then HCScore_Character.professions.alchemyElixirmaster = 0 end
    if HCScore_Character.professions.alchemyPotionmaster == nil then HCScore_Character.professions.alchemyPotionmaster = 0 end
    if HCScore_Character.professions.alchemyTransmutationmaster == nil then HCScore_Character.professions.alchemyTransmutationmaster = 0 end
    if HCScore_Character.professions.blacksmithing == nil then HCScore_Character.professions.blacksmithing = 0 end
    if HCScore_Character.professions.blacksmithingArmorsmith == nil then HCScore_Character.professions.blacksmithingArmorsmith = 0 end
    if HCScore_Character.professions.blacksmithingWeaponsmith == nil then HCScore_Character.professions.blacksmithingWeaponsmith = 0 end
    if HCScore_Character.professions.enchanting == nil then HCScore_Character.professions.enchanting = 0 end
    if HCScore_Character.professions.engineering == nil then HCScore_Character.professions.engineering = 0 end
    if HCScore_Character.professions.engineeringGnomish == nil then HCScore_Character.professions.engineeringGnomish = 0 end
    if HCScore_Character.professions.engineeringGoblin == nil then HCScore_Character.professions.engineeringGoblin = 0 end
    if HCScore_Character.professions.herbalism == nil then HCScore_Character.professions.herbalism = 0 end
    if HCScore_Character.professions.leatherworking == nil then HCScore_Character.professions.leatherworking = 0 end
    if HCScore_Character.professions.leatherworkingDragonscale == nil then HCScore_Character.professions.leatherworkingDragonscale = 0 end
    if HCScore_Character.professions.leatherworkingElemental == nil then HCScore_Character.professions.leatherworkingElemental = 0 end
    if HCScore_Character.professions.leatherworkingTribal == nil then HCScore_Character.professions.leatherworkingTribal = 0 end
    if HCScore_Character.professions.mining == nil then HCScore_Character.professions.mining = 0 end
    if HCScore_Character.professions.skinning == nil then HCScore_Character.professions.skinning = 0 end
    if HCScore_Character.professions.tailoring == nil then HCScore_Character.professions.tailoring = 0 end
    if HCScore_Character.professions.tailoringMooncloth == nil then HCScore_Character.professions.tailoringMooncloth = 0 end
    if HCScore_Character.professions.tailoringShadoweave == nil then HCScore_Character.professions.tailoringShadoweave = 0 end
    if HCScore_Character.professions.tailoringSpellfire == nil then HCScore_Character.professions.tailoringSpellfire = 0 end
    if HCScore_Character.professions.fishing == nil then HCScore_Character.professions.fishing = 0 end
    if HCScore_Character.professions.cooking == nil then HCScore_Character.professions.cooking = 0 end
    if HCScore_Character.professions.firstaid == nil then HCScore_Character.professions.firstaid = 0 end

    if HCScore_Character.name == "" then
        PlayerInfo:LoadCharacterData()
    end

--    Hardcore_Score:Print("Psst, ", UnitName("player").. "! "..  HCScore_Character.scores.coreScore.. " is a great Hardcore score!");

    Scoreboard:CreateUI()
    Hardcore_Score:Print("Psst, ", UnitName("player").. "! "..  HCScore_Character.scores.coreScore.. " is a great score! LET'S GO!");
    
--    Scoreboard:UpdateUI()
--    Hardcore_Score:Print("Psst, ", UnitName("player").. "! "..  HCScore_Character.scores.coreScore.. " is a great Hardcore score!");
end

local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", Hardcore_Score.init);



--[[
events:SetScript("OnEvent", function(self, event, addonName)
    if addonName == ADDON_NAME then
        print(addonName)
        core.init(addonName)
        -- Access the saved variable data and update your UI here
        local characterInfo = Backup_CharacterInfo
        print(characterInfo.name)
        print(characterInfo.class)
        print(characterInfo.level)
        print(characterInfo.scores.coreScore)
        print(characterInfo.quests.quest.questId)
        CharacterInfo = characterInfo       
        events:UnregisterEvent("ADDON_LOADED")
    end
end)
]]

--[[
-- Define your addon's namespace
local ADDON_NAME = "Hardcore_Score"
local ADDON_NAMESPACE = "Hardcore_ScoreNamespace"

-- Create a table to store your addon's saved variables
local Hardcore_Score_SavedVariables = {}

-- Define a function to initialize your addon's saved variables
local function InitSavedVariables()
    -- Load the saved variables data for your addon
    Hardcore_Score_SavedVariables = _G[ADDON_NAMESPACE] or {}

    -- Set the default values for your addon's saved variables
    Hardcore_Score_SavedVariables.CharacterInfo = Hardcore_Score_SavedVariables.CharacterInfo or {
        name = "",
        class = "",
        level = 0,
        scores = {
            coreScore = 0,
            equippedGearScore = 0,
            hcAchievementScore = 0,
            levelingScore = 0,
            timeBonusScore = 0,
            questingScore = 0,
            mobsKilledScore = 0,
            professionsScore = 0,
            dungeonsScore = 0,
        },
        quests = {
            quest = {
                questId = 0,
            },
        },
    }

    -- Save the updated values back to the store variables file
    _G[ADDON_NAMESPACE] = Hardcore_Score_SavedVariables
end

-- Register an event handler to initialize your addon's saved variables when the addon is loaded
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == ADDON_NAME then
        InitSavedVariables()
        -- Access the saved variable data and update your UI here
        local characterInfo = Hardcore_Score_SavedVariables.CharacterInfo
        print(characterInfo.name)
        print(characterInfo.class)
        print(characterInfo.level)
        print(characterInfo.scores.coreScore)
        print(characterInfo.quests.quest.questId)
        eventFrame:UnregisterEvent("ADDON_LOADED")
    end
end)
]]

