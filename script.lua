-- Senky Hub Script for Tsunami Brainrot (assuming "stanami brainrot" is a typo for Tsunami Brainrot)
-- This is a basic Roblox Lua script using Roblox's built-in GUI elements.
-- Note: This script should be run in a local script context (e.g., via an exploit or in Roblox Studio for testing).
-- It creates a loading screen with user avatar and greeting, then a menu for aura color selection.
-- Aura is implemented as a simple particle effect around the character.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local userName = player.Name
local userId = player.UserId

-- Function to get user avatar thumbnail
local function getAvatarThumbnail()
    local success, thumbnail = pcall(function()
        return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.Headshot, Enum.ThumbnailSize.Size420x420)
    end)
    if success then
        return thumbnail
    else
        return "rbxassetid://0" -- Fallback if error
    end
end

-- Create Loading Screen
local loadingGui = Instance.new("ScreenGui")
loadingGui.Parent = player:WaitForChild("PlayerGui")
loadingGui.Name = "SenkyLoading"

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loadingFrame.BackgroundTransparency = 0.5
loadingFrame.Parent = loadingGui

local avatarImage = Instance.new("ImageLabel")
avatarImage.Size = UDim2.new(0, 200, 0, 200)
avatarImage.Position = UDim2.new(0.5, -100, 0.4, -100)
avatarImage.Image = getAvatarThumbnail()
avatarImage.BackgroundTransparency = 1
avatarImage.Parent = loadingFrame

local greetingText = Instance.new("TextLabel")
greetingText.Size = UDim2.new(0, 400, 0, 50)
greetingText.Position = UDim2.new(0.5, -200, 0.5, 50)
greetingText.Text = "Senky Hub xin chào " .. userName
greetingText.TextColor3 = Color3.fromRGB(255, 255, 255)
greetingText.Font = Enum.Font.SourceSansBold
greetingText.TextSize = 30
greetingText.BackgroundTransparency = 1
greetingText.Parent = loadingFrame

-- Fade out loading screen after 3 seconds
wait(3)
local fadeTween = TweenService:Create(loadingFrame, TweenInfo.new(1), {BackgroundTransparency = 1})
fadeTween:Play()
for _, child in ipairs(loadingFrame:GetChildren()) do
    TweenService:Create(child, TweenInfo.new(1), {Transparency = 1}):Play()
end
fadeTween.Completed:Wait()
loadingGui:Destroy()

-- Now create the main menu
local menuGui = Instance.new("ScreenGui")
menuGui.Parent = player:WaitForChild("PlayerGui")
menuGui.Name = "SenkyMenu"

local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 300, 0, 400)
menuFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
menuFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menuFrame.BorderSizePixel = 0
menuFrame.Parent = menuGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Text = "Senky Hub - Aura Settings"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 24
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = menuFrame

-- Color selection section
local colors = {
    {Name = "White", Color = Color3.fromRGB(255, 255, 255)},
    {Name = "Red", Color = Color3.fromRGB(255, 0, 0)},
    {Name = "Green", Color = Color3.fromRGB(0, 255, 0)},
    {Name = "Blue", Color = Color3.fromRGB(0, 0, 255)},
    {Name = "Yellow", Color = Color3.fromRGB(255, 255, 0)},
    {Name = "Purple", Color = Color3.fromRGB(128, 0, 128)},
    {Name = "Orange", Color = Color3.fromRGB(255, 165, 0)},
    {Name = "Pink", Color = Color3.fromRGB(255, 192, 203)}
}

local currentAuraColor = colors[1].Color -- Default white

-- Create aura effect
local function createAura(color)
    -- Remove existing aura if any
    if character:FindFirstChild("AuraAttachment") then
        character.AuraAttachment:Destroy()
    end
    
    local attachment = Instance.new("Attachment")
    attachment.Name = "AuraAttachment"
    attachment.Parent = character:WaitForChild("HumanoidRootPart")
    
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Name = "AuraEmitter"
    particleEmitter.Texture = "rbxassetid://243660364" -- Simple glow texture
    particleEmitter.Color = ColorSequence.new(color)
    particleEmitter.Lifetime = NumberRange.new(1, 2)
    particleEmitter.Rate = 50
    particleEmitter.Rotation = NumberRange.new(0, 360)
    particleEmitter.Size = NumberSequence.new(1, 0)
    particleEmitter.Speed = NumberRange.new(5, 10)
    particleEmitter.SpreadAngle = Vector2.new(360, 360)
    particleEmitter.Transparency = NumberSequence.new(0.5, 1)
    particleEmitter.Parent = attachment
    
    -- Make it surround the character
    particleEmitter.Enabled = true
end

-- Initial aura
createAura(currentAuraColor)

-- Create color buttons
local yOffset = 60
for _, colorData in ipairs(colors) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 30)
    button.Position = UDim2.new(0, 10, 0, yOffset)
    button.Text = colorData.Name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Parent = menuFrame
    
    local colorSwatch = Instance.new("Frame")
    colorSwatch.Size = UDim2.new(0, 20, 0, 20)
    colorSwatch.Position = UDim2.new(1, -30, 0.5, -10)
    colorSwatch.BackgroundColor3 = colorData.Color
    colorSwatch.BorderSizePixel = 0
    colorSwatch.Parent = button
    
    button.MouseButton1Click:Connect(function()
        currentAuraColor = colorData.Color
        createAura(currentAuraColor)
    end)
    
    yOffset = yOffset + 40
end

-- Make menu draggable (optional)
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    menuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

menuFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = menuFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

menuFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)