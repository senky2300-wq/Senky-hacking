--[[
    SENKY HUB V24 - ETERNAL FLOW (BẢN FULL TREO MÁY)
    - Kiến trúc: Combat State Retention & Spawn Cycling
    - Tính năng: Mob Bring (Gom quái), Kill Aura (0ms), Auto Quest, Auto Code
    - Mục tiêu: Treo 24/7 không lỗi, Max Mastery
]]

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Senky Hub V24 💀", HidePremium = false, SaveConfig = true, ConfigFolder = "SenkyConfig"})

local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

_G.Settings = {
    AutoFarm = false,
    Weapon = "Melee", -- Ưu tiên cày Mastery như ảnh
    Distance = 22,
    BringMob = true,
    FastAttack = true
}

-- ═══ 1. AUTO REDEEM CODE X2 EXP (DÙNG CHO ACC MỚI/LV 42) ═══
task.spawn(function()
    local codes = {"TRIPLEABUSE", "Sub2CaptainMaui", "KITT_RESET", "CHANDLER", "JCWK", "Sub2Fer999"}
    for _, c in pairs(codes) do
        RS.Remotes.RedeemCode:DotServer(c)
        task.wait(0.5)
    end
end)

-- ═══ 2. TỐI ƯU HÓA HỆ THỐNG (CHỐNG LAG KHI TREO LÂU) ═══
task.spawn(function()
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
        end
    end
end)

-- ═══ 3. HÀM QUẢN LÝ NHIỆM VỤ & QUÁI (THEO LEVEL 42) ═══
function GetFarmData()
    local lv = LP.Data.Level.Value
    if lv >= 30 and lv < 60 then
        -- Đảo Buggy - Mob Brute
        return "BuggyQuest1", 1, "Brute", CFrame.new(-1103, 14, 3840)
    end
    return "BanditQuest1", 1, "Bandit", CFrame.new(1059, 17, 1547)
end

-- ═══ 4. LÕI FARM - KILL AURA & MOB BRING ═══
task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarm then
            pcall(function()
                local qName, qNum, mName, mPos = GetFarmData()
                
                -- Auto Quest (Remote Invoke)
                if not LP.PlayerGui.Main.Quest.Visible then
                    RS.Remotes.CommF_:InvokeServer("StartQuest", qName, qNum)
                end

                local hasMob = false
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == mName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        hasMob = true
                        -- GOM QUÁI (MOB BRING)
                        if _G.Settings.BringMob then
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.CFrame = mPos
                        end

                        -- KILL AURA & STAY STATE
                        repeat
                            task.wait()
                            LP.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, _G.Settings.Distance, 0)
                            
                            -- Trang bị vũ khí cày Mastery
                            local tool = LP.Backpack:FindFirstChild(_G.Settings.Weapon) or LP.Character:FindFirstChild(_G.Settings.Weapon)
                            if tool then LP.Character.Humanoid:EquipTool(tool) end
                            
                            -- Gửi tín hiệu gây dame (Kill Aura)
                            RS.Remotes.Validator:FireServer(0)
                            if _G.Settings.FastAttack then
                                -- Kích hoạt Attack qua Tool
                                if tool then tool:Activate() end
                            end
                        until not _G.Settings.AutoFarm or v.Humanoid.Health <= 0
                    end
                end

                -- Nếu sạch bãi (Chờ Spawn), đứng tại điểm Camp để giữ Zone Active
                if not hasMob then
                    LP.Character.HumanoidRootPart.CFrame = mPos * CFrame.new(0, _G.Settings.Distance, 0)
                end
            end)
        end
    end
end)

-- ═══ 5. GIAO DIỆN ĐIỀU KHIỂN ═══
local Tab = Window:MakeTab({Name = "Farm & Mastery", Icon = "rbxassetid://4483345998"})

Tab:AddToggle({
	Name = "Bật Auto Farm (Banana Style)",
	Default = false,
	Callback = function(v) _G.Settings.AutoFarm = v end
})

Tab:AddDropdown({
	Name = "Vũ khí (Cày Mastery)",
	Default = "Melee",
	Options = {"Melee", "Sword", "Fruit"},
	Callback = function(v) _G.Settings.Weapon = v end
})

Tab:AddParagraph("Lưu ý treo máy","Bản V24 đã fix lag và auto nhận code x2. Mày cứ bật lên và để đó, nó sẽ tự gom quái về một cục và vả sạch.")

OrionLib:Init()