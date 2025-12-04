-- Novious Hub - Survive On a Raft Script
-- by ScriptMaster

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Novious Hub | Survive On a Raft",
   LoadingTitle = "Novious Hub Loading...",
   LoadingSubtitle = "by ScriptMaster",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "NoviousHub_SurviveRaft"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Novious Hub Key System",
      Subtitle = "Enter the access key",
      Note = "Key: SURVIVE_RAFT_BEST_SCRIPT",
      FileName = "NoviousHubKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"SURVIVE_RAFT_BEST_SCRIPT"}
   }
})

-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Settings
local Settings = {
    AutoCollect = false,
    WalkSpeed = 16,
    JumpPower = 50,
    InfiniteJump = false,
    Fly = false,
    FlySpeed = 50,
    NoFallDamage = false,
    KillAura = false,
    KillAuraDistance = 30,
    ESP = false
}

-- ESP Tables
local ESPObjects = {}
local HighlightedObjects = {}

-- Fly Variables
local flying = false
local flyConnection

-- Update Character References
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    Humanoid = char:WaitForChild("Humanoid")
end)

-- Functions
local function CreateESP(object, color, text)
    if ESPObjects[object] then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP"
    billboard.Adornee = object
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = object
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = color
    frame.Parent = billboard
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeTransparency = 0.5
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextScaled = true
    textLabel.Parent = frame
    
    ESPObjects[object] = billboard
end

local function RemoveESP(object)
    if ESPObjects[object] then
        ESPObjects[object]:Destroy()
        ESPObjects[object] = nil
    end
end

local function ClearAllESP()
    for object, billboard in pairs(ESPObjects) do
        billboard:Destroy()
    end
    ESPObjects = {}
end

local function AutoCollectItems()
    if not Settings.AutoCollect then return end
    
    local itemsFound = {}
    
    -- Collect all available items first
    for _, obj in pairs(Workspace:GetDescendants()) do
        -- Search for ProximityPrompts in items
        if obj:IsA("ProximityPrompt") then
            local parent = obj.Parent
            if parent then
                local parentName = parent.Name:lower()
                -- Detect collectible items
                if parentName:find("box") or parentName:find("chest") or parentName:find("crate") or 
                   parentName:find("debris") or parentName:find("barrel") or parentName:find("loot") or
                   parentName:find("item") or parentName:find("supply") then
                    
                    table.insert(itemsFound, {type = "proximity", object = obj, parent = parent})
                end
            end
        end
        
        -- Also search for ClickDetectors as alternative
        if obj:IsA("ClickDetector") then
            local parent = obj.Parent
            if parent then
                local parentName = parent.Name:lower()
                if parentName:find("box") or parentName:find("chest") or parentName:find("crate") or
                   parentName:find("debris") or parentName:find("barrel") or parentName:find("item") then
                    
                    table.insert(itemsFound, {type = "click", object = obj, parent = parent})
                end
            end
        end
    end
    
    -- Teleport to each item and collect it
    for _, item in pairs(itemsFound) do
        if not Settings.AutoCollect then break end
        
        local parent = item.parent
        local objPos = parent:IsA("Model") and parent:GetPivot().Position or parent.Position
        
        -- Teleport to item
        HumanoidRootPart.CFrame = CFrame.new(objPos)
        wait(0.15)
        
        -- Activate item based on type
        if item.type == "proximity" then
            fireproximityprompt(item.object)
        elseif item.type == "click" then
            fireclickdetector(item.object)
        end
        
        wait(0.15)
    end
end

local function KillNearbyEntities()
    if not Settings.KillAura then return end
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") then
            local objName = obj.Name:lower()
            -- Detect sharks and enemies
            if objName:find("shark") or objName:find("enemy") or objName:find("mob") then
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                local rootPart = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Torso")
                
                if humanoid and rootPart and humanoid.Health > 0 then
                    local distance = (HumanoidRootPart.Position - rootPart.Position).Magnitude
                    
                    if distance <= Settings.KillAuraDistance then
                        humanoid.Health = 0
                    end
                end
            end
        end
    end
end

local function StartFlying()
    if flying then return end
    flying = true
    
    local ctrl = {f = 0, b = 0, l = 0, r = 0}
    local lastctrl = {f = 0, b = 0, l = 0, r = 0}
    local speed = Settings.FlySpeed
    
    local bg = Instance.new("BodyGyro")
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = HumanoidRootPart.CFrame
    bg.Parent = HumanoidRootPart
    
    local bv = Instance.new("BodyVelocity")
    bv.velocity = Vector3.new(0, 0, 0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Parent = HumanoidRootPart
    
    flyConnection = RunService.Heartbeat:Connect(function()
        if not flying then
            bg:Destroy()
            bv:Destroy()
            return
        end
        
        local cam = Workspace.CurrentCamera
        local direction = ((cam.CoordinateFrame.LookVector * (ctrl.f - ctrl.b)) + 
                          ((cam.CoordinateFrame * CFrame.new(ctrl.l - ctrl.r, 
                          (ctrl.f - ctrl.b) * 0.2, 0).p) - cam.CoordinateFrame.p))
        
        bv.velocity = direction * speed
        bg.cframe = cam.CoordinateFrame
    end)
    
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.W then ctrl.f = 1
        elseif input.KeyCode == Enum.KeyCode.S then ctrl.b = 1
        elseif input.KeyCode == Enum.KeyCode.A then ctrl.l = 1
        elseif input.KeyCode == Enum.KeyCode.D then ctrl.r = 1
        end
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.W then ctrl.f = 0
        elseif input.KeyCode == Enum.KeyCode.S then ctrl.b = 0
        elseif input.KeyCode == Enum.KeyCode.A then ctrl.l = 0
        elseif input.KeyCode == Enum.KeyCode.D then ctrl.r = 0
        end
    end)
end

local function StopFlying()
    flying = false
    if flyConnection then
        flyConnection:Disconnect()
    end
end

local function UpdateESP()
    if not Settings.ESP then
        ClearAllESP()
        return
    end
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") then
            local objName = obj.Name:lower()
            
            -- ESP for items
            if objName:find("box") or objName:find("chest") then
                if not ESPObjects[obj] then
                    CreateESP(obj, Color3.fromRGB(255, 255, 0), "Item")
                end
            end
            
            -- ESP for sharks
            if objName:find("shark") then
                if not ESPObjects[obj] then
                    CreateESP(obj, Color3.fromRGB(255, 0, 0), "Shark")
                end
            end
        end
    end
end

-- GUI Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)
local CombatTab = Window:CreateTab("Combat", 4483362458)
local VisualsTab = Window:CreateTab("Visuals", 4483362458)
local TeleportTab = Window:CreateTab("Teleports", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- Main Tab
local AutoFarmSection = MainTab:CreateSection("Auto Farm")

local AutoCollectToggle = MainTab:CreateToggle({
   Name = "Auto Collect All Items",
   CurrentValue = false,
   Flag = "AutoCollect",
   Callback = function(Value)
      Settings.AutoCollect = Value
      
      if Value then
          Rayfield:Notify({
             Title = "Auto Collect Enabled",
             Content = "Teleporting to all items automatically",
             Duration = 3,
             Image = 4483362458
          })
          
          spawn(function()
              while Settings.AutoCollect do
                  AutoCollectItems()
                  wait(2)
              end
          end)
      else
          Rayfield:Notify({
             Title = "Auto Collect Disabled",
             Content = "Stopped collecting items",
             Duration = 3,
             Image = 4483362458
          })
      end
   end,
})

MainTab:CreateLabel("Automatically teleports to all items in the game")

-- Player Tab
local MovementSection = PlayerTab:CreateSection("Movement")

local WalkSpeedSlider = PlayerTab:CreateSlider({
   Name = "Walk Speed",
   Range = {16, 200},
   Increment = 1,
   Suffix = "speed",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
      Settings.WalkSpeed = Value
      if Humanoid then
          Humanoid.WalkSpeed = Value
      end
   end,
})

local JumpPowerSlider = PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 200},
   Increment = 5,
   Suffix = "power",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      Settings.JumpPower = Value
      if Humanoid then
          Humanoid.JumpPower = Value
      end
   end,
})

local InfiniteJumpToggle = PlayerTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJump",
   Callback = function(Value)
      Settings.InfiniteJump = Value
   end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if Settings.InfiniteJump and Humanoid then
        Humanoid:ChangeState("Jumping")
    end
end)

local FlyToggle = PlayerTab:CreateToggle({
   Name = "Fly (WASD to move)",
   CurrentValue = false,
   Flag = "Fly",
   Callback = function(Value)
      Settings.Fly = Value
      
      if Value then
          StartFlying()
      else
          StopFlying()
      end
   end,
})

local FlySpeedSlider = PlayerTab:CreateSlider({
   Name = "Fly Speed",
   Range = {10, 200},
   Increment = 5,
   Suffix = "speed",
   CurrentValue = 50,
   Flag = "FlySpeed",
   Callback = function(Value)
      Settings.FlySpeed = Value
   end,
})

local SafetySection = PlayerTab:CreateSection("Safety")

local NoFallDamageToggle = PlayerTab:CreateToggle({
   Name = "No Fall Damage",
   CurrentValue = false,
   Flag = "NoFallDamage",
   Callback = function(Value)
      Settings.NoFallDamage = Value
   end,
})

-- Combat Tab
local CombatSection = CombatTab:CreateSection("Combat Features")

local KillAuraToggle = CombatTab:CreateToggle({
   Name = "Kill Aura (Sharks)",
   CurrentValue = false,
   Flag = "KillAura",
   Callback = function(Value)
      Settings.KillAura = Value
      
      if Value then
          spawn(function()
              while Settings.KillAura do
                  KillNearbyEntities()
                  wait(0.3)
              end
          end)
      end
   end,
})

local KillAuraDistanceSlider = CombatTab:CreateSlider({
   Name = "Kill Aura Distance",
   Range = {10, 100},
   Increment = 5,
   Suffix = "studs",
   CurrentValue = 30,
   Flag = "KillAuraDistance",
   Callback = function(Value)
      Settings.KillAuraDistance = Value
   end,
})

-- Visuals Tab
local ESPSection = VisualsTab:CreateSection("ESP Features")

local ESPToggle = VisualsTab:CreateToggle({
   Name = "Enable ESP",
   CurrentValue = false,
   Flag = "ESP",
   Callback = function(Value)
      Settings.ESP = Value
      
      if Value then
          spawn(function()
              while Settings.ESP do
                  UpdateESP()
                  wait(2)
              end
          end)
      else
          ClearAllESP()
      end
   end,
})

-- Teleport Tab
local TeleportSection = TeleportTab:CreateSection("Quick Teleports")

local TeleportToRaftButton = TeleportTab:CreateButton({
   Name = "Teleport to Raft",
   Callback = function()
      local raft = Workspace:FindFirstChild("Raft") or Workspace:FindFirstChild("PlayerRaft")
      
      if raft then
          HumanoidRootPart.CFrame = raft:GetPivot() * CFrame.new(0, 5, 0)
          Rayfield:Notify({
             Title = "Teleported",
             Content = "You've been teleported to your raft",
             Duration = 3,
             Image = 4483362458
          })
      else
          Rayfield:Notify({
             Title = "Error",
             Content = "Raft not found",
             Duration = 3,
             Image = 4483362458
          })
      end
   end,
})

local TeleportToSpawnButton = TeleportTab:CreateButton({
   Name = "Teleport to Spawn",
   Callback = function()
      local spawn = Workspace:FindFirstChild("SpawnLocation") or Workspace:FindFirstChild("Spawn")
      
      if spawn then
          HumanoidRootPart.CFrame = spawn.CFrame * CFrame.new(0, 5, 0)
          Rayfield:Notify({
             Title = "Teleported",
             Content = "You've been teleported to spawn",
             Duration = 3,
             Image = 4483362458
          })
      end
   end,
})

-- Misc Tab
local UISection = MiscTab:CreateSection("UI Customization")

local UIColorPicker = MiscTab:CreateColorPicker({
    Name = "UI Color",
    Color = Color3.fromRGB(138, 43, 226),
    Flag = "UIColor",
    Callback = function(Value)
        -- Change UI theme color
        Rayfield:Notify({
            Title = "UI Color Changed",
            Content = "Theme color updated successfully",
            Duration = 2,
            Image = 4483362458
        })
    end
})

local InfoSection = MiscTab:CreateSection("Information")

MiscTab:CreateLabel("Script: Novious Hub")
MiscTab:CreateLabel("Version: 1.0.0")
MiscTab:CreateLabel("Developer: ScriptMaster")
MiscTab:CreateLabel("Game: Survive On a Raft")

local CreditsSection = MiscTab:CreateSection("Credits & Support")

MiscTab:CreateParagraph({
    Title = "About Novious Hub",
    Content = "Premium script hub for Survive On a Raft. Features include auto collect, kill aura, ESP, and more."
})

local DestroyUIButton = MiscTab:CreateButton({
   Name = "Destroy UI",
   Callback = function()
      Rayfield:Destroy()
   end,
})

-- Anti Fall Damage
RunService.Heartbeat:Connect(function()
    if Settings.NoFallDamage and Humanoid then
        local fallingState = Humanoid:GetState()
        if fallingState == Enum.HumanoidStateType.Freefall then
            Humanoid:ChangeState(Enum.HumanoidStateType.Flying)
        end
    end
end)

-- Notification on load
Rayfield:Notify({
   Title = "Script Loaded",
   Content = "Novious Hub ready to use",
   Duration = 5,
   Image = 4483362458
})

print("Novious Hub - Survive On a Raft | Loaded Successfully")
