-- [[ SENKY HUB V-FINAL++++ MEGA ULTRA UPDATE 2026 😈 ]] --
-- TRẠNG THÁI: ĐÃ GỘP FIX FLY + AUTO ATTACK 15M CHẠY NGẦM
-- GIỮ NGUYÊN 100% LOGIC QUEST & FARM CỦA CHIẾN THẦN

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ KHỞI TẠO WINDOW ]] --
local Window = Rayfield:CreateWindow({
   Name = "Senky Hub V-FINAL++++ MEGA ULTRA 😈",
   LoadingTitle = "Đang gộp nội công chiến thần...",
   LoadingSubtitle = "by Senky Hub Team - 2026",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SenkyConfig",
      FileName = "SenkyHubUltra"
   },
   DisableRayfieldPrompts = true,
   KeySystem = false
})

-- [[ TOÀN BỘ SERVICES ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local Player = Players.LocalPlayer
local Data = Player:WaitForChild("Data")

-- [[ TOÀN BỘ VARIABLES HỆ THỐNG ]] --
local _G = _G or {}
_G.AutoFarm = false
_G.BringMob = true
_G.AutoAttack = true
_G.FastAttackSpeed = 0.08
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

-- [[ HỆ THỐNG THÔNG BÁO TÀI SẢN (GÓC MÀN HÌNH) ]] --
local function GetStats()
    local Beli = Data.Beli.Value
    local Fragments = Data.Fragments.Value
    local StatsPoint = Data.StatsPoints.Value
    local Level = Data.Level.Value
    local X2Time = "Không có"
    
    pcall(function()
        for _, v in pairs(Player:GetChildren()) do
            if v:IsA("NumberValue") and v.Name:find("Exp") then
                X2Time = math.floor(v.Value/60) .. " Phút"
            end
        end
    end)

    Rayfield:Notify({
        Title = "THỐNG KÊ CHIẾN THẦN 😈",
        Content = string.format(
            "📍 Level: %s\n💰 Beli: %s\n✨ Fragments: %s\n📊 Stats Point: %s\n⏳ X2 Exp: %s",
            tostring(Level), tostring(Beli), tostring(Fragments), tostring(StatsPoint), X2Time
        ),
        Duration = 15
    })
end

GetStats()

-- [[ CHARACTER MANAGER ]] --
local char, hrp
local function LoadChar()
   char = Player.Character or Player.CharacterAdded:Wait()
   hrp = char:WaitForChild("HumanoidRootPart")
end
LoadChar()
Player.CharacterAdded:Connect(LoadChar)

-- [[ NEW: AUTO ATTACK 15M (CHẠY NGẦM KHÔNG CẦN BẬT) ]] --
task.spawn(function()
    while task.wait(_G.FastAttackSpeed) do
        pcall(function()
            if char and hrp then
                for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        local dist = (hrp.Position - mob.HumanoidRootPart.Position).Magnitude
                        if dist <= 15 then -- Phạm vi xung quanh 15 mét
                            VirtualUser:Button1Down(Vector2.new(0,0))
                        end
                    end
                end
            end
        end)
    end
end)

-- [[ FIX FLY WASD (C-FRAME SIÊU MƯỢT - KHÔNG ĐỨNG IM) ]] --
local keys = {W=false,S=false,A=false,D=false,Space=false,LeftShift=false}
UserInputService.InputBegan:Connect(function(input)
   local name = input.KeyCode.Name
   if keys[name] ~= nil then keys[name] = true end
end)
UserInputService.InputEnded:Connect(function(input)
   local name = input.KeyCode.Name
   if keys[name] ~= nil then keys[name] = false end
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
                    hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + cam.LookVector) * CFrame.new(moveDir.Unit * (_G.Speed / 12))
                end
                hrp.Velocity = Vector3.new(0, 0.1, 0)
            end)
        end
    end
end)

-- [[ NHÀY VÔ HẠN ]] --
UserInputService.JumpRequest:Connect(function()
   if _G.InfiniteJump and char:FindFirstChildOfClass("Humanoid") then
      char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

-- [[ ĐỨNG TRÊN NƯỚC & KHÁNG SÁT THƯƠNG NƯỚC ]] --
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

-- [[ SPEED & NO CLIP ]] --
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

-- [[ TELEPORT FUNCTION ]] --
local function TP(pos)
   pcall(function()
      local tween = TweenService:Create(hrp, TweenInfo.new(0.6), {CFrame = CFrame.new(pos)})
      tween:Play()
      tween.Completed:Wait()
   end)
end

-- [[ AUTO FRUIT VIP ]] --
task.spawn(function()
   while task.wait(1) do
      if _G.AutoFruit then
         pcall(function()
            for _, item in pairs(Workspace:GetChildren()) do
               if item:IsA("Tool") and (item.Name:find("Fruit") or item:FindFirstChild("Handle")) then
                  TP(item.Handle.Position)
                  task.wait(0.5)
                  if _G.AutoStoreFruit then
                     ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", item.Name, item)
                  end
               end
            end
         end)
      end
      if _G.AutoRandom then
         pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "Buy")
         end)
      end
   end
end)

-- [[ TOÀN BỘ QUEST TABLE 3 SEA - GIỮ NGUYÊN 100% ]] --
local QuestList = {
   {min = 0, quest = "BanditQuest1", id = 1, mob = "Bandit", pos = Vector3.new(1059.37, 16.52, 1548.82)},
   {min = 10, quest = "JungleQuest", id = 1, mob = "Monkey", pos = Vector3.new(-1602.21, 36.85, 131.78)},
   {min = 15, quest = "JungleQuest", id = 2, mob = "Gorilla", pos = Vector3.new(-1602.21, 36.85, 131.78)},
   {min = 30, quest = "BuggyQuest1", id = 1, mob = "Pirate", pos = Vector3.new(-1139.6, 4.75, 3825.16)},
   {min = 40, quest = "BuggyQuest1", id = 2, mob = "Brute", pos = Vector3.new(-1139.6, 4.75, 3825.16)},
   {min = 60, quest = "DesertQuest", id = 1, mob = "Desert Bandit", pos = Vector3.new(932.79, 6.45, 4489.83)},
   {min = 75, quest = "DesertQuest", id = 2, mob = "Desert Officer", pos = Vector3.new(932.79, 6.45, 4489.83)},
   {min = 90, quest = "SnowQuest", id = 1, mob = "Snow Bandit", pos = Vector3.new(1374.47, 87.27, -1321.3)},
   {min = 100, quest = "SnowQuest", id = 2, mob = "Snowman", pos = Vector3.new(1374.47, 87.27, -1321.3)},
   {min = 120, quest = "MarineQuest2", id = 1, mob = "Chief Petty Officer", pos = Vector3.new(-4882.86, 22.65, -5102.86)},
   {min = 150, quest = "SkyQuest", id = 1, mob = "Sky Bandit", pos = Vector3.new(-4724.28, 845.8, -1953.34)},
   {min = 700, quest = "Area1Quest", id = 1, mob = "Raider", pos = Vector3.new(-429, 73, 1832)},
   {min = 875, quest = "MansionQuest", id = 1, mob = "Marine Lieutenant", pos = Vector3.new(-648, 93, 183)},
   {min = 1500, quest = "PiratePortTownQuest", id = 1, mob = "Pirate Millionaire", pos = Vector3.new(-290, 43.5, 5577.59)},
   {min = 2200, quest = "CakeQuest", id = 1, mob = "Cake Guard", pos = Vector3.new(0, 0, 0)}
}

local function GetQuest()
   local lvl = Data.Level.Value
   for i = #QuestList, 1, -1 do
      if lvl >= QuestList[i].min then return QuestList[i] end
   end
   return QuestList[1]
end

-- [[ AUTO FARM LOGIC CHIẾN THẦN ]] --
task.spawn(function()
   while task.wait(0.08) do
      if _G.AutoFarm and hrp then
         pcall(function()
            local q = GetQuest()
            if not Player.PlayerGui.Main.Quest.Visible then
               TP(q.pos + Vector3.new(0,20,0))
               ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q.quest, q.id)
            else
               local foundMob = false
               for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                  if mob.Name == q.mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                     foundMob = true
                     if _G.BringMob then
                        mob.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0,0,-8)
                        mob.HumanoidRootPart.Velocity = Vector3.new(0, -30, 0)
                        mob.HumanoidRootPart.CanCollide = false
                     end
                     hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0)
                     -- Auto Attack bổ trợ trong Farm
                     VirtualUser:Button1Down(Vector2.new(0,0))
                     task.wait(_G.FastAttackSpeed)
                     VirtualUser:Button1Up(Vector2.new(0,0))
                  end
               end
               if _G.AutoHop and not foundMob then
                  TeleportService:Teleport(game.PlaceId, Player)
               end
            end
         end)
      end
   end
end)

-- [[ GIAO DIỆN TABS ]] --
local MainTab = Window:CreateTab("Bảng Điều Khiển")
MainTab:CreateSection("Thống kê tài khoản")
MainTab:CreateButton({Name = "Kiểm tra ví & X2 Exp", Callback = function() GetStats() end})

MainTab:CreateSection("Tự Động Farm")
MainTab:CreateToggle({Name = "Auto Farm All Sea", CurrentValue = false, Callback = function(v) _G.AutoFarm = v end})
MainTab:CreateToggle({Name = "Gom Quái (Bring Mob)", CurrentValue = true, Callback = function(v) _G.BringMob = v end})

local FruitTab = Window:CreateTab("Trái Ác Quỷ")
FruitTab:CreateToggle({Name = "Auto Nhặt Trái Map", CurrentValue = false, Callback = function(v) _G.AutoFruit = v end})
FruitTab:CreateToggle({Name = "Auto Cất Trái (Store)", CurrentValue = true, Callback = function(v) _G.AutoStoreFruit = v end})
FruitTab:CreateToggle({Name = "Auto Random Fruit (Gacha)", CurrentValue = false, Callback = function(v) _G.AutoRandom = v end})

local MoveTab = Window:CreateTab("Di Chuyển VIP")
MoveTab:CreateToggle({Name = "Bay (Fly WASD - FIXED)", CurrentValue = false, Callback = function(v) _G.FlyEnabled = v end})
MoveTab:CreateToggle({Name = "Nhảy Vô Hạn (Space)", CurrentValue = true, Callback = function(v) _G.InfiniteJump = v end})
MoveTab:CreateToggle({Name = "Đứng Trên Nước & Kháng Damage", CurrentValue = true, Callback = function(v) _G.WalkOnWater = v end})
MoveTab:CreateSlider({Name = "Tốc độ chạy/bay", Range = {16, 500}, CurrentValue = 150, Callback = function(v) _G.Speed = v end})

local UtilsTab = Window:CreateTab("Tiện Ích")
UtilsTab:CreateToggle({Name = "Xuyên tường (NoClip)", CurrentValue = true, Callback = function(v) _G.NoClip = v end})
UtilsTab:CreateToggle({Name = "Anti AFK", CurrentValue = true, Callback = function(v) _G.AntiAFK = v end})
UtilsTab:CreateButton({Name = "Đổi Server (Server Hop)", Callback = function() TeleportService:Teleport(game.PlaceId, Player) end})

-- [[ ANTI AFK LOGIC ]] --
task.spawn(function()
   while _G.AntiAFK do
      VirtualUser:Button1Down(Vector2.new())
      task.wait(60)
   end
end)

Rayfield:Notify({Title = "ULTRA MERGE XONG!", Content = "Đã gộp Auto Attack 15m & Fix Fly! Quẩy thôi 😈", Duration = 10})