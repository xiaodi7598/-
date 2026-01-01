local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    wait()
    LocalPlayer = Players.LocalPlayer
end

local Blacklist = {
    Users = {
        "hnperezho888",
        "hxbbd769",
        "linluwqw",
        "woshidasabi91666",
        "jumonb6678",
        
    }
}

local playerName = LocalPlayer.Name
local isBanned = false
for _, bannedName in pairs(Blacklist.Users) do
    if playerName:lower() == bannedName:lower() then
        isBanned = true
        break
    end
end

if isBanned then
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BlacklistNotification"
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "BanMessage"
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    textLabel.BackgroundTransparency = 0.3
    textLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    textLabel.Text = "用户: " .. playerName .. "\n\n你已被列入脚本黑名单\n\n将在5秒后断开连接...\n\n错误代码: 迪脚本"
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 24
    textLabel.TextWrapped = true
    textLabel.Parent = screenGui
    for i = 5, 1, -1 do
        textLabel.Text = "用户: " .. playerName .. "\n\n你已被列入脚本黑名单\n\n将在 " .. i .. " 秒后断开连接...\n\n错误代码:  你惹怒了陌染"
        wait(1)
    end
    
    LocalPlayer:Kick("用户: " .. playerName .. " ┃ 你已被列入脚本黑名单\n\n错误代码: 陌染生气了")
    return
end
