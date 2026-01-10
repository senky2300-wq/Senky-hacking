local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "CHIEN THAN BONG DEM - ULTIMATE HYBRID",
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
    AutoStats = false,
    SelectedStat = "Melee"
}

local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "home" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "sword" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "bar-chart" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
}

local function FastAttackLogic()
    pcall(function()
        local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
        local RigController = CombatFramework.activeController
        if RigController and RigController.activeWeapon then
            for i = 1, 15 do
                RigController.activeWeapon:Attack()
            end
        end
    end)
end

task.spawn(function()
    while task.wait() do
        if Config.AutoFarm then
            pcall(function()
                local QuestModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/xQuartyx/DonateMe/main/OldBloxFruitQuests.lua"))()
                local q = QuestModule.GetQuest()
                if q then
                    if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", q.QuestName, q.LevelIndex)
                    end
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == q.MobName and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                                if Config.FastAttack then FastAttackLogic() end
                                if Config.BringMob then
                                    for _, m in pairs(game.Workspace.Enemies:GetChildren()) do
                                        if m.Name == q.MobName then
                                            m.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                            m.HumanoidRootPart.CanCollide = false
                                        end
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

Tabs.Main:AddToggle("AF", {Title = "Auto Farm (Hybrid Logic)", Default = false}):OnChanged(function(v) Config.AutoFarm = v end)
Tabs.Main:AddToggle("FA", {Title = "Super Fast Attack", Default = false}):OnChanged(function(v) Config.FastAttack = v end)
Tabs.Main:AddToggle("BM", {Title = "Bring Mob", Default = false}):OnChanged(function(v) Config.BringMob = v end)

Tabs.Stats:AddDropdown("St", {Title = "Select Stat", Values = {"Melee", "Defense", "Sword"}, Default = "Melee", Callback = function(v) Config.SelectedStat = v end})
Tabs.Stats:AddToggle("AS", {Title = "Auto Update Stats", Default = false}):OnChanged(function(v) Config.AutoStats = v end)

task.spawn(function()
    while task.wait(0.5) do
        if Config.AutoStats then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", Config.SelectedStat, 1)
        end
    end
end)

local SG = Instance.new("ScreenGui", game.CoreGui)
local BT = Instance.new("TextButton", SG)
BT.Size, BT.Position, BT.Text = UDim2.new(0,50,0,50), UDim2.new(0,10,0.5,0), "MENU"
BT.BackgroundColor3 = Color3.new(0,0,0)
BT.TextColor3 = Color3.new(0,1,0)
BT.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
end)

Window:SelectTab(1)