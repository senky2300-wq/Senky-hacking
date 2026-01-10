local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "CHIEN THAN BONG DEM V8 - CRACK LOGIC",
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
    SelectedStat = "Melee"
}

local QuestList = {
    ["Sea1"] = {
        {0, "Bandit", "BanditQuest1", 1, CFrame.new(1059, 15, 1550)},
        {10, "Monkey", "JungleQuest", 1, CFrame.new(-1598, 37, 153)},
        {15, "Gorilla", "JungleQuest", 2, CFrame.new(-1204, 51, -452)},
        {30, "Pirate", "PiratIslandQuest", 1, CFrame.new(-1144, 4, 3827)}
    }
}

function GetQuest()
    local myLevel = game.Players.LocalPlayer.Data.Level.Value
    local res = nil
    for _, q in pairs(QuestList["Sea1"]) do
        if myLevel >= q[1] then res = q end
    end
    return res
end

task.spawn(function()
    while task.wait() do
        if Config.FastAttack then
            pcall(function()
                local combat = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
                local active = combat.activeController
                if active and active.activeWeapon then
                    active.hitboxMagnitude = 65
                    for i = 1, 5 do
                        active.activeWeapon:Attack()
                    end
                end
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
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
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == q[2] and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                    if tool:IsA("Tool") then game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool) end
                                end
                                if Config.BringMob then
                                    for _, m in pairs(game.Workspace.Enemies:GetChildren()) do
                                        if m.Name == q[2] and m:FindFirstChild("HumanoidRootPart") then
                                            m.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                            m.HumanoidRootPart.CanCollide = false
                                        end
                                    end
                                end
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, Config.Distance, 0)
                            until not Config.AutoFarm or v.Humanoid.Health <= 0 or not v.Parent
                        end
                    end
                end
            end)
        end
    end
end)

local Tabs = {
    Main = Window:AddTab({ Title = "Farm", Icon = "home" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "bar-chart" })
}

Tabs.Main:AddToggle("Farm", {Title = "Auto Farm Level (V8)", Default = false}):OnChanged(function(v) Config.AutoFarm = v end)
Tabs.Main:AddToggle("Attack", {Title = "Fast Attack (MinVn Style)", Default = false}):OnChanged(function(v) Config.FastAttack = v end)
Tabs.Main:AddToggle("Bring", {Title = "Gom Quai", Default = false}):OnChanged(function(v) Config.BringMob = v end)
Tabs.Main:AddSlider("Dist", {Title = "Distance", Min = 5, Max = 20, Default = 10, Callback = function(v) Config.Distance = v end})

local SG = Instance.new("ScreenGui", game.CoreGui)
local BT = Instance.new("TextButton", SG)
BT.Size, BT.Position, BT.Text = UDim2.new(0,50,0,50), UDim2.new(0,10,0.4,0), "MENU"
BT.BackgroundColor3 = Color3.new(1,0,0)
BT.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
end)