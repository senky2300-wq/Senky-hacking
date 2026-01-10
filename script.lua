-- [[ SENKY HUB - PHIÊN BẢN CHIẾN THẦN 2026 ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Senky Hub 😈 | Admin: 1180691145630683216",
   LoadingTitle = "Đang nạp code từ Thế Giới Di Động...",
   LoadingSubtitle = "by Senky"
})

-- [[ BIẾN HỆ THỐNG ]] --
_G.AutoFarm = false
_G.FastAttack = true
_G.BringMob = true
local Player = game.Players.LocalPlayer

-- [[ DANH SÁCH CODE MỚI NHẤT (01/2026) ]] --
local ListCodes = {"LIGHTNINGABUSE", "fudd10_V2", "fudd10", "SUB2GAMERROBOT_EXP1", "BIGNEWS", "KITT_RESET", "Sub2UncleKizaru", "SUB2GAMERROBOT_RESET1", "Sub2CaptainMaui", "DEVSCOOKING", "Sub2Fer999", "Enyu_is_Pro", "Magicbus", "Starcodeheo", "JCWK", "KittGaming", "Bluxxy", "Sub2OfficialNoobie", "TheGreatAce", "Sub2NoobMaster123", "Sub2Daigrock", "Axiore", "StrawHatMaine", "TantaiGaming"}

function AutoRedeemAllCodes()
    for _, code in pairs(ListCodes) do
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RedeemCode", code)
        task.wait(0.1)
    end
end

-- [[ HÀM TÌM NHIỆM VỤ (SEA 1) ]] --
function GetQuest()
    local lvl = Player.Data.Level.Value
    if lvl >= 1 and lvl < 10 then return "BanditQuest1", 1, "Bandit", CFrame.new(1059, 15, 1549)
    elseif lvl >= 10 and lvl < 15 then return "JungleQuest", 1, "Monkey", CFrame.new(-1598, 35, 153)
    elseif lvl >= 15 and lvl < 30 then return "JungleQuest", 2, "Gorilla", CFrame.new(-1598, 35, 153)
    elseif lvl >= 30 and lvl < 60 then return "BuggyQuest1", 1, "Pirate", CFrame.new(-1141, 4, 3828)
    -- Thêm các mốc khác tại đây
    else return "BanditQuest1", 1, "Bandit", CFrame.new(1059, 15, 1549) end
end

-- [[ LOGIC FARM SIÊU CẤP ]] --
task.spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                local QuestName, QuestID, MonsterName, NPCPos = GetQuest()
                
                -- 1. KIỂM TRA NHIỆM VỤ
                if not Player.PlayerGui.Main:FindFirstChild("Quest") then
                    Player.Character.HumanoidRootPart.CFrame = NPCPos
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", QuestName, QuestID)
                else
                    -- 2. TÌM VÀ GOM QUÁI
                    local Monster = game:GetService("Workspace").Enemies:FindFirstChild(MonsterName)
                    if Monster and Monster:FindFirstChild("Humanoid") and Monster.Humanoid.Health > 0 then
                        -- Bay lên đầu quái
                        Player.Character.HumanoidRootPart.CFrame = Monster.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0)
                        
                        -- Gom quái (Bring Mob)
                        if _G.BringMob then
                            for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == MonsterName and v:FindFirstChild("HumanoidRootPart") then
                                    v.HumanoidRootPart.CFrame = Monster.HumanoidRootPart.CFrame
                                    v.HumanoidRootPart.CanCollide = false
                                end
                            end
                        end
                        
                        -- 3. ĐÁNH NHANH (FAST ATTACK)
                        if _G.FastAttack then
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                        end
                    else
                        -- Bay tới điểm spawn quái nếu không thấy
                        Player.Character.HumanoidRootPart.CFrame = NPCPos * CFrame.new(0, 50, 0)
                    end
                end
            end)
        end
    end
end)

-- [[ GIAO DIỆN ]] --
local MainTab = Window:CreateTab("Chiến Thần Farm", 4483345998)

MainTab:CreateToggle({
   Name = "BẬT AUTO FARM & NHẬN QUEST",
   CurrentValue = false,
   Callback = function(Value) _G.AutoFarm = Value end,
})

MainTab:CreateToggle({
   Name = "Gom Quái (Bring Mob)",
   CurrentValue = true,
   Callback = function(Value) _G.BringMob = Value end,
})

local CodeTab = Window:CreateTab("Mã Code", 4483345998)
CodeTab:CreateButton({
   Name = "Nhập Toàn Bộ Code 2026 (TGDD)",
   Callback = function() 
      AutoRedeemAllCodes()
      Rayfield:Notify({Title = "Xong!", Content = "Đã nhập hết code x2 EXP cho ông rồi đó!", Duration = 5})
   end,
})

local UtilsTab = Window:CreateTab("Tối Ưu", 4483345998)
UtilsTab:CreateButton({
   Name = "Bật Chế Độ Mượt (White Screen)",
   Callback = function() game:GetService("RunService"):Set3dRenderingEnabled(false) end,
})

Rayfield:Notify({Title = "Senky Hub", Content = "Bản 2026 đã sẵn sàng!", Duration = 5})