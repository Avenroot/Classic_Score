SaveHCScoreData = {}

--local LibSerialize = require("Libs.LibSerialize")

function SaveHCScoreData:SaveVariables()
    -- Serialize the data in MyAddon_SavedVariables to a string
    local serializedData = LibSerialize:Serialize(HCScore_StoredVariables)

    -- Write the serialized data to the saved variables file
    local file = io.open("Interface\\AddOns\\Hardcore_Score\\Hardcore_Score.lua", "w+")
    file:write("HCScore_StoredVariables = ")
    file:write(serializedData)
    file:close()

    -- Reload the UI to ensure the changes are loaded
    ReloadUI()
end

function SaveHCScoreData:UpdateCharacterInfo()
    -- Update the character's name in MyAddon_SavedVariables
    HCScore_StoredVariables.CharacterInfo.name = UnitName("player")

    -- Save the updated data to the saved variables file
    SaveVariables()
end
