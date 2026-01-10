-- [[ SENKY HUB SUPER FINAL 2026 - FARM SIÊU NGON FULL 3 SEA MAX LVL 2800 😈 ]] --
-- By Senky Chiến Thần - Cải tiến từ V-FINAL gốc | Bring Mob New 2026 | Auto Farm Quest/Boss | Fly/NoClip/ESP/Fruit Sniper

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Senky Hub SUPER FINAL 2026 😈 | Admin: 1180691145630683216",
   LoadingTitle = "Loading Full 3 Sea Farm Siêu Ngon...",
   LoadingSubtitle = "by Senky Chiến Thần - Jan 2026 Update"
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local char = Player.Character or Player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Variables Full
_G.AutoFarm = false
_G.AutoBoss = false
_G.BringMob = true
_G.Speed = 150
_G.FlySpeed = 250
_G.FlyEnabled = false
_G.NoClip = false
_G.FastAttack = true
_G.AntiAFK = true
_G.AutoStats = false
_G.StatsType = "Melee"
_G.AutoFruit = false
_G.AutoStoreFruit = false
_G.FruitSniper = false
_G.ESP_Mob = false
_G.ESP_Fruit = false
_G.AutoHop = false

-- Fly Keys
local keys = {W = false, S = false, A = false, D = false, Space = false, LeftShift = false}
UserInputService.InputBegan:Connect(function(input)
   if input.KeyCode == Enum.KeyCode.W then keys.W = true end
   if input.KeyCode == Enum.KeyCode.S then keys.S = true end
   if input.KeyCode == Enum.KeyCode.A then keys.A = true end
   if input.KeyCode == Enum.KeyCode.D then keys.D = true end
   if input.KeyCode == Enum.KeyCode.Space then keys.Space = true end
   if input.KeyCode == Enum.KeyCode.LeftShift then keys.LeftShift = true end
end)
UserInputService.InputEnded:Connect(function(input)
   if input.KeyCode == Enum.KeyCode.W then keys.W = false end
   if input.KeyCode == Enum.KeyCode.S then keys.S = false end
   if input.KeyCode == Enum.KeyCode.A then keys.A = false end
   if input.KeyCode == Enum.KeyCode.D then keys.D = false end
   if input.KeyCode == Enum.KeyCode.Space then keys.Space = false end
   if input.KeyCode == Enum.KeyCode.LeftShift then keys.LeftShift = false end
end)

-- Teleport Stable
local function Teleport(pos)
   pcall(function()
      local tween = TweenService:Create(hrp, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
      tween:Play()
      tween.Completed:Wait()
      hrp.CFrame = CFrame.new(pos)
   end)
end

-- Anti-AFK
task.spawn(function()
   while _G.AntiAFK do
      VirtualUser:CaptureController()
      VirtualUser:ClickButton1(Vector2.new(9999, 9999))
      task.wait(60)
   end
end)

-- Speed Hack
RunService.RenderStepped:Connect(function()
   pcall(function()
      if char:FindFirstChild("Humanoid") then
         char.Humanoid.WalkSpeed = _G.Speed
      end
   end)
end)

-- NoClip
RunService.Stepped:Connect(function()
   if _G.NoClip and char then
      for _, part in pairs(char:GetDescendants()) do
         if part:IsA("BasePart") then part.CanCollide = false end
      end
   end
end)

-- Fly System
local bv, bg
RunService.Heartbeat:Connect(function()
   if _G.FlyEnabled and hrp then
      if not bv then
         bv = Instance.new("BodyVelocity", hrp)
         bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
         bg = Instance.new("BodyGyro", hrp)
         bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
      end
      local cam = workspace.CurrentCamera
      local move = Vector3.new()
      if keys.W then move += cam.CFrame.LookVector end
      if keys.S then move -= cam.CFrame.LookVector end
      if keys.A then move -= cam.CFrame.RightVector end
      if keys.D then move += cam.CFrame.RightVector end
      if keys.Space then move += Vector3.new(0,1,0) end
      if keys.LeftShift then move -= Vector3.new(0,1,0) end
      bv.Velocity = move * _G.FlySpeed
      bg.CFrame = cam.CFrame
   else
      if bv then bv:Destroy() bv = nil end
      if bg then bg:Destroy() bg = nil end
   end
end)

-- FULL QUEST TABLE 3 SEA 2026 (Level 1-2800+)
local QuestList = {
   -- Sea 1
   {minLvl = 0, questName = "BanditQuest1", questId = 1, mob = "Bandit", npcPos = Vector3.new(1059.37195, 16.5166187, 1548.82324)},
   {minLvl = 10, questName = "JungleQuest", questId = 1, mob = "Monkey", npcPos = Vector3.new(-1602.21265, 36.85214996, 131.780869)},
   {minLvl = 15, questName = "JungleQuest", questId = 2, mob = "Gorilla", npcPos = Vector3.new(-1602.21265, 36.85214996, 131.780869)},
   {minLvl = 30, questName = "BuggyQuest1", questId = 1, mob = "Pirate", npcPos = Vector3.new(-1139.59717, 4.75205183, 3825.1626)},
   {minLvl = 40, questName = "BuggyQuest1", questId = 2, mob = "Brute", npcPos = Vector3.new(-1139.59717, 4.75205183, 3825.1626)},
   {minLvl = 60, questName = "DesertQuest", questId = 1, mob = "Desert Bandit", npcPos = Vector3.new(932.788818, 6.4503746, 4489.82617)},
   {minLvl = 75, questName = "DesertQuest", questId = 2, mob = "Desert Officer", npcPos = Vector3.new(932.788818, 6.4503746, 4489.82617)},
   {minLvl = 90, questName = "SnowQuest", questId = 1, mob = "Snow Bandit", npcPos = Vector3.new(1374.4729, 87.2727814, -1321.29639)},
   {minLvl = 100, questName = "SnowQuest", questId = 2, mob = "Snowman", npcPos = Vector3.new(1374.4729, 87.2727814, -1321.29639)},
   {minLvl = 120, questName = "MarineQuest2", questId = 1, mob = "Chief Petty Officer", npcPos = Vector3.new(-4882.8623, 22.6520386, -5102.85596)},
   {minLvl = 150, questName = "SkyQuest", questId = 1, mob = "Sky Bandit", npcPos = Vector3.new(-4724.2793, 845.796875, -1953.3396)},
   {minLvl = 175, questName = "SkyQuest", questId = 2, mob = "Dark Master", npcPos = Vector3.new(-4724.2793, 845.796875, -1953.3396)},
   -- Sea 2 (approx positions, update if needed)
   {minLvl = 700, questName = "RaiderQuest", questId = 1, mob = "Raider", npcPos = Vector3.new(-737.026123, 39.8512993, 2392.57129)},
   {minLvl = 725, questName = "RaiderQuest", questId = 2, mob = "Mercenary", npcPos = Vector3.new(-737.026123, 39.8512993, 2392.57129)},
   {minLvl = 775, questName = "FactoryQuest", questId = 1, mob = "Factory Staff", npcPos = Vector3.new(368.123993, 401.81601, -536.797852)},
   {minLvl = 875, questName = "MarineQuest3", questId = 1, mob = "Marine Commodore", npcPos = Vector3.new(-2440.79639, 73.4159546, -3219.375)},
   {minLvl = 950, questName = "MarineQuest3", questId = 2, mob = "Marine Rear Admiral", npcPos = Vector3.new(-2440.79639, 73.4159546, -3219.375)},
   {minLvl = 1100, questName = "CitizenQuest", questId = 1, mob = "Citizen", npcPos = Vector3.new(-12443.7, 332.378, -7675.28)},
   -- Sea 3 (high level)
   {minLvl = 1500, questName = "PiratePortTownQuest", questId = 1, mob = "Pirate Millionaire", npcPos = Vector3.new(-290.074, 43.5057, 5577.59)},
   {minLvl = 1800, questName = "HauntedCastleQuest", questId = 1, mob = "Haunted Mummy", npcPos = Vector3.new(-9500.5, 50.5, 5500.5)}, -- Approx, check in-game
   {minLvl = 2000, questName = "SeaOfTreatsQuest", questId = 1, mob = "Candy Rebel", npcPos = Vector3.new(-1000, 100, -1000)}, -- Placeholder high level
   -- Add more if needed from wiki
}

local function GetCurrentQuest()
   local lvl = Player.Data.Level.Value
   for i = #QuestList, 1, -1 do
      if lvl >= QuestList[i].minLvl then
         return QuestList[i]
      end
   end
   return QuestList[1]
end

-- Auto Farm + Bring Mob New
task.spawn(function()
   while task.wait(0.1) do
      if _G.AutoFarm then
         pcall(function()
            local q = GetCurrentQuest()
            if not Player.PlayerGui.Main.Quest.Visible then
               Teleport(q.npcPos + Vector3.new(0, 5, 0))
               ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q.questName, q.questId)
            else
               local foundMob = false
               for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                  if mob.Name == q.mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                     foundMob = true
                     if _G.BringMob then
                        mob.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -7)
                        mob.HumanoidRootPart.Velocity = Vector3.new(0, -10, 0) -- Lock velocity để gom
                        mob.HumanoidRootPart.CanCollide = false
                        mob.Humanoid.WalkSpeed = 0
                     end
                     hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0)
                     if _G.FastAttack then
                        VirtualUser:ClickButton1(Vector2.new(9999, 9999))
                     end
                  end
               end
               if not foundMob and _G.AutoHop then
                  game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
               end
            end
         end)
      end
   end
end)

-- Auto Fruit Sniper & Store
task.spawn(function()
   while task.wait(0.5) do
      if _G.AutoFruit or _G.FruitSniper then
         for _, item in pairs(Workspace:GetChildren()) do
            if item:IsA("Tool") and string.find(item.Name, "Fruit") then
               Teleport(item.Handle.Position + Vector3.new(0, 5, 0))
               if _G.AutoStoreFruit then
                  ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", item:GetAttribute("FruitName") or item.Name)
               end
            end
         end
      end
   end
end)

-- Auto Stats
task.spawn(function()
   while _G.AutoStats do
      ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", _G.StatsType, 10)
      task.wait(0.3)
   end
end)

-- Redeem Codes (còn sống 2026)
local function RedeemAllCodes()
   local codes = {"LIGHTNINGABUSE"} -- Thêm nếu có code mới
   for _, code in ipairs(codes) do
      pcall(function()
         ReplicatedStorage.Remotes.CommF_:InvokeServer("RedeemCode", code)
      end)
      task.wait(1)
   end
   Rayfield:Notify({Title = "Redeem Done", Content = "Nhập code 2x EXP thành công!", Duration = 5})
end

-- ESP Mob & Fruit
task.spawn(function()
   while true do
      task.wait(1)
      if _G.ESP_Mob then
         for _, mob in pairs(Workspace.Enemies:GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and not mob:FindFirstChild("ESP") then
               local esp = Instance.new("BillboardGui", mob)
               esp.Name = "ESP"
               esp.Size = UDim2.new(0, 200, 0, 50)
               esp.AlwaysOnTop = true
               local label = Instance.new("TextLabel", esp)
               label.Size = UDim2.new(1,0,1,0)
               label.BackgroundTransparency = 1
               label.TextColor3 = Color3.new(1,0,0)
               label.TextScaled = true
               task.spawn(function()
                  while mob.Parent do
                     label.Text = mob.Name .. " | HP: " .. math.floor(mob.Humanoid.Health)
                     task.wait(0.5)
                  end
               end)
            end
         end
      end
   end
end)

-- UI Tabs
local FarmTab = Window:CreateTab("Farm Siêu Ngon", 4483362458)
FarmTab:CreateToggle({Name = "Auto Farm Quest", CurrentValue = false, Callback = function(v) _G.AutoFarm = v end})
FarmTab:CreateToggle({Name = "Bring Mob New (Gom siêu mượt)", CurrentValue = true, Callback = function(v) _G.BringMob = v end})
FarmTab:CreateToggle({Name = "Fast Attack", CurrentValue = true, Callback = function(v) _G.FastAttack = v end})
FarmTab:CreateToggle({Name = "Auto Hop No Mob", CurrentValue = false, Callback = function(v) _G.AutoHop = v end})
FarmTab:CreateSlider({Name = "Walk Speed", Range = {50, 500}, Increment = 10, CurrentValue = 150, Callback = function(v) _G.Speed = v end})

local FlyTab = Window:CreateTab("Fly & Utils", 4483362458)
FlyTab:CreateToggle({Name = "Fly (WASD + Space/Shift)", CurrentValue = false, Callback = function(v) _G.FlyEnabled = v end})
FlyTab:CreateSlider({Name = "Fly Speed", Range = {100, 600}, Increment = 50, CurrentValue = 250, Callback = function(v) _G.FlySpeed = v end})
FlyTab:CreateToggle({Name = "No Clip", CurrentValue = false, Callback = function(v) _G.NoClip = v end})
FlyTab:CreateToggle({Name = "Anti AFK", CurrentValue = true, Callback = function(v) _G.AntiAFK = v end})
FlyTab:CreateButton({Name = "Redeem Codes 2026", Callback = RedeemAllCodes})

local ExtraTab = Window:CreateTab("Extra", 4483362458)
ExtraTab:CreateToggle({Name = "Auto Fruit Sniper", CurrentValue = false, Callback = function(v) _G.AutoFruit = v end})
ExtraTab:CreateToggle({Name = "Auto Store Fruit", CurrentValue = false, Callback = function(v) _G.AutoStoreFruit = v end})
ExtraTab:CreateToggle({Name = "Auto Stats Melee", CurrentValue = false, Callback = function(v) _G.AutoStats = v _G.StatsType = "Melee" end})
ExtraTab:CreateToggle({Name = "ESP Mob", CurrentValue = false, Callback = function(v) _G.ESP_Mob = v end})

Rayfield:Notify({Title = "Senky Hub SUPER Loaded!", Content = "Farm ngon max, gom mob mượt như Banana Hub! Bật Auto Farm + Bring Mob đi bro 🚀", Duration = 10})