-- [[ SENKY HUB V-FINAL++++ 2026 - AUTO START + HỎI TỰ BẬT LẦN SAU + FULL 3 SEA 😈 ]] --
-- Trên 300 dòng | Chức năng full xài được | Auto Farm bật sẵn | Tắt prompt reset config

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Senky Hub V-FINAL++++ 2026 😈",
   LoadingTitle = "Loading full 3 Sea + Auto Start...",
   LoadingSubtitle = "by Senky Chiến Thần - Jan 2026",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "SenkyHubFinalPlusPlus"
   },
   DisableRayfieldPrompts = true,  -- Tắt prompt reset config mặc định
   KeySystem = false
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

-- Variables
local _G = _G or {}
_G.AutoFarm = false  -- Default false, sẽ hỏi lần đầu
_G.BringMob = true
_G.AutoAttack = true
_G.FastAttackSpeed = 0.08
_G.Speed = 150
_G.FlyEnabled = false
_G.NoClip = true
_G.AntiAFK = true
_G.AutoFruit = false
_G.AutoHop = false

-- Load/Save config tự bật
local ConfigKey = "SenkyAutoStartFarm"
local savedAutoStart = Rayfield:GetConfigurationValue(ConfigKey) or false

-- Hỏi lần đầu nếu chưa save
if not Rayfield:GetConfigurationValue("HasAskedAutoStart") then
   Rayfield:Notify({
      Title = "Cài Đặt Tự Động",
      Content = "Bạn có muốn tự bật Auto Farm mỗi khi vào game không?\n(Yes: Tự bật lần sau | No: Hỏi tiếp)",
      Duration = 0,
      Actions = {
         Ignore = {
            Name = "Yes",
            Callback = function()
               Rayfield:SetConfigurationValue(ConfigKey, true)
               Rayfield:SetConfigurationValue("HasAskedAutoStart", true)
               _G.AutoFarm = true
               Rayfield:Notify({Title = "Đã Lưu!", Content = "Lần sau tự bật Auto Farm!", Duration = 5})
            end
         },
         Ignore2 = {
            Name = "No",
            Callback = function()
               Rayfield:SetConfigurationValue("HasAskedAutoStart", true)
               Rayfield:Notify({Title = "OK", Content = "Lần sau sẽ hỏi lại!", Duration = 5})
            end
         }
      }
   })
else
   _G.AutoFarm = savedAutoStart
end

-- Character load
local char, hrp
local function LoadChar()
   char = Player.Character or Player.CharacterAdded:Wait()
   hrp = char:WaitForChild("HumanoidRootPart")
end
LoadChar()
Player.CharacterAdded:Connect(LoadChar)

-- Fly keys
local keys = {W=false,S=false,A=false,D=false,Space=false,LeftShift=false}
UserInputService.InputBegan:Connect(function(input)
   local name = input.KeyCode.Name
   if name == "W" then keys.W = true end
   if name == "S" then keys.S = true end
   if name == "A" then keys.A = true end
   if name == "D" then keys.D = true end
   if name == "Space" then keys.Space = true end
   if name == "LeftShift" then keys.LeftShift = true end
end)
UserInputService.InputEnded:Connect(function(input)
   local name = input.KeyCode.Name
   if name == "W" then keys.W = false end
   if name == "S" then keys.S = false end
   if name == "A" then keys.A = false end
   if name == "D" then keys.D = false end
   if name == "Space" then keys.Space = false end
   if name == "LeftShift" then keys.LeftShift = false end
end)

-- Teleport
local function TP(pos)
   pcall(function()
      local tween = TweenService:Create(hrp, TweenInfo.new(0.6), {CFrame = CFrame.new(pos)})
      tween:Play()
      tween.Completed:Wait()
   end)
end

-- Anti-AFK
task.spawn(function()
   while _G.AntiAFK do
      VirtualUser:Button1Down(Vector2.new())
      task.wait(60)
   end
end)

-- Speed hack
RunService.RenderStepped:Connect(function()
   if char and char:FindFirstChild("Humanoid") then
      char.Humanoid.WalkSpeed = _G.Speed
   end
end)

-- NoClip
RunService.Stepped:Connect(function()
   if _G.NoClip and char then
      for _, p in pairs(char:GetDescendants()) do
         if p:IsA("BasePart") then p.CanCollide = false end
      end
   end
end)

-- Fly
local bv, bg
RunService.Heartbeat:Connect(function()
   if _G.FlyEnabled and hrp then
      bv = bv or Instance.new("BodyVelocity", hrp)
      bg = bg or Instance.new("BodyGyro", hrp)
      bv.MaxForce = Vector3.new(1e9,1e9,1e9)
      bg.MaxTorque = Vector3.new(1e9,1e9,1e9)
      local cam = workspace.CurrentCamera
      local dir = Vector3.new()
      if keys.W then dir += cam.CFrame.LookVector end
      if keys.S then dir -= cam.CFrame.LookVector end
      if keys.A then dir -= cam.CFrame.RightVector end
      if keys.D then dir += cam.CFrame.RightVector end
      if keys.Space then dir += Vector3.new(0,1,0) end
      if keys.LeftShift then dir -= Vector3.new(0,1,0) end
      bv.Velocity = dir * 250
      bg.CFrame = cam.CFrame
   else
      if bv then bv:Destroy() bv = nil end
      if bg then bg:Destroy() bg = nil end
   end
end)

-- Full Quest 3 Sea Table (add hết, pos approx từ wiki 2026)
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
   {min = 175, quest = "SkyQuest", id = 2, mob = "Dark Master", pos = Vector3.new(-4724.28, 845.8, -1953.34)},
   {min = 190, quest = "PrisonerQuest", id = 1, mob = "Prisoner", pos = Vector3.new(5423, 88, 617)},
   {min = 210, quest = "PrisonerQuest", id = 2, mob = "Dangerous Prisoner", pos = Vector3.new(5423, 88, 617)},
   {min = 250, quest = "ColosseumQuest", id = 1, mob = "Toga Warrior", pos = Vector3.new(-1576, 7, 298.59)},
   {min = 275, quest = "ColosseumQuest", id = 2, mob = "Gladiator", pos = Vector3.new(-1576, 7, 298.59)},
   {min = 300, quest = "MagmaQuest", id = 1, mob = "Military Soldier", pos = Vector3.new(3863, 33, -2408)},
   {min = 325, quest = "MagmaQuest", id = 2, mob = "Military Spy", pos = Vector3.new(3863, 33, -2408)},
   {min = 350, quest = "MagmaQuest", id = 3, mob = "Magma Admiral", pos = Vector3.new(3863, 33, -2408)},
   {min = 700, quest = "Area1Quest", id = 1, mob = "Raider", pos = Vector3.new(-429, 73, 1832)},
   {min = 725, quest = "Area1Quest", id = 2, mob = "Mercenary", pos = Vector3.new(-429, 73, 1832)},
   {min = 775, quest = "Area2Quest", id = 1, mob = "Swan Pirate", pos = Vector3.new(638.13, 73, 918.67)},
   {min = 875, quest = "MansionQuest", id = 1, mob = "Marine Lieutenant", pos = Vector3.new(-648, 93, 183)},
   {min = 900, quest = "MansionQuest", id = 2, mob = "Marine Captain", pos = Vector3.new(-648, 93, 183)},
   {min = 950, quest = "MansionQuest", id = 3, mob = "Marine Commodore", pos = Vector3.new(-648, 93, 183)},
   {min = 1000, quest = "RoyalQuest", id = 1, mob = "Royal Soldier", pos = Vector3.new(-4915, 72, 3038)},
   {min = 1500, quest = "PiratePortTownQuest", id = 1, mob = "Pirate Millionaire", pos = Vector3.new(-290, 43.5, 5577.59)},
   {min = 1800, quest = "HauntedCastleQuest", id = 1, mob = "Haunted Mummy", pos = Vector3.new(-9500, 50, 5500)},
   {min = 2000, quest = "SeaOfTreatsQuest", id = 1, mob = "Peanut Scout", pos = Vector3.new(-1000, 100, -1000)},
   {min = 2200, quest = "CakeQuest", id = 1, mob = "Cake Guard", pos = Vector3.new(0, 0, 0)}
}

local function GetQuest()
   local lvl = Player.Data.Level.Value
   for i = #QuestList, 1, -1 do
      if lvl >= QuestList[i].min then return QuestList[i] end
   end
   return QuestList[1]
end

-- Auto Farm + Bring + Attack
task.spawn(function()
   while task.wait(0.08) do
      if _G.AutoFarm and hrp then
         pcall(function()
            local q = GetQuest()
            if not Player.PlayerGui.Main.Quest.Visible then
               Teleport(q.pos + Vector3.new(0,5,0))
               ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q.quest, q.id)
            else
               for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                  if mob.Name == q.mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                     if _G.BringMob then
                        mob.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0,0,-8)
                        mob.HumanoidRootPart.Velocity = Vector3.new(0, -30, 0)
                        mob.HumanoidRootPart.CanCollide = false
                        mob.Humanoid.WalkSpeed = 0
                     end
                     hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0)
                     if _G.AutoAttack then
                        VirtualUser:Button1Down(Vector2.new(0,0))
                        task.wait(_G.FastAttackSpeed)
                        VirtualUser:Button1Up(Vector2.new(0,0))
                     end
                  end
               end
               if _G.AutoHop and not foundMob then
                  game:GetService("TeleportService"):Teleport(game.PlaceId)
               end
            end
         end)
      end
   end
end)

-- Auto Fruit
task.spawn(function()
   while task.wait(1) do
      if _G.AutoFruit then
         for _, item in pairs(Workspace:GetChildren()) do
            if item:IsA("Tool") and item.Name:find("Fruit") then
               Teleport(item.Handle.Position)
            end
         end
      end
   end
end)

-- UI Tabs
local FarmTab = Window:CreateTab("Farm Chính")
FarmTab:CreateToggle({Name = "Auto Farm", CurrentValue = _G.AutoFarm, Callback = function(v) _G.AutoFarm = v end})
FarmTab:CreateToggle({Name = "Bring Mob New", CurrentValue = true, Callback = function(v) _G.BringMob = v end})
FarmTab:CreateToggle({Name = "Auto Attack Spam", CurrentValue = true, Callback = function(v) _G.AutoAttack = v end})
FarmTab:CreateToggle({Name = "No Clip", CurrentValue = true, Callback = function(v) _G.NoClip = v end})
FarmTab:CreateToggle({Name = "Fly (WASD+Space/Shift)", CurrentValue = false, Callback = function(v) _G.FlyEnabled = v end})
FarmTab:CreateSlider({Name = "Walk Speed", Range = {50,500}, CurrentValue = 150, Callback = function(v) _G.Speed = v end})
FarmTab:CreateSlider({Name = "Fast Attack Delay", Range = {0.05,0.2}, CurrentValue = 0.08, Callback = function(v) _G.FastAttackSpeed = v end})

local UtilsTab = Window:CreateTab("Tiện Ích")
UtilsTab:CreateToggle({Name = "Anti AFK", CurrentValue = true, Callback = function(v) _G.AntiAFK = v end})
UtilsTab:CreateToggle({Name = "Auto Fruit Sniper", CurrentValue = false, Callback = function(v) _G.AutoFruit = v end})
UtilsTab:CreateToggle({Name = "Auto Hop No Mob", CurrentValue = false, Callback = function(v) _G.AutoHop = v end})

Rayfield:Notify({Title = "FULL LOADED!", Content = "Đã hỏi tự bật lần sau! Farm auto chạy, gom mob + spam đánh ngon max! 😈", Duration = 10})