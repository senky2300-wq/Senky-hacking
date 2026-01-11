
--[[
    ████████╗██╗  ██╗███████╗    ██╗   ██╗██╗  ████████╗██╗███╗   ███╗ █████╗ ████████╗███████╗
    ╚══██╔══╝██║  ██║██╔════╝    ██║   ██║██║  ╚══██╔══╝██║████╗ ████║██╔══██╗╚══██╔══╝██╔════╝
       ██║   ███████║█████╗      ██║   ██║██║     ██║   ██║██╔████╔██║███████║   ██║   █████╗  
       ██║   ██╔══██║██╔══╝      ██║   ██║██║     ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██╔══╝  
       ██║   ██║  ██║███████╗    ╚██████╔╝███████╗██║   ██║██║ ╚═╝ ██║██║  ██║   ██║   ███████╗
       ╚═╝   ╚═╝  ╚═╝╚══════╝     ╚═════╝ ╚══════╝╚═╝   ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝
    
    💀 BLOX FRUITS - ULTIMATE GODMODE EDITION 💀
    ✅ Auto Farm + Bring Mob + Fast Attack + GOD MODE + No Energy Loss
    🔥 Made by: SENKY CODER - FIXED VERSION
]]

-- ════════════════════════════════════════════════════════
--  SERVICES
-- ════════════════════════════════════════════════════════
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer

-- ════════════════════════════════════════════════════════
--  ANTI KICK SYSTEM
-- ════════════════════════════════════════════════════════
local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    local Method = getnamecallmethod()
    
    -- Chặn Kick
    if Method == "Kick" then
        warn("🛡️ Đã chặn Kick!")
        return
    end
    
    -- Chặn Damage khi God Mode bật
    if _G.Settings and _G.Settings.GodMode then
        if Method == "FireServer" or Method == "InvokeServer" then
            if tostring(Self) == "RemoteEvent" or tostring(Self) == "RemoteFunction" then
                if Args[1] == "TakeDamage" or Args[1] == "Damage" then
                    return -- Chặn damage
                end
            end
        end
    end
    
    return OldNamecall(Self, ...)
end)

print("✅ Anti-Kick đã bật!")

-- ════════════════════════════════════════════════════════
--  XÁC ĐỊNH SEA HIỆN TẠI
-- ════════════════════════════════════════════════════════
local CurrentSea = 1
if game.PlaceId == 2753915549 then
    CurrentSea = 1
    print("🌊 Đang ở Sea 1 - Old World")
elseif game.PlaceId == 4442272183 then
    CurrentSea = 2
    print("🌊 Đang ở Sea 2 - New World")
elseif game.PlaceId == 7449423635 then
    CurrentSea = 3
    print("🌊 Đang ở Sea 3 - Third Sea")
else
    warn("❌ Không nhận diện được Sea! PlaceId:", game.PlaceId)
end

-- ════════════════════════════════════════════════════════
--  BIẾN TOÀN CỤC
-- ════════════════════════════════════════════════════════
_G.Settings = {
    AutoFarm = false,
    FastAttack = false,
    BringMob = false,
    AutoHaki = false,
    GodMode = false,
    NoEnergyLoss = false,
    AutoDodge = false,
    InfiniteEnergy = false,
    FarmDistance = 20,
    BringDistance = 400,
    SelectedWeapon = "Melee"
}

local Character, Humanoid, HumanoidRootPart
local BringConnection = nil

-- ════════════════════════════════════════════════════════
--  UPDATE CHARACTER
-- ════════════════════════════════════════════════════════
function UpdateCharacter()
    Character = Player.Character or Player.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end

Player.CharacterAdded:Connect(UpdateCharacter)
UpdateCharacter()

-- ════════════════════════════════════════════════════════
--  ANTI AFK
-- ════════════════════════════════════════════════════════
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- ════════════════════════════════════════════════════════
--  GOD MODE - FIXED VERSION
-- ════════════════════════════════════════════════════════
spawn(function()
    while wait(0.5) do
        if _G.Settings.GodMode and Humanoid then
            pcall(function()
                -- Set health về max
                if Humanoid.Health < Humanoid.MaxHealth then
                    Humanoid.Health = Humanoid.MaxHealth
                end
                
                -- Xóa CanCollide
                for _, part in pairs(Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                
                -- Tránh stun
                Humanoid:ChangeState(11)
            end)
        end
    end
end)

-- ════════════════════════════════════════════════════════
--  NO ENERGY LOSS
-- ════════════════════════════════════════════════════════
spawn(function()
    while wait(0.1) do
        if _G.Settings.NoEnergyLoss or _G.Settings.InfiniteEnergy then
            pcall(function()
                if Player.Character and Player.Character:FindFirstChild("Energy") then
                    local energy = Player.Character.Energy
                    energy.Value = energy.MaxValue
                end
            end)
        end
    end
end)

-- ════════════════════════════════════════════════════════
--  AUTO DODGE
-- ════════════════════════════════════════════════════════
spawn(function()
    while wait() do
        if _G.Settings.AutoDodge then
            pcall(function()
                for _, projectile in pairs(workspace:GetChildren()) do
                    if projectile:IsA("Part") and projectile.Name:find("Projectile") then
                        local distance = (projectile.Position - HumanoidRootPart.Position).Magnitude
                        if distance < 50 then
                            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, 10, 0)
                        end
                    end
                end
                
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") then
                        local distance = (enemy.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
                        if distance < 10 and enemy.Humanoid.Health > 0 then
                            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)
                        end
                    end
                end
            end)
        end
    end
end)

-- ════════════════════════════════════════════════════════
--  UTILITY FUNCTIONS
-- ════════════════════════════════════════════════════════
function Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

function Tween(destination, speed)
    if not HumanoidRootPart then return end
    
    local distance = (HumanoidRootPart.Position - destination).Magnitude
    local time = distance / (speed or 300)
    
    local tween = TweenService:Create(
        HumanoidRootPart,
        TweenInfo.new(time, Enum.EasingStyle.Linear),
        {CFrame = CFrame.new(destination)}
    )
    tween:Play()
    return tween
end

function EquipWeapon(name)
    if not Character then return end
    local tool = Player.Backpack:FindFirstChild(name) or Character:FindFirstChild(name)
    if tool and tool.Parent == Player.Backpack then
        Humanoid:EquipTool(tool)
    end
end

function AutoHaki()
    if not _G.Settings.AutoHaki then return end
    if not Character:FindFirstChild("HasBuso") then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
    end
end

-- ════════════════════════════════════════════════════════
--  FAST ATTACK - FIXED VERSION (VIRTUAL INPUT)
-- ════════════════════════════════════════════════════════
function AttackNoCD()
    if not _G.Settings.FastAttack then return end
    
    pcall(function()
        local VirtualInputManager = game:GetService("VirtualInputManager")
        local Camera = workspace.CurrentCamera
        
        VirtualInputManager:SendMouseButtonEvent(
            Camera.ViewportSize.X / 2,
            Camera.ViewportSize.Y / 2,
            0,
            true,
            game,
            1
        )
        
        wait(0.001)
        
        VirtualInputManager:SendMouseButtonEvent(
            Camera.ViewportSize.X / 2,
            Camera.ViewportSize.Y / 2,
            0,
            false,
            game,
            1
        )
    end)
end

-- ════════════════════════════════════════════════════════
--  BRING MOB - FIXED VERSION (KHÔNG DÙNG sethiddenproperty)
-- ════════════════════════════════════════════════════════
function BringMobs(mobName)
    if not _G.Settings.BringMob then 
        if BringConnection then
            BringConnection:Disconnect()
            BringConnection = nil
        end
        return 
    end
    
    if not HumanoidRootPart then return end
    
    if BringConnection then
        BringConnection:Disconnect()
    end
    
    BringConnection = RunService.Stepped:Connect(function()
        pcall(function()
            for _, v in pairs(workspace.Enemies:GetChildren()) do
                if v.Name == mobName and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                    if v.Humanoid.Health > 0 then
                        local distance = (v.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
                        
                        if distance <= _G.Settings.BringDistance then
                            v.Humanoid.WalkSpeed = 0
                            v.Humanoid.JumpPower = 0
                            
                            v.HumanoidRootPart.CanCollide = false
                            v.Head.CanCollide = false
                            if v:FindFirstChild("Torso") then
                                v.Torso.CanCollide = false
                            end
                            
                            v.HumanoidRootPart.Size = Vector3.new(70, 70, 70)
                            v.HumanoidRootPart.Transparency = 0.8
                            
                            v.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -_G.Settings.FarmDistance)
                            
                            v.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                            v.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        end
                    end
                end
            end
        end)
    end)
end

-- ════════════════════════════════════════════════════════
--  QUEST DATABASE - PHÂN CHIA THEO SEA
-- ════════════════════════════════════════════════════════
local QuestDatabase = {
    [1] = {
        {Level = 1, QuestName = "BanditQuest1", QuestNum = 1, MobName = "Bandit", QuestPos = CFrame.new(1059, 17, 1547), MobPos = CFrame.new(1199, 17, 1404)},
        {Level = 10, QuestName = "JungleQuest", QuestNum = 1, MobName = "Monkey", QuestPos = CFrame.new(-1605, 37, 152), MobPos = CFrame.new(-1448, 50, 63)},
        {Level = 15, QuestName = "BuggyQuest1", QuestNum = 1, MobName = "Pirate", QuestPos = CFrame.new(-1141, 5, 3831), MobPos = CFrame.new(-1103, 14, 3840)},
        {Level = 30, QuestName = "DesertQuest", QuestNum = 1, MobName = "Desert Bandit", QuestPos = CFrame.new(898, 7, 4390), MobPos = CFrame.new(932, 7, 4484)},
        {Level = 60, QuestName = "SnowQuest", QuestNum = 1, MobName = "Snowman", QuestPos = CFrame.new(1391, 87, -1298), MobPos = CFrame.new(1289, 105, -1427)},
        {Level = 75, QuestName = "MarineQuest2", QuestNum = 1, MobName = "Marine Captain", QuestPos = CFrame.new(-5234, 29, 4047), MobPos = CFrame.new(-5006, 73, 4283)},
        {Level = 100, QuestName = "SkyQuest", QuestNum = 1, MobName = "God's Guard", QuestPos = CFrame.new(-4722, 845, -1953), MobPos = CFrame.new(-4710, 845, -1927)},
        {Level = 150, QuestName = "AlchemistQuest", QuestNum = 1, MobName = "Prisoner", QuestPos = CFrame.new(4863, 6, 735), MobPos = CFrame.new(5411, 96, 690)},
        {Level = 190, QuestName = "ColoseumQuest", QuestNum = 1, MobName = "Gladiator", QuestPos = CFrame.new(-1427, 8, -2842), MobPos = CFrame.new(-1262, 8, -2837)},
        {Level = 250, QuestName = "MagmaQuest", QuestNum = 1, MobName = "Lava Pirate", QuestPos = CFrame.new(-5237, 9, -4363), MobPos = CFrame.new(-5449, 16, -4800)},
    },
    [2] = {
        {Level = 700, QuestName = "Area1Quest", QuestNum = 1, MobName = "Raider", QuestPos = CFrame.new(-428, 73, 1836), MobPos = CFrame.new(-746, 39, 2507)},
        {Level = 775, QuestName = "Area2Quest", QuestNum = 1, MobName = "Swan Pirate", QuestPos = CFrame.new(935, 126, 1225), MobPos = CFrame.new(878, 122, 1235)},
        {Level = 850, QuestName = "MarineQuest3", QuestNum = 1, MobName = "Marine Commodore", QuestPos = CFrame.new(-2851, 73, -3191), MobPos = CFrame.new(-2890, 74, -3696)},
        {Level = 950, QuestName = "ZombieQuest", QuestNum = 1, MobName = "Zombie", QuestPos = CFrame.new(-5736, 127, -862), MobPos = CFrame.new(-5657, 78, -928)},
        {Level = 1100, QuestName = "SkyExp1Quest", QuestNum = 1, MobName = "Shanda", QuestPos = CFrame.new(-7863, 5546, -379), MobPos = CFrame.new(-7685, 5567, -446)},
        {Level = 1250, QuestName = "IceSideQuest", QuestNum = 1, MobName = "Yeti", QuestPos = CFrame.new(1350, 105, -1319), MobPos = CFrame.new(1219, 138, -1488)},
    },
    [3] = {
        {Level = 1575, QuestName = "PiratePortQuest", QuestNum = 1, MobName = "Pirate Millionaire", QuestPos = CFrame.new(-289, 43, 5580), MobPos = CFrame.new(-435, 189, 5551)},
        {Level = 1700, QuestName = "ForestQuest", QuestNum = 1, MobName = "Dragon Crew Warrior", QuestPos = CFrame.new(-12555, 332, -7445), MobPos = CFrame.new(-12525, 392, -7517)},
        {Level = 1850, QuestName = "DeepForestIsland", QuestNum = 1, MobName = "Female Islander", QuestPos = CFrame.new(5543, 602, -253), MobPos = CFrame.new(5616, 845, 149)},
        {Level = 2050, QuestName = "FrostQuest", QuestNum = 1, MobName = "Marine Rear Admiral", QuestPos = CFrame.new(-14545, 16, -7250), MobPos = CFrame.new(-14353, 73, -7131)},
        {Level = 2200, QuestName = "IceCreamQuest", QuestNum = 1, MobName = "Cake Guard", QuestPos = CFrame.new(-821, 66, -10965), MobPos = CFrame.new(-890, 125, -10965)},
        {Level = 2375, QuestName = "CakeQuest2", QuestNum = 1, MobName = "Cocoa Warrior", QuestPos = CFrame.new(-12191, 326, -10842), MobPos = CFrame.new(-12404, 333, -10839)},
    }
}

local QuestList = QuestDatabase[CurrentSea] or QuestDatabase[1]

-- ════════════════════════════════════════════════════════
--  QUEST FUNCTIONS
-- ════════════════════════════════════════════════════════
function GetQuestByLevel()
    local level = Player.Data.Level.Value
    local quest = QuestList[1]
    for _, q in pairs(QuestList) do
        if level >= q.Level then quest = q else break end
    end
    return quest
end

function TakeQuest()
    local quest = GetQuestByLevel()
    if not quest then return end
    
    HumanoidRootPart.CFrame = quest.QuestPos
    wait(0.5)
    
    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", quest.QuestName, quest.QuestNum)
    wait(0.3)
end

function CheckQuest()
    local quest = GetQuestByLevel()
    if Player.PlayerGui.Main.Quest.Visible then
        local title = Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
        if not string.find(title, quest.MobName) then
            Player.PlayerGui.Main.Quest.Visible = false
            return false
        end
        return true
    end
    return false
end

-- ════════════════════════════════════════════════════════
--  MAIN FARM LOOP
-- ════════════════════════════════════════════════════════
spawn(function()
    while wait() do
        if _G.Settings.AutoFarm then
            pcall(function()
                if not CheckQuest() then
                    TakeQuest()
                    wait(1)
                end
                
                local quest = GetQuestByLevel()
                local foundMob = false
                
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == quest.MobName and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        foundMob = true
                        BringMobs(quest.MobName)
                        
                        repeat
                            wait()
                            if not _G.Settings.AutoFarm or v.Humanoid.Health <= 0 then break end
                            
                            AutoHaki()
                            EquipWeapon(_G.Settings.SelectedWeapon)
                            
                            HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, _G.Settings.FarmDistance, 0)
                            AttackNoCD()
                            
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                        until not _G.Settings.AutoFarm or v.Humanoid.Health <= 0
                        
                        break
                    end
                end
                
                if not foundMob then
                    Tween(quest.MobPos.Position, 300)
                    wait(2)
                end
            end)
        end
    end
end)

-- ════════════════════════════════════════════════════════
--  FAST ATTACK LOOP
-- ════════════════════════════════════════════════════════
spawn(function()
    while wait(0.05) do
        if _G.Settings.FastAttack then
            AttackNoCD()
        end
    end
end)

-- ════════════════════════════════════════════════════════
--  GUI
-- ════════════════════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "GodModeGUI"
ScreenGui.Parent = game.CoreGui

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.Position = UDim2.new(0.02, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 360, 0, 600)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "💀 GODMODE EDITION"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 18

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = Title

ScrollFrame.Parent = MainFrame
ScrollFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ScrollFrame.Position = UDim2.new(0, 10, 0, 60)
ScrollFrame.Size = UDim2.new(1, -20, 1, -70)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 4

UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 10)

function CreateToggle(name, setting)
    local Button = Instance.new("TextButton")
    Button.Parent = ScrollFrame
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Button.Size = UDim2.new(1, -10, 0, 50)
    Button.Font = Enum.Font.Gotham
    Button.Text = "❌ " .. name
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.TextSize = 14
    Button.TextXAlignment = Enum.TextXAlignment.Left
    
    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 15)
    Padding.Parent = Button
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        _G.Settings[setting] = not _G.Settings[setting]
        if _G.Settings[setting] then
            Button.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
            Button.Text = "✅ " .. name
        else
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            Button.Text = "❌ " .. name
        end
    end)
end

CreateToggle("Auto Farm Level", "AutoFarm")
CreateToggle("Fast Attack", "FastAttack")
CreateToggle("Bring Mob", "BringMob")
CreateToggle("Auto Haki", "AutoHaki")
CreateToggle("🛡️ GOD MODE", "GodMode")
CreateToggle("⚡ No Energy Loss", "NoEnergyLoss")
CreateToggle("🌀 Auto Dodge", "AutoDodge")
CreateToggle("♾️ Infinite Energy", "InfiniteEnergy")

ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)

Notify("💀 GODMODE", "Ultimate Script Loaded!")
print("✅ Godmode Edition - Senky Coder [FIXED]")