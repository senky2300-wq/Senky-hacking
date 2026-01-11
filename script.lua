
--[[
    SENKY HUB V5.0 - MINIMAL TOGGLE BUTTON
    ✅ 1 nút duy nhất góc phải màn hình
    ✅ Click = ON/OFF farm
    ✅ Không có menu phức tạp
]]

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer.Character
task.wait(2)

local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

print("🔄 Loading Senky Hub V5.0...")

-- ══════════════════════════════════════════
--     SETTINGS
-- ══════════════════════════════════════════
_G.Farming = false

-- ══════════════════════════════════════════
--     DAMAGE AURA + AUTO FARM
-- ══════════════════════════════════════════
task.spawn(function()
    while task.wait(0.2) do
        if _G.Farming then
            pcall(function()
                local char = LP.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                
                local lv = LP.Data.Level.Value
                local qName, qNum, mName, mPos
                
                -- Auto detect level
                if lv >= 90 and lv < 120 then
                    qName, qNum = "SnowQuest", 2
                    mName = "Snowman"
                    mPos = CFrame.new(1389, 150, -1325)
                elseif lv >= 120 and lv < 150 then
                    qName, qNum = "MarineQuest3", 1
                    mName = "Marine Captain"
                    mPos = CFrame.new(-5200, 30, 4050)
                end
                
                -- Auto quest
                local questGui = LP.PlayerGui:FindFirstChild("Main")
                if questGui and questGui:FindFirstChild("Quest") and not questGui.Quest.Visible then
                    RS.Remotes.CommF_:InvokeServer("StartQuest", qName, qNum)
                end
                
                -- Find mob
                local targetMob = nil
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == mName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 
                       and v:FindFirstChild("HumanoidRootPart") then
                        targetMob = v
                        
                        -- Kill mob (God Mode)
                        v.Humanoid.Health = 0
                        
                        -- Bring mob
                        v.HumanoidRootPart.CanCollide = false
                        v.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, -5, 0)
                    end
                end
                
                -- Fly to farm
                if targetMob then
                    char.HumanoidRootPart.CFrame = targetMob.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
                elseif mPos then
                    char.HumanoidRootPart.CFrame = mPos
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
--     CREATE TOGGLE BUTTON (GÓC PHẢI)
-- ══════════════════════════════════════════

-- Xóa UI cũ
if game.CoreGui:FindFirstChild("SenkyToggle") then
    game.CoreGui:FindFirstChild("SenkyToggle"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SenkyToggle"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Button Container
local Button = Instance.new("TextButton")
Button.Name = "ToggleButton"
Button.Parent = ScreenGui
Button.BackgroundColor3 = Color3.fromRGB(255, 70, 70) -- Đỏ = OFF
Button.Position = UDim2.new(1, -120, 0.5, -35) -- Góc phải, giữa màn hình
Button.Size = UDim2.new(0, 100, 0, 70)
Button.Font = Enum.Font.GothamBold
Button.Text = "OFF"
Button.TextColor3 = Color3.white
Button.TextSize = 24
Button.BorderSizePixel = 0
Button.AutoButtonColor = false

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 15)
ButtonCorner.Parent = Button

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Color = Color3.white
ButtonStroke.Thickness = 3
ButtonStroke.Parent = Button

-- Status Label (dưới nút)
local Status = Instance.new("TextLabel")
Status.Parent = Button
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0, 0, 1, 5)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Font = Enum.Font.GothamBold
Status.Text = "🔴 Idle"
Status.TextColor3 = Color3.fromRGB(255, 100, 100)
Status.TextSize = 12

-- Click Event
Button.MouseButton1Click:Connect(function()
    _G.Farming = not _G.Farming
    
    if _G.Farming then
        -- ON State
        TS:Create(Button, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(70, 220, 150), -- Xanh lá
            Text = "ON"
        }):Play()
        
        Status.Text = "🟢 Farming..."
        Status.TextColor3 = Color3.fromRGB(100, 255, 150)
        
        print("✅ Auto Farm: ON")
    else
        -- OFF State
        TS:Create(Button, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(255, 70, 70), -- Đỏ
            Text = "OFF"
        }):Play()
        
        Status.Text = "🔴 Idle"
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        
        print("❌ Auto Farm: OFF")
    end
end)

-- Draggable Button
local dragging = false
local dragInput, dragStart, startPos

Button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Button.Position
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Button.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("✅ SENKY HUB V5.0 LOADED!")
print("🎮 Click button to toggle farm")