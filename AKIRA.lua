--[[
    AKIRA SCRIPT HUB • កំណែកែសម្រួលភាសាខ្មែរត្រឹមត្រូវ
    - គាំទ្រ Font ខ្មែរច្បាស់ល្អ មិនបាត់ស្រៈ ឬជើងអក្សរ
    - ប៊ូតុងអណ្ដែតជារូប Logo AKIRA ដំណើរការរលូន
    - មុខងារ Anti-Hit និង Config ដំណើរការពេញលេញ
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Safeguard សម្រាប់ Executor ទូរស័ព្ទ
local GuiParent = nil
pcall(function()
    if gethui then
        GuiParent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(PlayerGui)
        GuiParent = PlayerGui
    else
        GuiParent = CoreGui:FindFirstChild("RobloxGui") or PlayerGui
    end
end)
if not GuiParent then GuiParent = PlayerGui end

local old = GuiParent:FindFirstChild("AkiraScriptHub") or PlayerGui:FindFirstChild("AkiraScriptHub")
if old then
    old:Destroy()
end

-- ============================================================
-- កំណត់រូបភាព LOGO និងសំឡេង
-- ============================================================
local AKIRA_LOGO_ID = "rbxassetid://92844749741913[span_1](start_span)"[span_1](end_span)

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

-- ពណ៌ Theme
local Themes = {
    {Name = "ខៀវអគ្គិសនី", Main = Color3.fromRGB(10, 14, 22), Panel = Color3.fromRGB(16, 23, 36), Accent = Color3.fromRGB(0, 175, 255), ButtonDark = Color3.fromRGB(12, 45, 80)},
    {Name = "ក្រហមភ្លើង", Main = Color3.fromRGB(18, 10, 14), Panel = Color3.fromRGB(28, 16, 22), Accent = Color3.fromRGB(255, 60, 80), ButtonDark = Color3.fromRGB(90, 15, 25)},
    {Name = "ស្វាយរាត្រី", Main = Color3.fromRGB(14, 10, 22), Panel = Color3.fromRGB(24, 16, 36), Accent = Color3.fromRGB(170, 85, 255), ButtonDark = Color3.fromRGB(65, 25, 105)},
    {Name = "មាសប្រណិត", Main = Color3.fromRGB(18, 16, 12), Panel = Color3.fromRGB(28, 25, 18), Accent = Color3.fromRGB(255, 195, 60), ButtonDark = Color3.fromRGB(85, 65, 15)},
    {Name = "បៃតងត្បូង", Main = Color3.fromRGB(10, 18, 14), Panel = Color3.fromRGB(16, 28, 22), Accent = Color3.fromRGB(45, 225, 130), ButtonDark = Color3.fromRGB(15, 75, 45)},
}

local ThemeIndex = 1
local SizeIndex = 2
local Sizes = {
    UDim2.fromOffset(330, 255),
    UDim2.fromOffset(375, 290),
    UDim2.fromOffset(425, 330),
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
gui.DisplayOrder = 99999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = GuiParent

local scale = Instance.new("UIScale")
scale.Scale = 0.88
scale.Parent = gui

-- ស្រមោល Shadow
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.fromScale(0.5, 0.52)
shadow.Size = Sizes[SizeIndex]
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.35
shadow.BorderSizePixel = 0
shadow.Visible = true
shadow.Parent = gui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 18)
shadowCorner.Parent = shadow

-- ផ្ទាំងមេ Main Frame
local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.48)
main.Size = Sizes[SizeIndex]
main.BackgroundColor3 = Themes[ThemeIndex].Main
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Visible = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 18)
mainCorner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1.8
stroke.Color = Themes[ThemeIndex].Accent
stroke.Transparency = 0.25
stroke.Parent = main

-- TopBar
local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 56)
top.BackgroundTransparency = 1
top.Parent = main

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(70, 6)
title.Size = UDim2.new(1, -140, 0, 26)
title.Font = Enum.Font.SourceSansBold
title.Text = "AKIRA SCRIPT"
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextColor3 = Color3.new(1, 1, 1)
title.Parent = top

local titleGradient = Instance.new("UIGradient")
titleGradient.Rotation = 0
titleGradient.Offset = Vector2.new(1.2, 0)
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 175, 255)),
    ColorSequenceKeypoint.new(0.30, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.70, Color3.fromRGB(0, 175, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
})
titleGradient.Parent = title

task.spawn(function()
    while gui.Parent and title.Parent do
        titleGradient.Offset = Vector2.new(1.2, 0)
        local t = tween(titleGradient, TweenInfo.new(1.4, Enum.EasingStyle.Linear), {
            Offset = Vector2.new(-1.2, 0)
        })
        t.Completed:Wait()
    end
end)

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 50, 0, 32)
subtitle.Size = UDim2.new(1, -100, 0, 18)
subtitle.Font = Enum.Font.SourceSansBold
subtitle.Text = "ផ្ទាំងបញ្ជាទូរស័ព្ទ • កំណែពិសេស"
subtitle.TextSize = 14
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.TextColor3 = Color3.fromRGB(150, 175, 205)
subtitle.Parent = top

local function topButton(text, x)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(30, 28)
    b.Position = UDim2.new(1, x, 0, 10)
    b.AnchorPoint = Vector2.new(1, 0)
    b.BackgroundColor3 = Themes[ThemeIndex].Panel
    b.BorderSizePixel = 0
    b.Text = text
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 16
    b.TextColor3 = Color3.new(1, 1, 1)
    b.AutoButtonColor = false
    b.Parent = top
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b
    return b
end

local minimize = topButton("—", -50)
local close = topButton("×", -10)

-- របារសម្រាប់អូស
local dragHandle = Instance.new("TextButton")
dragHandle.Name = "AkiraDragHandle"
dragHandle.AnchorPoint = Vector2.new(0.5, 0.5)
dragHandle.Size = UDim2.fromOffset(115, 16)
dragHandle.BackgroundTransparency = 1
dragHandle.BorderSizePixel = 0
dragHandle.Text = ""
dragHandle.AutoButtonColor = false
dragHandle.ZIndex = 60
dragHandle.Visible = true
dragHandle.Parent = gui

local dragVisual = Instance.new("Frame")
dragVisual.Name = "Line"
dragVisual.AnchorPoint = Vector2.new(0.5, 0.5)
dragVisual.Position = UDim2.fromScale(0.5, 0.5)
dragVisual.Size = UDim2.fromOffset(80, 4)
dragVisual.BackgroundColor3 = Themes[ThemeIndex].Accent
dragVisual.BackgroundTransparency = 0.1
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
resizeHandle.Font = Enum.Font.SourceSansBold
resizeHandle.TextSize = 20
resizeHandle.TextColor3 = Themes[ThemeIndex].Accent
resizeHandle.AutoButtonColor = false
resizeHandle.ZIndex = 70
resizeHandle.Visible = true
resizeHandle.Parent = gui

local resizeDragging = false
local resizeStartInput
local resizeStartSize

local function updateFloatingControls()
    if not main or not main.Parent then return end
    local x = main.Position.X.Scale
    local ox = main.Position.X.Offset
    local y = main.Position.Y.Scale
    local oy = main.Position.Y.Offset
    local halfW = main.AbsoluteSize.X * 0.5
    local halfH = main.AbsoluteSize.Y * 0.5
    dragHandle.Position = UDim2.new(x, ox, y, oy + halfH + 13)
    resizeHandle.Position = UDim2.new(x, ox + halfW + 15, y, oy + halfH + 15)
end

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.fromOffset(8, 62)
sidebar.Size = UDim2.new(0, 105, 1, -70)
sidebar.BackgroundColor3 = Themes[ThemeIndex].Panel
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 14)
sideCorner.Parent = sidebar

local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 122, 0, 62)
content.Size = UDim2.new(1, -130, 1, -70)
content.BackgroundTransparency = 1
content.Parent = main

local currentTab = "Scripts"
local pages = {}

local function makePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.fromScale(1, 1)
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
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    local pad = Instance.new("UIPadding")
    pad.PaddingRight = UDim.new(0, 5)
    pad.PaddingBottom = UDim.new(0, 8)
    pad.Parent = page

    pages[name] = page
    return page
end

local scriptsPage = makePage("Scripts")
local configPage = makePage("Config")

local tabButtons = {}

local function makeTab(tabKey, displayText, icon)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -12, 0, 40)
    b.BackgroundColor3 = Themes[ThemeIndex].Panel
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.Parent = sidebar
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = b

    local sweepBg = Instance.new("Frame")
    sweepBg.Name = "SelectedSweep"
    sweepBg.Size = UDim2.fromScale(1, 1)
    sweepBg.BackgroundColor3 = Themes[ThemeIndex].Accent
    sweepBg.BorderSizePixel = 0
    sweepBg.Visible = false
    sweepBg.ZIndex = b.ZIndex + 1
    sweepBg.Parent = b
    local sweepCorner = Instance.new("UICorner")
    sweepCorner.CornerRadius = UDim.new(0, 10)
    sweepCorner.Parent = sweepBg

    local label = Instance.new("TextLabel")
    label.Name = "TabLabel"
    label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1)
    label.Text = icon .. " " .. displayText
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.ZIndex = b.ZIndex + 2
    label.Parent = b

    tabButtons[tabKey] = b
    return b
end

local scriptsTab = makeTab("Scripts", "មុខងារ", "🛡")
local configTab = makeTab("Config", "ការកំណត់", "⚙")
scriptsTab.Position = UDim2.fromOffset(6, 10)
configTab.Position = UDim2.new(0, 6, 1, -50)

local function refreshTabs()
    for name, b in pairs(tabButtons) do
        local selected = (name == currentTab)
        local sweepBg = b:FindFirstChild("SelectedSweep")
        local tabLabel = b:FindFirstChild("TabLabel")
        if selected then
            if sweepBg then sweepBg.Visible = true end
            if tabLabel then tabLabel.TextColor3 = Color3.fromRGB(255, 255, 255); tabLabel.TextSize = 15 end
            tween(b, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -8, 0, 42)})
        else
            if sweepBg then sweepBg.Visible = false end
            if tabLabel then tabLabel.TextColor3 = Color3.fromRGB(170, 185, 205); tabLabel.TextSize = 14 end
            tween(b, TweenInfo.new(0.14, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -12, 0, 38)})
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
-- មុខងារ ANTI-HIT
-- ============================================================
local AntiHitEnabled = false
local IsAntiHitRunning = false
local ANTI_HIT_SPEED = 0.016

local antiHitCard = Instance.new("TextButton")
antiHitCard.Name = "AntiHit"
antiHitCard.Size = UDim2.new(1, -4, 0, 62)
antiHitCard.BackgroundColor3 = Themes[ThemeIndex].ButtonDark
antiHitCard.BorderSizePixel = 0
antiHitCard.Text = ""
antiHitCard.AutoButtonColor = false
antiHitCard.Parent = scriptsPage

local antiHitCorner = Instance.new("UICorner")
antiHitCorner.CornerRadius = UDim.new(0, 12)
antiHitCorner.Parent = antiHitCard

local antiHitStroke = Instance.new("UIStroke")
antiHitStroke.Thickness = 1.2
antiHitStroke.Color = Themes[ThemeIndex].Accent
antiHitStroke.Transparency = 0.4
antiHitStroke.Parent = antiHitCard

local antiHitTitle = Instance.new("TextLabel")
antiHitTitle.BackgroundTransparency = 1
antiHitTitle.Position = UDim2.fromOffset(14, 8)
antiHitTitle.Size = UDim2.new(1, -28, 0, 24)
antiHitTitle.Text = "🛡  ប្រព័ន្ធគេចការវាយ (Anti-Hit)"
antiHitTitle.Font = Enum.Font.SourceSansBold
antiHitTitle.TextSize = 15
antiHitTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
antiHitTitle.TextXAlignment = Enum.TextXAlignment.Left
antiHitTitle.ZIndex = antiHitCard.ZIndex + 2
antiHitTitle.Parent = antiHitCard

local antiHitStatus = Instance.new("TextLabel")
antiHitStatus.BackgroundTransparency = 1
antiHitStatus.Position = UDim2.fromOffset(14, 34)
antiHitStatus.Size = UDim2.new(1, -28, 0, 18)
antiHitStatus.Text = "ស្ថានភាព៖ បិទ"
antiHitStatus.Font = Enum.Font.SourceSansBold
antiHitStatus.TextSize = 13
antiHitStatus.TextColor3 = Color3.fromRGB(255, 140, 140)
antiHitStatus.TextXAlignment = Enum.TextXAlignment.Left
antiHitStatus.ZIndex = antiHitCard.ZIndex + 2
antiHitStatus.Parent = antiHitCard

local function setAntiHitVisual(enabled)
    if enabled then
        antiHitStatus.Text = "ស្ថានភាព៖ កំពុងបើកដំណើរការ"
        antiHitStatus.TextColor3 = Color3.fromRGB(110, 255, 145)
        antiHitCard.BackgroundColor3 = Color3.fromRGB(20, 85, 45)
        antiHitStroke.Color = Color3.fromRGB(75, 255, 130)
    else
        antiHitStatus.Text = "ស្ថានភាព៖ បិទ"
        antiHitStatus.TextColor3 = Color3.fromRGB(255, 140, 140)
        antiHitCard.BackgroundColor3 = Themes[ThemeIndex].ButtonDark
        antiHitStroke.Color = Themes[ThemeIndex].Accent
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
-- ផ្ទាំង CONFIG
-- ============================================================
local function configLabel(text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -4, 0, 24)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.SourceSansBold
    l.TextSize = 14
    l.TextColor3 = Color3.fromRGB(180, 200, 225)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = configPage
    return l
end

local function configButton(text)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 38)
    b.BackgroundColor3 = Themes[ThemeIndex].Panel
    b.BorderSizePixel = 0
    b.Text = text
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 13
    b.TextColor3 = Color3.new(1, 1, 1)
    b.AutoButtonColor = false
    b.Parent = configPage
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = b
    return b
end

configLabel("ទំហំផ្ទាំងបញ្ជា")

local sizeRow = Instance.new("Frame")
sizeRow.Size = UDim2.new(1, -4, 0, 40)
sizeRow.BackgroundTransparency = 1
sizeRow.Parent = configPage

local sizeMinus = configButton("−")
sizeMinus.Parent = sizeRow
sizeMinus.Position = UDim2.fromOffset(0, 0)
sizeMinus.Size = UDim2.new(0.3, -2, 1, 0)

local sizeText = configButton("ទំហំមធ្យម")
sizeText.Parent = sizeRow
sizeText.Position = UDim2.new(0.3, 2, 0, 0)
sizeText.Size = UDim2.new(0.4, -4, 1, 0)

local sizePlus = configButton("+")
sizePlus.Parent = sizeRow
sizePlus.Position = UDim2.new(0.7, 2, 0, 0)
sizePlus.Size = UDim2.new(0.3, -2, 1, 0)

local sizeNamesKhmer = {"ទំហំតូច", "ទំហំមធ្យម", "ទំហំធំ"}

local function setSize(index)
    SizeIndex = math.clamp(index, 1, #Sizes)
    sizeText.Text = sizeNamesKhmer[SizeIndex]
    local target = Sizes[SizeIndex]
    tween(main, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
    tween(shadow, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
    task.defer(updateFloatingControls)
end

sizeMinus.Activated:Connect(function() AkiraPlayClick(); setSize(SizeIndex - 1) end)
sizePlus.Activated:Connect(function() AkiraPlayClick(); setSize(SizeIndex + 1) end)

configLabel("ពណ៌ផ្ទាំងបញ្ជា")

local colorButton = configButton("ជ្រើសរើសពណ៌ • " .. Themes[ThemeIndex].Name)

local colorPopup = Instance.new("Frame")
colorPopup.Name = "ColorPicker"
colorPopup.Size = UDim2.new(1, -4, 0, 0)
colorPopup.BackgroundTransparency = 1
colorPopup.ClipsDescendants = true
colorPopup.Parent = configPage

local colorGrid = Instance.new("UIGridLayout")
colorGrid.CellSize = UDim2.new(1, 0, 0, 32)
colorGrid.CellPadding = UDim2.new(0, 0, 0, 6)
colorGrid.SortOrder = Enum.SortOrder.LayoutOrder
colorGrid.Parent = colorPopup

local function applyTheme(index)
    ThemeIndex = index
    local th = Themes[ThemeIndex]
    colorButton.Text = "ជ្រើសរើសពណ៌ • " .. th.Name
    tween(main, TweenInfo.new(0.2), {BackgroundColor3 = th.Main})
    tween(stroke, TweenInfo.new(0.2), {Color = th.Accent})
    dragVisual.BackgroundColor3 = th.Accent
    resizeHandle.TextColor3 = th.Accent
    sidebar.BackgroundColor3 = th.Panel
    
    if not AntiHitEnabled then
        antiHitCard.BackgroundColor3 = th.ButtonDark
        antiHitStroke.Color = th.Accent
    end

    for _, b in pairs(tabButtons) do
        if b then
            local sweepBg = b:FindFirstChild("SelectedSweep")
            if sweepBg then
                sweepBg.BackgroundColor3 = th.Accent
            end
        end
    end
    refreshTabs()
end

for i, th in ipairs(Themes) do
    local b = Instance.new("TextButton")
    b.Name = th.Name
    b.Text = th.Name
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 13
    b.TextColor3 = Color3.new(1, 1, 1)
    b.BackgroundColor3 = th.ButtonDark
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Parent = colorPopup
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 8)
    bc.Parent = b
    b.Activated:Connect(function()
        AkiraPlayClick()
        applyTheme(i)
        tween(colorPopup, TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -4, 0, 0)})
    end)
end

local colorsOpen = false
colorButton.Activated:Connect(function()
    AkiraPlayClick()
    colorsOpen = not colorsOpen
    local h = colorsOpen and (#Themes * 38) or 0
    tween(colorPopup, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -4, 0, h)})
end)

configLabel("ព័ត៌មានបន្ថែម")
local closeInfo = configButton("បិទ ឬ បើកផ្ទាំង៖ ចុចសញ្ញា × ឬចុចលើរូប Logo")
closeInfo.TextColor3 = Color3.fromRGB(150, 165, 185)

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
        tween(dragVisual, TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(105, 5),
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
end

local function endDrag(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1
    and input.UserInputType ~= Enum.UserInputType.Touch then return end
    dragging = false
    if dragSource == dragHandle then
        tween(dragVisual, TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(80, 4),
            BackgroundTransparency = 0.1
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
-- FLOATING LOGO PHOTO BUTTON
-- ============================================================
local openButton = Instance.new("ImageButton")
openButton.Name = "OpenAkira"
openButton.AnchorPoint = Vector2.new(1, 0.5)
openButton.Position = UDim2.new(1, -18, 0.5, 0)
openButton.Size = UDim2.fromOffset(58, 58)
openButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
openButton.BackgroundTransparency = 0.12
openButton.BorderSizePixel = 0
openButton.Image = AKIRA_LOGO_ID[span_2](start_span)[span_2](end_span)
openButton.ScaleType = Enum.ScaleType.Fit
openButton.AutoButtonColor = false
openButton.Visible = false
openButton.ZIndex = 9999
openButton.Parent = gui

local oc = Instance.new("UICorner")
oc.CornerRadius = UDim.new(1, 0)
oc.Parent = openButton

local openStroke = Instance.new("UIStroke")
openStroke.Thickness = 2.2
openStroke.Color = Color3.fromRGB(0, 175, 255)
openStroke.Transparency = 0.2
openStroke.Parent = openButton

local function closeGui()
    if not main.Visible then return end
    main.Visible = false
    shadow.Visible = false
    dragHandle.Visible = false
    resizeHandle.Visible = false
    openButton.Visible = true
end

local function openGui()
    openButton.Visible = false
    main.Visible = true
    shadow.Visible = true
    dragHandle.Visible = true
    resizeHandle.Visible = true
    updateFloatingControls()
end

close.Activated:Connect(function() AkiraPlayClick(); closeGui() end)
minimize.Activated:Connect(function() AkiraPlayClick(); closeGui() end)

local akDragging = false
local akDragStart, akStartPos
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
    openGui()
end)

RunService.RenderStepped:Connect(function()
    if gui.Parent and (main.Visible or dragHandle.Visible or resizeHandle.Visible) then
        updateFloatingControls()
    end
end)

refreshTabs()
updateFloatingControls()

-- ======================================================
-- ផ្ទាំង INTRO ចាប់ផ្តើម
-- ======================================================
task.spawn(function()
    local intro = Instance.new("Frame")
    intro.Name = "AkiraIntro"
    intro.Size = UDim2.fromScale(1, 1)
    intro.BackgroundColor3 = Color3.fromRGB(6, 8, 14)
    intro.BackgroundTransparency = 0.15
    intro.BorderSizePixel = 0
    intro.ZIndex = 1000
    intro.Parent = gui

    local introCard = Instance.new("Frame")
    introCard.AnchorPoint = Vector2.new(0.5, 0.5)
    introCard.Position = UDim2.fromScale(0.5, 0.5)
    introCard.Size = UDim2.fromOffset(260, 150)
    introCard.BackgroundColor3 = Color3.fromRGB(12, 16, 26)
    introCard.BorderSizePixel = 0
    introCard.ZIndex = 1001
    introCard.Parent = intro

    local introCorner = Instance.new("UICorner")
    introCorner.CornerRadius = UDim.new(0, 18)
    introCorner.Parent = introCard

    local introTitle = Instance.new("TextLabel")
    introTitle.BackgroundTransparency = 1
    introTitle.Size = UDim2.new(1, 0, 0, 40)
    introTitle.Position = UDim2.fromOffset(0, 25)
    introTitle.Font = Enum.Font.SourceSansBold
    introTitle.Text = "AKIRA SCRIPT"
    introTitle.TextSize = 28
    introTitle.TextColor3 = Color3.fromRGB(0, 175, 255)
    introTitle.ZIndex = 1002
    introTitle.Parent = introCard

    local introStatus = Instance.new("TextLabel")
    introStatus.BackgroundTransparency = 1
    introStatus.Size = UDim2.new(1, 0, 0, 20)
    introStatus.Position = UDim2.fromOffset(0, 75)
    introStatus.Font = Enum.Font.SourceSansBold
    introStatus.Text = "កំពុងរៀបចំប្រព័ន្ធ... សូមរង់ចាំ"
    introStatus.TextSize = 14
    introStatus.TextColor3 = Color3.fromRGB(180, 200, 225)
    introStatus.ZIndex = 1002
    introStatus.Parent = introCard

    task.wait(1.4)
    tween(intro, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
    tween(introCard, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
    tween(introTitle, TweenInfo.new(0.25), {TextTransparency = 1})
    tween(introStatus, TweenInfo.new(0.25), {TextTransparency = 1})
    task.wait(0.38)
    intro:Destroy()
end)
