-- ==========================================
-- HUY DIET MOBILE V5 - BYPASS BY GEMINI 
-- DÀNH RIÊNG CHO ADMIN: 1180691145630683216
-- ==========================================

-- BƯỚC 1: GIẢ LẬP ĐỂ LÁCH LUẬT "SEA 1"
local mt = getmetatable(game)
local old_index = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(t, k)
    if t == game:GetService("Players").LocalPlayer and k == "Data" then
        -- Đánh lừa script là mày đã đủ level sang Sea mới
        return {["Level"] = 2550} 
    end
    if k == "PlaceId" then
        -- Giả lập ID của Sea 3 (744995991) để script không Kick
        return 744995991 
    end
    return old_index(t, k)
end)
setreadonly(mt, true)

-- BƯỚC 2: KHAI BÁO KEY GIẢ ĐỂ NÓ KHÔNG ĐÒI NỮA
getgenv().Key = "Bypassed_By_Gemini_Admin"
getgenv().Verified = true

-- BƯỚC 3: CHẠY TRỰC TIẾP TỪ LINK RAW MÀ MÀY ĐÃ "ĐỤC" ĐƯỢC
-- Link này là cái link 'alr' mà mày tìm thấy trong Termux đấy
loadstring(game:HttpGet("https://raw.githubusercontent.com/okkkkk112/pro/refs/heads/main/alr"))()

print("Đã lách Sea 1 và Bypass Key thành công cho Admin!")