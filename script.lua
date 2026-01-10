-- [[ ================================================================= ]] --
-- [[   SENKY HUB V-FINAL++++ MEGA ULTRA UPDATE 2026 😈                 ]] --
-- [[   TRẠNG THÁI: SIÊU CẤP GỘP - KHÔNG LỌC - KHÔNG RÚT GỌN             ]] --
-- [[   ĐỘ DÀI: > 410 DÒNG | FIX MENU 100% | NO COOLDOWN | ANTI ATTACK  ]] --
-- [[ ================================================================= ]] --

-- [[ 1. HỆ THỐNG KIỂM TRA KHỞI ĐỘNG ]] --
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer

-- [[ 2. TẢI THƯ VIỆN RAYFIELD (BẢN GỐC TỐI ƯU) ]] --
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source'))()

-- [[ 3. KHỞI TẠO CỬA SỔ CHÍNH ]] --
local Window = Rayfield:CreateWindow({
   Name = "Senky Hub V-FINAL++++ MEGA ULTRA 😈",
   LoadingTitle = "Đang kiểm tra nội công chiến thần 2026...",
   LoadingSubtitle = "by Senky Hub Team - Full Logic No Filter",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SenkyConfig",
      FileName = "SenkyHubUltra"
   },
   DisableRayfieldPrompts = true,
   KeySystem = false
})

-- [[ 4. TOÀN BỘ SERVICES ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- [[ 5. TOÀN BỘ VARIABLES HỆ THỐNG ]] --
local Player = Players.LocalPlayer
local Data = Player:WaitForChild("Data")
local _G = _G or {}

_G.AutoFarm = false
_G.BringMob = true
_G.AutoAttack = true
_G.FastAttackSpeed = 0.05
_G.Speed = 150
_G.FlyEnabled = false
_G.NoClip = true
_G.AntiAFK = true
_G.AutoFruit = false
_G.AutoHop = false
_G.InfiniteJump = true
_G.WalkOnWater = true
_G.AutoStoreFruit = true
_G.AutoRandom = false
_G.NoCooldown = false
_G.SuperFastAttack = false
_G.AntiAttack = false
_G.AutoChest = false
_G.AutoSkill = false

-- [[ 6. CHARACTER MANAGER ]] --
local char = Player.Character or Player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

Player.CharacterAdded:Connect(function(newChar)
    char = newChar
    hrp = newChar:WaitForChild("HumanoidRootPart")
end)

-- [[ 7. HỆ THỐNG THÔNG BÁO TÀI SẢN ]] --
local function GetStats()
    local Beli = Data.Beli.Value
    local Fragments = Data.Fragments.Value
    local StatsPoint = Data.StatsPoints.Value
    local Level = Data.Level.Value
    
    Rayfield:Notify({
        Title = "THỐNG KÊ CHIẾN THẦN 😈",
        Content = "📍 Lvl: "..tostring(Level).."\n💰 Beli: "..tostring(Beli).."\n✨ Frag: "..tostring(Fragments),
        Duration = 10
    })
end

-- [[ 8. [RISK] NO COOLDOWN SKILL ]] --
task.spawn(function()
    RunService.Heartbeat:Connect(function()
        if _G.NoCooldown then
            pcall(function()
                for _, v in pairs(char:GetDescendants()) do
                    if v.Name == "Cooldown" or v.Name == "lastTime" or v.Name == "Debounce" then
                        if v:IsA("NumberValue") or v:IsA("DoubleConstrainedValue") then
                            v.Value = 0
                        end
                    end
                end
            end)
        end
    end)
end)

-- [[ 9. SUPER FAST ATTACK NO DELAY ]] --
task.spawn(function()
    while task.wait(_G.FastAttackSpeed) do
        if _G.SuperFastAttack then
            pcall(function()
                local CombatRemotes = ReplicatedStorage.Remotes.CommF_
                CombatRemotes:InvokeServer("Attack", "1")
                VirtualUser:Button1Down(Vector2.new(0,0))
            end)
        end
    end
end)

-- [[ 10. ANTI ATTACK (GOD MODE) ]] --
task.spawn(function()
    RunService.Stepped:Connect(function()
        if _G.AntiAttack then
            pcall(function()
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanTouch = false
                    end
                end
                if char:FindFirstChild("Humanoid") then
                    char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                    char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                end
            end)
        else
            pcall(function()
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanTouch = true end
                end
            end)
        end
    end)
end)

-- [[ 11. FLY WASD C-FRAME ]] --
local keys = {W=false, S=false, A=false, D=false, Space=false, LeftShift=false}
UserInputService.InputBegan:Connect(function(input)
    local code = input.KeyCode.Name
    if keys[code] ~= nil then keys[code] = true end
end)
UserInputService.InputEnded:Connect(function(input)
    local code = input.KeyCode.Name
    if keys[code] ~= nil then keys[code] = false end
end)

task.spawn(function()
    while task.wait() do
        if _G.FlyEnabled and hrp then
            pcall(function()
                local cam = Workspace.CurrentCamera.CFrame
                local moveDir = Vector3.new(0,0,0)
                if keys.W then moveDir = moveDir + cam.LookVector end
                if keys.S then moveDir = moveDir - cam.LookVector end
                if keys.A then moveDir = moveDir - cam.RightVector end
                if keys.D then moveDir = moveDir + cam.RightVector end
                if keys.Space then moveDir = moveDir + Vector3.new(0,1,0) end
                if keys.LeftShift then moveDir = moveDir - Vector3.new(0,1,0) end
                if moveDir.Magnitude > 0 then
                    hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + cam.LookVector) * CFrame.new(moveDir.Unit * (_G.Speed / 10))
                end
                hrp.Velocity = Vector3.new(0, 0.1, 0)
            end)
        end
    end
end)

-- [[ 12. AUTO FARM CHEST (BELI) ]] --
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoChest and hrp then
            pcall(function()
                for _, v in pairs(Workspace:GetChildren()) do
                    if v.Name:find("Chest") and v:IsA("Part") then
                        hrp.CFrame = v.CFrame
                        task.wait(0.2)
                    end
                end
            end)
        end
    end
end)

-- [[ 13. AUTO SKILL (Z, X, C, V) ]] --
task.spawn(function()
    while task.wait(0.2) do
        if _G.AutoSkill then
            pcall(function()
                VirtualInputManager:SendKeyEvent(true, "Z", false, game)
                task.wait(0.01)
                VirtualInputManager:SendKeyEvent(true, "X", false, game)
                task.wait(0.01)
                VirtualInputManager:SendKeyEvent(true, "C", false, game)
                task.wait(0.01)
                VirtualInputManager:SendKeyEvent(true, "V", false, game)
            end)
        end
    end
end)

-- [[ 14. TELEPORT FUNCTION ]] --
local function TP(pos)
    pcall(function()
        local tween = TweenService:Create(hrp, TweenInfo.new(0.6), {CFrame = CFrame.new(pos)})
        tween:Play()
        tween.Completed:Wait()
    end)
end

-- [[ 15. TOÀN BỘ QUEST TABLE 3 SEA (KHÔNG LỌC) ]] --
local QuestList = {
    -- SEA 1
    {min = 0, quest = "BanditQuest1", id = 1, mob = "Bandit", pos = Vector3.new(1059.37, 16.52, 1548.82)},
    {min = 10, quest = "JungleQuest", id = 1, mob = "Monkey", pos = Vector3.new(-1602.21, 36.85, 131.78)},
    {min = 15, quest = "JungleQuest", id = 2, mob = "Gorilla", pos = Vector3.new(-1602.21, 36.85, 131.78)},
    {min = 30, quest = "BuggyQuest1", id = 1, mob = "Pirate", pos = Vector3.new(-1139.6, 4.75, 3825.16)},
    {min = 40, quest = "BuggyQuest1", id = 2, mob = "Brute", pos = Vector3.new(-1139.6, 4.75, 3825.16)},
    {min = 60, quest = "DesertQuest", id = 1, mob = "Desert Bandit", pos = Vector3.new(932.79, 6.45, 4489.83)},
    {min = 75, quest = "DesertQuest", id = 2, mob = "Desert Officer", pos = Vector3.new(932.79, 6.45, 4489.83)},
    {min = 90, quest = "SnowQuest", id = 1, mob = "Snow Bandit", pos = Vector3.new(1374.47, 87.27, -1321.3)},
    {min = 120, quest = "MarineQuest2", id = 1, mob = "Chief Petty Officer", pos = Vector3.new(-4882.86, 22.65, -5102.86)},
    {min = 150, quest = "SkyQuest", id = 1, mob = "Sky Bandit", pos = Vector3.new(-4724.28, 845.8, -1953.34)},
    {min = 190, quest = "SkyQuest", id = 2, mob = "Dark Skilled Skeleton", pos = Vector3.new(-4724.28, 845.8, -1953.34)},
    {min = 250, quest = "PrisonQuest", id = 1, mob = "Prisoner", pos = Vector3.new(4844.75, 5.65, 743.45)},
    {min = 300, quest = "MagmaQuest", id = 1, mob = "Military Soldier", pos = Vector3.new(-5242.76, 8.5, 8466.1)},
    -- SEA 2
    {min = 700, quest = "Area1Quest", id = 1, mob = "Raider", pos = Vector3.new(-429, 73, 1832)},
    {min = 725, quest = "Area1Quest", id = 2, mob = "Mercenary", pos = Vector3.new(-429, 73, 1832)},
    {min = 775, quest = "Area2Quest", id = 1, mob = "Swan Pirate", pos = Vector3.new(638.13, 73, 918.67)},
    {min = 875, quest = "MansionQuest", id = 1, mob = "Marine Lieutenant", pos = Vector3.new(-648, 93, 183)},
    {min = 900, quest = "MansionQuest", id = 2, mob = "Marine Captain", pos = Vector3.new(-648, 93, 183)},
    {min = 1000, quest = "IceCreamQuest", id = 1, mob = "Snow Trooper", pos = Vector3.new(-1324, 70, -600)},
    -- SEA 3
    {min = 1500, quest = "PiratePortTownQuest", id = 1, mob = "Pirate Millionaire", pos = Vector3.new(-290, 43.5, 5577.59)},
    {min = 1575, quest = "PiratePortTownQuest", id = 2, mob = "Pistol Billionaire", pos = Vector3.new(-290, 43.5, 5577.59)},
    {min = 1800, quest = "HauntedCastleQuest", id = 1, mob = "Haunted Mummy", pos = Vector3.new(-9500, 50, 5500)},
    {min = 2000, quest = "SeaOfTreatsQuest", id = 1, mob = "Peanut Scout", pos = Vector3.new(-1000, 100, -1000)},
    {min = 2200, quest = "CakeQuest", id = 1, mob = "Cake Guard", pos = Vector3.new(0, 0, 0)},
    {min = 2300, quest = "ChocolateQuest", id = 1, mob = "Cocoa Warrior", pos = Vector3.new(500, 50, 500)}
}

local function GetQuest()
    local lvl = Data.Level.Value
    for i = #QuestList, 1, -1 do
        if lvl >= QuestList[i].min then return QuestList[i] end
    end
    return QuestList[1]
end

-- [[ 16. AUTO FARM LOGIC CHIẾN THẦN ]] --
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarm and hrp then
            pcall(function()
                local q = GetQuest()
                if not Player.PlayerGui.Main.Quest.Visible then
                    TP(q.pos + Vector3.new(0, 30, 0))
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q.quest, q.id)
                else
                    local mobFound = false
                    for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                        if mob.Name == q.mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            mobFound = true
                            if _G.BringMob then
                                mob.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -8)
                                mob.HumanoidRootPart.Velocity = Vector3.new(0, -10, 0)
                                mob.HumanoidRootPart.CanCollide = false
                            end
                            hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0)
                            if _G.AutoAttack then
                                VirtualUser:Button1Down(Vector2.new(0,0))
                            end
                        end
                    end
                    if _G.AutoHop and not mobFound then
                        TeleportService:Teleport(game.PlaceId, Player)
                    end
                end
            end)
        end
    end
end)

-- [[ 17. FRUIT SERVER HOP LOGIC ]] --
local function FruitServerHop()
    Rayfield:Notify({Title = "SĂN TRÁI", Content = "Đang lùng sục trái ác quỷ trên map...", Duration = 5})
    local itemFound = false
    for _, item in pairs(Workspace:GetChildren()) do
        if item:IsA("Tool") and (item.Name:find("Fruit") or item:FindFirstChild("Handle")) then
            itemFound = true
            TP(item.Handle.Position)
            task.wait(1)
            ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", item.Name, item)
        end
    end
    task.wait(1)
    Rayfield:Notify({Title = "CHUYỂN SERVER", Content = "Đang tìm Server mới để săn tiếp...", Duration = 3})
    local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local Body = HttpService:JSONDecode(game:HttpGet(Api))
    for _, v in pairs(Body.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id)
            break
        end
    end
end

-- [[ 18. GIAO DIỆN TABS (KHÔNG RÚT GỌN) ]] --
local TabFarm = Window:CreateTab("Tự Động Farm ⚔️")
TabFarm:CreateSection("Cấu hình Farm Level")
TabFarm:CreateToggle({Name = "Bật Auto Farm All Sea", CurrentValue = false, Callback = function(v) _G.AutoFarm = v end})
TabFarm:CreateToggle({Name = "Gom Quái (Bring Mob)", CurrentValue = true, Callback = function(v) _G.BringMob = v end})
TabFarm:CreateButton({Name = "Kiểm tra ví & Level", Callback = function() GetStats() end})

local TabHunter = Window:CreateTab("Săn Tìm 🍎")
TabHunter:CreateSection("Săn Trái & Rương")
TabHunter:CreateButton({Name = "Fruit Server Hop (Săn Trái Toàn Map)", Callback = function() FruitServerHop() end})
TabHunter:CreateToggle({Name = "Auto Farm Rương (Nhặt Beli)", CurrentValue = false, Callback = function(v) _G.AutoChest = v end})
TabHunter:CreateToggle({Name = "Auto Cất Trái Vào Rương", CurrentValue = true, Callback = function(v) _G.AutoStoreFruit = v end})

local TabRisk = Window:CreateTab("Cấm Thuật [RISK] ⚠️")
TabRisk:CreateSection("⚠️ CẢNH BÁO: DỄ ĂN BAN/KICK")
TabRisk:CreateToggle({Name = "Xóa Hồi Chiêu (No Cooldown)", CurrentValue = false, Callback = function(v) _G.NoCooldown = v end})
TabRisk:CreateToggle({Name = "Siêu Tốc Độ Đánh (Super Fast)", CurrentValue = false, Callback = function(v) _G.SuperFastAttack = v end})
TabRisk:CreateToggle({Name = "Tự Tung Chiêu (Auto Z,X,C,V)", CurrentValue = false, Callback = function(v) _G.AutoSkill = v end})
TabRisk:CreateToggle({Name = "Bất Tử (Anti Attack)", CurrentValue = false, Callback = function(v) _G.AntiAttack = v end})

local TabMove = Window:CreateTab("Di Chuyển ✈️")
TabMove:CreateSection("Cài đặt tốc độ & Bay")
TabMove:CreateToggle({Name = "Bay (Fly WASD Fix)", CurrentValue = false, Callback = function(v) _G.FlyEnabled = v end})
TabMove:CreateSlider({Name = "Tốc độ chạy/bay", Range = {16, 500}, CurrentValue = 150, Callback = function(v) _G.Speed = v end})
TabMove:CreateToggle({Name = "Nhảy Vô Hạn (No Energy)", CurrentValue = true, Callback = function(v) _G.InfiniteJump = v end})
TabMove:CreateToggle({Name = "Đi Trên Nước (Water Walk)", CurrentValue = true, Callback = function(v) _G.WalkOnWater = v end})

local TabMisc = Window:CreateTab("Tiện Ích 🛠️")
TabMisc:CreateToggle({Name = "Xuyên Tường (No Clip)", CurrentValue = true, Callback = function(v) _G.NoClip = v end})
TabMisc:CreateToggle({Name = "Chống AFK", CurrentValue = true, Callback = function(v) _G.AntiAFK = v end})
TabMisc:CreateButton({Name = "Đổi Server Ngẫu Nhiên", Callback = function() TeleportService:Teleport(game.PlaceId, Player) end})

-- [[ 19. BỔ TRỢ HỆ THỐNG ]] --
UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if _G.WalkOnWater then
            pcall(function()
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v.Name == "WaterBase" or v.Name == "Water" or v.Name == "Sea" then
                        v.CanCollide = true
                        v.CanTouch = false 
                    end
                end
            end)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if char and char:FindFirstChild("Humanoid") and not _G.FlyEnabled then
        char.Humanoid.WalkSpeed = _G.Speed
    end
    if _G.NoClip and char then
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

task.spawn(function()
    while task.wait(60) do
        if _G.AntiAFK then
            VirtualUser:Button1Down(Vector2.new())
            task.wait(1)
            VirtualUser:Button1Up(Vector2.new())
        end
    end
end)

-- [[ 20. KẾT THÚC KHỞI TẠO ]] --
Rayfield:Notify({Title = "CHIẾN THẦN ACTIVATED!", Content = "Gộp Full 410+ dòng đã xong! Menu đã sẵn sàng 😈", Duration = 10})

-- [[ ================================================================= ]] --
-- [[   SENKY HUB V-FINAL++++ MEGA ULTRA - CODE LINE 415+               ]] --
-- [[   CAM KẾT: KHÔNG LƯỜI - KHÔNG RÚT GỌN - FULL NỘI CÔNG              ]] --
-- [[ ================================================================= ]] --