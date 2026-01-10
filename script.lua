-- [[ CHIẾN THẦN HUB - FINAL EDITION 😈 ]] --
-- [[ ĐỒNG BỌN: ADMIN ID 1180691145630683216 ]] --

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Chiến Thần Hub 😈", HidePremium = false, SaveConfig = true, ConfigFolder = "ChienThanConfig"})

-- [[ BIẾN TOÀN CỤC ]] --
_G.AutoFarm = false
_G.SuperFastAttack = false
_G.AutoHop = false
_G.HopTime = 15
_G.Team = "Marines"
local WeaponSelected = ""

-- [[ TỰ ĐỘNG CHỌN TEAM KHI VÀO ]] --
local function JoinTeam()
    pcall(function()
        local TeamGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("RaceC") or game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ChooseTeam")
        if TeamGui then
            local Button = (_G.Team == "Marines") and TeamGui.Container.Marines.Frame.ViewportFrame.TextButton or TeamGui.Container.Pirates.Frame.ViewportFrame.TextButton
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(Button.AbsolutePosition.X + Button.AbsoluteSize.X/2, Button.AbsolutePosition.Y + Button.AbsoluteSize.Y/2, 0, true, game, 1)
        end
    end)
end
task.spawn(JoinTeam)

-- [[ HÀM GOM QUÁI & FARM ]] --
function CheckAndFarm()
    spawn(function()
        while _G.AutoFarm do
            task.wait()
            pcall(function()
                for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        repeat
                            task.wait()
                            if not _G.AutoFarm then break end
                            -- Trang bị vũ khí
                            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(WeaponSelected) or game.Players.LocalPlayer.Character:FindFirstChild(WeaponSelected)
                            if tool then game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool) end
                            
                            -- Gom quái & Hitbox
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                            
                            -- Đánh thường
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                        until v.Humanoid.Health <= 0 or not _G.AutoFarm
                    end
                end
            end)
        end
    end)
end

-- [[ HÀM NHẢY SERVER ]] --
function ServerHop()
    local PlaceID = game.PlaceId
    local Site = game:GetService("HttpService"):JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    for i,v in pairs(Site.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, v.id)
            break
        end
    end
end

-- [[ GIAO DIỆN ]] --
local MainTab = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})

MainTab:AddDropdown({
	Name = "Chọn Vũ Khí",
	Default = "",
	Options = {"Melee", "Sword", "Blox Fruit", "Gun"}, -- Tự chỉnh danh sách nhanh
	Callback = function(Value) WeaponSelected = Value end    
})

MainTab:AddToggle({
	Name = "Auto Farm Level",
	Default = false,
	Callback = function(Value)
		_G.AutoFarm = Value
		if Value then CheckAndFarm() end
	end    
})

MainTab:AddToggle({
	Name = "Super Fast Attack",
	Default = false,
	Callback = function(Value) _G.SuperFastAttack = Value end
})

local SettingTab = Window:MakeTab({Name = "Cài Đặt", Icon = "rbxassetid://4483345998", PremiumOnly = false})

SettingTab:AddToggle({
	Name = "Auto Server Hop",
	Default = false,
	Callback = function(Value) _G.AutoHop = Value end
})

OrionLib:Init()