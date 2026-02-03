--[[
WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- Initial notification
StarterGui:SetCore("SendNotification", {
    Title = "⚠️ WARNING",
    Text = "Do not share your key. It may not work for others.",
    Duration = 6,
})

-- Local variable to track used keys
local usedKeys = {}

-- Create GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "KeySystemUI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 350, 0, 200)
frame.Position = UDim2.new(0.5, -175, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true -- makes the window draggable

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "JEFF Key System"
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local textBox = Instance.new("TextBox", frame)
textBox.Position = UDim2.new(0.1, 0, 0.35, 0)
textBox.Size = UDim2.new(0.8, 0, 0, 40)
textBox.PlaceholderText = "Enter your key here..."
textBox.Text = ""
textBox.TextScaled = true
textBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
textBox.TextColor3 = Color3.fromRGB(230, 230, 230)
textBox.ClearTextOnFocus = false
textBox.Font = Enum.Font.Gotham

local getKeyButton = Instance.new("TextButton", frame)
getKeyButton.Position = UDim2.new(0.1, 0, 0.65, 0)
getKeyButton.Size = UDim2.new(0.35, 0, 0, 40)
getKeyButton.Text = "Get Key"
getKeyButton.TextScaled = true
getKeyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.Font = Enum.Font.GothamSemibold
getKeyButton.AutoButtonColor = false

local verifyButton = Instance.new("TextButton", frame)
verifyButton.Position = UDim2.new(0.55, 0, 0.65, 0)
verifyButton.Size = UDim2.new(0.35, 0, 0, 40)
verifyButton.Text = "Verify"
verifyButton.TextScaled = true
verifyButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
verifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyButton.Font = Enum.Font.GothamSemibold
verifyButton.AutoButtonColor = false

local message = Instance.new("TextLabel", frame)
message.Position = UDim2.new(0, 0, 0.85, 0)
message.Size = UDim2.new(1, 0, 0.15, 0)
message.Text = ""
message.TextColor3 = Color3.fromRGB(255, 80, 80)
message.BackgroundTransparency = 1
message.TextScaled = true
message.Font = Enum.Font.GothamSemibold

-- Function to copy link
getKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://your-link-generator-url-here")
    message.Text = "Link copied! Paste it in your browser to generate your key."
end)

-- Function to check key format
local function isValidKeyFormat(key)
    return string.match(key, "^JEFF%-%w%w%w%w%-%w%w%w%w$") ~= nil
end

-- Function to send notifications
local function notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 5,
    })
end

-- Table to track used keys
local usedKeys = {}

-- Verify key
verifyButton.MouseButton1Click:Connect(function()
    local inputKey = textBox.Text:upper()
    if not isValidKeyFormat(inputKey) then
        message.Text = "❌ Invalid key format."
        notify("Error", "Invalid key format!", 4)
        return
    end
    if usedKeys[inputKey] then
        message.Text = "❌ This key has already been used! Use another."
        notify("Error", "❌ This key is repeated. Use another!", 5)
        return
    end
    -- Valid and not used before
    usedKeys[inputKey] = true
    message.Text = "✅ Correct key! You are whitelisted."
    notify("Success", "✅ Correct key! Whitelisting...", 5)
    wait(1)
    screenGui:Destroy()
    -- Here your code to unlock features for valid keys
    -- loadstring("Your script URL")()
end)
