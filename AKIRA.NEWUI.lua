--[[
    AKIRA SCRIPT HUB • RAYFIELD / LINORIA EDITION
    - Modern Dark Sleek Cards (#13151B)
    - Pill-shaped Animated Toggle Switch
    - Smooth UI Transitions & Mobile Touch Dragging
    - Floating Cambodia Akira Logo Button
    - Khmer Language Support
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

-- ScreenGui Setup
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
    UDim2.fromOffset(330, 260),
    UDim2.fromOffset(380, 295),
    UDim2.fromOffset(430, 335),
}
local SizeIndex = 2

-- Rayfield Glow Shadow
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.fromScale(0.5, 0.51)
shadow.Size = Sizes[SizeIndex]
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.45
shadow.BorderSizePixel = 0
shadow.Parent = gui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 14)
shadowCorner.Parent = shadow

-- Main Window (Rayfield Frame)
local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.48)
main.Size = Sizes[SizeIndex]
main.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 1.2
mainStroke.Color = Color3.fromRGB(42, 47, 63)
mainStroke.Parent = main

-- Top Navigation Header
local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 48)
top.BackgroundColor3 = Color3.fromRGB(22, 25, 35)
top.BorderSizePixel = 0
top.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 14)
topCorner.Parent = top

local topDivider = Instance.new("Frame")
topDivider.Size = UDim2.new(1, 0, 0, 1)
topDivider.Position = UDim2.new(0, 0, 1, -1)
topDivider.BackgroundColor3 = Color3.fromRGB(36, 41, 56)
topDivider.BorderSizePixel = 0
topDivider.Parent = top

-- Hub Brand Title
local titleContainer = Instance.new("Frame")
titleContainer.BackgroundTransparency = 1
titleContainer.Position = UDim2.fromOffset(14, 0)
titleContainer.Size = UDim2.new(0.65, 0, 1, 0)
titleContainer.Parent = top

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(0, 8)
title.Size = UDim2.new(1, 0, 0, 18)
title.Font = Enum.Font.GothamBold
title.Text = "AKIRA SCRIPT"
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = titleContainer

local badge = Instance.new("TextLabel")
badge.BackgroundTransparency = 1
badge.Position = UDim2.fromOffset(0, 26)
badge.Size = UDim2.new(1, 0, 0, 14)
badge.Font = Enum.Font.GothamMedium
badge.Text = "Rayfield UI • កំណែខ្មែរ"
badge.TextSize = 10
badge.TextXAlignment = Enum.TextXAlignment.Left
badge.TextColor3 = Color3.fromRGB(0, 175, 255)
badge.Parent = titleContainer

-- Top Actions (Minimize / Close)
local function makeTopBtn(symbol, xOffset)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(26, 26)
    b.Position = UDim2.new(1, xOffset, 0.5, 0)
    b.AnchorPoint = Vector2.new(1, 0.5)
    b.BackgroundColor3 = Color3.fromRGB(28, 32, 45)
    b.BorderSizePixel = 0
    b.Text = symbol
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.TextColor3 = Color3.fromRGB(170, 175, 195)
    b.AutoButtonColor = false
    b.Parent = top
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = b
    b.MouseEnter:Connect(function() b.TextColor3 = Color3.new(1, 1, 1) end)
    b.MouseLeave:Connect(function() b.TextColor3 = Color3.fromRGB(170, 175, 195) end)
    return b
end

local minimize = makeTopBtn("—", -44)
local close = makeTopBtn("×", -10)

-- Sidebar Tabs (Rayfield Style)
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.fromOffset(8, 54)
sidebar.Size = UDim2.new(0, 105, 1, -62)
sidebar.BackgroundColor3 = Color3.fromRGB(21, 24, 34)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 10)
sideCorner.Parent = sidebar

local sideStroke = Instance.new("UIStroke")
sideStroke.Thickness = 1
sideStroke.Color = Color3.fromRGB(33, 38, 53)
sideStroke.Parent = sidebar

-- Content Area
local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 120, 0, 54)
content.Size = UDim2.new(1, -128, 1, -62)
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
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 175, 255)
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
    b.BackgroundColor3 = Color3.fromRGB(21, 24, 34)
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.Parent = sidebar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b

    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(0, 3, 0.6, 0)
    indicator.Position = UDim2.new(0, 4, 0.2, 0)
    indicator.BackgroundColor3 = Color3.fromRGB(0, 175, 255)
    indicator.BorderSizePixel = 0
    indicator.Visible = false
    indicator.Parent = b

    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(1, 0)
    indCorner.Parent = indicator

    local label = Instance.new("TextLabel")
    label.Name = "TabLabel"
    label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1)
    label.Position = UDim2.fromOffset(14, 0)
    label.Text = icon .. "  " .. text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextColor3 = Color3.fromRGB(150, 155, 175)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = b

    tabButtons[text] = {Button = b, Label = label, Indicator = indicator}
    return b
end

local scriptsTab = makeTab("ស្គ្រីប", "🛡", UDim2.fromOffset(6, 8))
local configTab = makeTab("ការកំណត់", "⚙", UDim2.new(0, 6, 1, -44))

local function refreshTabs()
    for name, data in pairs(tabButtons) do
        local isSelected = (name == currentTab)
        if isSelected then
            data.Button.BackgroundColor3 = Color3.fromRGB(28, 33, 46)
            data.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            data.Indicator.Visible = true
        else
            data.Button.BackgroundColor3 = Color3.fromRGB(21, 24, 34)
            data.Label.TextColor3 = Color3.fromRGB(150, 155, 175)
            data.Indicator.Visible = false
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

-- Floating Drag Line
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
dragVisual.Size = UDim2.fromOffset(70, 3)
dragVisual.BackgroundColor3 = Color3.fromRGB(0, 175, 255)
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
resizeHandle.TextColor3 = Color3.fromRGB(0, 175, 255)
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
-- RAYFIELD MODERN TOGGLE: ANTI-HIT
-- ============================================================
local AntiHitEnabled = false
local IsAntiHitRunning = false
local ANTI_HIT_SPEED = 0.016

local antiHitCard = Instance.new("Frame")
antiHitCard.Name = "AntiHitCard"
antiHitCard.Size = UDim2.new(1, -6, 0, 52)
antiHitCard.BackgroundColor3 = Color3.fromRGB(22, 26, 36)
antiHitCard.BorderSizePixel = 0
antiHitCard.Parent = scriptsPage

local cardCorner = Instance.new("UICorner")
cardCorner.CornerRadius = UDim.new(0, 9)
cardCorner.Parent = antiHitCard

local cardStroke = Instance.new("UIStroke")
cardStroke.Thickness = 1
cardStroke.Color = Color3.fromRGB(36, 42, 58)
cardStroke.Parent = antiHitCard

local cardTitle = Instance.new("TextLabel")
cardTitle.BackgroundTransparency = 1
cardTitle.Position = UDim2.fromOffset(12, 8)
cardTitle.Size = UDim2.new(1, -70, 0, 18)
cardTitle.Font = Enum.Font.GothamBold
cardTitle.Text = "ការពារការវាយ (Anti-Hit)"
cardTitle.TextSize = 13
cardTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
cardTitle.TextXAlignment = Enum.TextXAlignment.Left
cardTitle.Parent = antiHitCard

local cardDesc = Instance.new("TextLabel")
cardDesc.BackgroundTransparency = 1
cardDesc.Position = UDim2.fromOffset(12, 26)
cardDesc.Size = UDim2.new(1, -70, 0, 14)
cardDesc.Font = Enum.Font.GothamMedium
cardDesc.Text = "ទប់ស្កាត់ការវាយដោយស្វ័យប្រវត្ត"
cardDesc.TextSize = 10
cardDesc.TextColor3 = Color3.fromRGB(140, 145, 165)
cardDesc.TextXAlignment = Enum.TextXAlignment.Left
cardDesc.Parent = antiHitCard

-- Rayfield Pill Toggle Switch
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.fromOffset(42, 22)
toggleButton.Position = UDim2.new(1, -12, 0.5, 0)
toggleButton.AnchorPoint = Vector2.new(1, 0.5)
toggleButton.BackgroundColor3 = Color3.fromRGB(34, 39, 54)
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
toggleKnob.BackgroundColor3 = Color3.fromRGB(180, 185, 205)
toggleKnob.BorderSizePixel = 0
toggleKnob.Parent = toggleButton

local kCorner = Instance.new("UICorner")
kCorner.CornerRadius = UDim.new(1, 0)
kCorner.Parent = toggleKnob

local function setAntiHitVisual(enabled)
    if enabled then
        tween(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(0, 175, 255)})
        tween(toggleKnob, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -19, 0.5, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        })
        cardStroke.Color = Color3.fromRGB(0, 175, 255)
    else
        tween(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(34, 39, 54)})
        tween(toggleKnob, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
            Position = UDim2.new(0, 3, 0.5, 0),
            BackgroundColor3 = Color3.fromRGB(180, 185, 205)
        })
        cardStroke.Color = Color3.fromRGB(36, 42, 58)
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
-- CONFIG TAB (RAYFIELD CARDS)
-- ============================================================
local function makeHeader(text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -6, 0, 20)
    l.BackgroundTransparency = 1
    l.Text = text:upper()
    l.Font = Enum.Font.GothamBold
    l.TextSize = 10
    l.TextColor3 = Color3.fromRGB(0, 175, 255)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = configPage
    return l
end

makeHeader("ទំហំផ្ទាំង (GUI Size)")

local sizeRow = Instance.new("Frame")
sizeRow.Size = UDim2.new(1, -6, 0, 36)
sizeRow.BackgroundColor3 = Color3.fromRGB(22, 26, 36)
sizeRow.BorderSizePixel = 0
sizeRow.Parent = configPage

local sCorner = Instance.new("UICorner")
sCorner.CornerRadius = UDim.new(0, 8)
sCorner.Parent = sizeRow

local sStroke = Instance.new("UIStroke")
sStroke.Thickness = 1
sStroke.Color = Color3.fromRGB(36, 42, 58)
sStroke.Parent = sizeRow

local sizeMinus = Instance.new("TextButton")
sizeMinus.Size = UDim2.new(0.3, 0, 1, 0)
sizeMinus.BackgroundTransparency = 1
sizeMinus.Text = "−"
sizeMinus.Font = Enum.Font.GothamBold
sizeMinus.TextSize = 14
sizeMinus.TextColor3 = Color3.new(1, 1, 1)
sizeMinus.Parent = sizeRow

local sizeText = Instance.new("TextLabel")
sizeText.Size = UDim2.new(0.4, 0, 1, 0)
sizeText.Position = UDim2.new(0.3, 0, 0, 0)
sizeText.BackgroundTransparency = 1
sizeText.Text = "មធ្យម"
sizeText.Font = Enum.Font.GothamMedium
sizeText.TextSize = 11
sizeText.TextColor3 = Color3.fromRGB(0, 175, 255)
sizeText.Parent = sizeRow

local sizePlus = Instance.new("TextButton")
sizePlus.Size = UDim2.new(0.3, 0, 1, 0)
sizePlus.Position = UDim2.new(0.7, 0, 0, 0)
sizePlus.BackgroundTransparency = 1
sizePlus.Text = "+"
sizePlus.Font = Enum.Font.GothamBold
sizePlus.TextSize = 14
sizePlus.TextColor3 = Color3.new(1, 1, 1)
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

makeHeader("ការគ្រប់គ្រង (Window)")

local infoCard = Instance.new("Frame")
infoCard.Size = UDim2.new(1, -6, 0, 42)
infoCard.BackgroundColor3 = Color3.fromRGB(22, 26, 36)
infoCard.BorderSizePixel = 0
infoCard.Parent = configPage

local iCorner = Instance.new("UICorner")
iCorner.CornerRadius = UDim.new(0, 8)
iCorner.Parent = infoCard

local iLabel = Instance.new("TextLabel")
iLabel.Size = UDim2.new(1, -16, 1, 0)
iLabel.Position = UDim2.fromOffset(8, 0)
iLabel.BackgroundTransparency = 1
iLabel.Text = "បិទ ឬ បើកផ្ទាំង៖ ចុច × ឬ ចុចលើរូប Logo"
iLabel.Font = Enum.Font.GothamMedium
iLabel.TextSize = 11
iLabel.TextColor3 = Color3.fromRGB(150, 155, 175)
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
            Size = UDim2.fromOffset(70, 3)
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
-- RAYFIELD FLOATING LOGO BUTTON
-- ============================================================
local LOGO_IMAGE_ID = "rbxassetid://97330468088484"

local openButton = Instance.new("ImageButton")
openButton.Name = "OpenAkiraLogo"
openButton.AnchorPoint = Vector2.new(1, 0.5)
openButton.Position = UDim2.new(1, -18, 0.5, 0)
openButton.Size = UDim2.fromOffset(60, 60)
openButton.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
openButton.BackgroundTransparency = 0.15
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
openStroke.Thickness = 2.5
openStroke.Color = Color3.fromRGB(0, 175, 255)
openStroke.Transparency = 0.2
openStroke.Parent = openButton

task.spawn(function()
    while gui.Parent and openButton.Parent do
        local t1 = tween(openStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Color3.fromRGB(0, 175, 255),
            Transparency = 0.1
        })
        t1.Completed:Wait()
        local t2 = tween(openStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Color3.fromRGB(255, 255, 255),
            Transparency = 0.4
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
    shadow.BackgroundTransparency = 0.45
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
-- RAYFIELD INTRO ANIMATION
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
introCard.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
introCard.BorderSizePixel = 0
introCard.ZIndex = 101
introCard.Parent = intro

local introCorner = Instance.new("UICorner")
introCorner.CornerRadius = UDim.new(0, 14)
introCorner.Parent = introCard

local introStroke = Instance.new("UIStroke")
introStroke.Thickness = 1.5
introStroke.Color = Color3.fromRGB(0, 175, 255)
introStroke.Parent = introCard

local introTitle = Instance.new("TextLabel")
introTitle.BackgroundTransparency = 1
introTitle.Size = UDim2.new(1, -20, 0, 36)
introTitle.Position = UDim2.fromOffset(10, 26)
introTitle.Font = Enum.Font.GothamBold
introTitle.Text = "AKIRA"
introTitle.TextSize = 32
introTitle.TextColor3 = Color3.new(1, 1, 1)
introTitle.ZIndex = 102
introTitle.Parent = introCard

local introStatus = Instance.new("TextLabel")
introStatus.BackgroundTransparency = 1
introStatus.Size = UDim2.new(1, -30, 0, 16)
introStatus.Position = UDim2.fromOffset(15, 76)
introStatus.Font = Enum.Font.GothamMedium
introStatus.Text = "RAYFIELD UI • កំពុងដំណើរការ..."
introStatus.TextSize = 10
introStatus.TextColor3 = Color3.fromRGB(0, 175, 255)
introStatus.ZIndex = 102
introStatus.Parent = introCard

local introBar = Instance.new("Frame")
introBar.Size = UDim2.new(0.75, 0, 0, 4)
introBar.Position = UDim2.new(0.125, 0, 1, -26)
introBar.BackgroundColor3 = Color3.fromRGB(30, 35, 48)
introBar.BorderSizePixel = 0
introBar.ZIndex = 102
introBar.Parent = introCard

local ibc = Instance.new("UICorner")
ibc.CornerRadius = UDim.new(1, 0)
ibc.Parent = introBar

local introFill = Instance.new("Frame")
introFill.Size = UDim2.new(0, 0, 1, 0)
introFill.BackgroundColor3 = Color3.fromRGB(0, 175, 255)
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
introStatus.Text = "AKIRA SCRIPT • រួចរាល់"
task.wait(0.7)

main.Visible = true
shadow.Visible = true
AkiraPlayClick(1.35, 0.24)
mainScale.Scale = 0.8
shadowScale.Scale = 0.8
main.BackgroundTransparency = 0
shadow.BackgroundTransparency = 0.45
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
