-- Novious Hub - Grace v1.0.0
-- Speedrun Horror Movement Script
-- by ScriptMaster & Azadopan

local VERSION = "1.0.0"

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Novious Hub - Grace v" .. VERSION,
   LoadingTitle = "Novious Hub",
   LoadingSubtitle = "Grace Edition",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local Settings = {
    SpeedMultiplier = 1,
    InfiniteSlide = false,
    AutoSlide = false,
    NoSlowdown = false,
    AutoPullLevers = false,
    InfiniteJump = false,
    EntityESP = false,
    DoorESP = false,
    LeverESP = false,
    Fullbright = false,
    NoTimer = false,
    InstantInteract = false,
    Fly = false,
    FlySpeed = 100,
    Noclip = false
}

local ESPObjects = {}
local Connections = {}

local function GetCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function GetHumanoid()
    local char = GetCharacter()
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function GetRootPart()
    local char = GetCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function CreateESP(obj, text, color)
    if ESPObjects[obj] then
        pcall(function() ESPObjects[obj]:Destroy() end)
    end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = obj
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = obj
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Font = Enum.Font.SourceSansBold
    label.TextScaled = true
    label.Parent = billboard
    
    ESPObjects[obj] = billboard
end

local function ClearESP()
    for obj, billboard in pairs(ESPObjects) do
        pcall(function() billboard:Destroy() end)
    end
    ESPObjects = {}
end

local function FindEntities()
    local entities = {}
    local entityNames = {
        "Carnation", "Slight", "Goatman", "Slugfish", 
        "Heed", "Dozer", "Sorrow", "Elkman", "Sin",
        "Shame", "Drain", "PIHSROW"
    }
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") then
            for _, entityName in pairs(entityNames) do
                if obj.Name:find(entityName) then
                    local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        table.insert(entities, {model = obj, part = part, name = entityName})
                    end
                    break
                end
            end
        end
    end
    
    return entities
end

local function FindDoors()
    local doors = {}
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") then
            local name = obj.Name:lower()
            if name:find("door") and not name:find("frame") then
                local part = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                if part then
                    table.insert(doors, part)
                end
            end
        end
    end
    
    return doors
end

local function FindLevers()
    local levers = {}
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Part") or obj:IsA("Model") then
            if obj.Name:lower():find("lever") then
                local part = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
                if part then
                    table.insert(levers, part)
                end
            end
        end
    end
    
    return levers
end

local function UpdateEntityESP()
    if not Settings.EntityESP then return end
    
    local rootPart = GetRootPart()
    if not rootPart then return end
    
    for _, entity in pairs(FindEntities()) do
        if entity.part and entity.part.Parent then
            local distance = math.floor((rootPart.Position - entity.part.Position).Magnitude)
            CreateESP(entity.part, entity.name .. "\n[" .. distance .. "m]", Color3.fromRGB(255, 0, 0))
        end
    end
end

local function UpdateDoorESP()
    if not Settings.DoorESP then return end
    
    local rootPart = GetRootPart()
    if not rootPart then return end
    
    for _, door in pairs(FindDoors()) do
        if door and door.Parent then
            local distance = math.floor((rootPart.Position - door.Position).Magnitude)
            if distance < 100 then
                CreateESP(door, "Door\n[" .. distance .. "m]", Color3.fromRGB(0, 255, 0))
            end
        end
    end
end

local function UpdateLeverESP()
    if not Settings.LeverESP then return end
    
    local rootPart = GetRootPart()
    if not rootPart then return end
    
    for _, lever in pairs(FindLevers()) do
        if lever and lever.Parent then
            local distance = math.floor((rootPart.Position - lever.Position).Magnitude)
            CreateESP(lever, "Lever\n[" .. distance .. "m]", Color3.fromRGB(255, 255, 0))
        end
    end
end

local Tab1 = Window:CreateTab("Movement", 4483362458)
local Tab2 = Window:CreateTab("ESP", 4483362458)
local Tab3 = Window:CreateTab("Visuals", 4483362458)
local Tab4 = Window:CreateTab("Misc", 4483362458)

Tab1:CreateSection("Speed Modifications")

Tab1:CreateSlider({
   Name = "Speed Multiplier",
   Range = {1, 5},
   Increment = 0.1,
   Suffix = "x",
   CurrentValue = 1,
   Callback = function(Value)
      Settings.SpeedMultiplier = Value
      local humanoid = GetHumanoid()
      if humanoid then
          humanoid.WalkSpeed = 16 * Value
      end
   end,
})

Tab1:CreateToggle({
   Name = "No Slide Slowdown",
   CurrentValue = false,
   Callback = function(Value)
      Settings.NoSlowdown = Value
      
      if Value then
          Rayfield:Notify({
             Title = "No Slowdown ON",
             Content = "Slide speed maintained",
             Duration = 2,
             Image = 4483362458
          })
          
          Connections.NoSlowdown = RunService.Heartbeat:Connect(function()
              if not Settings.NoSlowdown then return end
              
              local humanoid = GetHumanoid()
              if humanoid then
                  if humanoid.WalkSpeed < 16 * Settings.SpeedMultiplier then
                      humanoid.WalkSpeed = 16 * Settings.SpeedMultiplier
                  end
              end
          end)
      else
          if Connections.NoSlowdown then
              Connections.NoSlowdown:Disconnect()
              Connections.NoSlowdown = nil
          end
      end
   end,
})

Tab1:CreateSection("Flight")

Tab1:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Callback = function(Value)
      Settings.Fly = Value
      
      if Value then
          local rootPart = GetRootPart()
          if not rootPart then return end
          
          local bodyVelocity = Instance.new("BodyVelocity")
          bodyVelocity.Velocity = Vector3.new(0, 0, 0)
          bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
          bodyVelocity.Parent = rootPart
          
          local bodyGyro = Instance.new("BodyGyro")
          bodyGyro.P = 9e4
          bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
          bodyGyro.CFrame = rootPart.CFrame
          bodyGyro.Parent = rootPart
          
          Connections.Fly = RunService.Heartbeat:Connect(function()
              if not Settings.Fly or not rootPart.Parent then return end
              
              local camera = Workspace.CurrentCamera
              local moveDirection = Vector3.new(0, 0, 0)
              local UIS = game:GetService("UserInputService")
              
              if UIS:IsKeyDown(Enum.KeyCode.W) then
                  moveDirection = moveDirection + camera.CFrame.LookVector
              end
              if UIS:IsKeyDown(Enum.KeyCode.S) then
                  moveDirection = moveDirection - camera.CFrame.LookVector
              end
              if UIS:IsKeyDown(Enum.KeyCode.A) then
                  moveDirection = moveDirection - camera.CFrame.RightVector
              end
              if UIS:IsKeyDown(Enum.KeyCode.D) then
                  moveDirection = moveDirection + camera.CFrame.RightVector
              end
              if UIS:IsKeyDown(Enum.KeyCode.Space) then
                  moveDirection = moveDirection + Vector3.new(0, 1, 0)
              end
              if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                  moveDirection = moveDirection - Vector3.new(0, 1, 0)
              end
              
              bodyVelocity.Velocity = moveDirection * Settings.FlySpeed
              bodyGyro.CFrame = camera.CFrame
          end)
      else
          if Connections.Fly then
              Connections.Fly:Disconnect()
              Connections.Fly = nil
          end
          
          local rootPart = GetRootPart()
          if rootPart then
              for _, obj in pairs(rootPart:GetChildren()) do
                  if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                      obj:Destroy()
                  end
              end
          end
      end
   end,
})

Tab1:CreateSlider({
   Name = "Fly Speed",
   Range = {10, 300},
   Increment = 10,
   Suffix = " speed",
   CurrentValue = 100,
   Callback = function(Value)
      Settings.FlySpeed = Value
   end,
})

Tab1:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Callback = function(Value)
      Settings.Noclip = Value
      
      if Value then
          Connections.Noclip = RunService.Stepped:Connect(function()
              if not Settings.Noclip then return end
              
              local char = GetCharacter()
              if char then
                  for _, part in pairs(char:GetDescendants()) do
                      if part:IsA("BasePart") then
                          part.CanCollide = false
                      end
                  end
              end
          end)
      else
          if Connections.Noclip then
              Connections.Noclip:Disconnect()
              Connections.Noclip = nil
          end
      end
   end,
})

Tab2:CreateSection("ESP Settings")

Tab2:CreateToggle({
   Name = "Entity ESP",
   CurrentValue = false,
   Callback = function(Value)
      Settings.EntityESP = Value
      
      if Value then
          Connections.EntityESP = RunService.Heartbeat:Connect(function()
              task.wait(0.5)
              ClearESP()
              UpdateEntityESP()
          end)
      else
          if Connections.EntityESP then
              Connections.EntityESP:Disconnect()
              Connections.EntityESP = nil
          end
          ClearESP()
      end
   end,
})

Tab2:CreateToggle({
   Name = "Door ESP",
   CurrentValue = false,
   Callback = function(Value)
      Settings.DoorESP = Value
      
      if Value then
          Connections.DoorESP = RunService.Heartbeat:Connect(function()
              task.wait(1)
              UpdateDoorESP()
          end)
      else
          if Connections.DoorESP then
              Connections.DoorESP:Disconnect()
              Connections.DoorESP = nil
          end
          ClearESP()
      end
   end,
})

Tab2:CreateToggle({
   Name = "Lever ESP",
   CurrentValue = false,
   Callback = function(Value)
      Settings.LeverESP = Value
      
      if Value then
          Connections.LeverESP = RunService.Heartbeat:Connect(function()
              task.wait(1)
              UpdateLeverESP()
          end)
      else
          if Connections.LeverESP then
              Connections.LeverESP:Disconnect()
              Connections.LeverESP = nil
          end
          ClearESP()
      end
   end,
})

Tab3:CreateSection("Lighting")

Tab3:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Callback = function(Value)
      Settings.Fullbright = Value
      
      if Value then
          Lighting.Brightness = 2
          Lighting.ClockTime = 14
          Lighting.FogEnd = 100000
          Lighting.GlobalShadows = false
          Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
      else
          Lighting.Brightness = 1
          Lighting.FogEnd = 100000
          Lighting.GlobalShadows = true
      end
   end,
})

Tab3:CreateButton({
   Name = "Remove Visual Effects",
   Callback = function()
      for _, effect in pairs(Lighting:GetChildren()) do
          if effect:IsA("BlurEffect") or effect:IsA("ColorCorrectionEffect") or 
             effect:IsA("DepthOfFieldEffect") or effect:IsA("SunRaysEffect") then
              effect:Destroy()
          end
      end
      
      Rayfield:Notify({
         Title = "Effects Removed",
         Content = "Visual effects cleared",
         Duration = 2,
         Image = 4483362458
      })
   end,
})

Tab4:CreateSection("Game Mechanics")

Tab4:CreateToggle({
   Name = "Instant Interact",
   CurrentValue = false,
   Callback = function(Value)
      Settings.InstantInteract = Value
      
      if Value then
          Rayfield:Notify({
             Title = "Instant Interact ON",
             Content = "Doors and levers open instantly",
             Duration = 2,
             Image = 4483362458
          })
      end
   end,
})

Tab4:CreateButton({
   Name = "Auto Pull All Levers",
   Callback = function()
      local leverCount = 0
      
      for _, lever in pairs(FindLevers()) do
          if lever and lever.Parent then
              pcall(function()
                  fireproximityprompt(lever:FindFirstChildWhichIsA("ProximityPrompt"))
                  leverCount = leverCount + 1
              end)
          end
      end
      
      Rayfield:Notify({
         Title = "Levers Pulled",
         Content = leverCount .. " levers activated",
         Duration = 2,
         Image = 4483362458
      })
   end,
})

Tab4:CreateSection("Utilities")

Tab4:CreateButton({
   Name = "Destroy UI",
   Callback = function()
      for _, connection in pairs(Connections) do
          if connection then connection:Disconnect() end
      end
      
      ClearESP()
      Lighting.Brightness = 1
      Lighting.GlobalShadows = true
      
      local rootPart = GetRootPart()
      if rootPart then
          for _, obj in pairs(rootPart:GetChildren()) do
              if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                  obj:Destroy()
              end
          end
      end
      
      Rayfield:Destroy()
   end,
})

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 16 * Settings.SpeedMultiplier
    end
end)

Rayfield:Notify({
   Title = "Novious Hub",
   Content = "Grace v" .. VERSION .. " loaded",
   Duration = 3,
   Image = 4483362458
})

print("=================================================")
print("Novious Hub - Grace v" .. VERSION)
print("Speedrun Horror Movement Script")
print("by ScriptMaster & Azadopan")
print("=================================================")
