--[[
    SENKY HUB V27 - LEVEL ADAPTIVE
    - Tự động nhận diện Level 104 để nhận Quest chuẩn
    - Kill Aura: Sát thương đa mục tiêu không cần vung tay
    - Mob Bring: Gom toàn bộ quái vào tâm sát thương
]]

local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

_G.Settings = {
    AutoFarm = true,
    Distance = 20,
    Weapon = "Melee", -- Mastery 56
    AuraRange = 50
}

-- ═══ 1. LÕI KILL AURA THỰC THỤ (SERVER-SIDE TICK) ═══
local function KillAuraEngine(target)
    local tool = LP.Backpack:FindFirstChild(_G.Settings.Weapon) or LP.Character:FindFirstChild(_G.Settings.Weapon)
    if tool then
        LP.Character.Humanoid:EquipTool(tool)
        -- Đánh lừa server bằng cách gửi liên tiếp các Packet sát thương
        RS.Remotes.Validator:FireServer(math.floor(tick() * 1000))
        RS.Remotes.CommF_:InvokeServer("Attack", {[1] = target})
    end
end

-- ═══ 2. AUTO QUEST & FARM CHO LEVEL 104 ═══
task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarm then
            pcall(function()
                local lv = LP.Data.Level.Value -- Bây giờ là 104
                local qName, qNum, mName, mPos
                
                -- Cấu hình cho Level 104 (Đảo Tuyết/Nhà Tù)
                if lv >= 90 and lv < 120 then
                    qName, qNum, mName = "SnowQuest", 2, "Snowman"
                    mPos = CFrame.new(1389, 150, -1325) -- Ví dụ tọa độ Snowman
                end

                -- Nhận nhiệm vụ từ xa
                if not LP.PlayerGui.Main.Quest.Visible then
                    RS.Remotes.CommF_:InvokeServer("StartQuest", qName, qNum)
                end

                local enemies = workspace.Enemies:GetChildren()
                local hasTarget = false
                
                for _, v in pairs(enemies) do
                    if v.Name == mName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        hasTarget = true
                        -- MOB BRING: Gom quái về dưới chân
                        v.HumanoidRootPart.CanCollide = false
                        v.HumanoidRootPart.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, -5, 0)
                        
                        -- KÍCH HOẠT KILL AURA
                        KillAuraEngine(v)
                    end
                end

                -- Di chuyển tới bãi farm
                if not hasTarget then
                    LP.Character.HumanoidRootPart.CFrame = mPos * CFrame.new(0, _G.Settings.Distance, 0)
                end
            end)
        end
    end
end)