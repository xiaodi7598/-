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
    task.wait()
    LocalPlayer = Players.LocalPlayer
end

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

local FengYu = {
    us = XiaoDi:Section({ Title = "脚本信息", Opened = false, Icon = "user"}),
    Practical = XiaoDi:Section({ Title = "盲射", Opened = false, Icon = "user"}),
    Main = XiaoDi:Section({ Title = "主功能", Opened = true, Icon = "settings"}),
    Misc = XiaoDi:Section({ Title = "杂项", Opened = true, Icon = "wrench"}),
}

local Feng = {
    Aut = FengYu.us:Tab({ Title = "公告", Icon = "info"}),
    player = FengYu.us:Tab({ Title = "玩家信息", Icon = "info"}),
    me = FengYu.us:Tab({ Title = "作者信息", Icon = "info"}),
    DiOne = FengYu.Practical:Tab({ Title = "盲射", Icon = "folder"}),
    MainTab = FengYu.Main:Tab({ Title = "主功能", Icon = "settings"}),
    MiscTab = FengYu.Misc:Tab({ Title = "杂项", Icon = "wrench"}),
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
    Desc = "你的注入器: " .. (identifyexecutor and identifyexecutor() or "未知"),
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
                if setclipboard then
                    setclipboard("3954952871")
                    WindUI:Notify({Title = "成功", Content = "QQ号已复制", Duration = 2})
                end
            end,
            Icon = "folder",
        },
        {
            Title = "复制QQ群",
            Variant = "Primary",
            Callback = function()
                if setclipboard then
                    setclipboard("908685870")
                    WindUI:Notify({Title = "成功", Content = "QQ群已复制", Duration = 2})
                end
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
                if setclipboard then
                    setclipboard("1926190957")
                    WindUI:Notify({Title = "成功", Content = "QQ号已复制", Duration = 2})
                end
            end,
            Icon = "info",
        },
        {
            Title = "复制QQ群",
            Variant = "Primary",
            Callback = function()
                if setclipboard then
                    setclipboard("群")
                    WindUI:Notify({Title = "成功", Content = "QQ群已复制", Duration = 2})
                end
            end,
            Icon = "info",
        },
    }
})

-- 显示玩家 (反隐身) - 增强版本
local seePlayersConnection
local seePlayersParts = {}
local seePlayersBillboardGuis = {}
local seePlayersHighlights = {}

-- 配置参数
local ESPConfig = {
    BoxSize = 3,  -- 方块大小
    BoxHeight = 5, -- 方块高度
    TextSize = 14, -- 文字大小
    MaxDistance = 200, -- 最大显示距离
    ShowDistance = true, -- 显示距离
    ShowTeam = true, -- 显示队伍
    BoxTransparency = 0.4, -- 方块透明度
    HighlightTransparency = 0.7, -- 高光透明度
    InvisBoxColor = Color3.new(1, 0.2, 0.2), -- 隐身玩家颜色（红色）
    VisibleBoxColor = Color3.new(0.2, 1, 0.2), -- 可见玩家颜色（绿色）
    SameTeamColor = Color3.new(0.2, 0.5, 1), -- 同队玩家颜色（蓝色）
}

-- 配置界面
local ESPConfigTab = FengYu.Main:Tab({ Title = "ESP配置", Icon = "settings" })

-- 方块大小设置
ESPConfigTab:Slider({
    Title = "方块大小",
    Description = "调整ESP方块的大小",
    Default = ESPConfig.BoxSize,
    Min = 1,
    Max = 10,
    Step = 0.5,
    Callback = function(value)
        ESPConfig.BoxSize = value
        updateAllESPBoxes()
        WindUI:Notify({
            Title = "ESP配置",
            Content = "方块大小已设置为: " .. value,
            Duration = 2
        })
    end
})

-- 方块高度设置
ESPConfigTab:Slider({
    Title = "方块高度",
    Description = "调整ESP方块的高度",
    Default = ESPConfig.BoxHeight,
    Min = 3,
    Max = 10,
    Step = 0.5,
    Callback = function(value)
        ESPConfig.BoxHeight = value
        updateAllESPBoxes()
        WindUI:Notify({
            Title = "ESP配置",
            Content = "方块高度已设置为: " .. value,
            Duration = 2
        })
    end
})

-- 文字大小设置
ESPConfigTab:Slider({
    Title = "文字大小",
    Description = "调整ESP文字的大小",
    Default = ESPConfig.TextSize,
    Min = 10,
    Max = 30,
    Step = 1,
    Callback = function(value)
        ESPConfig.TextSize = value
        updateAllESPTexts()
        WindUI:Notify({
            Title = "ESP配置",
            Content = "文字大小已设置为: " .. value,
            Duration = 2
        })
    end
})

-- 最大距离设置
ESPConfigTab:Slider({
    Title = "最大距离",
    Description = "调整ESP最大显示距离",
    Default = ESPConfig.MaxDistance,
    Min = 50,
    Max = 1000,
    Step = 10,
    Callback = function(value)
        ESPConfig.MaxDistance = value
        WindUI:Notify({
            Title = "ESP配置",
            Content = "最大距离已设置为: " .. value,
            Duration = 2
        })
    end
})

-- 显示距离开关
ESPConfigTab:Toggle({
    Title = "显示距离",
    State = ESPConfig.ShowDistance,
    Callback = function(state)
        ESPConfig.ShowDistance = state
        updateAllESPTexts()
        WindUI:Notify({
            Title = "ESP配置",
            Content = "显示距离: " .. (state and "开" or "关"),
            Duration = 2
        })
    end
})

-- 显示队伍开关
ESPConfigTab:Toggle({
    Title = "显示队伍",
    State = ESPConfig.ShowTeam,
    Callback = function(state)
        ESPConfig.ShowTeam = state
        updateAllESPTexts()
        WindUI:Notify({
            Title = "ESP配置",
            Content = "显示队伍: " .. (state and "开" or "关"),
            Duration = 2
        })
    end
})

-- 方块透明度设置
ESPConfigTab:Slider({
    Title = "方块透明度",
    Description = "调整ESP方块的透明度",
    Default = ESPConfig.BoxTransparency * 100,
    Min = 10,
    Max = 90,
    Step = 5,
    Suffix = "%",
    Callback = function(value)
        ESPConfig.BoxTransparency = value / 100
        updateAllESPBoxes()
        WindUI:Notify({
            Title = "ESP配置",
            Content = "方块透明度已设置为: " .. value .. "%",
            Duration = 2
        })
    end
})

-- 高光透明度设置
ESPConfigTab:Slider({
    Title = "高光透明度",
    Description = "调整ESP高光的透明度",
    Default = ESPConfig.HighlightTransparency * 100,
    Min = 10,
    Max = 90,
    Step = 5,
    Suffix = "%",
    Callback = function(value)
        ESPConfig.HighlightTransparency = value / 100
        updateAllESPHighlights()
        WindUI:Notify({
            Title = "ESP配置",
            Content = "高光透明度已设置为: " .. value .. "%",
            Duration = 2
        })
    end
})

-- 更新所有ESP方块的函数
function updateAllESPBoxes()
    for userId, part in pairs(seePlayersParts) do
        if part and part.Parent then
            part.Size = Vector3.new(ESPConfig.BoxSize, ESPConfig.BoxHeight, ESPConfig.BoxSize)
            part.Transparency = ESPConfig.BoxTransparency
        end
    end
end

-- 更新所有ESP文本的函数
function updateAllESPTexts()
    for userId, gui in pairs(seePlayersBillboardGuis) do
        if gui and gui.Parent then
            local player = Players:GetPlayerByUserId(userId)
            if player then
                updateESPText(player, gui)
            end
        end
    end
end

-- 更新所有ESP高光的函数
function updateAllESPHighlights()
    for userId, highlight in pairs(seePlayersHighlights) do
        if highlight and highlight.Parent then
            highlight.FillTransparency = ESPConfig.HighlightTransparency
            highlight.OutlineTransparency = ESPConfig.HighlightTransparency
        end
    end
end

-- 检查是否为同一队伍
function isSameTeam(player1, player2)
    -- 方法1：检查Team属性
    if player1.Team and player2.Team then
        return player1.Team == player2.Team
    end
    
    -- 方法2：检查TeamColor属性
    if player1.TeamColor and player2.TeamColor then
        return player1.TeamColor == player2.TeamColor
    end
    
    -- 方法3：检查BrickColor（旧方法）
    local char1 = player1.Character
    local char2 = player2.Character
    
    if char1 and char2 then
        local torso1 = char1:FindFirstChild("Torso") or char1:FindFirstChild("UpperTorso")
        local torso2 = char2:FindFirstChild("Torso") or char2:FindFirstChild("UpperTorso")
        
        if torso1 and torso2 then
            return torso1.BrickColor == torso2.BrickColor
        end
    end
    
    return false
end

-- 检查玩家是否隐身
function isPlayerInvisible(player)
    local character = player.Character
    if not character then
        return true -- 没有角色通常意味着隐身
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        return true -- 没有HumanoidRootPart通常意味着隐身
    end
    
    -- 检查透明度
    if humanoidRootPart.Transparency >= 0.9 then
        return true
    end
    
    -- 检查CanCollide属性
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and not part.CanCollide then
            return true
        end
    end
    
    -- 检查特殊隐身效果
    local hasInvisEffect = character:FindFirstChild("InvisibilityEffect") or 
                           character:FindFirstChild("Stealth") or
                           character:FindFirstChild("Cloak") or
                           character:FindFirstChild("Ghost")
    
    if hasInvisEffect then
        return true
    end
    
    -- 检查是否在视野内但不可见
    local distance = (humanoidRootPart.Position - camera.CFrame.Position).Magnitude
    if distance < 100 then
        local ray = Ray.new(
            camera.CFrame.Position,
            (humanoidRootPart.Position - camera.CFrame.Position).Unit * 100
        )
        local hitPart = workspace:FindPartOnRayWithIgnoreList(ray, {camera, LocalPlayer.Character})
        
        if not hitPart or hitPart:IsDescendantOf(character) then
            -- 检查可见部位数量
            local visibleParts = 0
            local partsToCheck = {"Head", "Torso", "UpperTorso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}
            
            for _, partName in ipairs(partsToCheck) do
                local part = character:FindFirstChild(partName)
                if part and part:IsA("BasePart") and part.Transparency < 0.9 then
                    visibleParts = visibleParts + 1
                end
            end
            
            return visibleParts < 3
        end
    end
    
    return false
end

-- 获取玩家队伍信息
function getTeamInfo(player)
    if player.Team then
        return player.Team.Name
    elseif player.TeamColor then
        return "队伍" .. tostring(player.TeamColor)
    else
        return "无队伍"
    end
end

-- 更新ESP文本信息
function updateESPText(player, billboardGui)
    if not billboardGui then return end
    
    local nameLabel = billboardGui:FindFirstChild("PlayerName")
    local infoLabel = billboardGui:FindFirstChild("PlayerInfo")
    
    if not nameLabel then return end
    
    -- 设置名称文本
    nameLabel.Text = player.Name
    nameLabel.TextSize = ESPConfig.TextSize
    
    -- 创建或更新信息标签
    if not infoLabel then
        infoLabel = Instance.new("TextLabel")
        infoLabel.Name = "PlayerInfo"
        infoLabel.Size = UDim2.new(1, 0, 0.5, 0)
        infoLabel.Position = UDim2.new(0, 0, 0.5, 0)
        infoLabel.BackgroundTransparency = 1
        infoLabel.TextColor3 = Color3.new(1, 1, 1)
        infoLabel.TextScaled = true
        infoLabel.Font = Enum.Font.Gotham
        infoLabel.TextStrokeTransparency = 0.5
        infoLabel.Parent = billboardGui
    end
    
    infoLabel.TextSize = ESPConfig.TextSize - 2
    
    -- 构建信息文本
    local infoText = ""
    
    -- 检查是否为隐身状态
    local isInvisible = isPlayerInvisible(player)
    if isInvisible then
        nameLabel.Text = player.Name .. " (隐身)"
        nameLabel.TextColor3 = ESPConfig.InvisBoxColor
    else
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = ESPConfig.VisibleBoxColor
    end
    
    -- 检查是否为同队
    local sameTeam = isSameTeam(player, LocalPlayer)
    if sameTeam and ESPConfig.ShowTeam then
        nameLabel.Text = player.Name .. " (队友)"
        nameLabel.TextColor3 = ESPConfig.SameTeamColor
    end
    
    -- 添加距离信息
    if ESPConfig.ShowDistance then
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local distance = (humanoidRootPart.Position - camera.CFrame.Position).Magnitude
                infoText = infoText .. string.format("距离: %.1f\n", distance)
            end
        end
    end
    
    -- 添加队伍信息
    if ESPConfig.ShowTeam then
        local teamInfo = getTeamInfo(player)
        infoText = infoText .. teamInfo .. "\n"
    end
    
    -- 添加状态信息
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            if humanoid.Health <= 0 then
                infoText = infoText .. "状态: 死亡"
            else
                infoText = infoText .. string.format("血量: %.0f", humanoid.Health)
            end
        end
    end
    
    infoLabel.Text = infoText
end

-- 创建ESP标记
function createESPMarker(player)
    local userId = player.UserId
    
    -- 检查是否已存在标记
    if seePlayersParts[userId] then
        return seePlayersParts[userId]
    end
    
    -- 获取玩家位置
    local playerPosition = Vector3.new(0, 0, 0)
    local character = player.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            playerPosition = humanoidRootPart.Position
        end
    end
    
    -- 确定标记颜色
    local boxColor
    if isSameTeam(player, LocalPlayer) then
        boxColor = BrickColor.new(ESPConfig.SameTeamColor)
    elseif isPlayerInvisible(player) then
        boxColor = BrickColor.new(ESPConfig.InvisBoxColor)
    else
        boxColor = BrickColor.new(ESPConfig.VisibleBoxColor)
    end
    
    -- 创建标记方块
    local markerPart = Instance.new("Part")
    markerPart.Name = "ESPMarker_" .. userId
    markerPart.Size = Vector3.new(ESPConfig.BoxSize, ESPConfig.BoxHeight, ESPConfig.BoxSize)
    markerPart.BrickColor = boxColor
    markerPart.Material = Enum.Material.Neon
    markerPart.Transparency = ESPConfig.BoxTransparency
    markerPart.Anchored = true
    markerPart.CanCollide = false
    markerPart.CFrame = CFrame.new(playerPosition + Vector3.new(0, ESPConfig.BoxHeight/2 + 1, 0))
    markerPart.Parent = workspace
    
    -- 创建BillboardGui
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESPInfo_" .. userId
    billboardGui.Size = UDim2.new(0, 250, 0, 120)
    billboardGui.StudsOffset = Vector3.new(0, ESPConfig.BoxHeight + 2, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.MaxDistance = ESPConfig.MaxDistance
    billboardGui.Parent = markerPart
    
    -- 玩家名称标签
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "PlayerName"
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.Parent = billboardGui
    
    -- 创建高亮效果
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESPHighlight_" .. userId
    highlight.FillColor = boxColor.Color
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.FillTransparency = ESPConfig.HighlightTransparency
    highlight.OutlineTransparency = ESPConfig.HighlightTransparency
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = markerPart
    
    -- 存储引用
    seePlayersParts[userId] = markerPart
    seePlayersBillboardGuis[userId] = billboardGui
    seePlayersHighlights[userId] = highlight
    
    -- 更新文本信息
    updateESPText(player, billboardGui)
    
    return markerPart
end

-- 更新ESP标记位置和外观
function updateESPMarker(player)
    local userId = player.UserId
    local markerPart = seePlayersParts[userId]
    
    if not markerPart then
        createESPMarker(player)
        return
    end
    
    -- 更新位置
    local character = player.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            markerPart.CFrame = CFrame.new(humanoidRootPart.Position + Vector3.new(0, ESPConfig.BoxHeight/2 + 1, 0))
        end
    end
    
    -- 更新颜色
    local boxColor
    if isSameTeam(player, LocalPlayer) then
        boxColor = BrickColor.new(ESPConfig.SameTeamColor)
    elseif isPlayerInvisible(player) then
        boxColor = BrickColor.new(ESPConfig.InvisBoxColor)
    else
        boxColor = BrickColor.new(ESPConfig.VisibleBoxColor)
    end
    
    markerPart.BrickColor = boxColor
    if seePlayersHighlights[userId] then
        seePlayersHighlights[userId].FillColor = boxColor.Color
    end
    
    -- 更新文本
    local billboardGui = seePlayersBillboardGuis[userId]
    if billboardGui then
        updateESPText(player, billboardGui)
    end
    
    -- 更新显示状态
    local distance = (markerPart.Position - camera.CFrame.Position).Magnitude
    if distance > ESPConfig.MaxDistance then
        markerPart.Transparency = 1
        if billboardGui then
            billboardGui.Enabled = false
        end
        if seePlayersHighlights[userId] then
            seePlayersHighlights[userId].Enabled = false
        end
    else
        markerPart.Transparency = ESPConfig.BoxTransparency
        if billboardGui then
            billboardGui.Enabled = true
        end
        if seePlayersHighlights[userId] then
            seePlayersHighlights[userId].Enabled = true
        end
    end
end

-- 移除ESP标记
function removeESPMarker(player)
    local userId = player.UserId
    
    if seePlayersParts[userId] then
        seePlayersParts[userId]:Destroy()
        seePlayersParts[userId] = nil
    end
    
    seePlayersBillboardGuis[userId] = nil
    seePlayersHighlights[userId] = nil
end

-- 清理所有标记
function cleanupAllESPMarkers()
    for userId, part in pairs(seePlayersParts) do
        if part and part.Parent then
            part:Destroy()
        end
    end
    
    seePlayersParts = {}
    seePlayersBillboardGuis = {}
    seePlayersHighlights = {}
end

-- 改进的反隐身/ESP功能
Feng.MainTab:Toggle({
    Title = "显示玩家 (ESP)",
    State = false,
    Callback = function(state)
        _G.ShowESP = state
        
        if state then
            -- 启用ESP
            WindUI:Notify({
                Title = "提示",
                Content = "玩家ESP功能已启用",
                Duration = 2
            })
            
            -- 停止之前的连接
            if seePlayersConnection then
                seePlayersConnection:Disconnect()
                seePlayersConnection = nil
            end
            
            -- 为所有现有玩家创建标记
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    createESPMarker(player)
                end
            end
            
            -- 创建更新连接
            seePlayersConnection = RunService.RenderStepped:Connect(function()
                if not _G.ShowESP then
                    return
                end
                
                -- 更新所有玩家标记
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        updateESPMarker(player)
                    end
                end
            end)
        else
            -- 禁用ESP
            if seePlayersConnection then
                seePlayersConnection:Disconnect()
                seePlayersConnection = nil
            end
            
            cleanupAllESPMarkers()
            
            WindUI:Notify({
                Title = "提示",
                Content = "玩家ESP功能已禁用",
                Duration = 2
            })
        end
    end
})

-- 当玩家加入时创建标记
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        task.wait(0.5)
        if _G.ShowESP then
            createESPMarker(player)
        end
    end)
    
    if _G.ShowESP then
        task.wait(1)
        createESPMarker(player)
    end
end)

-- 当玩家离开时移除标记
Players.PlayerRemoving:Connect(function(player)
    removeESPMarker(player)
end)

-- 抗击退
local undergroundConnection
Feng.MainTab:Toggle({
    Title = "抗击退",
    State = false,
    Callback = function(state)
        _G.Underground = state
        
        if state then
            -- 停止之前的连接
            if undergroundConnection then
                undergroundConnection:Disconnect()
                undergroundConnection = nil
            end
            
            undergroundConnection = RunService.RenderStepped:Connect(function()
                if not _G.Underground then
                    undergroundConnection:Disconnect()
                    return
                end
                
                local Character = LocalPlayer.Character
                if Character then
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    if HumanoidRootPart then
                        local originalPosition = HumanoidRootPart.Position
                        local undergroundPosition = Vector3.new(originalPosition.X, originalPosition.Y - 5, originalPosition.Z)
                        
                        HumanoidRootPart.CFrame = CFrame.new(undergroundPosition)
                        task.wait()
                        HumanoidRootPart.CFrame = CFrame.new(originalPosition)
                    end
                end
            end)
            
            WindUI:Notify({
                Title = "提示",
                Content = "抗击退功能已启用",
                Duration = 2
            })
        elseif undergroundConnection then
            undergroundConnection:Disconnect()
            undergroundConnection = nil
        end
    end
})

-- 自动奖杯
local trophyFarmThread
Feng.MainTab:Toggle({
    Title = "自动奖杯",
    State = false,
    Callback = function(state)
        _G.TrophyFarm = state
        
        if state then
            trophyFarmThread = task.spawn(function()
                while _G.TrophyFarm do
                    local Character = LocalPlayer.Character
                    if Character then
                        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                        if HumanoidRootPart then
                            -- 查找奖杯
                            local trophy = workspace:FindFirstChild("Trophy", true)
                            if trophy then
                                -- 移动到奖杯位置
                                HumanoidRootPart.CFrame = trophy.CFrame
                                task.wait(0.1)
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
            WindUI:Notify({
                Title = "提示",
                Content = "自动奖杯功能已启用",
                Duration = 2
            })
        elseif trophyFarmThread then
            _G.TrophyFarm = false
        end
    end
})

-- 穿墙模式
local noclipConnection
Feng.MiscTab:Toggle({
    Title = "穿墙模式",
    State = false,
    Callback = function(state)
        _G.Noclip = state
        
        if state then
            -- 停止之前的连接
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
            
            noclipConnection = RunService.Stepped:Connect(function()
                if not _G.Noclip then
                    noclipConnection:Disconnect()
                    return
                end
                
                local Character = LocalPlayer.Character
                if Character then
                    for _, part in ipairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            
            WindUI:Notify({
                Title = "提示",
                Content = "穿墙模式已启用",
                Duration = 2
            })
        elseif noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
})

-- 飞行模式
local flyingConnection
local flyBodyGyro, flyBodyVelocity
Feng.MiscTab:Toggle({
    Title = "飞行模式",
    State = false,
    Callback = function(state)
        _G.Flying = state
        
        if state then
            local Character = LocalPlayer.Character
            if Character then
                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart then
                    -- 创建飞行控制器
                    flyBodyGyro = Instance.new("BodyGyro")
                    flyBodyGyro.P = 90000
                    flyBodyGyro.MaxTorque = Vector3.new(900000, 900000, 900000)
                    flyBodyGyro.CFrame = HumanoidRootPart.CFrame
                    flyBodyGyro.Parent = HumanoidRootPart
                    
                    flyBodyVelocity = Instance.new("BodyVelocity")
                    flyBodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
                    flyBodyVelocity.MaxForce = Vector3.new(900000, 900000, 900000)
                    flyBodyVelocity.Parent = HumanoidRootPart
                    
                    -- 控制变量
                    local flySpeed = 50
                    local flyDirection = Vector3.new(0, 0, 0)
                    
                    -- 键盘控制
                    local UserInputService = game:GetService("UserInputService")
                    local inputBegan = UserInputService.InputBegan:Connect(function(input)
                        if input.KeyCode == Enum.KeyCode.W then
                            flyDirection = flyDirection + Vector3.new(0, 0, -flySpeed)
                        elseif input.KeyCode == Enum.KeyCode.S then
                            flyDirection = flyDirection + Vector3.new(0, 0, flySpeed)
                        elseif input.KeyCode == Enum.KeyCode.A then
                            flyDirection = flyDirection + Vector3.new(-flySpeed, 0, 0)
                        elseif input.KeyCode == Enum.KeyCode.D then
                            flyDirection = flyDirection + Vector3.new(flySpeed, 0, 0)
                        elseif input.KeyCode == Enum.KeyCode.Space then
                            flyDirection = flyDirection + Vector3.new(0, flySpeed, 0)
                        elseif input.KeyCode == Enum.KeyCode.LeftShift then
                            flyDirection = flyDirection + Vector3.new(0, -flySpeed, 0)
                        end
                    end)
                    
                    local inputEnded = UserInputService.InputEnded:Connect(function(input)
                        if input.KeyCode == Enum.KeyCode.W then
                            flyDirection = flyDirection - Vector3.new(0, 0, -flySpeed)
                        elseif input.KeyCode == Enum.KeyCode.S then
                            flyDirection = flyDirection - Vector3.new(0, 0, flySpeed)
                        elseif input.KeyCode == Enum.KeyCode.A then
                            flyDirection = flyDirection - Vector3.new(-flySpeed, 0, 0)
                        elseif input.KeyCode == Enum.KeyCode.D then
                            flyDirection = flyDirection - Vector3.new(flySpeed, 0, 0)
                        elseif input.KeyCode == Enum.KeyCode.Space then
                            flyDirection = flyDirection - Vector3.new(0, flySpeed, 0)
                        elseif input.KeyCode == Enum.KeyCode.LeftShift then
                            flyDirection = flyDirection - Vector3.new(0, -flySpeed, 0)
                        end
                    end)
                    
                    -- 飞行更新循环
                    flyingConnection = RunService.RenderStepped:Connect(function()
                        if not _G.Flying or not HumanoidRootPart or not flyBodyVelocity then
                            flyingConnection:Disconnect()
                            inputBegan:Disconnect()
                            inputEnded:Disconnect()
                            return
                        end
                        
                        flyBodyVelocity.Velocity = flyDirection
                        flyBodyGyro.CFrame = camera.CFrame
                    end)
                    
                    WindUI:Notify({
                        Title = "提示",
                        Content = "飞行模式已启用 (WASD移动，空格上升，左Shift下降)",
                        Duration = 3
                    })
                end
            end
        else
            -- 清理飞行相关对象
            if flyingConnection then
                flyingConnection:Disconnect()
                flyingConnection = nil
            end
            
            if flyBodyGyro then
                flyBodyGyro:Destroy()
                flyBodyGyro = nil
            end
            
            if flyBodyVelocity then
                flyBodyVelocity:Destroy()
                flyBodyVelocity = nil
            end
        end
    end
})

-- 当角色重新生成时清理状态
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    
    -- 重置飞行状态
    if _G.Flying then
        _G.Flying = false
        if flyBodyGyro then flyBodyGyro:Destroy() end
        if flyBodyVelocity then flyBodyVelocity:Destroy() end
        if flyingConnection then flyingConnection:Disconnect() end
        
        task.wait(1)
        WindUI:Notify({
            Title = "提示",
            Content = "角色重生，飞行模式已重置",
            Duration = 2
        })
    end
    
    -- 清理ESP标记
    cleanupAllESPMarkers()
    
    -- 重新创建ESP标记
    if _G.ShowESP then
        task.wait(1)
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                createESPMarker(player)
            end
        end
    end
end)

WindUI:Notify({
    Title = "迪脚本通知",
    Content = "所有功能已加载完成",
    Duration = 2
})

-- 游戏关闭时清理
game:GetService("CoreGui").DescendantRemoving:Connect(function(descendant)
    if descendant == XiaoDi then
        -- 清理所有连接
        if undergroundConnection then undergroundConnection:Disconnect() end
        if noclipConnection then noclipConnection:Disconnect() end
        if flyingConnection then flyingConnection:Disconnect() end
        if seePlayersConnection then seePlayersConnection:Disconnect() end
        
        -- 清理物理对象
        if flyBodyGyro then flyBodyGyro:Destroy() end
        if flyBodyVelocity then flyBodyVelocity:Destroy() end
        
        -- 清理ESP标记
        cleanupAllESPMarkers()
        
        -- 重置全局变量
        _G.ShowESP = false
        _G.Underground = false
        _G.TrophyFarm = false
        _G.Noclip = false
        _G.Flying = false
    end
end)
