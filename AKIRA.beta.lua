-- AKIRA Script v1.0 | Steal An Egg Khmer
-- Keyless menu hub. Load with:
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/rothphoneshop09-ship-it/Steal-An-Egg-Khmer-/refs/heads/main/AKIRA.script.1.0"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

--// Settings
local Settings = {
    Speed = false,
    SpeedValue = 50,
    Fly = false,
    FlySpeed = 50,
    AntiAFK = true,
    ESP = false,
}

--// Anti AFK
if Settings.AntiAFK then
    local vu = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
end

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AKIRA_HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 320, 0, 380)
Main.Position = UDim2.new(0.5, -160, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(15, 20, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 255, 100)
Stroke.Thickness = 1.5
Stroke.Transparency = 0.4
Stroke.Parent = Main

--// Title bar
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
Title.BackgroundTransparency = 0.85
Title.Text = "  AKIRA HUB  |  v1.0"
Title.TextColor3 = Color3.fromRGB(0, 255, 100)
Title.Font = Enum.Font.Code
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

--// Close button
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -36, 0, 5)
Close.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.Font = Enum.Font.Code
Close.TextSize = 14
Close.Parent = Main

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = Close

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

--// Minimize button
local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0, 30, 0, 30)
Minimize.Position = UDim2.new(1, -72, 0, 5)
Minimize.BackgroundColor3 = Color3.fromRGB(40, 50, 40)
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(0, 255, 100)
Minimize.Font = Enum.Font.Code
Minimize.TextSize = 16
Minimize.Parent = Main

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = Minimize

--// Content holder
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -60)
Content.Position = UDim2.new(0, 10, 0, 50)
Content.BackgroundTransparency = 1
Content.Parent = Main

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 8)
UIList.Parent = Content

local minimized = false
Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    Content.Visible = not minimized
    Main.Size = minimized and UDim2.new(0, 320, 0, 40) or UDim2.new(0, 320, 0, 380)
end)

--// Toggle factory
local function makeToggle(name, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 36)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 35, 25)
    Btn.Text = name .. "  [ OFF ]"
    Btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    Btn.Font = Enum.Font.Code
    Btn.TextSize = 14
    Btn.Parent = Content

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = Btn

    local on = false
    Btn.MouseButton1Click:Connect(function()
        on = not on
        Btn.Text = name .. (on and "  [ ON ]" or "  [ OFF ]")
        Btn.TextColor3 = on and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(180, 180, 180)
        callback(on)
    end)
end

--// Button factory
local function makeButton(name, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 36)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 35, 25)
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(0, 255, 100)
    Btn.Font = Enum.Font.Code
    Btn.TextSize = 14
    Btn.Parent = Content

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = Btn

    Btn.MouseButton1Click:Connect(callback)
end

--// Speed
RunService.Heartbeat:Connect(function()
    if Settings.Speed and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = Settings.SpeedValue end
    end
end)

makeToggle("Speed Hack", function(on) Settings.Speed = on end)

--// Fly
local flying = false
makeToggle("Fly", function(on)
    Settings.Fly = on
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if on then
        flying = true
        local bv = Instance.new("BodyVelocity")
        bv.Name = "AKIRA_FLY"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Parent = root
        task.spawn(function()
            while flying and root.Parent do
                local dir = Vector3.new()
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then dir = hum.MoveDirection end
                bv.Velocity = dir * Settings.FlySpeed
                RunService.Heartbeat:Wait()
            end
            bv:Destroy()
        end)
    else
        flying = false
        local bv = root:FindFirstChild("AKIRA_FLY")
        if bv then bv:Destroy() end
    end
end)

--// ESP (highlights eggs & players)
local espObjs = {}
makeToggle("ESP", function(on)
    Settings.ESP = on
    if on then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local h = Instance.new("Highlight")
                h.FillColor = Color3.fromRGB(0, 255, 100)
                h.FillTransparency = 0.6
                h.Parent = plr.Character
                table.insert(espObjs, h)
            end
        end
    else
        for _, h in ipairs(espObjs) do pcall(function() h:Destroy() end) end
        espObjs = {}
    end
end)

--// Teleport to nearest egg (looks for parts named "Egg")
makeButton("Teleport To Nearest Egg", function()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local nearest, dist = nil, math.huge
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("egg") then
            local d = (obj.Position - root.Position).Magnitude
            if d < dist then dist, nearest = d, obj end
        end
    end
    if nearest then
        root.CFrame = nearest.CFrame + Vector3.new(0, 3, 0)
    end
end)

--// Reset character
makeButton("Reset Character", function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.Health = 0 end
end)

--// Credits
local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1, 0, 0, 24)
Credit.BackgroundTransparency = 1
Credit.Text = "AKIRA HUB — Made for Khmer community"
Credit.TextColor3 = Color3.fromRGB(100, 120, 100)
Credit.Font = Enum.Font.Code
Credit.TextSize = 11
Credit.Parent = Content

print("[AKIRA HUB] Loaded successfully! v1.0")
