HCS_PlayerEquippingItemEvent = {}

-- Create a frame to handle events
local _HCS_PlayerEquippingItemEvent = CreateFrame("Frame")

  _HCS_PlayerEquippingItemEvent:RegisterEvent("UNIT_INVENTORY_CHANGED")

  _HCS_PlayerEquippingItemEvent:SetScript("OnEvent", function(self, event, unit)

    HCS_CalculateScore:RefreshScores()
  --print("executed _HCS_PlayerEquippingItemEvent code")
end)
