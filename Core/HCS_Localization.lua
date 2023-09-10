-- Localization.lua

-- Load AceLocale-3.0
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")

local professionLocals = {
  ["First Aid"] = {
      ["ptBR"] = "Primeiros Socorros",
      ["ruRU"] = "Первая помощь",
      ["deDE"] = "Erste Hilfe",
      ["koKR"] = "응급치료",
      ["esMX"] = "Primeros auxilios",
      ["enUS"] = "First Aid",
      ["zhCN"] = "急救",
      ["zhTW"] = "急救",
      ["esES"] = "Primeros auxilios",
      ["frFR"] = "Secourisme",
  },
  ["Blacksmithing"] = {
      ["ptBR"] = "Ferraria",
      ["ruRU"] = "Кузнечное дело",
      ["deDE"] = "Schmiedekunst",
      ["koKR"] = "대장기술",
      ["esMX"] = "Herrería",
      ["enUS"] = "Blacksmithing",
      ["zhCN"] = "锻造",
      ["zhTW"] = "鍛造",
      ["esES"] = "Herrería",
      ["frFR"] = "Forge",
  },
  ["Leatherworking"] = {
      ["ptBR"] = "Couraria",
      ["ruRU"] = "Кожевничество",
      ["deDE"] = "Lederverarbeitung",
      ["koKR"] = "가죽세공",
      ["esMX"] = "Peletería",
      ["enUS"] = "Leatherworking",
      ["zhCN"] = "制皮",
      ["zhTW"] = "製皮",
      ["esES"] = "Peletería",
      ["frFR"] = "Travail du cuir",
  },
  ["Alchemy"] = {
      ["ptBR"] = "Alquimia",
      ["ruRU"] = "Алхимия",
      ["deDE"] = "Alchimie",
      ["koKR"] = "연금술",
      ["esMX"] = "Alquimia",
      ["enUS"] = "Alchemy",
      ["zhCN"] = "炼金术",
      ["zhTW"] = "鍊金術",
      ["esES"] = "Alquimia",
      ["frFR"] = "Alchimie",
  },
  ["Herbalism"] = {
      ["ptBR"] = "Herborismo",
      ["ruRU"] = "Травничество",
      ["deDE"] = "Kräuterkunde",
      ["koKR"] = "약초채집",
      ["esMX"] = "Herboristería",
      ["enUS"] = "Herbalism",
      ["zhCN"] = "草药学",
      ["zhTW"] = "草藥學",
      ["esES"] = "Herboristería",
      ["frFR"] = "Herboristerie",
  },
  ["Cooking"] = {
      ["ptBR"] = "Culinária",
      ["ruRU"] = "Кулинария",
      ["deDE"] = "Kochkunst",
      ["koKR"] = "요리",
      ["esMX"] = "Cocina",
      ["enUS"] = "Cooking",
      ["zhCN"] = "烹饪",
      ["zhTW"] = "烹飪",
      ["esES"] = "Cocina",
      ["frFR"] = "Cuisine",
  },
  ["Mining"] = {
      ["ptBR"] = "Mineração",
      ["ruRU"] = "Горное дело",
      ["deDE"] = "Bergbau",
      ["koKR"] = "채광",
      ["esMX"] = "Minería",
      ["enUS"] = "Mining",
      ["zhCN"] = "采矿",
      ["zhTW"] = "採礦",
      ["esES"] = "Minería",
      ["frFR"] = "Minage",
  },
  ["Tailoring"] = {
      ["ptBR"] = "Alfaiataria",
      ["ruRU"] = "Портняжное дело",
      ["deDE"] = "Schneiderei",
      ["koKR"] = "재봉술",
      ["esMX"] = "Sastrería",
      ["enUS"] = "Tailoring",
      ["zhCN"] = "裁缝",
      ["zhTW"] = "裁縫",
      ["esES"] = "Sastrería",
      ["frFR"] = "Couture",
  },
  ["Engineering"] = {
      ["ptBR"] = "Engenharia",
      ["ruRU"] = "Инженерное дело",
      ["deDE"] = "Ingenieurskunst",
      ["koKR"] = "기계공학",
      ["esMX"] = "Ingeniería",
      ["enUS"] = "Engineering",
      ["zhCN"] = "工程学",
      ["zhTW"] = "工程學",
      ["esES"] = "Ingeniería",
      ["frFR"] = "Ingénierie",
  },
  ["Enchanting"] = {
      ["ptBR"] = "Encantamento",
      ["ruRU"] = "Наложение чар",
      ["deDE"] = "Verzauberkunst",
      ["koKR"] = "마법부여",
      ["esMX"] = "Encantamiento",
      ["enUS"] = "Enchanting",
      ["zhCN"] = "附魔",
      ["zhTW"] = "附魔",
      ["esES"] = "Encantamiento",
      ["frFR"] = "Enchantement",
  },
  ["Fishing"] = {
      ["ptBR"] = "Pescaria",
      ["ruRU"] = "Рыбная ловля",
      ["deDE"] = "Angeln",
      ["koKR"] = "낚시",
      ["esMX"] = "Pesca",
      ["enUS"] = "Fishing",
      ["zhCN"] = "钓鱼",
      ["zhTW"] = "釣魚",
      ["esES"] = "Pesca",
      ["frFR"] = "Pêche",
  },
  ["Skinning"] = {
      ["ptBR"] = "Esfolamento",
      ["ruRU"] = "Снятие шкур",
      ["deDE"] = "Kürschnerei",
      ["koKR"] = "무두질",
      ["esMX"] = "Desuello",
      ["enUS"] = "Skinning",
      ["zhCN"] = "剥皮",
      ["zhTW"] = "剝皮",
      ["esES"] = "Desuello",
      ["frFR"] = "Dépeçage",
  },
  ["Jewelcrafting"] = {
      ["ptBR"] = "Joalheria",
      ["ruRU"] = "Ювелирное дело",
      ["deDE"] = "Juwelierskunst",
      ["koKR"] = "보석세공",
      ["esMX"] = "Joyería",
      ["enUS"] = "Jewelcrafting",
      ["zhCN"] = "珠宝加工",
      ["zhTW"] = "珠寶設計",
      ["esES"] = "Joyería",
      ["frFR"] = "Joaillerie",
  },
  ["Riding"] = {
      ["ptBR"] = "Montaria",
      ["ruRU"] = "Верховая езда",
      ["deDE"] = "Reiten",
      ["koKR"] = "탈것 타기",
      ["esMX"] = "Equitación",
      ["enUS"] = "Riding",
      ["zhCN"] = "骑术",
      ["zhTW"] = "騎術",
      ["esES"] = "Equitación",
      ["frFR"] = "Monte",
  },
  ["Inscription"] = {
      ["ptBR"] = "Escrivania",
      ["ruRU"] = "Начертание",
      ["deDE"] = "Inschriftenkunde",
      ["koKR"] = "주문각인",
      ["esMX"] = "Inscripción",
      ["enUS"] = "Inscription",
      ["zhCN"] = "铭文",
      ["zhTW"] = "銘文學",
      ["esES"] = "Inscripción",
      ["frFR"] = "Calligraphie",
  },
}

-- Create a new localization instance
local L = AceLocale:NewLocale("Hardcore_Score", "enUS", true)

-- English (enUS) localization
if L then
  L["First Aid"] = professionLocals["First Aid"]["enUS"]
  L["Blacksmithing"] = professionLocals["Blacksmithing"]["enUS"]
  L["Leatherworking"] = professionLocals["Leatherworking"]["enUS"]
  L["Alchemy"] = professionLocals["Alchemy"]["enUS"]
  L["Herbalism"] = professionLocals["Herbalism"]["enUS"]
  L["Cooking"] = professionLocals["Cooking"]["enUS"]
  L["Mining"] = professionLocals["Mining"]["enUS"]
  L["Tailoring"] = professionLocals["Tailoring"]["enUS"]
  L["Engineering"] = professionLocals["Engineering"]["enUS"]
  L["Enchanting"] = professionLocals["Enchanting"]["enUS"]
  L["Fishing"] = professionLocals["Fishing"]["enUS"]
  L["Skinning"] = professionLocals["Skinning"]["enUS"]
  L["Jewelcrafting"] = professionLocals["Jewelcrafting"]["enUS"]
  L["Riding"] = professionLocals["Riding"]["enUS"]
  L["Inscription"] = professionLocals["Inscription"]["enUS"]

end

-- German (deDE) localization
if GetLocale() == "deDE" then
  L = AceLocale:NewLocale("Hardcore_Score", "deDE")
  if L then
    L["First Aid"] = professionLocals["First Aid"]["deDE"] -- "Erste Hilfe"
    L["Blacksmithing"] = professionLocals["Blacksmithing"]["deDE"]
    L["Leatherworking"] = professionLocals["Leatherworking"]["deDE"]
    L["Alchemy"] = professionLocals["Alchemy"]["deDE"]
    L["Herbalism"] = professionLocals["Herbalism"]["deDE"]
    L["Cooking"] = professionLocals["Cooking"]["deDE"]
    L["Mining"] = professionLocals["Mining"]["deDE"]
    L["Tailoring"] = professionLocals["Tailoring"]["deDE"]
    L["Engineering"] = professionLocals["Engineering"]["deDE"]
    L["Enchanting"] = professionLocals["Enchanting"]["deDE"]
    L["Fishing"] = professionLocals["Fishing"]["deDE"]
    L["Skinning"] = professionLocals["Skinning"]["deDE"]
    L["Jewelcrafting"] = professionLocals["Jewelcrafting"]["deDE"]
    L["Riding"] = professionLocals["Riding"]["deDE"]
    L["Inscription"] = professionLocals["Inscription"]["deDE"]
  end
end

-- French (frFR) localization
if GetLocale() == "frFR" then
  L = AceLocale:NewLocale("Hardcore_Score", "frFR")
  if L then
    L["First Aid"] = professionLocals["First Aid"]["frFR"] 
    L["Blacksmithing"] = professionLocals["Blacksmithing"]["frFR"]
    L["Leatherworking"] = professionLocals["Leatherworking"]["frFR"]
    L["Alchemy"] = professionLocals["Alchemy"]["frFR"]
    L["Herbalism"] = professionLocals["Herbalism"]["frFR"]
    L["Cooking"] = professionLocals["Cooking"]["frFR"]
    L["Mining"] = professionLocals["Mining"]["frFR"]
    L["Tailoring"] = professionLocals["Tailoring"]["frFR"]
    L["Engineering"] = professionLocals["Engineering"]["frFR"]
    L["Enchanting"] = professionLocals["Enchanting"]["frFR"]
    L["Fishing"] = professionLocals["Fishing"]["frFR"]
    L["Skinning"] = professionLocals["Skinning"]["frFR"]
    L["Jewelcrafting"] = professionLocals["Jewelcrafting"]["frFR"]
    L["Riding"] = professionLocals["Riding"]["frFR"]
    L["Inscription"] = professionLocals["Inscription"]["frFR"]
  end
end

-- Portuguese (Brazil) (ptBR) localization
if GetLocale() == "ptBR" then
  L = AceLocale:NewLocale("Hardcore_Score", "ptBR")
  if L then
    L["First Aid"] = professionLocals["First Aid"]["ptBR"] 
    L["Blacksmithing"] = professionLocals["Blacksmithing"]["ptBR"]
    L["Leatherworking"] = professionLocals["Leatherworking"]["ptBR"]
    L["Alchemy"] = professionLocals["Alchemy"]["ptBR"]
    L["Herbalism"] = professionLocals["Herbalism"]["ptBR"]
    L["Cooking"] = professionLocals["Cooking"]["ptBR"]
    L["Mining"] = professionLocals["Mining"]["ptBR"]
    L["Tailoring"] = professionLocals["Tailoring"]["ptBR"]
    L["Engineering"] = professionLocals["Engineering"]["ptBR"]
    L["Enchanting"] = professionLocals["Enchanting"]["ptBR"]
    L["Fishing"] = professionLocals["Fishing"]["ptBR"]
    L["Skinning"] = professionLocals["Skinning"]["ptBR"]
    L["Jewelcrafting"] = professionLocals["Jewelcrafting"]["ptBR"]
    L["Riding"] = professionLocals["Riding"]["ptBR"]
    L["Inscription"] = professionLocals["Inscription"]["ptBR"]
  end
end

-- Spanish (esES) localization
if GetLocale() == "esES" then
  L = AceLocale:NewLocale("Hardcore_Score", "esES")
  if L then
    L["First Aid"] = professionLocals["First Aid"]["esES"] 
    L["Blacksmithing"] = professionLocals["Blacksmithing"]["esES"]
    L["Leatherworking"] = professionLocals["Leatherworking"]["esES"]
    L["Alchemy"] = professionLocals["Alchemy"]["esES"]
    L["Herbalism"] = professionLocals["Herbalism"]["esES"]
    L["Cooking"] = professionLocals["Cooking"]["esES"]
    L["Mining"] = professionLocals["Mining"]["esES"]
    L["Tailoring"] = professionLocals["Tailoring"]["esES"]
    L["Engineering"] = professionLocals["Engineering"]["esES"]
    L["Enchanting"] = professionLocals["Enchanting"]["esES"]
    L["Fishing"] = professionLocals["Fishing"]["esES"]
    L["Skinning"] = professionLocals["Skinning"]["esES"]
    L["Jewelcrafting"] = professionLocals["Jewelcrafting"]["esES"]
    L["Riding"] = professionLocals["Riding"]["esES"]
    L["Inscription"] = professionLocals["Inscription"]["esES"]
  end
end

-- Mexican Spanish (esMX) localization
if GetLocale() == "esMX" then
  L = AceLocale:NewLocale("Hardcore_Score", "esMX")
  if L then
    L["First Aid"] = professionLocals["First Aid"]["esMX"] 
    L["Blacksmithing"] = professionLocals["Blacksmithing"]["esMX"]
    L["Leatherworking"] = professionLocals["Leatherworking"]["esMX"]
    L["Alchemy"] = professionLocals["Alchemy"]["esMX"]
    L["Herbalism"] = professionLocals["Herbalism"]["esMX"]
    L["Cooking"] = professionLocals["Cooking"]["esMX"]
    L["Mining"] = professionLocals["Mining"]["esMX"]
    L["Tailoring"] = professionLocals["Tailoring"]["esMX"]
    L["Engineering"] = professionLocals["Engineering"]["esMX"]
    L["Enchanting"] = professionLocals["Enchanting"]["esMX"]
    L["Fishing"] = professionLocals["Fishing"]["esMX"]
    L["Skinning"] = professionLocals["Skinning"]["esMX"]
    L["Jewelcrafting"] = professionLocals["Jewelcrafting"]["esMX"]
    L["Riding"] = professionLocals["Riding"]["esMX"]
    L["Inscription"] = professionLocals["Inscription"]["esMX"]
  end
end

