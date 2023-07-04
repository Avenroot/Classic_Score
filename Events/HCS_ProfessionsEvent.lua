HCS_ProfessionsEvent = {}

local function OnSkillLinesChanged(event)
  _G["ScoringDescriptions"].professionsScore = "Profession Gain"
  HCS_CalculateScore:RefreshScores(ScoringDescriptions)
end
  
  local _HCS_ProfessionsEvent = CreateFrame("FRAME")
  _HCS_ProfessionsEvent:RegisterEvent("SKILL_LINES_CHANGED")
  _HCS_ProfessionsEvent:SetScript("OnEvent", OnSkillLinesChanged)
  
