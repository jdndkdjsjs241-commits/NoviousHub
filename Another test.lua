if game.PlaceId == 18687417158 then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Pudding Hub",
        Text = "Created By PuddingDev",
        Duration = 5
    })
    wait(2)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Script Loading..",
        Text = "Please wait for the script to load.",
        Duration = 5
    })
end

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local function CleanESP(espName)
    for _, v in ipairs(game:GetDescendants()) do
        if (v:IsA("Highlight") or v:IsA("BillboardGui")) and v.Name == espName then
            v:Destroy()
        end
    end
end

local Window = Rayfield:CreateWindow({
    Name = "Pudding Hub / Forsaken",
    Icon = 106975314970201,
    LoadingTitle = "Pudding Hub / Forsaken",
    LoadingSubtitle = "Created By PuddingDev",
    Theme = "AmberGlow",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PuddingHub",
        FileName = "pudding_forsaken"
    },
    Discord = {
        Enabled = true,
        Invite = "25ms",
        RememberJoins = true
    },
    KeySystem = false
})

local MainTab = Window:CreateTab("Main", "home")
local StaminaTab = Window:CreateTab("Stamina", "accessibility")
local EffectsTab = Window:CreateTab("Effects", "wand-sparkles")
local GeneratorsTab = Window:CreateTab("Generators", "cpu")
local PlayerTab = Window:CreateTab("Aimbot / Player", "crosshair")
local FunTab = Window:CreateTab("Fun", "smile")
local CreditsTab = Window:CreateTab("Credits", "clipboard")
local SettingsTab = Window:CreateTab("Settings", "settings")

Rayfield:Notify({
    Title = "Created By PuddingDev",
    Content = "Welcome to Pudding Hub!",
    Duration = 6.5,
    Image = "flame"
})

MainTab:CreateSection("Esp")

local KillerESPConnection = nil

MainTab:CreateToggle({
    Name = "Killer | Esp",
    CurrentValue = false,
    Flag = "ToggleKillerESP",
    Callback = function(enabled)
        if enabled then
            local Killers = workspace.Players.Killers
            local PlayersFolder = workspace:WaitForChild("Players")
            
            local function CreateHighlight(parent, fillColor, outlineColor)
                local highlight = parent:FindFirstChild("Highlight")
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "KillerESP"
                    highlight.Parent = parent
                    highlight.Adornee = parent
                end
                highlight.FillTransparency = 0.5
                highlight.FillColor = fillColor
                highlight.OutlineColor = outlineColor
                highlight.OutlineTransparency = 0
            end
            
            local function CreateBillboard(parent, text, textColor)
                local billboard = parent:FindFirstChildOfClass("BillboardGui")
                if billboard then
                    billboard.TextLabel.Text = text
                    billboard.TextLabel.TextColor3 = textColor
                    billboard.TextLabel.Font = Enum.Font.Antique
                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                else
                    billboard = Instance.new("BillboardGui")
                    billboard.Adornee = parent
                    billboard.Name = "KillerESP"
                    billboard.Size = UDim2.new(0, 100, 0, 25)
                    billboard.AlwaysOnTop = true
                    billboard.Parent = parent.Parent
                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                    
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.TextScaled = true
                    label.TextColor3 = textColor
                    label.Text = text
                    label.Font = Enum.Font.Antique
                    label.Parent = billboard
                end
            end
            
            local function ApplyESP(character)
                if character:FindFirstChildOfClass("Humanoid") and character:FindFirstChild("HumanoidRootPart") then
                    CreateHighlight(character, Color3.fromRGB(255, 0, 0), Color3.fromRGB(150, 0, 0))
                    CreateBillboard(character:FindFirstChild("HumanoidRootPart"), character.Name, Color3.fromRGB(255, 0, 0))
                end
            end
            
            local function UpdateESP()
                local killersFolder = PlayersFolder:FindFirstChild("Killers")
                if killersFolder then
                    for _, killer in pairs(killersFolder:GetChildren()) do
                        ApplyESP(killer)
                    end
                end
            end
            
            UpdateESP()
            KillerESPConnection = Killers.ChildAdded:Connect(UpdateESP)
            KillerESPConnection = PlayersFolder.DescendantAdded:Connect(function(descendant)
                if descendant.Parent and descendant.Parent.Name == "Killers" then
                    ApplyESP(descendant)
                end
            end)
        else
            CleanESP("KillerESP")
            if KillerESPConnection then
                KillerESPConnection:Disconnect()
                KillerESPConnection = nil
            end
        end
    end
})

local GeneratorESPEnabled = false
local GeneratorConnections = {}

MainTab:CreateToggle({
    Name = "Generator | ESP",
    CurrentValue = false,
    Flag = "GeneratorToggleESP",
    Callback = function(enabled)
        GeneratorESPEnabled = enabled
        if GeneratorESPEnabled then
            local IngameMap = workspace:WaitForChild("Map"):WaitForChild("Ingame")
            local updateInterval = 1
            
            local function GetMap()
                return IngameMap:FindFirstChild("Map")
            end
            
            local function CreateGeneratorHighlight(generator, fillRGB, outlineRGB)
                local highlight = generator:FindFirstChild("GeneratorHigh")
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "GeneratorHigh"
                    highlight.Parent = generator
                    highlight.Adornee = generator
                end
                highlight.FillColor = Color3.new(fillRGB[1], fillRGB[2], fillRGB[3])
                highlight.OutlineColor = Color3.new(outlineRGB[1], outlineRGB[2], outlineRGB[3])
            end
            
            local function UpdateGeneratorBillboard(generator)
                local main = generator:FindFirstChild("Main")
                if main then
                    local billboard = main:FindFirstChild("GeneratorHighBillboard")
                    if not billboard then
                        billboard = Instance.new("BillboardGui")
                        billboard.Name = "GeneratorHighBillboard"
                        billboard.Adornee = main
                        billboard.Size = UDim2.new(0, 150, 0, 30)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = main
                        
                        local label = Instance.new("TextLabel")
                        label.Name = "GeneratorTextLabel"
                        label.Size = UDim2.new(0.8, 0, 0.8, 0)
                        label.BackgroundTransparency = 1
                        label.TextScaled = true
                        label.Font = Enum.Font.Antique
                        label.Text = "Initializing..."
                        label.TextColor3 = Color3.new(1, 1, 1)
                        label.Parent = billboard
                    end
                    
                    local label = billboard:FindFirstChild("GeneratorTextLabel")
                    if label then
                        local isFixed = main:FindFirstChild("generatorActivate") ~= nil
                        if isFixed then
                            label.Text = "Generator: Fixed"
                            label.TextColor3 = Color3.new(0, 0.5, 0)
                            CreateGeneratorHighlight(generator, {0, 0.5, 0}, {0, 1, 0})
                        else
                            label.Text = "Generator: Not Fixed"
                            label.TextColor3 = Color3.new(0.8, 0, 0)
                            CreateGeneratorHighlight(generator, {0.5, 0, 0}, {1, 0, 0})
                        end
                        generator:SetAttribute("GeneratorState", isFixed)
                    end
                end
            end
            
            local function UpdateAllGenerators()
                local map = GetMap()
                if map then
                    for _, child in ipairs(map:GetChildren()) do
                        if child.Name == "Generator" and child:IsA("Model") then
                            UpdateGeneratorBillboard(child)
                        end
                    end
                end
            end
            
            local function DisconnectAll()
                for _, conn in ipairs(GeneratorConnections) do
                    if conn then
                        conn:Disconnect()
                    end
                end
                GeneratorConnections = {}
            end
            
            local function MonitorLoop()
                while GeneratorESPEnabled do
                    task.wait(1)
                    local map = GetMap()
                    if map then
                        UpdateAllGenerators()
                        local connection = map.DescendantAdded:Connect(function(descendant)
                            if GeneratorESPEnabled then
                                local targetGen = nil
                                if descendant.Name == "Generator" and descendant:IsA("Model") then
                                    targetGen = descendant
                                elseif descendant.Name == "Main" and descendant.Parent and descendant.Parent.Name == "Generator" then
                                    targetGen = descendant.Parent
                                end
                                if targetGen then
                                    UpdateGeneratorBillboard(targetGen)
                                end
                            end
                        end)
                        table.insert(GeneratorConnections, connection)
                    end
                end
            end
            
            UpdateAllGenerators()
            task.spawn(MonitorLoop)
            
            spawn(function()
                while GeneratorESPEnabled do
                    UpdateAllGenerators()
                    task.wait(updateInterval)
                end
                DisconnectAll()
            end)
        else
            GeneratorESPEnabled = false
            CleanESP("GeneratorHigh")
            CleanESP("GeneratorHighBillboard")
        end
    end
})

StaminaTab:CreateParagraph({
    Title = "Note:",
    Content = "Might not work on free executors."
})

local stam = false
StaminaTab:CreateToggle({
    Name = "Infinite Stamina",
    CurrentValue = false,
    Flag = "ToggleInfiniteStamina",
    Callback = function(enabled)
        stam = enabled
        local staminaMod = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
        local connection = nil
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if stam then
                function staminaMod.StaminaLossDisabled() end
            else
                connection:Disconnect()
                staminaMod.StaminaLossDisabled = nil
            end
        end)
    end
})

local AutoGenEnabled = false
local GenDelay = 2.5

GeneratorsTab:CreateToggle({
    Name = "Auto Generator Fix",
    CurrentValue = false,
    Flag = "AutoGeneratorFix",
    Callback = function(enabled)
        AutoGenEnabled = enabled
        if AutoGenEnabled then
            spawn(function()
                while AutoGenEnabled do
                    for _, gen in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
                        if gen.Name == "Generator" then
                            gen:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
                        end
                    end
                    wait(GenDelay)
                end
            end)
        else
            AutoGenEnabled = false
        end
    end
})

GeneratorsTab:CreateSlider({
    Name = "Delay Range",
    Range = {3, 10},
    Increment = 0.5,
    Suffix = "Seconds",
    CurrentValue = 2.5,
    Flag = "SliderGeneratorDelay",
    Callback = function(value)
        GenDelay = value
    end
})

CreditsTab:CreateSection("Created By PuddingDev")
CreditsTab:CreateParagraph({
    Title = "Creator",
    Content = "Script created by PuddingDev\nJoin discord.gg/25ms"
})
