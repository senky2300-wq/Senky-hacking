--[[
    SENKY HUB V14 - THE BANANA KILLER (THRESHOLD TUNING)
    - Kiến trúc: Spawn-Lock Cycling (Advanced)
    - Cơ chế: Spawn Threshold (Giữ 2 con mồi - Safety Buffer)
    - Chiến thuật: Kill-Finish (Đã đánh là phải chết, không ngắt quãng)
]]

local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

_G.Settings = {
    AutoFarm = true,
    Distance = 22,
    Weapon = "Melee",
    AttackInterval = 0.05,
    SpawnThreshold = 2 -- GIỮ 2 CON ĐỂ KÍCH SPAWN NHANH NHƯ BANANA
}

local function GetAliveEnemies(mName)
    local alive = {}
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v.Name == mName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            table.insert(alive, v)
        end
    end
    return alive
end

task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarm then
            pcall(function()
                -- Map Brute (Lv 42) - Mục tiêu tối thượng
                local mName = "Brute" 
                local aliveMobs = GetAliveEnemies(mName)
                local mobCount = #aliveMobs

                -- CHU KỲ KIỂM SOÁT SPAWN (SPAWN-LOCK CYCLING)
                if mobCount > _G.Settings.SpawnThreshold then
                    -- Ưu tiên chọn con yếu nhất để dứt điểm nhanh, xoay vòng spawn
                    table.sort(aliveMobs, function(a, b) return a.Humanoid.Health < b.Humanoid.Health end)
                    local target = aliveMobs[1]
                    
                    -- CHẾ ĐỘ KILL-FINISH: Đã khóa là đánh cho tới chết (Không bị kẹt khi spawn lag)
                    while target and target.Parent and target.Humanoid.Health > 0 and _G.Settings.AutoFarm do
                        task.wait(_G.Settings.AttackInterval)
                        
                        -- Cập nhật vị trí liên tục trên đầu target
                        LP.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, _G.Settings.Distance, 0)
                        
                        -- Auto Equip & Fast Attack
                        local tool = LP.Backpack:FindFirstChild(_G.Settings.Weapon) or LP.Character:FindFirstChild(_G.Settings.Weapon)
                        if tool then LP.Character.Humanoid:EquipTool(tool) end
                        
                        -- Heartbeat Validator để duy trì liên lạc server
                        RS.Remotes.Validator:FireServer(0)
                        -- AC:attack() từ Framework
                    end
                else
                    -- TRẠNG THÁI "NUÔI SPAWN" (BUFFER STATE)
                    -- Đứng tại điểm Spawn trung tâm, lơ lửng chờ quái mới hiện ra
                    local campPos = CFrame.new(-1103, 14, 3840) -- Tọa độ Camp Brute chuẩn
                    LP.Character.HumanoidRootPart.CFrame = campPos * CFrame.new(0, 45, 0) -- Bay cao để giữ an toàn cho "mồi"
                end
            end)
        end
    end
end)