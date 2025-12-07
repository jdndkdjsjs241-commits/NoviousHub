local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "RoCoreBlox Function Universal | Experimental Version",
    SubTitle = "Universal",
    Size = UDim2.fromOffset(540, 420),
    Theme = "Red",
    AccentColor = Color3.fromRGB(255,45,45),
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local espEnabled = false
local espObjects = {}

local function addESP(plr)
    if plr == LocalPlayer or espObjects[plr] then return end
    local char = plr.Character or plr.CharacterAdded:Wait()
    local head = char:WaitForChild("Head")
    local bill = Instance.new("BillboardGui")
    bill.Adornee = head
    bill.Parent = head
    bill.Size = UDim2.new(0,220,0,60)
    bill.StudsOffset = Vector3.new(0,3.2,0)
    bill.AlwaysOnTop = true
    bill.LightInfluence = 0
    local txt = Instance.new("TextLabel", bill)
    txt.Size = UDim2.new(1,0,1,0)
    txt.BackgroundTransparency = 1
    txt.TextStrokeTransparency = 0.25
    txt.TextStrokeColor3 = Color3.new(0,0,0)
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 15
    espObjects[plr] = bill
    RunService.RenderStepped:Connect(function()
        if not espEnabled or not plr.Character or not plr.Character:FindFirstChild("Humanoid") then
            bill.Enabled = false return
        end
        local hum = plr.Character.Humanoid
        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
        local myhrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local dist = myhrp and math.floor((hrp.Position - myhrp.Position).Magnitude) or 0
        txt.Text = plr.DisplayName.."\n["..math.floor(hum.Health).."/"..hum.MaxHealth.."] • "..dist.."m"
        txt.TextColor3 = Color3.fromRGB(255,45,45)
        bill.Enabled = true
    end)
end

local VisualTab = Window:Tab({Title="Visuals"})
VisualTab:Toggle({Title="Player ESP (Red)",Callback=function(v)
    espEnabled = v
    if v then
        for _,p in Players:GetPlayers() do addESP(p) end
        Players.PlayerAdded:Connect(addESP)
    else
        for _,b in espObjects do b:Destroy() end
        espObjects = {}
    end
end})

VisualTab:Toggle({Title="Fullbright",Callback=function(v)
    Lighting.Brightness = v and 3 or 1
    Lighting.GlobalShadows = not v
    Lighting.FogEnd = v and 100000 or 1000
end})

local LocalTab = Window:Tab({Title="LocalPlayer"})
LocalTab:Toggle({Title="Speed 100",Callback=function(v)
    if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = v and 100 or 16 end
end})
LocalTab:Toggle({Title="Jump 150",Callback=function(v)
    if LocalPlayer.Character then LocalPlayer.Character.Humanoid.JumpPower = v and 150 or 50 end
end})
LocalTab:Toggle({Title="FOV 100",Callback=function(v)
    game.Workspace.CurrentCamera.FieldOfView = v and 100 or 70
end})
LocalTab:Toggle({Title="Infinite Jump",Callback=function(v)
    if v then
        UserInputService.JumpRequest:Connect(function()
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState("Jumping") end
        end)
    end
end})

WindUI:Notify({Title="RoCoreBlox Function Universal | Experimental Version",Content="Loaded",Duration=5})
