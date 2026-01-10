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

_G.AutoFarm = false
_G.FastAttack = true
_G.AntiAttack = true
_G.NoCooldown = true
_G.AutoChest = false
_G.BringMob = true

local sg = Instance.new("ScreenGui")
sg.Name = "SenkyV3"
sg.Parent = game.CoreGui
sg.DisplayOrder = 999999

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 140, 0, 260)
main.Position = UDim2.new(0.1, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.BorderSizePixel = 2
main.BorderColor3 = Color3.fromRGB(255, 0, 0)
main.Active = true
main.Draggable = true
main.Parent = sg

local function create(name, pos, call)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.Parent = main
    btn.MouseButton1Click:Connect(call)
    return btn
end

local fbtn = create("FARM: OFF", UDim2.new(0.05, 0, 0.1, 0), function()
    _G.AutoFarm = not _G.AutoFarm
    main:FindFirstChild("FARM: OFF").Text = _G.AutoFarm and "FARM: ON" or "FARM: OFF"
end)

create("SĂN TRÁI (HOP)", UDim2.new(0.05, 0, 0.3, 0), function()
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
end)

create("NHẶT RƯƠNG", UDim2.new(0.05, 0, 0.5, 0), function()
    _G.AutoChest = not _G.AutoChest
end)

create("ĐÓNG MENU", UDim2.new(0.05, 0, 0.8, 0), function()
    sg:Destroy()
end)

RunService.RenderStepped:Connect(function()
    if _G.FastAttack and (_G.AutoFarm or _G.AutoChest) then
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Attack", "1")
            VirtualUser:Button1Down(Vector2.new(0,0))
            VirtualUser:Button1Up(Vector2.new(0,0))
        end)
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarm and _G.BringMob then
            pcall(function()
                for _, v in pairs(Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        if (v.HumanoidRootPart.Position - hrp.Position).Magnitude <= 300 then
                            v.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
                            v.HumanoidRootPart.CanCollide = false
                        end
                    end
                end
            end)
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
    {min = 120, quest = "MarineQuest2", id = 1, mob = "Chief Petty Officer", pos = Vector3.new(-4882, 22, -5102)},
    {min = 150, quest = "SkyQuest", id = 1, mob = "Sky Bandit", pos = Vector3.new(-4724, 845, -1953)},
    {min = 190, quest = "PrisonQuest", id = 1, mob = "Prisoner", pos = Vector3.new(4844, 5, 743)},
    {min = 250, quest = "ColosseumQuest", id = 1, mob = "Toga Warrior", pos = Vector3.new(-1576, 7, 298)},
    {min = 300, quest = "MagmaQuest", id = 1, mob = "Military Soldier", pos = Vector3.new(-5242, 8, 8466)},
    {min = 700, quest = "Area1Quest", id = 1, mob = "Raider", pos = Vector3.new(-429, 73, 1832)},
    {min = 800, quest = "Area2Quest", id = 1, mob = "Swan Pirate", pos = Vector3.new(638, 73, 918)},
    {min = 1000, quest = "ShipQuest1", id = 1, mob = "Ship Pirate", pos = Vector3.new(-9506, 15, -1500)},
    {min = 1500, quest = "PiratePortTownQuest", id = 1, mob = "Pirate Millionaire", pos = Vector3.new(-290, 43, 5577)},
    {min = 1800, quest = "HauntedCastleQuest", id = 1, mob = "Haunted Mummy", pos = Vector3.new(-9500, 50, 5500)},
    {min = 2000, quest = "SeaOfTreatsQuest", id = 1, mob = "Peanut Scout", pos = Vector3.new(-1000, 100, -1000)},
    {min = 2300, quest = "CakeQuest", id = 1, mob = "Cake Guard", pos = Vector3.new(-1150, 70, -2500)},
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
                    local dist = (hrp.Position - q.pos).Magnitude
                    TweenService:Create(hrp, TweenInfo.new(dist/350, Enum.EasingStyle.Linear), {CFrame = CFrame.new(q.pos)}):Play()
                    task.wait(dist/350)
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