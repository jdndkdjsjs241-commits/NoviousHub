local Rayfield=loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 108/109/1863/826/111/222/333/444/555/666/777/888/999/000/123/456/789/101/202/303/404/505/606/707/808/909/1111/2222/3333/4444/5555/6666/7777/8888/9999/1000/1001/1002/1003/1004/1005/1006/1007/1008/1009/1010/1011/1012/1013/1014/1015/1016/1017/1018/1019/1020/1021/1022/1023/1024/1025/1026/1027/1028/1029/1030/1031/1032/1033/1034/1035/1036/1037/1038/1039/1040/1041/1042/1043/1044/1045/1046/1047/1048/1049/1050/1051/1052/1053/1054/1055/1056/1057/1058/1059/1060/1061/1062/1063/1064/1065/1066/1067/1068/1069/1070/1071/1072/1073/1074/1075/1076/1077/1078/1079/1080/1081/1082/1083/1084/1085/1086/1087/1088/1089/1090/1091/1092/1093/1094/1095/1096/1097/1098/1099/1100/1101/1102/1103/1104/1105/1106/1107/1108/1109/1110/1111/1112/1113/1114/1115/1116/1117/1118/1119/1120/1121/1122/1123/1124/1125/1126/1127/1128/1129/1130/1131/1132/1133/1134/1135/1136/1137/1138/1139/1140/1141/1142/1143/1144/1145/1146/1147/1148/1149/1150/1151/1152/1153/1154/1155/1156/1157/1158/1159/1160/1161/1162/1163/1164/1165/1166/1167/1168/1169/1170/1171/1172/1173/1174/1175/1176/1177/1178/1179/1180/1181/1182/1183/1184/1185/1186/1187/1188/1189/1190/1191/1192/1193/1194/1195/1196/1197/1198/1199/1200/1201/1202/1203/1204/1205/1206/1207/1208/1209/1210/1211/1212/1213/1214/1215/1216/1217/1218/1219/1220/1221/1222/1223/1224/1225/1226/1227/1228/1229/1230/1231/1232/1233/1234/1235/1236/1237/1238/1239/1240/1241/1242/1243/1244/1245/1246/1247/1248/1249/1250/1251/1252/1253/1254/1255/1256/1257/1258/1259/1260/1261/1262/1263/1264/1265/1266/1267/1268/1269/1270/1271/1272/1273/1274/1275/1276/1277/1278/1279/1280/1281/1282/1283/1284/1285/1286/1287/1288/1289/1290/1291/1292/1293/1294/1295/1296/1297/1298/1299/1300/1301/1302/1303/1304/1305/1306/1307/1308/1309/1310/1311/1312/1313/1314/1315/1316/1317/1318/1319/1320/1321/1322/1323/1324/1325/1326/1327/1328/1329/1330/1331/1332/1333/1334/1335/1336/1337/1338/1339/1340/1341/1342/1343/1344/1345/1346/1347/1348/1349/1350/1351/1352/1353/1354/1355/1356/1357/1358/1359/1360/1361/1362/1363/1364/1365/1366/1367/1368/1369/1370/1371/1372/1373/1374/1375/1376/1377/1378/1379/1380/1381/1382/1383/1384/1385/1386/1387/1388/1389/1390/1391/1392/1393/1394/1395/1396/1397/1398/1399/1400/1401/1402/1403/1404/1405/1406/1407/1408/1409/1410/1411/1412/1413/1414/1415/1416/1417/1418/1419/1420/1421/1422/1423/1424/1425/1426/1427/1428/1429/1430/1431/1432/1433/1434/1435/1436/1437/1438/1439/1440/1441/1442/1443/1444/1445/1446/1447/1448/1449/1450/1451/1452/1453/1454/1455/1456/1457/1458/1459/1460/1461/1462/1463/1464/1465/1466/1467/1468/1469/1470/1471/1472/1473/1474/1475/1476/1477/1478/1479/1480/1481/1482/1483/1484/1485/1486/1487/1488/1489/1490/1491/1492/1493/1494/1495/1496/1497/1498/1499/1500

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

-- 108/109/1863/826/1501/1502/1503/1504/1505/1506/1507/1508/1509/1510/1511/1512/1513/1514/1515/1516/1517/1518/1519/1520/1521/1522/1523/1524/1525/1526/1527/1528/1529/1530/1531/1532/1533/1534/1535/1536/1537/1538/1539/1540/1541/1542/1543/1544/1545/1546/1547/1548/1549/1550/1551/1552/1553/1554/1555/1556/1557/1558/1559/1560/1561/1562/1563/1564/1565/1566/1567/1568/1569/1570/1571/1572/1573/1574/1575/1576/1577/1578/1579/1580/1581/1582/1583/1584/1585/1586/1587/1588/1589/1590/1591/1592/1593/1594/1595/1596/1597/1598/1599/1600/1601/1602/1603/1604/1605/1606/1607/1608/1609/1610/1611/1612/1613/1614/1615/1616/1617/1618/1619/1620/1621/1622/1623/1624/1625/1626/1627/1628/1629/1630/1631/1632/1633/1634/1635/1636/1637/1638/1639/1640/1641/1642/1643/1644/1645/1646/1647/1648/1649/1650/1651/1652/1653/1654/1655/1656/1657/1658/1659/1660/1661/1662/1663/1664/1665/1666/1667/1668/1669/1670/1671/1672/1673/1674/1675/1676/1677/1678/1679/1680/1681/1682/1683/1684/1685/1686/1687/1688/1689/1690/1691/1692/1693/1694/1695/1696/1697/1698/1699/1700/1701/1702/1703/1704/1705/1706/1707/1708/1709/1710/1711/1712/1713/1714/1715/1716/1717/1718/1719/1720/1721/1722/1723/1724/1725/1726/1727/1728/1729/1730/1731/1732/1733/1734/1735/1736/1737/1738/1739/1740/1741/1742/1743/1744/1745/1746/1747/1748/1749/1750/1751/1752/1753/1754/1755/1756/1757/1758/1759/1760/1761/1762/1763/1764/1765/1766/1767/1768/1769/1770/1771/1772/1773/1774/1775/1776/1777/1778/1779/1780/1781/1782/1783/1784/1785/1786/1787/1788/1789/1790/1791/1792/1793/1794/1795/1796/1797/1798/1799/1800

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

-- 108/109/1863/826/1801/1802/1803/1804/1805/1806/1807/1808/1809/1810/1811/1812/1813/1814/1815/1816/1817/1818/1819/1820/1821/1822/1823/1824/1825/1826/1827/1828/1829/1830/1831/1832/1833/1834/1835/1836/1837/1838/1839/1840/1841/1842/1843/1844/1845/1846/1847/1848/1849/1850/1851/1852/1853/1854/1855/1856/1857/1858/1859/1860/1861/1862/1863/1864/1865/1866/1867/1868/1869/1870/1871/1872/1873/1874/1875/1876/1877/1878/1879/1880/1881/1882/1883/1884/1885/1886/1887/1888/1889/1890/1891/1892/1893/1894/1895/1896/1897/1898/1899/1900/1901/1902/1903/1904/1905/1906/1907/1908/1909/1910/1911/1912/1913/1914/1915/1916/1917/1918/1919/1920/1921/1922/1923/1924/1925/1926/1927/1928/1929/1930/1931/1932/1933/1934/1935/1936/1937/1938/1939/1940/1941/1942/1943/1944/1945/1946/1947/1948/1949/1950/1951/1952/1953/1954/1955/1956/1957/1958/1959/1960/1961/1962/1963/1964/1965/1966/1967/1968/1969/1970/1971/1972/1973/1974/1975/1976/1977/1978/1979/1980/1981/1982/1983/1984/1985/1986/1987/1988/1989/1990/1991/1992/1993/1994/1995/1996/1997/1998/1999/2000

Rayfield:Notify({Title="Pudding Hub",Content="Grace v2.0.0 loaded",Duration=4})
