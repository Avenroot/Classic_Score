HCS_ProfessionsEvent = {}

local function OnSkillLinesChanged(event)
    if event == "SKILL_LINES_CHANGED" then
      HCS_ProfessionsScore:GetNumberOfProfessions()
      Scoreboard.UpdateUI(nil)
      print("A profession have been updated")
    end
end
  
  local _HCS_ProfessionsEvent = CreateFrame("FRAME")
  _HCS_ProfessionsEvent:RegisterEvent("SKILL_LINES_CHANGED")
  _HCS_ProfessionsEvent:SetScript("OnEvent", OnSkillLinesChanged)
  
