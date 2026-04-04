-- [[ MM2 SUPREME PREMIUM - NEON PURPLE EDITION ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- 1. THE NEON UI SETUP (Glowing Purple & Moving Gradients)
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", ScreenGui)
local UICorner = Instance.new("UICorner", Main)
local UIStroke = Instance.new("UIStroke", Main)
local UIGradient = Instance.new("UIGradient", Main)

Main.Size = UDim2.new(0, 450, 0, 350)
Main.Position = UDim2.new(0.5, -225, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(10, 0, 20)
UICorner.CornerRadius = UDim.new(0, 20)

-- Neon Glow Outline
UIStroke.Color = Color3.fromRGB(200, 0, 255)
UIStroke.Thickness = 4
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Moving Gradient Background
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 0, 80)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 0, 80))
}

task.spawn(function()
    while true do
        for i = -1, 1, 0.01 do
            UIGradient.Offset = Vector2.new(i, 0)
            task.wait(0.03)
        end
    end
end)

-- 2. ESP & ROLE CHAMS (Suggesting Roles via Highlights)
local function CreateESP(plr)
    plr.CharacterAdded:Connect(function(char)
        local Highlight = Instance.new("Highlight", char)
        Highlight.OutlineTransparency = 0
        Highlight.FillTransparency = 0.4
        
        RunService.RenderStepped:Connect(function()
            if char:FindFirstChild("Knife") or plr.Backpack:FindFirstChild("Knife") then
                Highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Murderer
            elseif char:FindFirstChild("Gun") or plr.Backpack:FindFirstChild("Gun") then
                Highlight.FillColor = Color3.fromRGB(0, 0, 255) -- Sheriff
            else
                Highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Innocent
            end
        end)
    end)
end
for _, v in pairs(Players:GetPlayers()) do if v ~= LocalPlayer then CreateESP(v) end end
Players.PlayerAdded:Connect(CreateESP)

-- 3. SILENT AIM (Hooking Methods)
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" and (self.Name == "Shoot" or self.Name == "Throw") then
        local target = nil
        local dist = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local d = (p.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then dist = d target = p end
            end
        end
        if target then return old(self, target.Character.HumanoidRootPart.Position) end
    end
    return old(self, ...)
end)

-- 4. KILL ALL & BLATANT COIN TP
_G.AutoCoin = false
_G.Speed = 90

local function KillAll()
    local Knife = LocalPlayer.Character:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
    if Knife then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                task.wait(0.1)
                Knife.Stab:FireServer()
            end
        end
    end
end

-- Coin Collection (Blatant Teleport)
task.spawn(function()
    while task.wait() do
        if _G.AutoCoin then
            for _, c in pairs(workspace:GetDescendants()) do
                if c.Name == "CoinContainer" then
                    for _, coin in pairs(c:GetChildren()) do
                        LocalPlayer.Character.HumanoidRootPart.CFrame = coin.CFrame
                        task.wait(0.05)
                    end
                end
            end
        end
    end
end)

-- 5. KILL MURDERER (Sheriff Mode)
local function KillMurderer()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and (p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife")) then
            LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
            task.wait(0.1)
            local Gun = LocalPlayer.Character:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
            if Gun then Gun.Shoot:FireServer(p.Character.HumanoidRootPart.Position) end
        end
    end
end

print("MM2 Supreme Loaded. Key Verified.")
