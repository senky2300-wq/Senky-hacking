
--[[
    SENKY HUB V4.2 - FIX BLACK SCREEN
    ✅ Fix ScrollingFrame không hiển thị content
    ✅ Tối ưu rendering
]]

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer.Character
task.wait(2)

local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")

print("🔄 Loading Senky Hub V4.2...")

-- ══════════════════════════════════════════
--     SETTINGS
-- ══════════════════════════════════════════
_G.Settings = {
    AutoFarm = false,
    AutoQuest = false,
    AutoRedeem = false,
    FlyHeight = 8,
    KillRadius = 25,
    BringMobs = false
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
--     UI LIBRARY (FIXED)
-- ══════════════════════════════════════════
local Library = {}

function Library:CreateWindow(title)
    if game.CoreGui:FindFirstChild("SenkyHubUI") then
        game.CoreGui:FindFirstChild("SenkyHubUI"):Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SenkyHubUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999
    
    pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    
    if not ScreenGui.Parent then
        ScreenGui.Parent = LP:WaitForChild("PlayerGui")
    end
    
    -- Main Container (KHÔNG dùng ScrollingFrame ở đây)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 450, 0, 550)
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 15)
    MainCorner.Parent = MainFrame
    
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(80, 80, 100)
    MainStroke.Thickness = 2
    MainStroke.Parent = MainFrame
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 55)
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 15)
    TitleCorner.Parent = TitleBar
    
    local Title = Instance.new("TextLabel")
    Title.Parent = TitleBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.Size = UDim2.new(1, -70, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 19
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close Button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = TitleBar
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    CloseBtn.Position = UDim2.new(1, -45, 0, 12)
    CloseBtn.Size = UDim2.new(0, 32, 0, 32)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.white
    CloseBtn.TextSize = 20
    CloseBtn.AutoButtonColor = false
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)
    
    -- Content Frame (BÂY GIỜ MỚI là ScrollingFrame)
    local ContentWrapper = Instance.new("Frame")
    ContentWrapper.Name = "ContentWrapper"
    ContentWrapper.Parent = MainFrame
    ContentWrapper.BackgroundTransparency = 1
    ContentWrapper.Position = UDim2.new(0, 0, 0, 55)
    ContentWrapper.Size = UDim2.new(1, 0, 1, -55)
    
    local Content = Instance.new("ScrollingFrame")
    Content.Name = "Content"
    Content.Parent = ContentWrapper
    Content.Active = true
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.Position = UDim2.new(0, 15, 0, 15)
    Content.Size = UDim2.new(1, -30, 1, -30)
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.ScrollBarThickness = 6
    Content.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 130)
    Content.ScrollBarImageTransparency = 0.3
    
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Content
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 15)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Content.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 20)
    end)
    
    -- Draggable
    local dragging = false
    local dragInput, dragStart, startPos
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    -- Keybind
    UIS.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
    
    return {Content = Content, Frame = MainFrame, ScreenGui = ScreenGui}
end

function Library:CreateToggle(parent, text, emoji, default, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    ToggleFrame.Size = UDim2.new(0, 390, 0, 55) -- Fixed size thay vì relative
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = ToggleFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(50, 50, 65)
    Stroke.Thickness = 1.5
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = ToggleFrame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 20, 0, 0)
    Label.Size = UDim2.new(1, -100, 1, 0)
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = emoji.." "..text
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.TextSize = 16
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local Switch = Instance.new("Frame")
    Switch.Parent = ToggleFrame
    Switch.BackgroundColor3 = default and Color3.fromRGB(70, 220, 150) or Color3.fromRGB(60, 60, 75)
    Switch.Position = UDim2.new(1, -65, 0.5, -14)
    Switch.Size = UDim2.new(0, 52, 0, 28)
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = Switch
    
    local Circle = Instance.new("Frame")
    Circle.Parent = Switch
    Circle.BackgroundColor3 = Color3.white
    Circle.Position = default and UDim2.new(1, -25, 0.5, -12) or UDim2.new(0, 3, 0.5, -12)
    Circle.Size = UDim2.new(0, 24, 0, 24)
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle
    
    local toggled = default
    
    local Button = Instance.new("TextButton")
    Button.Parent = ToggleFrame
    Button.BackgroundTransparency = 1
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.Text = ""
    Button.AutoButtonColor = false
    
    Button.MouseButton1Click:Connect(function()
        toggled = not toggled
        
        TS:Create(Switch, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            BackgroundColor3 = toggled and Color3.fromRGB(70, 220, 150) or Color3.fromRGB(60, 60, 75)
        }):Play()
        
        TS:Create(Circle, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Position = toggled and UDim2.new(1, -25, 0.5, -12) or UDim2.new(0, 3, 0.5, -12)
        }):Play()
        
        callback(toggled)
    end)
end

function Library:CreateLabel(parent, text)
    local Label = Instance.new("Frame")
    Label.Parent = parent
    Label.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    Label.Size = UDim2.new(0, 390, 0, 95)
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Label
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(60, 60, 80)
    Stroke.Thickness = 1.5
    Stroke.Parent = Label
    
    local Text = Instance.new("TextLabel")
    Text.Parent = Label
    Text.BackgroundTransparency = 1
    Text.Size = UDim2.new(1, -24, 1, -16)
    Text.Position = UDim2.new(0, 12, 0, 8)
    Text.Font = Enum.Font.GothamBold
    Text.Text = text
    Text.TextColor3 = Color3.fromRGB(120, 200, 255)
    Text.TextSize = 14
    Text.TextWrapped = true
    Text.TextYAlignment = Enum.TextYAlignment.Top
    Text.TextXAlignment = Enum.TextXAlignment.Left
end

-- ══════════════════════════════════════════
--     CREATE UI
-- ══════════════════════════════════════════
local Window = Library:CreateWindow("🍌 SENKY HUB V4.2 - GOD MODE")

Library:CreateToggle(Window.Content, "Auto Farm (God Mode)", "⚡", false, function(v)
    _G.Settings.AutoFarm = v
    print("✅ Auto Farm:", v)
end)

Library:CreateToggle(Window.Content, "Auto Quest", "📋", false, function(v)
    _G.Settings.AutoQuest = v
    print("✅ Auto Quest:", v)
end)

Library:CreateToggle(Window.Content, "Bring All Mobs", "🧲", false, function(v)
    _G.Settings.BringMobs = v
    print("✅ Bring Mobs:", v)
end)

Library:CreateToggle(Window.Content, "Auto Redeem Codes", "🎁", false, function(v)
    _G.Settings.AutoRedeem = v
    if v then
        task.spawn(function()
            for _, code in pairs(_G.Codes) do
                pcall(function()
                    RS.Remotes.Redeem:InvokeServer(code)
                    task.wait(1)
                end)
            end
            print("✅ All codes redeemed!")
        end)
    end
end)

Library:CreateLabel(Window.Content, "📍 Level: Auto Detect\n💀 Kill: Damage Aura (Radius 25)\n✈️ Fly Height: 8 studs\n⌨️ Toggle UI: Right Ctrl\n🎮 Version: 4.2 Fixed")

print("✅ SENKY HUB V4.2 LOADED!")
print("⌨️ Press RIGHT CTRL to toggle")
