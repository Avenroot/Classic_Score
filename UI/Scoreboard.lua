local AceGUI = LibStub("AceGUI-3.0")
local debug = false

-- Namespaces
--local _, Scoreboard = ...;
Scoreboard = {};

local UIScoreboard
local Hardcore_Score_Settings
local charframetext
local txt_core_score
local txt_equippedgear_score
local txt_leveling_score
local txt_mobskilled_score
local txt_timebonus_score
local txt_professions_score
local txt_hcachievement_score
local txt_questing_score
local txt_dungeons_score
local txt_reputation_score
local txt_discovery_score

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
--        print("DB Created")
    })    

--    print("x "..Hardcore_Score_Settings.profile.framePosition.xOfs)
--    print("y "..Hardcore_Score_Settings.profile.framePosition.yOfs)
    
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
    if SB ~= nil then
        if SB:IsShown() then
            SB:Hide()
        else
            Scoreboard:CreateUI()
        end
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
    --UIScoreboard:SetTitle(CharacterInfo.name)
    UIScoreboard:SetTitle("Hardcore Score")
    UIScoreboard:SetHeight(225)
    UIScoreboard:SetWidth(210)

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

    -- Total Hardcore Score
    local cscore = HCScore_Character.scores.coreScore
    txt_core_score = AceGUI:Create("Label")
    txt_core_score:SetText("Score: "..string.format("%.2f", cscore))
    txt_core_score:SetColor(0, 255, 128)
    txt_core_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_core_score)

    -- Equipped Gear Score
    local cgearbonus = HCScore_Character.scores.equippedGearScore
    txt_equippedgear_score = AceGUI:Create("Label")
    txt_equippedgear_score:SetText("Equipped Gear: "..string.format("%.2f", cgearbonus))
    txt_equippedgear_score:SetColor(0, 255, 128)
    txt_equippedgear_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_equippedgear_score)

    -- Leveling Score
    local clevelingscore = HCScore_Character.scores.levelingScore
    txt_leveling_score = AceGUI:Create("Label")
    txt_leveling_score:SetText("Leveling: "..string.format("%.2f", clevelingscore))
    txt_leveling_score:SetColor(0, 255, 128)
    txt_leveling_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_leveling_score)

    -- Leveling Time Bonus Score
    local ctimebonus = HCScore_Character.scores.timeBonusScore
    txt_timebonus_score = AceGUI:Create("Label")
    txt_timebonus_score:SetText("Time Bonus: "..string.format("%.2f", ctimebonus))
    txt_timebonus_score:SetColor(0, 255, 128)
    txt_timebonus_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_timebonus_score)

    -- Questing Score
    local cquestingScore = HCScore_Character.scores.questingScore
    txt_questing_score = AceGUI:Create("Label")
    txt_questing_score:SetText("Questing: "..string.format("%.2f", cquestingScore))
    txt_questing_score:SetColor(0, 255, 128)
    txt_questing_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_questing_score)
    
    -- Mobs Killed Score
    local ckilledmobsScore = HCScore_Character.scores.mobsKilledScore
    txt_mobskilled_score = AceGUI:Create("Label")
    txt_mobskilled_score:SetText("Mobs Killed: "..string.format("%.2f", ckilledmobsScore))
    txt_mobskilled_score:SetColor(0, 255, 128)
    txt_mobskilled_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_mobskilled_score)
    
    -- Professions Score 
    local cprofessionsScore = HCScore_Character.scores.professionsScore
    local cnumprofessions = HCS_ProfessionsScore:GetNumberOfProfessions()
    txt_professions_score = AceGUI:Create("Label")
    txt_professions_score:SetText("Professions ("..cnumprofessions.."): "..string.format("%.2f", cprofessionsScore))
    txt_professions_score:SetColor(0, 255, 128)
    txt_professions_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_professions_score)

    -- Hardcore Achievements Score
    local phcAchievementscore = HCScore_Character.scores.hcAchievementScore
    txt_hcachievement_score = AceGUI:Create("Label")
    txt_hcachievement_score:SetText("HC Achievements: "..string.format("%.2f", phcAchievementscore))
    txt_hcachievement_score:SetColor(0, 255, 128)
    txt_hcachievement_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_hcachievement_score)

    -- Dungeons Score 
    local cdungeonsScore = HCScore_Character.scores.dungeonsScore
    txt_dungeons_score = AceGUI:Create("Label")
    txt_dungeons_score:SetText("Dungeons: "..string.format("%.2f", cdungeonsScore))
    txt_dungeons_score:SetColor(0, 255, 128)
    txt_dungeons_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_dungeons_score)

    -- Reputation Score 
    local creputationScore = HCScore_Character.scores.reputationScore
    txt_reputation_score = AceGUI:Create("Label")
    txt_reputation_score:SetText("Reputation: "..string.format("%.2f", creputationScore))
    txt_reputation_score:SetColor(0, 255, 128)
    txt_reputation_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_reputation_score)

    -- Discovery Score 
    local cdiscoveryScore = HCScore_Character.scores.reputationScore
    txt_discovery_score = AceGUI:Create("Label")
    txt_discovery_score:SetText("Discovery: "..string.format("%.2f", cdiscoveryScore))
    txt_discovery_score:SetColor(0, 255, 128)
    txt_discovery_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_discovery_score)

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
     charframetext:SetText(string.format("%.2f", HCScore_Character.scores.coreScore))
     charframetext:SetTextColor(0, 255, 128) -- Blue

end

function Scoreboard:UpdateUI()        
    PlayerInfo:LoadCharacterData()
    
    local totProfessions = HCS_ProfessionsScore:GetNumberOfProfessions()
    print("totProfessions: "..totProfessions)

    txt_core_score:SetText("Score: "..string.format("%.2f", HCScore_Character.scores.coreScore))
    txt_equippedgear_score:SetText("Equipped Gear: "..string.format("%.2f", HCScore_Character.scores.equippedGearScore))    
    txt_leveling_score:SetText("Leveling: "..string.format("%.2f", HCScore_Character.scores.levelingScore))
    txt_timebonus_score:SetText("Time Bonus: "..string.format("%.2f", HCScore_Character.scores.timeBonusScore))
    txt_questing_score:SetText("Questing: "..string.format("%.2f", HCScore_Character.scores.questingScore))
    txt_mobskilled_score:SetText("Mobs Killed: "..string.format("%.2f", HCScore_Character.scores.mobsKilledScore))
    txt_professions_score:SetText("Professions ("..totProfessions.."): "..string.format("%.2f", HCScore_Character.scores.professionsScore))
    txt_hcachievement_score:SetText("HC Achievements: "..string.format("%.2f",HCScore_Character.scores.hcAchievementScore))
    txt_dungeons_score:SetText("Reputation: "..string.format("%.2f", HCScore_Character.scores.reputationScore))
    txt_dungeons_score:SetText("Discovery: "..string.format("%.2f", HCScore_Character.scores.discoveryScore))
    txt_dungeons_score:SetText("Dungeons: "..string.format("%.2f", HCScore_Character.scores.dungeonsScore))

    charframetext:SetText(string.format("%.2f", HCScore_Character.scores.coreScore))

    --print("executed Scoreboard:UpdateUI()")
end


