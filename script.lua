--[[
    SENKY HUB V17 - THE ULTIMATE GOD
    - Tầng 1: Supreme Kill Aura (Quét sát thương tầm rộng, 0 Delay)
    - Tầng 2: Auto Quest Remote (Nhận nhiệm vụ từ xa ngay lập tức)
    - Tầng 3: Banana Cycle (Nuôi spawn, giữ luồng EXP liên tục)
]]

local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

_G.Settings = {
    AutoFarm = true,
    Distance = 22,
    Weapon = "Melee",
    AuraRange = 50, -- Tầm đánh của Kill Aura
    AttackRate = 0.01 -- Tốc độ gửi packet (siêu nhanh)
}

-- ═══ 1. LÕI KILL AURA (FAST ATTACK FRAMEWORK) ═══
local CombatFramework = require(RS:WaitForChild("CombatFramework"))
local CombatFrameworkR
for _, v in pairs(getupvalues(CombatFramework)) do
    if typeof(v) == "table" and v.activeController then
        CombatFrameworkR = v break
    end
end

local function KillAura(target)
    local AC = CombatFrameworkR.activeController
    if AC and AC.equipped then
        -- Gửi tín hiệu đánh liên tục (Kill Aura)
        AC.attackInterval = 0
        AC:attack()
        RS.Remotes.Validator:FireServer(0) -- Heartbeat Combat-Lock
    end
end

-- ═══ 2. TỰ ĐỘNG NHẬN QUEST TỪ XA (REMOTE INVOKE) ═══
local function AutoQuest()
    local lv = LP.Data.Level.Value
    local qName, qNum, mName, qPos, mPos
    
    -- Level 42 nhận Brute (Map Đảo Buggy)
    if lv >= 30 and lv < 60 then
        qName, qNum, mName = "BuggyQuest1", 1, "Brute"
        qPos = CFrame.new(-1141, 5, 3831)
        mPos = CFrame.new(-1103, 14, 3840)
    end
    
    local questGui = LP.PlayerGui.Main.Quest
    if not questGui.Visible then
        -- Nhận quest từ xa bằng Remote (Không cần bay về NPC)
        RS.Remotes.CommF_:InvokeServer("StartQuest", qName, qNum)
    end
    return mName, mPos
end

-- ═══ 3. VÒNG LẶP HÀNH QUYẾT (THE GOD FLOW) ═══
task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarm then
            pcall(function()
                local mName, mPos = AutoQuest()
                local enemies = workspace.Enemies:GetChildren()
                
                -- Đếm quái để giữ Spawn-Lock (Banana Logic)
                local aliveMobs = {}
                for _, v in pairs(enemies) do
                    if v.Name == mName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        table.insert(aliveMobs, v)
                    end
                end

                -- Nếu bãi có quái (Giữ lại 1 con để nuôi spawn nếu cần)
                if #aliveMobs > 1 then
                    local target = aliveMobs[1]
                    
                    repeat
                        task.wait(_G.Settings.AttackRate)
                        -- Bay lơ lửng mượt mà trên đầu quái
                        LP.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, _G.Settings.Distance, 0)
                        
                        -- Tự cầm vũ khí cày Mastery
                        local tool = LP.Backpack:FindFirstChild(_G.Settings.Weapon) or LP.Character:FindFirstChild(_G.Settings.Weapon)
                        if tool then LP.Character.Humanoid:EquipTool(tool) end
                        
                        -- Kích hoạt Kill Aura
                        KillAura(target)
                    until not _G.Settings.AutoFarm or target.Humanoid.Health <= 0
                else
                    -- Đứng chờ tại điểm Spawn chuẩn để quái vừa ra là dính đòn ngay
                    LP.Character.HumanoidRootPart.CFrame = mPos * CFrame.new(0, _G.Settings.Distance, 0)
                    RS.Remotes.Validator:FireServer(0) -- Giữ Combat-Lock
                end
            end)
        end
    end
end)