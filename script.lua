repeat task.wait() until game:IsLoaded()
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

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Senky Hub V-FINAL ULTRA 😈",
   LoadingTitle = "Đang triệu hồi nội công chiến thần...",
   LoadingSubtitle = "by Senky Mobile - 2026",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false
})

_G.AutoFarm = false
_G.BringMob = true
_G.FastAttack = true
_G.Speed = 165
_G.FlyEnabled = false
_G.NoClip = true
_G.InfiniteJump = true
_G.WalkOnWater = true
_G.AutoFruit = false
_G.AutoStore = true
_G.AutoStats = false
_G.StatsType = "Melee"

local char = Player.Character or Player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
Player.CharacterAdded:Connect(function(n)
    char = n
    hrp = n:WaitForChild("HumanoidRootPart")
end)

local function TP(pos)
    pcall(function()
        local dist = (hrp.Position - pos).Magnitude
        local tween = TweenService:Create(hrp, TweenInfo.new(dist/350, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
        tween:Play()
        tween.Completed:Wait()
    end)
end

RunService.RenderStepped:Connect(function()
    if _G.FastAttack and (_G.AutoFarm or _G.AutoChest) then
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Attack", "1")
            VirtualUser:CaptureController()
            VirtualUser:Button1Down(Vector2.new(0,0))
            VirtualUser:Button1Up(Vector2.new(0,0))
        end)
    end
    if _G.NoClip and char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

local QuestList = {
    {min = 0, quest = "BanditQuest1", id = 1, mob = "Bandit", pos = Vector3.new(1059, 16, 1548)},
    {min = 10, quest = "JungleQuest", id = 1, mob = "Monkey", pos = Vector3.new(-1602, 36, 131)},
    {min = 15, quest = "JungleQuest", id = 2, mob = "Gorilla", pos = Vector3.new(-1602, 36, 131)},
    {min = 30, quest = "BuggyQuest1", id = 1, mob = "Pirate", pos = Vector3.new(-1139, 4, 3825)},
    {min = 40, quest = "BuggyQuest1", id = 2, mob = "Brute", pos = Vector3.new(-1139, 4, 3825)},
    {min = 60, quest = "DesertQuest", id = 1, mob = "Desert Bandit", pos = Vector3.new(932, 6, 4489)},
    {min = 75, quest = "DesertQuest", id = 2, mob = "Desert Officer", pos = Vector3.new(932, 6, 4489)},
    {min = 90, quest = "SnowQuest", id = 1, mob = "Snow Bandit", pos = Vector3.new(1374, 87, -1321)},
    {min = 100, quest = "SnowQuest", id = 2, mob = "Snowman", pos = Vector3.new(1374, 87, -1321)},
    {min = 120, quest = "MarineQuest2", id = 1, mob = "Chief Petty Officer", pos = Vector3.new(-4882, 22, -5102)},
    {min = 150, quest = "SkyQuest", id = 1, mob = "Sky Bandit", pos = Vector3.new(-4724, 845, -1953)},
    {min = 175, quest = "SkyQuest", id = 2, mob = "Dark Master", pos = Vector3.new(-4724, 845, -1953)},
    {min = 190, quest = "PrisonQuest", id = 1, mob = "Prisoner", pos = Vector3.new(4844, 5, 743)},
    {min = 210, quest = "PrisonQuest", id = 2, mob = "Dangerous Prisoner", pos = Vector3.new(4844, 5, 743)},
    {min = 250, quest = "ColosseumQuest", id = 1, mob = "Toga Warrior", pos = Vector3.new(-1576, 7, 298)},
    {min = 275, quest = "ColosseumQuest", id = 2, mob = "Gladiator", pos = Vector3.new(-1576, 7, 298)},
    {min = 300, quest = "MagmaQuest", id = 1, mob = "Military Soldier", pos = Vector3.new(-5242, 8, 8466)},
    {min = 325, quest = "MagmaQuest", id = 2, mob = "Military Spy", pos = Vector3.new(-5242, 8, 8466)},
    {min = 700, quest = "Area1Quest", id = 1, mob = "Raider", pos = Vector3.new(-429, 73, 1832)},
    {min = 725, quest = "Area1Quest", id = 2, mob = "Mercenary", pos = Vector3.new(-429, 73, 1832)},
    {min = 775, quest = "Area2Quest", id = 1, mob = "Swan Pirate", pos = Vector3.new(638, 73, 918)},
    {min = 875, quest = "MansionQuest", id = 1, mob = "Marine Lieutenant", pos = Vector3.new(-648, 93, 183)},
    {min = 925, quest = "MansionQuest", id = 2, mob = "Marine Captain", pos = Vector3.new(-648, 93, 183)},
    {min = 1000, quest = "ShipQuest1", id = 1, mob = "Ship Pirate", pos = Vector3.new(-9506, 15, -1500)},
    {min = 1050, quest = "ShipQuest1", id = 2, mob = "Ship Engineer", pos = Vector3.new(-9506, 15, -1500)},
    {min = 1100, quest = "IceQuest1", id = 1, mob = "Arctic Warrior", pos = Vector3.new(-6060, 15, -5000)},
    {min = 1150, quest = "IceQuest1", id = 2, mob = "Snow Warrior", pos = Vector3.new(-6060, 15, -5000)},
    {min = 1250, quest = "ForgottenQuest", id = 1, mob = "Forgotten Pirate", pos = Vector3.new(-3000, 15, -3000)},
    {min = 1350, quest = "SnowMountainQuest", id = 1, mob = "Winter Warrior", pos = Vector3.new(1150, 120, -5200)},
    {min = 1500, quest = "PiratePortTownQuest", id = 1, mob = "Pirate Millionaire", pos = Vector3.new(-290, 43, 5577)},
    {min = 1575, quest = "PiratePortTownQuest", id = 2, mob = "Pistol Billionaire", pos = Vector3.new(-290, 43, 5577)},
    {min = 1700, quest = "HydraQuest1", id = 1, mob = "Dragon Crew Warrior", pos = Vector3.new(5700, 15, -100)},
    {min = 1800, quest = "HauntedCastleQuest", id = 1, mob = "Haunted Mummy", pos = Vector3.new(-9500, 50, 5500)},
    {min = 1900, quest = "HauntedCastleQuest", id = 2, mob = "Living Zombie", pos = Vector3.new(-9500, 50, 5500)},
    {min = 2000, quest = "SeaOfTreatsQuest", id = 1, mob = "Peanut Scout", pos = Vector3.new(-1000, 100, -1000)},
    {min = 2100, quest = "SeaOfTreatsQuest", id = 2, mob = "Peanut Warrior", pos = Vector3.new(-1000, 100, -1000)},
    {min = 2200, quest = "CakeQuest", id = 1, mob = "Cake Guard", pos = Vector3.new(-1150, 70, -2500)},
    {min = 2300, quest = "CakeQuest", id = 2, mob = "Baking Staff", pos = Vector3.new(-1150, 70, -2500)},
    {min = 2400, quest = "ChocolateQuest1", id = 1, mob = "Cocoa Warrior", pos = Vector3.new(200, 50, 400)},
    {min = 2500, quest = "CandyQuest1", id = 1, mob = "Candy Pirate", pos = Vector3.new(800, 50, 1200)}
}

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoFarm and hrp then
            pcall(function()
                local q
                local lvl = Data.Level.Value
                for i = #QuestList, 1, -1 do if lvl >= QuestList[i].min then q = QuestList[i] break end end
                if not Player.PlayerGui.Main.Quest.Visible then
                    TP(q.pos)
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q.quest, q.id)
                else
                    local enemyFound = false
                    for _, v in pairs(Workspace.Enemies:GetChildren()) do
                        if v.Name == q.mob and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            enemyFound = true
                            if _G.BringMob then
                                v.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -8)
                                v.HumanoidRootPart.CanCollide = false
                            end
                            hrp.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                        end
                    end
                end
            end)
        end
    end
end)

local MainTab = Window:CreateTab("Auto Farm")
MainTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Callback = function(Value) _G.AutoFarm = Value end
})
MainTab:CreateToggle({
   Name = "Gom Quái (Bring Mob)",
   CurrentValue = true,
   Callback = function(Value) _G.BringMob = Value end
})

local FruitTab = Window:CreateTab("Trái Ác Quỷ")
FruitTab:CreateButton({
   Name = "Nhặt Trái & Hop Server",
   Callback = function()
        for _, v in pairs(Workspace:GetChildren()) do
            if v:IsA("Tool") and (v.Name:find("Fruit") or v:FindFirstChild("Handle")) then
                hrp.CFrame = v.Handle.CFrame
                task.wait(1)
                ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", v.Name, v)
            end
        end
        local s = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for _, v in pairs(s.data) do
            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id)
                break
            end
        end
   end
})

local MoveTab = Window:CreateTab("Tiện Ích")
MoveTab:CreateSlider({
   Name = "Tốc Độ Chạy",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 165,
   Callback = function(Value) _G.Speed = Value end
})
MoveTab:CreateToggle({
   Name = "Nhảy Vô Hạn",
   CurrentValue = true,
   Callback = function(Value) _G.InfiniteJump = Value end
})
MoveTab:CreateToggle({
   Name = "Đứng Trên Nước",
   CurrentValue = true,
   Callback = function(Value) _G.WalkOnWater = Value end
})

task.spawn(function()
    while task.wait() do
        pcall(function()
            if char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = _G.Speed end
        end)
    end
end)

UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump and char:FindFirstChild("Humanoid") then
        char.Humanoid:ChangeState("Jumping")
    end
end)

task.spawn(function()
   while task.wait(0.5) do
      if _G.WalkOnWater then
         pcall(function()
            for _, v in pairs(Workspace:GetDescendants()) do
               if v.Name == "Water" or v.Name == "Sea" or v.Name == "Ocean" then v.CanCollide = true end
            end
         end)
      end
   end
end)

task.spawn(function()
    while true do
        pcall(function()
            VirtualUser:Button1Down(Vector2.new())
            task.wait(1)
            VirtualUser:Button1Up(Vector2.new())
        end)
        task.wait(60)
    end
end)

Rayfield:Notify({Title = "XONG!", Content = "Bản ULTRA Mobile đã sẵn sàng 😈", Duration = 5})