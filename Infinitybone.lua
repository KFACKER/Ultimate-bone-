-- Script Loadstring cho Dead Rails: Infinite Bonds
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Tạo RemoteEvent nếu chưa có
if not ReplicatedStorage:FindFirstChild("InfiniteBoneEvent") then
    local infiniteBondsEvent = Instance.new("RemoteEvent")
    infiniteBondsEvent.Name = "InfiniteBondsEvent"
    infiniteBondsEvent.Parent = ReplicatedStorage

    -- Server-side logic (chạy trên server thông qua RemoteEvent)
    infiniteBondsEvent.OnServerEvent:Connect(function(plr)
        local leaderstats = plr:FindFirstChild("leaderstats")
        if leaderstats then
            local bonds = leaderstats:FindFirstChild("Bonds")
            if bonds then
                while true do
                    bonds.Value = 999999999 -- Đặt Bonds thành giá trị vô hạn
                    wait(0.1)
                end
            end
        end
    end)
end

-- Client-side: Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeadRailMenu"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.3, 0, 0.4, 0)
Frame.Position = UDim2.new(0.35, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.8, 0, 0.1, 0)
Title.Position = UDim2.new(0.1, 0, 0.05, 0)
Title.BackgroundTransparency = 1
Title.Text = "Dead Rail Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Parent = Frame

local InfiniteBondsButton = Instance.new("TextButton")
InfiniteBondsButton.Name = "InfiniteBoneButton"
InfiniteBondsButton.Size = UDim2.new(0.8, 0, 0.15, 0)
InfiniteBondsButton.Position = UDim2.new(0.1, 0, 0.2, 0)
InfiniteBondsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InfiniteBondsButton.Text = "Infinite Bone"
InfiniteBondsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InfiniteBondsButton.TextScaled = true
InfiniteBondsButton.Parent = Frame

-- Xử lý nút Infinite Bone
InfiniteBondsButton.MouseButton1Click:Connect(function()
    local infiniteBondsEvent = ReplicatedStorage:WaitForChild("InfiniteBondsEvent")
    infiniteBondsEvent:FireServer()
end)

-- Hiển thị số Bone (tuỳ chọn)
local BondsLabel = Instance.new("TextLabel")
BondsLabel.Name = "BoneLabel"
BondsLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
BondsLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
BondsLabel.BackgroundTransparency = 1
BondsLabel.Text = "Bone: 0"
BondsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BondsLabel.TextScaled = true
BondsLabel.Parent = Frame

while true do
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local bonds = leaderstats:FindFirstChild("Bonds")
        if bonds then
            BondsLabel.Text = "Bonds: " .. bonds.Value
        end
    end
    wait(0.1)
end
