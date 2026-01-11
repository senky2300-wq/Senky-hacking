--[[
    SENKY HUB V3 - PRO EDITION
    - UI: Orion Library (Auto-Center for Mobile)
    - Logic: Kill Aura + Auto Quest + Fast Attack
    - Level: 1 - 2550 (Full Seas)
]]

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Senky Hub V3 💀", HidePremium = false, SaveConfig = true, ConfigFolder = "SenkyConfig"})

local LP = game.Players.LocalPlayer
local RS = game.ReplicatedStorage

_G.Settings = {
    AutoFarm = false,
    KillAura = false,
    AutoStats = false,
    Weapon = "Melee"
}

-- ═══ HÀM KIỂM TRA LEVEL & NHẬN QUEST ═══
local function GetQuestData()
    local lv = LP.Data.Level.Value
    if lv >= 1 and lv < 10 then
        return "BanditQuest1", 1, "Bandit", CFrame.new(1059, 17, 1547), CFrame.new(1199, 17, 1404)
    elseif lv >= 10 and lv < 15 then
        return "JungleQuest", 1, "Monkey", CFrame.new(-1605, 37, 152), CFrame.new(-1448, 50, 63)
    elseif lv >= 15 and lv < 30 then
        return "JungleQuest", 2, "Gorilla", CFrame.new(-1605, 37, 152), CFrame.new(-1220, 10, -500)
    elseif lv >= 30 and lv < 60 then
        return "BuggyQuest1", 1, "Pirate", CFrame.new(-1141, 5, 3831), CFrame.new(-1103, 14, 3840)
    -- Mày có thể dán thêm các tọa độ sea tao đưa lúc nãy vào đây
    else
        -- Mặc định Sea 3 nếu level cao
        return "PortTownQuest", 1, "Pirate Billionaire", CFrame.new(-290, 15, 5308), CFrame.new(-435, 189, 5551)
    end
end

-- ═══ LOGIC FAST ATTACK & KILL AURA ═══
local CombatFramework = require(LP.PlayerScripts.CombatFramework)
local CombatFrameworkR = getupvalues(CombatFramework)[2]

task.spawn(function()
    while task.wait() do
        if _G.Settings.KillAura then
            pcall(function()
                local AC = CombatFrameworkR.activeController
                if AC and AC.equipped then
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            local dist = (LP.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                            if dist < 100 then
                                AC.attackInterval = 0
                                AC:attack()
                                RS.Remotes.Validator:FireServer(math.huge)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ═══ VÒNG LẶP AUTO FARM CHÍNH ═══
task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarm then
            pcall(function()
                local qName, qNum, mName, qPos, mPos = GetQuestData()
                
                -- Tự nhận nhiệm vụ
                if not LP.PlayerGui.Main.Quest.Visible then
                    LP.Character.HumanoidRootPart.CFrame = qPos
                    task.wait(0.5)
                    RS.Remotes.CommF_:InvokeServer("StartQuest", qName, qNum)
                end

                -- Tìm quái và di chuyển tới
                local found = false
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == mName and v.Humanoid.Health > 0 then
                        found = true
                        repeat
                            task.wait()
                            -- Kill Aura sẽ tự xử, mình chỉ cần đứng gần
                            LP.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
                            
                            -- Auto Equip
                            local tool = LP.Backpack:FindFirstChild(_G.Settings.Weapon) or LP.Character:FindFirstChild(_G.Settings.Weapon)
                            if tool then LP.Character.Humanoid:EquipTool(tool) end
                        until not _G.Settings.AutoFarm or v.Humanoid.Health <= 0
                    end
                end
                
                if not found then
                    LP.Character.HumanoidRootPart.CFrame = mPos
                end
            end)
        end
    end
end)

-- ═══ GIAO DIỆN MENU (TAB CHÍNH) ═══
local Tab = Window:MakeTab({Name = "Main Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false})

Tab:AddToggle({
	Name = "Auto Farm Level (Tự nhận Quest)",
	Default = false,
	Callback = function(Value) _G.Settings.AutoFarm = Value end
})

Tab:AddToggle({
	Name = "Kill Aura (Đánh lan cực mạnh)",
	Default = true, -- Mặc định bật để farm cho nhanh
	Callback = function(Value) _G.Settings.KillAura = Value end
})

Tab:AddDropdown({
	Name = "Chọn vũ khí",
	Default = "Melee",
	Options = {"Melee", "Sword", "Fruit"},
	Callback = function(Value) _G.Settings.Weapon = Value end
})

OrionLib:Init()
