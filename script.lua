local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "HUY DIET BLOX FRUIT - CHIEN THAN V3",
    SubTitle = "Admin ID: 1180691145630683216",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "home" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "sword" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "bar-chart" }),
    Fruit = Window:AddTab({ Title = "Fruit", Icon = "cherry" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
}

local Config = {
    AutoFarm = false,
    BringMob = false,
    FastAttack = false,
    AutoChest = false,
    GodMode = false,
    NoCooldown = false,
    InfiniteJump = false,
    WalkOnWater = false,
    NoClip = false,
    FruitSniper = false,
    AutoStore = false,
    AutoStats = false,
    SelectedStat = "Melee",
    AntiAFK = true
}

local QuestList = {
    ["Sea1"] = {
        {Level = 0, Name = "Bandit", QuestName = "BanditQuest1", QuestLevel = 1, Pos = CFrame.new(1059.3, 15.4, 1550.6)},
        {Level = 10, Name = "Monkey", QuestName = "JungleQuest", QuestLevel = 1, Pos = CFrame.new(-1598.4, 37.3, 153.2)},
        {Level = 15, Name = "Gorilla", QuestName = "JungleQuest", QuestLevel = 2, Pos = CFrame.new(-1204.2, 51.1, -452.1)},
        {Level = 30, Name = "Pirate", QuestName = "PiratIslandQuest", QuestLevel = 1, Pos = CFrame.new(-1144.1, 4.7, 3827.3)},
        {Level = 60, Name = "Brute", QuestName = "PiratIslandQuest", QuestLevel = 2, Pos = CFrame.new(-1144.1, 4.7, 3827.3)},
        {Level = 90, Name = "Desert Bandit", QuestName = "DesertQuest", QuestLevel = 1, Pos = CFrame.new(894.1, 6.4, 4392.1)},
        {Level = 120, Name = "Desert Officer", QuestName = "DesertQuest", QuestLevel = 2, Pos = CFrame.new(894.1, 6.4, 4392.1)},
        {Level = 150, Name = "Snow Bandit", QuestName = "SnowQuest", QuestLevel = 1, Pos = CFrame.new(1389.2, 87.3, -1297.4)},
        {Level = 190, Name = "Snowman", QuestName = "SnowQuest", QuestLevel = 2, Pos = CFrame.new(1389.2, 87.3, -1297.4)},
        {Level = 250, Name = "Chief Petty Officer", QuestName = "MarineQuest2", QuestLevel = 1, Pos = CFrame.new(-4854.1, 22.4, 4261.2)},
        {Level = 300, Name = "Sky Bandit", QuestName = "SkyQuest", QuestLevel = 1, Pos = CFrame.new(-4854.1, 22.4, 4261.2)}
    },
    ["Sea2"] = {
        {Level = 700, Name = "Raider", QuestName = "Area1Quest", QuestLevel = 1, Pos = CFrame.new(-424.1, 72.5, 1836.2)},
        {Level = 725, Name = "Mercenary", QuestName = "Area1Quest", QuestLevel = 2, Pos = CFrame.new(-424.1, 72.5, 1836.2)},
        {Level = 775, Name = "Swan Pirate", QuestName = "Area2Quest", QuestLevel = 1, Pos = CFrame.new(634.1, 72.5, 402.2)},
        {Level = 875, Name = "Marine Captain", QuestName = "MarineQuest3", QuestLevel = 1, Pos = CFrame.new(-2506.1, 72.5, -3145.2)},
        {Level = 900, Name = "Zombie", QuestName = "ZombieQuest", QuestLevel = 1, Pos = CFrame.new(-5622.1, 72.5, -718.2)}
    },
    ["Sea3"] = {
        {Level = 1500, Name = "Pirate Millionaire", QuestName = "FloatingTurtleQuest1", QuestLevel = 1, Pos = CFrame.new(-11489.1, 4.2, 3830.2)},
        {Level = 1525, Name = "Pistol Billionaire", QuestName = "FloatingTurtleQuest1", QuestLevel = 2, Pos = CFrame.new(-11489.1, 4.2, 3830.2)},
        {Level = 1575, Name = "Sun-kissed Warrior", QuestName = "FloatingTurtleQuest2", QuestLevel = 1, Pos = CFrame.new(-11489.1, 4.2, 3830.2)}
    }
}

function GetCurrentSea()
    local placeId = game.PlaceId
    if placeId == 2753915549 then return "Sea1" end
    if placeId == 4442245229 then return "Sea2" end
    if placeId == 7449925010 then return "Sea3" end
end

function CheckQuest()
    local myLevel = game.Players.LocalPlayer.Data.Level.Value
    local sea = GetCurrentSea()
    local bestQuest = nil
    for i, v in pairs(QuestList[sea]) do
        if myLevel >= v.Level then
            bestQuest = v
        end
    end
    return bestQuest
end

function EquipWeapon()
    pcall(function()
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v:IsA("Tool") and (v.ToolTip == "Melee" or v.ToolTip == "Sword" or v.ToolTip == "Blox Fruit") then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
            end
        end
    end)
end

task.spawn(function()
    while task.wait() do
        if Config.AutoFarm then
            pcall(function()
                local q = CheckQuest()
                if q then
                    if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", q.QuestName, q.QuestLevel)
                    end
                    for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == q.Name and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                EquipWeapon()
                                if Config.BringMob then
                                    for _, m in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                        if m.Name == q.Name and m:FindFirstChild("HumanoidRootPart") then
                                            m.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                            m.HumanoidRootPart.CanCollide = false
                                            m.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        end
                                    end
                                end
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0)
                            until not Config.AutoFarm or v.Humanoid.Health <= 0 or not v.Parent
                        end
                    end
                    if not game:GetService("Workspace").Enemies:FindFirstChild(q.Name) then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = q.Pos
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if Config.FastAttack then
            pcall(function()
                local virtualUser = game:GetService("VirtualUser")
                virtualUser:CaptureController()
                virtualUser:ClickButton1(Vector2.new(851, 158))
                local combat = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
                local active = combat.activeController
                if active and active.activeWeapon then
                    active.hitboxMagnitude = 55
                    active.activeWeapon:Attack()
                end
            end)
        end
    end)
end)

task.spawn(function()
    while task.wait() do
        if Config.AutoChest then
            pcall(function()
                for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v.Name:find("Chest") and v:IsA("BasePart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        task.wait(0.1)
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Config.GodMode then
            pcall(function()
                game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("BasePart") then
                        v.CanTouch = false
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Config.NoCooldown then
            pcall(function()
                for _, v in pairs(getgc(true)) do
                    if type(v) == "table" and v.Cooldown ~= nil then
                        v.Cooldown = 0
                    end
                end
            end)
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if Config.NoClip then
        pcall(function()
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end)
    end
end)

task.spawn(function()
    while task.wait() do
        if Config.WalkOnWater then
            pcall(function()
                local water = game:GetService("Workspace").Map:FindFirstChild("Water")
                if water then water.CanCollide = true end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Config.FruitSniper then
            pcall(function()
                for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v:IsA("Tool") and v:FindFirstChild("Handle") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                        if Config.AutoStore then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v.Name, v)
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if Config.AutoStats then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", Config.SelectedStat, 1)
            end)
        end
    end
end)

local MainToggle = Tabs.Main:AddToggle("AutoFarm", {Title = "Auto Farm Level", Default = false})
MainToggle:OnChanged(function(Value) Config.AutoFarm = Value end)

local BringToggle = Tabs.Main:AddToggle("BringMob", {Title = "Bring Mob (Gom Quai)", Default = false})
BringToggle:OnChanged(function(Value) Config.BringMob = Value end)

local FastToggle = Tabs.Main:AddToggle("FastAttack", {Title = "Sieu Fast Attack", Default = false})
FastToggle:OnChanged(function(Value) Config.FastAttack = Value end)

local ChestToggle = Tabs.Main:AddToggle("AutoChest", {Title = "Auto Farm Chest", Default = false})
ChestToggle:OnChanged(function(Value) Config.AutoChest = Value end)

local GodToggle = Tabs.Combat:AddToggle("GodMode", {Title = "God Mode (Bat Tu)", Default = false})
GodToggle:OnChanged(function(Value) Config.GodMode = Value end)

local CDToggle = Tabs.Combat:AddToggle("NoCD", {Title = "No Cooldown Skill", Default = false})
CDToggle:OnChanged(function(Value) Config.NoCooldown = Value end)

local StatDrop = Tabs.Stats:AddDropdown("StatSelect", {Title = "Select Stat", Values = {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}, Default = "Melee"})
StatDrop:OnChanged(function(Value) Config.SelectedStat = Value end)

local StatToggle = Tabs.Stats:AddToggle("AutoStat", {Title = "Auto Stats", Default = false})
StatToggle:OnChanged(function(Value) Config.AutoStats = Value end)

local SnipeToggle = Tabs.Fruit:AddToggle("Sniper", {Title = "Fruit Sniper", Default = false})
SnipeToggle:OnChanged(function(Value) Config.FruitSniper = Value end)

local StoreToggle = Tabs.Fruit:AddToggle("Store", {Title = "Auto Store Fruit", Default = false})
StoreToggle:OnChanged(function(Value) Config.AutoStore = Value end)

Tabs.Misc:AddButton({Title = "Server Hop", Callback = function()
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local Result = Http:JSONDecode(game:HttpGet(Api))
    for _, s in pairs(Result.data) do
        if s.playing < s.maxPlayers then
            TPS:TeleportToPlaceInstance(game.PlaceId, s.id)
        end
    end
end})

local AFKToggle = Tabs.Misc:AddToggle("AntiAFK", {Title = "Anti AFK", Default = true})
AFKToggle:OnChanged(function(Value) Config.AntiAFK = Value end)

game.Players.LocalPlayer.Idled:Connect(function()
    if Config.AntiAFK then
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end
end)

local FloatBtn = Instance.new("ScreenGui")
local Btn = Instance.new("TextButton")
FloatBtn.Parent = game:GetService("CoreGui")
Btn.Parent = FloatBtn
Btn.Size = UDim2.new(0, 50, 0, 50)
Btn.Position = UDim2.new(0, 10, 0.5, 0)
Btn.Text = "MENU"
Btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Btn.TextColor3 = Color3.fromRGB(255, 0, 0)
Btn.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
end)

Window:SelectTab(1)