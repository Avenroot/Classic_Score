HCS_Utils = {}

function HCS_Utils:GetClassImage(classid)

    local image = Img_hcs_Class_None -- default image

    if classid == 11 then -- Druid
        image = Img_hcs_Class_Druid
    elseif classid == 3 then -- Hunter
        image = Img_hcs_Class_Hunter
    elseif classid == 8 then  -- Mage
        image = Img_hcs_Class_Mage
    elseif classid == 2 then -- Paladin
        image = Img_hcs_Class_Paladin
    elseif classid == 5 then -- Priest
        image = Img_hcs_Class_Priest
    elseif classid == 4 then -- Rogue
        image = Img_hcs_Class_Rogue 
    elseif classid == 7 then -- Shaman
        image = Img_hcs_Class_Shaman
    elseif classid == 9 then -- Warlock
        image = Img_hcs_Class_Warlock
    elseif classid == 1 then -- Warrior
        image = Img_hcs_Class_Warrior
    elseif classid == 6 then -- Death Knight
        image = Img_hcs_Class_DeathKnight
    end

    return image

end

function HCS_Utils:GetTextWithClassColor(classid, text)
    local txt = text

    if classid == 11 then -- Druid
        txt = "|cFFFF7C0A"..text.."|r"
    elseif classid == 3 then -- Hunter
        txt = "|cFFAAD372"..text.."|r"
    elseif classid == 8 then -- Mage
        txt = "|cFF3FC7EB"..text.."|r"
    elseif classid == 2 then -- Paladin
        txt = "|cFFF48CBA"..text.."|r"
    elseif classid == 5 then -- Priest
        txt = "|cFFFFFFFF"..text.."|r"
    elseif classid == 4 then -- Rogue
        txt = "|cFFFFF468"..text.."|r"
    elseif classid == 7 then -- Shaman
        txt = "|cFF0070DD"..text.."|r"
    elseif classid == 9 then -- Warlock
        txt = "|cFF8788EE"..text.."|r"
    elseif classid == 1 then -- Warrior
        txt = "|cFFC69B6D"..text.."|r"
    end

    return txt
end

function HCS_Utils:GetClassColorText(classid)
    local txt = ''

    if classid == 11 then -- Druid
        txt = "|cFFFF7C0A".."Druid".."|r"
    elseif classid == 3 then -- Hunter
        txt = "|cFFAAD372".."Hunter".."|r"
    elseif classid == 8 then -- Mage
        txt = "|cFF3FC7EB".."Mage".."|r"
    elseif classid == 2 then -- Paladin
        txt = "|cFFF48CBA".."Paladin".."|r"
    elseif classid == 5 then -- Priest
        txt = "|cFFFFFFFF".."Priest".."|r"
    elseif classid == 4 then -- Rogue
        txt = "|cFFFFF468".."Rogue".."|r"
    elseif classid == 7 then -- Shaman
        txt = "|cFF0070DD".."Shaman".."|r"
    elseif classid == 9 then -- Warlock
        txt = "|cFF8788EE".."Warlock".."|r"
    elseif classid == 1 then -- Warrior
        txt = "|cFFC69B6D".."Warrior".."|r"
    end

    return txt
end

function HCS_Utils:GetTextWithRankColor(rank, text)
    local txt = text    

    if rank == 1 then 
        txt = "|cFFA07672"..text.."|r"
    elseif rank == 2 then
        txt = "|cFFC2C7CB"..text.."|r"
    elseif rank == 3 then
        txt = "|cFFFFDB5D"..text.."|r"
    elseif rank == 4 then
        txt = "|cFFADC0D8"..text.."|r"
    elseif rank == 5 then
        txt = "|cFF4FC9E8"..text.."|r"
    elseif rank == 6 then
        txt = "|cFFE15FE1"..text.."|r"
    elseif rank == 7 then
        txt = "|cFFFFC100"..text.."|r"
    end

    return txt
end

function HCS_Utils:GetTextWithFactionColor(faction, text)
    local txt = text

    if faction == "Horde" then
        txt = "|cFFFF0000Horde"..text.."|r"
    else
        txt = "|cFF0000FFAlliance"..text.."|r"
    end

    return txt
end

function HCS_Utils:GetRankLevelText(rank, level)
    local txt = ""

    if rank == 1 then
        if level == 4 then
            txt = HCS_Utils:GetTextWithRankColor(1, "BRONZE - LVL 4")
        elseif level == 3 then
            txt = HCS_Utils:GetTextWithRankColor(1, "BRONZE - LVL 3")
        elseif level == 2 then
            txt = HCS_Utils:GetTextWithRankColor(1, "BRONZE - LVL 2")
        elseif level == 1 then
            txt = HCS_Utils:GetTextWithRankColor(1, "BRONZE - LVL 1")
        elseif level == 0 then
            txt = HCS_Utils:GetTextWithRankColor(1, "BRONZE")
        end
    elseif rank == 2 then
        if level == 4 then
            txt = HCS_Utils:GetTextWithRankColor(2, "SILVER - LVL 4")
        elseif level == 3 then
            txt = HCS_Utils:GetTextWithRankColor(2, "SILVER - LVL 3")
        elseif level == 2 then
            txt = HCS_Utils:GetTextWithRankColor(2, "SILVER - LVL 2")
        elseif level == 1 then
            txt = HCS_Utils:GetTextWithRankColor(2, "SILVER - LVL 1")
        elseif level == 0 then
            txt = HCS_Utils:GetTextWithRankColor(2, "SILVER")
        end
    elseif rank == 3 then
        if level == 4 then
            txt = HCS_Utils:GetTextWithRankColor(3, "GOLD - LVL 4")
        elseif level == 3 then
            txt = HCS_Utils:GetTextWithRankColor(3, "GOLD - LVL 3")
        elseif level == 2 then
            txt = HCS_Utils:GetTextWithRankColor(3, "GOLD - LVL 2")
        elseif level == 1 then
            txt = HCS_Utils:GetTextWithRankColor(3, "GOLD - LVL 1")
        elseif level == 0 then
            txt = HCS_Utils:GetTextWithRankColor(3, "GOLD")
        end
    elseif rank == 4 then
        if level == 4 then
            txt = HCS_Utils:GetTextWithRankColor(4, "PLATINUM - LVL 4")
        elseif level == 3 then
            txt = HCS_Utils:GetTextWithRankColor(4, "PLATINUM - LVL 3")
        elseif level == 2 then
            txt = HCS_Utils:GetTextWithRankColor(4, "PLATINUM - LVL 2")
        elseif level == 1 then
            txt = HCS_Utils:GetTextWithRankColor(4, "PLATINUM - LVL 1")
        elseif level == 0 then
            txt = HCS_Utils:GetTextWithRankColor(4, "PLATINUM")
        end
    elseif rank == 5 then
        if level == 4 then
            txt = HCS_Utils:GetTextWithRankColor(5, "DIAMOND - LVL 4")
        elseif level == 3 then
            txt = HCS_Utils:GetTextWithRankColor(5, "DIAMOND - LVL 3")
        elseif level == 2 then
            txt = HCS_Utils:GetTextWithRankColor(5, "DIAMOND - LVL 2")
        elseif level == 1 then
            txt = HCS_Utils:GetTextWithRankColor(5, "DIAMOND - LVL 1")
        elseif level == 0 then
            txt = HCS_Utils:GetTextWithRankColor(5, "DIAMOND")
        end
    elseif rank == 6 then
        if level == 4 then
            txt = HCS_Utils:GetTextWithRankColor(6, "EPIC - LVL 4")
        elseif level == 3 then
            txt = HCS_Utils:GetTextWithRankColor(6, "EPIC - LVL 3")
        elseif level == 2 then
            txt = HCS_Utils:GetTextWithRankColor(6, "EPIC - LVL 2")
        elseif level == 1 then
            txt = HCS_Utils:GetTextWithRankColor(6, "EPIC - LVL 1")
        elseif level == 0 then
            txt = HCS_Utils:GetTextWithRankColor(6, "EPIC")
        end
    elseif rank == 7 then
        if level == 4 then
            txt = HCS_Utils:GetTextWithRankColor(7, "LEGENDARY - LVL 4")
        elseif level == 3 then
            txt = HCS_Utils:GetTextWithRankColor(7, "LEGENDARY - LVL 3")
        elseif level == 2 then
            txt = HCS_Utils:GetTextWithRankColor(7, "LEGENDARY - LVL 2")
        elseif level == 1 then
            txt = HCS_Utils:GetTextWithRankColor(7, "LEGENDARY - LVL 1")
        elseif level == 0 then
            txt = HCS_Utils:GetTextWithRankColor(7, "LEGENDARY")
        end
    end
    
    return txt
end

function HCS_Utils:GetPercentageToNextLevelAsText()
    local min = HCS_PlayerRank.MinPoints
    local max = HCS_PlayerRank.MaxPoints
    local current = HCScore_Character.scores.coreScore
    local percentage = ((current - min) / (max - min)) * 100
    local formattedPercentage = string.format("%.2f%%", percentage)
    return formattedPercentage
end

function HCS_Utils:AddThousandsCommas(inputString)
    local formattedString, _ = string.gsub(inputString, "^(-?%d+)(%d%d%d)", '%1,%2')
    return formattedString    
end   

-- Define a consistent structure for character information
local function CreateCharacter(charName, charClass, charLevel, coreScore, hasDied, lastOnline, guildName)
    -- Set default values if they are not provided
    hasDied = hasDied or 0
    lastOnline = lastOnline or date("%Y-%m-%d %H:%M:%S") -- Default to the current date and time
    guildName = guildName or ''

    return {
        charName = charName,
        charClass = charClass,
        charLevel = charLevel,
        coreScore = coreScore,
        hasDied = hasDied,
        lastOnline = lastOnline,
        guildName = guildName,
    }
end

HCS_print = true  -- Global!  Allows you to turn printing on and off if needed in certains
function HCS_Utils:Print(msg)
    
    if HCS_print then
        print(msg)
    end

end
