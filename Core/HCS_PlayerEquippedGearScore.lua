HCS_PlayerEquippedGearScore = {}

--[[
function HCS_PlayerEquippedGearScore:GetEquippedGearScore()
  local itemScore = 0

  for slotID = 1, 19 do
      local itemLink = GetInventoryItemLink("player", slotID)
      if itemLink then
          local _, _, itemRarity, itemLevel = GetItemInfo(itemLink)
          
          local multipliers = {
              [0] = 1.0,   -- grey
              [1] = 1.2,   -- white
              [2] = 2.0,   -- green
              [3] = 3.0,   -- blue
              [4] = 5.0,   -- purple
              [5] = 10.0   -- orange
          }

          itemScore = itemScore + (multipliers[itemRarity] or 1) * itemLevel 
      end
  end

  return itemScore  
end
]]

function HCS_PlayerEquippedGearScore:GetEquippedGearScore()
  local itemScore = 0

  for slotID = 1, 19 do
      local itemLink = GetInventoryItemLink("player", slotID)
      if itemLink then
        local _, _, itemRarity = GetItemInfo(itemLink)
        local itemName, _, _, itemLevel, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
        local color = ITEM_QUALITY_COLORS[itemRarity]          
         
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

    return itemScore  
end
