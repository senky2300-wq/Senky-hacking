-- [[ SENKY HUB - PHIÊN BẢN GỘP SIÊU CẤP ]] --
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Senky Hub 😈", HidePremium = false, SaveConfig = true, ConfigFolder = "SenkyConfig"})

-- [[ BIẾN HỆ THỐNG ]] --
_G.AutoFarm = false
_G.FastAttack = false
local Player = game:GetService("Players").LocalPlayer

-- [[ HÀM TÌM NHIỆM VỤ THEO LEVEL ]] --
function GetQuest()
    local lvl = Player.Data.Level.Value
    if lvl >= 1 and lvl < 10 then
        return "Bandit", "BanditQuest1", 1
    elseif lvl >= 10 and lvl < 15 then
        return "Monkey", "JungleQuest", 1
    elseif lvl >= 15 and lvl < 30 then
        return "Gorilla", "JungleQuest", 2
    elseif lvl >= 30 and lvl < 700 then
        -- Tạm thời để mốc cơ bản, ông muốn Full thì bảo tôi nhé
        return "Pirate", "BuggyQuest1", 1
    else
        return "Bandit", "BanditQuest1", 1
    end
end

-- [[ LOGIC AUTO FARM (BÓNG ĐÊM) ]] --
task.spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                local MonsterName, QuestName, QuestID = GetQuest()
                
                -- Kiểm tra xem đã nhận nhiệm vụ chưa
                if not Player.PlayerGui.Main:FindFirstChild("Quest") then
                    -- Code bay đi nhận Quest (Đây là mẫu, cần tọa độ NPC cụ thể)
                    -- game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Tọa_Độ_NPC)
                end

                -- Tìm quái và diệt
                local Target = game:GetService("Workspace").Enemies:FindFirstChild(MonsterName)
                if Target and Target:FindFirstChild("Humanoid") and Target.Humanoid.Health > 0 then
                    Player.Character.HumanoidRootPart.CFrame = Target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                else
                    -- Nếu không thấy quái thì bay đến chỗ quái spawn
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == MonsterName then
                            Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                        end
                    end
                end
            end)
        end
    end
end)

-- [[ GIAO DIỆN CHÍNH ]] --
local MainTab = Window:MakeTab({
	Name = "Main Farm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

MainTab:AddToggle({
	Name = "Auto Farm Level (XỊN)",
	Default = false,
	Callback = function(Value)
		_G.AutoFarm = Value
	end    
})

MainTab:AddToggle({
	Name = "Fast Attack (Đánh Nhanh)",
	Default = false,
	Callback = function(Value)
		_G.FastAttack = Value
	end    
})

-- [[ TAB HỆ THỐNG (ADMIN ID CỦA ÔNG) ]] --
local SettingTab = Window:MakeTab({
	Name = "Hệ Thống",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

SettingTab:AddButton({
	Name = "Check Admin ID",
	Callback = function()
		if Player.UserId == 1180691145630683216 then
			OrionLib:MakeNotification({Name = "Hệ Thống", Content = "Chào chủ nhân Senky! ID: 1180691145630683216", Time = 5})
		else
			OrionLib:MakeNotification({Name = "Hệ Thống", Content = "Bạn đéo phải chủ nhân Senky!", Time = 5})
		end
	end
})

OrionLib:Init()