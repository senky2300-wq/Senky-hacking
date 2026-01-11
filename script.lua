-- BUTTON LOGIC
local isFullscreen = false
local originalSize = UDim2.new(0, 600, 0, 500)
local originalPosition = UDim2.new(0.5, -300, 0.5, -250)

-- Minimize Button: Hide menu and show icon
MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    MenuIcon.Visible = true
    
    -- Animation effect
    TweenService:Create(MenuIcon, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 70, 0, 70)
    }):Play()
end)

-- Fullscreen Button: Toggle fullscreen
FullBtn.MouseButton1Click:Connect(function()
    isFullscreen = not isFullscreen
    
    if isFullscreen then
        -- Go fullscreen
        TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0)
        }):Play()
        FullBtn.Text = "❐"
        Main.Draggable = false
    else
        -- Return to normal
        TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = originalSize,
            Position = originalPosition
        }):Play()
        FullBtn.Text = "□"
        Main.Draggable = true
    end
end)

-- Close Button: Destroy the GUI completely
CloseBtn.MouseButton1Click:Connect(function()
    -- Fade out animation
    TweenService:Create(Main, TweenInfo.new(0.3), {
        BackgroundTransparency = 1
    }):Play()
    
    for _, child in pairs(Main:GetDescendants()) do
        if child:IsA("Frame") or child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("ImageLabel") then
            TweenService:Create(child, TweenInfo.new(0.3), {
                BackgroundTransparency = 1,
                TextTransparency = 1
            }):Play()
        end
    end
    
    wait(0.3)
    Gui:Destroy()
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🍌 BANANA HUB",
        Text = "GUI đã đóng! Rejoin để sử dụng lại.",
        Duration = 3
    })
end)

-- Menu Icon Click: Show menu again
MenuIcon.MouseButton1Click:Connect(function()
    Main.Visible = true
    MenuIcon.Visible = false
    
    -- Reset to normal size if was fullscreen
    if isFullscreen then
        isFullscreen = false
        Main.Size = originalSize
        Main.Position = originalPosition
        FullBtn.Text = "□"
        Main.Draggable = true
    end
    
    -- Animation
    Main.BackgroundTransparency = 1
    TweenService:Create(Main, TweenInfo.new(0.3), {
        BackgroundTransparency = 0
    }):Play()
end)

-- TAB SYSTEM
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
local WeaponTab = CreateTab("Weapons", "🗡️")
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
    Label.ZIndex = 104
    
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Parent = Container
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
    ToggleFrame.Size = UDim2.new(0, 50, 0, 24)
    ToggleFrame.ZIndex = 104
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("Frame")
    ToggleButton.Parent = ToggleFrame
    ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
    ToggleButton.Size = UDim2.new(0, 20, 0, 20)
    ToggleButton.ZIndex = 105
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(1, 0)
    ButtonCorner.Parent = ToggleButton
    
    local Button = Instance.new("TextButton")
    Button.Parent = Container
    Button.BackgroundTransparency = 1
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.Text = ""
    Button.ZIndex = 106
    
    local enabled = _G.Settings[setting] or false
    
    local function UpdateToggle()
        if enabled then
            TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 215, 0)}):Play()
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                Position = UDim2.new(1, -22, 0.5, -10),
                BackgroundColor3 = Color3.fromRGB(255,255,255)
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
        
        if callback then callback(enabled) end
        
        if setting == "BringMob" and enabled then
            BringMobs(GetQuest().Mob)
        end
    end)
    
    parent.CanvasSize = UDim2.new(0, 0, 0, parent.UIListLayout.AbsoluteContentSize.Y + 20)
end

function CreateSlider(parent, name, setting, min, max, default)
    local Container = Instance.new("Frame")
    Container.Parent = parent
    Container.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Container.BorderSizePixel = 0
    Container.Size = UDim2.new(0, 400, 0, 70)
    Container.ZIndex = 103
    
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
    Label.ZIndex = 104
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Parent = Container
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Position = UDim2.new(1, -60, 0, 5)
    ValueLabel.Size = UDim2.new(0, 50, 0, 25)
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    ValueLabel.TextSize = 14
    ValueLabel.ZIndex = 104
    
    local SliderBack = Instance.new("Frame")
    SliderBack.Parent = Container
    SliderBack.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    SliderBack.BorderSizePixel = 0
    SliderBack.Position = UDim2.new(0, 15, 0, 40)
    SliderBack.Size = UDim2.new(1, -30, 0, 6)
    SliderBack.ZIndex = 104
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(1, 0)
    SliderCorner.Parent = SliderBack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Parent = SliderBack
    SliderFill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    SliderFill.BorderSizePixel = 0
    SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    SliderFill.ZIndex = 105
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Parent = SliderBack
    SliderButton.BackgroundTransparency = 1
    SliderButton.Size = UDim2.new(1, 0, 1, 0)
    SliderButton.Text = ""
    SliderButton.ZIndex = 106
    
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
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            UpdateSlider(input)
        end
    end)
    
    parent.CanvasSize = UDim2.new(0, 0, 0, parent.UIListLayout.AbsoluteContentSize.Y + 20)
end

function CreateDropdown(parent, name, setting, options)
    local Container = Instance.new("Frame")
    Container.Parent = parent
    Container.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Container.BorderSizePixel = 0
    Container.Size = UDim2.new(0, 400, 0, 50)
    Container.ZIndex = 103
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Container
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Size = UDim2.new(0, 150, 1, 0)
    Label.Font = Enum.Font.Gotham
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 104
    
    local DropBtn = Instance.new("TextButton")
    DropBtn.Parent = Container
    DropBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    DropBtn.BorderSizePixel = 0
    DropBtn.Position = UDim2.new(0, 170, 0.5, -15)
    DropBtn.Size = UDim2.new(0, 215, 0, 30)
    DropBtn.Font = Enum.Font.Gotham
    DropBtn.Text = _G.Settings[setting] or options[1]
    DropBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
    DropBtn.TextSize = 13
    DropBtn.ZIndex = 104
    
    local DropCorner = Instance.new("UICorner")
    DropCorner.CornerRadius = UDim.new(0, 6)
    DropCorner.Parent = DropBtn
    
    local DropdownList = Instance.new("Frame")
    DropdownList.Parent = Container
    DropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    DropdownList.BorderSizePixel = 0
    DropdownList.Position = UDim2.new(0, 170, 1, 5)
    DropdownList.Size = UDim2.new(0, 215, 0, 0)
    DropdownList.ClipsDescendants = true
    DropdownList.Visible = false
    DropdownList.ZIndex = 110
    
    local ListCorner = Instance.new("UICorner")
    ListCorner.CornerRadius = UDim.new(0, 6)
    ListCorner.Parent = DropdownList
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = DropdownList
    
    local isOpen = false
    
    DropBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            DropdownList.Visible = true
            TweenService:Create(DropdownList, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 215, 0, #options * 30)
            }):Play()
        else
            TweenService:Create(DropdownList, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 215, 0, 0)
            }):Play()
            wait(0.2)
            DropdownList.Visible = false
        end
    end)
    
    for _, option in pairs(options) do
        local OptionBtn = Instance.new("TextButton")
        OptionBtn.Parent = DropdownList
        OptionBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
        OptionBtn.BorderSizePixel = 0
        OptionBtn.Size = UDim2.new(1, 0, 0, 30)
        OptionBtn.Font = Enum.Font.Gotham
        OptionBtn.Text = option
        OptionBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        OptionBtn.TextSize = 12
        OptionBtn.ZIndex = 111
        
        OptionBtn.MouseButton1Click:Connect(function()
            _G.Settings[setting] = option
            DropBtn.Text = option
            
            TweenService:Create(DropdownList, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 215, 0, 0)
            }):Play()
            wait(0.2)
            DropdownList.Visible = false
            isOpen = false
        end)
    end
    
    parent.CanvasSize = UDim2.new(0, 0, 0, parent.UIListLayout.AbsoluteContentSize.Y + 20)
end

-- CREATE TOGGLES & SLIDERS
CreateToggle(FarmTab, "🚀 Auto Farm Level", "AutoFarm", function(v)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🍌 BANANA HUB",
        Text = v and "✅ Auto Farm BẬT!" or "❌ Auto Farm TẮT!",
        Duration = 2
    })
end)

CreateSlider(FarmTab, "📏 Farm Distance", "FarmDistance", 10, 50, 15)
CreateSlider(FarmTab, "🌀 Bring Distance", "BringDistance", 200, 500, 350)

CreateToggle(CombatTab, "⚡ Ultra Fast Attack", "FastAttack", function(v)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🍌 BANANA HUB",
        Text = v and "⚡ Fast Attack BẬT!" or "❌ Fast Attack TẮT!",
        Duration = 2
    })
end)

CreateToggle(CombatTab, "🌀 Bring Mob", "BringMob")
CreateToggle(CombatTab, "💪 Auto Haki", "AutoHaki")
CreateToggle(CombatTab, "🛡️ God Mode", "GodMode")

-- WEAPON SELECTION
local weapons = {"Combat", "Sword", "Blox Fruit", "Gun"}
CreateDropdown(WeaponTab, "🗡️ Select Weapon:", "SelectedWeapon", weapons)

CreateToggle(MiscTab, "⚡ No Energy Loss", "NoEnergyLoss")

-- INFO TAB
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = InfoTab
InfoLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
InfoLabel.BorderSizePixel = 0
InfoLabel.Size = UDim2.new(0, 400, 0, 300)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Text = "📊 LOADING..."
InfoLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
InfoLabel.TextSize = 14
InfoLabel.TextWrapped = true
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
InfoLabel.ZIndex = 103

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 8)
InfoCorner.Parent = InfoLabel

local InfoPadding = Instance.new("UIPadding")
InfoPadding.PaddingTop = UDim.new(0, 15)
InfoPadding.PaddingLeft = UDim.new(0, 15)
InfoPadding.PaddingRight = UDim.new(0, 15)
InfoPadding.Parent = InfoLabel

spawn(function()
    while wait(1) do
        pcall(function()
            local q = GetQuest()
            InfoLabel.Text = string.format(
                "📊 THÔNG TIN HỆ THỐNG\n\n" ..
                "👤 Player: %s\n" ..
                "📊 Level: %d\n" ..
                "🌊 Sea: %d\n" ..
                "📝 Quest: %s\n" ..
                "👹 Mob: %s\n" ..
                "🗡️ Weapon: %s\n\n" ..
                "━━━━━━━━━━━━━━━━\n\n" ..
                "✅ Script: Banana Hub V3.1\n" ..
                "⚡ Fast Attack: OPTIMIZED\n" ..
                "🔥 Version: Quick Load\n" ..
                "👤 Made by: SENKY CODER\n" ..
                "🌟 Status: ACTIVE\n\n" ..
                "⌨️ Hotkey: INSERT",
                Player.Name,
                Player.Data.Level.Value,
                CurrentSea,
                q.Quest or "None",
                q.Mob or "None",
                _G.Settings.SelectedWeapon
            )
        end)
    end
end)

-- LOAD NOTIFICATION
wait(0.5)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🍌 BANANA HUB V3.1",
    Text = "✅ LOADED SUCCESSFULLY!\n⌨️ INSERT = Toggle Menu\n− = Hide | □ = Fullscreen | ✕ = Close",
    Duration = 8
})

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🍌 BANANA HUB V3.1 - LOADED!")
print("⚡ Fast Attack: OPTIMIZED")
print("📊 ZIndex: 999+ (Always On Top)")
print("⌨️ Hotkey: INSERT")
print("🔥 Made by: SENKY CODER")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
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
                BackgroundColor3 = Color3.fromRGB(255,255,255)
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
        
        if callback then callback(enabled) end
        
        if setting == "BringMob" and enabled then
            BringMobs(GetQuest().Mob)
        end
    end)
    
    parent.CanvasSize = UDim2.new(0, 0, 0, parent.UIListLayout.AbsoluteContentSize.Y + 20)
end

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
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            UpdateSlider(input)
        end
    end)
    
    parent.CanvasSize = UDim2.new(0, 0, 0, parent.UIListLayout.AbsoluteContentSize.Y + 20)
end

function CreateDropdown(parent, name, setting, options)
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
    Label.Size = UDim2.new(0, 150, 1, 0)
    Label.Font = Enum.Font.Gotham
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local DropBtn = Instance.new("TextButton")
    DropBtn.Parent = Container
    DropBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    DropBtn.BorderSizePixel = 0
    DropBtn.Position = UDim2.new(0, 170, 0.5, -15)
    DropBtn.Size = UDim2.new(0, 215, 0, 30)
    DropBtn.Font = Enum.Font.Gotham
    DropBtn.Text = _G.Settings[setting] or options[1]
    DropBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
    DropBtn.TextSize = 13
    
    local DropCorner = Instance.new("UICorner")
    DropCorner.CornerRadius = UDim.new(0, 6)
    DropCorner.Parent = DropBtn
    
    local DropdownList = Instance.new("Frame")
    DropdownList.Parent = Container
    DropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    DropdownList.BorderSizePixel = 0
    DropdownList.Position = UDim2.new(0, 170, 1, 5)
    DropdownList.Size = UDim2.new(0, 215, 0, 0)
    DropdownList.ClipsDescendants = true
    DropdownList.Visible = false
    DropdownList.ZIndex = 5
    
    local ListCorner = Instance.new("UICorner")
    ListCorner.CornerRadius = UDim.new(0, 6)
    ListCorner.Parent = DropdownList
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = DropdownList
    
    local isOpen = false
    
    DropBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            DropdownList.Visible = true
            TweenService:Create(DropdownList, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 215, 0, #options * 30)
            }):Play()
        else
            TweenService:Create(DropdownList, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 215, 0, 0)
            }):Play()
            wait(0.2)
            DropdownList.Visible = false
        end
    end)
    
    for _, option in pairs(options) do
        local OptionBtn = Instance.new("TextButton")
        OptionBtn.Parent = DropdownList
        OptionBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
        OptionBtn.BorderSizePixel = 0
        OptionBtn.Size = UDim2.new(1, 0, 0, 30)
        OptionBtn.Font = Enum.Font.Gotham
        OptionBtn.Text = option
        OptionBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        OptionBtn.TextSize = 12
        OptionBtn.ZIndex = 6
        
        OptionBtn.MouseButton1Click:Connect(function()
            _G.Settings[setting] = option
            DropBtn.Text = option
            
            TweenService:Create(DropdownList, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 215, 0, 0)
            }):Play()
            wait(0.2)
            DropdownList.Visible = false
            isOpen = false
        end)
    end
    
    parent.CanvasSize = UDim2.new(0, 0, 0, parent.UIListLayout.AbsoluteContentSize.Y + 20)
end

-- ADD TOGGLES & SLIDERS
CreateToggle(FarmTab, "🚀 Auto Farm Level", "AutoFarm", function(v)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🍌 BANANA HUB",
        Text = v and "Auto Farm BẬT!" or "Auto Farm TẮT!",
        Duration = 3
    })
end)

CreateSlider(FarmTab, "📏 Farm Distance", "FarmDistance", 10, 50, 15)
CreateSlider(FarmTab, "🌀 Bring Distance", "BringDistance", 200, 500, 350)

CreateToggle(CombatTab, "⚡ Ultra Fast Attack", "FastAttack", function(v)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🍌 BANANA HUB",
        Text = v and "Fast Attack BẬT (Tối ưu)!" or "Fast Attack TẮT!",
        Duration = 3
    })
end)

CreateToggle(CombatTab, "🌀 Bring Mob", "BringMob")
CreateToggle(CombatTab, "💪 Auto Haki", "AutoHaki")
CreateToggle(CombatTab, "🛡️ God Mode", "GodMode")

-- WEAPON SELECTION
local weapons = {"Combat", "Sword", "Blox Fruit", "Gun"}
CreateDropdown(WeaponTab, "🗡️ Select Weapon:", "SelectedWeapon", weapons)

CreateToggle(MiscTab, "⚡ No Energy Loss", "NoEnergyLoss")

-- INFO TAB
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = InfoTab
InfoLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
InfoLabel.BorderSizePixel = 0
InfoLabel.Size = UDim2.new(0, 400, 0, 300)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Text = "📊 THÔNG TIN ĐANG TẢI..."
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

spawn(function()
    while wait(1) do
        pcall(function()
            local q = GetQuest()
            InfoLabel.Text = string.format(
                "📊 THÔNG TIN HỆ THỐNG\n\n" ..
                "👤 Player: %s\n" ..
                "📊 Level: %d\n" ..
                "🌊 Sea: %d\n" ..
                "📝 Quest: %s\n" ..
                "👹 Mob: %s\n" ..
                "🗡️ Weapon: %s\n\n" ..
                "━━━━━━━━━━━━━━━━\n\n" ..
                "✅ Script: Banana Hub V3\n" ..
                "⚡ Fast Attack: OPTIMIZED\n" ..
                "🔥 Version: 3.0 Premium\n" ..
                "👤 Made by: SENKY CODER\n" ..
                "🌟 Status: ACTIVE",
                Player.Name,
                Player.Data.Level.Value,
                CurrentSea,
                q.Quest or "None",
                q.Mob or "None",
                _G.Settings.SelectedWeapon
            )
        end)
    end
end)

-- FINAL NOTIFICATION
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🍌 BANANA HUB V3 LOADED",
    Text = "✅ Fast Attack Optimized!\n− = Ẩn menu\n□ = Fullscreen\n✕ = Đóng hoàn toàn",
    Duration = 8
})

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🍌 BANANA HUB V3 - LOADED")
print("⚡ Ultra Fast Attack: ACTIVE")
print("🔥 Made by: SENKY CODER")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")