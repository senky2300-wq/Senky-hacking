
--[[
    SENKY HUB V4.3 - SIMPLE UI (NO SCROLL)
    ✅ Bỏ ScrollingFrame - dùng Frame thuần
    ✅ Fix màn hình đen hoàn toàn
]]

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer.Character
task.wait(2)

local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")

print("🔄 Loading Senky Hub V4.3...")

-- ══════════════════════════════════════════
--     SETTINGS
-- ══════════════════════════════════════════
_G.Settings = {
    AutoFarm = false,
    AutoQuest = false,
    BringMobs = false,
    AutoRedeem = false,
    FlyHeight = 8,
    KillRadius = 25
}

_G.Codes = {
    "NOEXPLOITER",
    "THEGREATACE", 
    "SUB2GAMERROBOT_EXP1",
    "Sub2UncleKizaru",
    "SUB2FER999"
}

-- ══════════════════════════════════════════
--     DAMAGE AURA
-- ══════════════════════════════════════════
task.spawn(function()
    while task.wait(0.3) do
        if _G.Settings.AutoFarm then
            pcall(function()
                local char = LP.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                
                for _, mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 
                       and mob:FindFirstChild("HumanoidRootPart") then
                        
                        local distance = (char.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude
                        
                        if distance <= _G.Settings.KillRadius then
                            mob.Humanoid.Health = 0
                        end
                    end
                end
            end)
        end
    end
end)

-- ══════════════════════════════════════════
--     AUTO FARM
-- ══════════════════════════════════════════
task.spawn(function()
    while task.wait(0.1) do
        if _G.Settings.AutoFarm then
            pcall(function()
                local char = LP.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                
                local lv = LP.Data.Level.Value
                local qName, qNum, mName, mPos
                
                if lv >= 90 and lv < 120 then
                    qName, qNum = "SnowQuest", 2
                    mName = "Snowman"
                    mPos = CFrame.new(1389, 150, -1325)
                elseif lv >= 120 and lv < 150 then
                    qName, qNum = "MarineQuest3", 1
                    mName = "Marine Captain"
                    mPos = CFrame.new(-5200, 30, 4050)
                end
                
                if _G.Settings.AutoQuest then
                    local questGui = LP.PlayerGui:FindFirstChild("Main")
                    if questGui and questGui:FindFirstChild("Quest") and not questGui.Quest.Visible then
                        RS.Remotes.CommF_:InvokeServer("StartQuest", qName, qNum)
                    end
                end
                
                local targetMob = nil
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == mName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 
                       and v:FindFirstChild("HumanoidRootPart") then
                        targetMob = v
                        break
                    end
                end
                
                if targetMob then
                    char.HumanoidRootPart.CFrame = targetMob.HumanoidRootPart.CFrame * CFrame.new(0, _G.Settings.FlyHeight, 0)
                    
                    if _G.Settings.BringMobs then
                        for _, mob in pairs(workspace.Enemies:GetChildren()) do
                            if mob.Name == mName and mob:FindFirstChild("HumanoidRootPart") 
                               and mob.Humanoid.Health > 0 then
                                mob.HumanoidRootPart.CanCollide = false
                                mob.HumanoidRootPart.CFrame = targetMob.HumanoidRootPart.CFrame
                                mob.Humanoid.WalkSpeed = 0
                            end
                        end
                    end
                else
                    if mPos then
                        char.HumanoidRootPart.CFrame = mPos
                    end
                end
            end)
        end
    end
end)

-- ══════════════════════════════════════════
--     ANTI AFK
-- ══════════════════════════════════════════
local VirtualUser = game:GetService("VirtualUser")
LP.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- ══════════════════════════════════════════
--     CREATE UI (SIMPLE VERSION)
-- ══════════════════════════════════════════

-- Xóa UI cũ
if game.CoreGui:FindFirstChild("SenkyHub") then
    game.CoreGui:FindFirstChild("SenkyHub"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SenkyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Main Window
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Main.Position = UDim2.new(0.5, -200, 0.5, -225)
Main.Size = UDim2.new(0, 400, 0, 450)
Main.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(80, 80, 100)
MainStroke.Thickness = 2
MainStroke.Parent = Main

-- Title Bar
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BorderSizePixel = 0
Title.Font = Enum.Font.GothamBold
Title.Text = "  🍌 SENKY HUB V4.3"
Title.TextColor3 = Color3.white
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = Title

-- Close Button
local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Parent = Title
Close.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
Close.Position = UDim2.new(1, -42, 0, 10)
Close.Size = UDim2.new(0, 32, 0, 32)
Close.Font = Enum.Font.GothamBold
Close.Text = "✕"
Close.TextColor3 = Color3.white
Close.TextSize = 18
Close.BorderSizePixel = 0

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = Close

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

-- Content Container (KHÔNG SCROLL)
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Parent = Main
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 15, 0, 65)
Content.Size = UDim2.new(1, -30, 1, -80)

local Layout = Instance.new("UIListLayout")
Layout.Parent = Content
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Padding = UDim.new(0, 12)

-- ═══ CREATE TOGGLES ═══

local function CreateToggle(name, emoji, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Parent = Content
    Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    Toggle.Size = UDim2.new(1, 0, 0, 50)
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = Toggle
    
    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Color = Color3.fromRGB(60, 60, 75)
    ToggleStroke.Thickness = 1.5
    ToggleStroke.Parent = Toggle
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Toggle
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Size = UDim2.new(1, -80, 1, 0)
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = emoji.." "..name
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.TextSize = 15
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local Switch = Instance.new("Frame")
    Switch.Parent = Toggle
    Switch.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    Switch.Position = UDim2.new(1, -60, 0.5, -13)
    Switch.Size = UDim2.new(0, 50, 0, 26)
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = Switch
    
    local Circle = Instance.new("Frame")
    Circle.Parent = Switch
    Circle.BackgroundColor3 = Color3.white
    Circle.Position = UDim2.new(0, 3, 0.5, -11)
    Circle.Size = UDim2.new(0, 22, 0, 22)
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle
    
    local toggled = false
    
    local Button = Instance.new("TextButton")
    Button.Parent = Toggle
    Button.BackgroundTransparency = 1
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.Text = ""
    
    Button.MouseButton1Click:Connect(function()
        toggled = not toggled
        
        TS:Create(Switch, TweenInfo.new(0.3), {
            BackgroundColor3 = toggled and Color3.fromRGB(70, 220, 150) or Color3.fromRGB(60, 60, 75)
        }):Play()
        
        TS:Create(Circle, TweenInfo.new(0.3), {
            Position = toggled and UDim2.new(1, -25, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)
        }):Play()
        
        callback(toggled)
    end)
end

-- Create All Toggles
CreateToggle("Auto Farm", "⚡", function(v)
    _G.Settings.AutoFarm = v
    print("✅ Auto Farm:", v)
end)

CreateToggle("Auto Quest", "📋", function(v)
    _G.Settings.AutoQuest = v
    print("✅ Auto Quest:", v)
end)

CreateToggle("Bring Mobs", "🧲", function(v)
    _G.Settings.BringMobs = v
    print("✅ Bring Mobs:", v)
end)

CreateToggle("Auto Redeem", "🎁", function(v)
    _G.Settings.AutoRedeem = v
    if v then
        task.spawn(function()
            for _, code in pairs(_G.Codes) do
                pcall(function()
                    RS.Remotes.Redeem:InvokeServer(code)
                    task.wait(1)
                end)
            end
            print("✅ Codes redeemed!")
        end)
    end
end)

-- Info Label
local Info = Instance.new("Frame")
Info.Parent = Content
Info.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Info.Size = UDim2.new(1, 0, 0, 85)

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 10)
InfoCorner.Parent = Info

local InfoStroke = Instance.new("UIStroke")
InfoStroke.Color = Color3.fromRGB(70, 70, 90)
InfoStroke.Thickness = 1.5
InfoStroke.Parent = Info

local InfoText = Instance.new("TextLabel")
InfoText.Parent = Info
InfoText.BackgroundTransparency = 1
InfoText.Size = UDim2.new(1, -20, 1, -10)
InfoText.Position = UDim2.new(0, 10, 0, 5)
InfoText.Font = Enum.Font.GothamBold
InfoText.Text = "📍 Level: Auto\n💀 Kill Radius: 25\n✈️ Fly: 8 studs\n⌨️ Toggle: Right Ctrl"
InfoText.TextColor3 = Color3.fromRGB(120, 200, 255)
InfoText.TextSize = 13
InfoText.TextWrapped = true
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.TextXAlignment = Enum.TextXAlignment.Left

-- Draggable
local dragging = false
local dragInput, dragStart, startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Keybind
UIS.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    end
end)

print("✅ SENKY HUB V4.3 LOADED!")
print("⌨️ Press RIGHT CTRL to toggle")
`