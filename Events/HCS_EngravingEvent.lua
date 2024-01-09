HCS_EngravingEvent = {}

function HCS_EngravingEvent:GetAllRunesInfo()

    local allRunesInfo = {}
    local categories = C_Engraving.GetRuneCategories(true, false)

    for _, category in ipairs(categories) do
        local runes = C_Engraving.GetRunesForCategory(category, false)
        for _, rune in ipairs(runes) do
            table.insert(allRunesInfo, {
                name = rune.name,
                iconTexture = rune.iconTexture,
                collected = rune.collected -- Assuming 'collected' is a boolean field in the rune data
            })
        end
    end

    return allRunesInfo
end

function HCS_EngravingEvent:GetCollectedRunesInfo()
    
    HCScore_Character.runes = HCScore_Character.runes or {}

    local categories = C_Engraving.GetRuneCategories(true, true)

    for _, category in ipairs(categories) do
        local runes = C_Engraving.GetRunesForCategory(category, true)

        for _, rune in ipairs(runes) do
            local runeAlreadyExists = false
            -- Check if this rune is already in the table
            for _, existingRune in ipairs(HCScore_Character.runes) do
                if existingRune.name == rune.name then
                    runeAlreadyExists = true
                    break
                end
            end

            -- If the rune is not already in the table, add it with score = 50
            if not runeAlreadyExists then
                table.insert(HCScore_Character.runes, {
                    name = rune.name,
                    iconTexture = rune.iconTexture,
                    score = 50  -- Set the score to 50 for each new rune
                })
            end
        end
    end
end

local function OnLearnNewEngraving()

    HCS_EngravingEvent:GetCollectedRunesInfo()

    _G["ScoringDescriptions"].runeScore = "New Rune Discovered"
    HCS_CalculateScore:RefreshScores(ScoringDescriptions)

end

function OnPlayerEquipmentChanged()
--    print("OnPlayerEquipmentChanged")

--    print("----------------------")
    HCS_EngravingEvent:GetCollectedRunesInfo() -- Call this to populate the runes data
    
--    for _, runeInfo in ipairs(HCScore_Character.runes) do
--        print("Rune Name: " .. runeInfo.name .. ", Icon Texture: " .. runeInfo.iconTexture)
        -- Additional logic to utilize the rune data
--    end
    
    
--    print("----------------------")
    local runesInfo = HCS_EngravingEvent:GetAllRunesInfo()
--    for _, runeInfo in ipairs(runesInfo) do
--        local collectedStatus = runeInfo.collected and "Collected" or "Not Collected"
--        print("Rune Name: " .. runeInfo.name .. ", Icon Texture: " .. runeInfo.iconTexture .. ", Status: " .. collectedStatus)
        -- Here, you can add your code to display this information in your custom UI
--    end

    
end

function HCS_EngravingEvent:GetNumberOfRunes()
    return #HCScore_Character.runes
end

function HCS_EngravingEvent:GetRunesScore()
    local score = 0

    for _, rune in pairs(HCScore_Character.runes) do
        score = score + rune.score
    end

    return score
end


local frameLearnNewRecipe = CreateFrame("Frame")
frameLearnNewRecipe:RegisterEvent("NEW_RECIPE_LEARNED")
frameLearnNewRecipe:SetScript("OnEvent", OnLearnNewEngraving)

local framePlayerEquipmentChanged = CreateFrame("Frame")
framePlayerEquipmentChanged:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
framePlayerEquipmentChanged:SetScript("OnEvent", OnPlayerEquipmentChanged)

