--[[
    SENKY ULTRA-LIGHT EDITION
    - Tối ưu Fast Attack (Hinishi Logic)
    - God Mode & Invisible
    - Auto Farm Level mượt nhất
]]

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

_G.Settings = {
    AutoFarm = false,
    FastAttack = true, -- Mặc định bật vì nó xịn
    GodMode = true,
    AutoHaki = true,
    SelectedWeapon = "Melee"
}

-- ═══ CHÔM FAST ATTACK BYPASS (HINISHI LOGIC) ═══
local CombatFramework = require(LP.PlayerScripts.CombatFramework)
local CombatFrameworkR = getupvalues(CombatFramework)[2]

local function FastAttack()
    if not _G.Settings.FastAttack then return end
    pcall(function()
        local AC = CombatFrameworkR.activeController
        if AC and AC.equipped then
            AC.attackInterval = 0
            AC.hitboxMagnitude = 60
            AC:attack()
        end
    end)
end

-- ═══ GOD MODE & INVISIBLE ═══
game:GetService("RunService").Stepped:Connect(function()
    if _G.Settings.GodMode and LP.Character then
        for _, v in pairs(LP.Character:GetChildren()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- ═══ AUTO FARM CORE ═══
local function GetQuest()
    local level = LP.Data.Level.Value
    -- Ví dụ tọa độ Sea 3 (Mày tự dán cái list tọa độ tao đưa lúc nãy vào đây)
    if level >= 1500 then
        return "PortTownQuest", 1, "Pirate Billionaire", CFrame.new(-290, 15, 5308), CFrame.new(-435, 189, 5551)
    end
    -- Thêm các mốc khác ở đây...
end

spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarm then
            pcall(function()
                local qName, qNum, mName, qPos, mPos = GetQuest()
                
                -- Nhận Quest nếu chưa có
                if not LP.PlayerGui.Main.Quest.Visible then
                    LP.Character.HumanoidRootPart.CFrame = qPos
                    task.wait(0.5)
                    RS.Remotes.CommF_:InvokeServer("StartQuest", qName, qNum)
                end

                -- Farm quái
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == mName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        repeat
                            task.wait()
                            if not _G.Settings.AutoFarm or v.Humanoid.Health <= 0 then break end
                            
                            -- Auto Haki
                            if _G.Settings.AutoHaki and not LP.Character:FindFirstChild("HasBuso") then
                                RS.Remotes.CommF_:InvokeServer("Buso")
                            end

                            -- Equip Tool
                            local tool = LP.Backpack:FindFirstChild(_G.Settings.SelectedWeapon) or LP.Character:FindFirstChild(_G.Settings.SelectedWeapon)
                            if tool then LP.Character.Humanoid:EquipTool(tool) end

                            -- Teleport & Attack
                            LP.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                            FastAttack()
                        until v.Humanoid.Health <= 0
                    end
                end
                
                -- Nếu không thấy quái thì bay về bãi
                if not workspace.Enemies:FindFirstChild(mName) then
                    TS:Create(LP.Character.HumanoidRootPart, TweenInfo.new(1), {CFrame = mPos}):Play()
                end
            end)
        end
    end
end)

-- ═══ GIAO DIỆN ĐƠN SƠ (QUICK MENU) ═══
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.5, -100, 0, 50)
Frame.BackgroundColor3 = Color3.new(0,0,0)
Frame.BackgroundTransparency = 0.5
Frame.Active = true
Frame.Draggable = true

local function CreateBtn(text, pos, callback)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, pos)
    btn.Text = text
    btn.MouseButton1Click:Connect(callback)
end

CreateBtn("Auto Farm: OFF", 10, function(rb)
    _G.Settings.AutoFarm = not _G.Settings.AutoFarm
    rb.Text = "Auto Farm: " .. (_G.Settings.AutoFarm and "ON" or "OFF")
end)

CreateBtn("God Mode: ON", 60, function(rb)
    _G.Settings.GodMode = not _G.Settings.GodMode
    rb.Text = "God Mode: " .. (_G.Settings.GodMode and "ON" or "OFF")
end)

print("✅ Senky Ultra-Light Loaded!")
