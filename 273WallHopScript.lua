-- === Branding & Title Changes ===

-- Main GUI title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.BackgroundTransparency = 0.1
title.Position = UDim2.new(0, 10, 0, 0)
title.Size = UDim2.new(1, -50, 1, 0)
title.Font = Enum.Font.GothamBlack   -- more premium feel
title.Text = "273 Hub"
title.TextColor3 = Color3.fromRGB(220, 180, 255)   -- light purple
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Welcome / subtitle (optional small text under title if you want)
local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 10, 0, 22)
subtitle.Size = UDim2.new(1, -50, 0, 16)
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "fast. clean. 273."
subtitle.TextColor3 = Color3.fromRGB(180, 140, 220)
subtitle.TextSize = 13
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

-- Change main frame background (darker purple theme)
hub.BackgroundColor3 = Color3.fromRGB(28, 22, 38)      -- deep dark purple
hub.BackgroundTransparency = 0.05

-- Header background
header.BackgroundColor3 = Color3.fromRGB(40, 30, 55)
header.BackgroundTransparency = 0.15

-- Tab buttons (selected / hover states will use purple accents)
-- Example for active tab:
-- mainTabButton.BackgroundTransparency = 0.35   (when selected)
-- mainTabButton.BackgroundColor3 = Color3.fromRGB(90, 60, 140)

-- Discord button
discordButton.Text = "Join 273 Discord"
discordButton.BackgroundColor3 = Color3.fromRGB(90, 60, 140)

discordButton.MouseButton1Click:Connect(function()
    local discordLink = "http://discord.gg/qYJ9gnB2DQ"
    local success = pcall(function()
        setclipboard(discordLink)
    end)
    local originalText = discordButton.Text
    discordButton.Text = success and "Link Copied!" or "Failed to copy"
    task.delay(2, function()
        discordButton.Text = originalText
    end)
end)

-- Replace any old welcome text that might still exist
-- (in case you had "Welcome, love from 273" somewhere)
-- Search for .Text = "Welcome" or similar and change to:
-- title.Text = "273 Hub"

-- Optional: change toggle button colors when ON
-- (example for wallhop toggle)
if wallhopEnabled then
    toggleWallhopButton.BackgroundColor3 = Color3.fromRGB(140, 100, 200)  -- purple ON
    toggleWallhopButton.Text = "Wallhop: ON"
else
    toggleWallhopButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    toggleWallhopButton.Text = "Wallhop: OFF"
end

-- Same pattern for infJump, autoWallhop, etc.
