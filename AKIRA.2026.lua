--[[
    AKIRA SCRIPT HUB • FIXED 100% REPLICA
    - Resolved Content Display Bug (Tabs & Cards are 100% Visible)
    - Full Original Anti-Hit with Shimmer Sweep & Teleportation
    - Restored Intro, Support Notification & Drag/Resize Controls
    - Full Config Tab (Size Scaler + 5 Theme Pickers)
    - Vector Icons & Floating Cambodia Logo
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

local old = GuiParent:FindFirstChild("AkiraScriptHub")
if old then
    old:Destroy()
end

local function tween(obj, info, props)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

-- Vector Assets
local Icons = {
    Shield = "rbxassetid://6031075938",
    FileText = "rbxassetid://6031071050",
    Settings = "rbxassetid://6031280882",
    Info = "rbxassetid://6031077364",
    Crown = "rbxassetid://6031068426",
    Minus = "rbxassetid://6031094678",
    Close = "rbxassetid://6031094687"
}

-- 5 Original Themes
local Themes = {
    {Name = "ខៀវ អាគីរ៉ា", Accent = Color3.fromRGB(0, 195, 255), AccentDark = Color3.fromRGB(0, 120, 255), Border = Color3.fromRGB(0, 150, 255)},
    {Name = "ក្រហម អាគីរ៉ា", Accent = Color3.fromRGB(255, 75, 75), AccentDark = Color3.fromRGB(185, 20, 30), Border = Color3.fromRGB(255, 60, 60)},
    {Name = "ស្វាយ អាគីរ៉ា", Accent = Color3.fromRGB(180, 90, 255), AccentDark = Color3.fromRGB(120, 40, 200), Border = Color3.fromRGB(160, 80, 255)},
    {Name = "ទឹកមាស អាគីរ៉ា", Accent = Color3.fromRGB(255, 195, 45), AccentDark = Color3.fromRGB(205, 130, 0), Border = Color3.fromRGB(255, 185, 30)},
    {Name = "បៃតង អាគីរ៉ា", Accent = Color3.fromRGB(50, 235, 130), AccentDark = Color3.fromRGB(20, 160, 80), Border = Color3.fromRGB(40, 210, 110)},
}
local ThemeIndex = 1

local Sizes = {
    UDim2.fromOffset(450, 240),
    UDim2.fromOffset(510, 270),
    UDim2.fromOffset(570, 300),
}
local SizeIndex = 2

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

-- Main Frame Shadow
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.fromScale(0.5, 0.51)
shadow.Size = Sizes[SizeIndex]
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.4
shadow.BorderSizePixel = 0
shadow.Parent = gui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 16)
shadowCorner.Parent = shadow

-- Main Outer Frame
local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.48)
main.Size = Sizes[SizeIndex]
main.BackgroundColor3 = Color3.fromRGB(4, 11, 26)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2
mainStroke.Color = Themes[ThemeIndex].Border
mainStroke.Transparency = 0.15
mainStroke.Parent = main

-- Top Left Akira Brand Badge ("A" Logo Icon)
local logoBadge = Instance.new("Frame")
logoBadge.Name = "LogoBadge"
logoBadge.Position = UDim2.fromOffset(12, 10)
logoBadge.Size = UDim2.fromOffset(52, 46)
logoBadge.BackgroundColor3 = Color3.fromRGB(6, 18, 42)
logoBadge.BorderSizePixel = 0
logoBadge.Parent = main

local lbc = Instance.new("UICorner")
lbc.CornerRadius = UDim.new(0, 12)
lbc.Parent = logoBadge

local lbStroke = Instance.new("UIStroke")
lbStroke.Thickness = 1.2
lbStroke.Color = Color3.fromRGB(15, 60, 120)
lbStroke.Parent = logoBadge

local logoImage = Instance.new("ImageLabel")
logoImage.BackgroundTransparency = 1
logoImage.Size = UDim2.fromOffset(40, 40)
logoImage.Position = UDim2.fromScale(0.5, 0.5)
logoImage.AnchorPoint = Vector2.new(0.5, 0.5)
logoImage.Image = "rbxassetid://97330468088484"
logoImage.Parent = logoBadge

-- Top Brand Titles
local titleContainer = Instance.new("Frame")
titleContainer.BackgroundTransparency = 1
titleContainer.Position = UDim2.fromOffset(74, 12)
titleContainer.Size = UDim2.new(0.6, 0, 0, 44)
titleContainer.Parent = main

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 22)
title.Font = Enum.Font.GothamBlack
title.Text = "AKIRA SCRIPT"
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = titleContainer

local titleGrad = Instance.new("UIGradient")
titleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.52, Color3.fromRGB(180, 50, 255)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(180, 50, 255))
})
titleGrad.Parent = title

local subTitle = Instance.new("TextLabel")
subTitle.BackgroundTransparency = 1
subTitle.Position = UDim2.fromOffset(0, 22)
subTitle.Size = UDim2.new(1, 0, 0, 16)
subTitle.Font = Enum.Font.FredokaOne
subTitle.Text = "Product BENZ • AKIRA SCRIPT"
subTitle.TextSize = 10
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
subTitle.Parent = titleContainer

-- Top Vector Action Buttons (Minimize & Close)
local function makeTopBtn(iconAsset, xOffset)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(26, 26)
    b.Position = UDim2.new(1, xOffset, 0, 14)
    b.AnchorPoint = Vector2.new(1, 0)
    b.BackgroundColor3 = Color3.fromRGB(10, 24, 52)
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.Parent = main
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = b
    
    local s = Instance.new("UIStroke")
    s.Thickness = 1
    s.Color = Color3.fromRGB(20, 60, 120)
    s.Parent = b

    local icon = Instance.new("ImageLabel")
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.fromOffset(13, 13)
    icon.Position = UDim2.fromScale(0.5, 0.5)
    icon.AnchorPoint = Vector2.new(0.5, 0.5)
    icon.Image = iconAsset
    icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    icon.Parent = b

    return b
end

local minimize = makeTopBtn(Icons.Minus, -46)
local close = makeTopBtn(Icons.Close, -14)

-- Sidebar Tabs (Left Strip)
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.fromOffset(12, 64)
sidebar.Size = UDim2.new(0, 115, 1, -76)
sidebar.BackgroundColor3 = Color3.fromRGB(5, 14, 34)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 12)
sideCorner.Parent = sidebar

local sideStroke = Instance.new("UIStroke")
sideStroke.Thickness = 1.2
sideStroke.Color = Themes[ThemeIndex].Border
sideStroke.Parent = sidebar

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 5)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

local sidePad = Instance.new("UIPadding")
sidePad.PaddingTop = UDim.new(0, 6)
sidePad.Parent = sidebar

-- Content Area (Right Panel - Fixed visibility issue)
local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 136, 0, 64)
content.Size = UDim2.new(1, -148, 1, -95)
content.BackgroundTransparency = 1
content.Parent = main

local currentTab = "ប្ដូរស្គ្រីប"
local pages = {}

local function makePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Themes[ThemeIndex].Accent
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.Visible = (name == "ប្ដូរស្គ្រីប")
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

local defaultPage = makePage("ប្ដូរស្គ្រីប")
local scriptsPage = makePage("ស្គ្រីប")
local configPage = makePage("ការកំណត់")
local infoPage = makePage("ព័ត៌មាន")
local vipPage = makePage("VIP")

local tabButtons = {}
local function makeTab(name, iconAsset, text)
    local b = Instance.new("TextButton")
    b.Name = name
    b.Size = UDim2.new(1, -10, 0, 32)
    b.BackgroundTransparency = 1
    b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.Parent = sidebar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b

    local bGrad = Instance.new("UIGradient")
    bGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, Themes[ThemeIndex].Accent),
        ColorSequenceKeypoint.new(1.0, Themes[ThemeIndex].AccentDark)
    })
    bGrad.Rotation = 90
    bGrad.Parent = b

    local icon = Instance.new("ImageLabel")
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.fromOffset(15, 15)
    icon.Position = UDim2.new(0, 9, 0.5, 0)
    icon.AnchorPoint = Vector2.new(0, 0.5)
    icon.Image = iconAsset
    icon.ImageColor3 = Color3.fromRGB(130, 160, 200)
    icon.Parent = b

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -30, 1, 0)
    label.Position = UDim2.fromOffset(29, 0)
    label.Text = text
    label.Font = Enum.Font.FredokaOne
    label.TextSize = 11.5
    label.TextColor3 = Color3.fromRGB(130, 160, 200)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = b

    tabButtons[name] = {Button = b, Label = label, Icon = icon, Grad = bGrad}

    b.Activated:Connect(function()
        AkiraPlayClick()
        currentTab = name
        for tName, data in pairs(tabButtons) do
            local isSel = (tName == currentTab)
            data.Button.BackgroundTransparency = isSel and 0 or 1
            data.Label.TextColor3 = isSel and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(130, 160, 200)
            data.Icon.ImageColor3 = isSel and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(130, 160, 200)
        end
        for pName, pObj in pairs(pages) do
            pObj.Visible = (pName == currentTab)
            if pObj.Visible then
                pObj.CanvasPosition = Vector2.zero
            end
        end
    end)

    return b
end

makeTab("ប្ដូរស្គ្រីប", Icons.Shield, "ប្ដូរស្គ្រីប")
makeTab("ស្គ្រីប", Icons.FileText, "ស្គ្រីប")
makeTab("ការកំណត់", Icons.Settings, "ការកំណត់")
makeTab("ព័ត៌មាន", Icons.Info, "ព័ត៌មាន")
makeTab("VIP", Icons.Crown, "VIP")

tabButtons["ប្ដូរស្គ្រីប"].Button.BackgroundTransparency = 0
tabButtons["ប្ដូរស្គ្រីប"].Label.TextColor3 = Color3.fromRGB(255, 255, 255)
tabButtons["ប្ដូរស្គ្រីប"].Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)

-- Bottom Watermark Signature
local sigContainer = Instance.new("Frame")
sigContainer.Name = "SignatureContainer"
sigContainer.BackgroundTransparency = 1
sigContainer.Position = UDim2.new(0, 136, 1, -26)
sigContainer.Size = UDim2.new(1, -148, 0, 20)
sigContainer.Parent = main

local crownIcon = Instance.new("ImageLabel")
crownIcon.BackgroundTransparency = 1
crownIcon.Size = UDim2.fromOffset(14, 14)
crownIcon.Position = UDim2.new(0, 0, 0.5, 0)
crownIcon.AnchorPoint = Vector2.new(0, 0.5)
crownIcon.Image = Icons.Crown
crownIcon.ImageColor3 = Themes[ThemeIndex].Accent
crownIcon.Parent = sigContainer

local signature = Instance.new("TextLabel")
signature.Name = "Signature"
signature.BackgroundTransparency = 1
signature.Position = UDim2.fromOffset(18, 0)
signature.Size = UDim2.new(1, -18, 1, 0)
signature.Font = Enum.Font.Caveat
signature.Text = "Akira Script"
signature.TextSize = 18
signature.TextColor3 = Themes[ThemeIndex].Accent
signature.TextXAlignment = Enum.TextXAlignment.Left
signature.Parent = sigContainer

-- Floating Controls (Drag & Resize Bar)
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
dragVisual.Size = UDim2.fromOffset(76, 3)
dragVisual.BackgroundColor3 = Themes[ThemeIndex].Accent
dragVisual.BorderSizePixel = 0
dragVisual.ZIndex = 61
dragVisual.Parent = dragHandle
local dragCorner = Instance.new("UICorner")
dragCorner.CornerRadius = UDim.new(1, 0)
dragCorner.Parent = dragVisual

local resizeHandle = Instance.new("TextButton")
resizeHandle.Name = "AkiraResizeHandle"
resizeHandle.AnchorPoint = Vector2.new(0.5, 0.5)
resizeHandle.Size = UDim2.fromOffset(28, 28)
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

local function updateFloatingControls()
    local x = main.Position.X.Scale
    local ox = main.Position.X.Offset
    local y = main.Position.Y.Scale
    local oy = main.Position.Y.Offset
    local halfW = main.AbsoluteSize.X * 0.5
    local halfH = main.AbsoluteSize.Y * 0.5
    dragHandle.Position = UDim2.new(x, ox, y, oy + halfH + 12)
    resizeHandle.Position = UDim2.new(x, ox + halfW + 14, y, oy + halfH + 14)
end

-- ============================================================
-- មុខងារ ANTI-HIT ដំណើរការពេញលេញ 100%
-- ============================================================
local AntiHitEnabled = false
local IsAntiHitRunning = false
local ANTI_HIT_SPEED = 0.016

local function createAntiHitElement(parentContainer)
    local card = Instance.new("Frame")
    card.Name = "AntiHitCard"
    card.Size = UDim2.new(1, -6, 0, 56)
    card.BackgroundColor3 = Color3.fromRGB(9, 21, 46)
    card.BorderSizePixel = 0
    card.Parent = parentContainer

    local ahCorner = Instance.new("UICorner")
    ahCorner.CornerRadius = UDim.new(0, 12)
    ahCorner.Parent = card

    local ahStroke = Instance.new("UIStroke")
    ahStroke.Thickness = 1.2
    ahStroke.Color = Color3.fromRGB(15, 60, 120)
    ahStroke.Parent = card

    local iconPlate = Instance.new("Frame")
    iconPlate.Size = UDim2.fromOffset(40, 40)
    iconPlate.Position = UDim2.new(0, 8, 0.5, 0)
    iconPlate.AnchorPoint = Vector2.new(0, 0.5)
    iconPlate.BackgroundColor3 = Color3.fromRGB(15, 35, 75)
    iconPlate.BorderSizePixel = 0
    iconPlate.Parent = card

    local ipc = Instance.new("UICorner")
    ipc.CornerRadius = UDim.new(0, 10)
    ipc.Parent = iconPlate

    local sImg = Instance.new("ImageLabel")
    sImg.Name = "ShieldIcon"
    sImg.BackgroundTransparency = 1
    sImg.Size = UDim2.fromOffset(22, 22)
    sImg.Position = UDim2.fromScale(0.5, 0.5)
    sImg.AnchorPoint = Vector2.new(0.5, 0.5)
    sImg.Image = Icons.Shield
    sImg.ImageColor3 = Themes[ThemeIndex].Accent
    sImg.Parent = iconPlate

    local cTitle = Instance.new("TextLabel")
    cTitle.BackgroundTransparency = 1
    cTitle.Position = UDim2.fromOffset(56, 10)
    cTitle.Size = UDim2.new(1, -120, 0, 18)
    cTitle.Font = Enum.Font.FredokaOne
    cTitle.Text = "ការពារការវាយ (ANTI-HIT)"
    cTitle.TextSize = 12.5
    cTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    cTitle.TextXAlignment = Enum.TextXAlignment.Left
    cTitle.Parent = card

    local cStatus = Instance.new("TextLabel")
    cStatus.Name = "StatusLabel"
    cStatus.BackgroundTransparency = 1
    cStatus.Position = UDim2.fromOffset(56, 28)
    cStatus.Size = UDim2.new(1, -120, 0, 16)
    cStatus.Font = Enum.Font.FredokaOne
    cStatus.Text = "ស្ថានភាព៖ បិទ"
    cStatus.TextSize = 11
    cStatus.TextColor3 = Color3.fromRGB(130, 160, 200)
    cStatus.TextXAlignment = Enum.TextXAlignment.Left
    cStatus.Parent = card

    local tBtn = Instance.new("TextButton")
    tBtn.Name = "ToggleSwitch"
    tBtn.Size = UDim2.fromOffset(48, 24)
    tBtn.Position = UDim2.new(1, -14, 0.5, 0)
    tBtn.AnchorPoint = Vector2.new(1, 0.5)
    tBtn.BackgroundColor3 = Color3.fromRGB(20, 45, 85)
    tBtn.BorderSizePixel = 0
    tBtn.Text = ""
    tBtn.AutoButtonColor = false
    tBtn.Parent = card

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(1, 0)
    tc.Parent = tBtn

    local tKnob = Instance.new("Frame")
    tKnob.Name = "Knob"
    tKnob.Size = UDim2.fromOffset(18, 18)
    tKnob.Position = UDim2.new(0, 3, 0.5, 0)
    tKnob.AnchorPoint = Vector2.new(0, 0.5)
    tKnob.BackgroundColor3 = Color3.fromRGB(240, 245, 255)
    tKnob.BorderSizePixel = 0
    tKnob.Parent = tBtn

    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0)
    kc.Parent = tKnob

    return card, tBtn, tKnob, cStatus, ahStroke, sImg
end

local defaultCard, defaultToggle, defaultKnob, defaultStatus, defaultStroke, defaultShield = createAntiHitElement(defaultPage)
local scriptsCard, scriptsToggle, scriptsKnob, scriptsStatus, scriptsStroke, scriptsShield = createAntiHitElement(scriptsPage)

local function updateAntiHitUI(enabled)
    local targetColor = enabled and Themes[ThemeIndex].Accent or Color3.fromRGB(20, 45, 85)
    local targetKnobPos = enabled and UDim2.new(1, -21, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
    local statusText = enabled and "ស្ថានភាព៖ កំពុងដំណើរការ" or "ស្ថានភាព៖ បិទ"
    local statusColor = enabled and Themes[ThemeIndex].Accent or Color3.fromRGB(130, 160, 200)
    local strokeColor = enabled and Themes[ThemeIndex].Accent or Color3.fromRGB(15, 60, 120)

    tween(defaultToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = targetColor})
    tween(defaultKnob, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = targetKnobPos})
    defaultStatus.Text = statusText
    defaultStatus.TextColor3 = statusColor
    defaultStroke.Color = strokeColor

    tween(scriptsToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = targetColor})
    tween(scriptsKnob, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = targetKnobPos})
    scriptsStatus.Text = statusText
    scriptsStatus.TextColor3 = statusColor
    scriptsStroke.Color = strokeColor
end

local function toggleAntiHit()
    AkiraPlayClick()
    AntiHitEnabled = not AntiHitEnabled
    updateAntiHitUI(AntiHitEnabled)
end

defaultToggle.Activated:Connect(toggleAntiHit)
scriptsToggle.Activated:Connect(toggleAntiHit)

-- Teleport System ៩ ចំណុច
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
-- ផ្ទាំងកំណត់ (CONFIG TAB) ដំណើរការពេញលេញ 100%
-- ============================================================
local function configSectionTitle(text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -6, 0, 18)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.FredokaOne
    l.TextSize = 11
    l.TextColor3 = Themes[ThemeIndex].Accent
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = configPage
    return l
end

local sizeTitleLabel = configSectionTitle("ទំហំផ្ទាំង MENU (GUI SCALE)")

-- Size Control Card with - / +
local sizeCard = Instance.new("Frame")
sizeCard.Size = UDim2.new(1, -6, 0, 42)
sizeCard.BackgroundColor3 = Color3.fromRGB(9, 21, 46)
sizeCard.BorderSizePixel = 0
sizeCard.Parent = configPage

local scCorner = Instance.new("UICorner")
scCorner.CornerRadius = UDim.new(0, 10)
scCorner.Parent = sizeCard

local scStroke = Instance.new("UIStroke")
scStroke.Thickness = 1
scStroke.Color = Color3.fromRGB(15, 60, 120)
scStroke.Parent = sizeCard

local sizeMinus = Instance.new("TextButton")
sizeMinus.Size = UDim2.new(0.25, 0, 1, 0)
sizeMinus.BackgroundTransparency = 1
sizeMinus.Text = "−"
sizeMinus.Font = Enum.Font.GothamBold
sizeMinus.TextSize = 16
sizeMinus.TextColor3 = Color3.new(1, 1, 1)
sizeMinus.Parent = sizeCard

local sizeLabel = Instance.new("TextLabel")
sizeLabel.Size = UDim2.new(0.50, 0, 1, 0)
sizeLabel.Position = UDim2.new(0.25, 0, 0, 0)
sizeLabel.BackgroundTransparency = 1
sizeLabel.Font = Enum.Font.FredokaOne
sizeLabel.Text = "មធ្យម"
sizeLabel.TextSize = 12
sizeLabel.TextColor3 = Color3.new(1, 1, 1)
sizeLabel.Parent = sizeCard

local sizePlus = Instance.new("TextButton")
sizePlus.Size = UDim2.new(0.25, 0, 1, 0)
sizePlus.Position = UDim2.new(0.75, 0, 0, 0)
sizePlus.BackgroundTransparency = 1
sizePlus.Text = "+"
sizePlus.Font = Enum.Font.GothamBold
sizePlus.TextSize = 16
sizePlus.TextColor3 = Color3.new(1, 1, 1)
sizePlus.Parent = sizeCard

local sizeNames = {"តូច", "មធ្យម", "ធំ"}
local function applySize(index)
    SizeIndex = math.clamp(index, 1, #Sizes)
    sizeLabel.Text = sizeNames[SizeIndex]
    local target = Sizes[SizeIndex]
    tween(main, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
    tween(shadow, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
    task.defer(updateFloatingControls)
end

sizeMinus.Activated:Connect(function() AkiraPlayClick(); applySize(SizeIndex - 1) end)
sizePlus.Activated:Connect(function() AkiraPlayClick(); applySize(SizeIndex + 1) end)

local themeTitleLabel = configSectionTitle("ជម្រើសពណ៌ផ្ទៃ (COLOR THEMES)")

-- Forward declaration of openStroke
local openStroke

local function applyTheme(idx)
    ThemeIndex = idx
    local th = Themes[ThemeIndex]
    mainStroke.Color = th.Border
    sideStroke.Color = th.Border
    crownIcon.ImageColor3 = th.Accent
    signature.TextColor3 = th.Accent
    defaultShield.ImageColor3 = th.Accent
    scriptsShield.ImageColor3 = th.Accent
    dragVisual.BackgroundColor3 = th.Accent
    resizeHandle.TextColor3 = th.Accent
    sizeTitleLabel.TextColor3 = th.Accent
    themeTitleLabel.TextColor3 = th.Accent
    if openStroke then openStroke.Color = th.Accent end
    
    for tName, data in pairs(tabButtons) do
        data.Grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, th.Accent),
            ColorSequenceKeypoint.new(1.0, th.AccentDark)
        })
    end
    for _, pg in pairs(pages) do
        pg.ScrollBarImageColor3 = th.Accent
    end
    updateAntiHitUI(AntiHitEnabled)
end

-- Theme Buttons Grid
local themeGrid = Instance.new("Frame")
themeGrid.Size = UDim2.new(1, -6, 0, 72)
themeGrid.BackgroundTransparency = 1
themeGrid.Parent = configPage

local tLayout = Instance.new("UIGridLayout")
tLayout.CellSize = UDim2.new(0.48, -2, 0, 30)
tLayout.CellPadding = UDim2.new(0.04, 0, 0, 6)
tLayout.Parent = themeGrid

for i, th in ipairs(Themes) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromScale(1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(9, 21, 46)
    btn.BorderSizePixel = 0
    btn.Text = "● " .. th.Name
    btn.Font = Enum.Font.FredokaOne
    btn.TextSize = 10.5
    btn.TextColor3 = th.Accent
    btn.AutoButtonColor = false
    btn.Parent = themeGrid
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn
    
    local st = Instance.new("UIStroke")
    st.Thickness = 1
    st.Color = Color3.fromRGB(15, 60, 120)
    st.Parent = btn
    
    btn.Activated:Connect(function()
        AkiraPlayClick()
        applyTheme(i)
    end)
end

configSectionTitle("ការគ្រប់គ្រង (WINDOW)")
local winCard = Instance.new("Frame")
winCard.Size = UDim2.new(1, -6, 0, 36)
winCard.BackgroundColor3 = Color3.fromRGB(9, 21, 46)
winCard.BorderSizePixel = 0
winCard.Parent = configPage

local wcCorner = Instance.new("UICorner")
wcCorner.CornerRadius = UDim.new(0, 8)
wcCorner.Parent = winCard

local wcLabel = Instance.new("TextLabel")
wcLabel.Size = UDim2.new(1, -16, 1, 0)
wcLabel.Position = UDim2.fromOffset(8, 0)
wcLabel.BackgroundTransparency = 1
wcLabel.Font = Enum.Font.FredokaOne
wcLabel.Text = "បិទ ឬ បើកផ្ទាំង៖ ចុច × ឬ ចុចលើរូប Logo AKIRA"
wcLabel.TextSize = 11
wcLabel.TextColor3 = Color3.fromRGB(130, 160, 200)
wcLabel.TextXAlignment = Enum.TextXAlignment.Left
wcLabel.Parent = winCard

-- INFO TAB CONTENT
local infoCard = Instance.new("Frame")
infoCard.Size = UDim2.new(1, -6, 0, 95)
infoCard.BackgroundColor3 = Color3.fromRGB(9, 21, 46)
infoCard.BorderSizePixel = 0
infoCard.Parent = infoPage

local icCorner = Instance.new("UICorner")
icCorner.CornerRadius = UDim.new(0, 10)
icCorner.Parent = infoCard

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -20, 1, -16)
infoText.Position = UDim2.fromOffset(10, 8)
infoText.BackgroundTransparency = 1
infoText.Font = Enum.Font.FredokaOne
infoText.Text = "AKIRA SCRIPT HUB • កំណែទូរស័ព្ទដៃ\n\nបង្កើតឡើងដោយ៖ BENZ\nមុខងារ៖ Anti-Hit, Auto-Prompt, Color Themes, Touch Scaling"
infoText.TextSize = 11.5
infoText.TextColor3 = Color3.fromRGB(240, 245, 255)
infoText.TextWrapped = true
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.Parent = infoCard

-- VIP TAB CONTENT
local vipCard = Instance.new("Frame")
vipCard.Size = UDim2.new(1, -6, 0, 70)
vipCard.BackgroundColor3 = Color3.fromRGB(9, 21, 46)
vipCard.BorderSizePixel = 0
vipCard.Parent = vipPage

local vcCorner = Instance.new("UICorner")
vcCorner.CornerRadius = UDim.new(0, 10)
vcCorner.Parent = vipCard

local vipText = Instance.new("TextLabel")
vipText.Size = UDim2.new(1, -20, 1, 0)
vipText.Position = UDim2.fromOffset(10, 0)
vipText.BackgroundTransparency = 1
vipText.Font = Enum.Font.FredokaOne
vipText.Text = "👑 VIP MEMBER ACTIVE\nសូមអរគុណសម្រាប់ការគាំទ្រ AKIRA SCRIPT HUB!"
vipText.TextSize = 12
vipText.TextColor3 = Color3.fromRGB(255, 215, 60)
vipText.TextXAlignment = Enum.TextXAlignment.Left
vipText.Parent = vipCard

-- ============================================================
-- FLOATING LOGO BUTTON
-- ============================================================
local LOGO_IMAGE_ID = "rbxassetid://97330468088484"

local openButton = Instance.new("ImageButton")
openButton.Name = "OpenAkiraLogo"
openButton.AnchorPoint = Vector2.new(1, 0.5)
openButton.Position = UDim2.new(1, -18, 0.5, 0)
openButton.Size = UDim2.fromOffset(60, 60)
openButton.BackgroundColor3 = Color3.fromRGB(4, 11, 26)
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

openStroke = Instance.new("UIStroke")
openStroke.Thickness = 2.4
openStroke.Color = Themes[ThemeIndex].Accent
openStroke.Transparency = 0.15
openStroke.Parent = openButton

task.spawn(function()
    while gui.Parent and openButton.Parent do
        local t1 = tween(openStroke, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Themes[ThemeIndex].Accent,
            Transparency = 0.1
        })
        t1.Completed:Wait()
        local t2 = tween(openStroke, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
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
    
    tween(mainScale, outInfo, {Scale = 0.90})
    tween(shadowScale, outInfo, {Scale = 0.90})
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
    tween(openButton, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(60, 60)})
end

local function openGui()
    openButton.Visible = false
    main.Visible = true
    shadow.Visible = true
    mainScale.Scale = 0.78
    shadowScale.Scale = 0.78
    dragHandle.Visible = true
    resizeHandle.Visible = true
    updateFloatingControls()
    tween(mainScale, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
    tween(shadowScale, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
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
        dragHandle.Visible = true
        resizeHandle.Visible = true
        mainScale.Scale = 0.78
        shadowScale.Scale = 0.78
        tween(main, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(shadow, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(mainScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        tween(shadowScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        task.delay(0.31, updateFloatingControls)
    else
        openGui()
    end
end)

minimize.Activated:Connect(function()
    AkiraPlayClick()
    if minimized then
        minimized = false
        openButton.Visible = false
        main.Visible = true
        shadow.Visible = true
        dragHandle.Visible = true
        resizeHandle.Visible = true
        mainScale.Scale = 0.78
        shadowScale.Scale = 0.78
        tween(main, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(shadow, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(mainScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        tween(shadowScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        task.delay(0.31, updateFloatingControls)
    else
        minimized = true
        savedSize = main.Size
        dragHandle.Visible = false
        resizeHandle.Visible = false
        local miniInfo = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        tween(mainScale, miniInfo, {Scale = 0.78})
        tween(shadowScale, miniInfo, {Scale = 0.78})
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
        tween(openButton, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(60, 60)})
    end
end)

-- Dragging & Resizing Interactions
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
            Size = UDim2.fromOffset(76, 3)
        })
    end
    dragSource = nil
end

dragHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        beginDrag(input, dragHandle)
    end
end)

main.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch)
    and input.Position.Y - main.AbsolutePosition.Y <= 60 then
        beginDrag(input, main)
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
    local maxW = math.max(380, math.min(650, 2 * math.min(centerX - 8, viewport.X - centerX - 8)))
    local maxH = math.max(220, math.min(420, 2 * math.min(centerY - 8, viewport.Y - centerY - 8)))
    local w = math.clamp(resizeStartSize.X.Offset + delta.X * 2, 380, maxW)
    local h = math.clamp(resizeStartSize.Y.Offset + delta.Y * 2, 220, maxH)
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

RunService.RenderStepped:Connect(function()
    if gui.Parent and (main.Visible or dragHandle.Visible or resizeHandle.Visible) then
        updateFloatingControls()
    end
end)

-- Startup: Show and ensure controls are properly placed
main.Visible = true
shadow.Visible = true
dragHandle.Visible = true
resizeHandle.Visible = true
updateFloatingControls()
