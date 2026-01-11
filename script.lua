--[[
    ════════════════════════════════════════════════════════
    BLOX FRUITS AUTO FARM - FULL FEATURES
    Chức năng: Auto Quest, Auto Kill, Auto Boss, Auto Mastery
    ════════════════════════════════════════════════════════
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ════════════════════════════════════════════════════════
--  BIẾN TOÀN CỤC
-- ════════════════════════════════════════════════════════
local Settings = {
    AutoFarm = false,
    AutoBoss = false,
    AutoMastery = false,
    FastAttack = false,
    BringMob = false,
    AutoHaki = false,
    SafeMode = true,
    FarmDistance = 20,
    SelectedWeapon = "Melee"
}

local QuestData = {
    CurrentQuest = nil,
    QuestLevel = nil,
    MobName = nil,
    MobPosition = nil
}

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
        Duration = duration or 5
    })
end

local function Tween(destination, speed)
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = Character.HumanoidRootPart
    local distance = (hrp.Position - destination).Magnitude
    local tweenSpeed = speed or 300
    
    local tween = game:GetService("TweenService"):Create(
        hrp,
        TweenInfo.new(distance / tweenSpeed, Enum.EasingStyle.Linear),
        {CFrame = CFrame.new(destination)}
    )
    tween:Play()
    return tween
end

local function EquipWeapon(weaponName)
    local weapon = Player.Backpack:FindFirstChild(weaponName) or Character:FindFirstChild(weaponName)
    if weapon and weapon.Parent == Player.Backpack then
        Humanoid:EquipTool(weapon)
    end
end

local function AutoHaki()
    if not Settings.AutoHaki then return end
    if not Player.Character:FindFirstChild("HasBuso") then
        local args = {[1] = "Buso"}
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
end

-- ════════════════════════════════════════════════════════
--  QUESTS BY LEVEL (SEA 1, 2, 3)
-- ════════════════════════════════════════════════════════
local QuestList = {
    -- SEA 1
    {Level = 1, QuestName = "BanditQuest1", MobName = "Bandit", Location = CFrame.new(1059, 17, 1547)},
    {Level = 10, QuestName = "JungleQuest", MobName = "Monkey", Location = CFrame.new(-1605, 37, 152)},
    {Level = 15, QuestName = "BuggyQuest1", MobName = "Pirate", Location = CFrame.new(-1141, 5, 3831)},
    {Level = 30, QuestName = "DesertQuest", MobName = "Desert Bandit", Location = CFrame.new(898, 7, 4390)},
    {Level = 60, QuestName = "SnowQuest", MobName = "Snowman", Location = CFrame.new(1391, 87, -1298)},
    {Level = 75, QuestName = "MarineQuest2", MobName = "Marine Captain", Location = CFrame.new(-5234, 29, 4047)},
    {Level = 100, QuestName = "SkyQuest", MobName = "God's Guard", Location = CFrame.new(-4722, 845, -1953)},
    {Level = 120, QuestName = "SkyQuest", MobName = "Shanda", Location = CFrame.new(-7863, 5546, -379)},
    {Level = 150, QuestName = "AlchemistQuest", MobName = "Prisoner", Location = CFrame.new(4863, 6, 735)},
    {Level = 190, QuestName = "ColoseumQuest", MobName = "Gladiator", Location = CFrame.new(-1427, 8, -2842)},
    {Level = 250, QuestName = "MagmaQuest", MobName = "Lava Pirate", Location = CFrame.new(-5237, 9, -4363)},
    {Level = 300, QuestName = "FountainQuest", MobName = "Galley Captain", Location = CFrame.new(5259, 39, 4050)},
    
    -- SEA 2
    {Level = 700, QuestName = "Area1Quest", MobName = "Raider", Location = CFrame.new(-428, 73, 1836)},
    {Level = 725, QuestName = "Area1Quest", MobName = "Mercenary", Location = CFrame.new(-973, 73, 1835)},
    {Level = 775, QuestName = "Area2Quest", MobName = "Swan Pirate", Location = CFrame.new(935, 126, 1225)},
    {Level = 850, QuestName = "Area2Quest", MobName = "Marine Commodore", Location = CFrame.new(-4915, 51, 4101)},
    {Level = 900, QuestName = "MarineQuest3", MobName = "Marine Lieutenant", Location = CFrame.new(-2851, 73, -3191)},
    {Level = 950, QuestName = "ZombieQuest", MobName = "Zombie", Location = CFrame.new(-5736, 127, -862)},
    {Level = 1000, QuestName = "FishmanQuest", MobName = "Fishman Warrior", Location = CFrame.new(61123, 19, 1569)},
    {Level = 1050, QuestName = "FishmanQuest", MobName = "Fishman Commando", Location = CFrame.new(61900, 32, 1569)},
    {Level = 1100, QuestName = "SkyExp1Quest", MobName = "God's Guard", Location = CFrame.new(-4722, 845, -1953)},
    {Level = 1200, QuestName = "SkyExp2Quest", MobName = "Shanda", Location = CFrame.new(-7863, 5546, -379)},
    {Level = 1250, QuestName = "IceSideQuest", MobName = "Yeti", Location = CFrame.new(1350, 105, -1319)},
    {Level = 1350, QuestName = "FrostQuest", MobName = "Ice Admiral", Location = CFrame.new(1350, 105, -1319)},
    {Level = 1425, QuestName = "FireSideQuest", MobName = "Lava Pirate", Location = CFrame.new(-5237, 9, -4363)},
    {Level = 1500, QuestName = "ShipQuest1", MobName = "Ship Deckhand", Location = CFrame.new(1037, 125, 32911)},
    
    -- SEA 3
    {Level = 1575, QuestName = "PiratePortQuest", MobName = "Pirate Millionaire", Location = CFrame.new(-289, 43, 5580)},
    {Level = 1625, QuestName = "PiratePortQuest", MobName = "Pistol Billionaire", Location = CFrame.new(-289, 43, 5580)},
    {Level = 1700, QuestName = "ForestQuest", MobName = "Dragon Crew Warrior", Location = CFrame.new(-12555, 332, -7445)},
    {Level = 1775, QuestName = "ForestQuest", MobName = "Dragon Crew Archer", Location = CFrame.new(-12555, 332, -7445)},
    {Level = 1850, QuestName = "DeepForestIsland", MobName = "Female Islander", Location = CFrame.new(5543, 602, -253)},
    {Level = 1900, QuestName = "DeepForestIsland2", MobName = "Giant Islander", Location = CFrame.new(5543, 602, -253)},
    {Level = 1975, QuestName = "FrostQuest", MobName = "Marine Commodore", Location = CFrame.new(-14545, 16, -7250)},
    {Level = 2050, QuestName = "FrostQuest", MobName = "Marine Rear Admiral", Location = CFrame.new(-14545, 16, -7250)},
    {Level = 2125, QuestName = "IceCreamQuest", MobName = "Cookie Crafter", Location = CFrame.new(-821, 66, -10965)},
    {Level = 2200, QuestName = "IceCreamQuest", MobName = "Cake Guard", Location = CFrame.new(-821, 66, -10965)},
    {Level = 2275, QuestName = "CakeQuest1", MobName = "Baking Staff", Location = CFrame.new(-1927, 38, -12850)},
    {Level = 2300, QuestName = "CakeQuest1", MobName = "Head Baker", Location = CFrame.new(-1927, 38, -12850)},
    {Level = 2375, QuestName = "CakeQuest2", MobName = "Cocoa Warrior", Location = CFrame.new(-12191, 326, -10842)},
    {Level = 2450, QuestName = "CakeQuest2", MobName = "Chocolate Bar Battler", Location = CFrame.new(-12191, 326, -10842)},
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
    if not quest then return end
    
    local questGiver = game:GetService("Workspace").NPCs:FindFirstChild(quest.QuestName)
    if questGiver then
        local args = {
            [1] = "StartQuest",
            [2] = quest.QuestName,
            [3] = 1
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        QuestData.CurrentQuest = quest
        return true
    end
    return false
end

-- ════════════════════════════════════════════════════════
--  TÌM VÀ ĐÁNH QUÁI
-- ════════════════════════════════════════════════════════
local function GetNearestMob()
    local quest = GetQuestByLevel()
    if not quest then return nil end
    
    local nearestMob = nil
    local shortestDistance = math.huge
    
    for _, mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if mob.Name == quest.MobName and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            local distance = (HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestMob = mob
            end
        end
    end
    
    return nearestMob
end

local function AttackMob(mob)
    if not mob or not mob:FindFirstChild("HumanoidRootPart") then return end
    
    pcall(function()
        repeat
            wait()
            if not Settings.AutoFarm then break end
            if not mob or mob.Humanoid.Health <= 0 then break end
            
            AutoHaki()
            EquipWeapon(Settings.SelectedWeapon)
            
            local mobPos = mob.HumanoidRootPart.CFrame
            HumanoidRootPart.CFrame = mobPos * CFrame.new(0, Settings.FarmDistance, 0)
            
            if Settings.FastAttack then
                local args = {[1] = mob.HumanoidRootPart}
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer(unpack(args))
            end
            
            -- Sử dụng skill fruit
            if Settings.AutoMastery then
                for i = 1, 3 do
                    local skill = Player.Character:FindFirstChild("Key"..i)
                    if skill then
                        skill:Activate()
                    end
                end
            end
            
        until not Settings.AutoFarm or mob.Humanoid.Health <= 0
    end)
end

-- ════════════════════════════════════════════════════════
--  VÒNG LẶP AUTO FARM
-- ════════════════════════════════════════════════════════
spawn(function()
    while wait() do
        if Settings.AutoFarm then
            pcall(function()
                -- Kiểm tra quest
                if not Player.PlayerGui.Main.Quest.Visible then
                    TakeQuest()
                    wait(1)
                end
                
                -- Tìm và đánh quái
                local mob = GetNearestMob()
                if mob then
                    AttackMob(mob)
                else
                    -- Teleport về vị trí spawn quái
                    local quest = GetQuestByLevel()
                    if quest and quest.Location then
                        Tween(quest.Location.Position, 300)
                        wait(2)
                    end
                end
            end)
        end
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

ScreenGui.Name = "AutoFarmGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.02, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 500)
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
--  HÀM TẠO BUTTON TOGGLE
-- ════════════════════════════════════════════════════════
local function CreateToggle(name, callback)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Parent = ScrollFrame
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(1, -10, 0, 40)
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
    
    local enabled = false
    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            Button.BackgroundColor3 = Color3.fromRGB(85, 255, 127)
            Button.Text = "✅ " .. name
        else
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            Button.Text = "❌ " .. name
        end
        callback(enabled)
    end)
    
    return Button
end

-- ════════════════════════════════════════════════════════
--  TẠO CÁC BUTTON
-- ════════════════════════════════════════════════════════
CreateToggle("Auto Farm Level", function(state)
    Settings.AutoFarm = state
    if state then
        Notify("🚀 AUTO FARM", "Đã bật Auto Farm!", 3)
    else
        Notify("⏸️ AUTO FARM", "Đã tắt Auto Farm!", 3)
    end
end)

CreateToggle("Fast Attack", function(state)
    Settings.FastAttack = state
end)

CreateToggle("Auto Haki", function(state)
    Settings.AutoHaki = state
end)

CreateToggle("Auto Mastery", function(state)
    Settings.AutoMastery = state
end)

CreateToggle("Bring Mob", function(state)
    Settings.BringMob = state
end)

CreateToggle("Safe Mode", function(state)
    Settings.SafeMode = state
end)

-- Auto-resize canvas
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)

-- ════════════════════════════════════════════════════════
--  THÔNG BÁO KHỞI ĐỘNG
-- ════════════════════════════════════════════════════════
Notify("⚡ AUTO FARM", "Script đã load thành công!", 5)
Notify("📊 LEVEL", "Level hiện tại: " .. Player.Data.Level.Value, 5)