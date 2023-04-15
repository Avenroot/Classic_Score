PlayerEquippingItem = {}

-- Create a frame to handle events
local _playerequippingitem = CreateFrame("Frame")

  _playerequippingitem:RegisterEvent("UNIT_INVENTORY_CHANGED")

  _playerequippingitem:SetScript("OnEvent", function(self, event, unit)

  Scoreboard.UpdateUI(nil)

  print("executed _playerequippingitem code")
end)
