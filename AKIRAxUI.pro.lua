--[[
    AKIRA SCRIPT HUB • FIXED & WORKING 100%
    រូបរាងដូចរូបថត 100% + មុខងារដំណើរការទាំងអស់ពិតប្រាកដ
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

-- សម្លេង Click
local AkiraClickSound = Instance.new("Sound")
AkiraClickSound.Name = "AkiraClick"
AkiraClickSound.SoundId = "rbxassetid://6026984224"
AkiraClickSound.Volume = 0.35
AkiraClickSound.Parent = SoundService

local function playClick()
    pcall(function()
        AkiraClickSound:Stop()
        AkiraClickSound.TimePosition = 0
        AkiraClickSound:Play()
    end)
end

-- លុប Script ចាស់ចោលការពារជាន់គ្នា
local old = GuiParent:FindFirstChild("AkiraScriptHub")
if old then old:Destroy() end

local function tween(obj, info, props)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

-- Assets & Themes
local LOGO_ID = "rbxassetid://97330468088484"
local SHIELD_ICON = "rbxassetid://6031075938"
local CROWN_ICON = "rbxassetid://6031068426"

local Themes = {
    {Name = "ខៀវ អាគីរ៉ា", Accent = Color3.fromRGB(0, 195, 255), AccentDark = Color3.fromRGB(0, 110, 230), Border = Color3.fromRGB(0, 150, 255)},
    {Name = "ក្រហម អាគីរ៉ា", Accent = Color3.fromRGB(255, 65, 65), AccentDark = Color3.fromRGB(180, 20, 30), Border = Color3.fromRGB(255, 50, 50)},
    {Name = "ស្វាយ អាគីរ៉ា", Accent = Color3.fromRGB(180, 85, 255), AccentDark = Color3.fromRGB(120, 35, 195), Border = Color3.fromRGB(160, 75, 255)},
    {Name = "ទឹកមាស អាគីរ៉ា", Accent = Color3.fromRGB(255, 190, 40), AccentDark = Color3.fromRGB(200, 125, 0), Border = Color3.fromRGB(255, 180, 25)},
    {Name = "បៃតង អាគីរ៉ា", Accent = Color3.fromRGB(45, 230, 120), AccentDark = Color3.fromRGB(15, 155, 75), Border = Color3.fromRGB(35, 205, 100)},
}
local ThemeIndex = 1

local Sizes = {
    UDim2.fromOffset(460, 245),
    UDim2.fromOffset(520, 275),
    UDim2.fromOffset(580, 305),
}
local SizeIndex = 2

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "AkiraScriptHub"
gui.ResetOnSpawn = false
gui.DisplayOrder = 9999
gui.Parent = GuiParent

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
mainStroke.Parent = main

-- Top Left Brand Badge ("A" Logo Icon)
local logoBadge = Instance.new("Frame")
logoBadge.Position = UDim2.fromOffset(12, 10)
logoBadge.Size = UDim2.fromOffset(48, 44)
logoBadge.BackgroundColor3 = Color3.fromRGB(6, 18, 42)
logoBadge.BorderSizePixel = 0
logoBadge.Parent = main

local lbc = Instance.new("UICorner")
lbc.CornerRadius = UDim.new(0, 10)
lbc.Parent = logoBadge

local lbStroke = Instance.new("UIStroke")
lbStroke.Thickness = 1
lbStroke.Color = Color3.fromRGB(15, 60, 120)
lbStroke.Parent = logoBadge

local logoImg = Instance.new("ImageLabel")
logoImg.BackgroundTransparency = 1
logoImg.Size = UDim2.fromOffset(38, 38)
logoImg.Position = UDim2.fromScale(0.5, 0.5)
logoImg.AnchorPoint = Vector2.new(0.5, 0.5)
logoImg.Image = LOGO_ID
logoImg.Parent = logoBadge

-- Top Brand Header
local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(68, 12)
title.Size = UDim2.new(0.6, 0, 0, 20)
title.Font = Enum.Font.GothamBlack
title.Text = "AKIRA SCRIPT"
title.TextSize = 17
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local titleGrad = Instance.new("UIGradient")
titleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(190, 60, 255)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(190, 60, 255))
})
titleGrad.Parent = title

local subTitle = Instance.new("TextLabel")
subTitle.BackgroundTransparency = 1
subTitle.Position = UDim2.fromOffset(68, 32)
subTitle.Size = UDim2.new(0.6, 0, 0, 15)
subTitle.Font = Enum.Font.FredokaOne
subTitle.Text = "Product BENZ • AKIRA SCRIPT"
subTitle.TextSize = 10
subTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.Parent = main

-- Top Buttons
local function makeTopBtn(text, x)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(26, 26)
    b.Position = UDim2.new(1, x, 0, 14)
    b.BackgroundColor3 = Color3.fromRGB(10, 24, 52)
    b.BorderSizePixel = 0
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.AutoButtonColor = false
    b.Parent = main
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b
    return b
end

local minimize = makeTopBtn("—", -44)
local close = makeTopBtn("×", -14)

-- Sidebar (Left)
local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.fromOffset(12, 60)
sidebar.Size = UDim2.new(0, 115, 1, -72)
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

-- Content Area (Right Container)
local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 135, 0, 60)
content.Size = UDim2.new(1, -147, 1, -88)
content.BackgroundTransparency = 1
content.Parent = main

-- Tab System Setup
local tabList = {"ប្ដូរស្គ្រីប", "ស្គ្រីប", "ការកំណត់", "ព័ត៌មាន", "VIP"}
local tabIcons = {
    ["ប្ដូរស្គ្រីប"] = SHIELD_ICON,
    ["ស្គ្រីប"] = "rbxassetid://6031071050",
    ["ការកំណត់"] = "rbxassetid://6031280882",
    ["ព័ត៌មាន"] = "rbxassetid://6031077364",
    ["VIP"] = CROWN_ICON
}

local pages = {}
local tabButtons = {}

for _, name in ipairs(tabList) do
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "_Page"
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = Themes[ThemeIndex].Accent
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = (name == "ប្ដូរស្គ្រីប" or name == "ស្គ្រីប")
    page.Parent = content

    local playout = Instance.new("UIListLayout")
    playout.Padding = UDim.new(0, 8)
    playout.SortOrder = Enum.SortOrder.LayoutOrder
    playout.Parent = page

    local ppad = Instance.new("UIPadding")
    ppad.PaddingRight = UDim.new(0, 6)
    ppad.Parent = page

    pages[name] = page

    -- Tab Button
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 32)
    b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    b.BackgroundTransparency = (name == "ប្ដូរស្គ្រីប") and 0 or 1
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.Parent = sidebar

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 8)
    bc.Parent = b

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
    icon.Position = UDim2.new(0, 8, 0.5, 0)
    icon.AnchorPoint = Vector2.new(0, 0.5)
    icon.Image = tabIcons[name]
    icon.ImageColor3 = (name == "ប្ដូរស្គ្រីប") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(130, 160, 200)
    icon.Parent = b

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -28, 1, 0)
    label.Position = UDim2.fromOffset(28, 0)
    label.Text = name
    label.Font = Enum.Font.FredokaOne
    label.TextSize = 11.5
    label.TextColor3 = (name == "ប្ដូរស្គ្រីប") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(130, 160, 200)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = b

    tabButtons[name] = {Button = b, Label = label, Icon = icon, Grad = bGrad}

    b.Activated:Connect(function()
        playClick()
        for tName, data in pairs(tabButtons) do
            local isSel = (tName == name)
            data.Button.BackgroundTransparency = isSel and 0 or 1
            data.Label.TextColor3 = isSel and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(130, 160, 200)
            data.Icon.ImageColor3 = isSel and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(130, 160, 200)
        end
        for pName, pFrame in pairs(pages) do
            pFrame.Visible = (pName == name)
        end
    end)
end

-- Watermark Signature ខាងក្រោម
local sigContainer = Instance.new("Frame")
sigContainer.BackgroundTransparency = 1
sigContainer.Position = UDim2.new(0, 136, 1, -26)
sigContainer.Size = UDim2.new(1, -148, 0, 20)
sigContainer.Parent = main

local crownIcon = Instance.new("ImageLabel")
crownIcon.BackgroundTransparency = 1
crownIcon.Size = UDim2.fromOffset(14, 14)
crownIcon.Position = UDim2.new(0, 0, 0.5, 0)
crownIcon.AnchorPoint = Vector2.new(0, 0.5)
crownIcon.Image = CROWN_ICON
crownIcon.ImageColor3 = Themes[ThemeIndex].Accent
crownIcon.Parent = sigContainer

local signature = Instance.new("TextLabel")
signature.BackgroundTransparency = 1
signature.Position = UDim2.fromOffset(18, 0)
signature.Size = UDim2.new(1, -18, 1, 0)
signature.Font = Enum.Font.Caveat
signature.Text = "Akira Script"
signature.TextSize = 18
signature.TextColor3 = Themes[ThemeIndex].Accent
signature.TextXAlignment = Enum.TextXAlignment.Left
signature.Parent = sigContainer

-- ============================================================
-- មុខងារ ANTI-HIT ដំណើរការពេញលេញ (WORKING ANTI-HIT ENGINE)
-- ============================================================
local AntiHitEnabled = false
local IsAntiHitRunning = false
local ANTI_HIT_SPEED = 0.016

local function buildAntiHitCard(parentFrame)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -4, 0, 58)
    card.BackgroundColor3 = Color3.fromRGB(9, 21, 46)
    card.BorderSizePixel = 0
    card.Parent = parentFrame

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 12)
    cardCorner.Parent = card

    local cardStroke = Instance.new("UIStroke")
    cardStroke.Thickness = 1.2
    cardStroke.Color = Color3.fromRGB(15, 60, 120)
    cardStroke.Parent = card

    local iconPlate = Instance.new("Frame")
    iconPlate.Size = UDim2.fromOffset(40, 40)
    iconPlate.Position = UDim2.new(0, 9, 0.5, 0)
    iconPlate.AnchorPoint = Vector2.new(0, 0.5)
    iconPlate.BackgroundColor3 = Color3.fromRGB(15, 35, 75)
    iconPlate.BorderSizePixel = 0
    iconPlate.Parent = card

    local ipc = Instance.new("UICorner")
    ipc.CornerRadius = UDim.new(0, 10)
    ipc.Parent = iconPlate

    local sImg = Instance.new("ImageLabel")
    sImg.BackgroundTransparency = 1
    sImg.Size = UDim2.fromOffset(22, 22)
    sImg.Position = UDim2.fromScale(0.5, 0.5)
    sImg.AnchorPoint = Vector2.new(0.5, 0.5)
    sImg.Image = SHIELD_ICON
    sImg.ImageColor3 = Themes[ThemeIndex].Accent
    sImg.Parent = iconPlate

    local titleLbl = Instance.new("TextLabel")
    titleLbl.BackgroundTransparency = 1
    titleLbl.Position = UDim2.fromOffset(58, 10)
    titleLbl.Size = UDim2.new(1, -125, 0, 18)
    titleLbl.Font = Enum.Font.FredokaOne
    titleLbl.Text = "ការពារការវាយ (ANTI-HIT)"
    titleLbl.TextSize = 13
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = card

    local statusLbl = Instance.new("TextLabel")
    statusLbl.BackgroundTransparency = 1
    statusLbl.Position = UDim2.fromOffset(58, 30)
    statusLbl.Size = UDim2.new(1, -125, 0, 16)
    statusLbl.Font = Enum.Font.FredokaOne
    statusLbl.Text = "ស្ថានភាព៖ បិទ"
    statusLbl.TextSize = 11
    statusLbl.TextColor3 = Color3.fromRGB(130, 160, 200)
    statusLbl.TextXAlignment = Enum.TextXAlignment.Left
    statusLbl.Parent = card

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.fromOffset(48, 24)
    toggle.Position = UDim2.new(1, -12, 0.5, 0)
    toggle.AnchorPoint = Vector2.new(1, 0.5)
    toggle.BackgroundColor3 = Color3.fromRGB(20, 45, 85)
    toggle.BorderSizePixel = 0
    toggle.Text = ""
    toggle.AutoButtonColor = false
    toggle.Parent = card

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(1, 0)
    tc.Parent = toggle

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(18, 18)
    knob.Position = UDim2.new(0, 3, 0.5, 0)
    knob.AnchorPoint = Vector2.new(0, 0.5)
    knob.BackgroundColor3 = Color3.fromRGB(240, 245, 255)
    knob.BorderSizePixel = 0
    knob.Parent = toggle

    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0)
    kc.Parent = knob

    return {Card = card, Toggle = toggle, Knob = knob, Status = statusLbl, Stroke = cardStroke, Shield = sImg}
end

-- បង្កើត Card ទាំងលើ Tab "ប្ដូរស្គ្រីប" និង "ស្គ្រីប" ដើម្បីកុំឱ្យបាត់
local antiHit1 = buildAntiHitCard(pages["ប្ដូរស្គ្រីប"])
local antiHit2 = buildAntiHitCard(pages["ស្គ្រីប"])

local function updateAntiHitUI(enabled)
    local targetColor = enabled and Themes[ThemeIndex].Accent or Color3.fromRGB(20, 45, 85)
    local knobPos = enabled and UDim2.new(1, -21, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
    local stText = enabled and "ស្ថានភាព៖ កំពុងដំណើរការ" or "ស្ថានភាព៖ បិទ"
    local stColor = enabled and Themes[ThemeIndex].Accent or Color3.fromRGB(130, 160, 200)
    local strkColor = enabled and Themes[ThemeIndex].Accent or Color3.fromRGB(15, 60, 120)

    for _, ui in ipairs({antiHit1, antiHit2}) do
        tween(ui.Toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = targetColor})
        tween(ui.Knob, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = knobPos})
        ui.Status.Text = stText
        ui.Status.TextColor3 = stColor
        ui.Stroke.Color = strkColor
    end
end

local function toggleAntiHit()
    playClick()
    AntiHitEnabled = not AntiHitEnabled
    updateAntiHitUI(AntiHitEnabled)
end

antiHit1.Toggle.Activated:Connect(toggleAntiHit)
antiHit2.Toggle.Activated:Connect(toggleAntiHit)

-- ប្រព័ន្ធ Teleport ៩ ចំណុចដើម
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
local cfgPage = pages["ការកំណត់"]

local function makeConfigLabel(txt)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -4, 0, 18)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.Font = Enum.Font.FredokaOne
    l.TextSize = 11.5
    l.TextColor3 = Themes[ThemeIndex].Accent
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = cfgPage
    return l
end

local sizeTitle = makeConfigLabel("ទំហំផ្ទាំង MENU (GUI SCALE)")

-- Size Buttons (− / +)
local sizeCard = Instance.new("Frame")
sizeCard.Size = UDim2.new(1, -4, 0, 40)
sizeCard.BackgroundColor3 = Color3.fromRGB(9, 21, 46)
sizeCard.BorderSizePixel = 0
sizeCard.Parent = cfgPage

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
sizeLabel.Size = UDim2.new(0.5, 0, 1, 0)
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
end

sizeMinus.Activated:Connect(function() playClick(); applySize(SizeIndex - 1) end)
sizePlus.Activated:Connect(function() playClick(); applySize(SizeIndex + 1) end)

local themeTitle = makeConfigLabel("ជម្រើសពណ៌ THEME (COLORWAYS)")

-- Forward declaration of openStroke
local openStroke

local function applyTheme(idx)
    ThemeIndex = idx
    local th = Themes[ThemeIndex]
    mainStroke.Color = th.Border
    sideStroke.Color = th.Border
    crownIcon.ImageColor3 = th.Accent
    signature.TextColor3 = th.Accent
    sizeTitle.TextColor3 = th.Accent
    themeTitle.TextColor3 = th.Accent
    antiHit1.Shield.ImageColor3 = th.Accent
    antiHit2.Shield.ImageColor3 = th.Accent
    if openStroke then openStroke.Color = th.Accent end

    for _, data in pairs(tabButtons) do
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
themeGrid.Size = UDim2.new(1, -4, 0, 68)
themeGrid.BackgroundTransparency = 1
themeGrid.Parent = cfgPage

local tLayout = Instance.new("UIGridLayout")
tLayout.CellSize = UDim2.new(0.48, -2, 0, 30)
tLayout.CellPadding = UDim2.new(0.04, 0, 0, 6)
tLayout.Parent = themeGrid

for i, th in ipairs(Themes) do
    local btn = Instance.new("TextButton")
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
        playClick()
        applyTheme(i)
    end)
end

-- ============================================================
-- ផ្ទាំងព័ត៌មាន (INFO) & VIP TAB
-- ============================================================
local infoCard = Instance.new("Frame")
infoCard.Size = UDim2.new(1, -4, 0, 80)
infoCard.BackgroundColor3 = Color3.fromRGB(9, 21, 46)
infoCard.BorderSizePixel = 0
infoCard.Parent = pages["ព័ត៌មាន"]

local icCorner = Instance.new("UICorner")
icCorner.CornerRadius = UDim.new(0, 10)
icCorner.Parent = infoCard

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -20, 1, -10)
infoText.Position = UDim2.fromOffset(10, 5)
infoText.BackgroundTransparency = 1
infoText.Font = Enum.Font.FredokaOne
infoText.Text = "AKIRA SCRIPT HUB • កំណែទូរស័ព្ទដៃ\n\nអ្នកបង្កើត៖ BENZ\nមុខងារ៖ Anti-Hit, Auto Teleport, Color Themes, Touch Scale"
infoText.TextSize = 11.5
infoText.TextColor3 = Color3.fromRGB(240, 245, 255)
infoText.TextWrapped = true
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.Parent = infoCard

local vipCard = Instance.new("Frame")
vipCard.Size = UDim2.new(1, -4, 0, 70)
vipCard.BackgroundColor3 = Color3.fromRGB(9, 21, 46)
vipCard.BorderSizePixel = 0
vipCard.Parent = pages["VIP"]

local vcCorner = Instance.new("UICorner")
vcCorner.CornerRadius = UDim.new(0, 10)
vcCorner.Parent = vipCard

local vipText = Instance.new("TextLabel")
vipText.Size = UDim2.new(1, -20, 1, 0)
vipText.Position = UDim2.fromOffset(10, 0)
vipText.BackgroundTransparency = 1
vipText.Font = Enum.Font.FredokaOne
vipText.Text = "👑 VIP MEMBER STATUS: ACTIVE\nសូមអរគុណសម្រាប់ការគាំទ្រ AKIRA SCRIPT HUB!"
vipText.TextSize = 12
vipText.TextColor3 = Color3.fromRGB(255, 215, 60)
vipText.TextXAlignment = Enum.TextXAlignment.Left
vipText.Parent = vipCard

-- ============================================================
-- ប៊ូតុង LOGO អណ្ដែត (FLOATING CAMBODIA LOGO)
-- ============================================================
local openButton = Instance.new("ImageButton")
openButton.Name = "OpenAkiraLogo"
openButton.AnchorPoint = Vector2.new(1, 0.5)
openButton.Position = UDim2.new(1, -18, 0.5, 0)
openButton.Size = UDim2.fromOffset(60, 60)
openButton.BackgroundColor3 = Color3.fromRGB(4, 11, 26)
openButton.BackgroundTransparency = 0.15
openButton.BorderSizePixel = 0
openButton.Image = LOGO_ID
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

local function closeGui()
    if not main.Visible then return end
    playClick()
    main.Visible = false
    shadow.Visible = false
    openButton.Visible = true
    tween(openButton, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(60, 60)})
end

local function openGui()
    playClick()
    openButton.Visible = false
    main.Visible = true
    shadow.Visible = true
end

close.Activated:Connect(closeGui)
minimize.Activated:Connect(closeGui)
openButton.Activated:Connect(openGui)

-- អូសប៊ូតុង Logo (Mobile Dragging)
local akDragging, akDragStart, akStartPos
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

-- អូសផ្ទាំង Menu (Hub Dragging)
local hubDragging, hubDragStart, hubStartPos
main.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch)
    and input.Position.Y - main.AbsolutePosition.Y <= 60 then
        hubDragging = true
        hubDragStart = input.Position
        hubStartPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if hubDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - hubDragStart
        local newPos = UDim2.new(hubStartPos.X.Scale, hubStartPos.X.Offset + delta.X, hubStartPos.Y.Scale, hubStartPos.Y.Offset + delta.Y)
        main.Position = newPos
        shadow.Position = newPos
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        hubDragging = false
    end
end)

-- បង្ហាញ UI ភ្លាមៗ
main.Visible = true
shadow.Visible = true
