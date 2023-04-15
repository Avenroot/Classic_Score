PlayerEquippedGearScore = {}

local function PrintGearInfo()
    for slotID = 1, 19 do
        local itemLink = GetInventoryItemLink("player", slotID)
        if itemLink then
          local _, _, itemRarity = GetItemInfo(itemLink)
          local itemName, _, _, itemLevel, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
          local color = ITEM_QUALITY_COLORS[itemRarity]          
--          if color.name ~= nil then
--            print(itemName.." ("..itemLevel..") - "..color.hex..color.name.."|r ["..itemEquipLoc.."]")
            --end
          print("itemRarity("..itemRarity..") "..itemName.." ("..itemLevel..") - |r ["..itemEquipLoc.."]")

        end    
    end
end

function PlayerEquippedGearScore:GetEquippedGearScore()
    local itemScore = 0

    for slotID = 1, 19 do
        local itemLink = GetInventoryItemLink("player", slotID)
        if itemLink then
          local _, _, itemRarity = GetItemInfo(itemLink)
          local itemName, _, _, itemLevel, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
          local color = ITEM_QUALITY_COLORS[itemRarity]          
--          if color.name ~= nil then
--            print(itemName.." ("..itemLevel..") - "..color.hex..color.name.."|r ["..itemEquipLoc.."]")
            --end
           -- print("itemRarity("..itemRarity..") "..itemName.." ("..itemLevel..") - |r ["..itemEquipLoc.."]")

           
           local cases = {
            [0] = function() 
              itemScore = (itemLevel * 1.0) + itemScore --grey
            end,
            [1] = function() 
                itemScore = (itemLevel * 1.2) + itemScore --white
            end,
            [2] = function() 
                itemScore = (itemLevel * 2.0) + itemScore --green
            end,
            [3] = function ()
                itemScore = (itemLevel * 3.0) + itemScore --blue
            end,
            [4] = function ()
                itemScore = (itemLevel * 5.0) + itemScore --purple
            end,
            [5] = function ()
                itemScore = (itemLevel * 10.0) + itemScore --orange
            end,
          }

          if cases[itemRarity] then
            cases[itemRarity]()
          else
            -- do nothing
          end          
        
        end
    end
      print("equipped gear score is ".. itemScore)
      --PrintGearInfo()
      return itemScore
        
end

  