--[[
    ════════════════════════════════════════════════════════
    BLOX FRUITS AUTO FARM - HARDCORE EDITION
    ✅ Auto Quest + Auto Kill + Bring Mob + Fast Attack
    ════════════════════════════════════════════════════════
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- ════════════════════════════════════════════════════════
--  BIẾN TOÀN CỤC
-- ════════════════════════════════════════════════════════
_G.Settings = {
    AutoFarm = false,
    AutoBoss = false,
    FastAttack = false,
    BringMob = false,
    AutoHaki = false,
    SafeMode = true,
    FarmDistance = 25,
    BringDistance = 350,  -- Khoảng cách gom quái
    SelectedWeapon = "Melee"
}

local QuestData = {
    CurrentQuest = nil,
    QuestLevel = nil,
    MobName = nil
}

local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Update Character khi respawn
Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

-- ════════════════════════════════════════════════════════
--  ANTI AFK
-- ════════════════════════════════════════════════════════
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- ════════════════════════════════════════════════════════
--  HÀM TIỆN ÍCH
-- ════════════════════════════════════════════════════════
local function Notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 3
    })
end

local function Tween(destination, speed)
    if not Character or not HumanoidRootPart then return end
    
    local distance = (HumanoidRootPart.Position - destination).Magnitude
    local tweenSpeed = speed or 300
    local time = distance / tweenSpeed
    
    local tween = TweenService:Create(
        HumanoidRootPart,
        TweenInfo.new(time, Enum.EasingStyle.Linear),
        {CFrame = CFrame.new(destination)}
    )
    tween:Play()
    return tween
end

local function EquipWeapon(weaponName)
    if not Character then return end
    
    local weapon = Player.Backpack:FindFirstChild(weaponName) or Character:FindFirstChild(weaponName)
    if weapon and weapon.Parent == Player.Backpack then
        Humanoid:EquipTool(weapon)
        wait(0.3)
    end
end

local function AutoHaki()
    if not _G.Settings.AutoHaki then return end
    if not Character:FindFirstChild("HasBuso") then
        local args = {[1] = "Buso"}
        ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
    end
end

-- ════════════════════════════════════════════════════════
--  FAST ATTACK - HARDCORE VERSION
-- ════════════════════════════════════════════════════════
local CombatFramework = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework)
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigController = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.RigController)
local RigControllerR = getupvalues(RigController)[2]
local realbhit = require(game.ReplicatedStorage.CombatFramework.RigLib)
local cooldownfastattack = tick()

function GetCurrentBlade() 
    local p13 = CombatFrameworkR.activeController
    local ret = p13.blades[1]
    if not ret then return end
    while ret.Parent ~= game.Players.LocalPlayer.Character do ret = ret.Parent end
    return ret
end

function AttackNoCD()
    if not _G.Settings.FastAttack then return end
    
    local AC = CombatFrameworkR.activeController
    if AC and AC.equipped then
        for i = 1, 1 do
            local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
                Player.Character,
                {Player.Character.HumanoidRootPart},
                60
            )
            local cac = {}
            local hash = {}
            for k, v in pairs(bladehit) do
                if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                    table.insert(cac, v.Parent.HumanoidRootPart)
                    hash[v.Parent] = true
                end
            end
            bladehit = cac
            if #bladehit > 0 then
                pcall(function()
                    AC:attack()
                end)
            end
        end
    end
end

-- ════════════════════════════════════════════════════════
--  BRING MOB - GOM QUÁI
-- ════════════════════════════════════════════════════════
function BringMobs(mobName)
    if not _G.Settings.BringMob then return end
    if not Character or not HumanoidRootPart then return end
    
    pcall(function()
        for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
            if v.Name == mobName and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                if v.Humanoid.Health > 0 then
                    local distance = (v.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
                    
                    if distance <= _G.Settings.BringDistance then
                        -- Tắt hitbox collision
                        v.Humanoid.WalkSpeed = 0
                        v.Humanoid.JumpPower = 0
                        v.HumanoidRootPart.CanCollide = false
                        v.Head.CanCollide = false
                        
                        -- Tắt animation
                        if v.Humanoid:FindFirstChild("Animator") then
                            v.Humanoid.Animator:Destroy()
                        end
                        
                        -- Di chuyển quái về vị trí farm
                        v.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -_G.Settings.FarmDistance)
                        v.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                        v.HumanoidRootPart.RotVelocity = Vector3.new(0, 0, 0)
                        
                        -- Giữ quái không rơi
                        sethiddenproperty(v, "NetworkOwnershipRule", "Manual")
                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                    end
                end
            end
        end
    end)
end

-- ════════════════════════════════════════════════════════
--  QUESTS BY LEVEL (ALL SEAS)
-- ════════════════════════════════════════════════════════
local QuestList = {
    -- SEA 1
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
    
    -- SEA 2
    {Level = 700, QuestName = "Area1Quest", QuestNum = 1, MobName = "Raider", QuestPos = CFrame.new(-428, 73, 1836), MobPos = CFrame.new(-746, 39, 2507)},
    {Level = 775, QuestName = "Area2Quest", QuestNum = 1, MobName = "Swan Pirate", QuestPos = CFrame.new(935, 126, 1225), MobPos = CFrame.new(878, 122, 1235)},
    {Level = 850, QuestName = "MarineQuest3", QuestNum = 1, MobName = "Marine Commodore", QuestPos = CFrame.new(-2851, 73, -3191), MobPos = CFrame.new(-2890, 74, -3696)},
    {Level = 950, QuestName = "ZombieQuest", QuestNum = 1, MobName = "Zombie", QuestPos = CFrame.new(-5736, 127, -862), MobPos = CFrame.new(-5657, 78, -928)},
    {Level = 1100, QuestName = "SkyExp1Quest", QuestNum = 1, MobName = "Shanda", QuestPos = CFrame.new(-7863, 5546, -379), MobPos = CFrame.new(-7685, 5567, -446)},
    {Level = 1250, QuestName = "IceSideQuest", QuestNum = 1, MobName = "Yeti", QuestPos = CFrame.new(1350, 105, -1319), MobPos = CFrame.new(1219, 138, -1488)},
    {Level = 1425, QuestName = "FireSideQuest", QuestNum = 1, MobName = "Lava Pirate", QuestPos = CFrame.new(-5237, 9, -4363), MobPos = CFrame.new(-5449, 16, -4800)},
    
    -- SEA 3
    {Level = 1575, QuestName = "PiratePortQuest", QuestNum = 1, MobName = "Pirate Millionaire", QuestPos = CFrame.new(-289, 43, 5580), MobPos = CFrame.new(-435, 189, 5551)},
    {Level = 1700, QuestName = "ForestQuest", QuestNum = 1, MobName = "Dragon Crew Warrior", QuestPos = CFrame.new(-12555, 332, -7445), MobPos = CFrame.new(-12525, 392, -7517)},
    {Level = 1850, QuestName = "DeepForestIsland", QuestNum = 1, MobName = "Female Islander", QuestPos = CFrame.new(5543, 602, -253), MobPos = CFrame.new(5616, 845, 149)},
    {Level = 2050, QuestName = "FrostQuest", QuestNum = 1, MobName = "Marine Rear Admiral", QuestPos = CFrame.new(-14545, 16, -7250), MobPos = CFrame.new(-14353, 73, -7131)},
    {Level = 2200, QuestName = "IceCreamQuest", QuestNum = 1, MobName = "Cake Guard", QuestPos = CFrame.new(-821, 66, -10965), MobPos = CFrame.new(-890, 125, -10965)},
    {Level = 2375, QuestName = "CakeQuest2", QuestNum = 1, MobName = "Cocoa Warrior", QuestPos = CFrame.new(-12191, 326, -10842), MobPos = CFrame.new(-12404, 333, -10839)},
}

-- ════════════════════════════════════════════════════════
--  TÌM QUEST PHÙ HỢP
-- ════════════════════════════════════════════════════════
local function GetQuestByLevel()
    local playerLevel = Player.Data.Level.Value
    local selectedQuest = QuestList[1]
    
    for _, quest in pairs(QuestList) do
        if playerLevel >= quest.Level then
            selectedQuest = quest
        else
            break
        end
    end
    
    return selectedQuest
end

-- ════════════════════════════════════════════════════════
--  AUTO NHẬN QUEST
-- ════════════════════════════════════════════════════════
local function TakeQuest()
    local quest = GetQuestByLevel()
    if not quest then return false end
    
    -- Teleport đến NPC quest
    HumanoidRootPart.CFrame = quest.QuestPos
    wait(0.5)
    
    -- Nhận quest
    local args = {
        [1] = "StartQuest",
        [2] = quest.QuestName,
        [3] = quest.QuestNum
    }
    
    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
    QuestData.CurrentQuest = quest
    
    wait(0.3)
    return true
end

-- ════════════════════════════════════════════════════════
--  KIỂM TRA QUEST
-- ════════════════════════════════════════════════════════
local function CheckQuest()
    local MyLevel = Player.Data.Level.Value
    local Quest = GetQuestByLevel()
    
    if Player.PlayerGui.Main.Quest.Visible then
        local QuestTitle = Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
        if not string.find(QuestTitle, Quest.MobName) then
            Player.PlayerGui.Main.Quest.Visible = false
            return false
        end
        return true
    else
        return false
    end
end

-- ════════════════════════════════════════════════════════
--  FARM LOOP
-- ════════════════════════════════════════════════════════
spawn(function()
    while wait() do
        if _G.Settings.AutoFarm then
            pcall(function()
                -- Kiểm tra quest
                if not CheckQuest() then
                    TakeQuest()
                    wait(1)
                end
                
                local Quest = GetQuestByLevel()
                if not Quest then return end
                
                -- Tìm quái
                local foundMob = false
                for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v.Name == Quest.MobName and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                        if v.Humanoid.Health > 0 then
                            foundMob = true
                            
                            -- Bring tất cả quái về
                            BringMobs(Quest.MobName)
                            
                            -- Bay lơ lửng phía trên quái
                            repeat
                                wait()
                                if not _G.Settings.AutoFarm then break end
                                if not v or v.Humanoid.Health <= 0 then break end
                                
                                AutoHaki()
                                EquipWeapon(_G.Settings.SelectedWeapon)
                                
                                -- Vị trí farm (trên đầu quái)
                                local farmPos = v.HumanoidRootPart.CFrame * CFrame.new(0, _G.Settings.FarmDistance, 0)
                                HumanoidRootPart.CFrame = farmPos
                                
                                -- Fast attack
                                AttackNoCD()
                                
                                -- Đánh thường
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                
                            until not _G.Settings.AutoFarm or v.Humanoid.Health <= 0
                            
                            break
                        end
                    end
                end
                
                -- Nếu không có quái, teleport về spawn point
                if not foundMob then
                    if Quest.MobPos then
                        Tween(Quest.MobPos.Position, 300)
                        wait(2)
                    end
                end
            end)
        end
    end
end)

-- ════════════════════════════════════════════════════════
--  LOOP FAST ATTACK
-- ════════════════════════════════════════════════════════
spawn(function()
    while wait() do
        pcall(function()
            if _G.Settings.FastAttack then
                AttackNoCD()
            end
        end)
    end
end)

-- ════════════════════════════════════════════════════════
--  TẠO GUI
-- ════════════════════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")

ScreenGui.Name = "AutoFarmGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.02, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 550)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ AUTO FARM BLOX FRUITS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Minimize Button
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Parent = MainFrame
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Position = UDim2.new(1, -40, 0, 5)
MinimizeBtn.Size = UDim2.new(0, 35, 0, 35)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeBtn.TextSize = 20

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizeBtn

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        ScrollFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 350, 0, 50)
        MinimizeBtn.Text = "+"
    else
        ScrollFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 350, 0, 550)
        MinimizeBtn.Text = "-"
    end
end)

ScrollFrame.Parent = MainFrame
ScrollFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.Position = UDim2.new(0, 10, 0, 55)
ScrollFrame.Size = UDim2.new(1, -20, 1, -65)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 4

UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- ════════════════════════════════════════════════════════
--  HÀM TẠO TOGGLE
-- ════════════════════════════════════════════════════════
local function CreateToggle(name, settingName, callback)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Parent = ScrollFrame
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(1, -10, 0, 45)
    Button.Font = Enum.Font.Gotham
    Button.Text = "❌ " .. name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 13
    Button.TextXAlignment = Enum.TextXAlignment.Left
    
    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 10)
    Padding.Parent = Button
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        _G.Settings[settingName] = not _G.Settings[settingName]
        
        if _G.Settings[settingName] then
            Button.BackgroundColor3 = Color3.fromRGB(85, 255, 127)
            Button.Text = "✅ " .. name
        else
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            Button.Text = "❌ " .. name
        end
        
        if callback then callback(_G.Settings[settingName]) end
    end)
    
    return Button
end

-- ════════════════════════════════════════════════════════
--  TẠO CÁC NÚT
-- ════════════════════════════════════════════════════════
CreateToggle("Auto Farm Level", "AutoFarm", function(state)
    if state then
        Notify("🚀 AUTO FARM", "Đã bật Auto Farm!", 3)
    else
        Notify("⏸️ AUTO FARM", "Đã tắt Auto Farm!", 3)
    end
end)

CreateToggle("Fast Attack", "FastAttack")
CreateToggle("Bring Mob", "BringMob")
CreateToggle("Auto Haki", "AutoHaki")
CreateToggle("Safe Mode", "SafeMode")

-- Info Label
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = ScrollFrame
InfoLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
InfoLabel.BorderSizePixel = 0
InfoLabel.Size = UDim2.new(1, -10, 0, 80)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Text = "📊 THÔNG TIN\nLevel: 0\nQuest: None"
InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoLabel.TextSize = 12
InfoLabel.TextWrapped = true
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top

local InfoPadding = Instance.new("UIPadding")
InfoPadding.PaddingLeft = UDim.new(0, 10)
InfoPadding.PaddingTop = UDim.new(0, 10)
InfoPadding.Parent = InfoLabel

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 8)
InfoCorner.Parent = InfoLabel

-- Update info
spawn(function()
    while wait(1) do
        if Player and Player.Data and Player.Data.Level then
            local quest = GetQuestByLevel()
            InfoLabel.Text = string.format(
                "📊 THÔNG TIN\nLevel: %d\nQuest: %s\nMob: %s",
                Player.Data.Level.Value,
                quest and quest.QuestName or "None",
                quest and quest.MobName or "None"
            )
        end
    end
end)

-- Auto-resize canvas
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)

-- ════════════════════════════════════════════════════════
--  THÔNG BÁO KHỞI ĐỘNG
-- ════════════════════════════════════════════════════════
Notify("⚡ AUTO FARM", "Script loaded thành công!", 5)
Notify("📊 LEVEL", "Level: " .. Player.Data.Level.Value, 3)
print("✅ Auto Farm loaded - Hardcore Edition!")