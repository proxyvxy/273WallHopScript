-- Your original script starts here
local LocalPlayer = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local function saveSettings()
    -- Your saveSettings code...
end
local function loadSettings()
    -- Your loadSettings code...
end

loadSettings()

-- =================== Key System UI (integrated) ===================

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- Initial notification
StarterGui:SetCore("SendNotification", {
    Title = "⚠️ WARNING",
    Text = "Do not share your key. It may not work for others.",
    Duration = 6,
})

-- Predefined valid key(s)
local validKeys = {
    "MYSECRETKEY123", -- Replace with your actual key
}

local usedKeys = {}

local keyGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
keyGui.Name = "KeySystemUI"

local frame = Instance.new("Frame", keyGui)
frame.Size = UDim2.new(0, 350, 0, 250)
frame.Position = UDim2.new(0.5, -175, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(180, 180, 180) -- Light gray background
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "JEFF Key System"
title.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local textBox = Instance.new("TextBox", frame)
textBox.Position = UDim2.new(0.1, 0, 0.3, 0)
textBox.Size = UDim2.new(0.8, 0, 0, 40)
textBox.PlaceholderText = "Enter your key..."
textBox.Text = ""
textBox.TextScaled = true
textBox.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
textBox.ClearTextOnFocus = false
textBox.Font = Enum.Font.Gotham

local getKeyBtn = Instance.new("TextButton", frame)
getKeyBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
getKeyBtn.Size = UDim2.new(0.35, 0, 0, 40)
getKeyBtn.Text = "Get Key"
getKeyBtn.TextScaled = true
getKeyBtn.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
getKeyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
getKeyBtn.Font = Enum.Font.GothamSemibold
getKeyBtn.AutoButtonColor = false

local verifyBtn = Instance.new("TextButton", frame)
verifyBtn.Position = UDim2.new(0.55, 0, 0.65, 0)
verifyBtn.Size = UDim2.new(0.35, 0, 0, 40)
verifyBtn.Text = "Verify"
verifyBtn.TextScaled = true
verifyBtn.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
verifyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
verifyBtn.Font = Enum.Font.GothamSemibold
verifyBtn.AutoButtonColor = false

local message = Instance.new("TextLabel", frame)
message.Position = UDim2.new(0, 0, 0.85, 0)
message.Size = UDim2.new(1, 0, 0.15, 0)
message.Text = ""
message.TextColor3 = Color3.fromRGB(255, 80, 80)
message.BackgroundTransparency = 1
message.TextScaled = true
message.Font = Enum.Font.GothamSemibold

-- Copy link button
getKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://your-link-generator-url-here")
    message.Text = "Link copied! Paste it in your browser to generate your key."
end)

-- Function to validate the key
local function isValidKey(inputKey)
    for _, key in ipairs(validKeys) do
        if inputKey == key then
            return true
        end
    end
    return false
end

-- Notification function
local function notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 5,
    })
end

-- Track used keys
local usedKeys = {}

-- Verify button logic
verifyBtn.MouseButton1Click:Connect(function()
    local inputKey = textBox.Text:upper()
    if not isValidKey(inputKey) then
        message.Text = "❌ Invalid key."
        notify("Error", "Invalid key!", 4)
        return
    end
    if usedKeys[inputKey] then
        message.Text = "❌ This key has already been used! Use another."
        notify("Error", "This key is already used. Use another!", 5)
        return
    end
    -- Valid and not used before
    usedKeys[inputKey] = true
    message.Text = "✅ Correct key! You are whitelisted."
    notify("Success", "Key accepted! Whitelisting...", 5)
    wait(1)
    keyGui:Destroy()
    -- Your code to unlock features for valid keys
    -- loadstring("Your script URL")()
end)

-- =================== Your original script code continues below ===================

-- (Insert your full script code here, starting from your "local LocalPlayer" line, as shown before)

-- For demonstration, I will just end here. Make sure to append your original script after the key UI code!
