local soundId = "rbxassetid://88457346646245" -- 请确认此音效内容完全合规
local Workspace = game:GetService("Workspace")

-- 创建音效对象
local sound = Instance.new("Sound")
sound.SoundId = soundId
sound.Looped = false -- 仅播放一次
sound.Volume = 0.5
sound.Parent = Workspace

-- 播放音效
sound:Play()

-- 音效结束后立即销毁，释放资源（优化内存占用）
sound.Ended:Connect(function()
    sound:Destroy()
    warn("音效已播放完毕并销毁") -- 可选：控制台提示，便于调试
end)

-- 可选：防止音效加载失败时占用资源
task.delay(10, function() -- 10秒后若未播放，自动销毁
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

local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local camera = workspace.CurrentCamera
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local Speed = 1
local sudu = nil
local tpwalkingspeed = false
local spinVelocity = nil
local autoInteract = false
local autoInteractThread = nil
local InfJ = false
local InfJConnection = nil
local fastInteractConnection = nil

-- ATM自动打击相关变量
local ATM_RUN = false
local ATM_NO_ATM_TIME = 0
local ATM_SERVER_HOP_TIME = 25
local ATM_ATTACK_ATM = true
local ATM_ATTACK_REGISTER = true
local ATM_GizmosFolder = nil
local ATM_SCRIPT_URL = "https://raw.githubusercontent.com/YunLua/Lua/refs/heads/main/ATM.lua"
local ATM_AUTO_FOLDER = "大司马脚本"
local ATM_AUTO_RELOAD_FILE = ATM_AUTO_FOLDER .. "/auto_reload.txt"
local ATM_STATE_FILE = ATM_AUTO_FOLDER .. "/atm_state.txt"

-- ATM随机传送位置
local ATM_RANDOM_POS = {
    Vector3.new(-1137, 78, -1953),
    Vector3.new(-44, 63, -2083),
    Vector3.new(194, 60, -2884),
    Vector3.new(-412, 106, -1301),
    Vector3.new(-377, 410, -741),
    Vector3.new(-985, 380, -1145),
    Vector3.new(-854, 406, -1505)
}

-- 初始化ATM文件夹
if isfolder then
    if not isfolder(ATM_AUTO_FOLDER) then
        makefolder(ATM_AUTO_FOLDER)
    end
end

-- 加载保存的ATM状态
if isfile and isfile(ATM_STATE_FILE) then
    ATM_RUN = readfile(ATM_STATE_FILE) == "1"
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
    Practical = XiaoDi:Section({ Title = "全局通用", Opened = false, Icon = "user"}),
    Byq = XiaoDi:Section({ Title = "被遗弃", Opened = false, Icon = "user"}),
    ATM = XiaoDi:Section({ Title = "正在寻求（通缉）", Opened = false, Icon = "user"}), -- 新增ATM功能区
}

local Feng = {
    Aut = FengYu.us:Tab({ Title = "公告", Icon = "info"}),
    player = FengYu.us:Tab({ Title = "玩家信息", Icon = "info"}),
    me = FengYu.us:Tab({ Title = "作者信息", Icon = "info"}),
    DiOne = FengYu.Practical:Tab({ Title = "本地玩家", Icon = "folder"}),
    ATM = FengYu.ATM:Tab({ Title = "ATM自动打击", Icon = "folder"}), -- 新增ATM选项卡
    Brq = FengYu.Byq:Tab({ Title = "被遗弃", Icon = "folder"}),
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

--玩家信息
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

--本地玩家
Feng.DiOne:Toggle({
    Title = "速度",
    Desc = "开/关",
    Value = false,
    Callback = function(v)
        if v == true then
            if sudu then
                sudu:Disconnect()
                sudu = nil
            end
            local player = game:GetService("Players").LocalPlayer
            sudu = game:GetService("RunService").Heartbeat:Connect(function()
                local character = player.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Parent then
                        local moveDirection = humanoid.MoveDirection
                        if moveDirection.Magnitude > 0 then
                            character:TranslateBy(moveDirection * Speed * 0.1)
                        end
                    end
                end
            end)
        else
            if sudu then
                sudu:Disconnect()
                sudu = nil
            end
        end
    end
})

Feng.DiOne:Slider({
    Title = "速度设置",
    Desc = "滑动可以加速",
    Step = 1,
    Value = {
        Min = 1,
        Max = 1000,
        Default = 1,
    },
    Callback = function(v)
        Speed = v
    end
})

Feng.DiOne:Input({
    Title = "旋转速度",
    PlaceholderText = "输入速度",
    Callback = function(Value)
        local speed = tonumber(Value)
        if speed then
            local plr = game:GetService("Players").LocalPlayer
            local character = plr.Character
            if not character then
                character = plr.CharacterAdded:Wait()
            end
            local humRoot = character:WaitForChild("HumanoidRootPart")
            local humanoid = character:WaitForChild("Humanoid")
            local rootAttachment = humRoot:FindFirstChild("RootAttachment")
            if not rootAttachment then
                rootAttachment = Instance.new("Attachment")
                rootAttachment.Name = "RootAttachment"
                rootAttachment.Parent = humRoot
            end
            humanoid.AutoRotate = false
            if spinVelocity then
                spinVelocity:Destroy()
            end
            spinVelocity = Instance.new("AngularVelocity")
            spinVelocity.Attachment0 = rootAttachment
            spinVelocity.MaxTorque = math.huge
            spinVelocity.AngularVelocity = Vector3.new(0, speed, 0)
            spinVelocity.Parent = humRoot
            spinVelocity.Name = "Spinbot"
        end
    end
})

Feng.DiOne:Button({
	Title = "停止旋转",
	Icon = "Primary",
	Callback = function()
        local plr = game:GetService("Players").LocalPlayer
        local character = plr.Character
        if character then
            local humRoot = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humRoot then
                local spinbot = humRoot:FindFirstChild("Spinbot")
                if spinbot then
                    spinbot:Destroy()
                    spinVelocity = nil
                end
            end
            if humanoid then
                humanoid.AutoRotate = true
            end
        end
    end
})

Feng.DiOne:Input({
    Title = "漂移",
    PlaceholderText = "输入加速",
    Callback = function(Value)
        local speedValue = tonumber(Value)
        if speedValue then
            tpwalkingspeed = true
            local player = game:GetService("Players").LocalPlayer
            RunService:UnbindFromRenderStep("TPWalk")
            RunService:BindToRenderStep("TPWalk", Enum.RenderPriority.Character.Value, function(delta)
                if tpwalkingspeed then
                    local character = player.Character
                    if character then
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        if humanoid and humanoid.Parent then
                            local moveDirection = humanoid.MoveDirection
                            if moveDirection.Magnitude > 0 then
                                character:TranslateBy(moveDirection * speedValue * delta * 10)
                            end
                        end
                    end
                end
            end)
        end
    end
})

Feng.DiOne:Button({
	Title = "点击关闭漂移加速",
	Icon = "Primary",
	Callback = function()
        tpwalkingspeed = false
        RunService:UnbindFromRenderStep("TPWalk")
    end
})

Feng.DiOne:Slider({
    Title = "修改跳跃",
    Desc = "滑动可以跳的更高",
    Step = 50,
    Value = {
        Min = 50,
        Max = 9999,
        Default = 1,
    },
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

Feng.DiOne:Slider({
    Title = "修改生命值",
    Desc = "说实话这个屁都没用",
    Step = 120,
    Value = {
        Min = 120,
        Max = 9999,
        Default = 1,
    },
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.Health = Value
    end
})

Feng.DiOne:Slider({
    Title = "相机焦距上限",
    Desc = "葫芦娃这一块",
    Step = 70,
    Value = {
        Min = 70,
        Max = 9999,
        Default = 1,
    },
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = Value
    end
})

-- ATM自动打击功能
-- 保存ATM状态函数
local function saveATMState()
    if writefile then
        writefile(ATM_STATE_FILE, ATM_RUN and "1" or "0")
    end
end

-- 获取物体的BasePart
local function getATMPart(obj)
    if obj:IsA("BasePart") then 
        return obj 
    end
    for _, v in ipairs(obj:GetDescendants()) do
        if v:IsA("BasePart") then
            return v
        end
    end
    return nil
end

-- 判断是否是ATM目标
local function isATMTarget(obj)
    local t = obj:GetAttribute("gizmoType")
    if t == "ATM" and ATM_ATTACK_ATM then
        return true
    elseif t == "Register" and ATM_ATTACK_REGISTER then
        return true
    end
    return false
end

-- 获取最近的ATM/收银机
local function getNearestATM()
    if not ATM_GizmosFolder then
        -- 尝试查找Gizmos文件夹
        ATM_GizmosFolder = workspace:FindFirstChild("Local") and workspace.Local:FindFirstChild("Gizmos") and workspace.Local.Gizmos:FindFirstChild("White")
        if not ATM_GizmosFolder then
            warn("警告: 未找到Gizmos文件夹，正在使用workspace")
            ATM_GizmosFolder = workspace
        end
    end
    
    local nearest, dist = nil, math.huge
    if not ATM_GizmosFolder then return nil end
    
    for _, gizmo in ipairs(ATM_GizmosFolder:GetChildren()) do
        if isATMTarget(gizmo) then
            local part = getATMPart(gizmo)
            if part then
                local d = (HumanoidRootPart.Position - part.Position).Magnitude
                if d < dist then
                    nearest, dist = part, d
                end
            end
        end
    end
    return nearest
end

-- 传送到目标
local function teleportToATM(target)
    if typeof(target) == "Vector3" then
        HumanoidRootPart.CFrame = CFrame.new(target) + Vector3.new(0, 3, 0) -- 增加高度防止卡住
    elseif typeof(target) == "Instance" then
        HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0, 5, 0)
    end
end

-- 模拟按键E
local function pressATMKey(time)
    local VIM = game:GetService("VirtualInputManager")
    local start = tick()
    while tick() - start < time do
        if VIM then
            VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.05)
            VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        end
        task.wait(0.1)
    end
end

-- 收集ATM
local function collectATM(atm)
    local start = tick()
    while tick() - start < 3 and atm.Parent and not atm:GetAttribute("Collected") do
        task.wait(0.1)
    end
    pressATMKey(1.5)
end

-- 换服函数
local function ATMserverHop()
    if writefile then
        writefile(ATM_AUTO_RELOAD_FILE, "1")
    end
    saveATMState()

    local placeId = game.PlaceId
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    
    local ok, data = pcall(function()
        local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(placeId)
        return HttpService:JSONDecode(game:HttpGet(url)).data
    end)

    if not ok then 
        warn("获取服务器列表失败")
        return 
    end

    local servers = {}
    for _, s in pairs(data) do
        if s.playing < s.maxPlayers and s.id ~= game.JobId then
            table.insert(servers, s.id)
        end
    end

    if #servers > 0 then
        if queue_on_teleport then
            queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/YunLua/Lua/refs/heads/main/ATM.lua'))()")
        end
        task.wait(1)
        TeleportService:TeleportToPlaceInstance(placeId, servers[math.random(#servers)], LocalPlayer)
    else
        warn("未找到可用的服务器")
    end
end

-- 主ATM自动打击逻辑
local function startATMAuto()
    if not ATM_RUN then return end
    
    task.spawn(function()
        ATM_NO_ATM_TIME = 0
        while ATM_RUN and task.wait(0.7) do
            -- 确保角色存在
            if not LocalPlayer.Character or not HumanoidRootPart or not HumanoidRootPart.Parent then
                Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
            end
            
            local atm = getNearestATM()
            if atm then
                teleportToATM(atm)
                task.wait(0.3)
                pressATMKey(1.5)
                collectATM(atm)
                ATM_NO_ATM_TIME = 0
            else
                ATM_NO_ATM_TIME = ATM_NO_ATM_TIME + 0.7
                local randomPos = ATM_RANDOM_POS[math.random(#ATM_RANDOM_POS)]
                teleportToATM(randomPos)
                
                if ATM_NO_ATM_TIME >= ATM_SERVER_HOP_TIME then    
                    warn("25秒未找到目标，正在换服")    
                    task.wait(1)    
                    ATM_RUN = false
                    saveATMState()
                    if queue_on_teleport then
                        queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/YunLua/Lua/refs/heads/main/ATM.lua'))()")
                    end
                    ATMserverHop()    
                    break    
                end    
            end    
        end
    end)
end

-- ATM功能界面
Feng.ATM:Toggle({
    Title = "打击目标收银机",
    Desc = "开启/关闭打击收银机",
    Value = ATM_ATTACK_REGISTER,
    Callback = function(state)
        ATM_ATTACK_REGISTER = state
    end
})

Feng.ATM:Toggle({
    Title = "打击目标ATM",
    Desc = "开启/关闭打击ATM",
    Value = ATM_ATTACK_ATM,
    Callback = function(state)
        ATM_ATTACK_ATM = state
    end
})

-- 总开关
Feng.ATM:Toggle({
    Title = "正在寻求（通缉）",
    Desc = "总开关：只有开启此开关才会执行ATM自动打击功能",
    Value = ATM_RUN,
    Callback = function(state)
        ATM_RUN = state
        saveATMState()
        if state then
            WindUI:Notify({
                Title = "ATM自动打击",
                Content = "功能已启动",
                Duration = 2
            })
            startATMAuto()
        else
            WindUI:Notify({
                Title = "ATM自动打击",
                Content = "功能已停止",
                Duration = 2
            })
        end
    end
})

-- 安全保存状态
game:GetService("Players").PlayerRemoving:Connect(function(leavingPlayer)
    if leavingPlayer == LocalPlayer then
        saveATMState()
    end
end)

-- 如果之前已开启，自动启动
if ATM_RUN then
    task.wait(2)
    startATMAuto()
    WindUI:Notify({
        Title = "ATM自动打击",
        Content = "已从上次保存的状态自动启动",
        Duration = 3
    })
end
