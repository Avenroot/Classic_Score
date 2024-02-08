HCS_AchievementScore = {}
local showAchievements = true  -- determines if achievements should be shown in the UI (Popup).  

local function AddAchievement(id)
    local found = false
    if show == nil then show = false end

    -- Check if achievement is already achieved
    for _, achievement in pairs(HCScore_Character.achievements) do
        if achievement.id == id then
            found = true
            break
        end
    end

    local achievementDesc, achievementImage

    if not found then
        -- Check in HCS_AchievementsDB
        for _, achievement in ipairs(HCS_AchievementsDB) do
            if achievement.id == id then
                table.insert(HCScore_Character.achievements, {
                    id = achievement.id,
                    points = achievement.points,
                })
                achievementDesc = achievement.desc
                achievementImage = achievement.image
                found = true
                break
            end
        end
    end

    if HCS_SODVersion then

        if not found then
            -- Check in ClassRuneAchievementTable
            for _, achievement in pairs(HCS_AchievementsDB.ClassRuneAchievementTable) do
                if achievement.id == id then
                    table.insert(HCScore_Character.achievements, {
                        id = achievement.id,
                        points = achievement.points,
                    })
                    achievementDesc = achievement.desc
                    achievementImage = achievement.image
                    break
                end
            end
        end
    end

    if showAchievements then
        if achievementDesc then
            HCS_Utils:Print("|cff81b7e9Achievement! Congrats! "..achievementDesc.."|r")
            HCS_PointsLogUI:AddMessage(achievementDesc)

            if Hardcore_Score.db.profile.framePositionMsg.show then
                local desc = string.upper(achievementDesc)
                local frame = HCS_MessageFrameUI.DisplayAchievementMessage(desc, achievementImage, 5)
                frame:ShowMessage() 
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

local function CheckRunesCompleted()

    for _, rune in pairs(HCScore_Character.runes) do
        
        local runeName = rune.name        

        for _, runeAchievement in ipairs(HCS_AchievementsDB.ClassRuneAchievementTable) do
            if type(runeAchievement) == "table" then  -- Ensure it's a table before processing
                
                if runeAchievement.shortdesc == runeName then
                    AddAchievement(runeAchievement.id)
                end
            end
        end
    end    
end

function HCS_AchievementScore:CheckAchievements()

    CheckLeveling()
    CheckMobKillsTotal()
    CheckMobKillsByType()
    CheckQuestTotals()
    CheckDiscoveryTotals()
    CheckDangerousEnemiesKilled()
    
    --Runes
    if HCS_SODVersion then
        CheckRunesCompleted()
    end
    
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

function HCS_AchievementScore:AchievedAchivement(achievementId)
    local found = false

    -- look up if achievement has been achieved
      for _, achievement in pairs(HCScore_Character.achievements) do
          if achievement.id == achievementId then
              found = true
              break
          end
      end

    return found
end

function HCS_AchievementScore:Reset()
    HCScore_Character.achievements = {}
    showAchievements =false
    HCS_AchievementScore:CheckAchievements()
    showAchievements = true
end