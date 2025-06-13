
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SimpleToggle"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui


local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(0, 120, 0, 30)
textButton.Position = UDim2.new(0.5, -60, 0, 20)
textButton.BackgroundTransparency = 1
textButton.Text = ".gg/bobox"
textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton.TextSize = 18
textButton.Font = Enum.Font.GothamBold
textButton.Parent = screenGui


local isMobile = UserInputService.TouchEnabled


local function pressLeftCtrl()
    textButton.TextColor3 = Color3.fromRGB(0, 255, 0)
    keypress(0x11) 
    wait(0.1)
    textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end

-- Click/Touch events
textButton.MouseButton1Click:Connect(pressLeftCtrl)

-- Mobile touch support
if isMobile then
    textButton.TouchTap:Connect(pressLeftCtrl)
end

-- Draggable (Support มือถือ)
local dragging = false
local dragStart = nil
local startPos = nil

local function startDrag(input)
    dragging = true
    dragStart = input.Position
    startPos = textButton.Position
end

local function updateDrag(input)
    if dragging then
        local delta = input.Position - dragStart
        textButton.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end

local function endDrag()
    dragging = false
end

-- Mouse events
textButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        startDrag(input)
    end
end)


if isMobile then
    textButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            startDrag(input)
        end
    end)
end

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        updateDrag(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        endDrag()
    end
end)
