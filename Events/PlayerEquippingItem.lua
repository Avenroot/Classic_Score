PlayerEquippingItem = {}

-- Create a frame to handle events
local _playerequippingitem = CreateFrame("Frame")

_playerequippingitem:RegisterEvent("UNIT_INVENTORY_CHANGED")

_playerequippingitem:SetScript("OnEvent", function(self, event, unit)

  Scoreboard.UpdateUI(nil)

  print("executed _playerequippingitem code")
--[[
    if unit == "player" then
        local weaponSlot = 16 -- The slot ID for the main hand weapon
        local itemLink = GetInventoryItemLink("player", weaponSlot)
        if itemLink then
            -- The player equipped a weapon in the main hand slot
            print("Equipped weapon:", itemLink)
        end
    end
]]    

end)
