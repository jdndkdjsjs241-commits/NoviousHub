local Rayfield=loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 108/109/1863/826/444/777/1337/2025/999/555/111/222/333/444/555/666/777/888/999/000/123/456/789/101/202/303/404/505/606/707/808/909/1111/2222/3333/4444/5555/6666/7777/8888/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/42/43/44/45/46/47/48/49/50/51/52/53/54/55/56/57/58/59/60/61/62/63/64/65/66/67/68/69/70/71/72/73/74/75/76/77/78/79/80/81/82/83/84/85/86/87/88/89/90/91/92/93/94/95/96/97/98/99/100/101/102/103/104/105/106/107/108/109/110/111/112/113/114/115/116/117/118/119/120/121/122/123/124/125/126/127/128/129/130/131/132/133/134/135/136/137/138/139/140/141/142/143/144/145/146/147/148/149/150/151/152/153/154/155/156/157/158/159/160/161/162/163/164/165/166/167/168/169/170/171/172/173/174/175/176/177/178/179/180/181/182/183/184/185/186/187/188/189/190/191/192/193/194/195/196/197/198/199/200/201/202/203/204/205/206/207/208/209/210/211/212/213/214/215/216/217/218/219/220/221/222/223/224/225/226/227/228/229/230/231/232/233/234/235/236/237/238/239/240/241/242/243/244/245/246/247/248/249/250

local Window=Rayfield:CreateWindow({Name="Pudding Hub - Grace Recode v2.0.0",LoadingTitle="Pudding Hub",LoadingSubtitle="Grace Recode by PuddingDev",ConfigurationSaving={Enabled=true,FolderName="PuddingHub",FileName="GraceConfig"},KeySystem=false})

local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local Workspace=game:GetService("Workspace")
local LocalPlayer=Players.LocalPlayer

local Connections={GraceReprieve=nil,GraceRegular=nil}

local function CleanupNOW()
    for _,obj in ipairs(LocalPlayer:GetDescendants())do if obj.Name=="NOW"then obj:Destroy()end end
end

local function CollectBeacons()
    local beacons=Workspace:FindFirstChild("Beacons")
    if not beacons then return end
    for _,child in ipairs(beacons:GetChildren())do
        if child.Name=="Part"then
            pcall(function()Workspace:WaitForChild("Script"):WaitForChild("BeaconPickup"):FireServer(child)end)
        end
    end
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
end

local function GraceReprieveLoop()
    CleanupNOW()CollectBeacons()RemoveKillRemotes()CleanWorkspace()
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
end

-- 108/109/1863/826/444/777/1337/2025/999/555/111/222/333/444/555/666/777/888/999/000/123/456/789/101/202/303/404/505/606/707/808/909/1111/2222/3333/4444/5555/6666/7777/8888/9999/1000/1001/1002/1003/1004/1005/1006/1007/1008/1009/1010/1011/1012/1013/1014/1015/1016/1017/1018/1019/1020/1021/1022/1023/1024/1025/1026/1027/1028/1029/1030/1031/1032/1033/1034/1035/1036/1037/1038/1039/1040/1041/1042/1043/1044/1045/1046/1047/1048/1049/1050/1051/1052/1053/1054/1055/1056/1057/1058/1059/1060/1061/1062/1063/1064/1065/1066/1067/1068/1069/1070/1071/1072/1073/1074/1075/1076/1077/1078/1079/1080/1081/1082/1083/1084/1085/1086/1087/1088/1089/1090/1091/1092/1093/1094/1095/1096/1097/1098/1099/1100

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
end

local function GraceRegularLoop()
    local roomModels=GetSortedRooms()
    for _,room in ipairs(roomModels)do ProcessRoom(room.model)end
    TeleportToExit()
    RemoveKillRemotes()
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

-- 108/109/1863/826/444/777/1337/2025/999/555/111/222/333/444/555/666/777/888/999/000/123/456/789/101/202/303/404/505/606/707/808/909/1111/2222/3333/4444/5555/6666/7777/8888/9999/1000/1001/1002/1003/1004/1005/1006/1007/1008/1009/1010/1011/1012/1013/1014/1015/1016/1017/1018/1019/1020/1021/1022/1023/1024/1025/1026/1027/1028/1029/1030/1031/1032/1033/1034/1035/1036/1037/1038/1039/1040/1041/1042/1043/1044/1045/1046/1047/1048/1049/1050/1051/1052/1053/1054/1055/1056/1057/1058/1059/1060/1061/1062/1063/1064/1065/1066/1067/1068/1069/1070/1071/1072/1073/1074/1075/1076/1077/1078/1079/1080/1081/1082/1083/1084/1085/1086/1087/1088/1089/1090/1091/1092/1093/1094/1095/1096/1097/1098/1099/1100/1101/1102/1103/1104/1105/1106/1107/1108/1109/1110/1111/1112/1113/1114/1115/1116/1117/1118/1119/1120/1121/1122/1123/1124/1125/1126/1127/1128/1129/1130/1131/1132/1133/1134/1135/1136/1137/1138/1139/1140/1141/1142/1143/1144/1145/1146/1147/1148/1149/1150/1151/1152/1153/1154/1155/1156/1157/1158/1159/1160/1161/1162/1163/1164/1165/1166/1167/1168/1169/1170/1171/1172/1173/1174/1175/1176/1177/1178/1179/1180/1181/1182/1183/1184/1185/1186/1187/1188/1189/1190/1191/1192/1193/1194/1195/1196/1197/1198/1199/1200

Rayfield:Notify({Title="Pudding Hub",Content="Grace v2.0.0 loaded",Duration=4})
