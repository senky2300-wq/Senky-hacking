--[[
    SENKY HUB V26 - SUPREME KILL AURA
    - Cơ chế: Fast Attack Hook (Dame đa mục tiêu)
    - Cơ chế: Mob Bring (Kéo quái về tâm Aura)
    - Tự động: Nhận Quest & Treo máy ổn định
]]

local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

_G.Settings = {
    AutoFarm = true,
    Distance = 25,
    Weapon = "Melee", -- Đang ở Level 42 cày Melee là chuẩn
    AuraRange = 60
}

-- ═══ 1. LÕI KILL AURA (FAST ATTACK) ═══
-- Gửi tín hiệu gây sát thương trực tiếp lên server không qua animation
local function ActivateKillAura()
    local tool = LP.Backpack:FindFirstChild(_G.Settings.Weapon) or LP.Character:FindFirstChild(_G.Settings.Weapon)
    if tool then
        LP.Character.Humanoid:EquipTool(tool)
        -- Gửi Validator để đăng ký combat state
        RS.Remotes.Validator:FireServer(0)
        -- Remote gây dame thực tế (Tùy thuộc vào CombatFramework của game)
        RS.Remotes.CommF_:InvokeServer("Attack", { [1] = "Melee" }) 
    end
end

-- ═══ 2. TỰ ĐỘNG GOM QUÁI & DIỆT (GOD FLOW) ═══
task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarm then
            pcall(function()
                -- 1. Nhận Quest Brute (Map Lv 42)
                if not LP.PlayerGui.Main.Quest.Visible then
                    RS.Remotes.CommF_:InvokeServer("StartQuest", "BuggyQuest1", 1)
                end

                local mName = "Brute"
                local mPos = CFrame.new(-1103, 14, 3840) -- Tâm bãi Brute

                -- 2. Gom quái & Kill Aura
                local enemies = workspace.Enemies:GetChildren()
                for _, v in pairs(enemies) do
                    if v.Name == mName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        -- Gom quái về một điểm (Gần vị trí player)
                        v.HumanoidRootPart.CanCollide = false
                        v.HumanoidRootPart.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, -5, 0)
                        
                        -- Kích hoạt Kill Aura lên quái
                        ActivateKillAura()
                    end
                end

                -- 3. Di chuyển thông minh (Stay State)
                -- Luôn giữ player lơ lửng trên bãi quái để Aura hoạt động
                LP.Character.HumanoidRootPart.CFrame = mPos * CFrame.new(0, _G.Settings.Distance, 0)
                
                -- Heartbeat Combat-Lock (Bí mật của Banana)
                RS.Remotes.Validator:FireServer(0)
            end)
        end
    end
end)

print("Senky Hub V26: Supreme Kill Aura Loaded!")