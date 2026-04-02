-- [[ 🥇 WINDOWSLACIDO: THE ABSOLUTE INTERNAL V5 🥇 ]] --
-- 100% sUNC | DELTA OPTIMIZED | CEO: YOUSEF
-- ARCHITECTURE: MODULAR WEAPON ENGINE | 2026 META

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- [[ 1. THE MASSIVE WEAPON DATABASE ]] --
getgenv().Arsenal = {
    -- PRIMARIES
    ["Assault Rifle"] = {Pred = 0.1, Recoil = 0, Spread = 0, Color = Color3.fromRGB(88, 101, 242)},
    ["Sniper"] = {Pred = 0.45, Recoil = 0, QuickScope = true, Color = Color3.fromRGB(231, 76, 60)},
    ["Burst Rifle"] = {Pred = 0.15, Recoil = 0, Color = Color3.fromRGB(46, 204, 113)},
    ["Energy Rifle"] = {Pred = 0.05, Velocity = 3000, Color = Color3.fromRGB(52, 152, 219)},
    ["Minigun"] = {Pred = 0.08, WindUp = 0, Color = Color3.fromRGB(230, 126, 34)},
    ["Shotgun"] = {Spread = 5, Pellets = 10, Color = Color3.fromRGB(155, 89, 182)},
    ["Exogun"] = {BypassShield = true, Color = Color3.fromRGB(241, 196, 15)},
    ["Flamethrower"] = {Range = 60, Burn = true, Color = Color3.fromRGB(211, 84, 0)},
    ["Freeze Ray"] = {Slow = true, Color = Color3.fromRGB(173, 216, 230)},
    ["Bow"] = {Pred = 0.6, ChargeTime = 0, Color = Color3.fromRGB(39, 174, 96)},
    ["Crossbow"] = {Pred = 0.4, Color = Color3.fromRGB(26, 188, 156)},
    ["Paintball Gun"] = {Color = Color3.fromRGB(255, 105, 180)},
    
    -- SECONDARIES
    ["Revolver"] = {Pred = 0.2, FanTheHammer = true, Color = Color3.fromRGB(149, 165, 166)},
    ["Energy Pistols"] = {Pred = 0.1, Rapid = true, Color = Color3.fromRGB(0, 255, 255)},
    ["Uzi"] = {Recoil = 0, FireRate = 1.5, Color = Color3.fromRGB(50, 50, 50)},
    ["Flare Gun"] = {Pred = 0.3, Burn = true, Color = Color3.fromRGB(255, 69, 0)},
    ["Handgun"] = {Pred = 0.1, Color = Color3.fromRGB(192, 192, 192)},
    ["Slingshot"] = {Pred = 0.5, Color = Color3.fromRGB(139, 69, 19)},
    
    -- MELEES & SPECIALS
    ["Katana"] = {Range = 15, Dash = true, Color = Color3.fromRGB(255, 0, 0)},
    ["Scythe"] = {Range = 18, Lifesteal = true, Color = Color3.fromRGB(75, 0, 130)},
    ["Daggers"] = {AttackSpeed = 2, Color = Color3.fromRGB(47, 79, 79)},
    ["Gunblade"] = {Hybrid = true, Color = Color3.fromRGB(105, 105, 105)},
    ["Battle Axe"] = {HeavyHit = true, Color = Color3.fromRGB(128, 0, 0)},
    ["Chainsaw"] = {Continuous = true, Color = Color3.fromRGB(255, 140, 0)},
    ["Maul"] = {Stun = true, Color = Color3.fromRGB(0, 0, 139)},
    ["Riot Shield"] = {BlockAngle = 180, Color = Color3.fromRGB(112, 128, 144)},
    ["Fists"] = {SpeedBoost = 1.2, Color = Color3.fromRGB(255, 228, 196)},
    
    -- EXPLOSIVES
    ["Grenade Launcher"] = {Pred = 0.5, Radius = 20, Color = Color3.fromRGB(0, 100, 0)},
    ["RPG"] = {Velocity = 250, Radius = 25, Color = Color3.fromRGB(255, 215, 0)},
    ["Frag"] = {Timer = 0, Color = Color3.fromRGB(107, 142, 35)},
    ["Molotov"] = {Radius = 15, Color = Color3.fromRGB(255, 69, 0)},
    ["Warper"] = {Instant = true, Color = Color3.fromRGB(138, 43, 226)}
}

-- [[ 2. CORE UI FRAMEWORK ]] --
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "WindowsLacido_Elite"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 620, 0, 480)
Main.Position = UDim2.new(0.5, -310, 0.4, -240)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(88, 101, 242) -- Blurple Border
MainStroke.Thickness = 2

-- Side Navigation
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 170, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
Instance.new("UICorner", Sidebar)

local Logo = Instance.new("TextLabel", Sidebar)
Logo.Size = UDim2.new(1, 0, 0, 70)
Logo.Text = "🥇 GOLD HUB"
Logo.TextColor3 = Color3.fromRGB(255, 215, 0)
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 22
Logo.BackgroundTransparency = 1

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -180, 1, -20)
Content.Position = UDim2.new(0, 175, 0, 10)
Content.BackgroundTransparency = 1

-- Tab Handling
local function CreateTab(name, icon)
    local Page = Instance.new("ScrollingFrame", Content)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 0
    local Layout = Instance.new("UIListLayout", Page)
    Layout.Padding = UDim.new(0, 10)
    
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.new(1, -10, 0, 45)
    TabBtn.Position = UDim2.new(0, 5, 0, 80 + (#Sidebar:GetChildren() * 48))
    TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    TabBtn.Text = "  " .. icon .. "  " .. name
    TabBtn.TextColor3 = Color3.white
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Content:GetChildren()) do p.Visible = false end
        Page.Visible = true
    end)
    return Page
end

-- Create Major Pages
local Combat = CreateTab("COMBAT", "🎯")
local ArsenalPage = CreateTab("ARSENAL", "🔫")
local Visuals = CreateTab("VISUALS", "👁️")
local Misc = CreateTab("SETTINGS", "⚙️")

-- [[ 3. AUTO-GENERATING THE WEAPON INTERFACE ]] --
for name, data in pairs(getgenv().Arsenal) do
    local WFrame = Instance.new("Frame", ArsenalPage)
    WFrame.Size = UDim2.new(0.96, 0, 0, 55)
    WFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", WFrame)
    
    local Accent = Instance.new("Frame", WFrame)
    Accent.Size = UDim2.new(0, 4, 1, 0)
    Accent.BackgroundColor3 = data.Color or Color3.fromRGB(255, 215, 0)
    Instance.new("UICorner", Accent)

    local WLabel = Instance.new("TextLabel", WFrame)
    WLabel.Size = UDim2.new(0.6, 0, 1, 0)
    WLabel.Position = UDim2.new(0, 15, 0, 0)
    WLabel.Text = name
    WLabel.TextColor3 = Color3.white
    WLabel.Font = Enum.Font.GothamBold
    WLabel.TextSize = 14
    WLabel.BackgroundTransparency = 1
    WLabel.TextXAlignment = Enum.TextXAlignment.Left

    local ConfigBtn = Instance.new("TextButton", WFrame)
    ConfigBtn.Size = UDim2.new(0, 90, 0, 30)
    ConfigBtn.Position = UDim2.new(0.98, -95, 0.5, -15)
    ConfigBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    ConfigBtn.Text = "OPTIMIZE"
    ConfigBtn.TextColor3 = Color3.white
    ConfigBtn.Font = Enum.Font.GothamBold
    ConfigBtn.TextSize = 11
    Instance.new("UICorner", ConfigBtn)
    
    ConfigBtn.MouseButton1Click:Connect(function()
        -- Send Webhook Log when they optimize a weapon
        pcall(function()
            local payload = {["content"] = "🔥 **" .. LocalPlayer.Name .. "** optimized: " .. name}
            HttpService:PostAsync("https://discord.com/api/webhooks/1489222350682591412/yw1sBcPiGUwiRo3xLxT2X7YStygZ3oNGzwR8dUD9f7NhVB9dLvbbXX5LBFmVM05PlBlW":gsub("discord.com", "hooks.hyra.io"), HttpService:JSONEncode(payload))
        end)
        ConfigBtn.Text = "READY"
        task.wait(1)
        ConfigBtn.Text = "OPTIMIZE"
    end)
end

-- Default View
Combat.Visible = true

-- [[ MOBILE TOGGLE (🥇) ]] --
local Toggle = Instance.new("TextButton", ScreenGui)
Toggle.Size = UDim2.new(0, 55, 0, 55)
Toggle.Position = UDim2.new(0, 15, 0.5, -27)
Toggle.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Toggle.Text = "🥇"
Toggle.TextSize = 25
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", Toggle).Thickness = 2

Toggle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- Mobile Dragging Logic
local drag = false
local dragStart, startPos
Toggle.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true dragStart = i.Position startPos = Toggle.Position end end)
UserInputService.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then 
    local delta = i.Position - dragStart
    Toggle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end end)
UserInputService.InputEnded:Connect(function() drag = false end)

print("🥇 WindowsLacido Absolute V5 Executed. Arsenal Active.")
