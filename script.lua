--[[
    SENKY ULTRA-LIGHT FIXED
    - Hiện Menu 100%
    - Fast Attack Hinishi
    - Auto Farm & Stats
]]

-- Chờ game load xong
if not game:IsLoaded() then game.Loaded:Wait() end

local LP = game.Players.LocalPlayer
local RS = game.ReplicatedStorage

_G.Settings = {
    AutoFarm = false,
    GodMode = true,
    FastAttack = true,
    AutoStats = true
}

-- ═══ HÀM VẼ MENU (FIX HIỆN THỊ) ═══
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SenkyMenu"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 180, 0, 220)
MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true -- Có thể kéo đi trên màn hình
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "SENKY HUB"
Title.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
Title.TextColor3 = Color3.new(1,1,1)
Title.Parent = MainFrame

function CreateToggle(text, pos, setting)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, pos)
    btn.Text = "❌ " .. text
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = MainFrame
    
    btn.MouseButton1Click:Connect(function()
        _G.Settings[setting] = not _G.Settings[setting]
        btn.Text = (_G.Settings[setting] and "✅ " or "❌ ") .. text
        btn.BackgroundColor3 = _G.Settings[setting] and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
    end)
end

CreateToggle("Auto Farm", 40, "AutoFarm")
CreateToggle("God Mode", 85, "GodMode")
CreateToggle("Fast Attack", 130, "FastAttack")
CreateToggle("Auto Stats", 175, "AutoStats")

-- ═══ LOGIC FAST ATTACK (HINISHI CHÔM) ═══
local CombatFramework = require(LP.PlayerScripts.CombatFramework)
local CombatFrameworkR = getupvalues(CombatFramework)[2]

task.spawn(function()
    while task.wait() do
        if _G.Settings.FastAttack then
            pcall(function()
                local AC = CombatFrameworkR.activeController
                if AC and AC.equipped then
                    AC.attackInterval = 0
                    AC.hitboxMagnitude = 60
                    AC:attack()
                end
            end)
        end
    end
end)

-- ═══ AUTO STATS SIÊU TỐC ═══
task.spawn(function()
    while task.wait(1) do
        if _G.Settings.AutoStats then
            pcall(function()
                if LP.Data.Points.Value > 0 then
                    RS.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
                end
            end)
        end
    end
end)

-- ═══ GOD MODE XUYÊN SUỐT ═══
game:GetService("RunService").Stepped:Connect(function()
    if _G.Settings.GodMode and LP.Character then
        for _, v in pairs(LP.Character:GetChildren()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- ═══ AUTO FARM LEVEL ═══
task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarm then
            pcall(function()
                -- Ví dụ Sea 3 - Mày hãy dán đống tọa độ tao đưa vào đây
                local mName = "Pirate Billionaire"
                local qName = "PortTownQuest"
                local mPos = CFrame.new(-435, 189, 5551)
                
                if not LP.PlayerGui.Main.Quest.Visible then
                    LP.Character.HumanoidRootPart.CFrame = CFrame.new(-290, 15, 5308)
                    task.wait(0.5)
                    RS.Remotes.CommF_:InvokeServer("StartQuest", qName, 1)
                end

                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == mName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        repeat
                            task.wait()
                            LP.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                            -- Auto Equip
                            local tool = LP.Backpack:FindFirstChild("Melee") or LP.Character:FindFirstChild("Melee")
                            if tool then LP.Character.Humanoid:EquipTool(tool) end
                        until not _G.Settings.AutoFarm or v.Humanoid.Health <= 0
                    end
                end
                
                if not workspace.Enemies:FindFirstChild(mName) then
                    LP.Character.HumanoidRootPart.CFrame = mPos
                end
            end)
        end
    end
end)
