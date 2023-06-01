HCS_CalculateScore = {}

LevelScalePercentage = 0

function HCS_CalculateScore:RefreshScores()

    LevelScalePercentage = (UnitLevel("player")  / 60) --* 100

    HCScore_Character.scores.equippedGearScore = HCS_PlayerEquippedGearScore:GetEquippedGearScore() * LevelScalePercentage
    HCScore_Character.scores.levelingScore = HCS_PlayerLevelingScore:GetLevelScore() * LevelScalePercentage
    HCScore_Character.scores.professionsScore = HCS_ProfessionsScore:GetProfessionsScore() * LevelScalePercentage
    HCScore_Character.scores.reputationScore = HCS_ReputationScore:GetReputationScore() * LevelScalePercentage
    HCScore_Character.scores.questingScore = HCS_PlayerQuestingScore:GetQuestingScore()
    HCScore_Character.scores.mobsKilledScore = HCS_KillingMobsScore:GetMobsKilledScore()
    HCScore_Character.scores.discoveryScore = HCS_DiscoveryScore:GetDiscoveryScore()
    HCScore_Character.scores.coreScore = HCS_PlayerCoreScore:GetCoreScore()

    RefreshUI()
    
end

function RefreshUI()
    HCS_ScoreboardSummaryUI:UpdateUI()
end