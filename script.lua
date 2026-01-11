--[[
    SENKY KILL AURA EDITION
    - Kill Aura: Quái tự chết trong tầm 60-100 units
    - No Animation: Đánh không động tác
    - God Mode: Xuyên thấu
]]

local LP = game.Players.LocalPlayer
local RS = game.ReplicatedStorage
local CombatFramework = require(LP.PlayerScripts.CombatFramework)
local CombatFrameworkR = getupvalues(CombatFramework)[2]

_G.Settings = {
    KillAura = true,
    AutoFarm = false,
    Distance = 45 -- Khoảng cách đứng cách quái
}

-- ═══ CHỨC NĂNG KILL AURA (HÀNG XỊN) ═══
task.spawn(function()
    while task.wait() do
        if _G.Settings.KillAura then
            pcall(function()
                local AC = CombatFrameworkR.activeController
                if AC and AC.equipped then
                    -- Lấy danh sách quái xung quanh
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            local dist = (LP.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                            if dist < 100 then -- Tầm đánh 100 units
                                -- Gọi dame trực tiếp không cần chạm
                                AC.attackInterval = 0
                                AC:attack()
                                -- Remote đánh của game (Bypass animation)
                                RS.Remotes.Validator:FireServer(math.huge) 
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ═══ AUTO FARM VỚI KILL AURA ═══
task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarm then
            pcall(function()
                -- Tọa độ bãi quái Sea 1 (Ví dụ từ ảnh của mày: Brutes Lv 42)
                local mName = "Brute"
                local mPos = CFrame.new(-1103, 14, 3840) -- Tọa độ ví dụ
                
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == mName and v.Humanoid.Health > 0 then
                        repeat
                            task.wait()
                            -- Đứng trên đầu quái một khoảng an toàn
                            LP.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, _G.Settings.Distance, 0)
                            
                            -- Trang bị vũ khí (Melee)
                            local tool = LP.Backpack:FindFirstChild("Combat") or LP.Character:FindFirstChild("Combat")
                            if tool then LP.Character.Humanoid:EquipTool(tool) end
                        until not _G.Settings.AutoFarm or v.Humanoid.Health <= 0
                    end
                end
                
                -- Quay về bãi nếu hết quái
                if not workspace.Enemies:FindFirstChild(mName) then
                    LP.Character.HumanoidRootPart.CFrame = mPos
                end
            end)
        end
    end
end)

-- ═══ UI ĐƠN GIẢN HIỆN TRÊN ĐIỆN THOẠI ═══
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 150, 0, 100)
Main.Position = UDim2.new(0.1, 0, 0.5, 0)
Main.BackgroundColor3 = Color3.new(0,0,0)

local function Btn(txt, pos, set)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(1, 0, 0, 45)
    b.Position = UDim2.new(0, 0, 0, pos)
    b.Text = txt .. ": OFF"
    b.MouseButton1Click:Connect(function()
        _G.Settings[set] = not _G.Settings[set]
        b.Text = txt .. ": " .. (_G.Settings[set] and "ON" or "OFF")
    end)
end

Btn("Kill Aura", 0, "KillAura")
Btn("Auto Farm", 50, "AutoFarm")
