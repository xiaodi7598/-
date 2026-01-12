local soundId = "rbxassetid://88457346646245"
local Workspace = game:GetService("Workspace")

local sound = Instance.new("Sound")
sound.SoundId = soundId
sound.Looped = false
sound.Volume = 0.5
sound.Parent = Workspace
sound:Play()

sound.Ended:Connect(function()
    sound:Destroy()
    warn("音效已播放完毕并销毁")
end)

task.delay(10, function()
    if sound and sound.Parent and not sound.IsPlaying then
        sound:Destroy()
        warn("音效加载超时/未播放，已自动销毁")
    end
end)

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    wait()
    LocalPlayer = Players.LocalPlayer
end

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local camera = workspace.CurrentCamera
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

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

WindUI:Notify({
    Title = "迪脚本通知",
    Content = "V2是新做的，后面会增加服务器功能和自制功能",
    Duration = 2
})

local XiaoDi = WindUI:CreateWindow({
    Title = "迪脚本 v2服务器功能",
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

local FengYu = {
    us = XiaoDi:Section({ Title = "脚本信息", Opened = false, Icon = "user"}),
    Practical = XiaoDi:Section({ Title = "力量传奇", Opened = false, Icon = "user"}),
}

local Feng = {
    Aut = FengYu.us:Tab({ Title = "公告", Icon = "info"}),
    player = FengYu.us:Tab({ Title = "玩家信息", Icon = "info"}),
    me = FengYu.us:Tab({ Title = "作者信息", Icon = "info"}),
    DiOne = FengYu.Practical:Tab({ Title = "力量传奇", Icon = "folder"}),
}

Feng.Aut:Code({
    Code = [[
欢迎大家游玩迪脚本
制作团队已将大部分的脚本修改
以方便大家游玩
如果你对我们的脚本感兴趣就来加入我们的群吧
如果你有脚本群也帮我们宣传
谢谢了]],
})

Feng.player:Paragraph({
    Title = "玩家",
    Desc = "迪脚本用户: " .. LocalPlayer.Name .. "欢迎游玩",
    Image = "user",
    ImageSize = 12
})

Feng.player:Paragraph({
    Title = "设备",
    Desc = "你的设备: " .. deviceType,
    Image = "gamepad",
    ImageSize = 12
})

Feng.player:Paragraph({
    Title = "监控",
    Desc = "你的注入器: " .. identifyexecutor(),
    Image = "syringe",
    ImageSize = 12
})

Feng.me:Paragraph({
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

Feng.me:Paragraph({
    Title = "👤程序病毒",
    Desc = "风御 X",
    Image = "rbxassetid://96338123345158",
    ImageSize = 50,
    Buttons = {
        {
            Title = "复制QQ号",
            Variant = "Primary",
            Callback = function()
                setclipboard("1926190957")
            end,
            Icon = "info",
        },
        {
            Title = "复制QQ群",
            Variant = "Primary",
            Callback = function()
                setclipboard("群")
            end,
            Icon = "info",
        },
    }
})

-- ==============================
-- 力量传奇功能（完整版）
-- ==============================

-- 自动功能
Feng.DiOne:Input({
    Title = "修改力量",
    Value = "输入数值",
    Callback = function(FXM)
        local value = tonumber(FXM)
        if value then
            game:GetService("Players").LocalPlayer.leaderstats.Strength.Value = value
        end
    end
})

Feng.DiOne:Input({
    Title = "修改重生",
    Value = "输入数值",
    Callback = function(FXM)
        local value = tonumber(FXM)
        if value then
            game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value = value
        end
    end
})

Feng.DiOne:Input({
    Title = "修改击杀",
    Value = "输入数值",
    Callback = function(FXM)
        local value = tonumber(FXM)
        if value then
            game:GetService("Players").LocalPlayer.leaderstats.Kills.Value = value
        end
    end
})

Feng.DiOne:Input({
    Title = "修改获胜",
    Value = "输入数值",
    Callback = function(FXM)
        local value = tonumber(FXM)
        if value then
            game:GetService("Players").LocalPlayer.leaderstats.Brawls.Value = value
        end
    end
})

Feng.DiOne:Divider()

-- 自动重生
local AutoRebirthThread
Feng.DiOne:Toggle({
    Title = "自动重生",
    Desc = "",
    Locked = false,
    Callback = function(Value)
        if AutoRebirthThread then
            task.cancel(AutoRebirthThread)
            AutoRebirthThread = nil
        end
        
        if Value then
            AutoRebirthThread = task.spawn(function()
                while Value do
                    pcall(function()
                        game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                    end)
                    task.wait()
                end
            end)
        end
    end
})

-- 自动修改体积
local AutoSizeThread
Feng.DiOne:Toggle({
    Title = "自动修改体积为2",
    Desc = "",
    Locked = false,
    Callback = function(Value)
        if AutoSizeThread then
            task.cancel(AutoSizeThread)
            AutoSizeThread = nil
        end
        
        if Value then
            AutoSizeThread = task.spawn(function()
                while Value do
                    pcall(function()
                        game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 2)
                    end)
                    task.wait()
                end
            end)
        end
    end
})

-- 自动传送肌肉之王
local AutoTeleportThread
Feng.DiOne:Toggle({
    Title = "自动传送肌肉之王",
    Desc = "",
    Locked = false,
    Callback = function(Value)
        if AutoTeleportThread then
            task.cancel(AutoTeleportThread)
            AutoTeleportThread = nil
        end
        
        if Value then
            AutoTeleportThread = task.spawn(function()
                while Value do
                    pcall(function()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8625.9296875, 13.566278457641602, -5730.4736328125)
                    end)
                    task.wait()
                end
            end)
        end
    end
})

Feng.DiOne:Divider()

-- 自动宝箱传送
Feng.DiOne:Button({
    Title = "自动宝箱（传送+检测）[重复2次]",
    Desc = "",
    Locked = false,
    Callback = function()
        local function showNotice(msg)
            WindUI:Notify({
                Title = "宝箱流程",
                Content = msg,
                Duration = 3
            })
        end
        
        task.spawn(function()
            local repeatTimes = 2
            for cycle = 1, repeatTimes do
                showNotice(string.format("开始第 %d/%d 轮宝箱流程", cycle, repeatTimes))
                
                local teleportPoints = {
                    CFrame.new(-138.17, 7.33, -276.85),        
                    CFrame.new(4680.29, 1001.05, -3689.63),    
                    CFrame.new(2213.03, 7.33, 918.64),    
                    CFrame.new(-6713.86, 7.33, -1454.19),  
                    CFrame.new(-2572.08, 7.33, -556.94),        
                    CFrame.new(40.71, 7.33, 410.27),    
                    CFrame.new(-7914.54, 4.30, 3028.47)
                }
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local rootPart = character:WaitForChild("HumanoidRootPart")
                
                for _, targetCFrame in ipairs(teleportPoints) do
                    rootPart.CFrame = targetCFrame
                    task.wait(5)
                end
                
                showNotice("本轮传送已完成，准备检测宝箱")
                
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local chestRewards = ReplicatedStorage:FindFirstChild("chestRewards")
                local checkRemote = ReplicatedStorage:FindFirstChild("rEvents"):FindFirstChild("checkChestRemote")
                
                if chestRewards and checkRemote then
                    local jk = {}
                    for _, v in pairs(chestRewards:GetDescendants()) do
                        if v.Name ~= "Light Karma Chest" and v.Name ~= "Evil Karma Chest" then
                            table.insert(jk, v.Name)
                        end
                    end
                    
                    for _, chestName in ipairs(jk) do
                        checkRemote:InvokeServer(chestName)
                        task.wait(2)
                    end
                end
                
                showNotice(string.format("第 %d/%d 轮宝箱检测完成", cycle, repeatTimes))
                showNotice("等待3秒后进入下一轮")
                task.wait(3)
            end
            
            showNotice("所有2轮宝箱流程已执行完毕！")
        end)
    end
})

Feng.DiOne:Divider()

-- 传送点按钮
local teleportButtons = {
    {Title = "沙滩", CFrame = CFrame.new(-42.7, 3.7, 404.2)},
    {Title = "小岛（0-1000力量）", CFrame = CFrame.new(-37.636775970458984, 3.86960768699646, 1879.180908203125)},
    {Title = "冰霜健身房（1重生）", CFrame = CFrame.new(-2623.022216796875, 3.716249465942383, -409.0733337402344)},
    {Title = "神话健身房（5重生）", CFrame = CFrame.new(2250.778076171875, 3.716248035430908, 1073.2266845703125)},
    {Title = "永恒健身房（15重生）", CFrame = CFrame.new(-6758.9638671875, 3.71626353263855, -1284.918701171875)},
    {Title = "传奇健身房（30重生）", CFrame = CFrame.new(4603.28173828125, 987.869140625, -3897.86572265625)},
    {Title = "力量之王健身房（5重生）", CFrame = CFrame.new(-8625.9296875, 13.566278457641602, -5730.4736328125)},
    {Title = "狂野健身房（60重生）", CFrame = CFrame.new(-8693.0927734375, 8.93972396850586, 2400.66259765625)},
}

for _, btn in ipairs(teleportButtons) do
    Feng.DiOne:Button({
        Title = btn.Title,
        Desc = "",
        Locked = false,
        Callback = function()
            local char = game.Players.LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = btn.CFrame
                end
            end
        end
    })
end

Feng.DiOne:Divider()

-- 自动锻炼
local AutoTrainThread
Feng.DiOne:Toggle({
    Title = "自动锻炼",
    Desc = "",
    Locked = false,
    Callback = function(Value)
        if AutoTrainThread then
            task.cancel(AutoTrainThread)
            AutoTrainThread = nil
        end
        
        if Value then
            AutoTrainThread = task.spawn(function()
                while Value do
                    local muscleEvent = game.Players.LocalPlayer:FindFirstChild("muscleEvent")
                    if muscleEvent then
                        muscleEvent:FireServer("rep")
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

-- 自动挥拳
local AutoPunchThread
Feng.DiOne:Toggle({
    Title = "自动挥拳",
    Desc = "",
    Locked = false,
    Callback = function(Value)
        if AutoPunchThread then
            task.cancel(AutoPunchThread)
            AutoPunchThread = nil
        end
        
        if Value then
            AutoPunchThread = task.spawn(function()
                while Value do
                    local muscleEvent = game.Players.LocalPlayer:FindFirstChild("muscleEvent")
                    if muscleEvent then
                        muscleEvent:FireServer("punch", "rightHand")
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

Feng.DiOne:Divider()

-- 跑步机海滩10
Feng.DiOne:Toggle({
    Title = "跑步机海滩10",
    Desc = "",
    Locked = false,
    Callback = function(treadmill)
        if treadmill then
            local char = game.Players.LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChild("Humanoid")
                local hrp = char:FindFirstChild("HumanoidRootPart")
                
                if humanoid and hrp then
                    humanoid.WalkSpeed = 10
                    hrp.CFrame = CFrame.new(238.671112, 5.40315914, 387.713165, -0.0160072874, -2.90710176e-08, -0.99987185, -3.3434191e-09, 1, -2.90212157e-08, 0.99987185, 2.87843993e-09, -0.0160072874)
                    
                    local RunService = game:GetService("RunService")
                    RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function()
                        if humanoid then
                            humanoid:Move(Vector3.new(10000, 0, -1), true)
                        end
                    end)
                end
            end
        else
            game:GetService("RunService"):UnbindFromRenderStep("move")
        end
    end
})

Feng.DiOne:Divider()

-- 沙滩蹲起
local SquatThread
Feng.DiOne:Toggle({
    Title = "沙滩蹲起",
    Desc = "",
    Locked = false,
    Callback = function(rack)
        if rack then
            SquatThread = task.spawn(function()
                while rack do
                    local player = game.Players.LocalPlayer
                    if player.machineInUse.Value == nil then
                        local char = player.Character
                        if char then
                            local hrp = char:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                hrp.CFrame = CFrame.new(232.627625, 3.67689133, 96.3039856, -0.963445187, -7.78685845e-08, -0.267905563, -7.92865222e-08, 1, -5.52570167e-09, 0.267905563, 1.5917589e-08, -0.963445187)
                            end
                        end
                        local vim = game:service("VirtualInputManager")
                        vim:SendKeyEvent(true, "E", false, game)
                    else
                        local muscleEvent = player:FindFirstChild("muscleEvent")
                        if muscleEvent then
                            muscleEvent:FireServer("rep", game:GetService("Workspace").machinesFolder["Squat Rack"].interactSeat)
                        end
                    end
                    task.wait()
                end
            end)
        elseif SquatThread then
            task.cancel(SquatThread)
            SquatThread = nil
        end
    end
})

Feng.DiOne:Divider()

-- 海滩引体向上
local PullupThread
Feng.DiOne:Toggle({
    Title = "海滩引体向上",
    Desc = "",
    Locked = false,
    Callback = function(pull)
        if pull then
            PullupThread = task.spawn(function()
                while pull do
                    local player = game.Players.LocalPlayer
                    if player.machineInUse.Value == nil then
                        local char = player.Character
                        if char then
                            local hrp = char:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                hrp.CFrame = CFrame.new(-185.157745, 5.81071186, 104.747154, 0.227061391, -8.2363325e-09, 0.97388047, 5.58502826e-08, 1, -4.56432803e-09, -0.97388047, 5.54278827e-08, 0.227061391)
                            end
                        end
                        local vim = game:service("VirtualInputManager")
                        vim:SendKeyEvent(true, "E", false, game)
                    else
                        local muscleEvent = player:FindFirstChild("muscleEvent")
                        if muscleEvent then
                            local pullupMachine = game:GetService("Workspace").machinesFolder:FindFirstChild("Legends Pullup") or
                                                 game:GetService("Workspace").machinesFolder:FindFirstChild("Pullup Bar")
                            if pullupMachine and pullupMachine:FindFirstChild("interactSeat") then
                                muscleEvent:FireServer("rep", pullupMachine.interactSeat)
                            end
                        end
                    end
                    task.wait()
                end
            end)
        elseif PullupThread then
            task.cancel(PullupThread)
            PullupThread = nil
        end
    end
})

Feng.DiOne:Divider()

-- 海滩举重
local DeadliftThread
Feng.DiOne:Toggle({
    Title = "海滩举重",
    Desc = "",
    Locked = false,
    Callback = function(lift)
        if lift then
            DeadliftThread = task.spawn(function()
                while lift do
                    local player = game.Players.LocalPlayer
                    if player.machineInUse.Value == nil then
                        local char = player.Character
                        if char then
                            local hrp = char:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                hrp.CFrame = CFrame.new(136.606216, 3.67689133, 97.661499, -0.974106729, -1.89495477e-08, 0.226088539, -1.78365624e-08, 1, 6.96555214e-09, -0.226088539, 2.75254886e-09, -0.974106729)
                            end
                        end
                        local vim = game:service("VirtualInputManager")
                        vim:SendKeyEvent(true, "E", false, game)
                    else
                        local muscleEvent = player:FindFirstChild("muscleEvent")
                        if muscleEvent then
                            muscleEvent:FireServer("rep", game:GetService("Workspace").machinesFolder.Deadlift.interactSeat)
                        end
                    end
                    task.wait()
                end
            end)
        elseif DeadliftThread then
            task.cancel(DeadliftThread)
            DeadliftThread = nil
        end
    end
})

Feng.DiOne:Divider()

-- 海滩投石
local ThrowingThread
Feng.DiOne:Toggle({
    Title = "海滩投石",
    Desc = "",
    Locked = false,
    Callback = function(lift)
        if lift then
            ThrowingThread = task.spawn(function()
                while lift do
                    local player = game.Players.LocalPlayer
                    if player.machineInUse.Value == nil then
                        local char = player.Character
                        if char then
                            local hrp = char:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                hrp.CFrame = CFrame.new(-91.6730804, 3.67689133, -292.42868, -0.221022144, -2.21041621e-08, -0.975268781, 1.21414407e-08, 1, -2.54162646e-08, 0.975268781, -1.7458726e-08, -0.221022144)
                            end
                        end
                        local vim = game:service("VirtualInputManager")
                        vim:SendKeyEvent(true, "E", false, game)
                    else
                        local muscleEvent = player:FindFirstChild("muscleEvent")
                        if muscleEvent then
                            muscleEvent:FireServer("rep", game:GetService("Workspace").machinesFolder.Deadlift.interactSeat)
                        end
                    end
                    task.wait()
                end
            end)
        elseif ThrowingThread then
            task.cancel(ThrowingThread)
            ThrowingThread = nil
        end
    end
})

WindUI:Notify({
    Title = "迪脚本v2",
    Content = "力量传奇功能已整合完成！",
    Duration = 3
})
