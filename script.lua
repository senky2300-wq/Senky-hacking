# 🔥 BLOX FRUITS - BANANA HUB PREMIUM EDITION (FULL CODE)

```lua
--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║  ██████╗ ██╗      ██████╗ ██╗  ██╗    ███████╗██████╗ ██╗   ██╗██╗████████╗███████╗  ║
    ║  ██╔══██╗██║     ██╔═══██╗╚██╗██╔╝    ██╔════╝██╔══██╗██║   ██║██║╚══██╔══╝██╔════╝  ║
    ║  ██████╔╝██║     ██║   ██║ ╚███╔╝     █████╗  ██████╔╝██║   ██║██║   ██║   ███████╗  ║
    ║  ██╔══██╗██║     ██║   ██║ ██╔██╗     ██╔══╝  ██╔══██╗██║   ██║██║   ██║   ╚════██║  ║
    ║  ██████╔╝███████╗╚██████╔╝██╔╝ ██╗    ██║     ██║  ██║╚██████╔╝██║   ██║   ███████║  ║
    ║  ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝   ╚═╝   ╚══════╝  ║
    ║                                                                                        ║
    ║              🍌 BANANA HUB - PREMIUM EDITION 🍌                                       ║
    ║              Made by: SENKY CODER | Version: 2.0                                      ║
    ╚══════════════════════════════════════════════════════════════╝
]]

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- ════════════════════════════════════════════════════════
--  🎬 INTRO ANIMATION
-- ════════════════════════════════════════════════════════
local IntroGui = Instance.new("ScreenGui")
IntroGui.Name = "IntroAnimation"
IntroGui.Parent = game.CoreGui

local IntroFrame = Instance.new("Frame")
IntroFrame.Parent = IntroGui
IntroFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
IntroFrame.BorderSizePixel = 0
IntroFrame.Size = UDim2.new(1, 0, 1, 0)

local IntroLogo = Instance.new("ImageLabel")
IntroLogo.Parent = IntroFrame
IntroLogo.BackgroundTransparency = 1
IntroLogo.Position = UDim2.new(0.5, -100, 0.5, -100)
IntroLogo.Size = UDim2.new(0, 0, 0, 0)
IntroLogo.Image = "rbxassetid://11419729917"
IntroLogo.ImageTransparency = 1

local IntroTitle = Instance.new("TextLabel")
IntroTitle.Parent = IntroFrame
IntroTitle.BackgroundTransparency = 1
IntroTitle.Position = UDim2.new(0.5, 0, 0.6, 0)
IntroTitle.Size = UDim2.new(0, 400, 0, 50)
IntroTitle.AnchorPoint = Vector2.new(0.5, 0.5)
IntroTitle.Font = Enum.Font.GothamBold
IntroTitle.Text = "🍌 BANANA HUB PREMIUM"
IntroTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
IntroTitle.TextSize = 35
IntroTitle.TextTransparency = 1

local IntroSubtitle = Instance.new("TextLabel")
IntroSubtitle.Parent = IntroFrame
IntroSubtitle.BackgroundTransparency = 1
IntroSubtitle.Position = UDim2.new(0.5, 0, 0.68, 0)
IntroSubtitle.Size = UDim2.new(0, 400, 0, 30)
IntroSubtitle.AnchorPoint = Vector2.new(0.5, 0.5)
IntroSubtitle.Font = Enum.Font.Gotham
IntroSubtitle.Text = "🔥 Ultimate Edition - Made by SENKY CODER 🔥"
IntroSubtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroSubtitle.TextSize = 16
IntroSubtitle.TextTransparency = 1

local LoadingBar = Instance.new("Frame")
LoadingBar.Parent = IntroFrame
LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
LoadingBar.BorderSizePixel = 0
LoadingBar.Position = UDim2.new(0.5, -150, 0.75, 0)
LoadingBar.Size = UDim2.new(0, 0, 0, 4)
LoadingBar.AnchorPoint = Vector2.new(0, 0.5)

local LoadingBarBG = Instance.new("Frame")
LoadingBarBG.Parent = IntroFrame
LoadingBarBG.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
LoadingBarBG.BorderSizePixel = 0
LoadingBarBG.Position = UDim2.new(0.5, -150, 0.75, 0)
LoadingBarBG.Size = UDim2.new(0, 300, 0, 4)
LoadingBarBG.AnchorPoint = Vector2.new(0, 0.5)

local UICorner1 = Instance.new("UICorner")
UICorner1.CornerRadius = UDim.new(1, 0)
UICorner1.Parent = LoadingBar

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(1, 0)
UICorner2.Parent = LoadingBarBG

spawn(function()
    TweenService:Create(IntroLogo, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 200, 0, 200),
        ImageTransparency = 0
    }):Play()
    
    wait(0.3)
    TweenService:Create(IntroTitle, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
    wait(0.2)
    TweenService:Create(IntroSubtitle, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
    wait(0.5)
    
    TweenService:Create(LoadingBar, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 300, 0, 4)
    }):Play()
    
    wait(1.8)
    
    TweenService:Create(IntroFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(IntroLogo, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
    TweenService:Create(IntroTitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(IntroSubtitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(LoadingBar, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadingBarBG, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    
    wait(0.6)
    IntroGui:Destroy()
end)

-- ════════════════════════════════════════════════════════
--  🛡️ ANTI KICK
-- ════════════════════════════════════════════════════════
local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Method = getnamecallmethod()
    if Method == "Kick" then return end
    return OldNamecall(Self, ...)
end)

-- ════════════════════════════════════════════════════════
--  🌊 SEA DETECTION
-- ════════════════════════════════════════════════════════
local CurrentSea = 1
if game.PlaceId == 4442272183 then 
    CurrentSea = 2
elseif game.PlaceId == 7449423635 then 
    CurrentSea = 3 
end

-- ════════════════════════════════════════════════════════
--  ⚙️ SETTINGS
-- ════════════════════════════════════════════════════════
_G.Settings = {
    AutoFarm = false,
    FastAttack = false,
    BringMob = false,
    AutoHaki = false,
    GodMode = false,
    NoEnergyLoss = false,
    FarmDistance = 15,
    BringDistance = 350,
    SelectedWeapon = "Melee"
}

local Character, Humanoid, HumanoidRootPart

function UpdateCharacter()
    Character = Player.Character or Player.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end

Player.CharacterAdded:Connect(UpdateCharacter)
UpdateCharacter()

Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- ════════════════════════════════════════════════════════
--  ⚡ ULTRA FAST ATTACK
-- ════════════════════════════════════════════════════════
local CombatFramework = require(Player.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigLib = require(ReplicatedStorage.CombatFramework.RigLib)

function AttackNoCD()
    if not _G.Settings.FastAttack then return end
    
    pcall(function()
        local AC = CombatFrameworkR.activeController
        if AC and AC.equipped then
            for _ = 1, 1 do
                local bladehit = RigLib.getBladeHits(Player.Character, {Player.Character.HumanoidRootPart}, 60)
                local cac = {}
                local hash = {}
                
                for _, v in pairs(bladehit) do
                    if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                        table.insert(cac, v.Parent.HumanoidRootPart)
                        hash[v.Parent] = true
                    end
                end
                
                bladehit = cac
                if #bladehit > 0 then
                    local u8 = debug.getupvalue(AC.attack, 5)
                    local u9 = debug.getupvalue(AC.attack, 6)
                    local u7 = debug.getupvalue(AC.attack, 4)
                    local u10 = debug.getupvalue(AC.attack, 7)
                    local u12 = (u8 * 798405 + u7 * 727595) % u9
                    local u13 = u7 * 798405
                    
                    u12 = (u12 * u9 + u13) % 1099511627776
                    u8 = math.floor(u12 / u9)
                    u7 = u12 - u8 * u9
                    u10 = u10 + 1
                    
                    debug.setupvalue(AC.attack, 5, u8)
                    debug.setupvalue(AC.attack, 6, u9)
                    debug.setupvalue(AC.attack, 4, u7)
                    debug.setupvalue(AC.attack, 7, u10)
                    
                    if Player.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then
                        AC.animator.anims.basic[1]:Play(0.01, 0.01, 0.01)
                        ReplicatedStorage.RigControllerEvent:FireServer("weaponChange", tostring(AC.blades[1].Parent.Name))
                        ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
                        ReplicatedStorage.RigControllerEvent:FireServer("hit", bladehit, 2, "")
                    end
                end
            end
        end
    end)
end

RunService.RenderStepped:Connect(function()
    pcall(AttackNoCD)
end)

-- ════════════════════════════════════════════════════════
--  🌀 BRING MOB
-- ════════════════════════════════════════════════════════
local BringConnection

function BringMobs(mobName)
    if BringConnection then BringConnection:Disconnect() end
    if not _G.Settings.BringMob or not HumanoidRootPart then return end
    
    BringConnection = RunService.Heartbeat:Connect(function()
        pcall(function()
            for _, v in pairs(workspace.Enemies:GetChildren()) do
                if v.Name == mobName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                    local dist = (v.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
                    if dist <= _G.Settings.BringDistance then
                        v.Humanoid.WalkSpeed = 0
                        v.Humanoid.JumpPower = 0
                        v.HumanoidRootPart.CanCollide = false
                        v.Head.CanCollide = false
                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                        v.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -_G.Settings.FarmDistance)
                        v.HumanoidRootPart.Velocity = Vector3.zero
                        v.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                    end
                end
            end
        end)
    end)
end

-- ════════════════════════════════════════════════════════
--  🛡️ GOD MODE
-- ════════════════════════════════════════════════════════
spawn(function()
    while wait(0.3) do
        if _G.Settings.GodMode and Humanoid then
            pcall(function()
                Humanoid.Health = Humanoid.MaxHealth
                for _, v in pairs(Character:GetChildren()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end)
        end
    end
end)

-- ════════════════════════════════════════════════════════
--  ⚡ NO ENERGY LOSS
-- ════════════════════════════════════════════════════════
spawn(function()
    while wait(0.1) do
        if _G.Settings.NoEnergyLoss and Player.Character:FindFirstChild("Energy") then
            pcall(function()
                Player.Character.Energy.Value = Player.Character.Energy.MaxValue
            end)
        end
    end
end)

-- ════════════════════════════════════════════════════════
--  📋 QUEST DATABASE
-- ════════════════════════════════════════════════════════
local QuestDB = {
    [1] = {
        {Level=1, Quest="BanditQuest1", Num=1, Mob="Bandit", QPos=CFrame.new(1059,17,1547), MPos=CFrame.new(1199,17,1404)},
        {Level=10, Quest="JungleQuest", Num=1, Mob="Monkey", QPos=CFrame.new(-1605,37,152), MPos=CFrame.new(-1448,50,63)},
        {Level=15, Quest="BuggyQuest1", Num=1, Mob="Pirate", QPos=CFrame.new(-1141,5,3831), MPos=CFrame.new(-1103,14,3840)},
        {Level=30, Quest="DesertQuest", Num=1, Mob="Desert Bandit", QPos=CFrame.new(898,7,4390), MPos=CFrame.new(932,7,4484)},
        {Level=60, Quest="SnowQuest", Num=1, Mob="Snowman", QPos=CFrame.new(1391,87,-1298), MPos=CFrame.new(1289,105,-1427)},
        {Level=100, Quest="SkyQuest", Num=1, Mob="God's Guard", QPos=CFrame.new(-4722,845,-1953), MPos=CFrame.new(-4710,845,-1927)},
        {Level=150, Quest="AlchemistQuest", Num=1, Mob="Prisoner", QPos=CFrame.new(4863,6,735), MPos=CFrame.new(5411,96,690)},
    },
    [2] = {
        {Level=700, Quest="Area1Quest", Num=1, Mob="Raider", QPos=CFrame.new(-428,73,1836), MPos=CFrame.new(-746,39,2507)},
        {Level=850, Quest="MarineQuest3", Num=1, Mob="Marine Commodore", QPos=CFrame.new(-2851,73,-3191), MPos=CFrame.new(-2890,74,-3696)},
        {Level=950, Quest="ZombieQuest", Num=1, Mob="Zombie", QPos=CFrame.new(-5736,127,-862), MPos=CFrame.new(-5657,78,-928)},
    },
    [3] = {
        {Level=1500, Quest="PiratePortQuest", Num=1, Mob="Pirate Millionaire", QPos=CFrame.new(-289,43,5580), MPos=CFrame.new(-435,189,5551)},
        {Level=1700, Quest="ForestQuest", Num=1, Mob="Dragon Crew Warrior", QPos=CFrame.new(-12555,332,-7445), MPos=CFrame.new(-12525,392,-7517)},
    }
}

local QuestList = QuestDB[CurrentSea] or QuestDB[1]

function GetQuest()
    local lvl = Player.Data.Level.Value
    local q = QuestList[1]
    for _, v in pairs(QuestList) do
        if lvl >= v.Level then q = v else break end
    end
    return q
end

function TakeQuest()
    local q = GetQuest()
    HumanoidRootPart.CFrame = q.QPos
    wait(0.5)
    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q.Quest, q.Num)
    wait(0.3)
end

function CheckQuest()
    local q = GetQuest()
    if Player.PlayerGui.Main.Quest.Visible then
        local title = Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
        if not string.find(title, q.Mob) then
            Player.PlayerGui.Main.Quest.Visible = false
            return false
        end
        return true
    end
    return false
end

function EquipWeapon()
    local tool = Player.Backpack:FindFirstChild(_G.Settings.SelectedWeapon)
    if tool then Humanoid:EquipTool(tool) end
end

function AutoHaki()
    if not Character:FindFirstChild("HasBuso") then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
    end
end

-- ════════════════════════════════════════════════════════
--  🎯 AUTO FARM LOOP
-- ════════════════════════════════════════════════════════
spawn(function()
    while wait() do
        if _G.Settings.AutoFarm then
            pcall(function()
                if not CheckQuest() then TakeQuest() wait(1) end
                
                local q = GetQuest()
                local found = false
                
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == q.Mob and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        found = true
                        BringMobs(q.Mob)
                        
                        repeat
                            wait()
                            if not _G.Settings.AutoFarm or v.Humanoid.Health <= 0 then break end
                            
                            if _G.Settings.AutoHaki then AutoHaki() end
                            EquipWeapon()
                            
                            HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, _G.Settings.FarmDistance, 0)
                            
                            VirtualUser:CaptureController()
                            VirtualUser:Button1Down(Vector2.new(1280, 672))
                        until not _G.Settings.AutoFarm or v.Humanoid.Health <= 0
                        break
                    end
                end
                
                if not found then
                    TweenService:Create(HumanoidRootPart, TweenInfo.new(2), {CFrame = q.MPos}):Play()
                    wait(2)
                end
            end)
        end
    end
end)

-- ════════════════════════════════════════════════════════
--  🎨 BANANA HUB GUI
-- ════════════════════════════════════════════════════════
wait(2.5)

local Gui = Instance.new("ScreenGui")
Gui.Name = "BananaHubGUI"
Gui.Parent = game.CoreGui
Gui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = Gui
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -300, 0.5, -250)
Main.Size = UDim2.new(0, 600, 0, 500)
Main.Active = true
Main.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local TopBar = Instance.new("Frame")
TopBar.Parent = Main
TopBar.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 50)

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(1, -30, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "🍌 BANANA HUB | BLOX FRUITS"
Title.TextColor3 = Color3.fromRGB(20, 20, 25)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -40, 0.5, -15)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.white
CloseBtn.TextSize = 16

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TopBar
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
MinBtn.BorderSizePixel = 0
MinBtn.Position = UDim2.new(1, -75, 0.5, -15)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(20, 20, 25)
MinBtn.TextSize = 20

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(Main, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 50)}):Play()
        MinBtn.Text = "+"
    else
        TweenService:Create(Main, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 500)}):Play()
        MinBtn.Text = "-"
    end
end)

local TabContainer = Instance.new("Frame")
TabContainer.Parent = Main
TabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TabContainer.BorderSizePixel = 0
TabContainer.Position = UDim2.new(0, 0, 0, 50)
TabContainer.Size = UDim2.new(0, 150, 1, -50)

local ContentContainer = Instance.new("Frame")
ContentContainer.Parent = Main
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 150, 0, 50)
ContentContainer.Size = UDim2.new(1, -150, 1, -50)

local TabList = Instance.new("UIListLayout")
TabList.Parent = TabContainer
TabList.Padding = UDim.new(0, 5)

function CreateTab(name, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabContainer
    TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    TabBtn.BorderSizePixel = 0
    TabBtn.Size = UDim2.new(1, 0, 0, 45)
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.Text = "  " .. icon .. "  " .. name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.TextSize = 14
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Parent = ContentContainer
    TabContent.BackgroundTransparency = 1
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.ScrollBarThickness = 4
    TabContent.Visible = false
    
    local ContentList = Instance.new("UIListLayout")
    ContentList.Parent = TabContent
    ContentList.Padding = UDim.new(0, 10)
    ContentList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    local ContentPadding = Instance.new("UIPadding")
    ContentPadding.Parent = TabContent
    ContentPadding.PaddingTop = UDim.new(0, 15)
    ContentPadding.PaddingLeft = UDim.new(0, 15)
    ContentPadding.PaddingRight = UDim.new(0, 15)
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, v in pairs(ContentContainer:GetChildren()) do
            if v:IsA("ScrollingFrame") then v.Visible = false end
        end
        for _, v in pairs(TabContainer:GetChildren()) do
            if v:IsA("TextButton") then
                v.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
                v.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
        
        TabContent.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        TabBtn.TextColor3 = Color3.fromRGB(20, 20, 25)
    end)
    
    return TabContent
end

local FarmTab = CreateTab("Auto Farm", "⚔️")
local CombatTab = CreateTab("Combat", "💥")
local MiscTab = CreateTab("Misc", "⚙️")
local InfoTab = CreateTab("Info", "📊")

FarmTab.Visible = true
for _, v in pairs(TabContainer:GetChildren()) do
    if v:IsA("TextButton") then
        v.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        v.TextColor3 = Color3.fromRGB(20, 20, 25)
        break
    end
end

-- ════════════════════════════════════════════════════════
--  🎛️ CREATE TOGGLE FUNCTION
-- ════════════════════════════════════════════════════════
function CreateToggle(parent, name, setting, callback)
    local Container = Instance.new("Frame")
    Container.Parent = parent
    Container.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Container.BorderSizePixel = 0
    Container.Size = UDim2.new(0, 400, 0, 50)
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Container
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Size = UDim2.new(1, -80, 1, 0)
    Label.Font = Enum.Font.Gotham
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Parent = Container
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
    ToggleFrame.Size = UDim2.new(0, 50, 0, 24)
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("Frame")
    ToggleButton.Parent = ToggleFrame
    ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
    ToggleButton.Size = UDim2.new(0, 20, 0, 20)
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(1, 0)
    ButtonCorner.Parent = ToggleButton
    
    local Button = Instance.new("TextButton")
    Button.Parent = Container
    Button.BackgroundTransparency = 1
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.Text = ""
    
    local enabled = _G.Settings[setting] or false
    
    local function UpdateToggle()
        if enabled then
            TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 215, 0)}):Play()
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                Position = UDim2.new(1, -22, 0.5, -10),
                BackgroundColor3 = Color3.white
            }):Play()
        else
            TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 55)}):Play()
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                Position = UDim2.new(0, 2, 0.5, -10),
                BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            }):Play()
        end
    end
    
    UpdateToggle()
    
    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        _G.Settings[setting] = enabled
        UpdateToggle()
        
        local Ripple = Instance.new("Frame")
        Ripple.Parent = Container
        Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Ripple.BackgroundTransparency = 0.5
        Ripple.BorderSizePixel = 0
        Ripple.Position = UDim2.new(0.5, -10, 0.5, -10)
        Ripple.Size = UDim2.new(0, 20, 0, 20)
        Ripple.ZIndex = 5
        
        local RippleCorner = Instance.new("UICorner")
        RippleCorner.CornerRadius = UDim.new(1, 0)
        RippleCorner.Parent = Ripple
        
        TweenService:Create(Ripple, TweenInfo.new(0.5), {
            Size = UDim2.new(0, 400, 0, 400),
            BackgroundTransparency = 1
        }):Play()
        
        spawn(function()
            wait(0.5)
            Ripple:Destroy()
        end)
        
        if callback then callback(enabled) end
    end)
    
    parent.CanvasSize = UDim2.new(0, 0, 0, parent.UIListLayout.AbsoluteContentSize.Y + 20)
end

-- ════════════════════════════════════════════════════════
--  📊 CREATE SLIDER FUNCTION
-- ════════════════════════════════════════════════════════
function CreateSlider(parent, name, setting, min, max, default)
    local Container = Instance.new("Frame")
    Container.Parent = parent
    Container.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Container.BorderSizePixel = 0
    Container.Size = UDim2.new(0, 400, 0, 70)
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Container
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 15, 0, 5)
    Label.Size = UDim2.new(1, -30, 0, 25)
    Label.Font = Enum.Font.Gotham
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Parent = Container
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Position = UDim2.new(1, -60, 0, 5)
    ValueLabel.Size = UDim2.new(0, 50, 0, 25)
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    ValueLabel.TextSize = 14
    
    local SliderBack = Instance.new("Frame")
    SliderBack.Parent = Container
    SliderBack.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    SliderBack.BorderSizePixel = 0
    SliderBack.Position = UDim2.new(0, 15, 0, 40)
    SliderBack.Size = UDim2.new(1, -30, 0, 6)
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(1, 0)
    SliderCorner.Parent = SliderBack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Parent = SliderBack
    SliderFill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    SliderFill.BorderSizePixel = 0
    SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Parent = SliderBack
    SliderButton.BackgroundTransparency = 1
    SliderButton.Size = UDim2.new(1, 0, 1, 0)
    SliderButton.Text = ""
    
    local dragging = false
    
    local function UpdateSlider(input)
        local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        
        _G.Settings[setting] = value
        ValueLabel.Text = tostring(value)
        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
    end
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            UpdateSlider(input)
        end
    end)
    
    SliderButton.MouseButton1Click:Connect(function()
        local mouse = game:GetService("Players").LocalPlayer:GetMouse()
        UpdateSlider({Position = Vector2.new(mouse.X, mouse.Y)})
    end)
    
    parent.CanvasSize = UDim2.new(0, 0, 0, parent.UIListLayout.AbsoluteContentSize.Y + 20)
end

-- ════════════════════════════════════════════════════════
--  ✨ ADD TOGGLES & SLIDERS
-- ════════════════════════════════════════════════════════

-- FARM TAB
CreateToggle(FarmTab, "🚀 Auto Farm Level", "AutoFarm", function(v)
    if v then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "🍌 BANANA HUB",
            Text = "Auto Farm đã được BẬT!",
            Duration = 3
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "🍌 BANANA HUB",
            Text = "Auto Farm đã được TẮT!",
            Duration = 3
        })
    end
end)

CreateSlider(FarmTab, "📏 Farm Distance", "FarmDistance", 10, 50, 15)
CreateSlider(FarmTab, "🌀 Bring Distance", "BringDistance", 200, 500, 350)

-- COMBAT TAB
CreateToggle(CombatTab, "⚡ Ultra Fast Attack", "FastAttack", function(v)
    if v then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "🍌 BANANA HUB",
            Text = "Fast Attack đã BẬT (Siêu Nhanh)!",
            Duration = 3
        })
    end
end)

CreateToggle(CombatTab, "🌀 Bring Mob", "BringMob")
CreateToggle(CombatTab, "💪 Auto Haki", "AutoHaki")
CreateToggle(CombatTab, "🛡️ God Mode", "GodMode")

-- MISC TAB
CreateToggle(MiscTab, "⚡ No Energy Loss", "NoEnergyLoss")

-- INFO TAB
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = InfoTab
InfoLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
InfoLabel.BorderSizePixel = 0
InfoLabel.Size = UDim2.new(0, 400, 0, 250)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Text = "📊 THÔNG TIN\n\nLevel: Loading...\nSea: " .. CurrentSea .. "\nQuest: None\nMob: None\n\n━━━━━━━━━━━━━━━━\n\n✅ Script: Banana Hub Premium\n🔥 Version: 2.0\n👤 Made by: SENKY CODER\n🌟 Status: ACTIVE"
InfoLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
InfoLabel.TextSize = 14
InfoLabel.TextWrapped = true
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 8)
InfoCorner.Parent = InfoLabel

local InfoPadding = Instance.new("UIPadding")
InfoPadding.PaddingTop = UDim.new(0, 15)
InfoPadding.PaddingLeft = UDim.new(0, 15)
InfoPadding.PaddingRight = UDim.new(0, 15)
InfoPadding.Parent = InfoLabel

-- Update Info Loop
spawn(function()
    while wait(1) do
        pcall(function()
            local q = GetQuest()
            InfoLabel.Text = string.format(
                "📊 THÔNG TIN\n\nLevel: %d\nSea: %d\nQuest: %s\nMob: %s\n\n━━━━━━━━━━━━━━━━\n\n✅ Script: Banana Hub Premium\n🔥 Version: 2.0\n👤 Made by: SENKY CODER\n🌟 Status: ACTIVE",
                Player.Data.Level.Value,
                CurrentSea,
                q.Quest or "None",
                q.Mob or "None"
            )
        end)
    end
end)

-- ════════════════════════════════════════════════════════
--  🎉 FINAL NOTIFICATION
-- ════════════════════════════════════════════════════════
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🍌 BANANA HUB PREMIUM",
    Text = "Script loaded successfully!\n🔥 Made by SENKY CODER",
    Duration = 5
})

print([[
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║       🍌 BANANA HUB - PREMIUM EDITION 🍌                 ║
║                                                           ║
║       ✅ Script loaded successfully!                     ║
║       🔥 Ultra Fast Attack: ACTIVE                       ║
║       🌀 Bring Mob: OPTIMIZED                            ║
║       🛡️ God Mode: READY                                 ║
║                                                           ║
║       ?? Version: 2.0                                     ║
║       👤 Made by: SENKY CODER                            ║
║       🌟 Sea: ]] .. CurrentSea .. [[                                              ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
]])