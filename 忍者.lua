local soundId = "rbxassetid://88457346646245"
local Workspace = game:GetService("Workspace")

-- 创建音效对象
local sound = Instance.new("Sound")
sound.SoundId = soundId
sound.Looped = false
sound.Volume = 0.5
sound.Parent = Workspace

-- 播放音效
sound:Play()

-- 音效结束后立即销毁
sound.Ended:Connect(function()
    sound:Destroy()
end)

task.delay(10, function()
    if sound and sound.Parent and not sound.IsPlaying then
        sound:Destroy()
    end
end)

-- ========== 忍者传奇脚本修复与整合 ==========

local AutoSettings = {
    AutoSwing = false,
    AutoSell = false,
    AutoR = false,
    AutoS = false,
    AutoB = false,
    AutoC = false,
    AutoE = false,
    AutoCr = false,
    AutoTa = false,
    AutoBo = false,
    AutoBo1 = false,
    AutoBo2 = false,
    AutoCoin = false,
    AutoChi = false
}

for k, v in pairs(AutoSettings) do
    getgenv()[k] = v
end

-- 修复传送功能
local function teleportTo(placeCFrame)
    local plyr = game.Players.LocalPlayer
    if plyr and plyr.Character and plyr.Character:FindFirstChild("HumanoidRootPart") then
        plyr.Character.HumanoidRootPart.CFrame = placeCFrame
    end
end

-- 修复自动功能
local AutoFunctions = {
    doBo = function()
        local taskHandle
        taskHandle = task.spawn(function()
            while AutoBo == true do
                local boss = game:GetService("Workspace").bossFolder:FindFirstChild("RobotBoss")
                if boss and boss:FindFirstChild("UpperTorso") then
                    teleportTo(boss.UpperTorso.CFrame)
                    local args = {[1] = "swingKatana"}
                    local event = game.Players.LocalPlayer:FindFirstChild("ninjaEvent")
                    if event then
                        event:FireServer(unpack(args))
                    end
                end
                task.wait(0.1)
            end
        end)
        return taskHandle
    end,

    doBo1 = function()
        local taskHandle
        taskHandle = task.spawn(function()
            while AutoBo1 == true do
                local boss = game:GetService("Workspace").bossFolder:FindFirstChild("EternalBoss")
                if boss and boss:FindFirstChild("UpperTorso") then
                    teleportTo(boss.UpperTorso.CFrame)
                    local args = {[1] = "swingKatana"}
                    local event = game.Players.LocalPlayer:FindFirstChild("ninjaEvent")
                    if event then
                        event:FireServer(unpack(args))
                    end
                end
                task.wait(0.1)
            end
        end)
        return taskHandle
    end,

    doBo2 = function()
        local taskHandle
        taskHandle = task.spawn(function()
            while AutoBo2 == true do
                local boss = game:GetService("Workspace").bossFolder:FindFirstChild("AncientMagmaBoss")
                if boss and boss:FindFirstChild("UpperTorso") then
                    teleportTo(boss.UpperTorso.CFrame)
                    local args = {[1] = "swingKatana"}
                    local event = game.Players.LocalPlayer:FindFirstChild("ninjaEvent")
                    if event then
                        event:FireServer(unpack(args))
                    end
                end
                task.wait(0.1)
            end
        end)
        return taskHandle
    end,

    doE = function()
        local taskHandle
        taskHandle = task.spawn(function()
            while AutoE == true do
                local elements = {
                    "Inferno", "Frost", "Lightning", "Electral Chaos",
                    "Shadow Charge", "Masterful Wrath", "Shadowfire",
                    "Eternity Storm", "Blazing Entity"
                }
                
                for _, element in ipairs(elements) do
                    local args = {[1] = element}
                    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("rEvents")
                    if remote then
                        remote = remote:FindFirstChild("elementMasteryEvent")
                        if remote then
                            remote:FireServer(unpack(args))
                        end
                    end
                    task.wait(0.1)
                end
                task.wait(0.5)
            end
        end)
        return taskHandle
    end,

    doSwing = function()
        local taskHandle
        taskHandle = task.spawn(function()
            while AutoSwing == true do
                local args = {[1] = "swingKatana"}
                local event = game.Players.LocalPlayer:FindFirstChild("ninjaEvent")
                if event then
                    event:FireServer(unpack(args))
                end
                task.wait(0.05)
            end
        end)
        return taskHandle
    end,

    doS = function()
        local taskHandle
        taskHandle = task.spawn(function()
            while AutoS == true do
                local args = {[1] = "buyAllSwords", [2] = "Blazing Vortex Island"}
                local event = game.Players.LocalPlayer:FindFirstChild("ninjaEvent")
                if event then
                    event:FireServer(unpack(args))
                end
                task.wait(0.5)
            end
        end)
        return taskHandle
    end,

    doB = function()
        local taskHandle
        taskHandle = task.spawn(function()
            while AutoB == true do
                local args = {[1] = "buyAllBelts", [2] = "Blazing Vortex Island"}
                local event = game.Players.LocalPlayer:FindFirstChild("ninjaEvent")
                if event then
                    event:FireServer(unpack(args))
                end
                task.wait(0.5)
            end
        end)
        return taskHandle
    end,

    doR = function()
        local taskHandle
        taskHandle = task.spawn(function()
            while AutoR == true do
                local ranks = {
                    "Grasshopper", "Apprentice", "Samurai", "Assassin", "Shadow",
                    "Ninja", "Master Ninja", "Sensei", "Master Sensei", "Ninja Legend",
                    "Master Of Shadows", "Immortal Assassin", "Eternity Hunter", "Shadow Legend", "Dragon Warrior",
                    "Dragon Master", "Chaos Sensei", "Chaos Legend", "Master Of Elements", "Elemental Legend",
                    "Ancient Battle Master", "Ancient Battle Legend", "Legendary Shadow Duelist", "Master Legend Assassin", "Mythic Shadowmaster",
                    "Legendary Shadowmaster", "Awakened Scythemaster", "Awakened Scythe Legend", "Master Legend Zephyr", "Golden Sun Shuriken Master",
                    "Golden Sun Shuriken Legend", "Dark Sun Samurai Legend", "Dragon Evolution Form I", "Dragon Evolution Form II", "Dragon Evolution Form III",
                    "Dragon Evolution Form IV", "Dragon Evolution Form V", "Cybernetic Electro Master", "Cybernetic Electro Legend", "Shadow Chaos Assassin",
                    "Shadow Chaos Legend", "Infinity Sensei", "Infinity Legend", "Aether Genesis Master Ninja", "Master Legend Sensei Hunter",
                    "Skystorm Series Samurai Legend", "Master Elemental Hero", "Eclipse Series Soul Master", "Starstrike Master Sensei", "Evolved Series Master Ninja",
                    "Dark Elements Guardian", "Elite Series Master Legend", "Infinity Shadows Master", "Lighting Storm Sensei",
                    "Dark Elements Blademaster", "Rising Shadow Eternal Ninja", "Skyblade Ninja Master", "Shadow Storm Sensei", "Comet Strike Lion",
                    "Cybernetic Azure Sensei", "Ultra Genesis Shadow"
                }
                
                for i = 1, #ranks, 5 do
                    for j = i, math.min(i+4, #ranks) do
                        local args = {[1] = "buyRank", [2] = ranks[j]}
                        local event = game.Players.LocalPlayer:FindFirstChild("ninjaEvent")
                        if event then
                            event:FireServer(unpack(args))
                        end
                    end
                    task.wait(0.1)
                end
                task.wait(0.5)
            end
        end)
        return taskHandle
    end,

    doSell = function()
        local taskHandle
        taskHandle = task.spawn(function()
            while AutoSell == true do
                local player = game.Players.LocalPlayer
                if player and player.Character and player.Character:FindFirstChild("Head") then
                    local playerHead = player.Character.Head
                    local sellArea = game:GetService("Workspace").sellAreaCircles:FindFirstChild("sellAreaCircle16")
                    if sellArea then
                        sellArea = sellArea:FindFirstChild("circleInner")
                        if sellArea then
                            for _, v in pairs(sellArea:GetDescendants()) do
                                if v.Name == "TouchInterest" and v.Parent then
                                    firetouchinterest(playerHead, v.Parent, 0)
                                    task.wait(0.1)
                                    firetouchinterest(playerHead, v.Parent, 1)
                                    break
                                end
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
        return taskHandle
    end,

    doC = function()
        local taskHandle
        taskHandle = task.spawn(function()
            while AutoC == true do
                local valleyCoins = game:GetService("Workspace"):FindFirstChild("spawnedCoins")
                if valleyCoins then
                    valleyCoins = valleyCoins:FindFirstChild("Valley")
                    if valleyCoins then
                        local coinNames = {"Pink Chi Crate", "Blue Chi Crate", "Chi Crate"}
                        for _, coinName in ipairs(coinNames) do
                            local coin = valleyCoins:FindFirstChild(coinName)
                            if coin then
                                teleportTo(coin.CFrame)
                                task.wait(0.1)
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
        return taskHandle
    end
}

-- 修复任务句柄存储
local taskHandles = {}

-- 修复自动功能开关
local function setupAutoToggle(toggleName, autoFunction)
    return function(state)
        getgenv()[toggleName] = state
        if state then
            taskHandles[toggleName] = autoFunction()
        else
            if taskHandles[toggleName] then
                task.cancel(taskHandles[toggleName])
                taskHandles[toggleName] = nil
            end
        end
    end
end

-- ========== 整合到迪脚本 ==========

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    task.wait()
    LocalPlayer = Players.LocalPlayer
end

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local camera = workspace.CurrentCamera

local function getDeviceType()
    local UserInputService = game:GetService("UserInputService")
    if UserInputService.TouchEnabled then
        if UserInputService.KeyboardEnabled then
            return "平板"
        else
            return "手机"
        end
    else
        return "电脑"
    end
end

local deviceType = getDeviceType()
local uiSize, uiPosition

if deviceType == "手机" then
    uiSize = UDim2.fromOffset(400, 240)
elseif deviceType == "平板" then
    uiSize = UDim2.fromOffset(450, 350)
else
    uiSize = UDim2.fromOffset(600, 500)
end
uiPosition = UDim2.new(0.5, 0, 0.5, 0)

WindUI.TransparencyValue = 0.15

WindUI:AddTheme({
    Name = "CyberBlue",
    Accent = "#18181b",
    Dialog = "#18181b",
    Outline = "#FFFFFF",
    Text = "#FFFFFF",
    Placeholder = "#000000",
    Background = "#0e0e10",
    Button = "#52525b",
    Icon = "#00f7ff"
})

WindUI:SetTheme("CyberBlue")

local playerName = LocalPlayer.Name
local displayName = LocalPlayer.DisplayName

WindUI:Notify({
    Title = "迪脚本通知",
    Content = "迪脚本v2加载完成",
    Duration = 2
})

local XiaoDi = WindUI:CreateWindow({
    Title = "迪脚本 v2",
    Icon = "rbxassetid://124019880670946",
    Author = "主作者：小迪",
    Folder = "迪脚本",
    Size = uiSize,
    Position = uiPosition,
    Theme = "CyberBlue",
    Background = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#1a1a1a"), Transparency = 0 },
        ["50"] = { Color = Color3.fromHex("#2c3e50"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#000000"), Transparency = 0 }
    }, { Rotation = 150 }),
    Transparent = true,
    HideSearchBar = false,
    User = {
        Enabled = true,
        Anonymous = false,
        Username = playerName,
        DisplayName = displayName,
        UserId = LocalPlayer.UserId,
        ThumbnailType = "AvatarBust",
        Callback = function()
            WindUI:Notify({
                Title = "用户信息",
                Content = "玩家:" .. LocalPlayer.Name,
                Duration = 3
            })
        end
    },
    SideBarWidth = deviceType == "手机" and 150 or 180,
    ScrollBarEnabled = true,
    CornerRadius = UDim.new(0, 14),
    DropShadow = true
})

XiaoDi:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "CyberBlue" and "Dark" or "CyberBlue")
    WindUI:Notify({
        Title = "提示",
        Content = "当前主题: "..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)

XiaoDi:EditOpenButton({
    Title = "打开迪脚本v2",
    Icon = "rbxassetid://124019880670946",
})

XiaoDi:SetToggleKey(Enum.KeyCode.N)

-- ========== 功能区划分 ==========
local FengYu = {
    ScriptInfo = XiaoDi:Section({ Title = "脚本信息", Opened = false, Icon = "info"}),
    NinjaLegend = XiaoDi:Section({ Title = "忍者传奇", Opened = true, Icon = "sword"}),
    AutoFarm = XiaoDi:Section({ Title = "自动刷取", Opened = false, Icon = "repeat"}),
    BossFarming = XiaoDi:Section({ Title = "Boss战斗", Opened = false, Icon = "skull"}),
    Teleports = XiaoDi:Section({ Title = "传送功能", Opened = false, Icon = "map-pin"}),
    PlayerFunctions = XiaoDi:Section({ Title = "玩家功能", Opened = false, Icon = "users"}),
    PetFunctions = XiaoDi:Section({ Title = "宠物功能", Opened = false, Icon = "package"}),
    OtherFunctions = XiaoDi:Section({ Title = "其他功能", Opened = false, Icon = "settings"})
}

local Feng = {
    ScriptInfo = FengYu.ScriptInfo:Tab({ Title = "公告", Icon = "info"}),
    PlayerInfo = FengYu.ScriptInfo:Tab({ Title = "玩家信息", Icon = "user"}),
    AuthorInfo = FengYu.ScriptInfo:Tab({ Title = "作者信息", Icon = "users"}),
    
    MainFunctions = FengYu.NinjaLegend:Tab({ Title = "主要功能", Icon = "zap"}),
    AutoFarmTab = FengYu.AutoFarm:Tab({ Title = "自动刷取", Icon = "repeat"}),
    BossTab = FengYu.BossFarming:Tab({ Title = "Boss功能", Icon = "skull"}),
    TeleportTab = FengYu.Teleports:Tab({ Title = "传送点", Icon = "map-pin"}),
    PlayerTab = FengYu.PlayerFunctions:Tab({ Title = "玩家管理", Icon = "users"}),
    PetTab = FengYu.PetFunctions:Tab({ Title = "宠物系统", Icon = "package"}),
    OtherTab = FengYu.OtherFunctions:Tab({ Title = "其他", Icon = "settings"})
}

-- ========== 脚本信息区 ==========
Feng.ScriptInfo:Code({
    Code = [[
欢迎使用迪脚本v2 - 忍者传奇专版
本脚本已优化修复所有功能
请安全使用，避免过度滥用
]],
})

Feng.PlayerInfo:Paragraph({
    Title = "玩家信息",
    Desc = "用户: " .. LocalPlayer.Name,
    Image = "user",
    ImageSize = 12
})

Feng.PlayerInfo:Paragraph({
    Title = "设备类型",
    Desc = "当前设备: " .. deviceType,
    Image = "gamepad",
    ImageSize = 12
})

Feng.AuthorInfo:Paragraph({
    Title = "主脚本作者",
    Desc = "小迪",
    Image = "rbxassetid://124019880670946",
    ImageSize = 50,
    Buttons = {
        {
            Title = "复制QQ号",
            Variant = "Primary",
            Callback = function()
                setclipboard("3954952871")
            end,
            Icon = "folder",
        },
        {
            Title = "复制QQ群",
            Variant = "Primary",
            Callback = function()
                setclipboard("908685870")
            end,
            Icon = "folder",
        },
    }
})

-- ========== 主要功能区 ==========
Feng.MainFunctions:Toggle({
    Title = "自动挥刀",
    Value = false,
    Callback = setupAutoToggle("AutoSwing", AutoFunctions.doSwing)
})

Feng.MainFunctions:Toggle({
    Title = "自动售卖",
    Value = false,
    Callback = setupAutoToggle("AutoSell", AutoFunctions.doSell)
})

Feng.MainFunctions:Toggle({
    Title = "自动升级",
    Value = false,
    Callback = setupAutoToggle("AutoR", AutoFunctions.doR)
})

Feng.MainFunctions:Toggle({
    Title = "自动称号",
    Value = false,
    Callback = setupAutoToggle("AutoB", AutoFunctions.doB)
})

Feng.MainFunctions:Toggle({
    Title = "自动买刀",
    Value = false,
    Callback = setupAutoToggle("AutoS", AutoFunctions.doS)
})

Feng.MainFunctions:Toggle({
    Title = "自动元素",
    Value = false,
    Callback = setupAutoToggle("AutoE", AutoFunctions.doE)
})

Feng.MainFunctions:Toggle({
    Title = "自动吸气",
    Value = false,
    Callback = setupAutoToggle("AutoC", AutoFunctions.doC)
})

Feng.MainFunctions:Button({
    Title = "解锁全部通行证",
    Callback = function()
        local gamepassIds = game:GetService("ReplicatedStorage"):FindFirstChild("gamepassIds")
        if gamepassIds then
            local passes = {
                "+2 Pet Slots", "+3 Pet Slots", "+4 Pet Slots",
                "+100 Capacity", "+200 Capacity", "+20 Capacity", "+60 Capacity",
                "Infinite Ammo", "Infinite Ninjitsu", "Permanent Islands Unlock",
                "x2 Coins", "x2 Damage", "x2 Health", "x2 Ninjitsu", "x2 Speed",
                "Faster Sword", "x3 Pet Clones"
            }
            
            for _, passName in ipairs(passes) do
                local pass = gamepassIds:FindFirstChild(passName)
                if pass then
                    pass.Parent = game.Players.LocalPlayer.ownedGamepasses
                end
            end
            WindUI:Notify({
                Title = "成功",
                Content = "已解锁所有通行证",
                Duration = 2
            })
        end
    end
})

-- ========== 自动刷取区 ==========
Feng.AutoFarmTab:Toggle({
    Title = "收集金币",
    Value = false,
    Callback = function(state)
        getgenv().AutoCoin = state
        if state then
            local coinTask
            coinTask = task.spawn(function()
                while getgenv().AutoCoin do
                    local valleyCoins = game.Workspace:FindFirstChild("spawnedCoins")
                    if valleyCoins then
                        valleyCoins = valleyCoins:FindFirstChild("Valley")
                        if valleyCoins then
                            for _, v in pairs(valleyCoins:GetChildren()) do
                                if v.Name == "Purple Coin Crate" then
                                    local player = game.Players.LocalPlayer
                                    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                        player.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
                                        task.wait(0.5)
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
            taskHandles.AutoCoin = coinTask
        else
            if taskHandles.AutoCoin then
                task.cancel(taskHandles.AutoCoin)
                taskHandles.AutoCoin = nil
            end
        end
    end
})

Feng.AutoFarmTab:Toggle({
    Title = "收集气",
    Value = false,
    Callback = function(state)
        getgenv().AutoChi = state
        if state then
            local chiTask
            chiTask = task.spawn(function()
                while getgenv().AutoChi do
                    local valleyCoins = game.Workspace:FindFirstChild("spawnedCoins")
                    if valleyCoins then
                        valleyCoins = valleyCoins:FindFirstChild("Valley")
                        if valleyCoins then
                            for _, v in pairs(valleyCoins:GetChildren()) do
                                if v.Name == "Blue Chi Crate" then
                                    local player = game.Players.LocalPlayer
                                    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                        player.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
                                        task.wait(0.5)
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
            taskHandles.AutoChi = chiTask
        else
            if taskHandles.AutoChi then
                task.cancel(taskHandles.AutoChi)
                taskHandles.AutoChi = nil
            end
        end
    end
})

-- ========== Boss功能区 ==========
Feng.BossTab:Toggle({
    Title = "普通Boss",
    Value = false,
    Callback = setupAutoToggle("AutoBo", AutoFunctions.doBo)
})

Feng.BossTab:Toggle({
    Title = "永恒Boss",
    Value = false,
    Callback = setupAutoToggle("AutoBo1", AutoFunctions.doBo1)
})

Feng.BossTab:Toggle({
    Title = "岩浆Boss",
    Value = false,
    Callback = setupAutoToggle("AutoBo2", AutoFunctions.doBo2)
})

-- ========== 传送功能区 ==========
local teleportLocations = {
    {"出生点", CFrame.new(25.665502548217773, 3.4228405952453613, 29.919952392578125)},
    {"附魔岛", CFrame.new(51.17238235473633, 766.1807861328125, -138.44842529296875)},
    {"星界岛", CFrame.new(207.2932891845703, 2013.88037109375, 237.36672973632812)},
    {"神秘岛", CFrame.new(171.97178649902344, 4047.380859375, 42.0699577331543)},
    {"太空岛", CFrame.new(148.83824157714844, 5657.18505859375, 73.5014877319336)},
    {"冻土岛", CFrame.new(139.28330993652344, 9285.18359375, 77.36406707763672)},
    {"永恒岛", CFrame.new(149.34817504882812, 13680.037109375, 73.3861312866211)},
    {"沙暴岛", CFrame.new(133.37144470214844, 17686.328125, 72.00334167480469)},
    {"雷暴岛", CFrame.new(143.19349670410156, 24070.021484375, 78.05432891845703)},
    {"远古炼狱岛", CFrame.new(141.27163696289062, 28256.294921875, 69.3790283203125)},
    {"午夜暗影岛", CFrame.new(132.74267578125, 33206.98046875, 57.495574951171875)},
    {"神秘灵魂岛", CFrame.new(137.76148986816406, 39317.5703125, 61.06639862060547)},
    {"冬季奇迹岛", CFrame.new(137.2720184326172, 46010.5546875, 55.941951751708984)},
    {"黄金大师岛", CFrame.new(128.32339477539062, 52607.765625, 56.69411849975586)},
    {"龙传奇岛", CFrame.new(146.35226440429688, 59594.6796875, 77.53300476074219)},
    {"赛博传奇岛", CFrame.new(137.3321075439453, 66669.1640625, 72.21722412109375)},
    {"天岚超能岛", CFrame.new(135.48077392578125, 70271.15625, 57.02311325073242)},
    {"混沌传奇岛", CFrame.new(148.58590698242188, 74442.8515625, 69.3177719116211)},
    {"灵魂融合岛", CFrame.new(136.9700927734375, 79746.984375, 58.54051971435547)},
    {"黑暗元素岛", CFrame.new(141.697265625, 83198.984375, 72.73107147216797)},
    {"内心和平岛", CFrame.new(135.3157501220703, 87051.0625, 66.78429412841797)},
    {"炽烈漩涡岛", CFrame.new(135.08216857910156, 91246.0703125, 69.56692504882812)},
    {"35倍金币区域", CFrame.new(86.2938232421875, 91245.765625, 120.54232788085938)},
    {"复制宠物", CFrame.new(4593.21337890625, 130.87181091308594, 1430.2239990234375)}
}

for _, location in ipairs(teleportLocations) do
    Feng.TeleportTab:Button({
        Title = "传送到" .. location[1],
        Callback = function()
            teleportTo(location[2])
            WindUI:Notify({
                Title = "传送成功",
                Content = "已传送到" .. location[1],
                Duration = 2
            })
        end
    })
end

-- ========== 玩家功能区 ==========
-- 初始化玩家列表
local PlayerList = {}
local Plr = game:GetService("Players")
getgenv().C_NPlayers = {}
getgenv().KillPlayers = {}
getgenv().KillEnabled = false
getgenv().MassKillEnabled = false

local function updatePlayerList()
    PlayerList = {}
    for _, player in pairs(Plr:GetPlayers()) do
        table.insert(PlayerList, player.Name)
    end
end

updatePlayerList()

Plr.PlayerAdded:Connect(function(player)
    if not table.find(PlayerList, player.Name) then
        table.insert(PlayerList, player.Name)
    end
end)

Plr.PlayerRemoving:Connect(function(player)
    if table.find(PlayerList, player.Name) then
        table.remove(PlayerList, table.find(PlayerList, player.Name))
    end
end)

-- 排除玩家下拉菜单
local excludeTargetsDropdown = Feng.PlayerTab:Dropdown({
    Title = "排除杀戮的玩家(多选)", 
    Values = PlayerList, 
    Value = {}, 
    Multi = true, 
    AllowNone = true, 
    Callback = function(d) 
        getgenv().C_NPlayers = d or {} 
    end
})

-- 杀戮目标下拉菜单
local killTargetsDropdown = Feng.PlayerTab:Dropdown({
    Title = "选择杀戮的玩家(多选)", 
    Values = PlayerList, 
    Value = {}, 
    Multi = true, 
    AllowNone = true, 
    Callback = function(d) 
        getgenv().KillPlayers = d or {} 
    end
})

-- 杀戮功能
local killTaskHandle
local function startKilling()
    killTaskHandle = task.spawn(function()
        local SpinSpeed = 5
        local Height = 1
        local Radius = 4
        
        while getgenv().KillEnabled do
            for _, playerName in pairs(getgenv().KillPlayers) do
                local player = Plr:FindFirstChild(playerName)
                if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local LP = game.Players.LocalPlayer
                    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                        LP.Character.HumanoidRootPart.CFrame = CFrame.new(
                            player.Character.HumanoidRootPart.Position + 
                            Vector3.new(
                                math.sin(tick() * SpinSpeed * math.pi) * Radius, 
                                Height, 
                                math.cos(tick() * SpinSpeed * math.pi) * Radius
                            ),
                            player.Character.HumanoidRootPart.Position
                        )
                        
                        workspace.Gravity = 0
                        
                        task.wait(0.1)
                        if LP.Character:FindFirstChildOfClass("Tool") then
                            local event = LP:FindFirstChild("ninjaEvent")
                            if event then
                                event:FireServer("swingKatana")
                            end
                        else
                            local backpack = LP:FindFirstChild("Backpack")
                            if backpack then
                                for _, tool in pairs(backpack:GetChildren()) do
                                    if tool.ClassName == "Tool" then
                                        if LP.Character:FindFirstChild("Humanoid") then
                                            LP.Character.Humanoid:EquipTool(tool)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.1)
        end
        workspace.Gravity = 196.2
    end)
end

Feng.PlayerTab:Toggle({
    Title = "开始杀戮",
    Value = false,
    Callback = function(value)
        getgenv().KillEnabled = value
        if value then
            startKilling()
        else
            if killTaskHandle then
                task.cancel(killTaskHandle)
                killTaskHandle = nil
            end
            workspace.Gravity = 196.2
        end
    end
})

-- 全体杀戮
local massKillTaskHandle
Feng.PlayerTab:Toggle({
    Title = "全体杀戮",
    Value = false,
    Callback = function(value)
        getgenv().MassKillEnabled = value
        if value then
            massKillTaskHandle = task.spawn(function()
                local SpinSpeed = 5
                local Height = 1
                local Radius = 4
                
                while getgenv().MassKillEnabled do
                    for _, player in pairs(Plr:GetPlayers()) do
                        if player ~= game.Players.LocalPlayer and not table.find(getgenv().C_NPlayers, player.Name) then
                            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local LP = game.Players.LocalPlayer
                                if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                                    LP.Character.HumanoidRootPart.CFrame = CFrame.new(
                                        player.Character.HumanoidRootPart.Position + 
                                        Vector3.new(
                                            math.sin(tick() * SpinSpeed * math.pi) * Radius, 
                                            Height, 
                                            math.cos(tick() * SpinSpeed * math.pi) * Radius
                                        ),
                                        player.Character.HumanoidRootPart.Position
                                    )
                                    
                                    workspace.Gravity = 0
                                    
                                    task.wait(0.1)
                                    if LP.Character:FindFirstChildOfClass("Tool") then
                                        local event = LP:FindFirstChild("ninjaEvent")
                                        if event then
                                            event:FireServer("swingKatana")
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.1)
                end
                workspace.Gravity = 196.2
            end)
        else
            if massKillTaskHandle then
                task.cancel(massKillTaskHandle)
                massKillTaskHandle = nil
            end
            workspace.Gravity = 196.2
        end
    end
})

Feng.PlayerTab:Button({
    Title = "刷新玩家列表", 
    Callback = function()
        updatePlayerList()
        excludeTargetsDropdown:Refresh(PlayerList)
        killTargetsDropdown:Refresh(PlayerList)
        WindUI:Notify({
            Title = "已刷新",
            Content = "玩家列表已更新",
            Duration = 2
        })
    end
})

-- ========== 宠物功能区 ==========
local eggs = {}
local mapCrystals = game.Workspace:FindFirstChild("mapCrystalsFolder")
if mapCrystals then
    for _, crystal in pairs(mapCrystals:GetChildren()) do
        table.insert(eggs, crystal.Name)
    end
end

local selectegg = ""
Feng.PetTab:Dropdown({
    Title = "选择抽奖机", 
    Values = eggs,
    Value = "",
    Callback = function(selectedEgg)
        selectegg = selectedEgg
    end
})

Feng.PetTab:Toggle({
    Title = "自动购买", 
    Value = false,
    Callback = function(open)
        getgenv().openegg = open
        if open then
            local eggTask
            eggTask = task.spawn(function()
                while getgenv().openegg and selectegg ~= "" do
                    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("rEvents")
                    if remote then
                        remote = remote:FindFirstChild("openCrystalRemote")
                        if remote then
                            remote:InvokeServer("openCrystal", selectegg)
                        end
                    end
                    task.wait(0.1)
                end
            end)
            taskHandles.openegg = eggTask
        else
            if taskHandles.openegg then
                task.cancel(taskHandles.openegg)
                taskHandles.openegg = nil
            end
        end
    end
})

-- ========== 其他功能区 ==========
Feng.OtherTab:Input({
    Title = "修改连跳次数",
    Placeholder = "输入连跳次数",
    Callback = function(Value)
        local value = tonumber(Value)
        if value then
            local player = game.Players.LocalPlayer
            local multiJump = player:FindFirstChild("multiJumpCount")
            if multiJump then
                multiJump.Value = value
                WindUI:Notify({
                    Title = "修改成功",
                    Content = "连跳次数已设置为: " .. value,
                    Duration = 2
                })
            end
        end
    end
})

Feng.OtherTab:Divider()

Feng.OtherTab:Button({
    Title = "解锁所有岛屿",
    Callback = function()
        local positions = {
            CFrame.new(26, 766, -114),
            CFrame.new(247, 2013, 347),
            CFrame.new(162, 4047, 13),
            CFrame.new(200, 5656, 13),
            CFrame.new(200, 9284, 13),
            CFrame.new(200, 13679, 13),
            CFrame.new(200, 17686, 13),
            CFrame.new(200, 24069, 13),
            CFrame.new(197, 28256, 7),
            CFrame.new(197, 33206, 7),
            CFrame.new(197, 39317, 7),
            CFrame.new(197, 46010, 7),
            CFrame.new(197, 52607, 7),
            CFrame.new(197, 59594, 7),
            CFrame.new(197, 66668, 7),
            CFrame.new(197, 70270, 7),
            CFrame.new(197, 74442, 7),
            CFrame.new(197, 79746, 7),
            CFrame.new(197, 83198, 7),
            CFrame.new(197, 91245, 7)
        }
        
        for i, pos in ipairs(positions) do
            teleportTo(pos)
            task.wait(0.1)
        end
        WindUI:Notify({
            Title = "完成",
            Content = "已解锁所有岛屿",
            Duration = 2
        })
    end
})

Feng.OtherTab:Button({
    Title = "获取所有宝箱",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Head") then
            local playerHead = player.Character.Head
            local chests = {
                "ultraNinjitsuChest", "mythicalChest", "goldenChest", "enchantedChest",
                "magmaChest", "legendsChest", "saharaChest", "eternalChest",
                "ancientChest", "midnightShadowChest", "wonderChest", "goldenZenChest",
                "skystormMastersChest", "chaosLegendsChest", "soulFusionChest"
            }
            
            for _, chestName in ipairs(chests) do
                local chest = game:GetService("Workspace"):FindFirstChild(chestName)
                if chest and chest:FindFirstChild("circleInner") then
                    for _, v in pairs(chest.circleInner:GetDescendants()) do
                        if v.Name == "TouchInterest" and v.Parent then
                            firetouchinterest(playerHead, v.Parent, 0)
                            task.wait(0.1)
                            firetouchinterest(playerHead, v.Parent, 1)
                            task.wait(0.1)
                        end
                    end
                end
            end
            WindUI:Notify({
                Title = "完成",
                Content = "已尝试获取所有宝箱",
                Duration = 2
            })
        end
    end
})

Feng.OtherTab:Divider()

-- 吸星大法功能
local isStarAbsorbRunning = false
Feng.OtherTab:Toggle({
    Title = "吸星大法",
    Value = false,
    Callback = function(state)
        if state and not isStarAbsorbRunning then
            isStarAbsorbRunning = true
            local starTask
            starTask = task.spawn(function()
                while isStarAbsorbRunning do
                    local player = game.Players.LocalPlayer
                    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local playerCFrame = player.Character.HumanoidRootPart.CFrame
                        local hoops = workspace:FindFirstChild("Hoops")
                        if hoops then
                            for _, child in pairs(hoops:GetChildren()) do
                                if child.Name == "Hoop" then
                                    child.CFrame = playerCFrame
                                end
                            end
                        end
                    end
                    task.wait()
                end
            end)
            taskHandles.StarAbsorb = starTask
        else
            isStarAbsorbRunning = false
            if taskHandles.StarAbsorb then
                task.cancel(taskHandles.StarAbsorb)
                taskHandles.StarAbsorb = nil
            end
        end
    end
})

WindUI:Notify({
    Title = "脚本加载完成",
    Content = "忍者传奇功能已整合完毕",
    Duration = 3
})
