HCS_ReputationEvent = {}

local frame = CreateFrame("FRAME")
frame:RegisterEvent("UPDATE_FACTION")

local function eventHandler(self, event, ...)
    HCS_ReputationScore:UpdateRepScore()
    Scoreboard.UpdateUI(nil)
  --  print("Reputation has been updated")
end

frame:SetScript("OnEvent", eventHandler)
