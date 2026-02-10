--[[
    GAME STATUS TRACKER - Roblox Script
    Hướng dẫn: Chạy script này trong game executor
]]

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ============================
-- CẤU HÌNH SERVER
-- ============================
local SERVER_URL = "http://localhost:3000/api" -- Thay đổi URL server của bạn ở đây
-- Hoặc nếu deploy online: "https://your-domain.com/api"

-- ============================
-- GIAO DIỆN THIẾT LẬP TAB
-- ============================
local function createSetupGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GameStatusSetup"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game.CoreGui
    
    -- Background overlay
    local Overlay = Instance.new("Frame")
    Overlay.Name = "Overlay"
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Overlay.BackgroundTransparency = 0.5
    Overlay.Parent = ScreenGui
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Corner
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainFrame
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -40, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "🎮 Thiết Lập Game Status"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MainFrame
    
    -- Question
    local Question = Instance.new("TextLabel")
    Question.Name = "Question"
    Question.Size = UDim2.new(1, -40, 0, 40)
    Question.Position = UDim2.new(0, 20, 0, 80)
    Question.BackgroundTransparency = 1
    Question.Text = "Bạn có muốn treo game ở dưới không?"
    Question.TextColor3 = Color3.fromRGB(200, 200, 200)
    Question.Font = Enum.Font.Gotham
    Question.TextSize = 16
    Question.TextXAlignment = Enum.TextXAlignment.Left
    Question.Parent = MainFrame
    
    -- Buttons Container
    local ButtonsContainer = Instance.new("Frame")
    ButtonsContainer.Name = "ButtonsContainer"
    ButtonsContainer.Size = UDim2.new(1, -40, 0, 50)
    ButtonsContainer.Position = UDim2.new(0, 20, 0, 130)
    ButtonsContainer.BackgroundTransparency = 1
    ButtonsContainer.Parent = MainFrame
    
    local function createButton(text, color, position, callback)
        local Button = Instance.new("TextButton")
        Button.Name = text.."Button"
        Button.Size = UDim2.new(0, 180, 0, 45)
        Button.Position = position
        Button.BackgroundColor3 = color
        Button.BorderSizePixel = 0
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.GothamBold
        Button.TextSize = 16
        Button.Parent = ButtonsContainer
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = Button
        
        Button.MouseButton1Click:Connect(callback)
        
        return Button
    end
    
    local YesButton = createButton("Yes", Color3.fromRGB(46, 204, 113), UDim2.new(0, 0, 0, 0), function()
        MainFrame:Destroy()
        Overlay:Destroy()
        askForTabName(ScreenGui)
    end)
    
    local NoButton = createButton("No", Color3.fromRGB(231, 76, 60), UDim2.new(1, -180, 0, 0), function()
        ScreenGui:Destroy()
        warn("⚠️ Bạn đã hủy thiết lập Game Status")
    end)
end

-- ============================
-- HỎI TÊN TAB
-- ============================
local function askForTabName(ScreenGui)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "TabNameFrame"
    MainFrame.Size = UDim2.new(0, 450, 0, 250)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -125)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 40)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "📝 Nhập Tên Tab"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MainFrame
    
    local TextBox = Instance.new("TextBox")
    TextBox.Name = "TabNameInput"
    TextBox.Size = UDim2.new(1, -40, 0, 45)
    TextBox.Position = UDim2.new(0, 20, 0, 70)
    TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TextBox.BorderSizePixel = 0
    TextBox.PlaceholderText = "Ví dụ: Senky, MyTab..."
    TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    TextBox.Text = ""
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextSize = 14
    TextBox.ClearTextOnFocus = false
    TextBox.Parent = MainFrame
    
    local TextBoxCorner = Instance.new("UICorner")
    TextBoxCorner.CornerRadius = UDim.new(0, 8)
    TextBoxCorner.Parent = TextBox
    
    local NextButton = Instance.new("TextButton")
    NextButton.Name = "NextButton"
    NextButton.Size = UDim2.new(1, -40, 0, 45)
    NextButton.Position = UDim2.new(0, 20, 0, 135)
    NextButton.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
    NextButton.BorderSizePixel = 0
    NextButton.Text = "Tiếp Theo ➜"
    NextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    NextButton.Font = Enum.Font.GothamBold
    NextButton.TextSize = 16
    NextButton.Parent = MainFrame
    
    local NextButtonCorner = Instance.new("UICorner")
    NextButtonCorner.CornerRadius = UDim.new(0, 8)
    NextButtonCorner.Parent = NextButton
    
    NextButton.MouseButton1Click:Connect(function()
        local tabName = TextBox.Text
        if tabName == "" or #tabName < 2 then
            TextBox.PlaceholderText = "⚠️ Vui lòng nhập tên tab (ít nhất 2 ký tự)"
            TextBox.PlaceholderColor3 = Color3.fromRGB(231, 76, 60)
            return
        end
        
        MainFrame:Destroy()
        askForPassword(ScreenGui, tabName)
    end)
end

-- ============================
-- HỎI MẬT KHẨU
-- ============================
local function askForPassword(ScreenGui, tabName)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "PasswordFrame"
    MainFrame.Size = UDim2.new(0, 450, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 40)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "🔐 Bảo Mật Tab"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MainFrame
    
    local Question = Instance.new("TextLabel")
    Question.Size = UDim2.new(1, -40, 0, 35)
    Question.Position = UDim2.new(0, 20, 0, 60)
    Question.BackgroundTransparency = 1
    Question.Text = "Tab '"..tabName.."' cần mật khẩu để truy cập không?"
    Question.TextColor3 = Color3.fromRGB(200, 200, 200)
    Question.Font = Enum.Font.Gotham
    Question.TextSize = 14
    Question.TextXAlignment = Enum.TextXAlignment.Left
    Question.Parent = MainFrame
    
    local YesPasswordButton = Instance.new("TextButton")
    YesPasswordButton.Name = "YesPassword"
    YesPasswordButton.Size = UDim2.new(1, -40, 0, 45)
    YesPasswordButton.Position = UDim2.new(0, 20, 0, 110)
    YesPasswordButton.BackgroundColor3 = Color3.fromRGB(155, 89, 182)
    YesPasswordButton.BorderSizePixel = 0
    YesPasswordButton.Text = "✓ Có, cần mật khẩu"
    YesPasswordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    YesPasswordButton.Font = Enum.Font.GothamBold
    YesPasswordButton.TextSize = 15
    YesPasswordButton.Parent = MainFrame
    
    local YesCorner = Instance.new("UICorner")
    YesCorner.CornerRadius = UDim.new(0, 8)
    YesCorner.Parent = YesPasswordButton
    
    local NoPasswordButton = Instance.new("TextButton")
    NoPasswordButton.Name = "NoPassword"
    NoPasswordButton.Size = UDim2.new(1, -40, 0, 45)
    NoPasswordButton.Position = UDim2.new(0, 20, 0, 165)
    NoPasswordButton.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
    NoPasswordButton.BorderSizePixel = 0
    NoPasswordButton.Text = "✗ Không cần mật khẩu"
    NoPasswordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    NoPasswordButton.Font = Enum.Font.GothamBold
    NoPasswordButton.TextSize = 15
    NoPasswordButton.Parent = MainFrame
    
    local NoCorner = Instance.new("UICorner")
    NoCorner.CornerRadius = UDim.new(0, 8)
    NoCorner.Parent = NoPasswordButton
    
    -- Xử lý khi chọn CÓ mật khẩu
    YesPasswordButton.MouseButton1Click:Connect(function()
        MainFrame:Destroy()
        enterPasswordScreen(ScreenGui, tabName)
    end)
    
    -- Xử lý khi chọn KHÔNG cần mật khẩu
    NoPasswordButton.MouseButton1Click:Connect(function()
        MainFrame:Destroy()
        startTracking(tabName, nil)
        ScreenGui:Destroy()
    end)
end

-- ============================
-- NHẬP MẬT KHẨU
-- ============================
local function enterPasswordScreen(ScreenGui, tabName)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "EnterPasswordFrame"
    MainFrame.Size = UDim2.new(0, 450, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 40)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "🔑 Tạo Mật Khẩu"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MainFrame
    
    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Size = UDim2.new(1, -40, 0, 35)
    InfoLabel.Position = UDim2.new(0, 20, 0, 60)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.Text = "Mật khẩu phải có ít nhất 6 số"
    InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    InfoLabel.Font = Enum.Font.Gotham
    InfoLabel.TextSize = 13
    InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
    InfoLabel.Parent = MainFrame
    
    local PasswordBox = Instance.new("TextBox")
    PasswordBox.Name = "PasswordInput"
    PasswordBox.Size = UDim2.new(1, -40, 0, 45)
    PasswordBox.Position = UDim2.new(0, 20, 0, 105)
    PasswordBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    PasswordBox.BorderSizePixel = 0
    PasswordBox.PlaceholderText = "Nhập mật khẩu (6+ số)"
    PasswordBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    PasswordBox.Text = ""
    PasswordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    PasswordBox.Font = Enum.Font.GothamBold
    PasswordBox.TextSize = 18
    PasswordBox.ClearTextOnFocus = false
    PasswordBox.Parent = MainFrame
    
    local PasswordCorner = Instance.new("UICorner")
    PasswordCorner.CornerRadius = UDim.new(0, 8)
    PasswordCorner.Parent = PasswordBox
    
    local ConfirmButton = Instance.new("TextButton")
    ConfirmButton.Name = "ConfirmButton"
    ConfirmButton.Size = UDim2.new(1, -40, 0, 45)
    ConfirmButton.Position = UDim2.new(0, 20, 0, 170)
    ConfirmButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    ConfirmButton.BorderSizePixel = 0
    ConfirmButton.Text = "✓ Xác Nhận"
    ConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ConfirmButton.Font = Enum.Font.GothamBold
    ConfirmButton.TextSize = 16
    ConfirmButton.Parent = MainFrame
    
    local ConfirmCorner = Instance.new("UICorner")
    ConfirmCorner.CornerRadius = UDim.new(0, 8)
    ConfirmCorner.Parent = ConfirmButton
    
    local CancelButton = Instance.new("TextButton")
    CancelButton.Name = "CancelButton"
    CancelButton.Size = UDim2.new(1, -40, 0, 45)
    CancelButton.Position = UDim2.new(0, 20, 0, 230)
    CancelButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
    CancelButton.BorderSizePixel = 0
    CancelButton.Text = "✗ Hủy"
    CancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CancelButton.Font = Enum.Font.GothamBold
    CancelButton.TextSize = 16
    CancelButton.Parent = MainFrame
    
    local CancelCorner = Instance.new("UICorner")
    CancelCorner.CornerRadius = UDim.new(0, 8)
    CancelCorner.Parent = CancelButton
    
    ConfirmButton.MouseButton1Click:Connect(function()
        local password = PasswordBox.Text
        
        -- Kiểm tra mật khẩu chỉ chứa số
        if not password:match("^%d+$") then
            PasswordBox.PlaceholderText = "⚠️ Mật khẩu chỉ được chứa số!"
            PasswordBox.PlaceholderColor3 = Color3.fromRGB(231, 76, 60)
            PasswordBox.Text = ""
            return
        end
        
        -- Kiểm tra độ dài mật khẩu
        if #password < 6 then
            PasswordBox.PlaceholderText = "⚠️ Mật khẩu phải có ít nhất 6 số!"
            PasswordBox.PlaceholderColor3 = Color3.fromRGB(231, 76, 60)
            PasswordBox.Text = ""
            return
        end
        
        MainFrame:Destroy()
        startTracking(tabName, password)
        ScreenGui:Destroy()
    end)
    
    CancelButton.MouseButton1Click:Connect(function()
        MainFrame:Destroy()
        askForPassword(ScreenGui, tabName)
    end)
end

-- ============================
-- BẮT ĐẦU TRACKING GAME DATA
-- ============================
local function startTracking(tabName, password)
    print("✅ Bắt đầu tracking cho tab: "..tabName)
    if password then
        print("🔒 Tab được bảo vệ bởi mật khẩu")
    else
        print("🔓 Tab không có mật khẩu")
    end
    
    -- Tạo tab trên server
    local success, response = pcall(function()
        return request({
            Url = SERVER_URL.."/create-tab",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode({
                tabName = tabName,
                password = password,
                playerName = LocalPlayer.Name,
                userId = LocalPlayer.UserId
            })
        })
    end)
    
    if success and response.StatusCode == 200 then
        print("✅ Tab đã được tạo thành công!")
        
        -- Bắt đầu gửi dữ liệu định kỳ
        spawn(function()
            while wait(5) do -- Cập nhật mỗi 5 giây
                sendGameData(tabName)
            end
        end)
    else
        warn("❌ Không thể tạo tab. Kiểm tra kết nối server!")
    end
end

-- ============================
-- GỬI DỮ LIỆU GAME LÊN SERVER
-- ============================
local function sendGameData(tabName)
    -- ĐÂY LÀ NơI BẠN THAY ĐỔI ĐỂ LẤY DỮ LIỆU TỪ GAME CỦA BẠN
    -- Ví dụ dưới đây là giả định, bạn cần thay đổi theo game thực tế
    
    local gameData = {
        tabName = tabName,
        playerName = LocalPlayer.Name,
        userId = LocalPlayer.UserId,
        timestamp = os.time(),
        
        -- DỮ LIỆU GAME - THAY ĐỔI THEO GAME CỦA BẠN
        beli = 0, -- Thay bằng cách lấy beli thực từ game
        fragments = 0, -- Fragments (F)
        bounty = 0, -- Bounty/Honor
        level = 1, -- Level
        fruitsInChest = 0, -- Số trái trong rương
        
        -- Bạn có thể thêm nhiều thông tin khác
        -- VD: CurrentQuest, Race, FightingStyle, v.v.
    }
    
    -- ===== HƯỚNG DẪN LẤY DỮ LIỆU THỰC TẾ =====
    -- Ví dụ nếu game có folder Data:
    -- local playerData = LocalPlayer:WaitForChild("Data")
    -- gameData.beli = playerData:FindFirstChild("Beli") and playerData.Beli.Value or 0
    -- gameData.level = playerData:FindFirstChild("Level") and playerData.Level.Value or 1
    -- gameData.fragments = playerData:FindFirstChild("Fragments") and playerData.Fragments.Value or 0
    -- ... và tiếp tục với các dữ liệu khác
    
    pcall(function()
        request({
            Url = SERVER_URL.."/update-data",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(gameData)
        })
    end)
end

-- ============================
-- KHỞI CHẠY SCRIPT
-- ============================
print("🎮 Game Status Tracker đã được load!")
print("📡 Server URL: "..SERVER_URL)
createSetupGUI()