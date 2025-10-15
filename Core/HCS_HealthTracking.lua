HCS_HealthTracking = {}

-- In-memory (per-session) lowest HP percent and zone
HCS_HealthTracking.sessionLowestPct = 100.0
HCS_HealthTracking.sessionLowestZone = nil
-- In-memory (per-session) deaths counter
HCS_HealthTracking.sessionDeaths = 0

local function Round2(num)
    -- Round to 2 decimals safely
    return math.floor((num + 0.0005) * 100) / 100
end

function HCS_HealthTracking:EnsureInit()
    -- Initialize saved variable container
    if HCScore_Character == nil then return end
    if HCScore_Character.lowestHealthPct == nil then
        HCScore_Character.lowestHealthPct = 100.0
    end
    if HCScore_Character.lowestHealthZone == nil then
        HCScore_Character.lowestHealthZone = nil
    end
    if self.sessionLowestPct == nil then
        self.sessionLowestPct = 100.0
    end
    if self.sessionLowestZone == nil then
        self.sessionLowestZone = nil
    end
    if self.sessionDeaths == nil then
        self.sessionDeaths = 0
    end
end

-- Build a readable zone string (Zone - Subzone when available)
function HCS_HealthTracking:GetCurrentZoneText()
    local zone = (GetRealZoneText and GetRealZoneText()) or (GetZoneText and GetZoneText()) or ""
    local sub = (GetSubZoneText and GetSubZoneText()) or ""
    local full = zone or ""
    if sub ~= nil and sub ~= "" and sub ~= zone then
        full = string.format("%s - %s", full, sub)
    end
    if full == nil or full == "" then
        full = "Unknown"
    end
    return full
end

function HCS_HealthTracking:UpdateFromUnit(unit)
    if unit ~= "player" then return end
    self:EnsureInit()

    local cur = UnitHealth("player") or 0
    local max = UnitHealthMax("player") or 0
    if max <= 0 then return end

    local pct = (cur / max) * 100.0
    pct = Round2(pct)

    -- Update session record
    if pct < (self.sessionLowestPct or 100.0) then
        self.sessionLowestPct = pct
        self.sessionLowestZone = self:GetCurrentZoneText()
    end

    -- Update lifetime record in saved vars
    if HCScore_Character and pct < (HCScore_Character.lowestHealthPct or 100.0) then
        HCScore_Character.lowestHealthPct = pct
        HCScore_Character.lowestHealthZone = self:GetCurrentZoneText()
    end
end

function HCS_HealthTracking:OnPlayerDead()
    -- Death implies 0%
    self:EnsureInit()
    -- Track per-session deaths (lifetime deaths are handled in HCS_DeathEvent)
    self.sessionDeaths = (self.sessionDeaths or 0) + 1
    if self.sessionLowestPct == nil or 0 < self.sessionLowestPct then
        self.sessionLowestPct = 0.0
        self.sessionLowestZone = self:GetCurrentZoneText()
    end
    if HCScore_Character and (HCScore_Character.lowestHealthPct == nil or 0 < HCScore_Character.lowestHealthPct) then
        HCScore_Character.lowestHealthPct = 0.0
        HCScore_Character.lowestHealthZone = self:GetCurrentZoneText()
    end
end

function HCS_HealthTracking:GetSessionLowestPct()
    self:EnsureInit()
    return self.sessionLowestPct or 100.0
end

function HCS_HealthTracking:GetLifetimeLowestPct()
    self:EnsureInit()
    return (HCScore_Character and HCScore_Character.lowestHealthPct) or 100.0
end

-- Small helpers to provide formatted text (e.g., "50.35%")
function HCS_HealthTracking:GetSessionLowestPctText()
    return string.format("%.2f%%", self:GetSessionLowestPct())
end

function HCS_HealthTracking:GetLifetimeLowestPctText()
    return string.format("%.2f%%", self:GetLifetimeLowestPct())
end

-- Zone getters
function HCS_HealthTracking:GetSessionLowestZone()
    self:EnsureInit()
    return self.sessionLowestZone or "Unknown"
end

function HCS_HealthTracking:GetLifetimeLowestZone()
    self:EnsureInit()
    if HCScore_Character and HCScore_Character.lowestHealthZone and HCScore_Character.lowestHealthZone ~= "" then
        return HCScore_Character.lowestHealthZone
    end
    return "Unknown"
end

function HCS_HealthTracking:GetSessionLowestZoneText()
    return tostring(self:GetSessionLowestZone())
end

function HCS_HealthTracking:GetLifetimeLowestZoneText()
    return tostring(self:GetLifetimeLowestZone())
end

-- Deaths (session)
function HCS_HealthTracking:GetSessionDeaths()
    self:EnsureInit()
    return self.sessionDeaths or 0
end

function HCS_HealthTracking:GetSessionDeathsText()
    return tostring(self:GetSessionDeaths())
end

-- Event frame to watch health changes
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("UNIT_HEALTH")
f:RegisterEvent("UNIT_MAXHEALTH")
f:RegisterEvent("PLAYER_DEAD")

f:SetScript("OnEvent", function(self, event, arg1)
    if event == "PLAYER_LOGIN" or event == "PLAYER_ENTERING_WORLD" then
        HCS_HealthTracking:EnsureInit()
        -- Initialize baselines from current health
        HCS_HealthTracking:UpdateFromUnit("player")
    elseif event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" then
        HCS_HealthTracking:UpdateFromUnit(arg1)
    elseif event == "PLAYER_DEAD" then
        HCS_HealthTracking:OnPlayerDead()
    end
end)
