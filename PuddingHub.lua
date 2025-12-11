local Rayfield=loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window=Rayfield:CreateWindow({Name="Pudding Hub - Grace Recode v2.0.0",LoadingTitle="Pudding Hub",LoadingSubtitle="Grace Recode by PuddingDev",ConfigurationSaving={Enabled=true,FolderName="PuddingHub",FileName="GraceConfig"},KeySystem=false})

local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local Workspace=game:GetService("Workspace")
local LocalPlayer=Players.LocalPlayer

local _0xFAKE1=math.random(11111,99999)local _0xFAKE2={}for i=1,999 do table.insert(_0xFAKE2,tostring(math.random()))end
local function _0xJUNKFUNC1()local a=0 for i=1,50000 do a=a+math.sin(i)*math.cos(i^2)end return a end
_0xJUNKFUNC1()_0xJUNKFUNC1()_0xJUNKFUNC1()
local _0xFAKE3=string.rep("NovaProtected"..tostring(tick()))local _0xFAKE4=table.create(300)

local _0xJUNK5=0

local Connections={GraceReprieve=nil,GraceRegular=nil}

local function CleanupNOW()
    for _,obj in ipairs(LocalPlayer:GetDescendants())do if obj.Name=="NOW"then obj:Destroy()end end
    local _junk=0 for i=1,10000 do _junk=_junk+1 end
end

local function CollectBeacons()
    local beacons=Workspace:FindFirstChild("Beacons")
    if not beacons then return end
    for _,child in ipairs(beacons:GetChildren())do
        if child.Name=="Part"then
            pcall(function()Workspace:WaitForChild("Script"):WaitForChild("BeaconPickup"):FireServer(child)end)
        end
    end
    local _fake=math.random()local _fake2=string.reverse("protected")
end

local function RemoveKillRemotes()
    for _,obj in ipairs(ReplicatedStorage:GetDescendants())do
        if obj:IsA("RemoteEvent")or obj:IsA("RemoteFunction")then
            local name=obj.Name
            if name:sub(1,4)=="Send"or name:sub(1,4)=="Kill"then
                pcall(function()obj:Destroy()end)
            end
        end
    end
    for i=1,15000 do local _=math.sqrt(i)*math.tan(i)end
end

local function CleanWorkspace()
    for _,item in ipairs(Workspace:GetChildren())do
        if item.Name~="Beacons"and not item:IsA("BaseScript")then
            pcall(function()
                if item.Name=="Rooms"then
                    for _,child in ipairs(item:GetChildren())do child:Destroy()end
                else
                    item:Destroy()
                end
            end)
        end
    end
    local _junkTable={}for i=1,800 do table.insert(_junkTable,i^3)end
end

local function GraceReprieveLoop()
    CleanupNOW()CollectBeacons()RemoveKillRemotes()CleanWorkspace()
    local _fakeLoop=0 for i=1,20000 do _fakeLoop=_fakeLoop+math.random()end
end

local function GetSortedRooms()
    local roomsFolder=Workspace:FindFirstChild("Rooms")
    if not roomsFolder then return{}end
    local roomModels={}
    for _,model in ipairs(roomsFolder:GetChildren())do
        if model:IsA("Model")then
            local num=tonumber(model.Name)
            if num then table.insert(roomModels,{model=model,number=num})end
        end
    end
    table.sort(roomModels,function(a,b)return a.number<b.number end)
    local _junk=string.rep("PuddingHubSecure",50)
    return roomModels
end

local function ProcessRoom(roomModel)
    local vault=roomModel:FindFirstChild("VaultEntrance")
    if vault then
        pcall(function()
            ReplicatedStorage.TriggerPrompt:FireServer(vault:FindFirstChild("Hinged"):FindFirstChild("Cylinder"):FindFirstChild("ProximityPrompt"))
            ReplicatedStorage.Events.EnteredSaferoom:FireServer()
        end)
    else
        local toDestroy={}
        for _,descendant in ipairs(roomModel:GetDescendants())do
            if descendant:IsA("BaseScript")then
                local target=descendant
                while target.Parent~=roomModel do target=target.Parent end
                toDestroy[target]=true
            end
        end
        for target in pairs(toDestroy)do pcall(function()target:Destroy()end)end
    end
    local _fakeCalc=0 for i=1,30000 do _fakeCalc=_fakeCalc+i^2 end
end

local function TeleportToExit()
    local char=LocalPlayer.Character
    if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local roomsFolder=Workspace:FindFirstChild("Rooms")
    if not roomsFolder then return end
    local roomModels=GetSortedRooms()
    if #roomModels==0 then return end
    local safeRoom=roomsFolder:FindFirstChild("SafeRoom",true)
    local deathTimer=Workspace:FindFirstChild("DEATHTIMER")
    if safeRoom and safeRoom:IsA("Model")and deathTimer and deathTimer.Value<=0 then
        local scale=safeRoom:FindFirstChild("Scale")
        local hitbox=scale and scale:FindFirstChild("hitbox")
        if hitbox and hitbox:IsA("BasePart")then
            pcall(function()root.CFrame=hitbox.CFrame*CFrame.Angles(0,math.rad(225),0)Workspace.CurrentCamera.CFrame=root.CFrame end)
            return
        end
    end
    local index=#roomModels
    if safeRoom and safeRoom:IsA("Model")and deathTimer and not deathTimer:GetAttribute("AUTOGO")then index=math.min(11,#roomModels)end
    local highestModel=roomModels[index]and roomModels[index].model
    local exit=highestModel and highestModel:FindFirstChild("Exit")
    if exit and exit:IsA("BasePart")then
        pcall(function()root.CFrame=exit.CFrame*CFrame.Angles(0,math.rad(45),0)Workspace.CurrentCamera.CFrame=root.CFrame end)
    end
    local _junkLoop=0 for i=1,25000 do _junkLoop=_junkLoop+math.sin(i) end
end

local function GraceRegularLoop()
    local roomModels=GetSortedRooms()
    for _,room in ipairs(roomModels)do ProcessRoom(room.model)end
    TeleportToExit()
    RemoveKillRemotes()
    local _fake=table.concat({"a","b","c","d","e"},",")for i=1,10000 do end
end

local function SetupAntiKick()
    if hookfunction then pcall(function()hookfunction(LocalPlayer.Kick,function()end)end)end
    if hookmetamethod then
        pcall(function()
            local old;old=hookmetamethod(game,"__namecall",function(self,...)
                if self==LocalPlayer and getnamecallmethod():lower()=="kick"then return end
                return old(self,...)
            end)
        end)
    end
    local _junk=0 for i=1,40000 do _junk=_junk+i end
end

local TabMain=Window:CreateTab("Main")
local TabUtility=Window:CreateTab("Utility")
local TabInfo=Window:CreateTab("Info")

TabMain:CreateSection("Grace Auto Modes")

TabMain:CreateToggle({Name="Grace Reprieve Mode [PATCHED]",CurrentValue=false,Flag="GraceReprieve",Callback=function(v)
    if v then
        SetupAntiKick()
        Connections.GraceReprieve=RunService.Heartbeat:Connect(function()pcall(GraceReprieveLoop)end)
    else
        if Connections.GraceReprieve then Connections.GraceReprieve:Disconnect()Connections.GraceReprieve=nil end
    end
end})

TabMain:CreateToggle({Name="Grace Regular Mode [NORMAL/ZEN]",CurrentValue=false,Flag="GraceRegular",Callback=function(v)
    if v then
        Connections.GraceRegular=RunService.Heartbeat:Connect(function()pcall(GraceRegularLoop)end)
    else
        if Connections.GraceRegular then Connections.GraceRegular:Disconnect()Connections.GraceRegular=nil end
    end
end})

TabUtility:CreateSection("Game Actions")

TabUtility:CreateButton({Name="Create OP Modifiers Lobby",Callback=function()
    local s=pcall(function()ReplicatedStorage.CreateLobby:FireServer({a=1,p=50,s=3,m={ms={II=true,QU=true,Ep=4,ei=true,oq=true,uR=true,wT=true,TQ=true,rq=10,YQ=3,tr=true,rI=true,ii=3,UO=true,CS=3,IR=true,RO=true,Ty=true,qi=true,im=true,Op=true,tQ=true,pe=true,iP=true,uY=true,MI=true,uy=true,Qr=true,iu=true,ir=true,KA=2,QP=true,WR=true,rt=true,TP=true,Ou=true,UT=5,yw=true,pp=true,To=true,Qi=true,Rw=true,Wt=true,Up=true,Er=true,uu=true,qY=true,RF=true,DR=true,PW=true,HE=true,it=true,iS=true,yE=true,wy=true,eW=3},vav=false,v=false},_m=1,c=1})end)
    Rayfield:Notify({Title=s and"Lobby Created"or"Error",Content=s and"OP lobby!"or"Failed",Duration=3})
end})

TabUtility:CreateButton({Name="Buy Crown (100 Keys)",Callback=function()
    local s=pcall(function()ReplicatedStorage:WaitForChild("BuyKCrown"):InvokeServer()end)
    Rayfield:Notify({Title=s and"Crown Bought"or"Error",Content=s and"100 keys spent"or"Failed",Duration=3})
end})

TabUtility:CreateButton({Name="Return to Lobby",Callback=function()
    pcall(function()ReplicatedStorage:WaitForChild("byebyemyFRIENDbacktothelobby"):FireServer()end)
end})

TabUtility:CreateSection("Badge Farming")

TabUtility:CreateButton({Name="Unlock All Badges (Kills You)",Callback=function()
    local Http=game:GetService("HttpService")
    local BadgeGot=ReplicatedStorage:FindFirstChild("BadgeGot")
    if not BadgeGot then Rayfield:Notify({Title="Error",Content="Remote not found",Duration=3})return end
    local req=http_request or request
    if not req then Rayfield:Notify({Title="Error",Content="HTTP not supported",Duration=3})return end
    local u=game.GameId
    local ids={}
    local c=""
    repeat
        local url=string.format("https://badges.roblox.com/v1/universes/%d/badges?limit=100&sortOrder=Asc%s",u,c~=""and"&cursor="..c or"")
        local r=req({Url=url,Method="GET"})
        if r.StatusCode~=200 then break end
        local d=Http:JSONDecode(r.Body)
        for _,b in ipairs(d.data)do table.insert(ids,b.id)end
        c=d.nextPageCursor or""
    until c==""
    for _,id in ipairs(ids)do pcall(function()BadgeGot:FireServer(id)end)end
    Rayfield:Notify({Title="Badges",Content=#ids.." badges attempted",Duration=3})
end})

TabInfo:CreateSection("About")
TabInfo:CreateLabel("Version: 2.0.0")
TabInfo:CreateLabel("by PuddingDev")
TabInfo:CreateLabel("Game: Grace")

TabInfo:CreateSection("Features")
TabInfo:CreateParagraph({Title="Grace Regular Mode",Content="Auto-completes Normal/Zen runs"})
TabInfo:CreateParagraph({Title="Grace Reprieve Mode",Content="Currently patched"})
TabInfo:CreateParagraph({Title="Utility",Content="OP lobby, crown, badge farm"})

TabInfo:CreateButton({Name="Destroy UI",Callback=function()
    for _,c in pairs(Connections)do if c then c:Disconnect()end end
    Rayfield:Destroy()
end})

local _0xJUNKFINAL=0
for i=1,100000 do
    _0xJUNKFINAL=_0xJUNKFINAL+math.random(1,100)
    if math.random()>0.99 then task.wait() end
end

Rayfield:Notify({Title="Pudding Hub",Content="Grace v2.0.0 loaded",Duration=4})
