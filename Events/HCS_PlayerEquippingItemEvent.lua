HCS_PlayerEquippingItemEvent = {}

-- Create a frame to handle events
local _HCS_PlayerEquippingItemEvent = CreateFrame("Frame")

  _HCS_PlayerEquippingItemEvent:RegisterEvent("UNIT_INVENTORY_CHANGED")

  _HCS_PlayerEquippingItemEvent:SetScript("OnEvent", function(self, event, unit)
   _G["ScoringDescriptions"].equippedGearScore = "Equipment update"
   HCS_CalculateScore:RefreshScores(ScoringDescriptions)

end)
