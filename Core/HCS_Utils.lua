HCS_Utils = {}

function HCS_Utils:GetClassImage(class)
    local image = Img_hcs_Class_None -- default image

    if class == "Druid" then 
        image = Img_hcs_Class_Druid
    elseif class == "Hunter" then
        image = Img_hcs_Class_Hunter
    elseif class == "Mage" then
        image = Img_hcs_Class_Mage
    elseif class == "Paladin" then
        image = Img_hcs_Class_Paladin
    elseif class == "Priest" then
        image = Img_hcs_Class_Priest
    elseif class == "Rouge" then
        image = Img_hcs_Class_Rouge
    elseif class == "Shaman" then
        image = Img_hcs_Class_Shaman
    elseif class == "Warlock" then
        image = Img_hcs_Class_Warlock
    elseif class == "Warrior" then
        image = Img_hcs_Class_Warrior
    elseif class == "Death Knight" then
        image = Img_hcs_Class_DeathKnight
    end

    return image

end

function HCS_Utils:GetTextWithClassColor(class, text)
    local txt = text

    if class == "Druid" then 
        txt = "|cFFFF7C0A"..text.."|r"
    elseif class == "Hunter" then
        txt = "|cFFAAD372"..text.."|r"
    elseif class == "Mage" then
        txt = "|cFF3FC7EB"..text.."|r"
    elseif class == "Paladin" then
        txt = "|cFFF48CBA"..text.."|r"
    elseif class == "Priest" then
        txt = "|cFFFFFFFF"..text.."|r"
    elseif class == "Rouge" then
        txt = "|cFFFFF468"..text.."|r"
    elseif class == "Shaman" then
        txt = "|cFF0070DD"..text.."|r"
    elseif class == "Warlock" then
        txt = "|cFF8788EE"..text.."|r"
    elseif class == "Warrior" then
        txt = "|cFFC69B6D"..text.."|r"
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


HCS_print = true  -- Global!  Allows you to turn printing on and off if needed in certains
function HCS_Utils:Print(msg)
    
    if HCS_print then
        print(msg)
    end

end
