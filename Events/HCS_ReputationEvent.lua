HCS_ReputationEvent = {}

local frame = CreateFrame("FRAME")
frame:RegisterEvent("UPDATE_FACTION")

local function eventHandler(self, event, ...)
    HCS_ReputationScore:UpdateRepScore()
    _G["ScoringDescriptions"].reputationScore = "Reputation Gain"
    HCS_CalculateScore:RefreshScores(ScoringDescriptions)
end

frame:SetScript("OnEvent", eventHandler)
