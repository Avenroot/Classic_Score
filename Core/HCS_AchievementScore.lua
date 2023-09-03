HCS_AchievementScore = {}


local newAchievement = {
    id = 0,
    points = 0,
  }

local function AddAchievement(id)

    local found = false

  -- look up if achievement has been achieved
    for _, achievement in pairs(HCScore_Character.achievements) do
        if achievement.id == id then
            found = true
            break
        end
    end

    if not found then
        -- add achievement
        for _, achievement in pairs(HCS_AchievementsDB) do
            if achievement.id == id then
                newAchievement = {
                    id = achievement.id,
                    points = achievement.points,
                }
--                DEFAULT_CHAT_FRAME:AddMessage("|cffADD8E6This is light blue text!|r")

                HCS_Utils:Print("|cff81b7e9"..achievement.desc.."|r")                

                --print("|cff81b7e9"..milestone.desc.."|r")     
                table.insert(HCScore_Character.achievements, newAchievement)
                
                HCS_PointsLogUI:AddMessage(achievement.desc) 

                if Hardcore_Score.db.profile.framePositionMsg.show then
                    local desc = string.upper(achievement.shortdesc)
                    local frame = HCS_MessageFrameUI.DisplayAchievementMessage(desc, achievement.image, 5)
                    frame:ShowMessage() 
                end
            end
        end
    end
end

local function CheckLeveling()
    local level = UnitLevel("player")

    if level >= 10 then AddAchievement("ach_lvl_1") end    
    if level >= 20 then AddAchievement("ach_lvl_2") end    
    if level >= 30 then AddAchievement("ach_lvl_3") end
    if level >= 40 then AddAchievement("ach_lvl_4") end
    if level >= 50 then AddAchievement("ach_lvl_5") end
    if level >= 60 then AddAchievement("ach_lvl_6") end
    if level >= 70 then AddAchievement("ach_lvl_7") end    
    if level == 80 then AddAchievement("ach_lvl_8") end

end

local function CheckMobKillsTotal()

    local total = 0

    for _, mob in pairs(HCScore_Character.mobsKilled) do
        total = total + mob.kills
    end

    if total >= 1000 then AddAchievement("ach_mobk_1") end
    if total >= 5000 then AddAchievement("ach_mobk_2") end
    if total >= 10000 then AddAchievement("ach_mobk_3") end

end

local function CheckMobKillsByType()
    local mobskilled = #HCScore_Character.mobsKilled

    if mobskilled >= 100 then AddAchievement("ach_mobkt_1") end
    if mobskilled >= 200 then AddAchievement("ach_mobkt_2") end

end

local function CheckQuestTotals()

    local total = #HCScore_Character.quests

    if total >= 100 then AddAchievement("ach_qtot_1") end
    if total >= 500 then AddAchievement("ach_qtot_2") end
    if total >= 1000 then AddAchievement("ach_qtot_3") end

end

local function CheckDiscoveryTotals()

    local total = #HCScore_Character.discovery

    if total >= 100 then AddAchievement("ach_disc_1") end
    if total >= 500 then AddAchievement("ach_disc_2") end
    if total >= 1000 then AddAchievement("ach_disc_3") end

end

local function CheckDangerousEnemiesKilled()

    local total = 0

    for _, mob in pairs(HCScore_Character.dangerousMobsKilled) do
        total = total + mob.kills
    end

    if total >= 1 then AddAchievement("ach_dek_1") end
    if total >= 100 then AddAchievement("ach_dek_2") end
    if total >= 500 then AddAchievement("ach_dek_3") end
    if total >= 1000 then AddAchievement("ach_dek_4") end

end

function HCS_AchievementScore:CheckAchievements()

    CheckLeveling()
    CheckMobKillsTotal()
    CheckMobKillsByType()
    CheckQuestTotals()
    CheckDiscoveryTotals()
    CheckDangerousEnemiesKilled()
    
end

function HCS_AchievementScore:GetAchievementsScore()

    local score = 0

    for _, achievement in pairs(HCScore_Character.achievements) do
        score = score + achievement.points
    end   
    
    return score
end

function HCS_AchievementScore:GetNumberOfAchievements()
    return #HCScore_Character.achievements
end
