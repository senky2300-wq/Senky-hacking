local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "CHIEN THAN V13 - REAL KILLER",
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
    Distance = 8
}

local QuestData = {
    ["Sea1"] = {
        {0, "Bandit", "BanditQuest1", 1, CFrame.new(1059, 15, 1550)},
        {10, "Monkey", "JungleQuest", 1, CFrame.new(-1598, 37, 153)},
        {15, "Gorilla", "JungleQuest", 2, CFrame.new(-1204, 51, -452)}
    }
}

local function GetQuest()
    local level = game.Players.LocalPlayer.Data.Level.Value
    local best = nil
    for _, q in pairs(QuestData["Sea1"]) do
        if level >= q[1] then best = q end
    end
    return best
end

local function DirectAttack(target)
    pcall(function()
        local combat = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
        local active = combat.activeController
        if active and active.activeWeapon then
            for i = 1, 20 do
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Attack", target.HumanoidRootPart.Position)
                active.activeWeapon:Attack()
                active.hitboxMagnitude = 100
            end
        end
    end)
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
                                if Config.FastAttack then DirectAttack(v) end
                            until not Config.AutoFarm or v.Humanoid.Health <= 0 or not v.Parent
                        end
                    end
                    if not game.Workspace.Enemies:FindFirstChild(q[2]) then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = q[5]
                    end
                end
            end)
        end
    end
end)

local Main = Window:AddTab({ Title = "Huy Diet", Icon = "home" })
Main:AddToggle("AF", {Title = "Auto Farm Level", Default = false}):OnChanged(function(v) Config.AutoFarm = v end)
Main:AddToggle("FA", {Title = "Sieu Fast Attack (X20)", Default = false}):OnChanged(function(v) Config.FastAttack = v end)
Main:AddToggle("BM", {Title = "Gom Quai", Default = false}):OnChanged(function(v) Config.BringMob = v end)

local SG = Instance.new("ScreenGui", game.CoreGui)
local BT = Instance.new("TextButton", SG)
BT.Size, BT.Position, BT.Text = UDim2.new(0,60,0,60), UDim2.new(0,10,0.4,0), "MENU"
BT.BackgroundColor3 = Color3.new(0,0,0)
BT.TextColor3 = Color3.new(1,1,0)
BT.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
end)

Window:SelectTab(1)