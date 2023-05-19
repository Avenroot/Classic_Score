HCS_ProfessionsEvent = {}

local function OnSkillLinesChanged(event)

    HCS_ProfessionsScore:GetNumberOfProfessions()
    Scoreboard.UpdateUI()
    print("A profession have been updated")

end
  
  local _HCS_ProfessionsEvent = CreateFrame("FRAME")
  _HCS_ProfessionsEvent:RegisterEvent("SKILL_LINES_CHANGED")
  _HCS_ProfessionsEvent:SetScript("OnEvent", OnSkillLinesChanged)
  
