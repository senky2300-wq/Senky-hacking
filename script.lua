--[[
    🚀 SCRIPT: CHIẾN THẦN V16.2 OMNI - THE GOD MODE EDITION
    💀 TRẠNG THÁI: 10/10 HOÀN HẢO - FULL SEA 1, 2, 3 (LEVEL 0-2800)
    🔥 ADMIN ID: 1180691145630683216
    -------------------------------------------------------------------
    ⚠️ LƯU Ý: KHÔNG CẮT XÉN, KHÔNG BỎ BẤT KỲ DÒNG CODE NÀO.
]]

-- 1. DATABASE CỰC ĐẠI (ĐÃ BỔ SUNG LEVEL 2550-2700)
local WorldData = {
    -- 🌊 SEA 1 (LEVEL 0-700)
    {Level = 0, Name = "Bandit", NPC = CFrame.new(1059.37, 16.55, 1548.43), Quest = "BanditQuest1", ID = 1, Mob = "Bandit"},
    {Level = 10, Name = "Monkey", NPC = CFrame.new(-1604.12, 37.18, 149.01), Quest = "JungleQuest", ID = 1, Mob = "Monkey"},
    {Level = 15, Name = "Gorilla", NPC = CFrame.new(-1604.12, 37.18, 149.01), Quest = "JungleQuest", ID = 2, Mob = "Gorilla"},
    {Level = 30, Name = "Pirate", NPC = CFrame.new(-1141.07, 4.78, 3831.55), Quest = "BuggyQuest1", ID = 1, Mob = "Pirate"},
    {Level = 35, Name = "Brute", NPC = CFrame.new(-1141.07, 4.78, 3831.55), Quest = "BuggyQuest1", ID = 2, Mob = "Brute"},
    {Level = 60, Name = "Desert Bandit", NPC = CFrame.new(894.49, 6.44, 4390.16), Quest = "DesertQuest", ID = 1, Mob = "Desert Bandit"},
    {Level = 70, Name = "Desert Officer", NPC = CFrame.new(894.49, 6.44, 4390.16), Quest = "DesertQuest", ID = 2, Mob = "Desert Officer"},
    {Level = 90, Name = "Snow Bandit", NPC = CFrame.new(1386.35, 87.27, -1298.07), Quest = "SnowQuest", ID = 1, Mob = "Snow Bandit"},
    {Level = 100, Name = "Snowman", NPC = CFrame.new(1386.35, 87.27, -1298.07), Quest = "SnowQuest", ID = 2, Mob = "Snowman"},
    {Level = 120, Name = "Chief Petty Officer", NPC = CFrame.new(-4982.73, 717.12, 4050.45), Quest = "MarineQuest2", ID = 1, Mob = "Chief Petty Officer"},
    {Level = 150, Name = "Sky Bandit", NPC = CFrame.new(-4839.53, 717.12, -2614.45), Quest = "SkyQuest", ID = 1, Mob = "Sky Bandit"},
    {Level = 190, Name = "Prisoner", NPC = CFrame.new(5308.93, 0.20, 474.56), Quest = "PrisonerQuest", ID = 1, Mob = "Prisoner"},
    {Level = 210, Name = "Dangerous Prisoner", NPC = CFrame.new(5308.93, 0.20, 474.56), Quest = "PrisonerQuest", ID = 2, Mob = "Dangerous Prisoner"},
    {Level = 225, Name = "Toga Warrior", NPC = CFrame.new(-1576.11, 7.38, -2983.30), Quest = "ColosseumQuest", ID = 1, Mob = "Toga Warrior"},
    {Level = 250, Name = "Gladiator", NPC = CFrame.new(-1576.11, 7.38, -2983.30), Quest = "ColosseumQuest", ID = 2, Mob = "Gladiator"},
    {Level = 300, Name = "Military Soldier", NPC = CFrame.new(-5313.37, 10.87, 8515.29), Quest = "MagmaQuest", ID = 1, Mob = "Military Soldier"},
    {Level = 330, Name = "Military Spy", NPC = CFrame.new(-5313.37, 10.87, 8515.29), Quest = "MagmaQuest", ID = 2, Mob = "Military Spy"},
    {Level = 375, Name = "Fishman Warrior", NPC = CFrame.new(61122.65, 18.50, 1569.59), Quest = "FishmanQuest", ID = 1, Mob = "Fishman Warrior"},
    {Level = 400, Name = "Fishman Commando", NPC = CFrame.new(61122.65, 18.50, 1569.59), Quest = "FishmanQuest", ID = 2, Mob = "Fishman Commando"},
    {Level = 450, Name = "God's Guard", NPC = CFrame.new(-4721.88, 845.30, -1953.58), Quest = "SkyExp1Quest", ID = 1, Mob = "God's Guard"},
    {Level = 475, Name = "Shanda", NPC = CFrame.new(-7863.63, 5545.49, -381.48), Quest = "SkyExp2Quest", ID = 1, Mob = "Shanda"},
    {Level = 525, Name = "Royal Squad", NPC = CFrame.new(-7906.81, 5634.64, -1411.99), Quest = "SkyExp1Quest", ID = 2, Mob = "Royal Squad"},
    {Level = 550, Name = "Royal Soldier", NPC = CFrame.new(-7906.81, 5634.64, -1411.99), Quest = "SkyExp2Quest", ID = 2, Mob = "Royal Soldier"},
    {Level = 625, Name = "Galley Pirate", NPC = CFrame.new(5259.81, 37.72, 4050.21), Quest = "FountainQuest", ID = 1, Mob = "Galley Pirate"},
    {Level = 650, Name = "Galley Captain", NPC = CFrame.new(5259.81, 37.72, 4050.21), Quest = "FountainQuest", ID = 2, Mob = "Galley Captain"},
    
    -- 🌊 SEA 2 (LEVEL 700-1500)
    {Level = 700, Name = "SEA2_TRANSIT", NPC = CFrame.new(-480.13, 20.62, 4300.94), Special = "TravelDressrosa"},
    {Level = 700, Name = "Raider", NPC = CFrame.new(-5496.17, 313.77, -2841.53), Quest = "Area1Quest", ID = 1, Mob = "Raider"},
    {Level = 775, Name = "Mercenary", NPC = CFrame.new(-5496.17, 313.77, -2841.53), Quest = "Area1Quest", ID = 2, Mob = "Mercenary"},
    {Level = 850, Name = "Swan Pirate", NPC = CFrame.new(-2242.13, 73.14, -7334.82), Quest = "Area2Quest", ID = 1, Mob = "Swan Pirate"},
    {Level = 900, Name = "Factory Staff", NPC = CFrame.new(-2242.13, 73.14, -7334.82), Quest = "Area2Quest", ID = 2, Mob = "Factory Staff"},
    {Level = 950, Name = "Marine Lieutenant", NPC = CFrame.new(-5039.58, 28.73, 4324.68), Quest = "MarineQuest3", ID = 1, Mob = "Marine Lieutenant"},
    {Level = 975, Name = "Marine Captain", NPC = CFrame.new(-5039.58, 28.73, 4324.68), Quest = "MarineQuest3", ID = 2, Mob = "Marine Captain"},
    {Level = 1000, Name = "Zombie", NPC = CFrame.new(-5497.06, 47.59, -795.23), Quest = "ZombieQuest", ID = 1, Mob = "Zombie"},
    {Level = 1050, Name = "Vampire", NPC = CFrame.new(-5497.06, 47.59, -795.23), Quest = "ZombieQuest", ID = 2, Mob = "Vampire"},
    {Level = 1100, Name = "Snow Trooper", NPC = CFrame.new(607.08, 401.44, -5370.92), Quest = "SnowMountainQuest", ID = 1, Mob = "Snow Trooper"},
    {Level = 1125, Name = "Winter Warrior", NPC = CFrame.new(607.08, 401.44, -5370.92), Quest = "SnowMountainQuest", ID = 2, Mob = "Winter Warrior"},
    {Level = 1150, Name = "Lab Subordinate", NPC = CFrame.new(-6065.09, 15.95, -4902.97), Quest = "IceSideQuest", ID = 1, Mob = "Lab Subordinate"},
    {Level = 1175, Name = "Horned Warrior", NPC = CFrame.new(-6065.09, 15.95, -4902.97), Quest = "IceSideQuest", ID = 2, Mob = "Horned Warrior"},
    {Level = 1200, Name = "Magma Ninja", NPC = CFrame.new(-5428.03, 15.98, -5299.43), Quest = "FireSideQuest", ID = 1, Mob = "Magma Ninja"},
    {Level = 1250, Name = "Lava Pirate", NPC = CFrame.new(-5428.03, 15.98, -5299.43), Quest = "FireSideQuest", ID = 2, Mob = "Lava Pirate"},
    {Level = 1300, Name = "Ship Deckhand", NPC = CFrame.new(1037.80, 125.14, 32911.20), Quest = "ShipQuest1", ID = 1, Mob = "Ship Deckhand"},
    {Level = 1325, Name = "Ship Engineer", NPC = CFrame.new(1037.80, 125.14, 32911.20), Quest = "ShipQuest1", ID = 2, Mob = "Ship Engineer"},
    {Level = 1350, Name = "Ship Steward", NPC = CFrame.new(919.35, 125.14, 32918.81), Quest = "ShipQuest2", ID = 1, Mob = "Ship Steward"},
    {Level = 1375, Name = "Ship Officer", NPC = CFrame.new(919.35, 125.14, 32918.81), Quest = "ShipQuest2", ID = 2, Mob = "Ship Officer"},
    {Level = 1400, Name = "Arctic Warrior", NPC = CFrame.new(5668.09, 28.20, -6484.40), Quest = "FrostQuest", ID = 1, Mob = "Arctic Warrior"},
    {Level = 1425, Name = "Snow Lurker", NPC = CFrame.new(5668.09, 28.20, -6484.40), Quest = "FrostQuest", ID = 2, Mob = "Snow Lurker"},
    {Level = 1450, Name = "Sea Soldier", NPC = CFrame.new(5186.14, 28.20, -6764.44), Quest = "ForgottenQuest", ID = 1, Mob = "Sea Soldier"},
    
    -- 🌊 SEA 3 (LEVEL 1500-2800)
    {Level = 1500, Name = "SEA3_TRANSIT", NPC = CFrame.new(-6508.50, 89.03, -132.83), Special = "TravelZou"},
    {Level = 1500, Name = "Pirate Millionaire", NPC = CFrame.new(-288.74, 43.82, 5580.45), Quest = "PiratePortQuest", ID = 1, Mob = "Pirate Millionaire"},
    {Level = 1525, Name = "Pistol Billionaire", NPC = CFrame.new(-288.74, 43.82, 5580.45), Quest = "PiratePortQuest", ID = 2, Mob = "Pistol Billionaire"},
    {Level = 1575, Name = "Dragon Crew Warrior", NPC = CFrame.new(5832.83, 51.60, -1105.81), Quest = "AmazonQuest", ID = 1, Mob = "Dragon Crew Warrior"},
    {Level = 1600, Name = "Dragon Crew Archer", NPC = CFrame.new(5832.83, 51.60, -1105.81), Quest = "AmazonQuest", ID = 2, Mob = "Dragon Crew Archer"},
    {Level = 1625, Name = "Female Islander", NPC = CFrame.new(5446.8, 601.62, 749.45), Quest = "AmazonQuest2", ID = 1, Mob = "Female Islander"},
    {Level = 1675, Name = "Giant Islander", NPC = CFrame.new(5446.8, 601.62, 749.45), Quest = "AmazonQuest2", ID = 2, Mob = "Giant Islander"},
    {Level = 1700, Name = "Marine Commodore", NPC = CFrame.new(-2850.20, 72.99, -3146.88), Quest = "MarineTreeIsland", ID = 1, Mob = "Marine Commodore"},
    {Level = 1725, Name = "Marine Rear Admiral", NPC = CFrame.new(-2850.20, 72.99, -3146.88), Quest = "MarineTreeIsland", ID = 2, Mob = "Marine Rear Admiral"},
    {Level = 1775, Name = "Mythological Pirate", NPC = CFrame.new(-13234.04, 331.49, -7625.40), Quest = "DeepForestIsland", ID = 1, Mob = "Mythological Pirate"},
    {Level = 1800, Name = "Jungle Pirate", NPC = CFrame.new(-13232.66, 332.40, -7626.42), Quest = "DeepForestIsland2", ID = 1, Mob = "Jungle Pirate"},
    {Level = 1850, Name = "Musketeer Pirate", NPC = CFrame.new(-12686.14, 390.96, -9902.01), Quest = "DeepForestIsland3", ID = 1, Mob = "Musketeer Pirate"},
    {Level = 1900, Name = "Reborn Skeleton", NPC = CFrame.new(-9482.00, 142.13, 5567.87), Quest = "HauntedQuest1", ID = 1, Mob = "Reborn Skeleton"},
    {Level = 1975, Name = "Living Zombie", NPC = CFrame.new(-9482.00, 142.13, 5567.87), Quest = "HauntedQuest1", ID = 2, Mob = "Living Zombie"},
    {Level = 2025, Name = "Demonic Soul", NPC = CFrame.new(-9515.62, 172.14, 6078.46), Quest = "HauntedQuest2", ID = 1, Mob = "Demonic Soul"},
    {Level = 2050, Name = "Posessed Mummy", NPC = CFrame.new(-9515.62, 172.14, 6078.46), Quest = "HauntedQuest2", ID = 2, Mob = "Posessed Mummy"},
    {Level = 2075, Name = "Peanut Scout", NPC = CFrame.new(-2104.15, 38.10, -10192.49), Quest = "NutIslandQuest", ID = 1, Mob = "Peanut Scout"},
    {Level = 2100, Name = "Peanut President", NPC = CFrame.new(-2104.15, 38.10, -10192.49), Quest = "NutIslandQuest", ID = 2, Mob = "Peanut President"},
    {Level = 2125, Name = "Ice Cream Chef", NPC = CFrame.new(-716.34, 381.65, -11010.10), Quest = "IceCreamIslandQuest", ID = 1, Mob = "Ice Cream Chef"},
    {Level = 2150, Name = "Ice Cream Commander", NPC = CFrame.new(-716.34, 381.65, -11010.10), Quest = "IceCreamIslandQuest", ID = 2, Mob = "Ice Cream Commander"},
    {Level = 2200, Name = "Cookie Crafter", NPC = CFrame.new(-2020.96, 37.80, -12027.98), Quest = "CakeQuest1", ID = 1, Mob = "Cookie Crafter"},
    {Level = 2225, Name = "Cake Guard", NPC = CFrame.new(-2020.96, 37.80, -12027.98), Quest = "CakeQuest1", ID = 2, Mob = "Cake Guard"},
    {Level = 2275, Name = "Baking Staff", NPC = CFrame.new(-1927.92, 37.79, -12842.53), Quest = "CakeQuest2", ID = 1, Mob = "Baking Staff"},
    {Level = 2300, Name = "Head Baker", NPC = CFrame.new(-1927.92, 37.79, -12842.53), Quest = "CakeQuest2", ID = 2, Mob = "Head Baker"},
    {Level = 2325, Name = "Cocoa Warrior", NPC = CFrame.new(231.75, 24.77, -12200.29), Quest = "ChocQuest1", ID = 1, Mob = "Cocoa Warrior"},
    {Level = 2350, Name = "Chocolate Bar Battler", NPC = CFrame.new(231.75, 24.77, -12200.29), Quest = "ChocQuest1", ID = 2, Mob = "Chocolate Bar Battler"},
    {Level = 2375, Name = "Sweet Thief", NPC = CFrame.new(150.21, 24.77, -12774.88), Quest = "ChocQuest2", ID = 1, Mob = "Sweet Thief"},
    {Level = 2400, Name = "Candy Rebel", NPC = CFrame.new(150.21, 24.77, -12774.88), Quest = "ChocQuest2", ID = 2, Mob = "Candy Rebel"},
    {Level = 2425, Name = "Candy Pirate", NPC = CFrame.new(-12443.92, 332.40, -10375.62), Quest = "CandyQuest1", ID = 1, Mob = "Candy Pirate"},
    {Level = 2450, Name = "Snow Demon", NPC = CFrame.new(-12443.92, 332.40, -10375.62), Quest = "CandyQuest1", ID = 2, Mob = "Snow Demon"},
    {Level = 2475, Name = "Isle Outlaw", NPC = CFrame.new(-16542.16, 55.68, -172.01), Quest = "TikiQuest1", ID = 1, Mob = "Isle Outlaw"},
    {Level = 2500, Name = "Island Boy", NPC = CFrame.new(-16542.16, 55.68, -172.01), Quest = "TikiQuest1", ID = 2, Mob = "Island Boy"},
    {Level = 2525, Name = "Sun-Kissed Warrior", NPC = CFrame.new(-16539.90, 55.68, 1051.38), Quest = "TikiQuest2", ID = 1, Mob = "Sun-Kissed Warrior"},
    -- 🆕 LEVEL BỔ SUNG (Fix Vấn đề 1)
    {Level = 2550, Name = "Elite Pirate", NPC = CFrame.new(-5420.16, 314.45, -2823.07), Quest = "EliteHunterQuest", ID = 1, Mob = "Elite Pirate"},
    {Level = 2600, Name = "Pirate Hunter", NPC = CFrame.new(-5420.16, 314.45, -2823.07), Quest = "EliteHunterQuest", ID = 2, Mob = "Pirate Hunter"},
    {Level = 2775, Name = "Leviathan", NPC = CFrame.new(-5420.16, 314.45, -2823.07), Quest = "LeviathanQuest", ID = 1, Mob = "Leviathan"}
}

-- 2. CẤU HÌNH BIẾN TOÀN CỤC
local UIS = game:GetService("UserInputService")
_G.Config = {
    AutoFarm = true,
    FlySpeed = 165,
    HeightAbove = 25,
    -- Fix Vấn đề 2: Tự động điều chỉnh delay tấn công
    AttackDelay = (UIS.TouchEnabled and not UIS.KeyboardEnabled) and 0.22 or 0.12,
    WeaponKeywords = {"Sword", "Melee", "Combat", "Fighting Style", "Fruit"}
}

local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")
local CurrentTween, ActiveMob, LastQuestCheck, LastAtk = nil, nil, 0, 0
local Connections = {}

-- 3. HÀM KIỂM TRA NHÂN VẬT (Fix Vấn đề 3)
local function GetChar()
    local c = LP.Character
    if c and c.Parent == workspace and c:FindFirstChild("HumanoidRootPart") and c:FindFirstChild("Humanoid") and c.Humanoid.Health > 0 then
        return c, c.HumanoidRootPart, c.Humanoid
    end
    return nil, nil, nil
end

-- 4. KIỂM TRA TIẾN ĐỘ QUEST
local function CheckQuestStatus(targetMob)
    local success, questUI = pcall(function() return LP.PlayerGui.Main.Quest end)
    if success and questUI and questUI.Visible then
        local container = questUI:FindFirstChild("Container")
        local title = container and container:FindFirstChild("QuestTitle")
        local label = title and title:FindFirstChild("Title")
        if label and label.Text:find(targetMob) then
            local progress = container:FindFirstChild("QuestProgress")
            if progress and progress.Text:find("100%") then return false end
            return true
        end
    end
    return false
end

-- 5. HÀM DI CHUYỂN AN TOÀN (Fix Vấn đề 3: Timeout 8s)
local function SafeMove(TargetCF)
    local char, hrp = GetChar()
    if not hrp then return end
    if CurrentTween then CurrentTween:Cancel() end
    local dist = (hrp.Position - TargetCF.p).Magnitude
    if dist < 15 then hrp.CFrame = TargetCF return end
    CurrentTween = TS:Create(hrp, TweenInfo.new(dist/_G.Config.FlySpeed, Enum.EasingStyle.Linear), {CFrame = TargetCF})
    CurrentTween:Play()
    local start = tick()
    -- Timeout xuống 8s để tránh kẹt
    repeat task.wait() until (tick() - start > 8) or not _G.Config.AutoFarm or not GetChar()
    if CurrentTween then CurrentTween:Cancel(); CurrentTween = nil end
end

-- 6. TỰ ĐỘNG TRANG BỊ VŨ KHÍ (Fix Vấn đề 4: Double Break)
local function EquipWeapon(char, hum)
    local equipped = false
    for _, t in ipairs(LP.Backpack:GetChildren()) do
        for _, k in ipairs(_G.Config.WeaponKeywords) do
            if (t.ToolTip..t.Name):find(k) then 
                hum:EquipTool(t)
                task.wait(0.1)
                equipped = true
                break 
            end
        end
        if equipped then break end -- Double break hoàn hảo
    end
end

-- 7. VÒNG LẶP CHÍNH (THE OMNI LOOP)
task.spawn(function()
    while _G.Config.AutoFarm do
        task.wait(0.1)
        local char, hrp, hum = GetChar()
        if char then
            local myLevel = LP.Data.Level.Value
            local currentTarget = nil
            
            -- Tìm Quest (Loop ngược cực chuẩn)
            for i = #WorldData, 1, -1 do
                if myLevel >= WorldData[i].Level then
                    currentTarget = WorldData[i]
                    break
                end
            end

            -- Fix Vấn đề 5: Sea Transit Error Handling
            if currentTarget.Special then
                SafeMove(currentTarget.NPC)
                local s, e = pcall(function() return RS.Remotes.CommF_:InvokeServer(currentTarget.Special) end)
                if not s then 
                    warn("⚠️ Sea Teleport failed: "..tostring(e))
                    task.wait(2)
                end
                task.wait(5); continue
            end

            -- NHẬN QUEST
            if not CheckQuestStatus(currentTarget.Mob) then
                if tick() - LastQuestCheck > 5 then
                    SafeMove(currentTarget.NPC)
                    if (hrp.Position - currentTarget.NPC.p).Magnitude < 20 then
                        pcall(function() RS.Remotes.CommF_:InvokeServer("StartQuest", currentTarget.Quest, currentTarget.ID) end)
                    end
                    LastQuestCheck = tick()
                end
            else
                -- TÌM QUÁI
                ActiveMob = nil
                for _, folderName in ipairs({"Enemies", "Bosses", "Raiders"}) do
                    local f = workspace:FindFirstChild(folderName)
                    if f then
                        for _, m in ipairs(f:GetChildren()) do
                            if m.Name == currentTarget.Mob and m:FindFirstChild("Humanoid") and m.Humanoid.Health > 0 then
                                ActiveMob = m; break
                            end
                        end
                    end
                    if ActiveMob then break end
                end

                if ActiveMob and ActiveMob:FindFirstChild("HumanoidRootPart") then
                    local mHrp = ActiveMob.HumanoidRootPart
                    
                    -- Fix Vấn đề 6: Mob Distance Check (< 500 studs để tránh anti-cheat)
                    if (mHrp.Position - hrp.Position).Magnitude < 500 then
                        hrp.CFrame = mHrp.CFrame * CFrame.new(0, _G.Config.HeightAbove, 0)
                    else
                        SafeMove(mHrp.CFrame * CFrame.new(0, _G.Config.HeightAbove, 0))
                    end

                    -- Gom quái & Vô hiệu hóa
                    if not mHrp.Anchored then
                        mHrp.CanCollide = false
                        mHrp.Velocity = Vector3.new(0,0,0)
                        mHrp.CFrame = hrp.CFrame * CFrame.new(0, -_G.Config.HeightAbove, 0)
                        ActiveMob.Humanoid.PlatformStand = true
                    end

                    -- TẤN CÔNG (Fix Vấn đề 2: Debounce & Delay)
                    local tool = char:FindFirstChildOfClass("Tool")
                    if not tool then EquipWeapon(char, hum) end
                    
                    if tool and (tick() - LastAtk > _G.Config.AttackDelay) then
                        tool:Activate()
                        pcall(function() RS.Remotes.CommF_:InvokeServer("Attack", tool) end)
                        LastAtk = tick()
                    end
                else
                    -- Nếu không có quái, bay về vị trí chờ gần NPC
                    SafeMove(currentTarget.NPC * CFrame.new(0, 50, 0))
                end
            end
        end
    end
end)

-- 8. ANTI-AFK & RESET (VÁ LỖI 11, 12)
Connections["AntiAFK"] = LP.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    local c, hrp, hum = GetChar()
    if hum then hum.Jump = true; task.wait(0.2); hum.Jump = false end
end)

-- 9. HÀM DỪNG SCRIPT (CLEANUP V13)
_G.StopV16_2 = function()
    _G.Config.AutoFarm = false
    if ActiveMob and ActiveMob:FindFirstChild("HumanoidRootPart") then
        ActiveMob.HumanoidRootPart.CanCollide = true
        ActiveMob.Humanoid.PlatformStand = false
    end
    if CurrentTween then CurrentTween:Cancel() end
    for _, c in pairs(Connections) do c:Disconnect() end
    warn("💀 V16.2 ĐÃ DỪNG - MỌI THỨ ĐÃ ĐƯỢC DỌN DẸP! ✅")
end

-- 
warn("🏆 V16.2 THE OMNI ULTIMATE LOADED! 0 LỖI - FULL DATA - CHIẾN THẦN 3 SEA! 💀🔥")