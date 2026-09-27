--[[
    AKIRA SCRIPT HUB • MOBILE EDITION
    Features:
    - Small mobile-friendly GUI
    - Anti-Hit system with proximity prompt trigger
    - Config tab (GUI Size, Custom Themes)
    - Touch & Mouse dragging (Dedicated drag bar)
    - Touch & Mouse resize handle (↘)
    - Smooth Tween Animations & Single-sound triggers
    - Mobile Executor Safeguards (gethui / protect_gui)
    - Floating Logo Button with Cambodia Akira Design
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
AkiraClickSound.Volume = 0.30
AkiraClickSound.Parent = AkiraSoundFolder

local function AkiraPlayClick(speed, volume)
    pcall(function()
        AkiraClickSound:Stop()
        AkiraClickSound.TimePosition = 0
        AkiraClickSound.PlaybackSpeed = speed or 1
        AkiraClickSound.Volume = volume or 0.30
        AkiraClickSound:Play()
    end)
end

local function AkiraPlayExecute()
    AkiraPlayClick(1.18, 0.34)
end

local old = GuiParent:FindFirstChild("AkiraScriptHub")
if old then
    old:Destroy()
end

local Themes = {
    {Name = "Akira Red", Main = Color3.fromRGB(8, 16, 30), Panel = Color3.fromRGB(13, 27, 46), Accent = Color3.fromRGB(255, 72, 72), ButtonDark = Color3.fromRGB(95, 8, 18)},
    {Name = "Akira Purple", Main = Color3.fromRGB(18, 17, 25), Panel = Color3.fromRGB(27, 24, 36), Accent = Color3.fromRGB(160, 100, 255), ButtonDark = Color3.fromRGB(72, 35, 120)},
    {Name = "Akira Blue", Main = Color3.fromRGB(15, 19, 26), Panel = Color3.fromRGB(23, 29, 40), Accent = Color3.fromRGB(75, 145, 255), ButtonDark = Color3.fromRGB(18, 55, 105)},
    {Name = "Akira Gold", Main = Color3.fromRGB(22, 20, 16), Panel = Color3.fromRGB(31, 28, 21), Accent = Color3.fromRGB(255, 190, 65), ButtonDark = Color3.fromRGB(105, 72, 12)},
    {Name = "Akira Green", Main = Color3.fromRGB(15, 22, 19), Panel = Color3.fromRGB(22, 32, 27), Accent = Color3.fromRGB(75, 220, 135), ButtonDark = Color3.fromRGB(18, 92, 55)},
}

local ThemeIndex = 1
local SizeIndex = 2
local Sizes = {
    UDim2.fromOffset(320, 250),
    UDim2.fromOffset(360, 285),
    UDim2.fromOffset(410, 325),
}

local function tween(obj, info, props)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

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

local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.fromScale(0.5, 0.52)
shadow.Size = Sizes[SizeIndex]
shadow.BackgroundColor3 = Color3.new(0,0,0)
shadow.BackgroundTransparency = 0.45
shadow.BorderSizePixel = 0
shadow.Parent = gui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 16)
shadowCorner.Parent = shadow

local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.48)
main.Size = Sizes[SizeIndex]
main.BackgroundColor3 = Color3.fromRGB(8, 16, 30)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0,0,0)
stroke.Transparency = 0.05
stroke.Parent = main

local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 55)
top.BackgroundTransparency = 1
top.Parent = main

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(74, 3)
title.Size = UDim2.new(1, -148, 0, 28)
title.Font = Enum.Font.FredokaOne
title.Text = "AKIRA SCRIPT"
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextColor3 = Color3.new(1,1,1)
title.Parent = top

local titleGradient = Instance.new("UIGradient")
titleGradient.Rotation = 0
titleGradient.Offset = Vector2.new(1.2, 0)
titleGradient.Parent = title

local AkiraRed = Color3.fromRGB(255, 72, 72)
local AkiraWhite = Color3.fromRGB(255, 255, 255)

titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, AkiraRed),
    ColorSequenceKeypoint.new(0.18, AkiraRed),
    ColorSequenceKeypoint.new(0.34, AkiraWhite),
    ColorSequenceKeypoint.new(0.50, AkiraRed),
    ColorSequenceKeypoint.new(0.66, AkiraRed),
    ColorSequenceKeypoint.new(0.82, AkiraWhite),
    ColorSequenceKeypoint.new(1.00, AkiraRed)
})

task.spawn(function()
    while gui.Parent and title.Parent do
        titleGradient.Offset = Vector2.new(1.2, 0)
        local t = tween(titleGradient, TweenInfo.new(1.15, Enum.EasingStyle.Linear), {
            Offset = Vector2.new(-1.2, 0)
        })
        t.Completed:Wait()
    end
end)

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 58, 0, 29)
subtitle.Size = UDim2.new(1, -116, 0, 16)
subtitle.Font = Enum.Font.FredokaOne
subtitle.Text = "MOBILE HUB"
subtitle.TextSize = 10
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.TextColor3 = Color3.fromRGB(145,145,155)
subtitle.Parent = top

local function topButton(text, x)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(30, 28)
    b.Position = UDim2.new(1, x, 0, 8)
    b.AnchorPoint = Vector2.new(1, 0)
    b.BackgroundColor3 = Color3.fromRGB(13, 27, 46)
    b.BorderSizePixel = 0
    b.Text = text
    b.Font = Enum.Font.FredokaOne
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.AutoButtonColor = false
    b.Parent = top
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b
    return b
end

local minimize = topButton("—", -52)
local close = topButton("×", -8)

-- Floating Drag Line
local dragHandle = Instance.new("TextButton")
dragHandle.Name = "AkiraDragHandle"
dragHandle.AnchorPoint = Vector2.new(0.5, 0.5)
dragHandle.Size = UDim2.fromOffset(110, 16)
dragHandle.BackgroundColor3 = Color3.fromRGB(235, 235, 240)
dragHandle.BackgroundTransparency = 1
dragHandle.BorderSizePixel = 0
dragHandle.Text = ""
dragHandle.AutoButtonColor = false
dragHandle.ZIndex = 60
dragHandle.Visible = false
dragHandle.Parent = gui

local dragVisual = Instance.new("Frame")
dragVisual.Name = "Line"
dragVisual.AnchorPoint = Vector2.new(0.5, 0.5)
dragVisual.Position = UDim2.fromScale(0.5, 0.5)
dragVisual.Size = UDim2.fromOffset(76, 3)
dragVisual.BackgroundColor3 = Themes[ThemeIndex].Accent
dragVisual.BackgroundTransparency = 0.10
dragVisual.BorderSizePixel = 0
dragVisual.ZIndex = 61
dragVisual.Parent = dragHandle
local dragVisualCorner = Instance.new("UICorner")
dragVisualCorner.CornerRadius = UDim.new(1, 0)
dragVisualCorner.Parent = dragVisual

-- Resize Handle
local resizeHandle = Instance.new("TextButton")
resizeHandle.Name = "AkiraResizeHandle"
resizeHandle.AnchorPoint = Vector2.new(0.5, 0.5)
resizeHandle.Size = UDim2.fromOffset(30, 30)
resizeHandle.BackgroundTransparency = 1
resizeHandle.BorderSizePixel = 0
resizeHandle.Text = "↘"
resizeHandle.Font = Enum.Font.GothamBlack
resizeHandle.TextSize = 18
resizeHandle.TextColor3 = Themes[ThemeIndex].Accent
resizeHandle.AutoButtonColor = false
resizeHandle.ZIndex = 70
resizeHandle.Visible = false
resizeHandle.Parent = gui

local resizeDragging = false
local resizeStartInput
local resizeStartSize

task.spawn(function()
    while gui.Parent and main.Parent do
        stroke.Color = Color3.fromRGB(0,0,0)
        stroke.Transparency = 0.05
        local toWhite = tween(stroke, TweenInfo.new(0.85, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Color3.fromRGB(255,255,255)
        })
        toWhite.Completed:Wait()
        local toBlack = tween(stroke, TweenInfo.new(0.85, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Color3.fromRGB(0,0,0)
        })
        toBlack.Completed:Wait()
    end
end)

local function updateFloatingControls()
    local x = main.Position.X.Scale
    local ox = main.Position.X.Offset
    local y = main.Position.Y.Scale
    local oy = main.Position.Y.Offset
    local halfW = main.AbsoluteSize.X * 0.5
    local halfH = main.AbsoluteSize.Y * 0.5
    dragHandle.Position = UDim2.new(x, ox, y, oy + halfH + 12)
    resizeHandle.Position = UDim2.new(x, ox + halfW + 15, y, oy + halfH + 15)
end

local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.fromOffset(8, 61)
sidebar.Size = UDim2.new(0, 98, 1, -69)
sidebar.BackgroundColor3 = Color3.fromRGB(13, 27, 46)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 12)
sideCorner.Parent = sidebar

local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 114, 0, 61)
content.Size = UDim2.new(1, -122, 1, -69)
content.BackgroundTransparency = 1
content.Parent = main

local currentTab = "Scripts"
local pages = {}

local function makePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.fromScale(1,1)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Themes[ThemeIndex].Accent
    page.CanvasSize = UDim2.new()
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.Visible = (name == "Scripts")
    page.Parent = content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 7)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    local pad = Instance.new("UIPadding")
    pad.PaddingRight = UDim.new(0, 4)
    pad.PaddingBottom = UDim.new(0, 8)
    pad.Parent = page

    pages[name] = page
    return page
end

local scriptsPage = makePage("Scripts")
local configPage = makePage("Config")

local tabButtons = {}
local tabSweepTokens = {}

local function makeTab(text, icon)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -12, 0, 39)
    b.BackgroundColor3 = Themes[ThemeIndex].Panel
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.Parent = sidebar
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 9)
    c.Parent = b

    local sweepBg = Instance.new("Frame")
    sweepBg.Name = "SelectedSweep"
    sweepBg.Size = UDim2.fromScale(1, 1)
    sweepBg.BackgroundColor3 = Color3.fromRGB(8, 16, 30)
    sweepBg.BorderSizePixel = 0
    sweepBg.Visible = false
    sweepBg.ZIndex = b.ZIndex + 1
    sweepBg.Parent = b
    local sweepCorner = Instance.new("UICorner")
    sweepCorner.CornerRadius = UDim.new(0, 9)
    sweepCorner.Parent = sweepBg
    local sweep = Instance.new("UIGradient")
    sweep.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Themes[ThemeIndex].Accent),
        ColorSequenceKeypoint.new(0.40, Themes[ThemeIndex].Accent),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.60, Themes[ThemeIndex].Accent),
        ColorSequenceKeypoint.new(1.00, Themes[ThemeIndex].Accent)
    })
    sweepBg.BackgroundColor3 = Themes[ThemeIndex].Accent
    sweep.Rotation = 0
    sweep.Offset = Vector2.new(1.15, 0)
    sweep.Parent = sweepBg

    local label = Instance.new("TextLabel")
    label.Name = "TabLabel"
    label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1)
    label.Text = icon .. "  " .. text
    label.Font = Enum.Font.FredokaOne
    label.TextSize = 11
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Position = UDim2.fromOffset(10, 0)
    label.ZIndex = b.ZIndex + 2
    label.Parent = b

    tabButtons[text] = b
    return b
end

local scriptsTab = makeTab("Scripts", "🛡")
local configTab = makeTab("Config", "⚙")
scriptsTab.Position = UDim2.fromOffset(6, 9)
configTab.Position = UDim2.new(0, 6, 1, -52)

local function refreshTabs()
    for name, b in pairs(tabButtons) do
        local selected = (name == currentTab)
        local sweepBg = b:FindFirstChild("SelectedSweep")
        local sweep = sweepBg and sweepBg:FindFirstChildOfClass("UIGradient")
        local tabLabel = b:FindFirstChild("TabLabel")
        if selected then
            b.BackgroundColor3 = Themes[ThemeIndex].Panel
            if sweepBg then sweepBg.Visible = true end
            if tabLabel then tabLabel.TextColor3 = Color3.fromRGB(255,255,255); tabLabel.TextSize = 12 end
            tween(b, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(1, -8, 0, 44)})
            if sweep then
                tabSweepTokens[name] = (tabSweepTokens[name] or 0) + 1
                local token = tabSweepTokens[name]
                task.spawn(function()
                    while gui.Parent and currentTab == name and tabSweepTokens[name] == token and b.Parent do
                        sweep.Offset = Vector2.new(1.15, 0)
                        local tw = tween(sweep, TweenInfo.new(1.8, Enum.EasingStyle.Linear), {Offset = Vector2.new(-1.15, 0)})
                        tw.Completed:Wait()
                    end
                end)
            end
        else
            tabSweepTokens[name] = (tabSweepTokens[name] or 0) + 1
            if sweepBg then sweepBg.Visible = false end
            b.BackgroundColor3 = Themes[ThemeIndex].Panel
            if tabLabel then tabLabel.TextColor3 = Color3.fromRGB(255,255,255); tabLabel.TextSize = 11 end
            tween(b, TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -12, 0, 39)})
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

scriptsTab.Activated:Connect(function() AkiraPlayClick(); switchTab("Scripts") end)
configTab.Activated:Connect(function() AkiraPlayClick(); switchTab("Config") end)

-- ============================================================
-- AKIRA ANTI-HIT FEATURE
-- ============================================================
local AntiHitEnabled = false
local IsAntiHitRunning = false
local ANTI_HIT_SPEED = 0.016

local antiHitCard = Instance.new("TextButton")
antiHitCard.Name = "AntiHit"
antiHitCard.Size = UDim2.new(1, -8, 0, 58)
antiHitCard.BackgroundColor3 = Themes[ThemeIndex].ButtonDark
antiHitCard.BorderSizePixel = 0
antiHitCard.Text = ""
antiHitCard.AutoButtonColor = false
antiHitCard.Parent = scriptsPage

local antiHitCorner = Instance.new("UICorner")
antiHitCorner.CornerRadius = UDim.new(0, 11)
antiHitCorner.Parent = antiHitCard

local antiHitSweep = Instance.new("UIGradient")
antiHitSweep.Name = "AntiHitSweep"
antiHitSweep.Rotation = 0
antiHitSweep.Offset = Vector2.new(1.15, 0)
antiHitSweep.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(105, 8, 18)),
    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(105, 8, 18)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(105, 8, 18)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(105, 8, 18))
})
antiHitSweep.Parent = antiHitCard

local antiHitTitle = Instance.new("TextLabel")
antiHitTitle.BackgroundTransparency = 1
antiHitTitle.Position = UDim2.fromOffset(13, 5)
antiHitTitle.Size = UDim2.new(1, -26, 0, 25)
antiHitTitle.Text = "🛡  ANTI HIT"
antiHitTitle.Font = Enum.Font.FredokaOne
antiHitTitle.TextSize = 15
antiHitTitle.TextColor3 = Color3.new(1,1,1)
antiHitTitle.TextXAlignment = Enum.TextXAlignment.Left
antiHitTitle.ZIndex = antiHitCard.ZIndex + 2
antiHitTitle.Parent = antiHitCard

local antiHitStatus = Instance.new("TextLabel")
antiHitStatus.BackgroundTransparency = 1
antiHitStatus.Position = UDim2.fromOffset(14, 31)
antiHitStatus.Size = UDim2.new(1, -28, 0, 18)
antiHitStatus.Text = "OFF"
antiHitStatus.Font = Enum.Font.FredokaOne
antiHitStatus.TextSize = 10
antiHitStatus.TextColor3 = Color3.fromRGB(255, 170, 175)
antiHitStatus.TextXAlignment = Enum.TextXAlignment.Left
antiHitStatus.ZIndex = antiHitCard.ZIndex + 2
antiHitStatus.Parent = antiHitCard

local antiHitSweepToken = 0
local function startAntiHitVisual(enabled)
    antiHitSweepToken += 1
    local token = antiHitSweepToken
    antiHitSweep.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, enabled and Color3.fromRGB(35, 170, 75) or Color3.fromRGB(105, 8, 18)),
        ColorSequenceKeypoint.new(0.40, enabled and Color3.fromRGB(35, 170, 75) or Color3.fromRGB(105, 8, 18)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.60, enabled and Color3.fromRGB(35, 170, 75) or Color3.fromRGB(105, 8, 18)),
        ColorSequenceKeypoint.new(1.00, enabled and Color3.fromRGB(35, 170, 75) or Color3.fromRGB(105, 8, 18))
    })
    task.spawn(function()
        while gui.Parent and antiHitCard.Parent and antiHitSweepToken == token do
            antiHitSweep.Offset = Vector2.new(1.15, 0)
            local tw = tween(antiHitSweep, TweenInfo.new(1.45, Enum.EasingStyle.Linear), {Offset = Vector2.new(-1.15, 0)})
            tw.Completed:Wait()
        end
    end)
end

local function setAntiHitVisual(enabled)
    if enabled then
        antiHitStatus.Text = "ON"
        antiHitStatus.TextColor3 = Color3.fromRGB(110,255,145)
        antiHitCard.BackgroundColor3 = Color3.fromRGB(35,170,75)
    else
        antiHitStatus.Text = "OFF"
        antiHitStatus.TextColor3 = Color3.fromRGB(255,170,175)
        antiHitCard.BackgroundColor3 = Color3.fromRGB(105,8,18)
    end
    startAntiHitVisual(enabled)
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

antiHitCard.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        AkiraPlayClick(1.0, 0.30)
        AntiHitEnabled = not AntiHitEnabled
        setAntiHitVisual(AntiHitEnabled)
    end
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

setAntiHitVisual(false)

-- ============================================================
-- CONFIG TAB
-- ============================================================
local function configLabel(text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -8, 0, 25)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.FredokaOne
    l.TextSize = 11
    l.TextColor3 = Color3.fromRGB(190,190,200)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = configPage
    return l
end

local function configButton(text)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -8, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(13, 27, 46)
    b.BorderSizePixel = 0
    b.Text = text
    b.Font = Enum.Font.FredokaOne
    b.TextSize = 11
    b.TextColor3 = Color3.new(1,1,1)
    b.AutoButtonColor = false
    b.Parent = configPage
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 9)
    c.Parent = b
    return b
end

configLabel("GUI SIZE")

local sizeRow = Instance.new("Frame")
sizeRow.Size = UDim2.new(1, -8, 0, 42)
sizeRow.BackgroundTransparency = 1
sizeRow.Parent = configPage

local sizeMinus = configButton("−")
sizeMinus.Parent = sizeRow
sizeMinus.Position = UDim2.fromOffset(0,0)
sizeMinus.Size = UDim2.new(0.31, -3, 1, 0)

local sizeText = configButton("MEDIUM")
sizeText.Parent = sizeRow
sizeText.Position = UDim2.new(0.31, 2, 0, 0)
sizeText.Size = UDim2.new(0.38, -3, 1, 0)

local sizePlus = configButton("+")
sizePlus.Parent = sizeRow
sizePlus.Position = UDim2.new(0.69, 2, 0, 0)
sizePlus.Size = UDim2.new(0.31, -2, 1, 0)

local sizeNames = {"SMALL", "MEDIUM", "LARGE"}

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

configLabel("COLOR")

local colorButton = configButton("Choose Color • Akira Red")

local colorPopup = Instance.new("Frame")
colorPopup.Name = "ColorPicker"
colorPopup.Size = UDim2.new(1, -8, 0, 0)
colorPopup.BackgroundTransparency = 1
colorPopup.ClipsDescendants = true
colorPopup.Parent = configPage

local colorGrid = Instance.new("UIGridLayout")
colorGrid.CellSize = UDim2.new(0.48, -4, 0, 34)
colorGrid.CellPadding = UDim2.new(0.02, 0, 0, 6)
colorGrid.SortOrder = Enum.SortOrder.LayoutOrder
colorGrid.Parent = colorPopup

-- Forward declarations for notification objects
local notification
local notificationStroke
local notificationBar
local updateNotificationPosition

-- Open Button forward declaration
local openButton
local openStroke

local function applyTheme(index)
    ThemeIndex = index
    local th = Themes[ThemeIndex]
    colorButton.Text = "Choose Color • " .. th.Name
    tween(main, TweenInfo.new(0.2), {BackgroundColor3 = th.Main})
    tween(stroke, TweenInfo.new(0.2), {Color = th.Accent})
    dragVisual.BackgroundColor3 = th.Accent
    resizeHandle.TextColor3 = th.Accent
    if notificationBar then notificationBar.BackgroundColor3 = th.Accent end
    if notificationStroke then notificationStroke.Color = th.Accent end
    if openStroke then openStroke.Color = th.Accent end
    sidebar.BackgroundColor3 = th.Main
    for _, b in pairs(tabButtons) do
        if b then
            b.BackgroundColor3 = th.Panel
            local sweepBg = b:FindFirstChild("SelectedSweep")
            if sweepBg then
                sweepBg.BackgroundColor3 = th.Accent
                local sweep = sweepBg:FindFirstChildOfClass("UIGradient")
                if sweep then
                    sweep.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0.00, th.Accent),
                        ColorSequenceKeypoint.new(0.40, th.Accent),
                        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
                        ColorSequenceKeypoint.new(0.60, th.Accent),
                        ColorSequenceKeypoint.new(1.00, th.Accent)
                    })
                end
            end
        end
    end
    for _, page in pairs(pages) do
        page.ScrollBarImageColor3 = th.Accent
        for _, child in ipairs(page:GetChildren()) do
            if child:IsA("Frame") and child.Name ~= "AntiHit" then
                child.BackgroundColor3 = th.Panel
            elseif child:IsA("TextButton") and child.Name ~= "RUN" and child.Name ~= "AntiHit" then
                child.BackgroundColor3 = th.Panel
            end
        end
    end
    refreshTabs()
end

for i, th in ipairs(Themes) do
    local b = Instance.new("TextButton")
    b.Name = th.Name
    b.Text = th.Name
    b.Font = Enum.Font.FredokaOne
    b.TextSize = 10
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = th.Accent
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Parent = colorPopup
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 8)
    bc.Parent = b
    b.Activated:Connect(function()
        AkiraPlayClick()
        applyTheme(i)
        tween(colorPopup, TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -8, 0, 0)})
    end)
end

local colorsOpen = false
colorButton.Activated:Connect(function()
    AkiraPlayClick()
    colorsOpen = not colorsOpen
    local h = colorsOpen and 5 * 34 + 4 * 6 or 0
    tween(colorPopup, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -8, 0, h)})
end)

configLabel("WINDOW")
local closeInfo = configButton("Close / Reopen: × or Logo button")
closeInfo.TextColor3 = Color3.fromRGB(145,145,155)

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
        tween(dragHandle, TweenInfo.new(0.10, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(136, 22),
            BackgroundTransparency = 1
        })
        tween(dragVisual, TweenInfo.new(0.10, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(108, 6),
            BackgroundTransparency = 0
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
    if notification and notification.Visible and updateNotificationPosition then
        updateNotificationPosition()
    end
end

local function endDrag(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1
    and input.UserInputType ~= Enum.UserInputType.Touch then return end
    dragging = false
    if dragSource == dragHandle then
        tween(dragHandle, TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(110, 16),
            BackgroundTransparency = 1
        })
        tween(dragVisual, TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(76, 3),
            BackgroundTransparency = 0.10
        })
    end
    dragSource = nil
end

dragHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        beginDrag(input, dragHandle)
    end
end)

resizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
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
    local viewport = camera and camera.ViewportSize or Vector2.new(1920,1080)
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
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
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
-- FLOATING LOGO BUTTON
-- ============================================================
local LOGO_IMAGE_ID = "rbxassetid://97330468088484"

openButton = Instance.new("ImageButton")
openButton.Name = "OpenAkiraLogo"
openButton.AnchorPoint = Vector2.new(1, 0.5)
openButton.Position = UDim2.new(1, -18, 0.5, 0)
openButton.Size = UDim2.fromOffset(60, 60)
openButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
openButton.BackgroundTransparency = 0.2
openButton.BorderSizePixel = 0
openButton.Image = LOGO_IMAGE_ID
openButton.AutoButtonColor = false
openButton.Visible = false
openButton.ZIndex = 85
openButton.Parent = gui

local oc = Instance.new("UICorner")
oc.CornerRadius = UDim.new(1, 0)
oc.Parent = openButton

openStroke = Instance.new("UIStroke")
openStroke.Thickness = 2.5
openStroke.Color = Themes[ThemeIndex].Accent
openStroke.Transparency = 0.1
openStroke.Parent = openButton

task.spawn(function()
    while gui.Parent and openButton.Parent do
        local toAccent = tween(openStroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Themes[ThemeIndex].Accent,
            Transparency = 0.05
        })
        toAccent.Completed:Wait()
        local toWhite = tween(openStroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Color3.fromRGB(255, 255, 255),
            Transparency = 0.35
        })
        toWhite.Completed:Wait()
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
    local outInfo = TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    local savedClosePosition = main.Position
    local leftExitPosition = UDim2.new(
        savedClosePosition.X.Scale, savedClosePosition.X.Offset - 42,
        savedClosePosition.Y.Scale, savedClosePosition.Y.Offset
    )
    local closeW = math.max(320, main.Size.X.Offset)
    local closeH = math.max(245, main.Size.Y.Offset)
    tween(mainScale, outInfo, {Scale = 0.94})
    tween(shadowScale, outInfo, {Scale = 0.94})
    tween(main, outInfo, {BackgroundTransparency = 1, Position = leftExitPosition, Size = UDim2.fromOffset(closeW, closeH)})
    tween(shadow, outInfo, {BackgroundTransparency = 1, Position = leftExitPosition, Size = UDim2.fromOffset(closeW, closeH)})
    task.wait(0.33)
    main.Visible = false
    shadow.Visible = false
    dragHandle.Visible = false
    resizeHandle.Visible = false
    if notification then notification.Visible = false end
    main.BackgroundTransparency = 1
    shadow.BackgroundTransparency = 1
    main.Size = Sizes[SizeIndex]
    shadow.Size = Sizes[SizeIndex]
    main.Position = savedClosePosition
    shadow.Position = savedClosePosition
    mainScale.Scale = 1
    shadowScale.Scale = 1
    updateFloatingControls()
    openButton.Visible = true
    tween(openButton, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(60, 60)
    })
end

local function openGui()
    openButton.Visible = false
    main.Visible = true
    shadow.Visible = true
    mainScale.Scale = 0.72
    shadowScale.Scale = 0.72
    main.BackgroundTransparency = 0
    shadow.BackgroundTransparency = 0.45
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
        main.Size = UDim2.fromOffset(190,45)
        shadow.Size = UDim2.fromOffset(190,45)
        mainScale.Scale = 0.72
        shadowScale.Scale = 0.72
        main.BackgroundTransparency = 0
        shadow.BackgroundTransparency = 0.45
        tween(main, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(shadow, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(mainScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        tween(shadowScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        task.delay(0.31, updateFloatingControls)
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
        main.Size = UDim2.fromOffset(190,45)
        shadow.Size = UDim2.fromOffset(190,45)
        mainScale.Scale = 0.72
        shadowScale.Scale = 0.72
        main.BackgroundTransparency = 0
        shadow.BackgroundTransparency = 0.45
        tween(main, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(shadow, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(mainScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        tween(shadowScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        task.delay(0.31, updateFloatingControls)
    else
        minimized = true
        savedSize = main.Size
        sidebar.Visible = false
        content.Visible = false
        resizeHandle.Visible = false
        dragHandle.Visible = false
        local miniInfo = TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        tween(mainScale, miniInfo, {Scale = 0.78})
        tween(shadowScale, miniInfo, {Scale = 0.78})
        tween(main, miniInfo, {BackgroundTransparency = 1, Size = UDim2.fromOffset(1,1)})
        tween(shadow, miniInfo, {BackgroundTransparency = 1, Size = UDim2.fromOffset(1,1)})
        task.wait(0.25)
        main.Visible = false
        shadow.Visible = false
        main.Size = savedSize
        shadow.Size = savedSize
        mainScale.Scale = 1
        shadowScale.Scale = 1
        openButton.Visible = true
        openButton.Size = UDim2.fromOffset(8,8)
        tween(openButton, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(60,60)})
    end
end)

refreshTabs()

-- ======================================================
-- SUPPORT NOTIFICATION
-- ======================================================
notification = Instance.new("Frame")
notification.Name = "SupportNotification"
notification.AnchorPoint = Vector2.new(0.5, 0.5)
notification.Size = UDim2.fromOffset(270, 48)
notification.BackgroundColor3 = Color3.fromRGB(18,18,23)
notification.BackgroundTransparency = 1
notification.BorderSizePixel = 0
notification.ZIndex = 90
notification.Visible = false
notification.Parent = gui

local notificationCorner = Instance.new("UICorner")
notificationCorner.CornerRadius = UDim.new(0, 14)
notificationCorner.Parent = notification

notificationStroke = Instance.new("UIStroke")
notificationStroke.Thickness = 1
notificationStroke.Transparency = 1
notificationStroke.Color = Themes[ThemeIndex].Accent
notificationStroke.Parent = notification

notificationBar = Instance.new("Frame")
notificationBar.Size = UDim2.new(0, 3, 0.58, 0)
notificationBar.Position = UDim2.new(0, 8, 0.21, 0)
notificationBar.BackgroundColor3 = Themes[ThemeIndex].Accent
notificationBar.BorderSizePixel = 0
notificationBar.ZIndex = 91
notificationBar.Parent = notification

local notificationBarCorner = Instance.new("UICorner")
notificationBarCorner.CornerRadius = UDim.new(1,0)
notificationBarCorner.Parent = notificationBar

local notificationText = Instance.new("TextLabel")
notificationText.BackgroundTransparency = 1
notificationText.Position = UDim2.fromOffset(20, 0)
notificationText.Size = UDim2.new(1, -30, 1, 0)
notificationText.Font = Enum.Font.FredokaOne
notificationText.Text = "Welcome to Akira Script Hub :)"
notificationText.TextSize = 12
notificationText.TextColor3 = Color3.new(1,1,1)
notificationText.TextTransparency = 1
notificationText.TextXAlignment = Enum.TextXAlignment.Left
notificationText.ZIndex = 91
notificationText.Parent = notification

local notificationGradient = Instance.new("UIGradient")
notificationGradient.Rotation = 0
notificationGradient.Offset = Vector2.new(1.1, 0)
notificationGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(70, 255, 120)),
    ColorSequenceKeypoint.new(0.38, Color3.fromRGB(70, 255, 120)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.62, Color3.fromRGB(70, 255, 120)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(70, 255, 120))
})
notificationGradient.Parent = notificationText

task.spawn(function()
    while gui.Parent and notificationText.Parent do
        notificationGradient.Offset = Vector2.new(1.1, 0)
        local t = tween(notificationGradient, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
            Offset = Vector2.new(-1.1, 0)
        })
        t.Completed:Wait()
    end
end)

function updateNotificationPosition()
    if not notification then return end
    local y = math.floor(-(main.Size.Y.Offset * 0.5) - 38)
    notification.Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset, main.Position.Y.Scale, main.Position.Y.Offset + y)
end

local function showSupportNotification()
    updateNotificationPosition()
    notification.Visible = true
    pcall(function() AkiraPlayClick(1.0, 0.30) end)
    notification.BackgroundTransparency = 1
    notificationText.TextTransparency = 1
    notificationStroke.Transparency = 1
    local startY = notification.Position.Y.Offset - 18
    local endY = notification.Position.Y.Offset
    notification.Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset, main.Position.Y.Scale, startY)
    tween(notification, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset, main.Position.Y.Scale, endY),
        BackgroundTransparency = 0.08
    })
    tween(notificationText, TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0})
    tween(notificationStroke, TweenInfo.new(0.20), {Transparency = 0.45})
    task.delay(2.6, function()
        if not notification or not notification.Parent or not notification.Visible then return end
        local outY = notification.Position.Y.Offset - 14
        tween(notification, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset, main.Position.Y.Scale, outY),
            BackgroundTransparency = 1
        })
        tween(notificationText, TweenInfo.new(0.18), {TextTransparency = 1})
        tween(notificationStroke, TweenInfo.new(0.18), {Transparency = 1})
        task.wait(0.27)
        if notification then notification.Visible = false end
    end)
end

-- ======================================================
-- INTRO ANIMATION -> MAIN GUI
-- ======================================================
main.Visible = false
shadow.Visible = false
dragHandle.Visible = false
resizeHandle.Visible = false
notification.Visible = false

local intro = Instance.new("Frame")
intro.Name = "AkiraIntro"
intro.Size = UDim2.fromScale(1, 1)
intro.BackgroundColor3 = Color3.fromRGB(0,0,0)
intro.BackgroundTransparency = 0.18
intro.BorderSizePixel = 0
intro.ZIndex = 100
intro.Parent = gui

local introBgGradient = Instance.new("UIGradient")
introBgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.38, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.62, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0,0,0))
})
introBgGradient.Rotation = 0
introBgGradient.Offset = Vector2.new(1.2,0)
introBgGradient.Parent = intro

task.spawn(function()
    while gui.Parent and intro.Parent do
        introBgGradient.Offset = Vector2.new(1.2,0)
        local tw = tween(introBgGradient, TweenInfo.new(2.2, Enum.EasingStyle.Linear), {Offset = Vector2.new(-1.2,0)})
        tw.Completed:Wait()
        task.wait(0.08)
    end
end)

local introCard = Instance.new("Frame")
introCard.AnchorPoint = Vector2.new(0.5,0.5)
introCard.Position = UDim2.fromScale(0.5,0.53)
introCard.Size = UDim2.fromOffset(250,150)
introCard.BackgroundColor3 = Color3.fromRGB(14,14,18)
introCard.BorderSizePixel = 0
introCard.ZIndex = 101
introCard.Parent = intro

local introCorner = Instance.new("UICorner")
introCorner.CornerRadius = UDim.new(0,18)
introCorner.Parent = introCard

local introTitle = Instance.new("TextLabel")
introTitle.BackgroundTransparency = 1
introTitle.Size = UDim2.new(1,-20,0,45)
introTitle.Position = UDim2.fromOffset(10,38)
introTitle.Font = Enum.Font.GothamBlack
introTitle.Text = "AKIRA"
introTitle.TextSize = 34
introTitle.TextColor3 = Color3.new(1,1,1)
introTitle.ZIndex = 102
introTitle.Parent = introCard

local introGrad = Instance.new("UIGradient")
introGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255,55,75)),
    ColorSequenceKeypoint.new(0.32, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(255,55,75)),
    ColorSequenceKeypoint.new(0.82, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255,55,75))
})
introGrad.Offset = Vector2.new(1.1,0)
introGrad.Parent = introTitle

task.spawn(function()
    while gui.Parent and introTitle.Parent do
        introGrad.Offset = Vector2.new(1.1,0)
        local tw = tween(introGrad, TweenInfo.new(1.4, Enum.EasingStyle.Linear), {Offset = Vector2.new(-1.1,0)})
        tw.Completed:Wait()
    end
end)

local introStatus = Instance.new("TextLabel")
introStatus.BackgroundTransparency = 1
introStatus.Size = UDim2.new(1,-30,0,18)
introStatus.Position = UDim2.fromOffset(15,91)
introStatus.Font = Enum.Font.FredokaOne
introStatus.Text = "AKIRA SCRIPT • INITIALIZING"
introStatus.TextSize = 10
introStatus.TextColor3 = Color3.fromRGB(150,150,160)
introStatus.ZIndex = 102
introStatus.Parent = introCard

local introBar = Instance.new("Frame")
introBar.Size = UDim2.new(0.72,0,0,4)
introBar.Position = UDim2.new(0.14,0,1,-25)
introBar.BackgroundColor3 = Color3.fromRGB(40,40,48)
introBar.BorderSizePixel = 0
introBar.ZIndex = 102
introBar.Parent = introCard

local ibc = Instance.new("UICorner")
ibc.CornerRadius = UDim.new(1,0)
ibc.Parent = introBar

local introFill = Instance.new("Frame")
introFill.Size = UDim2.new(0,0,1,0)
introFill.BackgroundColor3 = Color3.fromRGB(255,255,255)
introFill.BorderSizePixel = 0
introFill.ZIndex = 103
introFill.Parent = introBar

local ifc = Instance.new("UICorner")
ifc.CornerRadius = UDim.new(1,0)
ifc.Parent = introFill

local introScale = Instance.new("UIScale")
introScale.Scale = 0.82
introScale.Parent = introCard

introCard.BackgroundTransparency = 1
introTitle.TextTransparency = 1
introStatus.TextTransparency = 1
introBar.BackgroundTransparency = 1
introFill.BackgroundTransparency = 1

tween(introScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale=1})
tween(introCard, TweenInfo.new(0.28), {BackgroundTransparency=0.03})
tween(introTitle, TweenInfo.new(0.25), {TextTransparency=0})
tween(introStatus, TweenInfo.new(0.25), {TextTransparency=0})
tween(introBar, TweenInfo.new(0.25), {BackgroundTransparency=0})
tween(introFill, TweenInfo.new(0.25), {BackgroundTransparency=0})
tween(introFill, TweenInfo.new(2.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size=UDim2.new(1,0,1,0)})

task.wait(3.15)
introStatus.Text = "AKIRA SCRIPT • READY"
task.wait(1.2)

main.Visible = true
shadow.Visible = true
AkiraPlayClick(1.35,0.24)
mainScale.Scale = 0.78
shadowScale.Scale = 0.78
main.BackgroundTransparency = 0
shadow.BackgroundTransparency = 0.45
local handoff = TweenInfo.new(0.52, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
tween(mainScale, handoff, {Scale=1})
tween(shadowScale, handoff, {Scale=1})

task.spawn(function()
    task.wait(0.05)
    tween(introScale, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Scale=0.9})
    tween(intro, TweenInfo.new(0.38, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency=1})
    tween(introCard, TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency=1})
    tween(introTitle, TweenInfo.new(0.25), {TextTransparency=1})
    tween(introStatus, TweenInfo.new(0.25), {TextTransparency=1})
    task.wait(0.4)
    intro:Destroy()
    updateFloatingControls()
    dragHandle.Visible = true
    resizeHandle.Visible = true
    task.wait(0.08)
    showSupportNotification()
end)
