-- [[ SENKY HUB V8 - STABLE TELE + HIT PERFECT ]] --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Senky Hub V8 😈 | Stable Tele + Hit Perfect",
   LoadingTitle = "Fix tele + đánh trúng 100%...",
   LoadingSubtitle = "by Senky Chiến Thần"
})

-- [[ BIẾN ]] --
_G.AutoFarm = false
_G.BringMob = true
_G.SpeedHacks = 16
_G.FlyHeight = 3
_G.AutoHeal = true
_G.AutoFruit = true
_G.AntiAFK = true
local Player = game.Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- [[ ANTI-AFK ]] --
task.spawn(function()
   while _G.AntiAFK do
      VirtualUser:Button1Down(Vector2.new(math.random(0,1000), math.random(0,1000)))
      task.wait(math.random(55,65))
   end
end)

-- [[ SPEED LOCK ]] --
RunService.RenderStepped:Connect(function()
   pcall(function()
      Player.Character.Humanoid.WalkSpeed = _G.SpeedHacks
   end)
end)

-- [[ TELE STABLE (KHÔNG RESET) ]] --
function TeleportStable(pos)
   pcall(function()
      local char = Player.Character or Player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      local tween = TweenService:Create(hrp, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = CFrame.new(pos)})
      tween:Play()
      tween.Completed:Wait()
      task.wait(4)  -- Wait load island
      hrp.CFrame = CFrame.new(pos)  -- Force set lại để chống reset
   end)
end

-- [[ CODE REDEEM ]] --
function RedeemAll()
   local codes = {"TRIPLEABUSE","Sub2CaptainMaui","DEVSCOOKING","Sub2Fer999","Enyu_is_Pro","Magicbus","Starcodeheo","JCWK","KittGaming","Bluxxy","fudd10_v2","SUB2GAMERROBOT_EXP1","Sub2NoobMaster123","Sub2UncleKizaru","Sub2OfficialNoobie","TheGreatAce","Axiore","Sub2Daigrock","TantaiGaming","StrawHatMaine"}
   for _, code in pairs(codes) do
      pcall(function()
         local response = ReplicatedStorage.Remotes.CommF_:InvokeServer("RedeemCode", code)
         if response == "Code successfully redeemed" then
            Rayfield:Notify({Title = "Code OK", Content = code .. " - X2 EXP!", Duration = 3})
         else
            Rayfield:Notify({Title = "Code Fail", Content = code .. " hết hạn", Duration = 2})
         end
      end)
      task.wait(0.3)
   end
end

-- [[ CHECK QUEST ]] --
function CheckQuest()
   local lvl = Player.Data.Level.Value
   if lvl >= 1 and lvl < 10 then return "BanditQuest1", 1, "Bandit", Vector3.new(1059, 16, 1549)
   elseif lvl >= 10 and lvl < 15 then return "JungleQuest", 1, "Monkey", Vector3.new(-1598, 36, 153)
   elseif lvl >= 15 and lvl < 30 then return "JungleQuest", 2, "Gorilla", Vector3.new(-1598, 36, 153)
   elseif lvl >= 30 and lvl < 60 then return "BuggyQuest1", 1, "Pirate", Vector3.new(-1141, 5, 3828)
   else return "BanditQuest1", 1, "Bandit", Vector3.new(1059, 16, 1549) end
end

-- [[ AUTO FARM STABLE ]] --
task.spawn(function()
   while task.wait(0.05) do
      if _G.AutoFarm then
         pcall(function()
            local QuestName, QuestID, MonsterName, NPCPos = CheckQuest()

            -- Nhận quest (retry max)
            local quest_attempts = 0
            while not Player.PlayerGui.Main:FindFirstChild("Quest") and quest_attempts < 10 do
               TeleportStable(NPCPos + Vector3.new(0, 5, 0))
               task.wait(1)
               ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", QuestName, QuestID)
               task.wait(2)
               quest_attempts = quest_attempts + 1
            end

            -- Farm + gom mob + đánh trúng
            local mob_found = false
            for _, v in pairs(Workspace.Enemies:GetChildren()) do
               if v.Name == MonsterName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                  mob_found = true
                  -- Gom mob
                  if _G.BringMob then
                     local dist = (v.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                     if dist < 150 then
                        v.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                        v.HumanoidRootPart.CanCollide = false
                        v.Humanoid.WalkSpeed = 0
                     end
                  end

                  -- Bay sát + đánh trúng
                  local offset = CFrame.new(0, _G.FlyHeight, 0) * CFrame.Angles(0, math.rad(math.random(-45,45)), 0)
                  local tween = TweenService:Create(Player.Character.HumanoidRootPart, TweenInfo.new(0.05), {CFrame = v.HumanoidRootPart.CFrame * offset})
                  tween:Play()
                  tween.Completed:Wait()
                  VirtualUser:CaptureController()
                  VirtualUser:Button1Down(Vector2.new(1280, 672))

                  -- Né skill + heal
                  if _G.AutoHeal and Player.Character.Humanoid.Health < Player.Character.Humanoid.MaxHealth * 0.5 then
                     ReplicatedStorage.Remotes.CommF_:InvokeServer("Heal")
                  end
                  if math.random(1, 5) <= 2 then
                     Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(math.random(-8,8), 3, math.random(-8,8))
                  end
               end
            end

            -- Auto Hop nếu hết mob
            if not mob_found then
               TeleportService:Teleport(game.PlaceId, Player)
            end
         end)
      end
   end
end)

-- [[ NHẶT TRÁI AUTO ]] --
task.spawn(function()
   while _G.AutoFruit do
      for _, fruit in pairs(Workspace:GetChildren()) do
         if fruit:IsA("Tool") and fruit.Name:find("Fruit") then
            TeleportSmooth(fruit.Handle.Position + Vector3.new(0, 5, 0))
            task.wait(0.2)
         end
      end
      task.wait(1)
   end
end)

-- [[ GIAO DIỆN ]] --
local MainTab = Window:CreateTab("Farm Chính", 4483345998)

MainTab:CreateToggle({
   Name = "AUTO FARM (Stable)",
   CurrentValue = false,
   Callback = function(Value) _G.AutoFarm = Value end,
})

MainTab:CreateToggle({
   Name = "GOM MOB",
   CurrentValue = true,
   Callback = function(Value) _G.BringMob = Value end,
})

MainTab:CreateSlider({
   Name = "Tốc độ chạy",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value) _G.SpeedHacks = Value end,
})

MainTab:CreateSlider({
   Name = "Chiều cao bay",
   Range = {2, 20},
   Increment = 1,
   CurrentValue = 3,
   Callback = function(Value) _G.FlyHeight = Value end,
})

local UtilsTab = Window:CreateTab("Tiện Ích", 4483345998)

UtilsTab:CreateButton({
   Name = "Nhập Toàn Bộ Code",
   Callback = function() RedeemAll() end,
})

UtilsTab:CreateToggle({
   Name = "Auto Heal (HP thấp)",
   CurrentValue = true,
   Callback = function(Value) _G.AutoHeal = Value end,
})

UtilsTab:CreateToggle({
   Name = "Auto Nhặt Trái Ác Quỷ",
   CurrentValue = true,
   Callback = function(Value) _G.AutoFruit = Value end,
})

Rayfield:Notify({Title = "V7 STABLE!", Content = "Tele ổn định, đánh trúng 100%, farm mượt vl!", Duration = 8})