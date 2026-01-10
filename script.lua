local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "CHIẾN THẦN BÓNG ĐÊM - BLOX FRUITS",
    SubTitle = "by Dark Side Partner",
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
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
}

local Config = {
    AutoFarm = false,
    BringMob = false,
    FastAttack = false,
    GodMode = false,
    NoCooldown = false,
    InfiniteJump = false,
    WalkOnWater = false,
    AutoStats = false,
    SelectedStat = "Melee",
    FruitSniper = false
}

local Quests = {
    [1] = {
        {Level = 0, Name = "Bandit", QuestName = "BanditQuest1", Pos = Vector3.new(1059, 15, 1550)},
        {Level = 10, Name = "Monkey", QuestName = "JungleQuest", Pos = Vector3.new(-1598, 37, 153)},
        {Level = 15, Name = "Gorilla", QuestName = "JungleQuest", Pos = Vector3.new(-1204, 51, -452)}
    },
    [2] = {
        {Level = 700, Name = "Raider", QuestName = "Area1Quest", Pos = Vector3.new(-424, 73, 1836)},
        {Level = 725, Name = "Mercenary", QuestName = "Area1Quest", Pos = Vector3.new(-795, 73, 1554)}
    },
    [3] = {
        {Level = 1500, Name = "Pirate Millionaire", QuestName = "FloatingTurtleQuest1", Pos = Vector3.new(-11489, 4, 3830)}
    }
}

function GetQuest()
    local myLevel = game.Players.LocalPlayer.Data.Level.Value
    local currentSea = 1
    if game.PlaceId == 4442245229 then currentSea = 2 elseif game.PlaceId == 7449925010 then currentSea = 3 end
    local selectedQuest = nil
    for _, q in pairs(Quests[currentSea]) do
        if myLevel >= q.Level then selectedQuest = q end
    end
    return selectedQuest
end

task.spawn(function()
    while task.wait() do
        pcall(function()
            if Config.AutoFarm then
                local quest = GetQuest()
                if quest then
                    if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", quest.QuestName, 1)
                    end
                    for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == quest.Name and v:FindFirstChild("HumanoidRootPart") then
                            repeat
                                task.wait()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0)
                                if Config.BringMob then
                                    for _, mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                        if mob.Name == quest.Name then
                                            mob.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                            mob.HumanoidRootPart.CanCollide = false
                                        end
                                    end
                                end
                            until not Config.AutoFarm or v.Humanoid.Health <= 0
                        end
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        pcall(function()
            if Config.FastAttack then
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(851, 158), game.Workspace.CurrentCamera.CFrame)
            end
        end)
    end)
end)

task.spawn(function()
    while task.wait() do
        if Config.GodMode then
            pcall(function()
                game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                        if v:IsA("BasePart") then v.CanTouch = false end
                    end
                end
            end)
        end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if Config.InfiniteJump then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

Tabs.Main:AddToggle("AutoFarm", {Title = "Auto Farm Level", Default = false}):OnChanged(function(Value) Config.AutoFarm = Value end)
Tabs.Main:AddToggle("BringMob", {Title = "Bring Mob", Default = false}):OnChanged(function(Value) Config.BringMob = Value end)
Tabs.Main:AddToggle("FastAttack", {Title = "Fast Attack (No Delay)", Default = false}):OnChanged(function(Value) Config.FastAttack = Value end)

Tabs.Combat:AddToggle("GodMode", {Title = "God Mode", Default = false}):OnChanged(function(Value) Config.GodMode = Value end)
Tabs.Combat:AddToggle("NoCooldown", {Title = "No Cooldown Skill", Default = false}):OnChanged(function(Value) Config.NoCooldown = Value end)

Tabs.Stats:AddDropdown("StatSelect", {
    Title = "Select Stat",
    Values = {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"},
    Default = "Melee",
    Callback = function(Value) Config.SelectedStat = Value end
})
Tabs.Stats:AddToggle("AutoStats", {Title = "Auto Stats", Default = false}):OnChanged(function(Value) Config.AutoStats = Value end)

Tabs.Misc:AddButton({
    Title = "Server Hop",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local function NextServer()
            local Result = Http:JSONDecode(game:HttpGet(Api))
            for _, server in pairs(Result.data) do
                if server.playing < server.maxPlayers then
                    TPS:TeleportToPlaceInstance(game.PlaceId, server.id)
                    break
                end
            end
        end
        NextServer()
    end
})

Window:SelectTab(1)