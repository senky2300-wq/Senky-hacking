--[[
    SENKY HUB V15 - THE GOD ARCHITECT
    - Kiến trúc: Combat-Lock Exploit (Desync Logic)
    - Cơ chế: Virtual Kill Aura (No Animation, High DPS)
    - Cơ chế: Packet Stability (Chống kick khi spam Validator)
]]

local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

_G.Settings = {
    AutoFarm = true,
    Distance = 22,
    Weapon = "Melee",
    AuraRange = 50, -- Tầm quét của Kill Aura
    AttackSpeed = 0.02 -- Tốc độ gửi packet gây dame
}

-- ═══ 1. LÕI KILL AURA MƯỢT (VIRTUAL ATTACK) ═══
local CombatFramework = require(RS:WaitForChild("CombatFramework"))
local CombatFrameworkR
for _, v in pairs(getupvalues(CombatFramework)) do
    if typeof(v) == "table" and v.activeController then
        CombatFrameworkR = v break
    end
end

local function VirtualAttack()
    local AC = CombatFrameworkR.activeController
    if AC and AC.equipped then
        -- Combat-Lock: Gửi tín hiệu tấn công liên tục nhưng không Reset Animation
        AC.attackInterval = 0
        AC:attack() -- Kích hoạt trạng thái Combat trên Server
        RS.Remotes.Validator:FireServer(0) -- Heartbeat giữ kết nối
    end
end

-- ═══ 2. COMBAT-LOCK & SPAWN MANAGEMENT ═══
task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarm then
            pcall(function()
                local mName = "Brute" -- Target Level 42
                local enemies = workspace.Enemies:GetChildren()
                
                -- Tìm và khóa mục tiêu chính
                local target = nil
                for _, v in pairs(enemies) do
                    if v.Name == mName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        target = v
                        break
                    end
                end

                if target then
                    -- KILL AURA MODE: Di chuyển mượt và gây dame ảo
                    repeat
                        task.wait(_G.Settings.AttackSpeed)
                        
                        -- Di chuyển mượt bằng CFrame (Stealth Positioning)
                        LP.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, _G.Settings.Distance, 0)
                        
                        -- Tự cầm vũ khí nhưng không làm vướng màn hình
                        local tool = LP.Backpack:FindFirstChild(_G.Settings.Weapon) or LP.Character:FindFirstChild(_G.Settings.Weapon)
                        if tool then LP.Character.Humanoid:EquipTool(tool) end
                        
                        -- Kích hoạt Kill Aura qua Virtual Attack
                        VirtualAttack()
                        
                        -- Đưa Server vào trạng thái Combat-Lock
                        -- Bằng cách gửi liên tiếp các Remote mà không cần chờ Animation kết thúc
                    until not _G.Settings.AutoFarm or target.Humanoid.Health <= 0
                else
                    -- TRẠNG THÁI CHỜ (RETAIN COMBAT STATE)
                    -- Đứng tại điểm spawn và vẫn gửi Validator để server không thoát Combat Mode
                    LP.Character.HumanoidRootPart.CFrame = CFrame.new(-1103, 14, 3840) * CFrame.new(0, 40, 0)
                    RS.Remotes.Validator:FireServer(0)
                end
            end)
        end
    end
end)