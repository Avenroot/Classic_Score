-- Namespaces
local _, core = ...; 
--Hardcore_Score_Settings = {};

-- Custom Slash Command
core.commands = {
    ["show"] = core.Scoreboard.Toggle, -- this is a function (no knowledge of Config object)

    ["help"] = function ()
        print(" ");
        core:Print("List of slash commands:");
        core:Print("|cff00cc66/lb show|r - shows show menu");
        core:Print("|cff00cc66/lb help|r - shows help info");
        print(" ");
    end,

    ["example"] = {
        ["test"] = function(...)
            core:Print("My Value:", tostringall(...));
        end
    }
};

local function HandleSlashCommands(str)
    if (#str == 0) then
        
        --User just entered "/hlb" with no additional args.
        core.commands.help();
        return;
    end

    local args = {}; -- What we will iterate over using the loop (arguments).
    for _, arg in pairs({ string.split(' ', str) }) do
        if (#arg > 0) then -- if string length is greater than 0
            table.insert(args, arg);
        end
    end

    local path = core.commands; -- required for updating found table

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
                core.commands.help();
                return;
            end
        else
            -- does not exist!
            core.commands.help();
            return;
        end
    end
end


function core:Print(...)
    local hex = select(4, self.Scoreboard:GetThemeColor());
    local prefix = string.format("|cff%s%s|r", hex:upper(), "Hardcore Scoreboard:");
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, tostringall(...)));    
end

-- WARNING: self automatically becomes events frame!
function core:init(event, name)
    if (name ~= "Hardcore_Score") then return end
    -- allows using left and right buttons to move through chat 'edit' box
    for i = 1, NUM_CHAT_WINDOWS do
        _G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false);
    end

    -- Register Slash Commands!
    SLASH_RELOADUI1 = "/rl"; -- new slash command for reloading UI
    SlashCmdList.RELOADUI = ReloadUI;

    -- Register Slash Commands!
    SLASH_GETGEARINFO1 = "/gearinfo"; -- new slash command for getting gearinfo
    SlashCmdList.SLASH_GETGEARINFO = PlayerEquippedGearScore:GetEquippedGearScore()
    
    SLASH_FRAMESTK1 = "/fs"; -- new slash command for showing framestack tool
    SlashCmdList.FRAMESTK = function ()
        LoadAddOn("Blizzard_DebugTools");
        FrameStackTooltip_Toggle();        
    end

    SLASH_Scoreboard1 = "/lb";
    SlashCmdList.Scoreboard = HandleSlashCommands;

    PlayerInfo:LoadCharacterData()
    Scoreboard:CreateUI()

    core:Print("Psst, ", UnitName("player").. "! "..  CharacterInfo.scores.coreScore.. " is a great Hardcore score!");
end

function OnFinalized()

    
end

local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", core.init);




