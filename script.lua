local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "CHIEN THAN V15 - TRADE MASTER",
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
    AutoStore = false,
    Distance = 10,
    FruitSniper = false
}

local QuestData = {
    ["Sea1"] = {
        {0, "Bandit", "BanditQuest1", 1, CFrame.new(1059, 15, 1550)},
        {10, "Monkey", "JungleQuest", 1, CFrame.new(-1598, 37, 153)},
        {15, "Gorilla", "JungleQuest", 2, CFrame.new(-1204, 51, -452)}
    }
}

task.spawn(function()
    game:GetService("RunService").Stepped:Connect(function()
        if Config.FastAttack and Config.AutoFarm then
            pcall(function()
                local vim = game:GetService("VirtualInputManager")
                vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                local combat = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
                if combat.activeController and combat.activeController.activeWeapon then
                    combat.activeController.hitboxMagnitude = 75
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
                local level = game.Players.LocalPlayer.Data.Level.Value
                local q = nil
                for _, v in pairs(QuestData["Sea1"]) do if level >= v[1] then q = v end end
                if q then
                    if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", q[3], q[4])
                    end
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == q[2] and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                for _, t in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                    if t:IsA("Tool") then game.Players.LocalPlayer.Character.Humanoid:EquipTool(t) end
                                end
                                if Config.BringMob then
                                    for _, m in pairs(game.Workspace.Enemies:GetChildren()) do
                                        if m.Name == q[2] then m.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame m.HumanoidRootPart.CanCollide = false end
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

task.spawn(function()
    while task.wait(1) do
        if Config.FruitSniper then
            pcall(function()
                for _, v in pairs(game.Workspace:GetChildren()) do
                    if v:IsA("Tool") and v.Name:find("Fruit") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                    end
                end
            end)
        end
        if Config.AutoStore then
            for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if v:IsA("Tool") and v.ToolTip == "Blox Fruit" then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v.Name, v)
                end
            end
        end
    end
end)

local Tabs = {
    Main = Window:AddTab({ Title = "Farm", Icon = "home" }),
    Trade = Window:AddTab({ Title = "Trade & World", Icon = "globe" })
}

Tabs.Main:AddToggle("AF", {Title = "Auto Farm Level", Default = false}):OnChanged(function(v) Config.AutoFarm = v end)
Tabs.Main:AddToggle("FA", {Title = "Fast Attack (Zero Delay)", Default = false}):OnChanged(function(v) Config.FastAttack = v end)
Tabs.Main:AddToggle("BM", {Title = "Gom Quai", Default = false}):OnChanged(function(v) Config.BringMob = v end)

Tabs.Trade:AddToggle("SN", {Title = "Fruit Sniper (Nhat Trai)", Default = false}):OnChanged(function(v) Config.FruitSniper = v end)
Tabs.Trade:AddToggle("AS", {Title = "Auto Store (Tu Cat)", Default = false}):OnChanged(function(v) Config.AutoStore = v end)
Tabs.Trade:AddButton({Title = "Server Hop (Tim Server Moi)", Callback = function()
    local Http = game:GetService("HttpService")
    local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local Result = Http:JSONDecode(game:HttpGet(Api))
    for _, s in pairs(Result.data) do
        if s.playing < s.maxPlayers then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id) end
    end
end})

local SG = Instance.new("ScreenGui", game.CoreGui)
local BT = Instance.new("TextButton", SG)
BT.Size, BT.Position, BT.Text = UDim2.new(0,50,0,50), UDim2.new(0,10,0.5,0), "MENU"
BT.BackgroundColor3 = Color3.new(0,0,0)
BT.TextColor3 = Color3.new(0,1,1)
BT.MouseButton1Click:Connect(function() game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game) end)