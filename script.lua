local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "SIEU CAP CHIEN THAN V7 - SPEED ATTACK",
    SubTitle = "Admin ID: 1180691145630683216",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Farm", Icon = "home" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "bar-chart" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
}

local Config = {
    AutoFarm = false,
    FastAttack = false,
    BringMob = false,
    Distance = 10
}

local Quests = {
    ["Sea1"] = {
        {0, "Bandit", "BanditQuest1", 1, CFrame.new(1059, 15, 1550)},
        {10, "Monkey", "JungleQuest", 1, CFrame.new(-1598, 37, 153)},
        {15, "Gorilla", "JungleQuest", 2, CFrame.new(-1204, 51, -452)}
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
                                if Config.FastAttack then
                                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
                                    local combat = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
                                    if combat.activeController and combat.activeController.activeWeapon then
                                        combat.activeController.activeWeapon:Attack()
                                    end
                                end
                            until not Config.AutoFarm or v.Humanoid.Health <= 0 or not v.Parent
                        end
                    end
                end
            end)
        end
    end
end)

Tabs.Main:AddToggle("Farm", {Title = "Auto Farm (Sieu Nhanh)", Default = false}):OnChanged(function(v) Config.AutoFarm = v end)
Tabs.Main:AddToggle("Attack", {Title = "Sieu Fast Attack", Default = false}):OnChanged(function(v) Config.FastAttack = v end)
Tabs.Main:AddToggle("Bring", {Title = "Gom Quai", Default = false}):OnChanged(function(v) Config.BringMob = v end)

local SG = Instance.new("ScreenGui", game.CoreGui)
local BT = Instance.new("TextButton", SG)
BT.Size, BT.Position, BT.Text = UDim2.new(0,50,0,50), UDim2.new(0,10,0.4,0), "MENU"
BT.BackgroundColor3 = Color3.new(1,0,0)
BT.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
end)