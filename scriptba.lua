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

-- Ngôn ngữ pack
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
      CollectToggleName = "Enable Auto Collect Brainrot (If Available)",
      AntiAFKToggleName = "Enable Anti-AFK (Random Jump)",
      SettingsSection = "Advanced Settings",
      SafeSliderName = "Safe Distance Before Wave",
      SafeSliderSuffix = "Studs",
      BufferSliderName = "End Area Buffer (Wait for Wave Pass)",
      BufferSliderSuffix = "Studs",
      SpeedSliderName = "Tween Movement Speed",
      SpeedSliderSuffix = "Speed",
      LanguageLabel = "Language",
      StatusLabelPrefix = "Status: ",
      NotifyTitle = "Ready to Destroy!",
      NotifyContent = "Ultimate Script Loaded! Let's Farm!",
      Areas = {"Uncommon", "Common", "Rare", "Legendary", "Universe", "Secret", "Heaven"},
      StatusMoving = "Moving to ",
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
      CollectToggleName = "Bật Auto Thu Thập Brainrot (Nếu Có)",
      AntiAFKToggleName = "Bật Chống AFK (Nhảy Ngẫu Nhiên)",
      SettingsSection = "Cài Đặt Nâng Cao",
      SafeSliderName = "Khoảng Cách An Toàn Trước Sóng",
      SafeSliderSuffix = "Studs",
      BufferSliderName = "Buffer Cuối Khu (Chờ Sóng Qua)",
      BufferSliderSuffix = "Studs",
      SpeedSliderName = "Tốc Độ Di Chuyển Tween",
      SpeedSliderSuffix = "Tốc Độ",
      LanguageLabel = "Ngôn Ngữ",
      StatusLabelPrefix = "Trạng Thái: ",
      NotifyTitle = "Sẵn Sàng Quẩy!",
      NotifyContent = "Script Ultimate Đã Load! Farm Tung Nát Game!",
      Areas = {"Uncommon", "Common", "Hiếm", "Huyền Thoại", "Vũ Trụ", "Secret", "Thiên Đường"},
      StatusMoving = "Đang di chuyển tới ",
      StatusWaitingWave = "Sóng Phía Trước / Trong Khu! Chờ...",
      StatusWaveClose = "Sóng Gần Quá! Đứng Im...",
      StatusAtTarget = "Đã đến khu: ",
      StatusError = "Lỗi: ",
      StatusIdle = "Đang Tắt / Nghỉ"
   }
}

-- Biến global
local CurrentLang = "English"  -- Default English
local Lang = LanguagePack[CurrentLang]

local _G = {
    AutoFarm = false,
    SelectedArea = "Common",
    SafeDistance = 20,
    EndBuffer = 25,
    AutoCollect = true,
    AntiAFK = true,
    TweenSpeed = 50
}

local Areas = {
    ["Uncommon"] = {startZ = 150, endZ = 250, midPos = Vector3.new(200, 5, 200)},
    ["Common"] = {startZ = 50, endZ = 150, midPos = Vector3.new(100, 5, 100)},
    ["Rare"] = {startZ = 250, endZ = 350, midPos = Vector3.new(300, 5, 300)},
    ["Legendary"] = {startZ = 350, endZ = 450, midPos = Vector3.new(400, 5, 400)},
    ["Universe"] = {startZ = 450, endZ = 550, midPos = Vector3.new(500, 5, 500)},
    ["Secret"] = {startZ = 550, endZ = 650, midPos = Vector3.new(600, 5, 600)},
    ["Heaven"] = {startZ = 650, endZ = 750, midPos = Vector3.new(700, 5, 700)}
}

-- Biến UI để reload khi đổi ngôn ngữ
local MainTab, SettingsTab, StatusLabel, AreaDropdown, FarmToggle, CollectToggle, AntiAFKToggle
local SafeSlider, BufferSlider, SpeedSlider

function ReloadUI()
   -- Destroy old tabs if exist
   if MainTab then MainTab:Destroy() end
   if SettingsTab then SettingsTab:Destroy() end
   
   Lang = LanguagePack[CurrentLang]
   
   MainTab = Window:CreateTab(Lang.MainTabName, 4483362458)
   local MainSection = MainTab:CreateSection(Lang.AutoFarmSection)
   
   AreaDropdown = MainTab:CreateDropdown({
      Name = Lang.AreaDropdownName,
      Options = Lang.Areas,
      CurrentOption = {Lang.Areas[2]},  -- Default Common (index 2 in list)
      MultipleOptions = false,
      Callback = function(Option)
         _G.SelectedArea = Option[1]
      end
   })
   
   FarmToggle = MainTab:CreateToggle({
      Name = Lang.FarmToggleName,
      CurrentValue = false,
      Flag = "FarmToggle",
      Callback = function(Value)
         _G.AutoFarm = Value
         if Value then
            UltimateSmartFarmLoop()
         end
      end
   })
   
   CollectToggle = MainTab:CreateToggle({
      Name = Lang.CollectToggleName,
      CurrentValue = true,
      Flag = "CollectToggle",
      Callback = function(Value)
         _G.AutoCollect = Value
      end
   })
   
   AntiAFKToggle = MainTab:CreateToggle({
      Name = Lang.AntiAFKToggleName,
      CurrentValue = true,
      Flag = "AntiAFKToggle",
      Callback = function(Value)
         _G.AntiAFK = Value
         if Value then
            AntiAFKLoop()
         end
      end
   })
   
   StatusLabel = MainTab:CreateLabel(Lang.StatusLabelPrefix .. Lang.StatusIdle)
   
   SettingsTab = Window:CreateTab(Lang.SettingsTabName, 4483362458)
   local SettingsSection = SettingsTab:CreateSection(Lang.SettingsSection)
   
   SafeSlider = SettingsTab:CreateSlider({
      Name = Lang.SafeSliderName,
      Range = {10, 50},
      Increment = 5,
      Suffix = Lang.SafeSliderSuffix,
      CurrentValue = 20,
      Flag = "SafeSlider",
      Callback = function(Value)
         _G.SafeDistance = Value
      end
   })
   
   BufferSlider = SettingsTab:CreateSlider({
      Name = Lang.BufferSliderName,
      Range = {10, 50},
      Increment = 5,
      Suffix = Lang.BufferSliderSuffix,
      CurrentValue = 25,
      Flag = "BufferSlider",
      Callback = function(Value)
         _G.EndBuffer = Value
      end
   })
   
   SpeedSlider = SettingsTab:CreateSlider({
      Name = Lang.SpeedSliderName,
      Range = {30, 100},
      Increment = 5,
      Suffix = Lang.SpeedSliderSuffix,
      CurrentValue = 50,
      Flag = "SpeedSlider",
      Callback = function(Value)
         _G.TweenSpeed = Value
      end
   })
   
   local LangDropdown = SettingsTab:CreateDropdown({
      Name = Lang.LanguageLabel,
      Options = {"English", "Tiếng Việt"},
      CurrentOption = {CurrentLang},
      MultipleOptions = false,
      Callback = function(Option)
         CurrentLang = Option[1]
         ReloadUI()  -- Reload toàn bộ UI khi đổi ngôn ngữ
      end
   })
end

-- Khởi tạo UI lần đầu
ReloadUI()

function UpdateStatus(text)
   if StatusLabel then
      StatusLabel:Set(Lang.StatusLabelPrefix .. text)
   end
end

function GetPlayerCharacter()
   local player = game.Players.LocalPlayer
   local character = player.Character
   if not character or not character:FindFirstChild("HumanoidRootPart") then
      character = player.CharacterAdded:Wait()
   end
   return character
end

function IsWaveInFront(playerZ, tsunamiZ, startZ, endZ)
   if tsunamiZ > playerZ and tsunamiZ < startZ then return true end
   if playerZ >= startZ and playerZ <= endZ and tsunamiZ >= startZ and tsunamiZ <= endZ then return true end
   if playerZ > endZ and playerZ < endZ + _G.EndBuffer and tsunamiZ <= endZ + _G.EndBuffer then return true end
   return false
end

function TweenToPosition(hrp, targetPos)
   local distance = (hrp.Position - targetPos).Magnitude
   local tweenInfo = TweenInfo.new(distance / _G.TweenSpeed, Enum.EasingStyle.Linear)
   local tween = game:GetService("TweenService"):Create(hrp, tweenInfo, {CFrame = CFrame.new(targetPos)})
   tween:Play()
   tween.Completed:Wait()
end

function UltimateSmartFarmLoop()
   spawn(function()
      while _G.AutoFarm do
         local success, err = pcall(function()
            local character = GetPlayerCharacter()
            local hrp = character:WaitForChild("HumanoidRootPart", 5)
            if not hrp then return end
            local humanoid = character:WaitForChild("Humanoid", 5)
            if not humanoid then return end
            
            local area = Areas[_G.SelectedArea]
            if not area then return end
            local targetPos = area.midPos
            local startZ = area.startZ
            local endZ = area.endZ
            local playerZ = hrp.Position.Z
            
            local tsunami = workspace:FindFirstChild("Tsunami")
            local tsunamiZ = tsunami and tsunami.Position.Z or math.huge
            
            UpdateStatus("Checking Wave...")
            
            if (hrp.Position - targetPos).Magnitude < 5 then
               UpdateStatus(Lang.StatusAtTarget .. _G.SelectedArea)
               if _G.AutoCollect then
                  local collectRemote = game.ReplicatedStorage:FindFirstChild("CollectBrainrot") -- Thay tên remote nếu khác
                  if collectRemote and collectRemote:IsA("RemoteEvent") then
                     collectRemote:FireServer()
                  end
               end
               task.wait(1)
               return
            end
            
            if tsunami and math.abs(tsunamiZ - playerZ) < _G.SafeDistance then
               UpdateStatus(Lang.StatusWaveClose)
               task.wait(1)
               return
            end
            
            if tsunami and IsWaveInFront(playerZ, tsunamiZ, startZ, endZ) then
               UpdateStatus(Lang.StatusWaitingWave)
               task.wait(1)
               return
            end
            
            UpdateStatus(Lang.StatusMoving .. _G.SelectedArea)
            TweenToPosition(hrp, targetPos)
         end)
         if not success then
            UpdateStatus(Lang.StatusError .. tostring(err))
         end
         task.wait(0.2)
      end
      UpdateStatus(Lang.StatusIdle)
   end)
end

function AntiAFKLoop()
   spawn(function()
      while _G.AntiAFK do
         local character = GetPlayerCharacter()
         local humanoid = character and character:FindFirstChild("Humanoid")
         if humanoid then
            humanoid.Jump = true
            task.wait(math.random(8, 25))
            humanoid.Jump = false
         end
         task.wait(2)
      end
   end)
end

Rayfield:Notify({
   Title = Lang.NotifyTitle,
   Content = Lang.NotifyContent,
   Duration = 6,
   Image = 4483362458,
   Actions = {
      Ignore = {
         Name = "OK Boss",
         Callback = function() end
      }
   }
})

if _G.AntiAFK then
   AntiAFKLoop()
end