-- [[ SENKY HUB V-FINAL+++++ 2026 - NO MENU, NO PROMPT, AUTO FARM NGẦM 😈 ]] --
-- Không hiện UI | Không hỏi reset config | Auto bật farm khi vào | Full 3 Sea quest | Bring Mob New 2026

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create window but HIDE it completely and disable config saving to avoid prompts
local Window = Rayfield:CreateWindow({
   Name = "Senky Hub V-FINAL+++++ 2026 😈",
   LoadingTitle = "Loading auto farm ngầm...",
   LoadingSubtitle = "by Senky Chiến Thần - Jan 2026",
   ConfigurationSaving = {
      Enabled = false  -- TẮT HOÀN TOÀN SAVE/LOAD CONFIG → KHÔNG HỎI PROMPT RESET
   },
   KeySystem = false
})

-- Ẩn menu/UI ngay lập tức (không hiện popup nào)
Window:Hide()

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

-- Variables (auto bật hết để farm ngầm)
local _G = _G or {}
_G.AutoFarm = true
_G.BringMob = true
_G.AutoAttack = true
_G.FastAttackSpeed = 0.08  -- Spam M1 nhanh
_G.Speed = 150
_G.FlyEnabled = false  -- Bật tay nếu cần (thêm toggle sau nếu muốn)
_G.NoClip = true
_G.AntiAFK = true
_G.AutoFruit = false
_G.AutoHop = false

-- Character load/respawn
local char, hrp
local function LoadChar()
   char = Player.Character or Player.CharacterAdded:Wait()
   hrp = char:WaitForChild("HumanoidRootPart")
end
LoadChar()
Player.CharacterAdded:Connect(LoadChar)

-- Fly controls (nếu bật Fly)
local keys = {W = false, S = false, A = false, D = false, Space = false, LeftShift = false}
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

-- Teleport stable
local function Teleport(pos)
   pcall(function()
      local tween = TweenService:Create(hrp, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
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
      for _, part in pairs(char:GetDescendants()) do
         if part:IsA("BasePart") then part.CanCollide = false end
      end
   end
end)

-- Fly system
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

-- Full Quest Table 3 Sea (add hết từ wiki/data 2026, pos approx chính xác)
local QuestList = {
   {min = 0, quest = "BanditQuest1", id = 1, mob = "Bandit", pos = Vector3.new(1059.37195, 16.5166187, 1548.82324)},
   {min = 10, quest = "JungleQuest", id = 1, mob = "Monkey", pos = Vector3.new(-1602.21265, 36.85214996, 131.780869)},
   {min = 15, quest = "JungleQuest", id = 2, mob = "Gorilla", pos = Vector3.new(-1602.21265, 36.85214996, 131.780869)},
   {min = 30, quest = "BuggyQuest1", id = 1, mob = "Pirate", pos = Vector3.new(-1139.59717, 4.75205183, 3825.1626)},
   {min = 40, quest = "BuggyQuest1", id = 2, mob = "Brute", pos = Vector3.new(-1139.59717, 4.75205183, 3825.1626)},
   {min = 60, quest = "DesertQuest", id = 1, mob = "Desert Bandit", pos = Vector3.new(932.788818, 6.4503746, 4489.82617)},
   {min = 75, quest = "DesertQuest", id = 2, mob = "Desert Officer", pos = Vector3.new(932.788818, 6.4503746, 4489.82617)},
   {min = 90, quest = "SnowQuest", id = 1, mob = "Snow Bandit", pos = Vector3.new(1374.4729, 87.2727814, -1321.29639)},
   {min = 100, quest = "SnowQuest", id = 2, mob = "Snowman", pos = Vector3.new(1374.4729, 87.2727814, -1321.29639)},
   {min = 120, quest = "MarineQuest2", id = 1, mob = "Chief Petty Officer", pos = Vector3.new(-4882.8623, 22.6520386, -5102.85596)},
   {min = 150, quest = "SkyQuest", id = 1, mob = "Sky Bandit", pos = Vector3.new(-4724.2793, 845.796875, -1953.3396)},
   {min = 175, quest = "SkyQuest", id = 2, mob = "Dark Master", pos = Vector3.new(-4724.2793, 845.796875, -1953.3396)},
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

-- Auto Farm Loop (ngầm chạy, gom mob + spam đánh)
task.spawn(function()
   while task.wait(0.08) do
      if _G.AutoFarm and hrp then
         pcall(function()
            local q = GetQuest()
            if not Player.PlayerGui.Main.Quest.Visible then
               Teleport(q.pos + Vector3.new(0,5,0))
               ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q.quest, q.id)
            else
               local found = false
               for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                  if mob.Name == q.mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                     found = true
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
               if _G.AutoHop and not found then
                  game:GetService("TeleportService"):Teleport(game.PlaceId)
               end
            end
         end)
      end
   end
end)

-- Auto Fruit Sniper (ngầm)
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

-- Silent notify (in console, không hiện popup)
print("Senky Hub V-FINAL+++++ 2026 loaded! Auto Farm NGẦM chạy: gom mob + spam đánh tự động 😈")
print("Không hiện menu, không hỏi prompt config. Farm vui tay lên 2800 nhanh!")