HCS_PlayerLevelingScore = {}

local data = {
        {Level = 1, Bonus = 0.01, LevelTotal = 1.01, Total = 1.01},
        {Level = 2, Bonus = 0.04, LevelTotal = 2.04, Total = 3.05},
        {Level = 3, Bonus = 0.09, LevelTotal = 3.09, Total = 6.14},
        {Level = 4, Bonus = 0.16, LevelTotal = 4.16, Total = 10.30},
        {Level = 5, Bonus = 0.25, LevelTotal = 5.25, Total = 15.55},
        {Level = 6, Bonus = 0.36, LevelTotal = 6.36, Total = 21.91},
        {Level = 7, Bonus = 0.49, LevelTotal = 7.49, Total = 29.40},
        {Level = 8, Bonus = 0.64, LevelTotal = 8.64, Total = 38.04},
        {Level = 9, Bonus = 0.81, LevelTotal = 9.81, Total = 47.85},
        {Level = 10, Bonus = 1.00, LevelTotal = 11.00, Total = 58.85},
        {Level = 11, Bonus = 1.21, LevelTotal = 12.21, Total = 71.06},
        {Level = 12, Bonus = 1.44, LevelTotal = 13.44, Total = 84.50},
        {Level = 13, Bonus = 1.69, LevelTotal = 14.69, Total = 99.19},
        {Level = 14, Bonus = 1.96, LevelTotal = 15.96, Total = 115.15},
        {Level = 15, Bonus = 2.25, LevelTotal = 17.25, Total = 132.40},
        {Level = 16, Bonus = 2.56, LevelTotal = 18.56, Total = 150.96},
        {Level = 17, Bonus = 2.89, LevelTotal = 19.89, Total = 170.85},
        {Level = 18, Bonus = 3.24, LevelTotal = 21.24, Total = 192.09},
        {Level = 19, Bonus = 3.61, LevelTotal = 22.61, Total = 214.70},
        {Level = 20, Bonus = 4.00, LevelTotal = 24.00, Total = 238.70},
        {Level = 21, Bonus = 4.41, LevelTotal = 25.41, Total = 264.11},
        {Level = 22, Bonus = 4.84, LevelTotal = 26.84, Total = 290.95},
        {Level = 23, Bonus = 5.29, LevelTotal = 28.29, Total = 319.24},
        {Level = 24, Bonus = 5.76, LevelTotal = 29.76, Total = 349.00},
        {Level = 25, Bonus = 6.25, LevelTotal = 31.25, Total = 380.25},
        {Level = 26, Bonus = 6.76, LevelTotal = 32.76, Total = 413.01},
        {Level = 27, Bonus = 7.29, LevelTotal = 34.29, Total = 447.30},
        {Level = 28, Bonus = 7.84, LevelTotal = 35.84, Total = 483.14},
        {Level = 29, Bonus = 8.41, LevelTotal = 37.41, Total = 520.55},
        {Level = 30, Bonus = 9.00, LevelTotal = 39.00, Total = 559.55},
        {Level = 31, Bonus = 9.61, LevelTotal = 40.61, Total = 600.16},
        {Level = 32, Bonus = 10.24, LevelTotal = 42.24, Total = 642.40},
        {Level = 33, Bonus = 10.89, LevelTotal = 43.89, Total = 686.29},
        {Level = 34, Bonus = 11.56, LevelTotal = 45.56, Total = 731.85},
        {Level = 35, Bonus = 12.25, LevelTotal = 47.25, Total = 779.10},
        {Level = 36, Bonus = 12.96, LevelTotal = 48.96, Total = 828.06},
        {Level = 37, Bonus = 13.69, LevelTotal = 50.69, Total = 878.75},
        {Level = 38, Bonus = 14.44, LevelTotal = 52.44, Total = 931.19},
        {Level = 39, Bonus = 15.21, LevelTotal = 54.21, Total = 985.40},
        {Level = 40, Bonus = 16.00, LevelTotal = 56.00, Total = 1041.40},
        {Level = 41, Bonus = 16.81, LevelTotal = 57.81, Total = 1099.21},
        {Level = 42, Bonus = 17.64, LevelTotal = 59.64, Total = 1158.85},
        {Level = 43, Bonus = 18.49, LevelTotal = 61.49, Total = 1220.34},
        {Level = 44, Bonus = 19.36, LevelTotal = 63.36, Total = 1283.70},
        {Level = 45, Bonus = 20.25, LevelTotal = 65.25, Total = 1348.95},
        {Level = 46, Bonus = 21.16, LevelTotal = 67.16, Total = 1416.11},
        {Level = 47, Bonus = 22.09, LevelTotal = 69.09, Total = 1485.20},
        {Level = 48, Bonus = 23.04, LevelTotal = 71.04, Total = 1556.24},
        {Level = 49, Bonus = 24.01, LevelTotal = 73.01, Total = 1629.25},
        {Level = 50, Bonus = 25.00, LevelTotal = 75.00, Total = 1704.25},
        {Level = 51, Bonus = 26.01, LevelTotal = 77.01, Total = 1781.26},
        {Level = 52, Bonus = 27.04, LevelTotal = 79.04, Total = 1860.30},
        {Level = 53, Bonus = 28.09, LevelTotal = 81.09, Total = 1941.39},
        {Level = 54, Bonus = 29.16, LevelTotal = 83.16, Total = 2024.55},
        {Level = 55, Bonus = 30.25, LevelTotal = 85.25, Total = 2109.80},
        {Level = 56, Bonus = 31.36, LevelTotal = 87.36, Total = 2197.16},
        {Level = 57, Bonus = 32.49, LevelTotal = 89.49, Total = 2286.65},
        {Level = 58, Bonus = 33.64, LevelTotal = 91.64, Total = 2378.29},
        {Level = 59, Bonus = 34.81, LevelTotal = 93.81, Total = 2472.10},
        {Level = 60, Bonus = 36.00, LevelTotal = 96.00, Total = 2568.10},
    }
            
function HCS_PlayerLevelingScore:GetLevelScore()
    
    local score = 0
    local level = UnitLevel("player")

    
    score = data[level].Total

    return score

end
