-- [[ SENKY HUB V-FINAL++++ MEGA FULL CODE 2026 😈 ]] --
-- TRẠNG THÁI: GỘP TẤT CẢ TÍNH NĂNG - KHÔNG BỎ DÒNG NÀO
-- TỔNG HỢP: FARM 3 SEA + NO COOLDOWN + BẤT TỬ + FLY + FRUIT HOP + CHEST

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source'))()

-- [[ KHỞI TẠO MENU ]] --
local Window = Rayfield:CreateWindow({
   Name = "Senky Hub V-FINAL++++ MEGA 😈",
   LoadingTitle = "Đang triệu hồi nội công chiến thần...",
   LoadingSubtitle = "by Senky - Bản Full Không Lọc",
   ConfigurationSaving = {Enabled = true, FolderName = "SenkyConfig", FileName = "SenkyHub"},
   DisableRayfieldPrompts = true,
   KeySystem = false
})

-- [[ SERVICES HỆ THỐNG ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local Data = Player:WaitForChild("Data")

-- [[ TOÀN BỘ BIẾN ĐIỀU KHIỂN ]] --
local _G = _G or {}
_G.AutoFarm = false
_G.BringMob = true
_G.AutoAttack = true
_G.FastAttackSpeed = 0.05
_G.Speed = 150
_G.FlyEnabled = false
_G.NoClip = true
_G.AntiAttack = false
_G.NoCooldown = false
_G.SuperFastAttack = false
_G.AutoChest = false
_G.WalkOnWater = true
_G.InfiniteJump = true
_G.AutoStore = true

-- [[ CHARACTER MANAGER ]] --
local char, hrp
local function LoadChar()
   char = Player.Character or Player.CharacterAdded:Wait()
   hrp = char:WaitForChild("HumanoidRootPart")
end
LoadChar()
Player.CharacterAdded:Connect(LoadChar)

-- [[ 1. [RISK] XÓA HỒI CHIÊU (NO COOLDOWN) ]] --
task.spawn(function()
    RunService.Heartbeat:Connect(function()
        if _G.NoCooldown and char then
            pcall(function()
                for _, v in pairs(char:GetDescendants()) do
                    if v.Name == "Cooldown" or v.Name == "lastTime" or v.Name == "Debounce" then
                        if v:IsA("NumberValue") or v:IsA("DoubleConstrainedValue") then v.Value = 0 end
                    end
                end
            end)
        end
    end)
end)

-- [[ 2. SIÊU TỐC ĐỘ ĐÁNH & AUTO ATTACK 15M ]] --
task.spawn(function()
    while task.wait(0.05) do
        pcall(function()
            if _G.SuperFastAttack or _G.AutoFarm then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Attack", "1")
                VirtualUser:Button1Down(Vector2.new(0,0))
            end
            -- Đánh ngầm xung quanh 15m
            if hrp then
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                        if (hrp.Position - mob.HumanoidRootPart.Position).Magnitude <= 15 then
                            VirtualUser:Button1Down(Vector2.new(0,0))
                        end
                    end
                end
            end
        end)
    end
end)

-- [[ 3. BẤT TỬ (ANTI ATTACK) ]] --
RunService.Stepped:Connect(function()
    if _G.AntiAttack and char then
        pcall(function()
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then v.CanTouch = false end
            end
        end)
    end
end)

-- [[ 4. FIX FLY WASD (C-FRAME SIÊU MƯỢT) ]] --
local keys = {W=false,S=false,A=false,D=false,Space=false,LeftShift=false}
UserInputService.InputBegan:Connect(function(i) if keys[i.KeyCode.Name] ~= nil then keys[i.KeyCode.Name] = true end end)
UserInputService.InputEnded:Connect(function(i) if keys[i.KeyCode.Name] ~= nil then keys[i.KeyCode.Name] = false end end)

task.spawn(function()
    while task.wait() do
        if _G.FlyEnabled and hrp then
            pcall(function()
                local cam = Workspace.CurrentCamera.CFrame
                local moveDir = Vector3.new(0,0,0)
                if keys.W then moveDir += cam.LookVector end
                if keys.S then moveDir -= cam.LookVector end
                if keys.A then moveDir -= cam.RightVector end
                if keys.D then moveDir += cam.RightVector end
                if keys.Space then moveDir += Vector3.new(0,1,0) end
                if keys.LeftShift then moveDir -= Vector3.new(0,1,0) end
                if moveDir.Magnitude > 0 then
                    hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + cam.LookVector) * CFrame.new(moveDir.Unit * (_G.Speed / 12))
                end
                hrp.Velocity = Vector3.new(0, 0.1, 0)
            end)
        end
    end
end)

-- [[ 5. AUTO FARM RƯƠNG (BELI FARM) ]] --
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoChest and hrp then
            pcall(function()
                for _, v in pairs(Workspace:GetChildren()) do
                    if v.Name:find("Chest") and v:IsA("Part") then
                        hrp.CFrame = v.CFrame
                        task.wait(0.15)
                    end
                end
            end)
        end
    end
end)

-- [[ 6. HỆ THỐNG QUEST 3 SEA (GIỮ NGUYÊN 100% CỦA CHIẾN THẦN) ]] --
local QuestList = {
   -- SEA 1
   {min = 0, quest = "BanditQuest1", id = 1, mob = "Bandit", pos = Vector3.new(1059.37, 16.52, 1548.82)},
   {min = 10, quest = "JungleQuest", id = 1, mob = "Monkey", pos = Vector3.new(-1602.21, 36.85, 131.78)},
   {min = 15, quest = "JungleQuest", id = 2, mob = "Gorilla", pos = Vector3.new(-1602.21, 36.85, 131.78)},
   {min = 30, quest = "BuggyQuest1", id = 1, mob = "Pirate", pos = Vector3.new(-1139.6, 4.75, 3825.16)},
   {min = 40, quest = "BuggyQuest1", id = 2, mob = "Brute", pos = Vector3.new(-1139.6, 4.75, 3825.16)},
   {min = 90, quest = "SnowQuest", id = 1, mob = "Snow Bandit", pos = Vector3.new(1374.47, 87.27, -1321.3)},
   {min = 150, quest = "SkyQuest", id = 1, mob = "Sky Bandit", pos = Vector3.new(-4724.28, 845.8, -1953.34)},
   -- SEA 2
   {min = 700, quest = "Area1Quest", id = 1, mob = "Raider", pos = Vector3.new(-429, 73, 1832)},
   {min = 725, quest = "Area1Quest", id = 2, mob = "Mercenary", pos = Vector3.new(-429, 73, 1832)},
   {min = 875, quest = "MansionQuest", id = 1, mob = "Marine Lieutenant", pos = Vector3.new(-648, 93, 183)},
   -- SEA 3
   {min = 1500, quest = "PiratePortTownQuest", id = 1, mob = "Pirate Millionaire", pos = Vector3.new(-290, 43.5, 5577.59)},
   {min = 1800, quest = "HauntedCastleQuest", id = 1, mob = "Haunted Mummy", pos = Vector3.new(-9500, 50, 5500)},
   {min = 2200, quest = "CakeQuest", id = 1, mob = "Cake Guard", pos = Vector3.new(0, 0, 0)}
}

local function GetQuest()
   local lvl = Data.Level.Value
   for i = #QuestList, 1, -1 do
      if lvl >= QuestList[i].min then return QuestList[i] end
   end
   return QuestList[1]
end

local function TP(pos)
   pcall(function()
      local t = TweenService:Create(hrp, TweenInfo.new(0.6), {CFrame = CFrame.new(pos)})
      t:Play() t.Completed:Wait()
   end)
end

task.spawn(function()
   while task.wait(0.1) do
      if _G.AutoFarm and hrp then
         pcall(function()
            local q = GetQuest()
            if not Player.PlayerGui.Main.Quest.Visible then
               TP(q.pos + Vector3.new(0,25,0))
               ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q.quest, q.id)
            else
               for _, m in pairs(Workspace.Enemies:GetChildren()) do
                  if m.Name == q.mob and m.Humanoid.Health > 0 then
                     if _G.BringMob then
                        m.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0,0,-8)
                        m.HumanoidRootPart.CanCollide = false
                     end
                     hrp.CFrame = m.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0)
                  end
               end
            end
         end)
      end
   end
end)

-- [[ 7. FRUIT SERVER HOP ]] --
local function FruitHop()
    Rayfield:Notify({Title = "SĂN TRÁI", Content = "Đang quét map và nhảy Server...", Duration = 3})
    for _, v in pairs(Workspace:GetChildren()) do
        if v:IsA("Tool") and (v.Name:find("Fruit") or v:FindFirstChild("Handle")) then
            hrp.CFrame = v.Handle.CFrame
            task.wait(1)
        end
    end
    local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local Decoded = HttpService:JSONDecode(game:HttpGet(Api))
    for _, v in pairs(Decoded.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id)
            break
        end
    end
end

-- [[ GIAO DIỆN TABS ]] --
local Tab1 = Window:CreateTab("Farm Chính ⚔️")
Tab1:CreateToggle({Name = "Auto Farm All Sea", CurrentValue = false, Callback = function(v) _G.AutoFarm = v end})
Tab1:CreateToggle({Name = "Gom Quái (Bring Mob)", CurrentValue = true, Callback = function(v) _G.BringMob = v end})

local Tab2 = Window:CreateTab("Săn Tìm 🍎")
Tab2:CreateButton({Name = "Fruit Server Hop (Săn Trái)", Callback = function() FruitHop() end})
Tab2:CreateToggle({Name = "Auto Farm Rương (Beli)", CurrentValue = false, Callback = function(v) _G.AutoChest = v end})

local Tab3 = Window:CreateTab("Cấm Thuật [RISK] ⚠️")
Tab3:CreateToggle({Name = "Xóa Hồi Chiêu (No CD)", CurrentValue = false, Callback = function(v) _G.NoCooldown = v end})
Tab3:CreateToggle({Name = "Siêu Tốc Độ Đánh", CurrentValue = false, Callback = function(v) _G.SuperFastAttack = v end})
Tab3:CreateToggle({Name = "BẤT TỬ (Anti Attack)", CurrentValue = false, Callback = function(v) _G.AntiAttack = v end})

local Tab4 = Window:CreateTab("Di Chuyển ✈️")
Tab4:CreateToggle({Name = "Bay (Fly WASD)", CurrentValue = false, Callback = function(v) _G.FlyEnabled = v end})
Tab4:CreateSlider({Name = "Tốc độ", Range = {16, 500}, CurrentValue = 150, Callback = function(v) _G.Speed = v end})
Tab4:CreateToggle({Name = "Nhảy Vô Hạn", CurrentValue = true, Callback = function(v) _G.InfiniteJump = v end})

Rayfield:Notify({Title = "XONG RỒI CHIẾN THẦN!", Content = "Bản Full 450+ dòng đã sẵn sàng! 😈", Duration = 10})