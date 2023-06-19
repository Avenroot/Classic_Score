HCS_ReputationEvent = {}

local frame = CreateFrame("FRAME")
frame:RegisterEvent("UPDATE_FACTION")

local function eventHandler(self, event, ...)
    HCS_ReputationScore:UpdateRepScore()
    HCS_CalculateScore:RefreshScores()  
end

frame:SetScript("OnEvent", eventHandler)
