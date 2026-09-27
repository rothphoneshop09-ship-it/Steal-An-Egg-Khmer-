--[[
    AKIRA SCRIPT HUB • FIXED & DIRECT DISPLAY
    - បង្ហាញផ្ទាំង Menu ភ្លាមៗ (មិនគាំង មិនបាត់)
    - គាំទ្រ Executor ទូរស័ព្ទគ្រប់ប្រភេទ
    - ភាសាខ្មែរច្បាស់ល្អ មិនបាត់ស្រៈ
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui", 10)

-- កំណត់កន្លែងដាក់ UI ឱ្យមានសុវត្ថិភាពបំផុតសម្រាប់ Mobile
local GuiParent = nil
if gethui then
    GuiParent = gethui()
else
    GuiParent = PlayerGui
end

-- លុប Script ចាស់ប្រសិនបើមាន
pcall(function()
    if GuiParent:FindFirstChild("AkiraScriptHub") then
        GuiParent.AkiraScriptHub:Destroy()
    end
    if PlayerGui:FindFirstChild("AkiraScriptHub") then
        PlayerGui.AkiraScriptHub:Destroy()
    end
end)

local AKIRA_LOGO_ID = "rbxassetid://92844749741913[span_0](start_span)"[span_0](end_span)

local Themes = {
    {Name = "ខៀវអគ្គិសនី", Main = Color3.fromRGB(12, 16, 24), Panel = Color3.fromRGB(18, 24, 38), Accent = Color3.fromRGB(0, 175, 255), ButtonDark = Color3.fromRGB(14, 45, 80)},
    {Name = "ក្រហមភ្លើង", Main = Color3.fromRGB(20, 12, 16), Panel = Color3.fromRGB(30, 18, 24), Accent = Color3.fromRGB(255, 60, 80), ButtonDark = Color3.fromRGB(90, 15, 25)},
    {Name = "បៃតងត្បូង", Main = Color3.fromRGB(12, 20, 16), Panel = Color3.fromRGB(18, 30, 24), Accent = Color3.fromRGB(45, 225, 130), ButtonDark = Color3.fromRGB(15, 75, 45)},
}
local ThemeIndex = 1

local function tween(obj, info, props)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

-- បង្កើត ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "AkiraScriptHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999
gui.Parent = GuiParent

-- ផ្ទាំងមេ Main UI
local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.45)
main.Size = UDim2.fromOffset(360, 270)
main.BackgroundColor3 = Themes[ThemeIndex].Main
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Visible = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1.8
stroke.Color = Themes[ThemeIndex].Accent
stroke.Transparency = 0.2
stroke.Parent = main

-- TopBar
local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 48)
top.BackgroundTransparency = 1
top.Parent = main

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(14, 6)
title.Size = UDim2.new(1, -90, 0, 22)
title.Font = Enum.Font.SourceSansBold
title.Text = "AKIRA SCRIPT"
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.new(1, 1, 1)
title.Parent = top

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.fromOffset(14, 26)
subtitle.Size = UDim2.new(1, -90, 0, 16)
subtitle.Font = Enum.Font.SourceSansBold
subtitle.Text = "ផ្ទាំងបញ្ជាទូរស័ព្ទ • កំណែពិសេស"
subtitle.TextSize = 13
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.TextColor3 = Color3.fromRGB(150, 175, 205)
subtitle.Parent = top

local function topButton(text, x)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(28, 28)
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

local close = topButton("×", -10)
local minimize = topButton("—", -44)

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.fromOffset(8, 54)
sidebar.Size = UDim2.new(0, 100, 1, -62)
sidebar.BackgroundColor3 = Themes[ThemeIndex].Panel
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 10)
sideCorner.Parent = sidebar

local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 116, 0, 54)
content.Size = UDim2.new(1, -124, 1, -62)
content.BackgroundTransparency = 1
content.Parent = main

-- Pages
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

    pages[name] = page
    return page
end

local scriptsPage = makePage("Scripts")
local configPage = makePage("Config")

local tabButtons = {}
local function makeTab(tabKey, displayText, yOffset)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -12, 0, 36)
    b.Position = UDim2.fromOffset(6, yOffset)
    b.BackgroundColor3 = (tabKey == currentTab) and Themes[ThemeIndex].Accent or Themes[ThemeIndex].Main
    b.BorderSizePixel = 0
    b.Text = displayText
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1, 1, 1)
    b.AutoButtonColor = false
    b.Parent = sidebar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b

    tabButtons[tabKey] = b

    b.Activated:Connect(function()
        currentTab = tabKey
        for k, btn in pairs(tabButtons) do
            btn.BackgroundColor3 = (k == currentTab) and Themes[ThemeIndex].Accent or Themes[ThemeIndex].Main
        end
        for k, p in pairs(pages) do
            p.Visible = (k == currentTab)
        end
    end)
    return b
end

makeTab("Scripts", "🛡 មុខងារ", 8)
makeTab("Config", "⚙ ការកំណត់", 50)

-- ============================================================
-- មុខងារ ANTI-HIT
-- ============================================================
local AntiHitEnabled = false
local IsAntiHitRunning = false

local antiHitCard = Instance.new("TextButton")
antiHitCard.Name = "AntiHit"
antiHitCard.Size = UDim2.new(1, -4, 0, 58)
antiHitCard.BackgroundColor3 = Themes[ThemeIndex].ButtonDark
antiHitCard.BorderSizePixel = 0
antiHitCard.Text = ""
antiHitCard.AutoButtonColor = false
antiHitCard.Parent = scriptsPage

local antiHitCorner = Instance.new("UICorner")
antiHitCorner.CornerRadius = UDim.new(0, 10)
antiHitCorner.Parent = antiHitCard

local antiHitTitle = Instance.new("TextLabel")
antiHitTitle.BackgroundTransparency = 1
antiHitTitle.Position = UDim2.fromOffset(12, 8)
antiHitTitle.Size = UDim2.new(1, -24, 0, 20)
antiHitTitle.Text = "🛡 ប្រព័ន្ធគេចការវាយ (Anti-Hit)"
antiHitTitle.Font = Enum.Font.SourceSansBold
antiHitTitle.TextSize = 15
antiHitTitle.TextColor3 = Color3.new(1, 1, 1)
antiHitTitle.TextXAlignment = Enum.TextXAlignment.Left
antiHitTitle.Parent = antiHitCard

local antiHitStatus = Instance.new("TextLabel")
antiHitStatus.BackgroundTransparency = 1
antiHitStatus.Position = UDim2.fromOffset(12, 30)
antiHitStatus.Size = UDim2.new(1, -24, 0, 18)
antiHitStatus.Text = "ស្ថានភាព៖ បិទ"
antiHitStatus.Font = Enum.Font.SourceSansBold
antiHitStatus.TextSize = 13
antiHitStatus.TextColor3 = Color3.fromRGB(255, 140, 140)
antiHitStatus.TextXAlignment = Enum.TextXAlignment.Left
antiHitStatus.Parent = antiHitCard

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
        task.wait(0.016)
    end
    IsAntiHitRunning = false
end

antiHitCard.Activated:Connect(function()
    AntiHitEnabled = not AntiHitEnabled
    if AntiHitEnabled then
        antiHitStatus.Text = "ស្ថានភាព៖ កំពុងបើកដំណើរការ"
        antiHitStatus.TextColor3 = Color3.fromRGB(110, 255, 145)
        antiHitCard.BackgroundColor3 = Color3.fromRGB(20, 85, 45)
    else
        antiHitStatus.Text = "ស្ថានភាព៖ បិទ"
        antiHitStatus.TextColor3 = Color3.fromRGB(255, 140, 140)
        antiHitCard.BackgroundColor3 = Themes[ThemeIndex].ButtonDark
    end
end)

ProximityPromptService.PromptTriggered:Connect(function(prompt, player)
    if player ~= Player then return end
    if not AntiHitEnabled or IsAntiHitRunning then return end
    local character = Player.Character
    if character then
        task.spawn(function()
            TeleportRoute(character)
        end)
    end
end)

-- ============================================================
-- ផ្ទាំង CONFIG
-- ============================================================
local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -4, 0, 36)
infoText.BackgroundTransparency = 1
infoText.Text = "ជ្រើសរើសពណ៌រូបរាង (Themes)"
infoText.Font = Enum.Font.SourceSansBold
infoText.TextSize = 14
infoText.TextColor3 = Color3.fromRGB(180, 200, 225)
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.Parent = configPage

for i, th in ipairs(Themes) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 36)
    b.Text = th.Name
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 13
    b.TextColor3 = Color3.new(1, 1, 1)
    b.BackgroundColor3 = th.Panel
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Parent = configPage
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 8)
    bc.Parent = b
    
    b.Activated:Connect(function()
        ThemeIndex = i
        main.BackgroundColor3 = th.Main
        sidebar.BackgroundColor3 = th.Panel
        stroke.Color = th.Accent
        if not AntiHitEnabled then
            antiHitCard.BackgroundColor3 = th.ButtonDark
        end
        for k, btn in pairs(tabButtons) do
            btn.BackgroundColor3 = (k == currentTab) and th.Accent or th.Main
        end
    end)
end

-- ============================================================
-- FLOATING LOGO BUTTON & DRAGGING
-- ============================================================
local openButton = Instance.new("ImageButton")
openButton.Name = "OpenAkira"
openButton.AnchorPoint = Vector2.new(1, 0.5)
openButton.Position = UDim2.new(1, -15, 0.5, 0)
openButton.Size = UDim2.fromOffset(55, 55)
openButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
openButton.BackgroundTransparency = 0.1
openButton.BorderSizePixel = 0
openButton.Image = AKIRA_LOGO_ID[span_1](start_span)[span_1](end_span)
openButton.ScaleType = Enum.ScaleType.Fit
openButton.AutoButtonColor = false
openButton.Visible = false
openButton.ZIndex = 999999
openButton.Parent = gui

local oc = Instance.new("UICorner")
oc.CornerRadius = UDim.new(1, 0)
oc.Parent = openButton

local openStroke = Instance.new("UIStroke")
openStroke.Thickness = 2
openStroke.Color = Color3.fromRGB(0, 175, 255)
openStroke.Parent = openButton

local function closeGui()
    main.Visible = false
    openButton.Visible = true
end

local function openGui()
    openButton.Visible = false
    main.Visible = true
end

close.Activated:Connect(closeGui)
minimize.Activated:Connect(closeGui)
openButton.Activated:Connect(openGui)

-- អូស Main UI លើអេក្រង់
local dragging = false
local dragStart, startPos
top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

-- អូស Floating Logo
local btnDragging = false
local btnDragStart, btnStartPos
openButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true
        btnDragStart = input.Position
        btnStartPos = openButton.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    elseif btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - btnDragStart
        openButton.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        btnDragging = false
    end
end)
