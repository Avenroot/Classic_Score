HCS_ProfessionsEvent = {}

local function OnSkillLinesChanged(event)
    HCS_CalculateScore:RefreshScores("Profession")  
end
  
  local _HCS_ProfessionsEvent = CreateFrame("FRAME")
  _HCS_ProfessionsEvent:RegisterEvent("SKILL_LINES_CHANGED")
  _HCS_ProfessionsEvent:SetScript("OnEvent", OnSkillLinesChanged)
  
