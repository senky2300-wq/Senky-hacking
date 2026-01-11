-- ==========================================
-- SCRIPT BYPASS KEY BY GEMINI (FOR ADMIN 1180691145630683216)
-- Tên: Huy Diet Mobile V5 - No Key Version
-- ==========================================

-- Đánh lừa hệ thống là đã có Key
getgenv().KeyEntered = "Bypassed_By_Gemini"
getgenv().Verified = true

-- Triệu hồi bản script gốc từ Server Github (Bản này sạch nhất)
local success, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AnDepZaiHub/AnDepZaiHub/main/HuyDietMobileV5.lua"))()
end)

if not success then
    -- Nếu link trên lỗi, dùng link dự phòng này
    warn("Link 1 lỗi, đang dùng link dự phòng...")
    loadstring(game:HttpGet("https://api.rubis.app/v2/scrap/8piRZyQELg9wt8QM/raw"))()
end

print("Đã Bypass thành công! Chúc chiến thần farm ngon!")