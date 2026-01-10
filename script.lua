local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "CHIEN THAN HUY DIET V4 - FIX ALL",
    SubTitle = "Anh Em Cot Cheo",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Farm", Icon = "home" }),
    Combat = Window:AddTab({ Title = "PVP", Icon = "sword" }),
    Stats = Window:AddTab({ Title = "Point", Icon = "bar-chart" }),
    Misc = Window:AddTab({ Title = "More", Icon = "settings" })
}

local Config = {
    AutoFarm = false,
    BringMob = false,
    FastAttack = false,
    GodMode = false,
    NoCooldown = false,
    AutoStats = false,
    SelectedStat = "Melee"
}

local function GetWeapon()
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then return v.Name end
    end
    for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then return v.Name end
    end
end

task.spawn(function()
    while task.wait() do
        if Config.AutoFarm then
            pcall(function()
                local tool = GetWeapon()
                if tool then
                    if not game.Players.LocalPlayer.Character:FindFirstChild(tool) then
                        local t = game.Players.LocalPlayer.Backpack:FindFirstChild(tool)
                        if t then game.Players.LocalPlayer.Character.Humanoid:EquipTool(t) end
                    end
                end
                
                local myLevel = game.Players.LocalPlayer.Data.Level.Value
                local qName, qLevel, mName, mPos
                if myLevel < 10 then
                    qName, qLevel, mName, mPos = "BanditQuest1", 1, "Bandit", CFrame.new(1059, 15, 1550)
                elseif myLevel < 15 then
                    qName, qLevel, mName, mPos = "JungleQuest", 1, "Monkey", CFrame.new(-1598, 37, 153)
                end

                if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", qName, qLevel)
                end

                for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v.Name == mName and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        repeat
                            task.wait()
                            if Config.BringMob then
                                for _, m in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if m.Name == mName and m:FindFirstChild("HumanoidRootPart") then
                                        m.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                        m.HumanoidRootPart.CanCollide = false
                                    end
                                end
                            end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 11, 0)
                            
                            if Config.FastAttack then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Attack", v.HumanoidRootPart.Position)
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(851, 158), workspace.CurrentCamera.CFrame)
                            end
                        until not Config.AutoFarm or v.Humanoid.Health <= 0 or not v.Parent
                    end
                end
            end)
        end
    end
end)

Tabs.Main:AddToggle("T1", {Title = "Auto Farm Level", Default = false}):OnChanged(function(v) Config.AutoFarm = v end)
Tabs.Main:AddToggle("T2", {Title = "Gom Quai (Bring Mob)", Default = false}):OnChanged(function(v) Config.BringMob = v end)
Tabs.Main:AddToggle("T3", {Title = "Fast Attack (Fix)", Default = false}):OnChanged(function(v) Config.FastAttack = v end)

Tabs.Stats:AddDropdown("D1", {Title = "Chon Point", Values = {"Melee", "Defense", "Sword"}, Default = "Melee", Callback = function(v) Config.SelectedStat = v end})
Tabs.Stats:AddToggle("T4", {Title = "Auto Up Point", Default = false}):OnChanged(function(v) Config.AutoStats = v end)

task.spawn(function()
    while task.wait(1) do
        if Config.AutoStats then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", Config.SelectedStat, 1)
        end
    end
end)

local Float = Instance.new("ScreenGui", game:GetService("CoreGui"))
local B = Instance.new("TextButton", Float)
B.Size, B.Position, B.Text = UDim2.new(0,60,0,60), UDim2.new(0,10,0.4,0), "ON/OFF"
B.BackgroundColor3 = Color3.new(1,0,0)
B.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
end)