-- [[ SENKY HUB - AUTO QUEST & FARM SEA 1 ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Senky Hub 😈 | Admin: 1180691145630683216",
   LoadingTitle = "Đang kết nối hệ thống...",
   LoadingSubtitle = "by Senky"
})

-- [[ BIẾN HỆ THỐNG ]] --
_G.AutoFarm = false
local Player = game.Players.LocalPlayer

-- [[ BẢNG DỮ LIỆU NHIỆM VỤ SEA 1 ]] --
function GetQuestData()
    local lvl = Player.Data.Level.Value
    if lvl >= 1 and lvl < 10 then
        return "Bandit", "BanditQuest1", 1, CFrame.new(1059, 15, 1549) -- NPC Bandit
    elseif lvl >= 10 and lvl < 15 then
        return "Monkey", "JungleQuest", 1, CFrame.new(-1598, 35, 153) -- NPC Monkey
    elseif lvl >= 15 and lvl < 30 then
        return "Gorilla", "JungleQuest", 2, CFrame.new(-1598, 35, 153) -- NPC Gorilla
    elseif lvl >= 30 and lvl < 60 then
        return "Pirate", "BuggyQuest1", 1, CFrame.new(-1141, 4, 3828) -- NPC Pirate
    -- Tạm thời mốc đầu Sea 1, ông cần thêm mốc nào bảo tôi nhé
    else
        return "Bandit", "BanditQuest1", 1, CFrame.new(1059, 15, 1549)
    end
end

-- [[ LOGIC AUTO FARM & QUEST ]] --
task.spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                local Monster, QuestName, QuestID, NPC_Pos = GetQuestData()

                -- Kiểm tra nếu chưa có nhiệm vụ thì bay đi nhận
                if not Player.PlayerGui.Main:FindFirstChild("Quest") then
                    Player.Character.HumanoidRootPart.CFrame = NPC_Pos
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", QuestName, QuestID)
                else
                    -- Đã có nhiệm vụ thì đi vả quái
                    local Target = game:GetService("Workspace").Enemies:FindFirstChild(Monster) or game:GetService("ReplicatedStorage"):FindFirstChild(Monster)
                    
                    if game:GetService("Workspace").Enemies:FindFirstChild(Monster) then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == Monster and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672)) -- Tự đánh
                                break
                            end
                        end
                    else
                        -- Nếu quái chưa hồi sinh thì bay tới điểm chờ quái
                        Player.Character.HumanoidRootPart.CFrame = NPC_Pos -- Bay tạm về NPC hoặc điểm spawn
                    end
                end
            end)
        end
    end
end)

-- [[ GIAO DIỆN ]] --
local MainTab = Window:CreateTab("Farm Level", 4483345998)

MainTab:CreateToggle({
   Name = "Bật Auto Farm & Quest",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
   end,
})

-- [[ CHECK ADMIN ]] --
local AdminTab = Window:CreateTab("Admin", 4483345998)
AdminTab:CreateButton({
   Name = "Kích hoạt Admin ID",
   Callback = function()
       if Player.UserId == 1180691145630683216 then
           Rayfield:Notify({Title = "OK", Content = "Chào đại ca!", Duration = 3})
       end
   end,
})

Rayfield:Notify({Title = "Xong!", Content = "Hệ thống nhận quest đã sẵn sàng.", Duration = 3})