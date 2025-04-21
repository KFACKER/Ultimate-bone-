-- Script Loadstring cho Dead Rails: Infinite Bone
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Tạo RemoteEvent nếu chưa có
if not ReplicatedStorage:FindFirstChild("InfiniteBoneEvent") then
    local infiniteBoneEvent = Instance.new("RemoteEvent")
    infiniteBoneEvent.Name = "InfiniteBoneEvent"
    infiniteBoneEvent.Parent = ReplicatedStorage

    -- Server-side logic (chạy trên server thông qua RemoteEvent)
    infiniteBoneEvent.OnServerEvent:Connect(function(plr)
        local leaderstats = plr:FindFirstChild("leaderstats")
        if leaderstats then
            local bone = leaderstats:FindFirstChild("Bone")
            if bone then
                while true do
                    bone.Value = 999999999 -- Đặt Bone thành giá trị vô hạn
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

local InfiniteBoneButton = Instance.new("TextButton")
InfiniteBoneButton.Name = "InfiniteBoneButton"
InfiniteBoneButton.Size = UDim2.new(0.8, 0, 0.15, 0)
InfiniteBoneButton.Position = UDim2.new(0.1, 0, 0.2, 0)
InfiniteBoneButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InfiniteBoneButton.Text = "Infinite Bone"
InfiniteBoneButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InfiniteBoneButton.TextScaled = true
InfiniteBoneButton.Parent = Frame

-- Xử lý nút Infinite Bone
InfiniteBoneButton.MouseButton1Click:Connect(function()
    local infiniteBoneEvent = ReplicatedStorage:WaitForChild("InfiniteBoneEvent")
    infiniteBoneEvent:FireServer()
end)

-- Hiển thị số Bone (tuỳ chọn)
local BoneLabel = Instance.new("TextLabel")
BoneLabel.Name = "BoneLabel"
BoneLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
BoneLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
BoneLabel.BackgroundTransparency = 1
BoneLabel.Text = "Bone: 0"
BoneLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BoneLabel.TextScaled = true
BoneLabel.Parent = Frame

while true do
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local bone = leaderstats:FindFirstChild("Bone")
        if bone then
            BoneLabel.Text = "Bone: " .. bone.Value
        end
    end
    wait(0.1)
end
