HCS_Utils = {}

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

function HCS_Utils:GetTextWithFactionColor(faction, text)
    local txt = text

    if faction == "Horde" then
        txt = "|cFFFF0000Horde"..text.."|r"
    else
        txt = "|cFF0000FFAlliance"..text.."|r"
    end

    return txt
end

HCS_print = true  -- Global!  Allows you to turn printing on and off if needed in certains
function HCS_Utils:Print(msg)
    
    if HCS_print then
        print(msg)
    end

end
