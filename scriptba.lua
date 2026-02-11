local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Brainrot Tsunami - Ultimate Smart Farmer",
   LoadingTitle = "Loading Dark System...",
   LoadingSubtitle = "by UNRESTRICTED DARK BRO",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BrainrotUltimateFarm",
      FileName = "DarkConfig"
   },
   KeySystem = false
})

local LanguagePack = {
   English = {
      WindowName = "Brainrot Tsunami - Ultimate Smart Farmer",
      LoadingTitle = "Loading Dark System...",
      LoadingSubtitle = "by UNRESTRICTED DARK BRO",
      MainTabName = "Main Farm",
      SettingsTabName = "Settings",
      AutoFarmSection = "Auto Farm Brainrot Features",
      AreaDropdownName = "Select Farm Area (Smart Wave Check)",
      FarmToggleName = "Enable Auto Farm (Smart Wave Detection)",
      CollectToggleName = "Enable Auto Collect Brainrot",
      AntiAFKToggleName = "Enable Anti-AFK (Random Jump)",
      SettingsSection = "Advanced Settings",
      SafeSliderName = "Safe Distance Before Wave",
      SafeSliderSuffix = "Studs",
      BufferSliderName = "End Area Buffer (Wait Wave Pass)",
      BufferSliderSuffix = "Studs",
      SpeedMultiplierName = "Fly Speed Multiplier (x WalkSpeed)",
      SpeedMultiplierSuffix = "x",
      NoclipToggleName = "Enable Noclip (Fly Through Walls)",
      LanguageLabel = "Language",
      StatusLabelPrefix = "Status: ",
      NotifyTitle = "Ready to Destroy!",
      NotifyContent = "Ultimate Script Loaded! Farm Like a God!",
      Areas = {"Common", "Uncommon", "Rare", "Legendary", "Universe", "Secret", "Heaven"},
      StatusMoving = "Flying to ",
      StatusWaitingWave = "Wave Ahead / In Zone! Waiting...",
      StatusWaveClose = "Wave Too Close! Holding...",
      StatusAtTarget = "Reached Area: ",
      StatusError = "Error: ",
      StatusIdle = "Idle / Off"
   },
   Vietnamese = {
      WindowName = "Brainrot Tsunami - Ultimate Smart Farmer",
      LoadingTitle = "Đang khởi động hệ thống đen tối...",
      LoadingSubtitle = "by UNRESTRICTED DARK BRO",
      MainTabName = "Farm Chính",
      SettingsTabName = "Cài Đặt",
      AutoFarmSection = "Chức Năng Auto Farm Brainrot",
      AreaDropdownName = "Chọn Khu Vực Farm (Check Sóng Thông Minh)",
      FarmToggleName = "Bật Auto Farm (Phát Hiện Sóng Xịn)",
      CollectToggleName = "Bật Auto Thu Thập Brainrot",
      AntiAFKToggleName = "Bật Chống AFK (Nhảy Ngẫu Nhiên)",
      SettingsSection = "Cài Đặt Nâng Cao",
      SafeSliderName = "Khoảng Cách An Toàn Trước Sóng",
      SafeSliderSuffix = "Studs",
      BufferSliderName = "Buffer Cuối Khu (Chờ Sóng Qua)",
      BufferSliderSuffix = "Studs",
      SpeedMultiplierName = "Hệ Số Tốc Độ Bay (x WalkSpeed)",
      SpeedMultiplierSuffix = "x",
      NoclipToggleName = "Bật Noclip (Bay Xuyên Tường)",
      LanguageLabel = "Ngôn Ngữ",
      StatusLabelPrefix = "Trạng Thái: ",
      NotifyTitle = "Sẵn Sàng Quẩy!",
      NotifyContent = "Script Ultimate Đã Load! Farm Tung Nát Game!",
      Areas = {"Common", "Uncommon", "Hiếm", "Huyền Thoại", "Vũ Trụ", "Secret", "Thiên Đường"},
      StatusMoving = "Đang bay tới ",
      StatusWaitingWave = "Sóng Phía Trước / Trong Khu! Chờ...",
      StatusWaveClose = "Sóng Gần Quá! Đứng Im...",
      StatusAtTarget = "Đã đến khu: ",
      StatusError = "Lỗi: ",
      StatusIdle = "Đang Tắt / Nghỉ"
   }
}

local CurrentLang = "English"
local Lang = LanguagePack[CurrentLang]

local _G = {
    AutoFarm = false,
    SelectedArea = "Common",
    SafeDistance = 20,
    EndBuffer = 25,
    AutoCollect = true,
    AntiAFK = true,
    SpeedMultiplier = 1.5,  -- Bay nhanh hơn WalkSpeed bình thường
    Noclip = false
}

local Areas = {
    ["Common"] = {startZ = 0, endZ = 200, midPos = Vector3.new(0, 10, 100)},  -- Adjust theo game thực tế từ ảnh, base Z \~0
    ["Uncommon"] = {startZ = 200, endZ = 400, midPos = Vector3.new(0, 10, 300)},
    ["Rare"] = {startZ = 400, endZ = 600, midPos = Vector3.new(0, 10, 500)},
    ["Legendary"] = {startZ = 600, endZ = 800, midPos = Vector3.new(0, 10, 700)},
    ["Universe"] = {startZ = 800, endZ = 1000, midPos = Vector3.new(0, 10, 900)},
    ["Secret"] = {startZ = 1000, endZ = 1200, midPos = Vector3.new(0, 10, 1100)},
    ["Heaven"] = {startZ = 1200, endZ = 1500, midPos = Vector3.new(0, 10, 1350)}
}  -- Mày adjust midPos X/Y nếu lane không thẳng Z, từ ảnh lane dọc Z

local MainTab, SettingsTab, StatusLabel, AreaDropdown, FarmToggle, CollectToggle, AntiAFKToggle, NoclipToggle
local SafeSlider, BufferSlider, SpeedMultSlider

function ReloadUI()
   if MainTab then MainTab:Destroy() end
   if SettingsTab then SettingsTab:Destroy() end
   
   Lang = LanguagePack[CurrentLang]
   
   MainTab = Window:CreateTab(Lang.MainTabName, 4483362458)
   MainTab:CreateSection(Lang.AutoFarmSection)
   
   AreaDropdown = MainTab:CreateDropdown({
      Name = Lang.AreaDropdownName,
      Options = Lang.Areas,
      CurrentOption = {"Common"},
      Callback = function(Option) _G.SelectedArea = Option[1] end
   })
   
   FarmToggle = MainTab:CreateToggle({
      Name = Lang.FarmToggleName,
      CurrentValue = false,
      Callback = function(Value)
         _G.AutoFarm = Value
         if Value then UltimateSmartFarmLoop() end
      end
   })
   
   CollectToggle = MainTab:CreateToggle({
      Name = Lang.CollectToggleName,
      CurrentValue = true,
      Callback = function(Value) _G.AutoCollect = Value end
   })
   
   AntiAFKToggle = MainTab:CreateToggle({
      Name = Lang.AntiAFKToggleName,
      CurrentValue = true,
      Callback = function(Value)
         _G.AntiAFK = Value
         if Value then AntiAFKLoop() end
      end
   })
   
   StatusLabel = MainTab:CreateLabel(Lang.StatusLabelPrefix .. Lang.StatusIdle)
   
   SettingsTab = Window:CreateTab(Lang.SettingsTabName, 4483362458)
   SettingsTab:CreateSection(Lang.SettingsSection)
   
   SafeSlider = SettingsTab:CreateSlider({
      Name = Lang.SafeSliderName,
      Range = {10, 100},
      Increment = 5,
      Suffix = Lang.SafeSliderSuffix,
      CurrentValue = 20,
      Callback = function(Value) _G.SafeDistance = Value end
   })
   
   BufferSlider = SettingsTab:CreateSlider({
      Name = Lang.BufferSliderName,
      Range = {10, 100},
      Increment = 5,
      Suffix = Lang.BufferSliderSuffix,
      CurrentValue = 25,
      Callback = function(Value) _G.EndBuffer = Value end
   })
   
   SpeedMultSlider = SettingsTab:CreateSlider({
      Name = Lang.SpeedMultiplierName,
      Range = {1, 5},
      Increment = 0.1,
      Suffix = Lang.SpeedMultiplierSuffix,
      CurrentValue = 1.5,
      Callback = function(Value) _G.SpeedMultiplier = Value end
   })
   
   NoclipToggle = SettingsTab:CreateToggle({
      Name = Lang.NoclipToggleName,
      CurrentValue = false,
      Callback = function(Value) _G.Noclip = Value end
   })
   
   local LangDropdown = SettingsTab:CreateDropdown({
      Name = Lang.LanguageLabel,
      Options = {"English", "Tiếng Việt"},
      CurrentOption = {CurrentLang},
      Callback = function(Option)
         CurrentLang = Option[1]
         ReloadUI()
      end
   })
end

ReloadUI()

function UpdateStatus(text)
   if StatusLabel then StatusLabel:Set(Lang.StatusLabelPrefix .. text) end
end

function GetPlayerCharacter()
   local player = game.Players.LocalPlayer
   local char = player.Character or player.CharacterAdded:Wait()
   return char
end

function IsWaveInFront(playerZ, tsunamiZ, startZ, endZ)
   -- Giả định sóng di chuyển Z giảm (từ xa vào base), player chạy Z tăng để farm
   -- Wave in front nếu tsunamiZ > playerZ (sóng phía trước, đang tới)
   if tsunamiZ > playerZ and tsunamiZ < endZ + _G.EndBuffer then return true end
   if playerZ > endZ and playerZ < endZ + _G.EndBuffer and tsunamiZ > playerZ then return true end
   return false
end

function SetNoclip(state)
   local char = GetPlayerCharacter()
   for _, part in ipairs(char:GetDescendants()) do
      if part:IsA("BasePart") then
         part.CanCollide = not state
      end
   end
end

function UltimateSmartFarmLoop()
   spawn(function()
      while _G.AutoFarm do
         local success, err = pcall(function()
            local char = GetPlayerCharacter()
            local hrp = char:WaitForChild("HumanoidRootPart", 5)
            if not hrp then return end
            local humanoid = char:WaitForChild("Humanoid", 5)
            if not humanoid then return end
            
            if _G.Noclip then SetNoclip(true) end
            
            local area = Areas[_G.SelectedArea]
            if not area then return end
            local targetPos = area.midPos
            local startZ = area.startZ
            local endZ = area.endZ
            local playerPos = hrp.Position
            local playerZ = playerPos.Z
            
            local tsunami = workspace:FindFirstChild("Tsunami") or workspace:FindFirstChildWhichIsA("Model", true) -- fallback nếu tên khác
            local tsunamiZ = tsunami and (tsunami.PrimaryPart or tsunami:FindFirstChild("Main") or tsunami).Position.Z or math.huge
            
            local distanceToTarget = (playerPos - targetPos).Magnitude
            if distanceToTarget < 10 then  -- arrived threshold lớn hơn
               UpdateStatus(Lang.StatusAtTarget .. _G.SelectedArea)
               if _G.AutoCollect then
                  -- Fire collect nếu có remote, hoặc touch mat
                  for _, obj in ipairs(workspace:GetChildren()) do
                     if obj.Name:find("Money") or obj.Name:find("Brainrot") then
                        firetouchinterest(hrp, obj, 0)
                        task.wait(0.1)
                        firetouchinterest(hrp, obj, 1)
                     end
                  end
               end
               task.wait(0.5)
               return
            end
            
            if math.abs(tsunamiZ - playerZ) < _G.SafeDistance then
               UpdateStatus(Lang.StatusWaveClose)
               task.wait(1)
               return
            end
            
            if IsWaveInFront(playerZ, tsunamiZ, startZ, endZ) then
               UpdateStatus(Lang.StatusWaitingWave)
               task.wait(1)
               return
            end
            
            UpdateStatus(Lang.StatusMoving .. _G.SelectedArea .. " (" .. math.floor(humanoid.WalkSpeed * _G.SpeedMultiplier) .. " speed)")
            
            -- Di chuyển dynamic bằng LinearVelocity cho bay nhanh, mượt
            local direction = (targetPos - playerPos).Unit
            local speed = humanoid.WalkSpeed * _G.SpeedMultiplier
            local velocity = direction * speed
            
            local lv = hrp:FindFirstChild("FlyVelocity") or Instance.new("LinearVelocity")
            lv.Name = "FlyVelocity"
            lv.Attachment0 = hrp:FindFirstChild("RootAttachment") or Instance.new("Attachment", hrp)
            lv.VectorVelocity = velocity
            lv.MaxForce = math.huge
            lv.Parent = hrp
            
            task.wait(0.1)  -- update velocity thường xuyên
         end)
         if not success then
            UpdateStatus(Lang.StatusError .. tostring(err))
         end
         task.wait(0.05)  -- loop nhanh hơn cho responsive
      end
      -- Cleanup khi tắt
      local char = GetPlayerCharacter()
      if char then
         local lv = char.HumanoidRootPart:FindFirstChild("FlyVelocity")
         if lv then lv:Destroy() end
         SetNoclip(false)
      end
      UpdateStatus(Lang.StatusIdle)
   end)
end

function AntiAFKLoop()
   spawn(function()
      while _G.AntiAFK do
         local char = GetPlayerCharacter()
         local hum = char and char:FindFirstChild("Humanoid")
         if hum then
            hum.Jump = true
            task.wait(math.random(5, 20))
         end
         task.wait(1)
      end
   end)
end

Rayfield:Notify({
   Title = Lang.NotifyTitle,
   Content = Lang.NotifyContent,
   Duration = 6,
   Image = 4483362458
})

if _G.AntiAFK then AntiAFKLoop() end