repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("Data")

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

local Player = Players.LocalPlayer
local Data = Player:WaitForChild("Data")
local char = Player.Character or Player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

_G = _G or {}
_G.AutoFarm = false
_G.BringMob = true
_G.FastAttack = true
_G.AntiAttack = true
_G.NoCooldown = true
_G.FlyEnabled = false
_G.Speed = 160
_G.AutoChest = false
_G.InfiniteJump = true
_G.WalkOnWater = true
_G.NoClip = true

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local Title = Instance.new("TextLabel")
local BtnFarm = Instance.new("TextButton")
local BtnFly = Instance.new("TextButton")
local BtnChest = Instance.new("TextButton")
local BtnFruit = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "SenkyMobile"

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 150, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true

UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "SENKY HUB 😈"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.BackgroundTransparency = 1
Title.TextSize = 18

local function CreateBtn(btn, txt, callback)
    btn.Parent = MainFrame
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Text = txt
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(callback)
end

CreateBtn(BtnFarm, "Auto Farm: OFF", function()
    _G.AutoFarm = not _G.AutoFarm
    BtnFarm.Text = "Auto Farm: " .. (_G.AutoFarm and "ON" or "OFF")
end)

CreateBtn(BtnFly, "Fly: OFF", function()
    _G.FlyEnabled = not _G.FlyEnabled
    BtnFly.Text = "Fly: " .. (_G.FlyEnabled and "ON" or "OFF")
end)

CreateBtn(BtnChest, "Auto Chest: OFF", function()
    _G.AutoChest = not _G.AutoChest
    BtnChest.Text = "Auto Chest: " .. (_G.AutoChest and "ON" or "OFF")
end)

CreateBtn(BtnFruit, "Săn Trái & Hop", function()
    FruitServerHop()
end)

Player.CharacterAdded:Connect(function(n)
    char = n
    hrp = n:WaitForChild("HumanoidRootPart")
end)

local function TP(pos)
    pcall(function()
        if not hrp then return end
        local dist = (hrp.Position - pos).Magnitude
        local tween = TweenService:Create(hrp, TweenInfo.new(dist/350, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
        tween:Play()
        tween.Completed:Wait()
    end)
end

function FruitServerHop()
    for _, v in pairs(Workspace:GetChildren()) do
        if v:IsA("Tool") and (v.Name:find("Fruit") or v:FindFirstChild("Handle")) then
            hrp.CFrame = v.Handle.CFrame
            task.wait(1)
            ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", v.Name, v)
        end
    end
    local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local Body = HttpService:JSONDecode(game:HttpGet(Api))
    for _, v in pairs(Body.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id)
            break
        end
    end
end

task.spawn(function()
    while task.wait(0.01) do
        if _G.AutoFarm or _G.FastAttack then
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Attack", "1")
                VirtualUser:CaptureController()
                VirtualUser:Button1Down(Vector2.new(0,0))
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarm and _G.BringMob then
            pcall(function()
                for _, v in pairs(Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        if (v.HumanoidRootPart.Position - hrp.Position).Magnitude <= 350 then
                            v.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -6)
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        if _G.AutoChest and hrp then
            pcall(function()
                for _, v in pairs(Workspace:GetChildren()) do
                    if v.Name:find("Chest") and v:IsA("Part") then
                        hrp.CFrame = v.CFrame
                        task.wait(0.1)
                    end
                end
            end)
        end
    end
end)

RunService.Stepped:Connect(function()
    if _G.AntiAttack and char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanTouch = false end
        end
    end
    if _G.NoCooldown and char then
        for _, v in pairs(char:GetDescendants()) do
            if v.Name == "Cooldown" or v.Name == "Debounce" then
                if v:IsA("NumberValue") then v.Value = 0 end
            end
        end
    end
    if _G.NoClip and char then
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

local QuestList = {
    {min = 0, quest = "BanditQuest1", id = 1, mob = "Bandit", pos = Vector3.new(1059.37, 16.51, 1548.82)},
    {min = 10, quest = "JungleQuest", id = 1, mob = "Monkey", pos = Vector3.new(-1602.21, 36.85, 131.78)},
    {min = 15, quest = "JungleQuest", id = 2, mob = "Gorilla", pos = Vector3.new(-1602.21, 36.85, 131.78)},
    {min = 30, quest = "BuggyQuest1", id = 1, mob = "Pirate", pos = Vector3.new(-1139.59, 4.75, 3825.16)},
    {min = 40, quest = "BuggyQuest1", id = 2, mob = "Brute", pos = Vector3.new(-1139.59, 4.75, 3825.16)},
    {min = 60, quest = "DesertQuest", id = 1, mob = "Desert Bandit", pos = Vector3.new(932.78, 6.45, 4489.82)},
    {min = 75, quest = "DesertQuest", id = 2, mob = "Desert Officer", pos = Vector3.new(932.78, 6.45, 4489.82)},
    {min = 90, quest = "SnowQuest", id = 1, mob = "Snow Bandit", pos = Vector3.new(1374.47, 87.27, -1321.29)},
    {min = 120, quest = "MarineQuest2", id = 1, mob = "Chief Petty Officer", pos = Vector3.new(-4882.86, 22.65, -5102.85)},
    {min = 150, quest = "SkyQuest", id = 1, mob = "Sky Bandit", pos = Vector3.new(-4724.27, 845.79, -1953.33)},
    {min = 190, quest = "PrisonQuest", id = 1, mob = "Prisoner", pos = Vector3.new(4844.75, 5.65, 743.45)},
    {min = 250, quest = "ColosseumQuest", id = 1, mob = "Toga Warrior", pos = Vector3.new(-1576.12, 7.39, 298.59)},
    {min = 300, quest = "MagmaQuest", id = 1, mob = "Military Soldier", pos = Vector3.new(-5242.76, 8.5, 8466.1)},
    {min = 700, quest = "Area1Quest", id = 1, mob = "Raider", pos = Vector3.new(-429.1, 73.1, 1832.5)},
    {min = 725, quest = "Area1Quest", id = 2, mob = "Mercenary", pos = Vector3.new(-429.1, 73.1, 1832.5)},
    {min = 800, quest = "Area2Quest", id = 1, mob = "Swan Pirate", pos = Vector3.new(638.13, 73, 918.67)},
    {min = 875, quest = "MansionQuest", id = 1, mob = "Marine Lieutenant", pos = Vector3.new(-648.1, 93.2, 183.1)},
    {min = 925, quest = "MansionQuest", id = 2, mob = "Marine Captain", pos = Vector3.new(-648.1, 93.2, 183.1)},
    {min = 1000, quest = "ShipQuest1", id = 1, mob = "Ship Pirate", pos = Vector3.new(-9506.5, 15.1, -1500.2)},
    {min = 1100, quest = "IceQuest1", id = 1, mob = "Arctic Warrior", pos = Vector3.new(-6060.1, 15.2, -5000.3)},
    {min = 1250, quest = "ForgottenQuest", id = 1, mob = "Forgotten Pirate", pos = Vector3.new(-3000.5, 15.3, -3000.4)},
    {min = 1350, quest = "SnowMountainQuest", id = 1, mob = "Winter Warrior", pos = Vector3.new(1150.1, 120.2, -5200.3)},
    {min = 1425, quest = "SnowMountainQuest", id = 2, mob = "Glacial Warrior", pos = Vector3.new(1150.1, 120.2, -5200.3)},
    {min = 1500, quest = "PiratePortTownQuest", id = 1, mob = "Pirate Millionaire", pos = Vector3.new(-290.1, 43.5, 5577.6)},
    {min = 1600, quest = "PiratePortTownQuest", id = 2, mob = "Pistol Billionaire", pos = Vector3.new(-290.1, 43.5, 5577.6)},
    {min = 1700, quest = "HydraQuest1", id = 1, mob = "Dragon Crew Warrior", pos = Vector3.new(5700.5, 15.4, -100.2)},
    {min = 1800, quest = "HauntedCastleQuest", id = 1, mob = "Haunted Mummy", pos = Vector3.new(-9500.1, 50.2, 5500.3)},
    {min = 1900, quest = "HauntedCastleQuest", id = 2, mob = "Living Zombie", pos = Vector3.new(-9500.1, 50.2, 5500.3)},
    {min = 2000, quest = "SeaOfTreatsQuest", id = 1, mob = "Peanut Scout", pos = Vector3.new(-1000.2, 100.3, -1000.4)},
    {min = 2100, quest = "SeaOfTreatsQuest", id = 2, mob = "Peanut Warrior", pos = Vector3.new(-1000.2, 100.3, -1000.4)},
    {min = 2200, quest = "CakeQuest", id = 1, mob = "Cake Guard", pos = Vector3.new(-1150.3, 70.4, -2500.5)},
    {min = 2300, quest = "CakeQuest", id = 2, mob = "Baking Staff", pos = Vector3.new(-1150.3, 70.4, -2500.5)},
    {min = 2400, quest = "ChocolateQuest1", id = 1, mob = "Cocoa Warrior", pos = Vector3.new(200.1, 50.2, 400.3)},
    {min = 2500, quest = "CandyQuest1", id = 1, mob = "Candy Pirate", pos = Vector3.new(800.2, 50.3, 1200.4)},
    {min = 2600, quest = "TikiQuest1", id = 1, mob = "Sunken Pirate", pos = Vector3.new(-15000, 50, -15000)},
    {min = 2700, quest = "FinalQuest1", id = 1, mob = "Senky Guard", pos = Vector3.new(-16000, 100, -16000)}
}

local function GetQuest()
    local lvl = Data.Level.Value
    for i = #QuestList, 1, -1 do
        if lvl >= QuestList[i].min then return QuestList[i] end
    end
    return QuestList[1]
end

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoFarm and hrp then
            pcall(function()
                local q = GetQuest()
                if not Player.PlayerGui.Main.Quest.Visible then
                    TP(q.pos)
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q.quest, q.id)
                else
                    for _, m in pairs(Workspace.Enemies:GetChildren()) do
                        if m.Name == q.mob and m:FindFirstChild("Humanoid") and m.Humanoid.Health > 0 then
                            hrp.CFrame = m.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                        end
                    end
                end
            end)
        end
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

UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
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