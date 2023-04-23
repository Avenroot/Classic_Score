HCS_ProfessionsEvent = {}

local function OnSkillLinesChanged(event)
    if event == "SKILL_LINES_CHANGED" then

        for i = 1, GetNumSkillLines() do
            local skillName, isHeader, _, skillRank, _, _, skillMaxRank, _, _, skillLineID = GetSkillLineInfo(i)
            
            if not isHeader then
                local _, _, _, _, _, _, skillID = GetProfessionInfo(skillLineID)
                
                if skillID then
                    HCS_ProfessionsScore.UpdateProfessionScore(skillLineID, skillRank)
                    print(skillName, "ID:", skillID, "Rank:", skillRank, "Max Rank:", skillMaxRank)
                end
            end
        end

      Scoreboard.UpdateUI(nil)
    end
end
  
  local _HCS_ProfessionsEvent = CreateFrame("FRAME")
  _HCS_ProfessionsEvent:RegisterEvent("SKILL_LINES_CHANGED")
  _HCS_ProfessionsEvent:SetScript("OnEvent", OnSkillLinesChanged)
  

--[[
  local numProfessions = GetNumProfessions()
  
  if numProfessions > 0 then
    for i = 1, numProfessions do
      local _, _, skillLineRank, _, _, _, _, _, _, _, _, _, _, _, _, professionID = GetProfessionInfo(i)

      -- Check if the skill line ID matches the profession that just leveled up
      if professionID == MY_PROFESSION_ID then
        HCS_ProfessionsScore.UpdateProfessionScore(professionID, skillLineRank)
        print("Your profession level in " .. GetProfessionInfo(professionID) .. " has increased to " .. skillLineRank)
      end
    end
  end
]]