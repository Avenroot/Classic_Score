local AceGUI = LibStub("AceGUI-3.0")
local debug = false

-- Namespaces
--local _, Scoreboard = ...;
Scoreboard = {};

--local UIScoreboard
--local Hardcore_Score_Settings
--local charframetext
local txt_core_score
local txt_core_separator
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


-- Defaults (usually a database!)
local defaults = {
    theme = {
        r = 0,
        g = 0.8,
        b = 1,
        hex = "00ccff"
    },
    
    minimap = true

}

-- Leaderboard functions
-- Save the frame position to the database
local function SavePositionToDatabase()

    local point, relativeTo, relativePoint, xOfs, yOfs = UIScoreboard:GetPoint()
    Hardcore_Score_Settings.profile.framePosition = {
        point = point,
        --  relativeTo = relativeTo:GetName(),
        relativePoint = relativePoint,
        xOfs = xOfs,
        yOfs = yOfs,
    }

end

-- Load Saved Frame Position
local function LoadSavedFramePosition()
    local framePosition = Hardcore_Score_Settings.profile.framePosition
    if framePosition then
        local relativeTo = _G[framePosition.relativeTo]
        if relativeTo then
            UIScoreboard:SetPoint(framePosition.point, relativeTo, framePosition.relativePoint, framePosition.xOfs, framePosition.yOfs)
        end
    end
end

 function Scoreboard:Toggle()
    local SB = UIScoreboard or Scoreboard:CreateUI()

    if SB then
        if SB:IsShown() then
            SavePositionToDatabase()
            SB:Hide()
        else
            LoadSavedFramePosition()
            SB:Show()
         --   Scoreboard:CreateUI()
        end
    end
end

function Scoreboard:GetThemeColor()
    local c = defaults.theme;
    return c.r, c.g, c.b, c.hex;
end


-- Setup Scoreboard and get data
function Scoreboard:CreateUI()
 
    UIScoreboard = AceGUI:Create("HardcoreScoreboard")

    --local pinfo = PlayerInfo:GetPlayerInfo()
    --UIScoreboard:SetTitle(CharacterInfo.name)
    UIScoreboard:SetTitle("Hardcore Score")
    UIScoreboard:SetHeight(225)
    UIScoreboard:SetWidth(210)

    -- When (If) we release this when hiding we need to recreate when showing... causes a problem atm.
    UIScoreboard:SetCallback("OnClose", function(widget)

        --        SavePositionToDatabase()
        --        AceGUI:Release(widget)
        --        print("OnClose callback()")
    end)


    local spacetext = AceGUI:Create("Label")
    spacetext:SetText("")
    spacetext:SetColor(0, 255, 128)
    spacetext:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(spacetext)

    -- Total Hardcore Score
    local cscore = HCScore_Character.scores.coreScore
    txt_core_score = AceGUI:Create("Label")
    --txt_core_score:SetText(string.format("%-10s %.2f","Score:  ", cscore))
    txt_core_score:SetColor(0, 255, 0)
    txt_core_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_core_score)

    -- line separator
    txt_core_separator = AceGUI:Create("Label")
    txt_core_separator:SetText("-----")
    txt_core_separator:SetColor(0, 255, 0)
    txt_core_separator:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_core_separator)

    -- Equipped Gear Score
    --local cgearbonus = HCScore_Character.scores.equippedGearScore
    txt_equippedgear_score = AceGUI:Create("Label")
    --txt_equippedgear_score:SetText(string.format("%-10s %.2f","Equipped Gear:  ", cgearbonus))
    txt_equippedgear_score:SetColor(0, 255, 128)
    txt_equippedgear_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_equippedgear_score)

    -- Leveling Score
    --local clevelingscore = HCScore_Character.scores.levelingScore
    txt_leveling_score = AceGUI:Create("Label")
    --txt_leveling_score:SetText(string.format("%-10s %.2f","Leveling:  ", clevelingscore))
    txt_leveling_score:SetColor(0, 255, 128)
    txt_leveling_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_leveling_score)

    -- Leveling Time Bonus Score
    --local ctimebonus = HCScore_Character.scores.timeBonusScore
    txt_timebonus_score = AceGUI:Create("Label")
    --txt_timebonus_score:SetText(string.format("%-10s %.2f","Time Bonus:  ", ctimebonus))
    txt_timebonus_score:SetColor(0, 255, 128)
    txt_timebonus_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_timebonus_score)

    -- Questing Score
    --local cquestingScore = HCScore_Character.scores.questingScore
    txt_questing_score = AceGUI:Create("Label")
    --txt_questing_score:SetText(string.format("%-10s %.2f","Questing:  ", cquestingScore))
    txt_questing_score:SetColor(0, 255, 128)
    txt_questing_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_questing_score)
    
    -- Mobs Killed Score
    --local ckilledmobsScore = HCScore_Character.scores.mobsKilledScore
    txt_mobskilled_score = AceGUI:Create("Label")
    --txt_mobskilled_score:SetText(string.format("%-10s %.2f","Mobs Killed:  ", ckilledmobsScore))
    txt_mobskilled_score:SetColor(0, 255, 128)
    txt_mobskilled_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_mobskilled_score)
    
    -- Professions Score 
    --local cprofessionsScore = HCScore_Character.scores.professionsScore
    --local cnumprofessions = HCS_ProfessionsScore:GetNumberOfProfessions()
    txt_professions_score = AceGUI:Create("Label")
    --txt_professions_score:SetText(string.format("%-10s %.2f","Professions ("..cnumprofessions.."):  ", cprofessionsScore))
    txt_professions_score:SetColor(0, 255, 128)
    txt_professions_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_professions_score)

    -- Reputation Score 
    --local creputationScore = HCScore_Character.scores.reputationScore
    --local cnumofreputations = HCS_ReputationScore:GetNumFactions()
    txt_reputation_score = AceGUI:Create("Label")
    --txt_reputation_score:SetText(string.format("%-10s %.2f","Reputation ("..cnumofreputations.."):  ", creputationScore))
    txt_reputation_score:SetColor(0, 255, 128)
    txt_reputation_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_reputation_score)

    -- Hardcore Achievements Score
    --local phcAchievementscore = HCScore_Character.scores.hcAchievementScore
    txt_hcachievement_score = AceGUI:Create("Label")
    --txt_hcachievement_score:SetText(string.format("%-10s %.2f","HC Achievements:  ", phcAchievementscore))
    txt_hcachievement_score:SetColor(0.5, 0.5, 0.5)
    txt_hcachievement_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_hcachievement_score)

    -- Dungeons Score 
    --local cdungeonsScore = HCScore_Character.scores.dungeonsScore
    txt_dungeons_score = AceGUI:Create("Label")
    --txt_dungeons_score:SetText(string.format("%-10s %.2f","Dungeons:  ", cdungeonsScore))
    txt_dungeons_score:SetColor(0.5, 0.5, 0.5)
    txt_dungeons_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_dungeons_score)

    -- Discovery Score 
    --local cdiscoveryScore = HCScore_Character.scores.discoveryScore
    txt_discovery_score = AceGUI:Create("Label")
    --txt_discovery_score:SetText(string.format("%-10s %.2f","Discovery:  ", cdiscoveryScore))
    txt_discovery_score:SetColor(0.5, 0.5, 0.5)
    txt_discovery_score:SetFontObject(GameFontNormal)
    UIScoreboard:AddChild(txt_discovery_score)

    -- CharacterFrame button with score
--[[
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
     charframetext:SetTextColor(0, 255, 0) -- Green
]]
end

function Scoreboard:UpdateUI()        
    PlayerInfo:LoadCharacterData()
    
    local totProfessions = HCS_ProfessionsScore:GetNumberOfProfessions()
    local totReputations = HCS_ReputationScore:GetNumFactions()
    local totMobTypesKilled = HCS_KillingMobsScore:GetNumMobTypes()

    txt_core_score:SetText("Score: "..string.format("%.2f", HCScore_Character.scores.coreScore))
    txt_equippedgear_score:SetText("Equipped Gear: "..string.format("%.2f", HCScore_Character.scores.equippedGearScore))    
    txt_leveling_score:SetText("Leveling: "..string.format("%.2f", HCScore_Character.scores.levelingScore))
    txt_timebonus_score:SetText("Time Bonus: "..string.format("%.2f", HCScore_Character.scores.timeBonusScore))
    txt_questing_score:SetText("Questing: "..string.format("%.2f", HCScore_Character.scores.questingScore))
    txt_mobskilled_score:SetText("Mobs Killed ("..totMobTypesKilled.."): "..string.format("%.2f", HCScore_Character.scores.mobsKilledScore))
    txt_professions_score:SetText("Professions ("..totProfessions.."): "..string.format("%.2f", HCScore_Character.scores.professionsScore))
    txt_hcachievement_score:SetText("HC Achievements: "..string.format("%.2f",HCScore_Character.scores.hcAchievementScore))
    txt_reputation_score:SetText("Reputation ("..totReputations.."): "..string.format("%.2f", HCScore_Character.scores.reputationScore))
    txt_discovery_score:SetText("Discovery: "..string.format("%.2f", HCScore_Character.scores.discoveryScore))
    txt_dungeons_score:SetText("Dungeons: "..string.format("%.2f", HCScore_Character.scores.dungeonsScore))

  --  charframetext:SetText(string.format("%.2f", HCScore_Character.scores.coreScore))

    --print("executed Scoreboard:UpdateUI()")
end



