-- Lightweight in-addon tests for HCS mob kill scoring at level caps
-- Run with: /hcs_tests

local function say(msg, color)
    color = color or "|cff66ccff"
    if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
        DEFAULT_CHAT_FRAME:AddMessage(color .. "[HCS Tests]|r " .. tostring(msg))
    else
        print("[HCS Tests] " .. tostring(msg))
    end
end

local function approxEqual(a, b, eps)
    eps = eps or 1e-4
    return math.abs((a or 0) - (b or 0)) <= eps
end

-- Session-only toggle flag (does not persist across reloads/logins)
_G.HCS_TestHarnessEnabled = _G.HCS_TestHarnessEnabled or false

-- Preserve originals to restore after tests
local _orig = {}

local function saveOriginals()
    _orig.UnitLevel = UnitLevel
    _orig.UnitClassification = UnitClassification
    _orig.UnitName = UnitName
    _orig.CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
    _orig.HCS_XPUpdateEvent = HCS_XPUpdateEvent
    _orig.HCS_CalculateScore = HCS_CalculateScore
    if HCS_CalculateScore and HCS_CalculateScore.RefreshScores then
        _orig.HCS_CalculateScore_RefreshScores = HCS_CalculateScore.RefreshScores
    end
end

local function restoreOriginals()
    if _orig.UnitLevel then UnitLevel = _orig.UnitLevel end
    if _orig.UnitClassification then UnitClassification = _orig.UnitClassification end
    if _orig.UnitName then UnitName = _orig.UnitName end
    if _orig.CombatLogGetCurrentEventInfo then CombatLogGetCurrentEventInfo = _orig.CombatLogGetCurrentEventInfo end
    if _orig.HCS_XPUpdateEvent then HCS_XPUpdateEvent = _orig.HCS_XPUpdateEvent end
    if _orig.HCS_CalculateScore then HCS_CalculateScore = _orig.HCS_CalculateScore end
    if _orig.HCS_CalculateScore_RefreshScores and HCS_CalculateScore then
        HCS_CalculateScore.RefreshScores = _orig.HCS_CalculateScore_RefreshScores
    end
end

-- Simple assertion helpers
local function assertTrue(cond, msg)
    if not cond then error(msg or "assertTrue failed", 2) end
end

local function assertEq(actual, expected, msg)
    if actual ~= expected then
        error(string.format("%s (expected: %s, got: %s)", msg or "assertEq failed", tostring(expected), tostring(actual)), 2)
    end
end

local function assertApprox(actual, expected, msg)
    if not approxEqual(actual, expected) then
        error(string.format("%s (expected: %.5f, got: %.5f)", msg or "assertApprox failed", expected, actual), 2)
    end
end

-- Ensure globals used by the addon exist for tests
local function ensureGlobals()
    _G.HCScore_Character = _G.HCScore_Character or { name = "Tester" }
    _G.ScoringDescriptions = _G.ScoringDescriptions or { mobsKilledScore = "" }
    _G.HCS_GameVersion = _G.HCS_GameVersion or 11404 -- Classic Era style default
    _G.HCS_SODVersion = _G.HCS_SODVersion ~= nil and _G.HCS_SODVersion or false
    _G.HCS_CalculateScore = _G.HCS_CalculateScore or {}
    -- Always stub RefreshScores to avoid running full milestone/achievement logic during tests
    _G.HCS_CalculateScore.RefreshScores = function()
        -- no-op in tests
    end
    _G.HCS_XPUpdateEvent = _G.HCS_XPUpdateEvent or {}
end

-- Test runner
function HCS_RunMobKillTests()
    say("Starting mob kill tests…")
    saveOriginals()
    ensureGlobals()

    local pass, fail = 0, 0

    -- Snapshot user data to avoid persistent side effects
    local savedUserData = {
        mobsKilled = HCScore_Character.mobsKilled,
        mobsKilledMap = HCScore_Character.mobsKilledMap,
        dangerousMobsKilled = HCScore_Character.dangerousMobsKilled,
        scoringDesc = ScoringDescriptions and ScoringDescriptions.mobsKilledScore,
    }

    local function runCase(name, ctx, checker)
    -- Use fresh, isolated tables for each case
    HCScore_Character.mobsKilled = {}
    HCScore_Character.mobsKilledMap = {}
    HCScore_Character.dangerousMobsKilled = {}

        -- Context defaults
        ctx.playerLevel = ctx.playerLevel or 60
        ctx.targetLevelRaw = ctx.targetLevelRaw or ctx.playerLevel
        ctx.subEvent = ctx.subEvent or "PARTY_KILL"
        ctx.gameVersion = ctx.gameVersion or 11404 -- Classic
        ctx.isSOD = ctx.isSOD or false
        ctx.xpGainReturn = ctx.xpGainReturn or 0 -- simulate no XP event
        ctx.sourceName = HCScore_Character.name
        ctx.destName = ctx.destName or "Test Mob"
        ctx.updateCalls = 0

        -- Stub APIs according to ctx
        UnitLevel = function(unit)
            if unit == "player" then return ctx.playerLevel end
            if unit == "target" then return ctx.targetLevelRaw end
            if _orig.UnitLevel then return _orig.UnitLevel(unit) end
            return 1
        end

        UnitClassification = function(unit)
            return ctx.classification or "normal"
        end

        UnitName = function(unit)
            if unit == "pet" then return ctx.petName or "TesterPet" end
            if unit == "player" then return HCScore_Character.name end
            if _orig.UnitName then return _orig.UnitName(unit) end
            return "Unknown"
        end

        CombatLogGetCurrentEventInfo = function()
            -- Return tuple matching usage in OnCombatEvent
            return GetTime(), ctx.subEvent, nil,
                   "Player-0-0000", ctx.sourceName, 0, 0,
                   "Creature-0-0000", ctx.destName, 0, 0,
                   nil, nil, 1, 0, 0
        end

        -- Configure environment flags
        HCS_GameVersion = ctx.gameVersion
        HCS_SODVersion = ctx.isSOD

        -- Stub XP update event behavior
        HCS_XPUpdateEvent.GetXPGain = function()
            return ctx.xpGainReturn
        end
        HCS_XPUpdateEvent.UpdateScoresBasedOnEvents = function()
            ctx.updateCalls = ctx.updateCalls + 1
            -- In production flow, UpdateScoresBasedOnEvents would call into the scoring path
            if HCS_KillingMobsScore and HCS_KillingMobsScore.UpdateMobsKilled then
                HCS_KillingMobsScore:UpdateMobsKilled()
            end
        end

        local ok, err = pcall(function()
            -- Trigger the combat event path
            OnCombatEvent()
            -- Ensure scoring runs. Classic 60 PARTY_KILL auto-invokes; otherwise, invoke explicitly.
            if ctx.updateCalls == 0 then
                HCS_XPUpdateEvent:UpdateScoresBasedOnEvents()
            end

            checker(ctx)
        end)

        if ok then
            pass = pass + 1
            say("PASS: " .. name, "|cff55ff55")
        else
            fail = fail + 1
            say("FAIL: " .. name .. " -> " .. tostring(err), "|cffff5555")
        end
    end

    -- Case 1: Classic Era level 60, equal-level mob via PARTY_KILL; xpGain forced to 300
    runCase("Classic 60 equal-level mob", {
        playerLevel = 60,
        targetLevelRaw = 60,
        subEvent = "PARTY_KILL",
        gameVersion = 11404,
        isSOD = false,
        xpGainReturn = 0,
    }, function(ctx)
        -- Verify immediate processing path was invoked
        assertEq(ctx.updateCalls, 1, "UpdateScoresBasedOnEvents should be called once at level 60 Classic on PARTY_KILL")
    assertTrue(HCScore_Character.mobsKilled and #HCScore_Character.mobsKilled == 1, "One mob entry expected")
        local mob = HCScore_Character.mobsKilled[1]
        assertEq(mob.id, "Test Mob", "Mob name should be recorded")
        assertEq(mob.kills, 1, "One kill recorded")
        -- xpGain should be overridden to 300
        assertEq(mob.xp, 300, "XP gain should be 300 at Classic 60")
        -- Score: diff 0 -> multiplier 0.0010, with 25% increase: 300 * 0.0010 * 1.25 = 0.375
        assertApprox(mob.score, 0.375, "Score should match multiplier for diff 0")
        -- No dangerous kills for diff 0
        assertTrue(not HCScore_Character.dangerousMobsKilled or #HCScore_Character.dangerousMobsKilled == 0, "No dangerous kills expected")
        -- Kill map for diff 0
        assertTrue(HCScore_Character.mobsKilledMap and #HCScore_Character.mobsKilledMap == 1, "Kill map entry expected")
        assertEq(HCScore_Character.mobsKilledMap[1].difficulty, 0, "Difficulty bucket should be 0")
    end)

    -- Case 2: Classic Era level 60, skull mob (?? -> -1) treated as +3 diff
    runCase("Classic 60 skull mob (+3 diff)", {
        playerLevel = 60,
        targetLevelRaw = -1,
        subEvent = "PARTY_KILL",
        gameVersion = 11404,
        isSOD = false,
        xpGainReturn = 0,
    }, function(ctx)
    assertTrue(HCScore_Character.mobsKilled and #HCScore_Character.mobsKilled == 1, "One mob entry expected")
        local mob = HCScore_Character.mobsKilled[1]
        assertEq(mob.xp, 300, "XP gain should be 300 at Classic 60")
        -- diff +3 -> multiplier 0.0020 -> score 300 * 0.0020 * 1.25 = 0.75
        assertApprox(mob.score, 0.75, "Score should match multiplier for diff +3")
        -- Dangerous kill recorded (>= 3)
        assertTrue(HCScore_Character.dangerousMobsKilled and HCScore_Character.dangerousMobsKilled[1], "Dangerous kills should be recorded")
        local dk = HCScore_Character.dangerousMobsKilled[1]
        assertEq(dk.kills, 1, "One dangerous kill recorded")
        assertEq(dk.difficulty, 3, "Dangerous kill difficulty should be 3")
    end)

    -- Case 3: Classic Era level 60, unknown mob level (0) uses default multiplier (-5)
    runCase("Classic 60 unknown level mob (0)", {
        playerLevel = 60,
        targetLevelRaw = 0,
        subEvent = "PARTY_KILL",
        gameVersion = 11404,
        isSOD = false,
        xpGainReturn = 0,
    }, function(ctx)
    assertTrue(HCScore_Character.mobsKilled and #HCScore_Character.mobsKilled == 1, "One mob entry expected")
    local mob = HCScore_Character.mobsKilled[1]
        assertEq(mob.xp, 300, "XP gain should be 300 at Classic 60")
        -- default multiplier -5: 0.0003 -> score 300 * 0.0003 * 1.25 = 0.1125
        assertApprox(mob.score, 0.1125, "Score should use -5 difficulty multiplier for unknown level")
    end)



    say(string.format("Completed. %d passed, %d failed.", pass, fail), fail == 0 and "|cff55ff55" or "|cffffaa00")

    -- Restore original environment
    restoreOriginals()

    -- Restore user data (no persistent changes from tests)
    HCScore_Character.mobsKilled = savedUserData.mobsKilled
    HCScore_Character.mobsKilledMap = savedUserData.mobsKilledMap
    HCScore_Character.dangerousMobsKilled = savedUserData.dangerousMobsKilled
    if ScoringDescriptions then
        ScoringDescriptions.mobsKilledScore = savedUserData.scoringDesc
    end
end

-- Register the slash command only when explicitly enabled
local function registerTestsCommand()
    SLASH_HCS_TESTS1 = "/hcs_tests"
    SlashCmdList = SlashCmdList or {}
    SlashCmdList["HCS_TESTS"] = function()
        local ok, err = pcall(HCS_RunMobKillTests)
        if not ok then
            say("Unexpected error running tests: " .. tostring(err), "|cffff5555")
        end
    end
    say("HCS test harness enabled. Type /hcs_tests to run.")
end

SLASH_HCS_TESTING_ON1 = "/hcs_testing_on"
SlashCmdList = SlashCmdList or {}
SlashCmdList["HCS_TESTING_ON"] = function()
    _G.HCS_TestHarnessEnabled = true
    registerTestsCommand()
end

SLASH_HCS_TESTING_OFF1 = "/hcs_testing_off"
SlashCmdList["HCS_TESTING_OFF"] = function()
    _G.HCS_TestHarnessEnabled = false
    -- Keep the /hcs_tests alias but make it a no-op with guidance
    SlashCmdList["HCS_TESTS"] = function()
        say("HCS test harness is disabled. Use /hcs_testing_on to enable.", "|cffffaa00")
    end
    say("HCS test harness disabled.")
end

-- Do not auto-enable on load; tests must be turned on via /hcs_testing_on each session
