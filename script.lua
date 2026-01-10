local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "CHIEN THAN V10 - ANTI BAN",
    SubTitle = "Admin ID: 1180691145630683216",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Config = {
    AutoFarm = false,
    FastAttack = false,
    BringMob = false,
    Distance = 10,
    AutoStats = false,
    SelectedStat = "Melee",
    NoClip = true
}

local QuestData = {
    ["Sea1"] = {
        {0, "Bandit", "BanditQuest1", 1, CFrame.new(1059, 15, 1550)},
        {10, "Monkey", "JungleQuest", 1, CFrame.new(-1598, 37, 153)},
        {15, "Gorilla", "JungleQuest", 2, CFrame.new(-1204, 51, -452)},
        {30, "Pirate", "PiratIslandQuest", 1, CFrame.new(-1144, 4, 3827)},
        {60, "Brute", "PiratIslandQuest", 2, CFrame.new(-1144, 4, 3827)},
        {90, "Desert Bandit", "DesertQuest", 1, CFrame.new(894, 6, 4392)},
        {120, "Desert Officer", "DesertQuest", 2, CFrame.new(894, 6, 4392)},
        {150, "Snow Bandit", "SnowQuest", 1, CFrame.new(1389, 87, -1297)},
        {190, "Snowman", "SnowQuest", 2, CFrame.new(1389, 87, -1297)},
        {250, "Chief Petty Officer", "MarineQuest2", 1, CFrame.new(-4854, 22, 4261)},
        {300, "Sky Bandit", "SkyQuest", 1, CFrame.new(-4854, 22, 4261)}
    }
}

local function GetQuest()
    local myLevel = game.Players.LocalPlayer.Data.Level.Value
    local sea = "Sea1"
    local best = nil
    for _, q in pairs(QuestData[sea]) do
        if myLevel >= q[1] then best = q end
    end
    return best
end

local function EquipTool()
    pcall(function()
        local backpack = game.Players.LocalPlayer.Backpack
        local character = game.Players.LocalPlayer.Character
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.ToolTip == "Melee" then
                character.Humanoid:EquipTool(tool)
            end
        end
    end)
end

task.spawn(function()
    while task.wait() do
        if Config.FastAttack then
            pcall(function()
                local combat = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
                local active = combat.activeController
                if active and active.activeWeapon then
                    active.hitboxMagnitude = 60
                    active.activeWeapon:Attack()
                    task.wait(0.01)
                    if active.activeWeapon.IsAttacking then
                        active.activeWeapon.IsAttacking = false
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Config.AutoFarm then
            pcall(function()
                local q = GetQuest()
                if q then
                    if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", q[3], q[4])
                    end
                    local target = nil
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == q[2] and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            target = v
                            break
                        end
                    end
                    if target then
                        repeat
                            task.wait()
                            EquipTool()
                            if Config.BringMob then
                                for _, m in pairs(game.Workspace.Enemies:GetChildren()) do
                                    if m.Name == q[2] and m:FindFirstChild("HumanoidRootPart") then
                                        m.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame
                                        m.HumanoidRootPart.CanCollide = false
                                    end
                                end
                            end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, Config.Distance, 0)
                        until not Config.AutoFarm or target.Humanoid.Health <= 0 or not target.Parent
                    else
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = q[5]
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    game:GetService("RunService").Stepped:Connect(function()
        if Config.NoClip then
            pcall(function()
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end)
        end
    end)
end)

local Tabs = {
    Main = Window:AddTab({ Title = "Farm", Icon = "home" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "bar-chart" })
}

Tabs.Main:AddToggle("AF", {Title = "Auto Farm Level", Default = false}):OnChanged(function(v) Config.AutoFarm = v end)
Tabs.Main:AddToggle("FA", {Title = "Safe Fast Attack", Default = false}):OnChanged(function(v) Config.FastAttack = v end)
Tabs.Main:AddToggle("BM", {Title = "Bring Mob", Default = false}):OnChanged(function(v) Config.BringMob = v end)
Tabs.Main:AddSlider("DS", {Title = "Distance", Min = 5, Max = 20, Default = 10, Callback = function(v) Config.Distance = v end})

local SG = Instance.new("ScreenGui", game.CoreGui)
local BT = Instance.new("TextButton", SG)
BT.Size, BT.Position, BT.Text = UDim2.new(0,50,0,50), UDim2.new(0,10,0.4,0), "MENU"
BT.BackgroundColor3 = Color3.new(0,0,0)
BT.TextColor3 = Color3.new(0,1,0)
BT.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
end)