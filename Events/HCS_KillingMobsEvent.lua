HCS_KillingMobsEvent = {}

local TRIVAL = 0 -- grey
local EASY = 0.0005 -- green
local MODERATE = 0.00075 -- yellow
local HARD = 0.001 -- orange
local VERYHARD = 0.00125 -- red


function GetXPGain()
    local newXP = UnitXP("player")
    local xpGain = newXP - CurrentXP
    if xpGain < 0 then
        xpGain = (CurrentMaxXP - CurrentXP) + newXP 
    end
    CurrentXP = newXP
    print("xp gained: "..xpGain)
    return xpGain
end

local function between(x, a, b)
    return x >= a and x <= b
  end
  
function GetMobKillHCScore(mobLevel)
    local xpGain = GetXPGain()
    local score = 0

    local playerLevel = UnitLevel("player")
    local levelMod = mobLevel - playerLevel
  
    -- grey
    if levelMod <= -6 then
        score = 0
        print("Mob is grey")
    end
    -- green
    if between(levelMod, -5, -1) then
        score =  xpGain * EASY         
        print("Mob is green")
    end 
    -- yellow
    if between(levelMod, 0, 4) then
        score = xpGain * MODERATE    
        print("Mob is yellow")
    end
    -- orange
    if between(levelMod, 5, 9) then
        score = xpGain * HARD
        print("Mob is orange")
    end
    -- red
    if levelMod > 9 then
        score =  xpGain * VERYHARD
        print("Mob is red")
    end
    
    -- overrides all the other calculations above.  if mobLevel is 0 it means the mob could not be determined so 
    -- the player get a default multiplier of EASY
    if mobLevel == 0 then
        score = xpGain * EASY
        print("Mob level is 0")
    end

    return score    
end

-- This function will be called when a combat event is triggered
function OnCombatEvent(_, event, _, sourceGUID, _, _, _, destGUID, destName, _, _, _, spellID)
    	local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName,
            destFlags, destRaidFlags, damage_spellid, overkill_spellname, school_spellSchool, resisted_amount, blocked_overkill = CombatLogGetCurrentEventInfo()
   -- local   _, event, _, sourceGUID, _, _, _, destGUID, destName, _, _, _, spellID = CombatLogGetCurrentEventInfo()

    if destGUID ~= nil
    then
        local guidType = select(1,strsplit("-", destGUID))
        if (guidType ~= "Player" and guidType ~= "Pet")
        then
            -- When any damage is done by player or player's pet, record the mob
            if (subEvent == "SWING_DAMAGE" or subEvent == "SPELL_DAMAGE")
            then
                MobCombatKill = true
                MobName = destName
                MobLevel = UnitLevel("target")

            elseif (subEvent=="PARTY_KILL")
            then
                MobCombatKill = true
                MobName = destName
                MobLevel = UnitLevel("target")

--[[
                local targetname = UnitName("target")
                local targetlevel = UnitLevel("target")
                local targetid = UnitGUID("target")
                local targetrarity = UnitClassification("target")
                
                print("targetname: ".. targetname)
                print("targetlevel: ".. targetlevel)
                print("targetid: ".. targetid)
                print("targetrarity: ".. targetrarity)
 ]]       

                print(MobCombatKill)
                print(destName.. " - level ".. MobLevel.. " ("..guidType..")")

            elseif (subEvent=="UNIT_DIED" and destGUID ~= nil)
            then
                MobCombatKill = true
                MobName = destName
                MobLevel = UnitLevel("target")
            end
        end
    end
end

-- Register the OnCombatEvent function to be called when a combat event is triggered
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", OnCombatEvent)

local frame2 = CreateFrame("Frame")
frame2:RegisterEvent("PLAYER_XP_UPDATE")
frame2:SetScript("OnEvent", function(event, ...)

    print("In XP Update")
    print(MobCombatKill)

    if MobCombatKill == true then
        local mobScore = GetMobKillHCScore(MobLevel)
        HCS_KillingMobsScore:UpdateMobsKilled(mobScore, MobName)
        print("Points for killing mob:", mobScore)
        MobCombatKill = false
        MobName = ""
        MobLevel = 0
    end    

    Scoreboard.UpdateUI(nil)

    print(MobCombatKill)
    print("Out XP Update")
    
end)
