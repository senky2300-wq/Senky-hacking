local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Banana Cat Hub Clone",
   LoadingTitle = "Loading Script...",
   LoadingSubtitle = "by YourName",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BananaHubConfig", -- Thư mục lưu config trong workspace
      FileName = "MainConfig"
   },
   KeySystem = false -- Tắt hệ thống Key cho đỡ phiền
})

-- Tạo Tab "Shop" giống trong ảnh
local ShopTab = Window:CreateTab("Shop", 4483345998) -- ID icon giỏ hàng

-- Tạo các nút bấm trong Shop
ShopTab:CreateButton({
   Name = "Redeem Code",
   Callback = function()
       print("Da bam Redeem Code!")
   end,
})

ShopTab:CreateButton({
   Name = "Teleport New World",
   Callback = function()
       print("Dang chuyen den New World...")
   end,
})

-- Tạo Tab "Config" để ông gắn cái code lưu file của ông vào
local ConfigTab = Window:CreateTab("Config", 4483345998)

ConfigTab:CreateInput({
   Name = "Admin Message",
   PlaceholderText = "Nhap tin nhan vao day...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       -- Đây chính là chỗ ông dùng logic lưu file config.json nè
       print("Tin nhan moi: " .. Text)
   end,
})