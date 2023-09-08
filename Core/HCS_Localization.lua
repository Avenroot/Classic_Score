-- Localization.lua

-- Load AceLocale-3.0
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")

-- Create a new localization instance
local L = AceLocale:NewLocale("Hardcore_Score", "enUS", true)

-- English (enUS) localization
if L then
  L["Hello"] = "Hello, World!"
end

-- German (deDE) localization
if GetLocale() == "deDE" then
  L = AceLocale:NewLocale("Hardcore_Score", "deDE")
  if L then
    L["Hello"] = "Hallo, Welt!"
  end
end
