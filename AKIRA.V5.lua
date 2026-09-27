--[[
    AKIRA SCRIPT HUB • EXECUTIVE PREMIUM EDITION
    Design Framework:
    - Obsidian & Deep Navy Frosted Cards
    - Royal Cyan Ambient Lighting (#00D4FF)
    - Executive VIP Member Status Tag
    - Smooth Micro-Damped Motion (EasingStyle.Quart/Back)
    - Khmer Localization & Mobile Floating Logo
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local GuiParent = (gethui and gethui()) or (syn and syn.protect_gui and PlayerGui) or PlayerGui

-- Sound Setup
local AkiraSoundFolder = Instance.new("Folder")
AkiraSoundFolder.Name = "AkiraSounds"
AkiraSoundFolder.Parent = SoundService

local AkiraClickSound = Instance.new("Sound")
AkiraClickSound.Name = "AkiraClick"
AkiraClickSound.SoundId = "rbxassetid://6026984224"
AkiraClickSound.Volume = 0.28
AkiraClickSound.Parent = AkiraSoundFolder

local function AkiraPlayClick(speed, volume)
    pcall(function()
        AkiraClickSound:Stop()
        AkiraClickSound.TimePosition = 0
        AkiraClickSound.PlaybackSpeed = speed or 1
        AkiraClickSound.Volume = volume or 0.28
        AkiraClickSound:Play()
    end)
end

local old = GuiParent:FindFirstChild("AkiraScriptHub")
if old then
    old:Destroy()
end

local function tween(obj, info, props)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

-- Premium Palette
local Colors = {
    Background = Color3.fromRGB(13, 15, 20),
    CardBg = Color3.fromRGB(20, 24, 34),
    CardBorder = Color3.fromRGB(36, 44, 62),
    Accent = Color3.fromRGB(0, 212, 255),
    AccentGlow = Color3.fromRGB(0, 140, 255),
    TextActive = Color3.fromRGB(255, 255, 255),
    TextMuted = Color3.fromRGB(150, 160, 185),
    Sidebar = Color3.fromRGB(16, 19, 26)
}

local gui = Instance.new("ScreenGui")
gui.Name = "AkiraScriptHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 9999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = GuiParent

local scale = Instance.new("UIScale")
scale.Scale = 0.88
scale.Parent = gui

local Sizes = {
    UDim2.fromOffset(335, 260),
    UDim2.fromOffset(385, 295),
    UDim2.fromOffset(435, 335),
}
local SizeIndex = 2

-- Deep Drop Shadow
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.fromScale(0.5, 0.512)
shadow.Size = Sizes[SizeIndex]
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.4
shadow.BorderSizePixel = 0
shadow.Parent = gui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 16)
shadowCorner.Parent = shadow

-- Main Container
local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.48)
main.Size = Sizes[SizeIndex]
main.BackgroundColor3 = Colors.Background
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 1.4
mainStroke.Color = Colors.CardBorder
mainStroke.Parent = main

-- Top Navigation Header
local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 52)
top.BackgroundColor3 = Color3.fromRGB(17, 21, 29)
top.BorderSizePixel = 0
top.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 16)
topCorner.Parent = top

local topDivider = Instance.new("Frame")
topDivider.Size = UDim2.new(1, 0, 0, 1)
topDivider.Position = UDim2.new(0, 0, 1, -1)
topDivider.BackgroundColor3 = Color3.fromRGB(28, 34, 48)
topDivider.BorderSizePixel = 0
topDivider.Parent = top

-- Brand & Status Badge
local brandContainer = Instance.new("Frame")
brandContainer.BackgroundTransparency = 1
brandContainer.Position = UDim2.fromOffset(14, 0)
brandContainer.Size = UDim2.new(0.68, 0, 1, 0)
brandContainer.Parent = top

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(0, 8)
title.Size = UDim2.new(1, 0, 0, 18)
title.Font = Enum.Font.GothamBold
title.Text = "AKIRA PREMIER"
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Colors.TextActive
title.Parent = brandContainer

local vipBadge = Instance.new("Frame")
vipBadge.Position = UDim2.fromOffset(0, 28)
vipBadge.Size = UDim2.fromOffset(78, 16)
vipBadge.BackgroundColor3 = Color3.fromRGB(0, 48, 70)
vipBadge.BorderSizePixel = 0
vipBadge.Parent = brandContainer

local vipCorner = Instance.new("UICorner")
vipCorner.CornerRadius = UDim.new(0, 4)
vipCorner.Parent = vipBadge

local vipStroke = Instance.new("UIStroke")
vipStroke.Thickness = 1
vipStroke.Color = Colors.Accent
vipStroke.Transparency = 0.4
vipStroke.Parent = vipBadge

local vipText = Instance.new("TextLabel")
vipText.BackgroundTransparency = 1
vipText.Size = UDim2.fromScale(1, 1)
vipText.Font = Enum.Font.GothamBold
vipText.Text = "✦ VIP EDITION"
vipText.TextSize = 8
vipText.TextColor3 = Colors.Accent
vipText.Parent = vipBadge

-- Top Control Actions
local function makeTopBtn(symbol, xOffset)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(26, 26)
    b.Position = UDim2.new(1, xOffset, 0.5, 0)
    b.AnchorPoint = Vector2.new(1, 0.5)
    b.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
    b.BorderSizePixel = 0
    b.Text = symbol
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.TextColor3 = Colors.TextMuted
    b.AutoButtonColor = false
    b.Parent = top
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b
    local s = Instance.new("UIStroke")
    s.Thickness = 1
    s.Color = Color3.fromRGB(36, 42, 58)
    s.Parent = b
    return b
end

local minimize = makeTopBtn("—", -44)
local close = makeTopBtn("×", -10)

-- Sidebar Tabs
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.fromOffset(8, 58)
sidebar.Size = UDim2.new(0, 108, 1, -66)
sidebar.BackgroundColor3 = Colors.Sidebar
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 10)
sideCorner.Parent = sidebar

local sideStroke = Instance.new("UIStroke")
sideStroke.Thickness = 1
sideStroke.Color = Color3.fromRGB(28, 34, 48)
sideStroke.Parent = sidebar

-- Content Area
local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 122, 0, 58)
content.Size = UDim2.new(1, -130, 1, -66)
content.BackgroundTransparency = 1
content.Parent = main

local currentTab = "ស្គ្រីប"
local pages = {}

local function makePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = Colors.Accent
    page.CanvasSize = UDim2.new()
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.Visible = (name == "ស្គ្រីប")
    page.Parent = content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    local pad = Instance.new("UIPadding")
    pad.PaddingRight = UDim.new(0, 4)
    pad.PaddingBottom = UDim.new(0, 8)
    pad.Parent = page

    pages[name] = page
    return page
end

local scriptsPage = makePage("ស្គ្រីប")
local configPage = makePage("ការកំណត់")

local tabButtons = {}
local function makeTab(text, icon, yPos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -12, 0, 36)
    b.Position = yPos
    b.BackgroundColor3 = Colors.Sidebar
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.Parent = sidebar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b

    local bStroke = Instance.new("UIStroke")
    bStroke.Thickness = 1
    bStroke.Color = Color3.fromRGB(30, 36, 50)
    bStroke.Transparency = 1
    bStroke.Parent = b

    local glowLine = Instance.new("Frame")
    glowLine.Name = "GlowLine"
    glowLine.Size = UDim2.new(0, 3, 0.6, 0)
    glowLine.Position = UDim2.new(0, 5, 0.2, 0)
    glowLine.BackgroundColor3 = Colors.Accent
    glowLine.BorderSizePixel = 0
    glowLine.Visible = false
    glowLine.Parent = b

    local glCorner = Instance.new("UICorner")
    glCorner.CornerRadius = UDim.new(1, 0)
    glCorner.Parent = glowLine

    local label = Instance.new("TextLabel")
    label.Name = "TabLabel"
    label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1)
    label.Position = UDim2.fromOffset(14, 0)
    label.Text = icon .. "  " .. text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextColor3 = Colors.TextMuted
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = b

    tabButtons[text] = {Button = b, Label = label, Line = glowLine, Stroke = bStroke}
    return b
end

local scriptsTab = makeTab("ស្គ្រីប", "🛡", UDim2.fromOffset(6, 8))
local configTab = makeTab("ការកំណត់", "⚙", UDim2.new(0, 6, 1, -44))

local function refreshTabs()
    for name, data in pairs(tabButtons) do
        local isSelected = (name == currentTab)
        if isSelected then
            data.Button.BackgroundColor3 = Color3.fromRGB(24, 29, 40)
            data.Label.TextColor3 = Colors.TextActive
            data.Line.Visible = true
            data.Stroke.Transparency = 0.3
            data.Stroke.Color = Colors.Accent
        else
            data.Button.BackgroundColor3 = Colors.Sidebar
            data.Label.TextColor3 = Colors.TextMuted
            data.Line.Visible = false
            data.Stroke.Transparency = 1
        end
    end
    for name, page in pairs(pages) do
        page.Visible = (name == currentTab)
        if page.Visible then
            page.CanvasPosition = Vector2.zero
        end
    end
end

local function switchTab(tab)
    currentTab = tab
    refreshTabs()
end

scriptsTab.Activated:Connect(function() AkiraPlayClick(); switchTab("ស្គ្រីប") end)
configTab.Activated:Connect(function() AkiraPlayClick(); switchTab("ការកំណត់") end)

-- Floating Touch Drag Bar
local dragHandle = Instance.new("TextButton")
dragHandle.Name = "AkiraDragHandle"
dragHandle.AnchorPoint = Vector2.new(0.5, 0.5)
dragHandle.Size = UDim2.fromOffset(110, 16)
dragHandle.BackgroundTransparency = 1
dragHandle.BorderSizePixel = 0
dragHandle.Text = ""
dragHandle.AutoButtonColor = false
dragHandle.ZIndex = 60
dragHandle.Visible = false
dragHandle.Parent = gui

local dragVisual = Instance.new("Frame")
dragVisual.AnchorPoint = Vector2.new(0.5, 0.5)
dragVisual.Position = UDim2.fromScale(0.5, 0.5)
dragVisual.Size = UDim2.fromOffset(72, 3)
dragVisual.BackgroundColor3 = Colors.Accent
dragVisual.BorderSizePixel = 0
dragVisual.ZIndex = 61
dragVisual.Parent = dragHandle

local dragCorner = Instance.new("UICorner")
dragCorner.CornerRadius = UDim.new(1, 0)
dragCorner.Parent = dragVisual

-- Resize Handle
local resizeHandle = Instance.new("TextButton")
resizeHandle.Name = "AkiraResizeHandle"
resizeHandle.AnchorPoint = Vector2.new(0.5, 0.5)
resizeHandle.Size = UDim2.fromOffset(28, 28)
resizeHandle.BackgroundTransparency = 1
resizeHandle.BorderSizePixel = 0
resizeHandle.Text = "↘"
resizeHandle.Font = Enum.Font.GothamBold
resizeHandle.TextSize = 18
resizeHandle.TextColor3 = Colors.Accent
resizeHandle.AutoButtonColor = false
resizeHandle.ZIndex = 70
resizeHandle.Visible = false
resizeHandle.Parent = gui

local function updateFloatingControls()
    local x = main.Position.X.Scale
    local ox = main.Position.X.Offset
    local y = main.Position.Y.Scale
    local oy = main.Position.Y.Offset
    local halfW = main.AbsoluteSize.X * 0.5
    local halfH = main.AbsoluteSize.Y * 0.5
    dragHandle.Position = UDim2.new(x, ox, y, oy + halfH + 11)
    resizeHandle.Position = UDim2.new(x, ox + halfW + 14, y, oy + halfH + 14)
end

-- ============================================================
-- VIP GLASS CARD: ANTI-HIT TOGGLE
-- ============================================================
local AntiHitEnabled = false
local IsAntiHitRunning = false
local ANTI_HIT_SPEED = 0.016

local antiHitCard = Instance.new("Frame")
antiHitCard.Name = "AntiHitCard"
antiHitCard.Size = UDim2.new(1, -6, 0, 54)
antiHitCard.BackgroundColor3 = Colors.CardBg
antiHitCard.BorderSizePixel = 0
antiHitCard.Parent = scriptsPage

local cardCorner = Instance.new("UICorner")
cardCorner.CornerRadius = UDim.new(0, 10)
cardCorner.Parent = antiHitCard

local cardStroke = Instance.new("UIStroke")
cardStroke.Thickness = 1
cardStroke.Color = Colors.CardBorder
cardStroke.Parent = antiHitCard

local cardTitle = Instance.new("TextLabel")
cardTitle.BackgroundTransparency = 1
cardTitle.Position = UDim2.fromOffset(12, 9)
cardTitle.Size = UDim2.new(1, -75, 0, 18)
cardTitle.Font = Enum.Font.GothamBold
cardTitle.Text = "🛡 ប្រព័ន្ធការពារការវាយ (Anti-Hit)"
cardTitle.TextSize = 12
cardTitle.TextColor3 = Colors.TextActive
cardTitle.TextXAlignment = Enum.TextXAlignment.Left
cardTitle.Parent = antiHitCard

local cardDesc = Instance.new("TextLabel")
cardDesc.BackgroundTransparency = 1
cardDesc.Position = UDim2.fromOffset(12, 28)
cardDesc.Size = UDim2.new(1, -75, 0, 14)
cardDesc.Font = Enum.Font.GothamMedium
cardDesc.Text = "គេចផុតពីការវាយប្រហារដោយស្វ័យប្រវត្តិ"
cardDesc.TextSize = 10
cardDesc.TextColor3 = Colors.TextMuted
cardDesc.TextXAlignment = Enum.TextXAlignment.Left
cardDesc.Parent = antiHitCard

-- Modern Pill Toggle
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.fromOffset(40, 22)
toggleButton.Position = UDim2.new(1, -12, 0.5, 0)
toggleButton.AnchorPoint = Vector2.new(1, 0.5)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 36, 48)
toggleButton.BorderSizePixel = 0
toggleButton.Text = ""
toggleButton.AutoButtonColor = false
toggleButton.Parent = antiHitCard

local tCorner = Instance.new("UICorner")
tCorner.CornerRadius = UDim.new(1, 0)
tCorner.Parent = toggleButton

local toggleKnob = Instance.new("Frame")
toggleKnob.Size = UDim2.fromOffset(16, 16)
toggleKnob.Position = UDim2.new(0, 3, 0.5, 0)
toggleKnob.AnchorPoint = Vector2.new(0, 0.5)
toggleKnob.BackgroundColor3 = Colors.TextMuted
toggleKnob.BorderSizePixel = 0
toggleKnob.Parent = toggleButton

local kCorner = Instance.new("UICorner")
kCorner.CornerRadius = UDim.new(1, 0)
kCorner.Parent = toggleKnob

local function setAntiHitVisual(enabled)
    if enabled then
        tween(toggleButton, TweenInfo.new(0.22, Enum.EasingStyle.Quart), {BackgroundColor3 = Colors.Accent})
        tween(toggleKnob, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -19, 0.5, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        })
        cardStroke.Color = Colors.Accent
    else
        tween(toggleButton, TweenInfo.new(0.22, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(30, 36, 48)})
        tween(toggleKnob, TweenInfo.new(0.22, Enum.EasingStyle.Quart), {
            Position = UDim2.new(0, 3, 0.5, 0),
            BackgroundColor3 = Colors.TextMuted
        })
        cardStroke.Color = Colors.CardBorder
    end
end

local TeleportPoints = {
    Vector3.new(500.62, 241.28, -366.64),
    Vector3.new(504.45, 155.80, -366.35),
    Vector3.new(508.30, 70.28, -366.03),
    Vector3.new(513.86, 70.28, -366.25),
    Vector3.new(519.43, 70.28, -366.47),
    Vector3.new(524.32, 70.28, -366.59),
    Vector3.new(529.22, 70.28, -366.71),
    Vector3.new(538.01, 70.28, -365.55),
    Vector3.new(546.80, 70.28, -364.40)
}

local function TeleportRoute(character)
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root or not humanoid or humanoid.Health <= 0 then return end
    
    IsAntiHitRunning = true
    for _, position in ipairs(TeleportPoints) do
        if not AntiHitEnabled or not root.Parent or humanoid.Health <= 0 then
            IsAntiHitRunning = false
            return
        end
        root.CFrame = CFrame.new(position)
        task.wait(ANTI_HIT_SPEED)
    end
    IsAntiHitRunning = false
end

toggleButton.Activated:Connect(function()
    AkiraPlayClick()
    AntiHitEnabled = not AntiHitEnabled
    setAntiHitVisual(AntiHitEnabled)
end)

ProximityPromptService.PromptTriggered:Connect(function(prompt, player)
    if player ~= Player then return end
    if not AntiHitEnabled or IsAntiHitRunning then return end
    local character = Player.Character
    if not character then return end
    task.spawn(function()
        TeleportRoute(character)
    end)
end)

-- ============================================================
-- CONFIG TAB (PREMIUM SETTINGS)
-- ============================================================
local function makeHeader(text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -6, 0, 20)
    l.BackgroundTransparency = 1
    l.Text = text:upper()
    l.Font = Enum.Font.GothamBold
    l.TextSize = 10
    l.TextColor3 = Colors.Accent
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = configPage
    return l
end

makeHeader("ទំហំផ្ទាំង (Hub Scale)")

local sizeRow = Instance.new("Frame")
sizeRow.Size = UDim2.new(1, -6, 0, 36)
sizeRow.BackgroundColor3 = Colors.CardBg
sizeRow.BorderSizePixel = 0
sizeRow.Parent = configPage

local sCorner = Instance.new("UICorner")
sCorner.CornerRadius = UDim.new(0, 8)
sCorner.Parent = sizeRow

local sStroke = Instance.new("UIStroke")
sStroke.Thickness = 1
sStroke.Color = Colors.CardBorder
sStroke.Parent = sizeRow

local sizeMinus = Instance.new("TextButton")
sizeMinus.Size = UDim2.new(0.3, 0, 1, 0)
sizeMinus.BackgroundTransparency = 1
sizeMinus.Text = "−"
sizeMinus.Font = Enum.Font.GothamBold
sizeMinus.TextSize = 14
sizeMinus.TextColor3 = Colors.TextActive
sizeMinus.Parent = sizeRow

local sizeText = Instance.new("TextLabel")
sizeText.Size = UDim2.new(0.4, 0, 1, 0)
sizeText.Position = UDim2.new(0.3, 0, 0, 0)
sizeText.BackgroundTransparency = 1
sizeText.Text = "មធ្យម"
sizeText.Font = Enum.Font.GothamMedium
sizeText.TextSize = 11
sizeText.TextColor3 = Colors.Accent
sizeText.Parent = sizeRow

local sizePlus = Instance.new("TextButton")
sizePlus.Size = UDim2.new(0.3, 0, 1, 0)
sizePlus.Position = UDim2.new(0.7, 0, 0, 0)
sizePlus.BackgroundTransparency = 1
sizePlus.Text = "+"
sizePlus.Font = Enum.Font.GothamBold
sizePlus.TextSize = 14
sizePlus.TextColor3 = Colors.TextActive
sizePlus.Parent = sizeRow

local sizeNames = {"តូច", "មធ្យម", "ធំ"}

local function setSize(index)
    SizeIndex = math.clamp(index, 1, #Sizes)
    sizeText.Text = sizeNames[SizeIndex]
    local target = Sizes[SizeIndex]
    tween(main, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
    tween(shadow, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
    task.defer(updateFloatingControls)
end

sizeMinus.Activated:Connect(function() AkiraPlayClick(); setSize(SizeIndex - 1) end)
sizePlus.Activated:Connect(function() AkiraPlayClick(); setSize(SizeIndex + 1) end)

makeHeader("ការគ្រប់គ្រងផ្ទាំង (Window Controls)")

local infoCard = Instance.new("Frame")
infoCard.Size = UDim2.new(1, -6, 0, 42)
infoCard.BackgroundColor3 = Colors.CardBg
infoCard.BorderSizePixel = 0
infoCard.Parent = configPage

local iCorner = Instance.new("UICorner")
iCorner.CornerRadius = UDim.new(0, 8)
iCorner.Parent = infoCard

local iStroke = Instance.new("UIStroke")
iStroke.Thickness = 1
iStroke.Color = Colors.CardBorder
iStroke.Parent = infoCard

local iLabel = Instance.new("TextLabel")
iLabel.Size = UDim2.new(1, -16, 1, 0)
iLabel.Position = UDim2.fromOffset(8, 0)
iLabel.BackgroundTransparency = 1
iLabel.Text = "បិទ ឬ បើកផ្ទាំង៖ ចុច × ឬ ចុចលើរូប Logo VIP"
iLabel.Font = Enum.Font.GothamMedium
iLabel.TextSize = 11
iLabel.TextColor3 = Colors.TextMuted
iLabel.TextXAlignment = Enum.TextXAlignment.Left
iLabel.Parent = infoCard

-- ============================================================
-- DRAGGING & RESIZING
-- ============================================================
local dragging = false
local dragStart
local startPos
local dragSource

local function beginDrag(input, source)
    dragging = true
    dragSource = source
    dragStart = input.Position
    startPos = main.Position
    if source == dragHandle then
        tween(dragVisual, TweenInfo.new(0.10, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(105, 5)
        })
    end
end

local function updateDrag(input)
    if not dragging then return end
    local delta = input.Position - dragStart
    local camera = workspace.CurrentCamera
    local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
    local halfW = main.AbsoluteSize.X * 0.5
    local halfH = main.AbsoluteSize.Y * 0.5
    local minX = -viewport.X * 0.5 + halfW + 4
    local maxX = viewport.X * 0.5 - halfW - 4
    local minY = -viewport.Y * 0.5 + halfH + 4
    local maxY = viewport.Y * 0.5 - halfH - 4
    local ox = math.clamp(startPos.X.Offset + delta.X, minX, maxX)
    local oy = math.clamp(startPos.Y.Offset + delta.Y, minY, maxY)
    local newPos = UDim2.new(0.5, ox, 0.5, oy)
    main.Position = newPos
    shadow.Position = newPos
    updateFloatingControls()
end

local function endDrag(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1
    and input.UserInputType ~= Enum.UserInputType.Touch then return end
    dragging = false
    if dragSource == dragHandle then
        tween(dragVisual, TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(72, 3)
        })
    end
    dragSource = nil
end

dragHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        beginDrag(input, dragHandle)
    end
end)

local resizeDragging = false
local resizeStartInput
local resizeStartSize

resizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizeDragging = true
        AkiraPlayClick()
        resizeStartInput = input.Position
        resizeStartSize = main.Size
    end
end)

local function updateResize(input)
    if not resizeDragging then return end
    local delta = input.Position - resizeStartInput
    local camera = workspace.CurrentCamera
    local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
    local centerX = main.AbsolutePosition.X + main.AbsoluteSize.X * 0.5
    local centerY = main.AbsolutePosition.Y + main.AbsoluteSize.Y * 0.5
    local maxW = math.max(300, math.min(540, 2 * math.min(centerX - 8, viewport.X - centerX - 8)))
    local maxH = math.max(230, math.min(430, 2 * math.min(centerY - 8, viewport.Y - centerY - 8)))
    local w = math.clamp(resizeStartSize.X.Offset + delta.X * 2, 300, maxW)
    local h = math.clamp(resizeStartSize.Y.Offset + delta.Y * 2, 230, maxH)
    main.Size = UDim2.fromOffset(w, h)
    shadow.Size = UDim2.fromOffset(w, h)
    updateFloatingControls()
end

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        updateDrag(input)
        updateResize(input)
    end
end)

UIS.InputEnded:Connect(function(input)
    endDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizeDragging = false
    end
end)

-- ============================================================
-- PREMIUM VIP FLOATING LOGO BUTTON
-- ============================================================
local LOGO_IMAGE_ID = "rbxassetid://97330468088484"

local openButton = Instance.new("ImageButton")
openButton.Name = "OpenAkiraLogo"
openButton.AnchorPoint = Vector2.new(1, 0.5)
openButton.Position = UDim2.new(1, -18, 0.5, 0)
openButton.Size = UDim2.fromOffset(60, 60)
openButton.BackgroundColor3 = Colors.Background
openButton.BackgroundTransparency = 0.1
openButton.BorderSizePixel = 0
openButton.Image = LOGO_IMAGE_ID
openButton.AutoButtonColor = false
openButton.Visible = false
openButton.ZIndex = 85
openButton.Parent = gui

local oc = Instance.new("UICorner")
oc.CornerRadius = UDim.new(1, 0)
oc.Parent = openButton

local openStroke = Instance.new("UIStroke")
openStroke.Thickness = 2.4
openStroke.Color = Colors.Accent
openStroke.Transparency = 0.15
openStroke.Parent = openButton

task.spawn(function()
    while gui.Parent and openButton.Parent do
        local t1 = tween(openStroke, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Colors.Accent,
            Transparency = 0.1
        })
        t1.Completed:Wait()
        local t2 = tween(openStroke, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Colors.AccentGlow,
            Transparency = 0.45
        })
        t2.Completed:Wait()
    end
end)

local mainScale = Instance.new("UIScale")
mainScale.Scale = 1
mainScale.Parent = main

local shadowScale = Instance.new("UIScale")
shadowScale.Scale = 1
shadowScale.Parent = shadow

local function closeGui()
    if not main.Visible then return end
    local outInfo = TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    local savedPos = main.Position
    local exitPos = UDim2.new(savedPos.X.Scale, savedPos.X.Offset - 35, savedPos.Y.Scale, savedPos.Y.Offset)
    
    tween(mainScale, outInfo, {Scale = 0.92})
    tween(shadowScale, outInfo, {Scale = 0.92})
    tween(main, outInfo, {BackgroundTransparency = 1, Position = exitPos})
    tween(shadow, outInfo, {BackgroundTransparency = 1, Position = exitPos})
    task.wait(0.3)
    main.Visible = false
    shadow.Visible = false
    dragHandle.Visible = false
    resizeHandle.Visible = false
    main.BackgroundTransparency = 0
    shadow.BackgroundTransparency = 0.4
    main.Position = savedPos
    shadow.Position = savedPos
    mainScale.Scale = 1
    shadowScale.Scale = 1
    updateFloatingControls()
    openButton.Visible = true
    tween(openButton, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(60, 60)})
end

local function openGui()
    openButton.Visible = false
    main.Visible = true
    shadow.Visible = true
    mainScale.Scale = 0.8
    shadowScale.Scale = 0.8
    dragHandle.Visible = true
    resizeHandle.Visible = true
    updateFloatingControls()
    tween(mainScale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
    tween(shadowScale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
end

local minimized = false
local savedSize = main.Size

close.Activated:Connect(function() AkiraPlayClick(); closeGui() end)

local akDragging = false
local akDragStart
local akStartPos

openButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        akDragging = true
        akDragStart = input.Position
        akStartPos = openButton.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if akDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - akDragStart
        openButton.Position = UDim2.new(akStartPos.X.Scale, akStartPos.X.Offset + d.X, akStartPos.Y.Scale, akStartPos.Y.Offset + d.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        akDragging = false
    end
end)

openButton.Activated:Connect(function()
    AkiraPlayClick()
    if minimized then
        minimized = false
        openButton.Visible = false
        main.Visible = true
        shadow.Visible = true
        sidebar.Visible = true
        content.Visible = true
        resizeHandle.Visible = true
        dragHandle.Visible = true
        mainScale.Scale = 0.8
        shadowScale.Scale = 0.8
        tween(main, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(shadow, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(mainScale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        tween(shadowScale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        task.delay(0.29, updateFloatingControls)
    else
        openGui()
    end
end)

RunService.RenderStepped:Connect(function()
    if gui.Parent and (main.Visible or dragHandle.Visible or resizeHandle.Visible) then
        updateFloatingControls()
    end
end)

minimize.Activated:Connect(function()
    AkiraPlayClick()
    if minimized then
        minimized = false
        openButton.Visible = false
        main.Visible = true
        shadow.Visible = true
        sidebar.Visible = true
        content.Visible = true
        resizeHandle.Visible = true
        dragHandle.Visible = true
        mainScale.Scale = 0.8
        shadowScale.Scale = 0.8
        tween(main, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(shadow, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(mainScale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        tween(shadowScale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        task.delay(0.29, updateFloatingControls)
    else
        minimized = true
        savedSize = main.Size
        sidebar.Visible = false
        content.Visible = false
        resizeHandle.Visible = false
        dragHandle.Visible = false
        local miniInfo = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        tween(mainScale, miniInfo, {Scale = 0.8})
        tween(shadowScale, miniInfo, {Scale = 0.8})
        tween(main, miniInfo, {BackgroundTransparency = 1, Size = UDim2.fromOffset(1, 1)})
        tween(shadow, miniInfo, {BackgroundTransparency = 1, Size = UDim2.fromOffset(1, 1)})
        task.wait(0.23)
        main.Visible = false
        shadow.Visible = false
        main.Size = savedSize
        shadow.Size = savedSize
        mainScale.Scale = 1
        shadowScale.Scale = 1
        openButton.Visible = true
        openButton.Size = UDim2.fromOffset(8, 8)
        tween(openButton, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(60, 60)})
    end
end)

refreshTabs()

-- ======================================================
-- PREMIUM VIP INTRO ANIMATION
-- ======================================================
main.Visible = false
shadow.Visible = false
dragHandle.Visible = false
resizeHandle.Visible = false

local intro = Instance.new("Frame")
intro.Name = "AkiraIntro"
intro.Size = UDim2.fromScale(1, 1)
intro.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
intro.BackgroundTransparency = 0.15
intro.BorderSizePixel = 0
intro.ZIndex = 100
intro.Parent = gui

local introCard = Instance.new("Frame")
introCard.AnchorPoint = Vector2.new(0.5, 0.5)
introCard.Position = UDim2.fromScale(0.5, 0.5)
introCard.Size = UDim2.fromOffset(250, 145)
introCard.BackgroundColor3 = Colors.Background
introCard.BorderSizePixel = 0
introCard.ZIndex = 101
introCard.Parent = intro

local introCorner = Instance.new("UICorner")
introCorner.CornerRadius = UDim.new(0, 16)
introCorner.Parent = introCard

local introStroke = Instance.new("UIStroke")
introStroke.Thickness = 1.4
introStroke.Color = Colors.Accent
introStroke.Parent = introCard

local introTitle = Instance.new("TextLabel")
introTitle.BackgroundTransparency = 1
introTitle.Size = UDim2.new(1, -20, 0, 36)
introTitle.Position = UDim2.fromOffset(10, 26)
introTitle.Font = Enum.Font.GothamBold
introTitle.Text = "AKIRA VIP"
introTitle.TextSize = 30
introTitle.TextColor3 = Colors.TextActive
introTitle.ZIndex = 102
introTitle.Parent = introCard

local introStatus = Instance.new("TextLabel")
introStatus.BackgroundTransparency = 1
introStatus.Size = UDim2.new(1, -30, 0, 16)
introStatus.Position = UDim2.fromOffset(15, 76)
introStatus.Font = Enum.Font.GothamMedium
introStatus.Text = "EXECUTIVE SUITE • កំពុងដំណើរការ..."
introStatus.TextSize = 10
introStatus.TextColor3 = Colors.Accent
introStatus.ZIndex = 102
introStatus.Parent = introCard

local introBar = Instance.new("Frame")
introBar.Size = UDim2.new(0.75, 0, 0, 4)
introBar.Position = UDim2.new(0.125, 0, 1, -26)
introBar.BackgroundColor3 = Color3.fromRGB(26, 32, 44)
introBar.BorderSizePixel = 0
introBar.ZIndex = 102
introBar.Parent = introCard

local ibc = Instance.new("UICorner")
ibc.CornerRadius = UDim.new(1, 0)
ibc.Parent = introBar

local introFill = Instance.new("Frame")
introFill.Size = UDim2.new(0, 0, 1, 0)
introFill.BackgroundColor3 = Colors.Accent
introFill.BorderSizePixel = 0
introFill.ZIndex = 103
introFill.Parent = introBar

local ifc = Instance.new("UICorner")
ifc.CornerRadius = UDim.new(1, 0)
ifc.Parent = introFill

local introScale = Instance.new("UIScale")
introScale.Scale = 0.85
introScale.Parent = introCard

introCard.BackgroundTransparency = 1
introTitle.TextTransparency = 1
introStatus.TextTransparency = 1
introBar.BackgroundTransparency = 1
introFill.BackgroundTransparency = 1

tween(introScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
tween(introCard, TweenInfo.new(0.26), {BackgroundTransparency = 0.05})
tween(introTitle, TweenInfo.new(0.24), {TextTransparency = 0})
tween(introStatus, TweenInfo.new(0.24), {TextTransparency = 0})
tween(introBar, TweenInfo.new(0.24), {BackgroundTransparency = 0})
tween(introFill, TweenInfo.new(0.24), {BackgroundTransparency = 0})
tween(introFill, TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(1, 0, 1, 0)})

task.wait(2.5)
introStatus.Text = "AKIRA VIP • ត្រៀមរួចរាល់"
task.wait(0.7)

main.Visible = true
shadow.Visible = true
AkiraPlayClick(1.35, 0.24)
mainScale.Scale = 0.8
shadowScale.Scale = 0.8
main.BackgroundTransparency = 0
shadow.BackgroundTransparency = 0.4
local handoff = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
tween(mainScale, handoff, {Scale = 1})
tween(shadowScale, handoff, {Scale = 1})

task.spawn(function()
    task.wait(0.05)
    tween(introScale, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Scale = 0.9})
    tween(intro, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1})
    tween(introCard, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1})
    tween(introTitle, TweenInfo.new(0.2), {TextTransparency = 1})
    tween(introStatus, TweenInfo.new(0.2), {TextTransparency = 1})
    task.wait(0.36)
    intro:Destroy()
    updateFloatingControls()
    dragHandle.Visible = true
    resizeHandle.Visible = true
end)
