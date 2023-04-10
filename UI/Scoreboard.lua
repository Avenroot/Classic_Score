local AceGUI = LibStub("AceGUI-3.0")
local AceDB = LibStub("AceDB-3.0")
local debug = false

-- Namespaces
local _, core = ...;
core.Scoreboard = {};
Scoreboard = core.Scoreboard;

local UIScoreboard;
local Hardcore_Score_Settings;
-----------------------

function Scoreboard:CreateDB()
    -- Load AceDB-3.0
    local AceDB = LibStub("AceDB-3.0")

    -- Create a new database for your addon
    Hardcore_Score_Settings = AceDB:New("Hardcore_Score_Settings", {
        profile = {
            framePosition = {
                point = "TOPLEFT",  --"CENTER",
                relativeTo = "UIParent",
                relativePoint = "BOTTOMLEFT", -- "CENTER",
                xOfs = 0,
                yOfs = 0,
            },
        },
        print("DB Created")
    })    

    print("x "..Hardcore_Score_Settings.profile.framePosition.xOfs)
    print("y "..Hardcore_Score_Settings.profile.framePosition.yOfs)
    
end

-- Defaults (usually a database!)
local defaults = {
    theme = {
        r = 0,
        g = 0.8,
        b = 1,
        hex = "00ccff"
    }
}

-- Leaderboard functions
function Scoreboard:Toggle()
    local SB = UIScoreboard or Scoreboard:CreateUI();
        if SB:IsShown() then
            SB:Hide()
        else
            Scoreboard:CreateUI()
        end
end

function Scoreboard:GetThemeColor()
    local c = defaults.theme;
    return c.r, c.g, c.b, c.hex;
end


-- Setup Scoreboard and get data
function Scoreboard:CreateUI()

    Scoreboard:CreateDB()
    UIScoreboard = AceGUI:Create("HardcoreScoreboard")

    --local pinfo = PlayerInfo:GetPlayerInfo()
    UIScoreboard:SetTitle(CharacterInfo.name)
    UIScoreboard:SetHeight(200)
    UIScoreboard:SetWidth(200)

    -- Use the HardcoreScoreDB database to load and save the frame's position
    UIScoreboard.OnAcquire = function(self)
        local db = Hardcore_Score_Settings.profile.framePosition
        UIScoreboard:ClearAllPoints()
        UIScoreboard:SetPoint(db.point, UIParent, db.relativePoint, db.xOfs, db.yOfs)
        print("OnAcquire")
        print("x "..db.xOfs)
        print("y "..db.yOfs)
        UIScoreboard:Show()
    end

    UIScoreboard.OnRelease = function(self)
        local db = Hardcore_Score_Settings.profile.framePosition
        db.xOfs, db.yOfs = self.frame:GetLeft(), self.frame:GetTop()
        print("OnRelease")
        print("x "..db.xOfs);
        print("y "..db.yOfs)
    end    


    UIScoreboard:SetPoint(Hardcore_Score_Settings.profile.framePosition.point, UIParent, 
        Hardcore_Score_Settings.profile.framePosition.relativePoint, Hardcore_Score_Settings.profile.framePosition.xOfs,
        Hardcore_Score_Settings.profile.framePosition.yOfs)

    print("x "..Hardcore_Score_Settings.profile.framePosition.xOfs)
    print("y "..Hardcore_Score_Settings.profile.framePosition.yOfs)
 
--[[
    -- Save the frame position when it moves
    UIScoreboard:SetCallback("OnDragStop", function(self)
        HardcoreScoreDB.profile.framePosition.point, HardcoreScoreDB.profile.framePosition.relativeTo, 
        HardcoreScoreDB.profile.framePosition.relativePoint, HardcoreScoreDB.profile.framePosition.xOfs,
        HardcoreScoreDB.profile.framePosition.yOfs = self:GetPoint()
        print("finished dragging")
    end)
    
    UIScoreboard:SetCallback("OnClick", function(self) print("clicked")end)
]]  
  
    UIScoreboard:SetCallback("OnClose", function(widget) 
    AceGUI:Release(widget) end)    

    local text = AceGUI:Create("Label")
    text:SetText("")
    text:SetColor(0, 255, 128)
    text:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(text)

    local pscore = CharacterInfo.scores.coreScore
    local txtCoreScore = AceGUI:Create("Label")
    txtCoreScore:SetText("Core - "..pscore)
    txtCoreScore:SetColor(0, 255, 128)
    txtCoreScore:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txtCoreScore)

    local phcAchievementscore = CharacterInfo.scores.hcAchievementScore
    local txtHCAchievementScore = AceGUI:Create("Label")
    txtHCAchievementScore:SetText("HC Achievements - "..phcAchievementscore)
    txtHCAchievementScore:SetColor(0, 255, 128)
    txtHCAchievementScore:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txtHCAchievementScore)

    local ptimebonus = CharacterInfo.scores.timeBonusScore
    local txt_timebonus_score = AceGUI:Create("Label")
    txt_timebonus_score:SetText("Time Bonus - "..ptimebonus)
    txt_timebonus_score:SetColor(0, 255, 128)
    txt_timebonus_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_timebonus_score)

    local pgearbonus = CharacterInfo.scores.gearbonusScore
    local txt_gearbonus_score = AceGUI:Create("Label")
    txt_gearbonus_score:SetText("Gear Bonus - "..pgearbonus)
    txt_gearbonus_score:SetColor(0, 255, 128)
    txt_gearbonus_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_gearbonus_score)

    local plevelingscore = CharacterInfo.scores.levelingScore
    local txt_leveling_score = AceGUI:Create("Label")
    txt_leveling_score:SetText("Leveling - "..plevelingscore)
    txt_leveling_score:SetColor(0, 255, 128)
    txt_leveling_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_leveling_score)

    -- CharacterFrame button with score
    local button = CreateFrame("Button", "HCScore", CharacterFrame, "UIPanelButtonTemplate")
    button:SetPoint("TOPLEFT", CharacterFrame, "TOPLEFT", 150, -56)
    button:SetSize(80, 17)
    button:SetText("HC Score")
    button:SetScript("OnClick", function() 
        print("Button Clicked!")
        Scoreboard:Toggle()
     end)        
     
     local text = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
     text:SetPoint("TOPLEFT", CharacterFrame, "TOPLEFT", 235, -59)
     text:SetText(CharacterInfo.scores.coreScore)
     text:SetTextColor(0, 255, 128) -- Blue

end



