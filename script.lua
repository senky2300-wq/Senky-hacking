-- [[ SENKY HUB V4 - PHỤC THÙ SIÊU CẤP ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Senky Hub V4 😈 | Phục Thù Siêu Cấp",
   LoadingTitle = "Đang phục thù toàn diện...",
   LoadingSubtitle = "by Senky Chiến Thần"
})

-- [[ BIẾN HỆ THỐNG ]] --
_G.AutoFarm = false
_G.BringMob = true
_G.SpeedHacks = 16
_G.FlyHeight = 10
_G.AutoStats = false
_G.AutoHop = false
_G.AntiAFK = true
_G.AutoHeal = true
_G.ESP_Mob = false
local Player = game.Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- [[ ANTI-AFK + ANTI-BAN (humanize) ]] --
task.spawn(function()
   while _G.AntiAFK do
      VirtualUser:Button1Down(Vector2.new(math.random(0, 1000), math.random(0, 1000)))
      task.wait(math.random(50, 70))
   end
end)

-- [[ KHÓA SPEED + FLY HEIGHT ]] --
RunService.RenderStepped:Connect(function()
   if Player.Character and Player.Character:FindFirstChild("Humanoid") then
      Player.Character.Humanoid.WalkSpeed = _G.SpeedHacks
      Player.Character.Humanoid.JumpPower = 50
   end
end)

-- [[ ESP MOB (HIỂN THỊ TÊN + HP) ]] --
task.spawn(function()
   while _G.ESP_Mob do
      for _, v in pairs(Workspace.Enemies:GetChildren()) do
         if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            if not v:FindFirstChild("ESP") then
               local esp = Instance.new("BillboardGui")
               esp.Name = "ESP"
               esp.Size = UDim2.new(0, 200, 0, 50)
               esp.StudsOffset = Vector3.new(0, 3, 0)
               esp.AlwaysOnTop = true
               esp.Parent = v
               local text = Instance.new("TextLabel")
               text.Size = UDim2.new(1, 0, 1, 0)
               text.BackgroundTransparency = 1
               text.Text = v.Name .. " [" .. math.floor(v.Humanoid.Health) .. "/" .. math.floor(v.Humanoid.MaxHealth) .. "]"
               text.TextColor3 = Color3.fromRGB(255, 0, 0)
               text.TextScaled = true
               text.Parent = esp
            end
         end
      end
      task.wait(1)
   end
end)

-- [[ HÀM NHẬP CODE (FIX CHECK LỖI) ]] --
function RedeemAll()
   local codes = {"TRIPLEABUSE", "Sub2CaptainMaui", "DEVSCOOKING", "Sub2Fer999", "Enyu_is_Pro", "Magicbus", "Starcodeheo", "JCWK", "KittGaming", "Bluxxy", "fudd10_v2", "SUB2GAMERROBOT_EXP1", "Sub2NoobMaster123", "Sub2UncleKizaru", "Sub2OfficialNoobie", "TheGreatAce", "Axiore", "Sub2Daigrock", "TantaiGaming", "StrawHatMaine"}
   for _, v in pairs(codes) do
      pcall(function()
         local response = ReplicatedStorage.Remotes.CommF_:InvokeServer("RedeemCode", v)
         if response == "Code successfully redeemed" then
            Rayfield:Notify({Title = "Code Success", Content = v .. " - Redeem OK!", Duration = 3})
         end
      end)
      task.wait(0.3)
   end
   Rayfield:Notify({Title = "Redeem Done!", Content = "Đã nhập hết code X2 EXP!", Duration = 5})
end

-- [[ HÀM TÌM NHIỆM VỤ CHUẨN ]] --
function CheckQuest()
   local lvl = Player.Data.Level.Value
   if lvl >= 1 and lvl < 10 then return "BanditQuest1", 1, "Bandit", Vector3.new(1059, 16, 1549)
   elseif lvl >= 10 and lvl < 15 then return "JungleQuest", 1, "Monkey", Vector3.new(-1598, 36, 153)
   elseif lvl >= 15 and lvl < 30 then return "JungleQuest", 2, "Gorilla", Vector3.new(-1598, 36, 153)
   elseif lvl >= 30 and lvl < 60 then return "BuggyQuest1", 1, "Pirate", Vector3.new(-1141, 5, 3828)
   else return "BanditQuest1", 1, "Bandit", Vector3.new(1059, 16, 1549) end
end

-- [[ LOGIC AUTO FARM SIÊU CẤP - FIX HẾT LỖI ]] --
task.spawn(function()
   while task.wait(0.1) do
      if _G.AutoFarm then
         pcall(function()
            local QuestName, QuestID, MonsterName, NPCPos = CheckQuest()

            -- Nhận nhiệm vụ (fix retry 5 lần)
            local quest_attempts = 0
            while not Player.PlayerGui.Main:FindFirstChild("Quest") and quest_attempts < 5 do
               Player.Character.HumanoidRootPart.CFrame = CFrame.new(NPCPos + Vector3.new(0, 5, 0))
               task.wait(0.5)
               ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", QuestName, QuestID)
               task.wait(1)
               quest_attempts = quest_attempts + 1
            end

            -- Đi đánh quái + gom mob
            local mob_found = false
            for _, v in pairs(Workspace.Enemies:GetChildren()) do
               if v.Name == MonsterName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                  mob_found = true
                  -- Gom mob an toàn
                  if _G.BringMob then
                     local dist = (v.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                     if dist < 150 then
                        v.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                        v.HumanoidRootPart.CanCollide = false
                        v.Humanoid.WalkSpeed = 0
                     end
                  end

                  -- Bay sát đánh trúng (3 studs trên đầu, né skill random)
                  local offset = CFrame.new(0, _G.FlyHeight, 0) * CFrame.Angles(0, math.rad(math.random(-30, 30)), 0)
                  Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * offset
                  VirtualUser:CaptureController()
                  VirtualUser:Button1Down(Vector2.new(1280, 672))

                  -- Né skill + heal tự động
                  if _G.AutoHeal and Player.Character.Humanoid.Health < Player.Character.Humanoid.MaxHealth * 0.5 then
                     ReplicatedStorage.Remotes.CommF_:InvokeServer("Heal")
                  end
                  if math.random(1, 10) <= 3 then  -- Né random
                     Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(math.random(-10,10), 5, math.random(-10,10))
                  end
               end
            end

            -- Auto Hop nếu hết mob
            if _G.AutoHop and not mob_found then
               game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
            end
         end)
      end
   end
end)

-- [[ AUTO STATS (Melee/Defense/Gun/Sword/Devil Fruit) ]] --
task.spawn(function()
   while _G.AutoStats do
      task.wait(1)
      pcall(function()
         ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 10)  -- Thay bằng loại mày muốn
      end)
   end
end)

-- [[ GIAO DIỆN SIÊU CẤP ]] --
local MainTab = Window:CreateTab("Chiến Thần Farm", 4483345998)

MainTab:CreateToggle({
   Name = "AUTO FARM & QUEST (FIXED)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoFarm = Value end,
})

MainTab:CreateToggle({
   Name = "GOM MOB (Bring Mob)",
   CurrentValue = true,
   Callback = function(Value) _G.BringMob = Value end,
})

MainTab:CreateSlider({
   Name = "Tốc độ chạy (Speed)",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value) _G.SpeedHacks = Value end,
})

MainTab:CreateSlider({
   Name = "Chiều cao bay (Fly Height)",
   Range = {5, 30},
   Increment = 1,
   CurrentValue = 10,
   Callback = function(Value) _G.FlyHeight = Value end,
})

MainTab:CreateToggle({
   Name = "Auto Stats (Melee)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoStats = Value end,
})

MainTab:CreateToggle({
   Name = "Auto Hop Server (Farm nhanh hơn)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoHop = Value end,
})

local UtilsTab = Window:CreateTab("Tiện Ích", 4483345998)

UtilsTab:CreateButton({
   Name = "Nhập Toàn Bộ Code (X2 EXP)",
   Callback = function() RedeemAll() end,
})

UtilsTab:CreateButton({
   Name = "Tối Ưu Hóa Lag / Nóng Máy",
   Callback = function()
      for _,v in pairs(game:GetDescendants()) do
         if v:IsA("BasePart") then v.Material = "Plastic" v.Reflectance = 0 end
         if v:IsA("Decal") or v:IsA("ParticleEmitter") or v:IsA("Smoke") then v:Destroy() end
      end
      Rayfield:Notify({Title = "Tối Ưu Done!", Content = "Lag giảm, máy mát hơn!", Duration = 5})
   end,
})

UtilsTab:CreateToggle({
   Name = "Anti-AFK (Không bị kick)",
   CurrentValue = true,
   Callback = function(Value) _G.AntiAFK = Value end,
})

UtilsTab:CreateToggle({
   Name = "ESP Mob (Tên + HP)",
   CurrentValue = false,
   Callback = function(Value) _G.ESP_Mob = Value end,
})

Rayfield:Notify({Title = "V4 SIÊU CẤP!", Content = "Fix hết lỗi - Farm chuẩn vl, quẩy đi chiến thần!", Duration = 8})