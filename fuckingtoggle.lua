local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(0, 120, 0, 30)
textButton.Position = UDim2.new(0.5, -60, 0, 20)
textButton.BackgroundTransparency = 1
textButton.Text = ".gg/bobox"
textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton.TextSize = 18
textButton.Font = Enum.Font.GothamBold
textButton.Parent = screenGui

textButton.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
end)

local dragging = false
local dragStart, startPos

textButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = textButton.Position
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        textButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
