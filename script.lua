-- Senky Hub v3 - Escape Tsunami For Brainrots 🌊🧠 (Full Features: Aura, Noclip, Godmode)
-- Loading + Collapsible Menu (thu gọn thành icon nhỏ) + NoClip (xuyên tường) + Godmode (bất tử sóng + player dmg)
-- Key: RightShift mở/đóng menu | Default: Rainbow Aura ON

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRoot = character:WaitForChild("HumanoidRootPart")
local userName = player.Name
local userId = player.UserId

-- Respawn Handler
local function onCharacterAdded(newChar)
    character = newChar
    humanoidRoot = newChar:WaitForChild("HumanoidRootPart")
    local hum = newChar:WaitForChild("Humanoid")
    if auraEnabled then
        createAura(currentAuraColor)
    end
    if noclipEnabled and noclipConn then
        noclipConn:Disconnect()
        setNoclip(true)
    end
    if godEnabled then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        hum:GetPropertyChangedSignal("Health"):Connect(function()
            if godEnabled then hum.Health = math.huge end
        end)
    end
end
player.CharacterAdded:Connect(onCharacterAdded)

-- Avatar Thumbnail
local function getAvatarThumbnail()
    local success, thumb = pcall(Players.GetUserThumbnailAsync, Players, userId, Enum.ThumbnailType.Headshot, Enum.ThumbnailSize.Size420x420)
    return success and thumb or "rbxassetid://0"
end

-- Loading Screen (giữ nguyên vibe)
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "SenkyLoading"
loadingGui.ResetOnSpawn = false
loadingGui.Parent = player:WaitForChild("PlayerGui")

local loadingFrame = Instance.new("Frame", loadingGui)
loadingFrame.Size = UDim2.new(1,0,1,0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(10,10,15)
loadingFrame.BackgroundTransparency = 0.3

local avatar = Instance.new("ImageLabel", loadingFrame)
avatar.Size = UDim2.new(0,220,0,220)
avatar.Position = UDim2.new(0.5,-110,0.35,-110)
avatar.Image = getAvatarThumbnail()

local greet = Instance.new("TextLabel", loadingFrame)
greet.Size = UDim2.new(0,500,0,60)
greet.Position = UDim2.new(0.5,-250,0.55,0)
greet.Text = "Senky Hub xin chào " .. userName .. " 🌊🧠"
greet.TextColor3 = Color3.fromRGB(255, 100, 200)
greet.Font = Enum.Font.GothamBlack
greet.TextSize = 38
greet.BackgroundTransparency = 1
greet.TextStrokeTransparency = 0.5
greet.TextStrokeColor3 = Color3.fromRGB(0,0,0)

task.wait(3.5)
local fadeInfo = TweenInfo.new(1.2, Enum.EasingStyle.Quad)
TweenService:Create(loadingFrame, fadeInfo, {BackgroundTransparency = 1}):Play()
TweenService:Create(avatar, fadeInfo, {ImageTransparency = 1}):Play()
TweenService:Create(greet, fadeInfo, {TextTransparency = 1}):Play()
fadeInfo.Completed:Wait()
loadingGui:Destroy()

-- ===== AURA SYSTEM =====
local auraEnabled = true
local currentAuraColor = nil
local auraAttachment, auraEmitter

local rainbowSeq = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255,127,0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0,255,0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,255,255)),
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0,0,255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255,0,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,0))
}

local function createAura(colorSeq)
    if auraAttachment then auraAttachment:Destroy() end
    auraAttachment = Instance.new("Attachment", humanoidRoot)
    auraEmitter = Instance.new("ParticleEmitter", auraAttachment)
    auraEmitter.Texture = "rbxassetid://243660364"
    auraEmitter.Color = colorSeq
    auraEmitter.Lifetime = NumberRange.new(0.8,1.8)
    auraEmitter.Rate = 100
    auraEmitter.RotSpeed = NumberRange.new(-360,360)
    auraEmitter.Size = NumberSequence.new{NumberSequenceKeypoint.new(0,2.2), NumberSequenceKeypoint.new(1,0)}
    auraEmitter.Speed = NumberRange.new(8,15)
    auraEmitter.SpreadAngle = Vector2.new(360,360)
    auraEmitter.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0,0.2), NumberSequenceKeypoint.new(1,1)}
    auraEmitter.LightEmission = 1
    auraEmitter.Enabled = auraEnabled
end
createAura(rainbowSeq)
currentAuraColor = rainbowSeq

-- ===== NOCLIP SYSTEM =====
local noclipEnabled = false
local noclipConn
local function setNoclip(state)
    noclipEnabled = state
    if noclipConn then noclipConn:Disconnect() end
    if state then
        noclipConn = RunService.Heartbeat:Connect(function()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end

-- ===== GODMODE SYSTEM ===== (Infinite Health + Disable Tsunami/KillParts/Water)
local godEnabled = false
local godLoop
local function setGod(state)
    godEnabled = state
    if godLoop then godLoop:Disconnect() end
    if state then
        godLoop = RunService.Heartbeat:Connect(function()
            -- Infinite Health
            local hum = character and character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.MaxHealth = math.huge
                hum.Health = math.huge
            end
            -- Disable Tsunami/Kill/Water Parts (loop toàn workspace)
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (
                    obj.Name:lower():find("kill") or
                    obj.Name:lower():find("tsunami") or
                    obj.Name:lower():find("water") or
                    obj.Name:lower():find("damage")
                ) then
                    obj.CanCollide = false
                    obj.Transparency = 1
                    obj.CanQuery = false
                    pcall(function() obj:Destroy() end)
                end
            end
        end)
    end
end

-- ===== MAIN MENU GUI =====
local menuGui = Instance.new("ScreenGui")
menuGui.Name = "SenkyHub"
menuGui.ResetOnSpawn = false
menuGui.Parent = player.PlayerGui

-- Main Frame (full menu)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 520)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -260)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = menuGui

local uicorner = Instance.new("UICorner", mainFrame)
uicorner.CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, -60, 0, 50)
title.Position = UDim2.new(0, 10, 0, 5)
title.Text = "Senky Hub 🌊🧠"
title.TextColor3 = Color3.fromRGB(255, 100, 200)
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.BackgroundTransparency = 1

-- Minimize Button
local minBtn = Instance.new("TextButton", mainFrame)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -40, 0, 10)
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 24
local minCorner = Instance.new("UICorner", minBtn)
minCorner.CornerRadius = UDim.new(0, 6)

-- Mini Frame (thu gọn - icon nhỏ góc phải dưới)
local miniFrame = Instance.new("Frame")
miniFrame.Name = "MiniFrame"
miniFrame.Size = UDim2.new(0, 60, 0, 60)
miniFrame.Position = UDim2.new(1, -80, 1, -80)
miniFrame.BackgroundColor3 = Color3.fromRGB(255, 100, 200)
miniFrame.BorderSizePixel = 0
miniFrame.Visible = false
miniFrame.Active = true
miniFrame.Parent = menuGui

local miniCorner = Instance.new("UICorner", miniFrame)
miniCorner.CornerRadius = UDim.new(0, 15)
local miniBtn = Instance.new("TextButton", miniFrame)
miniBtn.Size = UDim2.new(1,0,1,0)
miniBtn.Text = "🧠"
miniBtn.TextColor3 = Color3.fromRGB(255,255,255)
miniBtn.BackgroundTransparency = 1
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 32

-- Toggle Buttons Section
local toggles = {
    {name = "Aura", var = "auraEnabled", colorOn = Color3.fromRGB(0,180,0), colorOff = Color3.fromRGB(180,0,0), func = function(state) auraEmitter.Enabled = state end},
    {name = "NoClip", var = "noclipEnabled", colorOn = Color3.fromRGB(0,150,255), colorOff = Color3.fromRGB(100,100,100), func = setNoclip},
    {name = "GodMode", var = "godEnabled", colorOn = Color3.fromRGB(255,50,50), colorOff = Color3.fromRGB(100,100,100), func = setGod}
}

local toggleY = 70
for _, t in ipairs(toggles) do
    local btn = Instance.new("TextButton", mainFrame)
    btn.Size = UDim2.new(0.88, 0, 0, 45)
    btn.Position = UDim2.new(0.06, 0, 0, toggleY)
    btn.Text = t.name .. ": ON"
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = t.colorOn
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 8)
    
    _G[t.var] = true -- Default ON for aura, OFF others? Wait, aura yes, others no
    if t.name ~= "Aura" then
        btn.Text = t.name .. ": OFF"
        btn.BackgroundColor3 = t.colorOff
        _G[t.var] = false
    end
    
    btn.MouseButton1Click:Connect(function()
        _G[t.var] = not _G[t.var]
        btn.Text = t.name .. ": " .. (_G[t.var] and "ON" or "OFF")
        btn.BackgroundColor3 = _G[t.var] and t.colorOn or t.colorOff
        t.func(_G[t.var])
    end)
    toggleY = toggleY + 55
end

-- Colors (dưới toggles)
local colors = {
    {Name = "Rainbow", Seq = rainbowSeq},
    {Name = "White", Color = Color3.fromRGB(255,255,255)},
    {Name = "Red", Color = Color3.fromRGB(255,50,50)},
    {Name = "Lime", Color = Color3.fromRGB(50,255,50)},
    {Name = "Blue", Color = Color3.fromRGB(50,100,255)},
    {Name = "Yellow", Color = Color3.fromRGB(255,220,50)},
    {Name = "Purple", Color = Color3.fromRGB(180,50,255)},
    {Name = "Pink", Color = Color3.fromRGB(255,105,180)},
    {Name = "Cyan", Color = Color3.fromRGB(0,255,255)}
}

local colorY = toggleY + 10
local colorTitle = Instance.new("TextLabel", mainFrame)
colorTitle.Size = UDim2.new(1,0,0,30)
colorTitle.Position = UDim2.new(0,0,0, colorY)
colorTitle.Text = "Aura Colors:"
colorTitle.TextColor3 = Color3.fromRGB(200,200,255)
colorTitle.Font = Enum.Font.GothamBold
colorTitle.TextSize = 18
colorTitle.BackgroundTransparency = 1
colorY = colorY + 40

for _, c in ipairs(colors) do
    local btn = Instance.new("TextButton", mainFrame)
    btn.Size = UDim2.new(0.88,0,0,35)
    btn.Position = UDim2.new(0.06,0,0,colorY)
    btn.Text = c.Name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,60)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    local btnC = Instance.new("UICorner", btn)
    btnC.CornerRadius = UDim.new(0,6)
    
    local swatch = Instance.new("Frame", btn)
    swatch.Size = UDim2.new(0,25,0,25)
    swatch.Position = UDim2.new(1,-35,0.5,-12.5)
    swatch.BorderSizePixel = 0
    local swC = Instance.new("UICorner", swatch)
    swC.CornerRadius = UDim.new(0,4)
    
    if c.Seq then
        swatch.BackgroundColor3 = Color3.fromRGB(255,255,255)
        local emoji = Instance.new("TextLabel", swatch)
        emoji.Size = UDim2.new(1,0,1,0)
        emoji.Text = "🌈"
        emoji.BackgroundTransparency = 1
        emoji.TextColor3 = Color3.fromRGB(0,0,0)
        emoji.Font = Enum.Font.Gotham
        emoji.TextSize = 20
    else
        swatch.BackgroundColor3 = c.Color
    end
    
    btn.MouseButton1Click:Connect(function()
        currentAuraColor = c.Seq or ColorSequence.new(c.Color)
        createAura(currentAuraColor)
    end)
    colorY = colorY + 42
end

-- Minimize Logic
minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    miniFrame.Visible = true
end)

miniBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    miniFrame.Visible = false
end)

-- Keybind: RightShift toggle main menu (expand if mini)
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if mainFrame.Visible then
            mainFrame.Visible = false
            miniFrame.Visible = true
        else
            mainFrame.Visible = true
            miniFrame.Visible = false
        end
    end
end)

print("🧠 Senky Hub v3 Loaded! RightShift mở menu | Godmode + Noclip OP cho Tsunami Brainrot!")