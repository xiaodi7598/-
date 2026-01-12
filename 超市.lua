-- 播放音效部分
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
end)

task.delay(10, function()
    if sound and sound.Parent and not sound.IsPlaying then
        sound:Destroy()
    end
end)

-- 加载WindUI库
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

while not LocalPlayer do
    wait()
    LocalPlayer = Players.LocalPlayer
end

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
    Practical = XiaoDi:Section({ Title = "超市生活", Opened = false, Icon = "user"}),
}

local Feng = {
    Aut = FengYu.us:Tab({ Title = "公告", Icon = "info"}),
    player = FengYu.us:Tab({ Title = "玩家信息", Icon = "info"}),
    me = FengYu.us:Tab({ Title = "作者信息", Icon = "info"}),
    DiOne = FengYu.Practical:Tab({ Title = "超市生活", Icon = "folder"}),
}

-- 公告标签
Feng.Aut:Code({
    Code = [[
欢迎大家游玩迪脚本
制作团队已将大部分的脚本修改
以方便大家游玩
如果你对我们的脚本感兴趣就来加入我们的群吧
如果你有脚本群也帮我们宣传
谢谢了]],
})

-- 玩家信息标签
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

-- 作者信息标签
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

-- ========== 超市生活功能（完全保留原始逻辑）==========
-- 自动收集食物
local foodThread
Feng.DiOne:Toggle({
    Title = "自动收集食物",
    Icon = "shopping-bag",
    Callback = function(state)
        if state then
            foodThread = task.spawn(function()
                while true do
                    for _, v in next, workspace.Map.Util.Items:GetChildren() do
                        if v.ToolStats.ItemType.Value == "Food" then
                            game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                        end
                    end
                    task.wait()
                end
            end)
        elseif foodThread then
            task.cancel(foodThread)
            foodThread = nil
        end
    end
})

-- 自动收集手电筒
local flashlightThread
Feng.DiOne:Toggle({
    Title = "自动收集手电筒",
    Icon = "zap",
    Callback = function(state)
        if state then
            flashlightThread = task.spawn(function()
                while true do
                    for _, v in next, workspace.Map.Util.Items:GetChildren() do
                        if v.ToolStats.ItemType.Value == "Flashlight" then
                            game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                        end
                    end
                    task.wait()
                end
            end)
        elseif flashlightThread then
            task.cancel(flashlightThread)
            flashlightThread = nil
        end
    end
})

-- 自动收集近战武器
local meleeThread
Feng.DiOne:Toggle({
    Title = "自动收集近战武器",
    Icon = "sword",
    Callback = function(state)
        if state then
            meleeThread = task.spawn(function()
                while true do
                    for _, v in next, workspace.Map.Util.Items:GetChildren() do
                        if v.ToolStats.ItemType.Value == "Melee" then
                            game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                        end
                    end
                    task.wait()
                end
            end)
        elseif meleeThread then
            task.cancel(meleeThread)
            meleeThread = nil
        end
    end
})

-- 自动收集枪
local gunThread
Feng.DiOne:Toggle({
    Title = "自动收集枪",
    Icon = "gun",
    Callback = function(state)
        if state then
            gunThread = task.spawn(function()
                while true do
                    for _, v in next, workspace.Map.Util.Items:GetChildren() do
                        if v.ToolStats.ItemType.Value == "Gun" then
                            game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                        end
                    end
                    task.wait()
                end
            end)
        elseif gunThread then
            task.cancel(gunThread)
            gunThread = nil
        end
    end
})

-- 自动收集药品
local healthThread
Feng.DiOne:Toggle({
    Title = "自动收集药品",
    Icon = "heart",
    Callback = function(state)
        if state then
            healthThread = task.spawn(function()
                while true do
                    for _, v in next, workspace.Map.Util.Items:GetChildren() do
                        if v.ToolStats.ItemType.Value == "Health" then
                            game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                        end
                    end
                    task.wait()
                end
            end)
        elseif healthThread then
            task.cancel(healthThread)
            healthThread = nil
        end
    end
})

-- 自动装弹（修正了v参数）
local reloadThread
Feng.DiOne:Toggle({
    Title = "自动装弹",
    Icon = "loader",
    Callback = function(state)
        if state then
            reloadThread = task.spawn(function()
                while true do
                    -- 尝试装弹，v参数根据游戏实际情况可能需要调整
                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes.Weapon.GunReloaded:FireServer()
                    end)
                    task.wait(0.1) -- 添加短暂延迟
                end
            end)
        elseif reloadThread then
            task.cancel(reloadThread)
            reloadThread = nil
        end
    end
})

-- 自动开枪（保留原始逻辑）
local shootThread
Feng.DiOne:Toggle({
    Title = "自动开枪",
    Icon = "target",
    Callback = function(state)
        if state then
            shootThread = task.spawn(function()
                while true do
                    for _, v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
                        if v:FindFirstChild("ToolStats") and v.ToolStats:FindFirstChild("Ammo") then
                            for _, e in next, workspace.Enemies:GetChildren() do
                                if e.Humanoid.Health > 0 then
                                    local BulletsPerShot = v.ToolStats.BulletsPerShot.Value
                                    local DirectionTbl = {}
                                    for i = 1, BulletsPerShot do
                                        table.insert(DirectionTbl, Vector3.new(e.Head.Position.X, e.Head.Position.Y, e.Head.Position.Z).Unit)
                                    end
                                    local args = {
                                        [1] = {
                                            ["FiringPlayer"] = game:GetService("Players").LocalPlayer,
                                            ["FiredTime"] = os.time(),
                                            ["FiringPlayerUserId"] = game.Players.LocalPlayer.UserId,
                                            ["Origin"] = Vector3.new(game.Players.LocalPlayer.Character:GetPivot().Position),
                                            ["UID"] = game.Players.LocalPlayer.UserId .. "_1",
                                            ["WeaponInstance"] = v,
                                            ["ThisBulletProperties"] = {
                                                ["BulletSpread"] = v.ToolStats.BulletSpread.Value,
                                                ["BulletsPerShot"] = v.ToolStats.BulletsPerShot.Value,
                                                ["BulletPenetration"] = v.ToolStats.BulletPenetration.Value,
                                                ["BulletSpeed"] = v.ToolStats.BulletSpeed.Value,
                                                ["FireSound"] = v.ToolStats.FireSound.Value,
                                                ["BulletSize"] = v.ToolStats.BulletSize.Value
                                            },
                                            ["DirectionTbl"] = DirectionTbl
                                        }
                                    }
                                    game:GetService("ReplicatedStorage").Remotes.Weapon.GunFired:FireServer(unpack(args))
                                end
                            end
                        end
                    end
                    task.wait()
                end
            end)
        elseif shootThread then
            task.cancel(shootThread)
            shootThread = nil
        end
    end
})

-- 修改超级枪（修正了背包引用）
local superGunThread
Feng.DiOne:Toggle({
    Title = "修改超级枪",
    Icon = "zap",
    Callback = function(state)
        if state then
            superGunThread = task.spawn(function()
                while true do
                    for _, v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
                        if v.ToolStats:FindFirstChild("Ammo") then
                            v.ToolStats.ReloadTime.Value = 0
                            v.ToolStats.FireDelay.Value = 0
                            v.ToolStats.Ammo.Value = math.huge
                            v.ToolStats.Damage.Value = math.huge
                        end
                    end
                    task.wait(0.5) -- 降低频率
                end
            end)
        elseif superGunThread then
            task.cancel(superGunThread)
            superGunThread = nil
        end
    end
})

-- 无限体力和饥饿度（保留原始逻辑）
local infiniteThread
Feng.DiOne:Toggle({
    Title = "无限体力和饥饿度",
    Icon = "battery",
    Callback = function(state)
        if state then
            infiniteThread = task.spawn(function()
                while true do
                    local charData = game.Players.LocalPlayer.Character.CharacterData
                    if charData then
                        charData.MaxStamina.Value = math.huge
                        charData.MaxEnergy.Value = math.huge
                        charData.Energy.Value = charData.MaxEnergy.Value
                        charData.Stamina.Value = charData.MaxStamina.Value
                    end
                    task.wait(0.5) -- 降低频率
                end
            end)
        elseif infiniteThread then
            task.cancel(infiniteThread)
            infiniteThread = nil
        end
    end
})

-- 夜晚自动躲避（修正了语法错误）
local nightThread
local oldpos
Feng.DiOne:Toggle({
    Title = "夜晚自动躲避",
    Icon = "moon",
    Callback = function(state)
        if state then
            nightThread = task.spawn(function()
                while true do
                    if game:GetService("ReplicatedStorage").GameInfo.TimeOfDay.Value == "Night" then
                        if not oldpos then
                            oldpos = game.Players.LocalPlayer.Character:GetPivot().Position
                        end
                        
                        repeat 
                            task.wait()
                            game.Players.LocalPlayer.Character:PivotTo(CFrame.new(306.18927001953125, 36.67450714111328, -519.2435913085938))
                            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                            if hrp then
                                hrp.Anchored = true
                            end
                        until game:GetService("ReplicatedStorage").GameInfo.TimeOfDay.Value ~= "Night"
                        
                        local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                        if hrp then
                            hrp.Anchored = false
                            hrp.CFrame = CFrame.new(oldpos)
                        end
                        oldpos = nil
                    else
                        task.wait(1)
                    end
                end
            end)
        elseif nightThread then
            task.cancel(nightThread)
            nightThread = nil
            
            -- 重置状态
            if oldpos then
                local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                if hrp then
                    hrp.Anchored = false
                    hrp.CFrame = CFrame.new(oldpos)
                end
                oldpos = nil
            end
        end
    end
})

-- 添加关闭所有功能按钮
Feng.DiOne:Button({
    Title = "关闭所有功能",
    Icon = "power",
    Variant = "Destructive",
    Callback = function()
        -- 停止所有线程
        local threads = {
            foodThread, flashlightThread, meleeThread, gunThread, healthThread,
            reloadThread, shootThread, superGunThread, infiniteThread, nightThread
        }
        
        for _, thread in pairs(threads) do
            if thread then
                task.cancel(thread)
                thread = nil
            end
        end
        
        -- 重置夜晚躲避状态
        if oldpos then
            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
            if hrp then
                hrp.Anchored = false
                hrp.CFrame = CFrame.new(oldpos)
            end
            oldpos = nil
        end
        
        WindUI:Notify({
            Title = "系统",
            Content = "已关闭所有超市生活功能",
            Duration = 3
        })
    end
})

-- 添加功能说明
Feng.DiOne:Label({
    Title = "超市生活功能",
    Desc = "所有功能已按照原始逻辑修复"
})

Feng.DiOne:Paragraph({
    Title = "温馨提示",
    Desc = "使用功能时请注意游戏规则，适度使用",
    Image = "info",
    ImageSize = 12
})
