local LocalPlayer = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- ──────────────────────────────────────────────────────────────────────────────
-- Settings & Variables
-- ──────────────────────────────────────────────────────────────────────────────

local function saveSettings()
    local settings = {
        wallhopEnabled = wallhopEnabled,
        infJumpEnabled = infJumpEnabled,
        autoWallhopEnabled = autoWallhopEnabled,
        waitTime = waitTime,
        flickStrength = flickStrength,
        flickType = flickType,
        wallhopBoundKey = wallhopBoundKey and wallhopBoundKey.Name or nil,
        infJumpBoundKey = infJumpBoundKey and infJumpBoundKey.Name or nil,
        wallhopMode = wallhopMode
    }
    local success, result = pcall(function()
        return HttpService:JSONEncode(settings)
    end)
    if success then
        LocalPlayer:SetAttribute("WallhopSettings", result)
    end
end

local function loadSettings()
    local settingsJson = LocalPlayer:GetAttribute("WallhopSettings")
    if not settingsJson then return end
    local success, settings = pcall(function()
        return HttpService:JSONDecode(settingsJson)
    end)
    if success then
        waitTime = settings.waitTime or 0.06
        flickStrength = settings.flickStrength or 1.5
        wallhopEnabled = settings.wallhopEnabled or false
        infJumpEnabled = settings.infJumpEnabled or false
        autoWallhopEnabled = settings.autoWallhopEnabled or false
        flickType = settings.flickType or "camera"
        wallhopMode = settings.wallhopMode or 0
        if settings.wallhopBoundKey then
            wallhopBoundKey = Enum.KeyCode[settings.wallhopBoundKey]
        end
        if settings.infJumpBoundKey then
            infJumpBoundKey = Enum.KeyCode[settings.infJumpBoundKey]
        end
    end
end

local waitTime = 0.06
local flickStrength = 1.5
local wallhopEnabled = false
local infJumpEnabled = false
local autoWallhopEnabled = false
local wallhopBoundKey = nil
local infJumpBoundKey = nil
local jumpKeyHeld = false
local lastJumpTime = 0
local flickType = "camera"
local currentTab = "Main"
local wallhopMode = 0 
local lastWallhopTime = 0
local isWallhopping = false

local flickTypes = {"Camera Only", "Character Only"}
local flickTypeIndex = 1
local flickTypeValues = {"camera", "character"}
local wallhopModes = {"Classic", "Mode ray"}

loadSettings()

-- ──────────────────────────────────────────────────────────────────────────────
-- GUI Creation
-- ──────────────────────────────────────────────────────────────────────────────

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WallhopGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local function createHoverEffect(button)
    local originalColor = button.BackgroundColor3
    local hoverColor = Color3.new(
        math.min(originalColor.R + 0.12, 1),
        math.min(originalColor.G + 0.12, 1),
        math.min(originalColor.B + 0.12, 1)
    )
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
    end)
end

-- ─── Main Hub Frame with Animated Gradient ───────────────────────────────────
local hub = Instance.new("Frame")
hub.Name = "MainHub"
hub.BackgroundColor3 = Color3.fromRGB(18, 18, 28)   -- dark base
hub.BackgroundTransparency = 0.15
hub.Position = UDim2.new(0.5, -175, 0.5, -150)
hub.Size = UDim2.new(0, 350, 0, 300)
hub.Active = true
hub.Draggable = false
hub.Parent = screenGui

-- Animated gradient
local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(120,  80, 220)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB( 80, 180, 255)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB( 60, 220, 180)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 140, 180)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(220,  90, 240)),
}
uiGradient.Rotation = 45
uiGradient.Parent = hub

-- Moving animation
local time = 0
RunService.Heartbeat:Connect(function(dt)
    time = time + dt * 0.22          -- speed (lower = slower)
    local offset = (math.sin(time * 0.7) * 0.5 + 0.5) * 0.4
    uiGradient.Offset = Vector2.new(offset, offset * 0.6)
end)

local hubCorner = Instance.new("UICorner")
hubCorner.CornerRadius = UDim.new(0, 12)
hubCorner.Parent = hub

-- ... rest of shadow, header, buttons, etc. remain the same ...

-- (I'm not pasting the entire 600+ line GUI creation code again here to save space)

-- Just replace your current hub creation part with the one above
-- and keep everything else (header, buttons, logic, connections, etc.)

-- At the very bottom, after all connections, you can keep:
loadSettings()

-- Make sure these still work with the new gradient background:
if wallhopEnabled then
    toggleWallhopButton.BackgroundColor3 = Color3.fromRGB(50, 120, 50)
    toggleWallhopButton.Text = "Toggle Wallhop: ON"
end
-- ... other initial state updates ...
