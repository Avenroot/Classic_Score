local AceGUI = LibStub("AceGUI-3.0")
local AceDB = LibStub("AceDB-3.0")
local debug = false

-- Namespaces
local _, core = ...;
core.Scoreboard = {};
Scoreboard = core.Scoreboard;

local UIScoreboard
local Hardcore_Score_Settings
local charframetext
local txt_leveling_score
local txt_gearbonus_score
local txt_timebonus_score
local txtHCAchievementScore
local txtCoreScore
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
 
    UIScoreboard:SetCallback("OnClose", function(widget) 
    AceGUI:Release(widget) end)    

    local spacetext = AceGUI:Create("Label")
    spacetext:SetText("")
    spacetext:SetColor(0, 255, 128)
    spacetext:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(spacetext)

    local pscore = CharacterInfo.scores.coreScore
    txtCoreScore = AceGUI:Create("Label")
    txtCoreScore:SetText("Core - "..pscore)
    txtCoreScore:SetColor(0, 255, 128)
    txtCoreScore:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txtCoreScore)

    local phcAchievementscore = CharacterInfo.scores.hcAchievementScore
    txtHCAchievementScore = AceGUI:Create("Label")
    txtHCAchievementScore:SetText("HC Achievements - "..phcAchievementscore)
    txtHCAchievementScore:SetColor(0, 255, 128)
    txtHCAchievementScore:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txtHCAchievementScore)

    local ptimebonus = CharacterInfo.scores.timeBonusScore
    txt_timebonus_score = AceGUI:Create("Label")
    txt_timebonus_score:SetText("Time Bonus - "..ptimebonus)
    txt_timebonus_score:SetColor(0, 255, 128)
    txt_timebonus_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_timebonus_score)

    local pgearbonus = CharacterInfo.scores.gearbonusScore
    txt_gearbonus_score = AceGUI:Create("Label")
    txt_gearbonus_score:SetText("Gear Bonus - "..pgearbonus)
    txt_gearbonus_score:SetColor(0, 255, 128)
    txt_gearbonus_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_gearbonus_score)

    local plevelingscore = CharacterInfo.scores.levelingScore
    txt_leveling_score = AceGUI:Create("Label")
    txt_leveling_score:SetText("Leveling - "..plevelingscore)
    txt_leveling_score:SetColor(0, 255, 128)
    txt_leveling_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_leveling_score)

    -- CharacterFrame button with score
    local charframebutton = CreateFrame("Button", "HCScore", CharacterFrame, "UIPanelButtonTemplate")
    charframebutton:SetPoint("TOPLEFT", CharacterFrame, "TOPLEFT", 150, -56)
    charframebutton:SetSize(80, 17)
    charframebutton:SetText("HC Score")
    charframebutton:SetScript("OnClick", function() 
        Scoreboard:Toggle()
     end)        
     
     charframetext = CharacterFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
     charframetext:SetPoint("TOPLEFT", CharacterFrame, "TOPLEFT", 235, -59)
     charframetext:SetText(CharacterInfo.scores.coreScore)
     charframetext:SetTextColor(0, 255, 128) -- Blue

end

function Scoreboard:UpdateUI()

    PlayerInfo.LoadCharacterData(self)
    txtCoreScore:SetText("Core - "..CharacterInfo.scores.coreScore)
    txtHCAchievementScore:SetText("HC Achievements - "..CharacterInfo.scores.hcAchievementScore)    
    txt_timebonus_score:SetText("Time Bonus - "..CharacterInfo.scores.timeBonusScore)
    txt_gearbonus_score:SetText("Gear Bonus - "..CharacterInfo.scores.gearbonusScore)    
    txt_leveling_score:SetText("Leveling - "..CharacterInfo.scores.levelingScore)

    charframetext:SetText(CharacterInfo.scores.coreScore)

    print("executed Scoreboard:UpdateUI()")
end


