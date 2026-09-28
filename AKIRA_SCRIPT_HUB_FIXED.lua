--[[
    AKIRA SCRIPT HUB • 100% STEAL AN EGG ACCURATE EDITION
    - Creator: BENZ
    - Fully Synced with Steal an Egg Core Gameplay Loop
    - Drop UI Detection & Auto Escape to Safe Zone Line
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local function getGuiParent()
    local ok, hui = pcall(function()
        if typeof(gethui) == "function" then
            return gethui()
        end
        if syn and typeof(syn.protect_gui) == "function" then
            return PlayerGui
        end
        return PlayerGui
    end)
    return (ok and hui) or PlayerGui
end

local GuiParent = getGuiParent()

-- ============================================================
-- SOUND SYSTEM
-- ============================================================
local AkiraSoundFolder = SoundService:FindFirstChild("AkiraSounds") or Instance.new("Folder")
AkiraSoundFolder.Name = "AkiraSounds"
AkiraSoundFolder.Parent = SoundService

local AkiraClickSound = AkiraSoundFolder:FindFirstChild("AkiraClick") or Instance.new("Sound")
AkiraClickSound.Name = "AkiraClick"
AkiraClickSound.SoundId = "rbxassetid://6026984224"
AkiraClickSound.Volume = 0.30
AkiraClickSound.Parent = AkiraSoundFolder

local ConfigSettings = {
    SoundEnabled = true,
    RGBEnabled = true,
    BoostFPSEnabled = false
}

local function AkiraPlayClick(speed, volume)
    if ConfigSettings.SoundEnabled then
        pcall(function()
            AkiraClickSound:Stop()
            AkiraClickSound.TimePosition = 0
            AkiraClickSound.PlaybackSpeed = speed or 1
            AkiraClickSound.Volume = volume or 0.30
            AkiraClickSound:Play()
        end)
    end
end

local TELEGRAM_LINK = "https://t.me/YourTelegramLink"
local function copyText(value)
    local copier = setclipboard or toclipboard or (syn and syn.write_clipboard)
    if typeof(copier) == "function" then
        local ok = pcall(copier, value)
        return ok
    end
    return false
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

-- ============================================================
-- MAIN SCREEN GUI
-- ============================================================
local gui = Instance.new("ScreenGui")
gui.Name = "AkiraScriptHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 9999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = GuiParent

local scale = Instance.new("UIScale")
scale.Scale = 0.92
scale.Parent = gui

local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.5)
main.Size = UDim2.fromOffset(560, 310)
main.BackgroundColor3 = Color3.fromRGB(4, 9, 20)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 18)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2
mainStroke.Color = Color3.fromRGB(255, 255, 255)
mainStroke.Transparency = 0.15
mainStroke.Parent = main

-- ============================================================
-- TOP BAR (HEADER & CONTROLS)
-- ============================================================
local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 68)
top.BackgroundTransparency = 1
top.Active = true
top.Parent = main

local logoCard = Instance.new("Frame")
logoCard.Name = "LogoCard"
logoCard.Position = UDim2.fromOffset(14, 10)
logoCard.Size = UDim2.fromOffset(50, 50)
logoCard.BackgroundColor3 = Color3.fromRGB(7, 16, 32)
logoCard.BorderSizePixel = 0
logoCard.Parent = top

local logoCardCorner = Instance.new("UICorner")
logoCardCorner.CornerRadius = UDim.new(0, 14)
logoCardCorner.Parent = logoCard

local logoCardStroke = Instance.new("UIStroke")
logoCardStroke.Thickness = 1.2
logoCardStroke.Color = Color3.fromRGB(255, 255, 255)
logoCardStroke.Parent = logoCard

local logoImage = Instance.new("ImageLabel")
logoImage.Name = "LogoImage"
logoImage.BackgroundTransparency = 1
logoImage.AnchorPoint = Vector2.new(0.5, 0.5)
logoImage.Position = UDim2.fromScale(0.5, 0.5)
logoImage.Size = UDim2.fromOffset(40, 40)
logoImage.Image = "rbxassetid://97330468088484"
logoImage.Parent = logoCard

local title = Instance.new("TextLabel")
title.Name = "Title"
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(74, 15)
title.Size = UDim2.new(0, 200, 0, 22)
title.Font = Enum.Font.GothamBlack
title.Text = "AKIRA SCRIPT"
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.fromOffset(74, 38)
subtitle.Size = UDim2.new(0, 250, 0, 16)
subtitle.Font = Enum.Font.GothamBold
subtitle.Text = "Product BENZ • AKIRA SCRIPT"
subtitle.TextSize = 11
subtitle.TextColor3 = Color3.fromRGB(180, 195, 220)
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = top

local function createTopControl(iconAssetId, xOffset)
    local btn = Instance.new("ImageButton")
    btn.Size = UDim2.fromOffset(26, 26)
    btn.Position = UDim2.new(1, xOffset, 0, 15)
    btn.AnchorPoint = Vector2.new(1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(8, 18, 38)
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = top

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = btn

    local bStroke = Instance.new("UIStroke")
    bStroke.Thickness = 1
    bStroke.Color = Color3.fromRGB(20, 45, 80)
    bStroke.Parent = btn

    local img = Instance.new("ImageLabel")
    img.BackgroundTransparency = 1
    img.AnchorPoint = Vector2.new(0.5, 0.5)
    img.Position = UDim2.fromScale(0.5, 0.5)
    img.Size = UDim2.fromOffset(14, 14)
    img.Image = iconAssetId
    img.ImageColor3 = Color3.fromRGB(190, 210, 240)
    img.Parent = btn

    return btn
end

local closeBtn = createTopControl("rbxassetid://10747384394", -15)
local minimizeBtn = createTopControl("rbxassetid://10709790948", -48)

-- ============================================================
-- SIDEBAR & TABS
-- ============================================================
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.fromOffset(14, 72)
sidebar.Size = UDim2.new(0, 116, 1, -86)
sidebar.BackgroundColor3 = Color3.fromRGB(6, 13, 26)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 14)
sideCorner.Parent = sidebar

local sideStroke = Instance.new("UIStroke")
sideStroke.Thickness = 1.2
sideStroke.Color = Color3.fromRGB(0, 140, 255)
sideStroke.Transparency = 0.35
sideStroke.Parent = sidebar

local telegramBtn = Instance.new("TextButton")
telegramBtn.Name = "TelegramButton"
telegramBtn.AnchorPoint = Vector2.new(0.5, 1)
telegramBtn.Position = UDim2.new(0.5, 0, 1, -10)
telegramBtn.Size = UDim2.new(1, -16, 0, 32)
telegramBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
telegramBtn.BorderSizePixel = 0
telegramBtn.Text = "telegram"
telegramBtn.Font = Enum.Font.GothamBlack
telegramBtn.TextSize = 13
telegramBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
telegramBtn.AutoButtonColor = false
telegramBtn.Parent = sidebar

local teleCorner = Instance.new("UICorner")
teleCorner.CornerRadius = UDim.new(0, 10)
teleCorner.Parent = telegramBtn

local teleGradient = Instance.new("UIGradient")
teleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 180, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 110, 240))
})
teleGradient.Rotation = 90
teleGradient.Parent = telegramBtn

local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0, 140, 0, 72)
content.Size = UDim2.new(1, -154, 1, -86)
content.BackgroundTransparency = 1
content.Parent = main

local currentTab = "ស្គ្រីប"
local pages = {}
local tabButtons = {}

local function makePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 140, 255)
    page.CanvasSize = UDim2.new()
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.Visible = (name == "ស្គ្រីប")
    page.Parent = content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    pages[name] = page
    return page
end

local scriptsPage = makePage("ស្គ្រីប")
local configPage = makePage("ការកំណត់")
local infoPage = makePage("ព័ត៌មាន")

-- ============================================================
-- CONFIGURATION PAGE COMPONENTS
-- ============================================================
local function createConfigToggle(titleText, defaultState, callback)
    local card = Instance.new("Frame")
    card.Name = "ToggleCard_" .. titleText
    card.Size = UDim2.new(1, -10, 0, 52)
    card.BackgroundColor3 = Color3.fromRGB(7, 16, 32)
    card.BorderSizePixel = 0
    card.Parent = configPage

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = card

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.2
    stroke.Color = Color3.fromRGB(0, 140, 255)
    stroke.Transparency = 0.5
    stroke.Parent = card

    local titleLbl = Instance.new("TextLabel")
    titleLbl.BackgroundTransparency = 1
    titleLbl.Position = UDim2.fromOffset(14, 8)
    titleLbl.Size = UDim2.new(1, -80, 0, 18)
    titleLbl.Font = Enum.Font.FredokaOne
    titleLbl.Text = titleText
    titleLbl.TextSize = 12
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = card

    local statusLbl = Instance.new("TextLabel")
    statusLbl.BackgroundTransparency = 1
    statusLbl.Position = UDim2.fromOffset(14, 27)
    statusLbl.Size = UDim2.new(1, -80, 0, 16)
    statusLbl.Font = Enum.Font.FredokaOne
    statusLbl.Text = defaultState and "ស្ថានភាព៖ បើក" or "ស្ថានភាព៖ បិទ"
    statusLbl.TextSize = 10
    statusLbl.TextColor3 = defaultState and Color3.fromRGB(80, 255, 140) or Color3.fromRGB(130, 150, 180)
    statusLbl.TextXAlignment = Enum.TextXAlignment.Left
    statusLbl.Parent = card

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.AnchorPoint = Vector2.new(1, 0.5)
    toggleBtn.Position = UDim2.new(1, -14, 0.5, 0)
    toggleBtn.Size = UDim2.fromOffset(46, 22)
    toggleBtn.BackgroundColor3 = defaultState and Color3.fromRGB(0, 140, 255) or Color3.fromRGB(24, 40, 68)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = ""
    toggleBtn.AutoButtonColor = false
    toggleBtn.Parent = card

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBtn

    local thumb = Instance.new("Frame")
    thumb.AnchorPoint = Vector2.new(0, 0.5)
    thumb.Position = defaultState and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
    thumb.Size = UDim2.fromOffset(16, 16)
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thumb.BorderSizePixel = 0
    thumb.Parent = toggleBtn

    local thCorner = Instance.new("UICorner")
    thCorner.CornerRadius = UDim.new(1, 0)
    thCorner.Parent = thumb

    local state = defaultState
    toggleBtn.Activated:Connect(function()
        AkiraPlayClick()
        state = not state
        
        if state then
            statusLbl.Text = "ស្ថានភាព៖ បើក"
            statusLbl.TextColor3 = Color3.fromRGB(80, 255, 140)
            tween(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 140, 255)})
            tween(thumb, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, -19, 0.5, 0)
            })
        else
            statusLbl.Text = "ស្ថានភាព៖ បិទ"
            statusLbl.TextColor3 = Color3.fromRGB(130, 150, 180)
            tween(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 40, 68)})
            tween(thumb, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 3, 0.5, 0)
            })
        end

        if callback then
            callback(state)
        end
    end)

    return card
end

createConfigToggle("សំឡេងចុច UI (Sound Effects)", true, function(state)
    ConfigSettings.SoundEnabled = state
end)

createConfigToggle("ភ្លើង RGB រត់ជុំវិញ (RGB Effects)", true, function(state)
    ConfigSettings.RGBEnabled = state
    local rgbMain = mainStroke:FindFirstChild("RGBStrokeFlow")
    local rgbLogo = logoCardStroke:FindFirstChild("RGBStrokeFlow")
    local dotObj = main:FindFirstChild("DragDot")
    local rgbDot = dotObj and dotObj:FindFirstChildOfClass("UIStroke") and dotObj:FindFirstChildOfClass("UIStroke"):FindFirstChild("RGBStrokeFlow")
    
    if rgbMain then rgbMain.Enabled = state end
    if rgbLogo then rgbLogo.Enabled = state end
    if rgbDot then rgbDot.Enabled = state end
    
    local c = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 140, 255)
    mainStroke.Color = c
    logoCardStroke.Color = c
    if dotObj and dotObj:FindFirstChildOfClass("UIStroke") then
        dotObj:FindFirstChildOfClass("UIStroke").Color = c
    end
end)

local Lighting = game:GetService("Lighting")
local originalLighting = {
    GlobalShadows = Lighting.GlobalShadows,
    FogEnd = Lighting.FogEnd,
    Effects = {}
}
for _, effect in ipairs(Lighting:GetChildren()) do
    if effect:IsA("PostEffect") then
        originalLighting.Effects[effect] = effect.Enabled
    end
end

createConfigToggle("កាត់បន្ថយភាពរអាក់រអួល (Boost FPS)", false, function(state)
    ConfigSettings.BoostFPSEnabled = state
    if state then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, effect in ipairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") then effect.Enabled = false end
        end
    else
        Lighting.GlobalShadows = originalLighting.GlobalShadows
        Lighting.FogEnd = originalLighting.FogEnd
        for effect, enabled in pairs(originalLighting.Effects) do
            if effect and effect.Parent then effect.Enabled = enabled end
        end
    end
end)

-- ============================================================
-- INFO PAGE COMPONENTS
-- ============================================================
local function createInfoCard(iconAsset, titleText, descText, subDescText)
    local card = Instance.new("Frame")
    card.Name = "InfoCard"
    card.Size = UDim2.new(1, -10, 0, 56)
    card.BackgroundColor3 = Color3.fromRGB(7, 16, 32)
    card.BorderSizePixel = 0
    card.Parent = infoPage

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = card

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.2
    stroke.Color = Color3.fromRGB(0, 140, 255)
    stroke.Transparency = 0.5
    stroke.Parent = card

    local iconBox = Instance.new("Frame")
    iconBox.Size = UDim2.fromOffset(38, 38)
    iconBox.Position = UDim2.fromOffset(9, 9)
    iconBox.BackgroundColor3 = Color3.fromRGB(12, 26, 52)
    iconBox.BorderSizePixel = 0
    iconBox.Parent = card

    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 8)
    iconCorner.Parent = iconBox

    local iconImg = Instance.new("ImageLabel")
    iconImg.BackgroundTransparency = 1
    iconImg.AnchorPoint = Vector2.new(0.5, 0.5)
    iconImg.Position = UDim2.fromScale(0.5, 0.5)
    iconImg.Size = UDim2.fromOffset(20, 20)
    iconImg.Image = iconAsset
    iconImg.ImageColor3 = Color3.fromRGB(0, 180, 255)
    iconImg.Parent = iconBox

    local tLbl = Instance.new("TextLabel")
    tLbl.BackgroundTransparency = 1
    tLbl.Position = UDim2.fromOffset(56, 10)
    tLbl.Size = UDim2.new(1, -66, 0, 18)
    tLbl.Font = Enum.Font.FredokaOne
    tLbl.Text = titleText
    tLbl.TextSize = 12
    tLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    tLbl.Parent = card

    local dLbl = Instance.new("TextLabel")
    dLbl.BackgroundTransparency = 1
    dLbl.Position = UDim2.fromOffset(56, 29)
    dLbl.Size = UDim2.new(1, -66, 0, 16)
    dLbl.Font = Enum.Font.GothamBold
    dLbl.RichText = true
    dLbl.Text = descText .. (subDescText and (' • <font color="rgb(120, 150, 190)">' .. subDescText .. '</font>') or "")
    dLbl.TextSize = 10
    dLbl.TextColor3 = Color3.fromRGB(0, 210, 255)
    dLbl.TextXAlignment = Enum.TextXAlignment.Left
    dLbl.Parent = card

    return card
end

createInfoCard("rbxassetid://10747373176", "អ្នកអភិវឌ្ឍន៍ (DEVELOPER)", "BENZ", "AKIRA Hub Creator")
createInfoCard("rbxassetid://10734950020", "កំណែស្គ្រីប (HUB VERSION)", "v1.0.0", "ស្ថានភាព៖ ដំណើរការធម្មតា")
createInfoCard("rbxassetid://10709790948", "គណនីអ្នកលេង (PLAYER INFO)", tostring(Player.Name), "ID: " .. tostring(Player.UserId))

local copyCard = Instance.new("Frame")
copyCard.Size = UDim2.new(1, -10, 0, 48)
copyCard.BackgroundColor3 = Color3.fromRGB(7, 16, 32)
copyCard.BorderSizePixel = 0
copyCard.Parent = infoPage

local ccCorner = Instance.new("UICorner")
ccCorner.CornerRadius = UDim.new(0, 10)
ccCorner.Parent = copyCard

local ccStroke = Instance.new("UIStroke")
ccStroke.Thickness = 1.2
ccStroke.Color = Color3.fromRGB(0, 140, 255)
ccStroke.Transparency = 0.5
ccStroke.Parent = copyCard

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(1, -16, 0, 32)
copyBtn.Position = UDim2.fromOffset(8, 8)
copyBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
copyBtn.BorderSizePixel = 0
copyBtn.Font = Enum.Font.FredokaOne
copyBtn.Text = "ចម្លងតំណភ្ជាប់ TELEGRAM"
copyBtn.TextSize = 11
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.AutoButtonColor = false
copyBtn.Parent = copyCard

local cbCorner = Instance.new("UICorner")
cbCorner.CornerRadius = UDim.new(0, 8)
cbCorner.Parent = copyBtn

copyBtn.Activated:Connect(function()
    AkiraPlayClick()
    if copyText(TELEGRAM_LINK) then
        copyBtn.Text = "បានចម្លងរួចរាល់! (COPIED)"
        task.delay(1.5, function()
            if copyBtn.Parent then copyBtn.Text = "ចម្លងតំណភ្ជាប់ TELEGRAM" end
        end)
    else
        copyBtn.Text = "Clipboard មិនមានក្នុង Executor"
        task.delay(1.5, function()
            if copyBtn.Parent then copyBtn.Text = "ចម្លងតំណភ្ជាប់ TELEGRAM" end
        end)
    end
end)

telegramBtn.Activated:Connect(function()
    AkiraPlayClick()
    if copyText(TELEGRAM_LINK) then
        telegramBtn.Text = "COPIED!"
        task.delay(1.5, function()
            if telegramBtn.Parent then telegramBtn.Text = "telegram" end
        end)
    else
        telegramBtn.Text = "Clipboard មិនមាន"
        task.delay(1.5, function()
            if telegramBtn.Parent then telegramBtn.Text = "telegram" end
        end)
    end
end)

-- ============================================================
-- TAB SWITCHING SYSTEM
-- ============================================================
local function createTabButton(text, iconAssetId, yOffset)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -14, 0, 32)
    btn.Position = UDim2.fromOffset(7, yOffset)
    btn.BackgroundColor3 = Color3.fromRGB(11, 24, 48)
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = sidebar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local iconImg = Instance.new("ImageLabel")
    iconImg.Name = "TabIcon"
    iconImg.BackgroundTransparency = 1
    iconImg.AnchorPoint = Vector2.new(0, 0.5)
    iconImg.Position = UDim2.new(0, 8, 0.5, 0)
    iconImg.Size = UDim2.fromOffset(16, 16)
    iconImg.Image = iconAssetId
    iconImg.ImageColor3 = Color3.fromRGB(120, 140, 170)
    iconImg.Parent = btn

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.fromOffset(30, 0)
    label.Size = UDim2.new(1, -34, 1, 0)
    label.Font = Enum.Font.FredokaOne
    label.Text = text
    label.TextSize = 11
    label.TextColor3 = Color3.fromRGB(120, 140, 170)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = btn

    tabButtons[text] = btn
    return btn
end

local tab1 = createTabButton("ស្គ្រីប", "rbxassetid://10734950309", 12)
local tab2 = createTabButton("ការកំណត់", "rbxassetid://10734950020", 50)
local tab3 = createTabButton("ព័ត៌មាន", "rbxassetid://10747373176", 88)

local function switchTab(tabName)
    currentTab = tabName
    for name, btn in pairs(tabButtons) do
        local selected = (name == tabName)
        local icon = btn:FindFirstChild("TabIcon")
        local lbl = btn:FindFirstChild("Label")
        if selected then
            btn.BackgroundTransparency = 0
            if icon then icon.ImageColor3 = Color3.fromRGB(0, 190, 255) end
            if lbl then lbl.TextColor3 = Color3.fromRGB(255, 255, 255) end
        else
            btn.BackgroundTransparency = 1
            if icon then icon.ImageColor3 = Color3.fromRGB(110, 130, 160) end
            if lbl then lbl.TextColor3 = Color3.fromRGB(110, 130, 160) end
        end
    end
    for name, page in pairs(pages) do
        page.Visible = (name == tabName)
    end
end

tab1.Activated:Connect(function() AkiraPlayClick(); switchTab("ស្គ្រីប") end)
tab2.Activated:Connect(function() AkiraPlayClick(); switchTab("ការកំណត់") end)
tab3.Activated:Connect(function() AkiraPlayClick(); switchTab("ព័ត៌មាន") end)
switchTab("ស្គ្រីប")

-- ============================================================
-- FEATURE 1: ANTI-HIT CARD & ROUTE SYSTEM
-- ============================================================
local AntiHitEnabled = false
local IsAntiHitRunning = false
local ANTI_HIT_SPEED = 0.016

local antiHitCard = Instance.new("Frame")
antiHitCard.Name = "AntiHitCard"
antiHitCard.Size = UDim2.new(1, -10, 0, 60)
antiHitCard.BackgroundColor3 = Color3.fromRGB(7, 16, 32)
antiHitCard.BorderSizePixel = 0
antiHitCard.Parent = scriptsPage

local ahcCorner = Instance.new("UICorner")
ahcCorner.CornerRadius = UDim.new(0, 12)
ahcCorner.Parent = antiHitCard

local ahcStroke = Instance.new("UIStroke")
ahcStroke.Thickness = 1.2
ahcStroke.Color = Color3.fromRGB(0, 140, 255)
ahcStroke.Transparency = 0.5
ahcStroke.Parent = antiHitCard

local shieldBox = Instance.new("Frame")
shieldBox.Name = "ShieldBox"
shieldBox.Position = UDim2.fromOffset(8, 8)
shieldBox.Size = UDim2.fromOffset(44, 44)
shieldBox.BackgroundColor3 = Color3.fromRGB(12, 26, 52)
shieldBox.BorderSizePixel = 0
shieldBox.Parent = antiHitCard

local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 10)
sbCorner.Parent = shieldBox

local shieldIcon = Instance.new("ImageLabel")
shieldIcon.BackgroundTransparency = 1
shieldIcon.AnchorPoint = Vector2.new(0.5, 0.5)
shieldIcon.Position = UDim2.fromScale(0.5, 0.5)
shieldIcon.Size = UDim2.fromOffset(26, 26)
shieldIcon.Image = "rbxassetid://10734950309"
shieldIcon.ImageColor3 = Color3.fromRGB(0, 160, 255)
shieldIcon.Parent = shieldBox

local ahTitle = Instance.new("TextLabel")
ahTitle.BackgroundTransparency = 1
ahTitle.Position = UDim2.fromOffset(62, 11)
ahTitle.Size = UDim2.new(1, -140, 0, 20)
ahTitle.Font = Enum.Font.FredokaOne
ahTitle.RichText = true
ahTitle.Text = 'ការការពារការវាយ <font color="rgb(0, 210, 255)">(ANTI-HIT)</font>'
ahTitle.TextSize = 13
ahTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ahTitle.TextXAlignment = Enum.TextXAlignment.Left
ahTitle.Parent = antiHitCard

local ahStatus = Instance.new("TextLabel")
ahStatus.BackgroundTransparency = 1
ahStatus.Position = UDim2.fromOffset(62, 31)
ahStatus.Size = UDim2.new(1, -140, 0, 16)
ahStatus.Font = Enum.Font.FredokaOne
ahStatus.Text = "ស្ថានភាព៖ បិទ"
ahStatus.TextSize = 10
ahStatus.TextColor3 = Color3.fromRGB(130, 150, 180)
ahStatus.TextXAlignment = Enum.TextXAlignment.Left
ahStatus.Parent = antiHitCard

local toggleTrack = Instance.new("TextButton")
toggleTrack.Name = "ToggleTrack"
toggleTrack.AnchorPoint = Vector2.new(1, 0.5)
toggleTrack.Position = UDim2.new(1, -14, 0.5, 0)
toggleTrack.Size = UDim2.fromOffset(48, 24)
toggleTrack.BackgroundColor3 = Color3.fromRGB(24, 40, 68)
toggleTrack.BorderSizePixel = 0
toggleTrack.Text = ""
toggleTrack.AutoButtonColor = false
toggleTrack.Parent = antiHitCard

local ttCorner = Instance.new("UICorner")
ttCorner.CornerRadius = UDim.new(1, 0)
ttCorner.Parent = toggleTrack

local toggleThumb = Instance.new("Frame")
toggleThumb.Name = "Thumb"
toggleThumb.AnchorPoint = Vector2.new(0, 0.5)
toggleThumb.Position = UDim2.new(0, 3, 0.5, 0)
toggleThumb.Size = UDim2.fromOffset(18, 18)
toggleThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleThumb.BorderSizePixel = 0
toggleThumb.Parent = toggleTrack

local thumbCorner = Instance.new("UICorner")
thumbCorner.CornerRadius = UDim.new(1, 0)
thumbCorner.Parent = toggleThumb

local function setToggle(state)
    AntiHitEnabled = state
    if AntiHitEnabled then
        ahStatus.Text = "ស្ថានភាព៖ បើកដំណើរការ"
        ahStatus.TextColor3 = Color3.fromRGB(80, 255, 140)
        tween(toggleTrack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 140, 255)})
        tween(toggleThumb, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -21, 0.5, 0)
        })
    else
        ahStatus.Text = "ស្ថានភាព៖ បិទ"
        ahStatus.TextColor3 = Color3.fromRGB(130, 150, 180)
        tween(toggleTrack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 40, 68)})
        tween(toggleThumb, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 3, 0.5, 0)
        })
    end
end

toggleTrack.Activated:Connect(function()
    AkiraPlayClick()
    setToggle(not AntiHitEnabled)
end)

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
    for _, pos in ipairs(TeleportPoints) do
        if not AntiHitEnabled or not root.Parent or humanoid.Health <= 0 then
            IsAntiHitRunning = false
            return
        end
        root.CFrame = CFrame.new(pos, pos + root.CFrame.LookVector)
        task.wait(ANTI_HIT_SPEED)
    end
    IsAntiHitRunning = false
end

ProximityPromptService.PromptTriggered:Connect(function(prompt, p)
    if p ~= Player or not AntiHitEnabled or IsAntiHitRunning then return end
    local char = Player.Character
    if char then
        task.spawn(function()
            TeleportRoute(char)
        end)
    end
end)

-- ============================================================
-- FEATURE 2: FAST PROMPT (INSTANT INTERACT)
-- ============================================================
local InstantPromptEnabled = false

local fastPromptCard = Instance.new("Frame")
fastPromptCard.Name = "FastPromptCard"
fastPromptCard.Size = UDim2.new(1, -10, 0, 60)
fastPromptCard.BackgroundColor3 = Color3.fromRGB(7, 16, 32)
fastPromptCard.BorderSizePixel = 0
fastPromptCard.Parent = scriptsPage

local fpcCorner = Instance.new("UICorner")
fpcCorner.CornerRadius = UDim.new(0, 12)
fpcCorner.Parent = fastPromptCard

local fpcStroke = Instance.new("UIStroke")
fpcStroke.Thickness = 1.2
fpcStroke.Color = Color3.fromRGB(0, 140, 255)
fpcStroke.Transparency = 0.5
fpcStroke.Parent = fastPromptCard

local fpIconBox = Instance.new("Frame")
fpIconBox.Position = UDim2.fromOffset(8, 8)
fpIconBox.Size = UDim2.fromOffset(44, 44)
fpIconBox.BackgroundColor3 = Color3.fromRGB(12, 26, 52)
fpIconBox.BorderSizePixel = 0
fpIconBox.Parent = fastPromptCard

local fpiCorner = Instance.new("UICorner")
fpiCorner.CornerRadius = UDim.new(0, 10)
fpiCorner.Parent = fpIconBox

local fpIcon = Instance.new("ImageLabel")
fpIcon.BackgroundTransparency = 1
fpIcon.AnchorPoint = Vector2.new(0.5, 0.5)
fpIcon.Position = UDim2.fromScale(0.5, 0.5)
fpIcon.Size = UDim2.fromOffset(24, 24)
fpIcon.Image = "rbxassetid://10709768567"
fpIcon.ImageColor3 = Color3.fromRGB(0, 160, 255)
fpIcon.Parent = fpIconBox

local fpTitle = Instance.new("TextLabel")
fpTitle.BackgroundTransparency = 1
fpTitle.Position = UDim2.fromOffset(62, 11)
fpTitle.Size = UDim2.new(1, -140, 0, 20)
fpTitle.Font = Enum.Font.FredokaOne
fpTitle.RichText = true
fpTitle.Text = 'ចុចយកភ្លាមៗ <font color="rgb(0, 210, 255)">(FAST PROMPT)</font>'
fpTitle.TextSize = 13
fpTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
fpTitle.TextXAlignment = Enum.TextXAlignment.Left
fpTitle.Parent = fastPromptCard

local fpStatus = Instance.new("TextLabel")
fpStatus.BackgroundTransparency = 1
fpStatus.Position = UDim2.fromOffset(62, 31)
fpStatus.Size = UDim2.new(1, -140, 0, 16)
fpStatus.Font = Enum.Font.FredokaOne
fpStatus.Text = "ស្ថានភាព៖ បិទ"
fpStatus.TextSize = 10
fpStatus.TextColor3 = Color3.fromRGB(130, 150, 180)
fpStatus.TextXAlignment = Enum.TextXAlignment.Left
fpStatus.Parent = fastPromptCard

local fpToggle = Instance.new("TextButton")
fpToggle.AnchorPoint = Vector2.new(1, 0.5)
fpToggle.Position = UDim2.new(1, -14, 0.5, 0)
fpToggle.Size = UDim2.fromOffset(48, 24)
fpToggle.BackgroundColor3 = Color3.fromRGB(24, 40, 68)
fpToggle.BorderSizePixel = 0
fpToggle.Text = ""
fpToggle.AutoButtonColor = false
fpToggle.Parent = fastPromptCard

local fptCorner = Instance.new("UICorner")
fptCorner.CornerRadius = UDim.new(1, 0)
fptCorner.Parent = fpToggle

local fpThumb = Instance.new("Frame")
fpThumb.AnchorPoint = Vector2.new(0, 0.5)
fpThumb.Position = UDim2.new(0, 3, 0.5, 0)
fpThumb.Size = UDim2.fromOffset(18, 18)
fpThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
fpThumb.BorderSizePixel = 0
fpThumb.Parent = fpToggle

local fptbCorner = Instance.new("UICorner")
fptbCorner.CornerRadius = UDim.new(1, 0)
fptbCorner.Parent = fpThumb

fpToggle.Activated:Connect(function()
    AkiraPlayClick()
    InstantPromptEnabled = not InstantPromptEnabled
    
    if InstantPromptEnabled then
        fpStatus.Text = "ស្ថានភាព៖ បើកដំណើរការ"
        fpStatus.TextColor3 = Color3.fromRGB(80, 255, 140)
        tween(fpToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 140, 255)})
        tween(fpThumb, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -21, 0.5, 0)
        })
    else
        fpStatus.Text = "ស្ថានភាព៖ បិទ"
        fpStatus.TextColor3 = Color3.fromRGB(130, 150, 180)
        tween(fpToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 40, 68)})
        tween(fpThumb, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 3, 0.5, 0)
        })
    end
end)

ProximityPromptService.PromptShown:Connect(function(prompt)
    if InstantPromptEnabled then
        prompt.HoldDuration = 0
    end
end)

-- ============================================================
-- FEATURE 3: SPEED HACK (ASSEMBLY LINEAR VELOCITY)
-- ============================================================
local CurrentSpeed = 16
local SpeedEnabled = false
local minSpeed = 16
local maxSpeed = 500
local speedStep = 5

local speedCard = Instance.new("Frame")
speedCard.Name = "SpeedCard"
speedCard.Size = UDim2.new(1, -10, 0, 75)
speedCard.BackgroundColor3 = Color3.fromRGB(7, 16, 32)
speedCard.BorderSizePixel = 0
speedCard.Parent = scriptsPage

local scCorner = Instance.new("UICorner")
scCorner.CornerRadius = UDim.new(0, 12)
scCorner.Parent = speedCard

local scStroke = Instance.new("UIStroke")
scStroke.Thickness = 1.2
scStroke.Color = Color3.fromRGB(0, 140, 255)
scStroke.Transparency = 0.5
scStroke.Parent = speedCard

local spIconBox = Instance.new("Frame")
spIconBox.Position = UDim2.fromOffset(8, 8)
spIconBox.Size = UDim2.fromOffset(40, 40)
spIconBox.BackgroundColor3 = Color3.fromRGB(12, 26, 52)
spIconBox.BorderSizePixel = 0
spIconBox.Parent = speedCard

local spiCorner = Instance.new("UICorner")
spiCorner.CornerRadius = UDim.new(0, 10)
spiCorner.Parent = spIconBox

local spIcon = Instance.new("ImageLabel")
spIcon.BackgroundTransparency = 1
spIcon.AnchorPoint = Vector2.new(0.5, 0.5)
spIcon.Position = UDim2.fromScale(0.5, 0.5)
spIcon.Size = UDim2.fromOffset(24, 24)
spIcon.Image = "rbxassetid://10734975692"
spIcon.ImageColor3 = Color3.fromRGB(0, 190, 255)
spIcon.Parent = spIconBox

local spTitle = Instance.new("TextLabel")
spTitle.BackgroundTransparency = 1
spTitle.Position = UDim2.fromOffset(56, 9)
spTitle.Size = UDim2.new(1, -130, 0, 18)
spTitle.Font = Enum.Font.FredokaOne
spTitle.RichText = true
spTitle.Text = 'ល្បឿនរត់ <font color="rgb(0, 210, 255)">(SMOOTH SPEED)</font>'
spTitle.TextSize = 13
spTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
spTitle.TextXAlignment = Enum.TextXAlignment.Left
spTitle.Parent = speedCard

local spValBox = Instance.new("TextBox")
spValBox.Name = "SpeedInputBox"
spValBox.BackgroundTransparency = 1
spValBox.Position = UDim2.fromOffset(56, 27)
spValBox.Size = UDim2.new(1, -130, 0, 18)
spValBox.Font = Enum.Font.FredokaOne
spValBox.Text = "ល្បឿនបច្ចុប្បន្ន៖ 16 (ចុចវាយលេខបាន)"
spValBox.TextSize = 10
spValBox.TextColor3 = Color3.fromRGB(130, 150, 180)
spValBox.TextXAlignment = Enum.TextXAlignment.Left
spValBox.ClearTextOnFocus = false
spValBox.Parent = speedCard

local spToggleTrack = Instance.new("TextButton")
spToggleTrack.AnchorPoint = Vector2.new(1, 0)
spToggleTrack.Position = UDim2.new(1, -14, 0, 10)
spToggleTrack.Size = UDim2.fromOffset(46, 22)
spToggleTrack.BackgroundColor3 = Color3.fromRGB(24, 40, 68)
spToggleTrack.BorderSizePixel = 0
spToggleTrack.Text = ""
spToggleTrack.AutoButtonColor = false
spToggleTrack.Parent = speedCard

local sptCorner = Instance.new("UICorner")
sptCorner.CornerRadius = UDim.new(1, 0)
sptCorner.Parent = spToggleTrack

local spThumb = Instance.new("Frame")
spThumb.AnchorPoint = Vector2.new(0, 0.5)
spThumb.Position = UDim2.new(0, 3, 0.5, 0)
spThumb.Size = UDim2.fromOffset(16, 16)
spThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
spThumb.BorderSizePixel = 0
spThumb.Parent = spToggleTrack

local spthCorner = Instance.new("UICorner")
spthCorner.CornerRadius = UDim.new(1, 0)
spthCorner.Parent = spThumb

local sliderBar = Instance.new("Frame")
sliderBar.Name = "SliderBar"
sliderBar.Position = UDim2.fromOffset(12, 53)
sliderBar.Size = UDim2.new(1, -24, 0, 8)
sliderBar.BackgroundColor3 = Color3.fromRGB(16, 30, 56)
sliderBar.BorderSizePixel = 0
sliderBar.Parent = speedCard

local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(1, 0)
sbCorner.Parent = sliderBar

local sliderFill = Instance.new("Frame")
sliderFill.Name = "SliderFill"
sliderFill.Size = UDim2.new(0, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
sliderFill.BorderSizePixel = 0
sliderFill.Parent = sliderBar

local sfCorner = Instance.new("UICorner")
sfCorner.CornerRadius = UDim.new(1, 0)
sfCorner.Parent = sliderFill

local sliderButton = Instance.new("TextButton")
sliderButton.BackgroundTransparency = 1
sliderButton.Size = UDim2.fromScale(1, 1)
sliderButton.Text = ""
sliderButton.Parent = sliderBar

local function applySpeedValue(val)
    local clamped = math.clamp(val, minSpeed, maxSpeed)
    CurrentSpeed = clamped
    local percent = (CurrentSpeed - minSpeed) / (maxSpeed - minSpeed)
    sliderFill.Size = UDim2.new(percent, 0, 1, 0)
    spValBox.Text = "ល្បឿនបច្ចុប្បន្ន៖ " .. tostring(CurrentSpeed)
end

spToggleTrack.Activated:Connect(function()
    AkiraPlayClick()
    SpeedEnabled = not SpeedEnabled

    if SpeedEnabled then
        spValBox.TextColor3 = Color3.fromRGB(80, 255, 140)
        tween(spToggleTrack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 140, 255)})
        tween(spThumb, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -19, 0.5, 0)
        })
    else
        spValBox.TextColor3 = Color3.fromRGB(130, 150, 180)
        tween(spToggleTrack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 40, 68)})
        tween(spThumb, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 3, 0.5, 0)
        })
    end
end)

spValBox.FocusLost:Connect(function()
    local num = tonumber(spValBox.Text:match("%d+"))
    if num then
        applySpeedValue(num)
    else
        spValBox.Text = "ល្បឿនបច្ចុប្បន្ន៖ " .. tostring(CurrentSpeed)
    end
end)

local isSliderDragging = false
local function updateSlider(inputPos)
    local barAbsPos = sliderBar.AbsolutePosition.X
    local barAbsSize = sliderBar.AbsoluteSize.X
    local percent = math.clamp((inputPos.X - barAbsPos) / barAbsSize, 0, 1)
    local rawSpeed = minSpeed + (maxSpeed - minSpeed) * percent
    local steppedSpeed = math.floor((rawSpeed / speedStep) + 0.5) * speedStep
    applySpeedValue(steppedSpeed)
end

sliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSliderDragging = true
        updateSlider(input.Position)
    end
end)

UIS.InputChanged:Connect(function(input)
    if isSliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSlider(input.Position)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSliderDragging = false
    end
end)

RunService.Heartbeat:Connect(function()
    if SpeedEnabled then
        local char = Player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            if hum and root and hum.MoveDirection.Magnitude > 0 then
                local targetVelocity = hum.MoveDirection.Unit * CurrentSpeed
                root.AssemblyLinearVelocity = Vector3.new(targetVelocity.X, root.AssemblyLinearVelocity.Y, targetVelocity.Z)
            end
        end
    end
end)

-- ============================================================
-- FEATURE 4: ANTI-KNOCKBACK & ANTI-FLING (វាយមិនប៉ើង / មិនដួល)
-- ============================================================
local AntiKnockbackEnabled = false
local antiFlingLoop = nil
local savedHumanoidStates = nil

local function saveHumanoidStates(hum)
    savedHumanoidStates = {
        Ragdoll = hum:GetStateEnabled(Enum.HumanoidStateType.Ragdoll),
        FallingDown = hum:GetStateEnabled(Enum.HumanoidStateType.FallingDown),
        PlatformStanding = hum:GetStateEnabled(Enum.HumanoidStateType.PlatformStanding)
    }
end

local function restoreHumanoidStates(hum)
    if not savedHumanoidStates then return end
    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, savedHumanoidStates.Ragdoll)
    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, savedHumanoidStates.FallingDown)
    hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, savedHumanoidStates.PlatformStanding)
    savedHumanoidStates = nil
end

local godCard = Instance.new("Frame")
godCard.Name = "AntiKnockbackCard"
godCard.Size = UDim2.new(1, -10, 0, 60)
godCard.BackgroundColor3 = Color3.fromRGB(7, 16, 32)
godCard.BorderSizePixel = 0
godCard.Parent = scriptsPage

local gcCorner = Instance.new("UICorner")
gcCorner.CornerRadius = UDim.new(0, 12)
gcCorner.Parent = godCard

local gcStroke = Instance.new("UIStroke")
gcStroke.Thickness = 1.2
gcStroke.Color = Color3.fromRGB(0, 140, 255)
gcStroke.Transparency = 0.5
gcStroke.Parent = godCard

local gcIconBox = Instance.new("Frame")
gcIconBox.Position = UDim2.fromOffset(8, 8)
gcIconBox.Size = UDim2.fromOffset(44, 44)
gcIconBox.BackgroundColor3 = Color3.fromRGB(12, 26, 52)
gcIconBox.BorderSizePixel = 0
gcIconBox.Parent = godCard

local gciCorner = Instance.new("UICorner")
gciCorner.CornerRadius = UDim.new(0, 10)
gciCorner.Parent = gcIconBox

local gcIcon = Instance.new("ImageLabel")
gcIcon.BackgroundTransparency = 1
gcIcon.AnchorPoint = Vector2.new(0.5, 0.5)
gcIcon.Position = UDim2.fromScale(0.5, 0.5)
gcIcon.Size = UDim2.fromOffset(24, 24)
gcIcon.Image = "rbxassetid://10709790644"
gcIcon.ImageColor3 = Color3.fromRGB(0, 210, 255)
gcIcon.Parent = gcIconBox

local gcTitle = Instance.new("TextLabel")
gcTitle.BackgroundTransparency = 1
gcTitle.Position = UDim2.fromOffset(62, 11)
gcTitle.Size = UDim2.new(1, -140, 0, 20)
gcTitle.Font = Enum.Font.FredokaOne
gcTitle.RichText = true
gcTitle.Text = 'វាយមិនប៉ើង <font color="rgb(0, 210, 255)">(ANTI-FLING)</font>'
gcTitle.TextSize = 13
gcTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
gcTitle.TextXAlignment = Enum.TextXAlignment.Left
gcTitle.Parent = godCard

local gcStatus = Instance.new("TextLabel")
gcStatus.BackgroundTransparency = 1
gcStatus.Position = UDim2.fromOffset(62, 31)
gcStatus.Size = UDim2.new(1, -140, 0, 16)
gcStatus.Font = Enum.Font.FredokaOne
gcStatus.Text = "ស្ថានភាព៖ បិទ"
gcStatus.TextSize = 10
gcStatus.TextColor3 = Color3.fromRGB(130, 150, 180)
gcStatus.TextXAlignment = Enum.TextXAlignment.Left
gcStatus.Parent = godCard

local gcToggle = Instance.new("TextButton")
gcToggle.AnchorPoint = Vector2.new(1, 0.5)
gcToggle.Position = UDim2.new(1, -14, 0.5, 0)
gcToggle.Size = UDim2.fromOffset(48, 24)
gcToggle.BackgroundColor3 = Color3.fromRGB(24, 40, 68)
gcToggle.BorderSizePixel = 0
gcToggle.Text = ""
gcToggle.AutoButtonColor = false
gcToggle.Parent = godCard

local gctCorner = Instance.new("UICorner")
gctCorner.CornerRadius = UDim.new(1, 0)
gctCorner.Parent = gcToggle

local gcThumb = Instance.new("Frame")
gcThumb.AnchorPoint = Vector2.new(0, 0.5)
gcThumb.Position = UDim2.new(0, 3, 0.5, 0)
gcThumb.Size = UDim2.fromOffset(18, 18)
gcThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
gcThumb.BorderSizePixel = 0
gcThumb.Parent = gcToggle

local gctbCorner = Instance.new("UICorner")
gctbCorner.CornerRadius = UDim.new(1, 0)
gctbCorner.Parent = gcThumb

local function applyAntiKnockback(character)
    if not character then return end
    local hum = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end

    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
    hum.PlatformStand = false

    for _, child in ipairs(root:GetChildren()) do
        if child:IsA("BodyVelocity") or child:IsA("BodyForce") or child:IsA("BodyThrust") or child:IsA("LinearVelocity") or child:IsA("VectorForce") then
            child:Destroy()
        end
    end
end

gcToggle.Activated:Connect(function()
    AkiraPlayClick()
    AntiKnockbackEnabled = not AntiKnockbackEnabled

    if AntiKnockbackEnabled then
        gcStatus.Text = "ស្ថានភាព៖ បើកដំណើរការ"
        gcStatus.TextColor3 = Color3.fromRGB(80, 255, 140)
        tween(gcToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 140, 255)})
        tween(gcThumb, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -21, 0.5, 0)
        })

        local currentChar = Player.Character
        local currentHum = currentChar and currentChar:FindFirstChildOfClass("Humanoid")
        if currentHum then saveHumanoidStates(currentHum) end

        if antiFlingLoop then antiFlingLoop:Disconnect() end
        antiFlingLoop = RunService.Stepped:Connect(function()
            if AntiKnockbackEnabled then
                local char = Player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if root and hum then
                        applyAntiKnockback(char)

                        if hum.MoveDirection.Magnitude == 0 then
                            root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
                        else
                            local maxWalk = hum.WalkSpeed + 5
                            local currentHVel = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z)
                            if currentHVel.Magnitude > maxWalk then
                                local clampedVel = currentHVel.Unit * maxWalk
                                root.AssemblyLinearVelocity = Vector3.new(clampedVel.X, root.AssemblyLinearVelocity.Y, clampedVel.Z)
                            end
                        end
                        root.AssemblyAngularVelocity = Vector3.zero
                    end
                end
            end
        end)
    else
        gcStatus.Text = "ស្ថានភាព៖ បិទ"
        gcStatus.TextColor3 = Color3.fromRGB(130, 150, 180)
        tween(gcToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 40, 68)})
        tween(gcThumb, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 3, 0.5, 0)
        })

        if antiFlingLoop then
            antiFlingLoop:Disconnect()
            antiFlingLoop = nil
        end

        local char = Player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then restoreHumanoidStates(hum) end
        end
    end
end)

-- ============================================================
-- FEATURE 5: AUTO ESCAPE TO SAFE ZONE (100% STEAL AN EGG ACCURATE)
-- ============================================================
local AutoSafeZoneEnabled = false
local IsRunningToSafeZone = false
local CUSTOM_SAFE_ZONE = nil

-- Floating Quick Toggle Button
local floatBtn = Instance.new("ImageButton")
floatBtn.Name = "AutoRunFloatingToggle"
floatBtn.Size = UDim2.fromOffset(48, 48)
floatBtn.Position = UDim2.new(1, -65, 0.35, 0)
floatBtn.BackgroundColor3 = Color3.fromRGB(7, 16, 32)
floatBtn.BorderSizePixel = 0
floatBtn.AutoButtonColor = false
floatBtn.Visible = false
floatBtn.Active = true
floatBtn.Parent = gui

local fbCorner = Instance.new("UICorner")
fbCorner.CornerRadius = UDim.new(0, 14)
fbCorner.Parent = floatBtn

local fbStroke = Instance.new("UIStroke")
fbStroke.Thickness = 2
fbStroke.Color = Color3.fromRGB(0, 140, 255)
fbStroke.Parent = floatBtn

local fbIcon = Instance.new("ImageLabel")
fbIcon.BackgroundTransparency = 1
fbIcon.AnchorPoint = Vector2.new(0.5, 0.5)
fbIcon.Position = UDim2.fromScale(0.5, 0.5)
fbIcon.Size = UDim2.fromOffset(26, 26)
fbIcon.Image = "rbxassetid://10734950309"
fbIcon.ImageColor3 = Color3.fromRGB(0, 210, 255)
fbIcon.Parent = floatBtn

local fDragging = false
local fDragStart = nil
local fStartPos = nil
local fMoved = false

floatBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        fDragging = true
        fMoved = false
        fDragStart = input.Position
        fStartPos = floatBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                fDragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and fDragging and fDragStart and fStartPos then
        local delta = input.Position - fDragStart
        if delta.Magnitude > 6 then
            fMoved = true
        end
        floatBtn.Position = UDim2.new(
            fStartPos.X.Scale,
            fStartPos.X.Offset + delta.X,
            fStartPos.Y.Scale,
            fStartPos.Y.Offset + delta.Y
        )
    end
end)

-- Safe Zone Main Card (មានប៊ូតុងកំណត់បន្ទាត់ Safe Zone)
local safeZoneCard = Instance.new("Frame")
safeZoneCard.Name = "SafeZoneCard"
safeZoneCard.Size = UDim2.new(1, -10, 0, 95)
safeZoneCard.BackgroundColor3 = Color3.fromRGB(7, 16, 32)
safeZoneCard.BorderSizePixel = 0
safeZoneCard.Parent = scriptsPage

local szcCorner = Instance.new("UICorner")
szcCorner.CornerRadius = UDim.new(0, 12)
szcCorner.Parent = safeZoneCard

local szcStroke = Instance.new("UIStroke")
szcStroke.Thickness = 1.2
szcStroke.Color = Color3.fromRGB(0, 140, 255)
szcStroke.Transparency = 0.5
szcStroke.Parent = safeZoneCard

local szcIconBox = Instance.new("Frame")
szcIconBox.Position = UDim2.fromOffset(8, 8)
szcIconBox.Size = UDim2.fromOffset(44, 44)
szcIconBox.BackgroundColor3 = Color3.fromRGB(12, 26, 52)
szcIconBox.BorderSizePixel = 0
szcIconBox.Parent = safeZoneCard

local szciCorner = Instance.new("UICorner")
szciCorner.CornerRadius = UDim.new(0, 10)
szciCorner.Parent = szcIconBox

local szcIcon = Instance.new("ImageLabel")
szcIcon.BackgroundTransparency = 1
szcIcon.AnchorPoint = Vector2.new(0.5, 0.5)
szcIcon.Position = UDim2.fromScale(0.5, 0.5)
szcIcon.Size = UDim2.fromOffset(24, 24)
szcIcon.Image = "rbxassetid://10734950309"
szcIcon.ImageColor3 = Color3.fromRGB(0, 210, 255)
szcIcon.Parent = szcIconBox

local szcTitle = Instance.new("TextLabel")
szcTitle.BackgroundTransparency = 1
szcTitle.Position = UDim2.fromOffset(62, 11)
szcTitle.Size = UDim2.new(1, -140, 0, 20)
szcTitle.Font = Enum.Font.FredokaOne
szcTitle.RichText = true
szcTitle.Text = 'រត់ចូល Safe Zone <font color="rgb(0, 210, 255)">(AUTO ESCAPE)</font>'
szcTitle.TextSize = 13
szcTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
szcTitle.TextXAlignment = Enum.TextXAlignment.Left
szcTitle.Parent = safeZoneCard

local szcStatus = Instance.new("TextLabel")
szcStatus.BackgroundTransparency = 1
szcStatus.Position = UDim2.fromOffset(62, 31)
szcStatus.Size = UDim2.new(1, -140, 0, 16)
szcStatus.Font = Enum.Font.FredokaOne
szcStatus.Text = "ស្ថានភាព៖ បិទ"
szcStatus.TextSize = 10
szcStatus.TextColor3 = Color3.fromRGB(130, 150, 180)
szcStatus.TextXAlignment = Enum.TextXAlignment.Left
szcStatus.Parent = safeZoneCard

local szcToggle = Instance.new("TextButton")
szcToggle.AnchorPoint = Vector2.new(1, 0)
szcToggle.Position = UDim2.new(1, -14, 0, 15)
szcToggle.Size = UDim2.fromOffset(48, 24)
szcToggle.BackgroundColor3 = Color3.fromRGB(24, 40, 68)
szcToggle.BorderSizePixel = 0
szcToggle.Text = ""
szcToggle.AutoButtonColor = false
szcToggle.Parent = safeZoneCard

local szctCorner = Instance.new("UICorner")
szctCorner.CornerRadius = UDim.new(1, 0)
szctCorner.Parent = szcToggle

local szcThumb = Instance.new("Frame")
szcThumb.AnchorPoint = Vector2.new(0, 0.5)
szcThumb.Position = UDim2.new(0, 3, 0.5, 0)
szcThumb.Size = UDim2.fromOffset(18, 18)
szcThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
szcThumb.BorderSizePixel = 0
szcThumb.Parent = szcToggle

local szctbCorner = Instance.new("UICorner")
szctbCorner.CornerRadius = UDim.new(1, 0)
szctbCorner.Parent = szcThumb

-- ប៊ូតុងកំណត់ទីតាំងបន្ទាត់ Safe Zone ដោយដៃ
local setSafeBtn = Instance.new("TextButton")
setSafeBtn.Name = "SetSafeZoneButton"
setSafeBtn.Position = UDim2.fromOffset(10, 58)
setSafeBtn.Size = UDim2.new(1, -20, 0, 28)
setSafeBtn.BackgroundColor3 = Color3.fromRGB(12, 26, 52)
setSafeBtn.BorderSizePixel = 0
setSafeBtn.Font = Enum.Font.FredokaOne
setSafeBtn.Text = "📍 ឈរលើបន្ទាត់ SAFE ZONE រួចចុចត្រង់នេះ"
setSafeBtn.TextSize = 10
setSafeBtn.TextColor3 = Color3.fromRGB(0, 210, 255)
setSafeBtn.AutoButtonColor = false
setSafeBtn.Parent = safeZoneCard

local ssbCorner = Instance.new("UICorner")
ssbCorner.CornerRadius = UDim.new(0, 8)
ssbCorner.Parent = setSafeBtn

local ssbStroke = Instance.new("UIStroke")
ssbStroke.Color = Color3.fromRGB(0, 140, 255)
ssbStroke.Transparency = 0.5
ssbStroke.Parent = setSafeBtn

setSafeBtn.Activated:Connect(function()
    AkiraPlayClick()
    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        CUSTOM_SAFE_ZONE = root.Position
        setSafeBtn.Text = "✅ បានចំណាំបន្ទាត់ SAFE ZONE រួចរាល់!"
        setSafeBtn.TextColor3 = Color3.fromRGB(80, 255, 140)
    end
end)

local function setAutoSafeZoneState(enabled)
    AutoSafeZoneEnabled = enabled

    if AutoSafeZoneEnabled then
        floatBtn.Visible = true
        fbStroke.Color = Color3.fromRGB(0, 210, 255)
        fbIcon.ImageColor3 = Color3.fromRGB(0, 210, 255)

        szcStatus.Text = "ស្ថានភាព៖ រង់ចាំលួច Egg"
        szcStatus.TextColor3 = Color3.fromRGB(80, 255, 140)
        tween(szcToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 140, 255)})
        tween(szcThumb, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -21, 0.5, 0)
        })
    else
        floatBtn.Visible = false
        IsRunningToSafeZone = false
        szcStatus.Text = "ស្ថានភាព៖ បិទ"
        szcStatus.TextColor3 = Color3.fromRGB(130, 150, 180)
        tween(szcToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 40, 68)})
        tween(szcThumb, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 3, 0.5, 0)
        })
    end
end

szcToggle.Activated:Connect(function()
    AkiraPlayClick()
    setAutoSafeZoneState(not AutoSafeZoneEnabled)
end)

floatBtn.InputEnded:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not fMoved then
        AkiraPlayClick()
        if AutoSafeZoneEnabled then
            AutoSafeZoneEnabled = false
            IsRunningToSafeZone = false
            fbStroke.Color = Color3.fromRGB(255, 60, 60)
            fbIcon.ImageColor3 = Color3.fromRGB(255, 100, 100)
            szcStatus.Text = "ស្ថានភាព៖ បិទ (តាម Floating)"
            szcStatus.TextColor3 = Color3.fromRGB(255, 120, 120)
            tween(szcToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 40, 68)})
            tween(szcThumb, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, 0)})
        else
            AutoSafeZoneEnabled = true
            fbStroke.Color = Color3.fromRGB(0, 210, 255)
            fbIcon.ImageColor3 = Color3.fromRGB(0, 210, 255)
            szcStatus.Text = "ស្ថានភាព៖ រង់ចាំលួច Egg"
            szcStatus.TextColor3 = Color3.fromRGB(80, 255, 140)
            tween(szcToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 140, 255)})
            tween(szcThumb, TweenInfo.new(0.2), {Position = UDim2.new(1, -21, 0.5, 0)})
        end
    end
end)

-- ឆែករកប៊ូតុង "Drop" ពណ៌ក្រហមលើអេក្រង់
local function isDropButtonActive()
    for _, g in ipairs(PlayerGui:GetChildren()) do
        if g:IsA("ScreenGui") and g.Name ~= "AkiraScriptHub" and g.Enabled then
            for _, v in ipairs(g:GetDescendants()) do
                if v:IsA("GuiObject") and v.Visible then
                    local nameMatch = string.find(string.lower(v.Name), "drop")
                    local textMatch = (v:IsA("TextLabel") or v:IsA("TextButton")) and string.find(string.lower(v.Text), "drop")
                    if nameMatch or textMatch then
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- ស្វែងរកទីតាំងបន្ទាត់ Safe Zone (ស្វ័យប្រវត្តិតាមអក្សរលើដី ឬចំណុចដែលបានកំណត់)
local function findAccurateSafeZone(myPos)
    if CUSTOM_SAFE_ZONE then
        return CUSTOM_SAFE_ZONE
    end

    local safeNames = {"safezone", "safe_zone", "safe zone", "safe", "finish", "home"}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local lowerName = string.lower(obj.Name)
            for _, keyword in ipairs(safeNames) do
                if string.find(lowerName, keyword, 1, true) then
                    return obj.Position
                end
            end
        end
    end

    -- Do not silently teleport to a stale hard-coded coordinate.
    return nil
end

-- ស្វែងរកមេដែលកំពុងដេញ
local function getNearestMonster(myRoot)
    local nearestDist = math.huge
    local monster = nil
    for _, model in ipairs(workspace:GetChildren()) do
        if model:IsA("Model") and model ~= Player.Character then
            local hum = model:FindFirstChildOfClass("Humanoid")
            local root = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso")
            if hum and root and not Players:GetPlayerFromCharacter(model) then
                local dist = (myRoot.Position - root.Position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    monster = model
                end
            end
        end
    end
    return monster, nearestDist
end

-- ដំណើរការរត់ចូល Safe Zone
local function RunToSafety(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root or IsRunningToSafeZone then return end

    IsRunningToSafeZone = true
    szcStatus.Text = "ស្ថានភាព៖ កំពុងកាន់ Egg រត់ទៅ Safe Zone..."
    szcStatus.TextColor3 = Color3.fromRGB(0, 210, 255)

    local targetSafeZone = findAccurateSafeZone(root.Position)
    if not targetSafeZone then
        IsRunningToSafeZone = false
        szcStatus.Text = "ស្ថានភាព៖ មិនរកឃើញ Safe Zone — សូមកំណត់ទីតាំងជាមុន"
        szcStatus.TextColor3 = Color3.fromRGB(255, 180, 80)
        return
    end

    local originalWalkSpeed = humanoid.WalkSpeed

    task.spawn(function()
        while AutoSafeZoneEnabled and IsRunningToSafeZone and character.Parent do
            -- ប្រសិនបើប៊ូតុង Drop បាត់ពីអេក្រង់ = ពងធ្លាក់ពីដៃ ឬចុច Drop -> ឈប់រត់ភ្លាម!
            if not isDropButtonActive() then
                humanoid.WalkSpeed = originalWalkSpeed
                humanoid:MoveTo(root.Position)
                szcStatus.Text = "ស្ថានភាព៖ ពងធ្លាក់ពីដៃ (ឈប់រត់)"
                szcStatus.TextColor3 = Color3.fromRGB(255, 120, 120)
                break
            end

            -- ដល់បន្ទាត់ Safe Zone ជោគជ័យ
            local distToSafe = (root.Position - targetSafeZone).Magnitude
            if distToSafe <= 10 then
                szcStatus.Text = "ស្ថានភាព៖ ដល់ Safe Zone សុវត្ថិភាពហើយ!"
                szcStatus.TextColor3 = Color3.fromRGB(80, 255, 140)
                break
            end

            -- គណនាល្បឿនរត់គេចមេ
            local monster, mDist = getNearestMonster(root)
            local targetSpeed = 22

            if monster and mDist < 35 then
                local mHum = monster:FindFirstChildOfClass("Humanoid")
                local mSpeed = mHum and mHum.WalkSpeed or 20
                targetSpeed = math.clamp(mSpeed + 3, 23, 36)
            end

            humanoid.WalkSpeed = targetSpeed
            humanoid:MoveTo(targetSafeZone)

            task.wait(0.12)
        end

        if humanoid.Parent then
            humanoid.WalkSpeed = originalWalkSpeed
        end
        IsRunningToSafeZone = false
        task.wait(2)
        if AutoSafeZoneEnabled then
            szcStatus.Text = "ស្ថានភាព៖ រង់ចាំលួច Egg"
            szcStatus.TextColor3 = Color3.fromRGB(80, 255, 140)
        end
    end)
end

-- តាមដានវត្តមានប៊ូតុង Drop លើអេក្រង់ផ្ទាល់ជាប្រចាំ
RunService.RenderStepped:Connect(function()
    if AutoSafeZoneEnabled and not IsRunningToSafeZone then
        local char = Player.Character
        if char and isDropButtonActive() then
            RunToSafety(char)
        end
    end
end)

-- ចាប់សញ្ញាបន្ថែមតាមរយៈ ProximityPrompt ពេលចុចលួចពង
ProximityPromptService.PromptTriggered:Connect(function(prompt, p)
    if p == Player and AutoSafeZoneEnabled and not IsRunningToSafeZone then
        local pName = string.lower(prompt.ObjectText .. " " .. prompt.ActionText .. " " .. prompt.Name)
        if string.find(pName, "egg") or string.find(pName, "steal") or string.find(pName, "take") or string.find(pName, "pick") then
            local char = Player.Character
            if char then
                task.delay(0.1, function()
                    RunToSafety(char)
                end)
            end
        end
    end
end)

-- ============================================================
-- DRAGGING MENU SYSTEM
-- ============================================================
local dragDot = Instance.new("ImageButton")
dragDot.Name = "DragDot"
dragDot.AnchorPoint = Vector2.new(0.5, 0)
dragDot.Position = UDim2.new(0, 160, 1, -12)
dragDot.Size = UDim2.fromOffset(16, 16)
dragDot.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
dragDot.BorderSizePixel = 0
dragDot.AutoButtonColor = false
dragDot.Active = true
dragDot.Parent = main

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = dragDot

local dotStroke = Instance.new("UIStroke")
dotStroke.Thickness = 2
dotStroke.Color = Color3.fromRGB(255, 255, 255)
dotStroke.Parent = dragDot

local isMainDragging = false
local mainDragStart = nil
local mainStartPos = nil

local function bindDragger(obj)
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isMainDragging = true
            mainDragStart = input.Position
            mainStartPos = main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    isMainDragging = false
                end
            end)
        end
    end)
end

bindDragger(top)
bindDragger(dragDot)

UIS.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and isMainDragging and mainDragStart and mainStartPos then
        local delta = input.Position - mainDragStart
        main.Position = UDim2.new(
            mainStartPos.X.Scale,
            mainStartPos.X.Offset + delta.X,
            mainStartPos.Y.Scale,
            mainStartPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isMainDragging = false
    end
end)

-- ============================================================
-- FLOATING LOGO BUTTON
-- ============================================================
local openButton = Instance.new("ImageButton")
openButton.Name = "OpenAkiraLogo"
openButton.AnchorPoint = Vector2.new(0.5, 0.5)
openButton.Position = UDim2.new(1, -50, 0.5, 0)
openButton.Size = UDim2.fromOffset(56, 56)
openButton.BackgroundColor3 = Color3.fromRGB(4, 9, 20)
openButton.Image = "rbxassetid://97330468088484"
openButton.AutoButtonColor = false
openButton.Active = true
openButton.Visible = false
openButton.Parent = gui

local obCorner = Instance.new("UICorner")
obCorner.CornerRadius = UDim.new(1, 0)
obCorner.Parent = openButton

local obStroke = Instance.new("UIStroke")
obStroke.Thickness = 2.5
obStroke.Color = Color3.fromRGB(0, 140, 255)
obStroke.Parent = openButton

local function toggleGUI(visible)
    if visible then
        openButton.Visible = false
        main.Visible = true
        main.Position = UDim2.fromScale(0.5, 0.5)
        scale.Scale = 0.75
        tween(scale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 0.92
        })
    else
        local hideTween = tween(scale, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Scale = 0.7
        })
        hideTween.Completed:Wait()
        main.Visible = false
        scale.Scale = 0.92
        openButton.Visible = true
    end
end

closeBtn.Activated:Connect(function()
    AkiraPlayClick()
    toggleGUI(false)
end)

minimizeBtn.Activated:Connect(function()
    AkiraPlayClick()
    toggleGUI(false)
end)

local logoDragging = false
local logoDragStart = nil
local logoStartPos = nil
local hasMoved = false

openButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        logoDragging = true
        hasMoved = false
        logoDragStart = input.Position
        logoStartPos = openButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                logoDragging = false
            end
        end)
    end
end)

openButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if logoDragging and logoDragStart and logoStartPos then
            local delta = input.Position - logoDragStart
            if delta.Magnitude > 6 then
                hasMoved = true
            end

            local camera = workspace.CurrentCamera
            local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
            local btnSize = openButton.AbsoluteSize.X * 0.5

            local startAbs = openButton.AbsolutePosition + Vector2.new(openButton.AbsoluteSize.X * 0.5, openButton.AbsoluteSize.Y * 0.5) - delta
            local rawX = startAbs.X + delta.X
            local rawY = startAbs.Y + delta.Y

            local clampedX = math.clamp(rawX, btnSize + 10, viewport.X - btnSize - 10)
            local clampedY = math.clamp(rawY, btnSize + 10, viewport.Y - btnSize - 10)

            openButton.Position = UDim2.fromOffset(clampedX, clampedY)
        end
    end
end)

openButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        logoDragging = false
        if not hasMoved then
            AkiraPlayClick()
            toggleGUI(true)
        end
        hasMoved = false
    end
end)

-- ============================================================
-- LIVE ANIMATIONS & SYNCHRONIZED RGB
-- ============================================================
local rainbowSequence = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 127, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 180, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(150, 0, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
})

local rgbStrokeGradient = Instance.new("UIGradient")
rgbStrokeGradient.Name = "RGBStrokeFlow"
rgbStrokeGradient.Color = rainbowSequence
rgbStrokeGradient.Parent = mainStroke

local logoRGB = rgbStrokeGradient:Clone()
logoRGB.Parent = logoCardStroke

local dotRGB = rgbStrokeGradient:Clone()
dotRGB.Parent = dotStroke

task.spawn(function()
    local rot = 0
    while gui.Parent and main.Parent do
        rot = (rot + 3) % 360
        if rgbStrokeGradient.Parent then rgbStrokeGradient.Rotation = rot end
        if logoRGB.Parent then logoRGB.Rotation = rot end
        if dotRGB.Parent then dotRGB.Rotation = rot end
        task.wait(0.03)
    end
end)

local akiraGradient = Instance.new("UIGradient")
akiraGradient.Name = "AkiraTextRGB"
akiraGradient.Rotation = 0
akiraGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(0.30, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 0, 140)),
    ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 200, 255))
})
akiraGradient.Offset = Vector2.new(-1.2, 0)
akiraGradient.Parent = title

task.spawn(function()
    while gui.Parent and title.Parent do
        akiraGradient.Offset = Vector2.new(-1.2, 0)
        local t = tween(akiraGradient, TweenInfo.new(1.8, Enum.EasingStyle.Linear), {
            Offset = Vector2.new(1.2, 0)
        })
        t.Completed:Wait()
        task.wait(1.2)
    end
end)

task.spawn(function()
    local basePos = title.Position
    while gui.Parent and title.Parent do
        local up = tween(title, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Position = UDim2.new(basePos.X.Scale, basePos.X.Offset, basePos.Y.Scale, basePos.Y.Offset - 2)
        })
        up.Completed:Wait()

        local down = tween(title, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Position = UDim2.new(basePos.X.Scale, basePos.X.Offset, basePos.Y.Scale, basePos.Y.Offset + 1)
        })
        down.Completed:Wait()
    end
end)

task.spawn(function()
    while gui.Parent and openButton.Parent do
        local floatGlow = tween(obStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Color3.fromRGB(0, 240, 255),
            Thickness = 3.2
        })
        floatGlow.Completed:Wait()

        local floatFade = tween(obStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Color3.fromRGB(0, 110, 220),
            Thickness = 2
        })
        floatFade.Completed:Wait()
    end
end)