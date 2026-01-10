local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "CHIEN THAN V11 - ZERO DELAY",
    SubTitle = "Admin ID: 1180691145630683216",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Config = {
    AutoFarm = false,
    ZeroDelay = false,
    BringMob = false,
    Distance = 10
}

local QuestData = {
    {0, "Bandit", "BanditQuest1", 1, CFrame.new(1059, 15, 1550)},
    {10, "Monkey", "JungleQuest", 1, CFrame.new(-1598, 37, 153)},
    {15, "Gorilla", "JungleQuest", 2, CFrame.new(-1204, 51, -452)}
}

function GetQuest()
    local myLevel = game.Players.LocalPlayer.Data.Level.Value
    for i = #QuestData, 1, -1 do
        if myLevel >= QuestData[i][1] then return QuestData[i] end
    end
end

task.spawn(function()
    game:GetService("RunService").Stepped:Connect(function()
        if Config.ZeroDelay and Config.AutoFarm then
            pcall(function()
                local vim = game:GetService("VirtualInputManager")
                vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                
                local combat = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
                if combat.activeController and combat.activeController.activeWeapon then
                    combat.activeController.hitboxMagnitude = 60
                    combat.activeController.activeWeapon:Attack()
                end
            end)
        end
    end)
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
                            target = v break
                        end
                    end
                    if target then
                        repeat
                            task.wait()
                            for _, t in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if t:IsA("Tool") then game.Players.LocalPlayer.Character.Humanoid:EquipTool(t) end
                            end
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

local Main = Window:AddTab({ Title = "Main", Icon = "home" })
Main:AddToggle("AF", {Title = "Auto Farm Level", Default = false}):OnChanged(function(v) Config.AutoFarm = v end)
Main:AddToggle("ZD", {Title = "Zero Delay Tap (Click)", Default = false}):OnChanged(function(v) Config.ZeroDelay = v end)
Main:AddToggle("BM", {Title = "Bring Mob", Default = false}):OnChanged(function(v) Config.BringMob = v end)
Main:AddSlider("DS", {Title = "Distance", Min = 5, Max = 25, Default = 10, Callback = function(v) Config.Distance = v end})

local SG = Instance.new("ScreenGui", game.CoreGui)
local BT = Instance.new("TextButton", SG)
BT.Size, BT.Position, BT.Text = UDim2.new(0,50,0,50), UDim2.new(0,10,0.4,0), "MENU"
BT.BackgroundColor3 = Color3.new(0,0,0)
BT.TextColor3 = Color3.new(1,1,1)
BT.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
end)