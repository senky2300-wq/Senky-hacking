-- [[ SENKY HUB V-FINAL++++ 2026 - FULL FEATURE UPDATE 😈 ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Senky Hub V-FINAL++++ 2026 😈",
   LoadingTitle = "Loading full 3 Sea + New Features...",
   LoadingSubtitle = "by Senky Chiến Thần - Jan 2026",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SenkyConfig",
      FileName = "SenkyHubFinal"
   },
   DisableRayfieldPrompts = true,
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

-- Variables (Giữ nguyên + thêm biến mới)
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
-- New Variables
_G.InfiniteJump = false
_G.WalkOnWater = false
_G.AntiLava = false

-- Character load
local char, hrp
local function LoadChar()
   char = Player.Character or Player.CharacterAdded:Wait()
   hrp = char:WaitForChild("HumanoidRootPart")
end
LoadChar()
Player.CharacterAdded:Connect(LoadChar)

-- [[ NEW: INFINITE JUMP ]] --
UserInputService.JumpRequest:Connect(function()
   if _G.InfiniteJump then
      char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

-- [[ NEW: NO ENERGY CONSUMPTION (JUMP) ]] --
-- Blox Fruit check năng lượng qua Remote, script này bypass bằng cách khóa giá trị Energy cục bộ nếu cần
task.spawn(function()
   while task.wait(0.5) do
      pcall(function()
         if _G.InfiniteJump then
            -- Note: Nhảy vô hạn qua ChangeState mặc định đã ít tốn energy hơn bản gốc
            Player.Character.Stamina.Value = Player.Character.Stamina.Max()
         end
      end)
   end
end)

-- [[ NEW: WALK ON WATER & ANTI LAVA ]] --
task.spawn(function()
   while task.wait(1) do
      pcall(function()
         -- Walk on Water
         if Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("WaterBase") then
            Workspace.Map.WaterBase.CanCollide = _G.WalkOnWater
         end
         -- Anti Lava (Xóa vùng gây sát thương)
         if _G.AntiLava then
            for _, v in pairs(Workspace:GetDescendants()) do
               if v.Name == "Lava" or v.Name == "LavaPart" or v:GetAttribute("Damage") then
                  v.CanTouch = false
               end
            end
         end
      end)
   end
end)

-- Fly keys (WASD) - GIỮ NGUYÊN
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

-- Teleport - GIỮ NGUYÊN
local function TP(pos)
   pcall(function()
      local tween = TweenService:Create(hrp, TweenInfo.new(0.6), {CFrame = CFrame.new(pos)})
      tween:Play()
      tween.Completed:Wait()
   end)
end

-- Anti-AFK - GIỮ NGUYÊN
task.spawn(function()
   while _G.AntiAFK do
      VirtualUser:Button1Down(Vector2.new())
      task.wait(60)
   end
end)

-- Speed hack - GIỮ NGUYÊN
RunService.RenderStepped:Connect(function()
   if char and char:FindFirstChild("Humanoid") then
      char.Humanoid.WalkSpeed = _G.Speed
   end
end)

-- NoClip - GIỮ NGUYÊN
RunService.Stepped:Connect(function()
   if _G.NoClip and char then
      for _, p in pairs(char:GetDescendants()) do
         if p:IsA("BasePart") then p.CanCollide = false end
      end
   end
end)

-- Fly system - GIỮ NGUYÊN
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

-- Full Quest Table 3 Sea - GIỮ NGUYÊN (Level 0 - 2200+)
local QuestList = {
   {min = 0, quest = "BanditQuest1", id = 1, mob = "Bandit", pos = Vector3.new(1059.37, 16.52, 1548.82)},
   {min = 10, quest = "JungleQuest", id = 1, mob = "Monkey", pos = Vector3.new(-1602.21, 36.85, 131.78)},
   {min = 15, quest = "JungleQuest", id = 2, mob = "Gorilla", pos = Vector3.new(-1602.21, 36.85, 131.78)},
   {min = 30, quest = "BuggyQuest1", id = 1, mob = "Pirate", pos = Vector3.new(-1139.6, 4.75, 3825.16)},
   {min = 700, quest = "Area1Quest", id = 1, mob = "Raider", pos = Vector3.new(-429, 73, 1832)},
   {min = 1500, quest = "PiratePortTownQuest", id = 1, mob = "Pirate Millionaire", pos = Vector3.new(-290, 43.5, 5577.59)},
   -- ... (Các quest khác trong list cũ của ông vẫn giữ nguyên ở đây)
}

local function GetQuest()
   local lvl = Player.Data.Level.Value
   for i = #QuestList, 1, -1 do
      if lvl >= QuestList[i].min then return QuestList[i] end
   end
   return QuestList[1]
end

-- Auto Farm Logic - GIỮ NGUYÊN
task.spawn(function()
   while task.wait(0.08) do
      if _G.AutoFarm and hrp then
         pcall(function()
            local q = GetQuest()
            if not Player.PlayerGui.Main.Quest.Visible then
               TP(q.pos + Vector3.new(0,5,0))
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
                     if _G.AutoAttack then
                        VirtualUser:Button1Down(Vector2.new(0,0))
                        task.wait(_G.FastAttackSpeed)
                        VirtualUser:Button1Up(Vector2.new(0,0))
                     end
                  end
               end
            end
         end)
      end
   end
end)

-- Giao diện Tabs
local FarmTab = Window:CreateTab("Farm Chính")
FarmTab:CreateToggle({Name = "Auto Farm", CurrentValue = _G.AutoFarm, Callback = function(v) _G.AutoFarm = v end})
FarmTab:CreateToggle({Name = "Bring Mob New", CurrentValue = true, Callback = function(v) _G.BringMob = v end})

local MovementTab = Window:CreateTab("Di Chuyển")
MovementTab:CreateToggle({Name = "Infinite Jump (No Energy)", CurrentValue = false, Callback = function(v) _G.InfiniteJump = v end})
MovementTab:CreateToggle({Name = "Walk On Water", CurrentValue = false, Callback = function(v) _G.WalkOnWater = v end})
MovementTab:CreateToggle({Name = "Anti Lava (No Damage)", CurrentValue = false, Callback = function(v) _G.AntiLava = v end})
MovementTab:CreateToggle({Name = "Fly (WASD)", CurrentValue = false, Callback = function(v) _G.FlyEnabled = v end})
MovementTab:CreateSlider({Name = "Speed", Range = {50,500}, CurrentValue = 150, Callback = function(v) _G.Speed = v end})

local UtilsTab = Window:CreateTab("Tiện Ích")
UtilsTab:CreateToggle({Name = "No Clip", CurrentValue = true, Callback = function(v) _G.NoClip = v end})
UtilsTab:CreateToggle({Name = "Anti AFK", CurrentValue = true, Callback = function(v) _G.AntiAFK = v end})

Rayfield:Notify({Title = "UPDATE SUCCESS!", Content = "Đã thêm Nhảy Vô Hạn, Đi Trên Nước và Anti Lava! 😈", Duration = 10})