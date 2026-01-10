local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "HUY DIET MOBILE V5 - FIX TUYET DOI",
    SubTitle = "Admin ID: 1180691145630683216",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Farm", Icon = "home" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "sword" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "bar-chart" }),
    Fruit = Window:AddTab({ Title = "Fruit", Icon = "cherry" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
}

local Config = {
    AutoFarm = false,
    BringMob = false,
    FastAttack = false,
    GodMode = false,
    NoCooldown = false,
    AutoStats = false,
    SelectedStat = "Melee",
    InfiniteJump = true,
    Distance = 10
}

local Quests = {
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
    for _, q in pairs(Quests["Sea1"]) do
        if myLevel >= q[1] then res = q end
    end
    return res
end

task.spawn(function()
    while task.wait() do
        if Config.AutoFarm then
            pcall(function()
                local q = GetQuest()
                if q then
                    if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", q[3], q[4])
                    end
                    local mob = nil
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == q[2] and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            mob = v
                            break
                        end
                    end
                    if mob then
                        repeat
                            task.wait()
                            for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if v:IsA("Tool") then
                                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                                end
                            end
                            if Config.BringMob then
                                for _, m in pairs(game.Workspace.Enemies:GetChildren()) do
                                    if m.Name == q[2] and m:FindFirstChild("HumanoidRootPart") then
                                        m.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame
                                        m.HumanoidRootPart.CanCollide = false
                                    end
                                end
                            end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, Config.Distance, 0)
                            if Config.FastAttack then
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
                            end
                        until not Config.AutoFarm or mob.Humanoid.Health <= 0 or not mob.Parent
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
        if Config.AutoFarm then
            pcall(function()
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end)
        end
    end)
end)

Tabs.Main:AddToggle("Farm", {Title = "Auto Farm Level (Fix)", Default = false}):OnChanged(function(v) Config.AutoFarm = v end)
Tabs.Main:AddToggle("Bring", {Title = "Bring Mob (Gom Quai)", Default = false}):OnChanged(function(v) Config.BringMob = v end)
Tabs.Main:AddToggle("Attack", {Title = "Fast Attack (Click)", Default = false}):OnChanged(function(v) Config.FastAttack = v end)
Tabs.Main:AddSlider("Dist", {Title = "Khoang Cach Farm", Min = 5, Max = 25, Default = 10, Callback = function(v) Config.Distance = v end})

Tabs.Stats:AddDropdown("St", {Title = "Chon Point", Values = {"Melee", "Defense", "Sword"}, Default = "Melee", Callback = function(v) Config.SelectedStat = v end})
Tabs.Stats:AddToggle("Up", {Title = "Auto Stats", Default = false}):OnChanged(function(v) Config.AutoStats = v end)

task.spawn(function()
    while task.wait(0.5) do
        if Config.AutoStats then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", Config.SelectedStat, 1)
        end
    end
end)

local SG = Instance.new("ScreenGui", game.CoreGui)
local BT = Instance.new("TextButton", SG)
BT.Size = UDim2.new(0, 50, 0, 50)
BT.Position = UDim2.new(0, 10, 0.4, 0)
BT.Text = "MENU"
BT.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
BT.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if Config.InfiniteJump then game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping") end
end)