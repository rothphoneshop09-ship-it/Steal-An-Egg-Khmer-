--[[
    AKIRA SCRIPT HUB • FULL FIX EDITION
    - ស្ទីល UI ថ្មីតាមរូបភាព (Modern Dark Blue / Cyan Glow)
    - ជួសជុល Icon បាត់ តាមរយៈ Asset ID ផ្ទាល់
    - ជួសជុលការ Drag & Drop ទាំងផ្ទាំង Menu និងប៊ូតុង Logo Akira
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

-- សំឡេងចុច
local AkiraSoundFolder = SoundService:FindFirstChild("AkiraSounds") or Instance.new("Folder")
AkiraSoundFolder.Name = "AkiraSounds"
AkiraSoundFolder.Parent = SoundService

local AkiraClickSound = AkiraSoundFolder:FindFirstChild("AkiraClick") or Instance.new("Sound")
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
mainStroke.Color = Color3.fromRGB(0, 140, 255)
mainStroke.Transparency = 0.2
mainStroke.Parent = main

-- ============================================================
-- TOP BAR (HEADER & DRAG AREA)
-- ============================================================
local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 68)
top.BackgroundTransparency = 1
top.Active = true
top.Parent = main

-- Logo Box ខាងឆ្វេងលើ
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
logoCardStroke.Color = Color3.fromRGB(0, 150, 255)
logoCardStroke.Transparency = 0.35
logoCardStroke.Parent = logoCard

local logoImage = Instance.new("ImageLabel")
logoImage.Name = "LogoImage"
logoImage.BackgroundTransparency = 1
logoImage.AnchorPoint = Vector2.new(0.5, 0.5)
logoImage.Position = UDim2.fromScale(0.5, 0.5)
logoImage.Size = UDim2.fromOffset(40, 40)
logoImage.Image = "rbxassetid://97330468088484"
logoImage.Parent = logoCard

-- Title & Subtitle
local title = Instance.new("TextLabel")
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

-- Controls: Minimize & Close
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

-- Telegram Button
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

-- Content Pages
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
-- ANTI-HIT CARD & TOGGLE SWITCH
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

-- Toggle Switch
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
-- DRAGGING MENU SYSTEM (ទាញទម្លាក់ MENU តាម TOPBAR & INDICATOR)
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
dotStroke.Color = Color3.fromRGB(4, 9, 20)
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
-- FLOATING LOGO BUTTON (DRAGGABLE & CLICKABLE FIX)
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

            local rawX = logoStartPos.X.Offset + delta.X
            local rawY = logoStartPos.Y.Offset + delta.Y

            local clampedX = math.clamp(rawX, btnSize + 10, viewport.X - btnSize - 10)
            local clampedY = math.clamp(rawY, btnSize + 10, viewport.Y - btnSize - 10)

            openButton.Position = UDim2.new(0, clampedX, 0, clampedY)
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
