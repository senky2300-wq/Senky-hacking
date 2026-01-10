-- [[ SENKY HUB - PHIÊN BẢN CHIẾN THẦN SIÊU CẤP ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Senky Hub 😈 | Admin: 1180691145630683216",
   LoadingTitle = "Đang nạp nội công...",
   LoadingSubtitle = "by Senky"
})

-- [[ BIẾN HỆ THỐNG ]] --
_G.AutoFarm = false
_G.FastAttack = true
_G.BringMob = true
_G.WalkSpeed = 16
local Player = game.Players.LocalPlayer

-- [[ HÀM TỐI ƯU HÓA - GIẢM LAG/NÓNG MÁY ]] --
function OptimizeGame()
    local Terrain = game:GetService("Workspace"):FindFirstChildOfClass('Terrain')
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 0
    game:GetService("Lighting").GlobalShadows = false
    for i, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
end

-- [[ AUTO NHẬP ALL CODE ]] --
function AutoImportCodes()
    local codes = {"TRIPLEABUSE", "Sub2CaptainMaui", "DEVSCOOKING", "Sub2Fer999", "Enyu_is_Pro", "Magicbus", "Starcodeheo", "JCWK", "KittGaming", "Bluxxy", "fudd10_v2", "SUB2GAMERROBOT_EXP1", "Sub2NoobMaster123", "Sub2UncleKizaru", "Sub2OfficialNoobie", "TheGreatAce", "Axiore", "Sub2Daigrock", "TantaiGaming", "StrawHatMaine"}
    for _, v in pairs(codes) do
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RedeemCode", v)
    end
end

-- [[ LOGIC GOM QUÁI & ĐÁNH NHANH ]] --
task.spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                -- Bay lên trên đầu quái để tránh bị đánh
                local Monster = game:GetService("Workspace").Enemies:FindFirstChildOfClass("Model")
                if Monster and Monster:FindFirstChild("HumanoidRootPart") then
                    Player.Character.HumanoidRootPart.CFrame = Monster.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0) -- Bay lên 15 đơn vị
                    
                    -- Gom quái (Bring Mob)
                    if _G.BringMob then
                        for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == Monster.Name and v:FindFirstChild("HumanoidRootPart") then
                                v.HumanoidRootPart.CFrame = Monster.HumanoidRootPart.CFrame
                                v.HumanoidRootPart.CanCollide = false
                            end
                        end
                    end
                    
                    -- Đánh nhanh (Fast Attack)
                    if _G.FastAttack then
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                    end
                end
            end)
        end
    end
end)

-- [[ GIAO DIỆN ]] --
local MainTab = Window:CreateTab("Tính Năng Chính", 4483345998)

MainTab:CreateToggle({
   Name = "Auto Farm + Gom Quái + Bay",
   CurrentValue = false,
   Callback = function(Value) _G.AutoFarm = Value end,
})

MainTab:CreateSlider({
   Name = "Tốc độ chạy (Speed)",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value) Player.Character.Humanoid.WalkSpeed = Value end,
})

local UtilsTab = Window:CreateTab("Tiện Ích", 4483345998)

UtilsTab:CreateButton({
   Name = "Nhập Tất Cả Code (X2 EXP)",
   Callback = function() AutoImportCodes() end,
})

UtilsTab:CreateButton({
   Name = "Tối Ưu Hóa (Giảm Lag/Nóng Máy)",
   Callback = function() OptimizeGame() end,
})

UtilsTab:CreateToggle({
   Name = "Chế Độ Treo Máy (White Screen)",
   CurrentValue = false,
   Callback = function(Value)
      game:GetService("RunService"):Set3dRenderingEnabled(not Value)
   end,
})

Rayfield:Notify({Title = "Sẵn Sàng!", Content = "Bản VIP đã sẵn sàng cho chiến thần!", Duration = 5})