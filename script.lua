-- [[ SENKY HUB V-FINAL++++ 2026 - FULL CODE + WATER & JUMP BYPASS 😈 ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Senky Hub V-FINAL++++ 2026 😈",
   LoadingTitle = "Loading full 3 Sea + Anti-Water + Jump...",
   LoadingSubtitle = "by Senky Chiến Thần - Jan 2026",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SenkyConfig",
      FileName = "SenkyHubFinal"
   },
   DisableRayfieldPrompts = true,
   KeySystem = false
})

-- [[ SERVICES ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

-- [[ VARIABLES ]] --
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
-- New Vars
_G.InfiniteJump = true
_G.WalkOnWater = true

-- [[ CHARACTER LOAD ]] --
local char, hrp
local function LoadChar()
   char = Player.Character or Player.CharacterAdded:Wait()
   hrp = char:WaitForChild("HumanoidRootPart")
end
LoadChar()
Player.CharacterAdded:Connect(LoadChar)

-- [[ NEW: INFINITE JUMP (NHẢY TRÊN KHÔNG) ]] --
UserInputService.JumpRequest:Connect(function()
   if _G.InfiniteJump then
      char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

-- [[ NEW: WALK ON WATER & ANTI WATER DAMAGE (KHÁNG NƯỚC) ]] --
-- Cách này giúp đứng trên nước và không mất máu khi dùng trái ác quỷ
task.spawn(function()
   while task.wait(0.1) do
      pcall(function()
         if _G.WalkOnWater then
            -- Chặn chìm và chặn sát thương từ nước
            for _, v in pairs(Workspace:GetDescendants()) do
               if v.Name == "WaterBase" or v.Name == "Water" or v.Name == "Sea" then
                  v.CanCollide = true -- Đứng lên mặt nước
                  v.CanTouch = false  -- Không chạm (không kích hoạt script mất máu của game)
               end
            end
            -- Fix riêng cho Map 2026
            if Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("WaterBase") then
               Workspace.Map.WaterBase.CanCollide = true
               Workspace.Map.WaterBase.CanTouch = false
            end
         end
      end)
   end
end)

-- [[ FLY KEYS (WASD) ]] --
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

-- [[ TELEPORT ]] --
local function TP(pos)
   pcall(function()
      local tween = TweenService:Create(hrp, TweenInfo.new(0.6), {CFrame = CFrame.new(pos)})
      tween:Play()
      tween.Completed:Wait()
   end)
end

-- [[ ANTI-AFK ]] --
task.spawn(function()
   while _G.AntiAFK do
      VirtualUser:Button1Down(Vector2.new())
      task.wait(60)
   end
end)

-- [[ SPEED HACK ]] --
RunService.RenderStepped:Connect(function()
   if char and char:FindFirstChild("Humanoid") then
      char.Humanoid.WalkSpeed = _G.Speed
   end
end)

-- [[ NO CLIP ]] --
RunService.Stepped:Connect(function()
   if _G.NoClip and char then
      for _, p in pairs(char:GetDescendants()) do
         if p:IsA("BasePart") then p.CanCollide = false end
      end
   end
end)

-- [[ FLY SYSTEM ]] --
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

-- [[ FULL QUEST TABLE 3 SEA ]] --
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
   {min = 700, quest = "Area1Quest", id = 1, mob = "Raider", pos = Vector3.new(-429, 73, 1832)},
   {min = 1500, quest = "PiratePortTownQuest", id = 1, mob = "Pirate Millionaire", pos = Vector3.new(-290, 43.5, 5577.59)},
   {min = 2200, quest = "CakeQuest", id = 1, mob = "Cake Guard", pos = Vector3.new(0, 0, 0)}
}

local function GetQuest()
   local lvl = Player.Data.Level.Value
   for i = #QuestList, 1, -1 do
      if lvl >= QuestList[i].min then return QuestList[i] end
   end
   return QuestList[1]
end

-- [[ AUTO FARM LOGIC ]] --
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
            end
         end)
      end
   end
end)

-- [[ GIAO DIỆN TABS ]] --
local FarmTab = Window:CreateTab("Farm Chính")
FarmTab:CreateToggle({Name = "Auto Farm", CurrentValue = _G.AutoFarm, Callback = function(v) _G.AutoFarm = v end})
FarmTab:CreateToggle({Name = "Gom Quái (Bring Mob)", CurrentValue = true, Callback = function(v) _G.BringMob = v end})

local MoveTab = Window:CreateTab("Di Chuyển VIP")
MoveTab:CreateToggle({Name = "Nhảy Vô Hạn (Space)", CurrentValue = true, Callback = function(v) _G.InfiniteJump = v end})
MoveTab:CreateToggle({Name = "Đi Trên Nước & Kháng Damage", CurrentValue = true, Callback = function(v) _G.WalkOnWater = v end})
MoveTab:CreateToggle({Name = "Fly (WASD)", CurrentValue = false, Callback = function(v) _G.FlyEnabled = v end})
MoveTab:CreateSlider({Name = "Speed", Range = {50,500}, CurrentValue = 150, Callback = function(v) _G.Speed = v end})

local UtilsTab = Window:CreateTab("Tiện Ích")
UtilsTab:CreateToggle({Name = "No Clip", CurrentValue = true, Callback = function(v) _G.NoClip = v end})
UtilsTab:CreateToggle({Name = "Auto Fruit Sniper", CurrentValue = false, Callback = function(v) _G.AutoFruit = v end})

Rayfield:Notify({Title = "CHẾ ĐỘ CHIẾN THẦN!", Content = "Đã bật Kháng Nước + Nhảy Vô Hạn! Quẩy thôi 😈", Duration = 10})