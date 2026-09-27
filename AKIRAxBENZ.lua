--[[
    AKIRA SCRIPT HUB • VECTOR ICON EDITION
    Recreated precisely with crisp Roblox Vector Image Assets (No Emojis):
    - Vector Icons for Sidebar Tabs: Shield, FileText, Settings, Info, Crown
    - Vector Minimize (-) and Close (X) Icons
    - Clean Vector Shield Badge on Anti-Hit Card
    - Cambodia Logo Button Support
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

-- Official Lucide/Roblox Vector Asset IDs
local Icons = {
    Shield = "rbxassetid://6031075938",
    FileText = "rbxassetid://6031071050",
    Settings = "rbxassetid://6031280882",
    Info = "rbxassetid://6031077364",
    Crown = "rbxassetid://6031068426",
    Minus = "rbxassetid://6031094678",
    Close = "rbxassetid://6031094687"
}

-- Exact Palette extracted from image
local Pal = {
    MainBg = Color3.fromRGB(4, 11, 26),
    SidebarBorder = Color3.fromRGB(0, 150, 255),
    CardBg = Color3.fromRGB(9, 21, 46),
    CardBorder = Color3.fromRGB(15, 60, 120),
    ActiveTabTop = Color3.fromRGB(0, 195, 255),
    ActiveTabBottom = Color3.fromRGB(0, 120, 255),
    TextWhite = Color3.fromRGB(255, 255, 255),
    TextMuted = Color3.fromRGB(130, 160, 200),
    PurpleAccent = Color3.fromRGB(180, 50, 255),
    NeonCyan = Color3.fromRGB(0, 210, 255)
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
    UDim2.fromOffset(450, 240),
    UDim2.fromOffset(510, 270),
    UDim2.fromOffset(570, 300),
}
local SizeIndex = 2

-- Hub Shadow / Ambient Glow
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
main.BackgroundColor3 = Pal.MainBg
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2
mainStroke.Color = Pal.SidebarBorder
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
lbStroke.Color = Pal.CardBorder
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
title.TextColor3 = Pal.TextWhite
title.Parent = titleContainer

local titleGrad = Instance.new("UIGradient")
titleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Pal.TextWhite),
    ColorSequenceKeypoint.new(0.48, Pal.TextWhite),
    ColorSequenceKeypoint.new(0.52, Pal.PurpleAccent),
    ColorSequenceKeypoint.new(1.0, Pal.PurpleAccent)
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
subTitle.TextColor3 = Pal.TextWhite
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
    icon.ImageColor3 = Pal.TextWhite
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
sideStroke.Color = Pal.SidebarBorder
sideStroke.Parent = sidebar

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 5)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

local sidePad = Instance.new("UIPadding")
sidePad.PaddingTop = UDim.new(0, 6)
sidePad.Parent = sidebar

-- Content Area (Right Panel)
local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 136, 0, 64)
content.Size = UDim2.new(1, -148, 1, -76)
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
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = Pal.NeonCyan
    page.CanvasSize = UDim2.new()
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.Visible = (name == "ប្ដូរស្គ្រីប")
    page.Parent = content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

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
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.Parent = sidebar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b

    local bGrad = Instance.new("UIGradient")
    bGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, Pal.ActiveTabTop),
        ColorSequenceKeypoint.new(1.0, Pal.ActiveTabBottom)
    })
    bGrad.Rotation = 90
    bGrad.Parent = b

    local icon = Instance.new("ImageLabel")
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.fromOffset(15, 15)
    icon.Position = UDim2.new(0, 9, 0.5, 0)
    icon.AnchorPoint = Vector2.new(0, 0.5)
    icon.Image = iconAsset
    icon.ImageColor3 = Pal.TextMuted
    icon.Parent = b

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -30, 1, 0)
    label.Position = UDim2.fromOffset(29, 0)
    label.Text = text
    label.Font = Enum.Font.FredokaOne
    label.TextSize = 11.5
    label.TextColor3 = Pal.TextMuted
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = b

    tabButtons[name] = {Button = b, Label = label, Icon = icon}

    b.Activated:Connect(function()
        AkiraPlayClick()
        currentTab = name
        for tName, data in pairs(tabButtons) do
            local isSel = (tName == currentTab)
            data.Button.BackgroundTransparency = isSel and 0 or 1
            data.Label.TextColor3 = isSel and Pal.TextWhite or Pal.TextMuted
            data.Icon.ImageColor3 = isSel and Pal.TextWhite or Pal.TextMuted
        end
        for pName, pObj in pairs(pages) do
            pObj.Visible = (pName == currentTab)
        end
    end)

    return b
end

-- Sidebar Tabs with Vector Icons
makeTab("ប្ដូរស្គ្រីប", Icons.Shield, "ប្ដូរស្គ្រីប")
makeTab("ស្គ្រីប", Icons.FileText, "ស្គ្រីប")
makeTab("ការកំណត់", Icons.Settings, "ការកំណត់")
makeTab("ព័ត៌មាន", Icons.Info, "ព័ត៌មាន")
makeTab("VIP", Icons.Crown, "VIP")

-- Default Tab State Activation
tabButtons["ប្ដូរស្គ្រីប"].Button.BackgroundTransparency = 0
tabButtons["ប្ដូរស្គ្រីប"].Label.TextColor3 = Pal.TextWhite
tabButtons["ប្ដូរស្គ្រីប"].Icon.ImageColor3 = Pal.TextWhite

-- Bottom Right Watermark Signature with Vector Crown Icon
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
crownIcon.ImageColor3 = Pal.NeonCyan
crownIcon.Parent = sigContainer

local signature = Instance.new("TextLabel")
signature.Name = "Signature"
signature.BackgroundTransparency = 1
signature.Position = UDim2.fromOffset(18, 0)
signature.Size = UDim2.new(1, -18, 1, 0)
signature.Font = Enum.Font.Caveat
signature.Text = "Akira Script"
signature.TextSize = 18
signature.TextColor3 = Pal.NeonCyan
signature.TextXAlignment = Enum.TextXAlignment.Left
signature.Parent = sigContainer

-- ============================================================
-- ANTI-HIT CARD & PILL SWITCH
-- ============================================================
local AntiHitEnabled = false
local IsAntiHitRunning = false
local ANTI_HIT_SPEED = 0.016

local antiHitCard = Instance.new("Frame")
antiHitCard.Name = "AntiHitCard"
antiHitCard.Size = UDim2.new(1, -6, 0, 56)
antiHitCard.BackgroundColor3 = Pal.CardBg
antiHitCard.BorderSizePixel = 0
antiHitCard.Parent = defaultPage

local ahCorner = Instance.new("UICorner")
ahCorner.CornerRadius = UDim.new(0, 12)
ahCorner.Parent = antiHitCard

local ahStroke = Instance.new("UIStroke")
ahStroke.Thickness = 1.2
ahStroke.Color = Pal.CardBorder
ahStroke.Parent = antiHitCard

-- Card Shield Icon Plate with Vector Image
local iconPlate = Instance.new("Frame")
iconPlate.Size = UDim2.fromOffset(40, 40)
iconPlate.Position = UDim2.new(0, 8, 0.5, 0)
iconPlate.AnchorPoint = Vector2.new(0, 0.5)
iconPlate.BackgroundColor3 = Color3.fromRGB(15, 35, 75)
iconPlate.BorderSizePixel = 0
iconPlate.Parent = antiHitCard

local ipc = Instance.new("UICorner")
ipc.CornerRadius = UDim.new(0, 10)
ipc.Parent = iconPlate

local shieldImg = Instance.new("ImageLabel")
shieldImg.BackgroundTransparency = 1
shieldImg.Size = UDim2.fromOffset(22, 22)
shieldImg.Position = UDim2.fromScale(0.5, 0.5)
shieldImg.AnchorPoint = Vector2.new(0.5, 0.5)
shieldImg.Image = Icons.Shield
shieldImg.ImageColor3 = Pal.NeonCyan
shieldImg.Parent = iconPlate

-- Title & Status Labels
local cardTitle = Instance.new("TextLabel")
cardTitle.BackgroundTransparency = 1
cardTitle.Position = UDim2.fromOffset(56, 10)
cardTitle.Size = UDim2.new(1, -120, 0, 18)
cardTitle.Font = Enum.Font.FredokaOne
cardTitle.Text = "ការពារការវាយ (ANTI-HIT)"
cardTitle.TextSize = 12.5
cardTitle.TextColor3 = Pal.TextWhite
cardTitle.TextXAlignment = Enum.TextXAlignment.Left
cardTitle.Parent = antiHitCard

local cardStatus = Instance.new("TextLabel")
cardStatus.BackgroundTransparency = 1
cardStatus.Position = UDim2.fromOffset(56, 28)
cardStatus.Size = UDim2.new(1, -120, 0, 16)
cardStatus.Font = Enum.Font.FredokaOne
cardStatus.Text = "ស្ថានភាព៖ បិទ"
cardStatus.TextSize = 11
cardStatus.TextColor3 = Pal.TextMuted
cardStatus.TextXAlignment = Enum.TextXAlignment.Left
cardStatus.Parent = antiHitCard

-- Pill Switch Toggle
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.fromOffset(48, 24)
toggle.Position = UDim2.new(1, -14, 0.5, 0)
toggle.AnchorPoint = Vector2.new(1, 0.5)
toggle.BackgroundColor3 = Color3.fromRGB(20, 45, 85)
toggle.BorderSizePixel = 0
toggle.Text = ""
toggle.AutoButtonColor = false
toggle.Parent = antiHitCard

local tc = Instance.new("UICorner")
tc.CornerRadius = UDim.new(1, 0)
tc.Parent = toggle

local toggleKnob = Instance.new("Frame")
toggleKnob.Size = UDim2.fromOffset(18, 18)
toggleKnob.Position = UDim2.new(0, 3, 0.5, 0)
toggleKnob.AnchorPoint = Vector2.new(0, 0.5)
toggleKnob.BackgroundColor3 = Color3.fromRGB(240, 245, 255)
toggleKnob.BorderSizePixel = 0
toggleKnob.Parent = toggle

local kc = Instance.new("UICorner")
kc.CornerRadius = UDim.new(1, 0)
kc.Parent = toggleKnob

local function setAntiHitVisual(enabled)
    if enabled then
        tween(toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = Pal.ActiveTabTop})
        tween(toggleKnob, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -21, 0.5, 0)
        })
        cardStatus.Text = "ស្ថានភាព៖ កំពុងដំណើរការ"
        cardStatus.TextColor3 = Pal.NeonCyan
        ahStroke.Color = Pal.ActiveTabTop
    else
        tween(toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(20, 45, 85)})
        tween(toggleKnob, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
            Position = UDim2.new(0, 3, 0.5, 0)
        })
        cardStatus.Text = "ស្ថានភាព៖ បិទ"
        cardStatus.TextColor3 = Pal.TextMuted
        ahStroke.Color = Pal.CardBorder
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

toggle.Activated:Connect(function()
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

-- CONFIG TAB ELEMENTS
local configBox = Instance.new("Frame")
configBox.Size = UDim2.new(1, -6, 0, 48)
configBox.BackgroundColor3 = Pal.CardBg
configBox.BorderSizePixel = 0
configBox.Parent = configPage

local cbc = Instance.new("UICorner")
cbc.CornerRadius = UDim.new(0, 10)
cbc.Parent = configBox

local cfgIcon = Instance.new("ImageLabel")
cfgIcon.BackgroundTransparency = 1
cfgIcon.Size = UDim2.fromOffset(18, 18)
cfgIcon.Position = UDim2.new(0, 12, 0.5, 0)
cfgIcon.AnchorPoint = Vector2.new(0, 0.5)
cfgIcon.Image = Icons.Settings
cfgIcon.ImageColor3 = Pal.NeonCyan
cfgIcon.Parent = configBox

local sizeText = Instance.new("TextLabel")
sizeText.BackgroundTransparency = 1
sizeText.Position = UDim2.fromOffset(36, 0)
sizeText.Size = UDim2.new(1, -48, 1, 0)
sizeText.Font = Enum.Font.FredokaOne
sizeText.Text = "ទំហំផ្ទាំង MENU ៖ មធ្យម (ចុចដើម្បីប្តូរ)"
sizeText.TextSize = 12
sizeText.TextColor3 = Pal.TextWhite
sizeText.TextXAlignment = Enum.TextXAlignment.Left
sizeText.Parent = configBox

local sizeNames = {"តូច", "មធ្យម", "ធំ"}
configBox.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        AkiraPlayClick()
        SizeIndex = (SizeIndex % #Sizes) + 1
        sizeText.Text = "ទំហំផ្ទាំង MENU ៖ " .. sizeNames[SizeIndex] .. " (ចុចដើម្បីប្តូរ)"
        local target = Sizes[SizeIndex]
        tween(main, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
        tween(shadow, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
    end
end)

-- ============================================================
-- FLOATING LOGO BUTTON
-- ============================================================
local LOGO_IMAGE_ID = "rbxassetid://97330468088484"

local openButton = Instance.new("ImageButton")
openButton.Name = "OpenAkiraLogo"
openButton.AnchorPoint = Vector2.new(1, 0.5)
openButton.Position = UDim2.new(1, -18, 0.5, 0)
openButton.Size = UDim2.fromOffset(60, 60)
openButton.BackgroundColor3 = Pal.MainBg
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
openStroke.Thickness = 2.4
openStroke.Color = Pal.ActiveTabTop
openStroke.Transparency = 0.15
openStroke.Parent = openButton

task.spawn(function()
    while gui.Parent and openButton.Parent do
        local t1 = tween(openStroke, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Pal.ActiveTabTop,
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
    main.BackgroundTransparency = 0
    shadow.BackgroundTransparency = 0.4
    main.Position = savedPos
    shadow.Position = savedPos
    mainScale.Scale = 1
    shadowScale.Scale = 1
    openButton.Visible = true
    tween(openButton, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(60, 60)})
end

local function openGui()
    openButton.Visible = false
    main.Visible = true
    shadow.Visible = true
    mainScale.Scale = 0.78
    shadowScale.Scale = 0.78
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
        mainScale.Scale = 0.78
        shadowScale.Scale = 0.78
        tween(main, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(shadow, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(mainScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        tween(shadowScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
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
        mainScale.Scale = 0.78
        shadowScale.Scale = 0.78
        tween(main, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(shadow, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = savedSize})
        tween(mainScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
        tween(shadowScale, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
    else
        minimized = true
        savedSize = main.Size
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

-- Hub Touch Dragging on Top Bar
local hubDragging = false
local hubDragStart
local hubStartPos

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

-- Initial Startup Show
main.Visible = true
shadow.Visible = true
