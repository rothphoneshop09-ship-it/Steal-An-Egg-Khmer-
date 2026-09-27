--[[
    AKIRA SCRIPT HUB • MOBILE STABLE FIX
    - ទំហំសមស្របជាមួយអេក្រង់ទូរស័ព្ទដៃ (380x230)
    - ធានាដំណើរការ ១០០% មិនគាំង មិនបាត់ផ្ទាំង
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local Player = Players.LocalPlayer
while not Player do
    task.wait(0.1)
    Player = Players.LocalPlayer
end

local PlayerGui = Player:WaitForChild("PlayerGui", 10)
if not PlayerGui then return end

-- សម្អាតផ្ទាំងចាស់
if PlayerGui:FindFirstChild("AkiraHubFix") then
    PlayerGui.AkiraHubFix:Destroy()
end

local function tween(obj, info, props)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

-- ============================================================
-- GUI មេ
-- ============================================================
local gui = Instance.new("ScreenGui")
gui.Name = "AkiraHubFix"
gui.ResetOnSpawn = false
gui.DisplayOrder = 9999
gui.Parent = PlayerGui

-- សំឡេងចុច
local AkiraClickSound = Instance.new("Sound")
AkiraClickSound.SoundId = "rbxassetid://6026984224"
AkiraClickSound.Volume = 0.3
AkiraClickSound.Parent = gui

local function AkiraPlayClick()
    pcall(function()
        AkiraClickSound:Stop()
        AkiraClickSound.TimePosition = 0
        AkiraClickSound:Play()
    end)
end

-- ចម្រៀង BGM
local MusicSound = Instance.new("Sound")
MusicSound.Name = "AkiraBGM"
MusicSound.SoundId = "rbxassetid://110960672338793"
MusicSound.Volume = 0.35
MusicSound.Looped = true
MusicSound.Parent = gui
pcall(function() MusicSound:Play() end)

-- ផ្ទាំង Menu ធំ (Main Frame កំណត់ទំហំឱ្យល្មមអេក្រង់ទូរស័ព្ទ)
local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.5)
main.Size = UDim2.fromOffset(390, 230)
main.BackgroundColor3 = Color3.fromRGB(4, 9, 20)
main.BorderSizePixel = 0
main.Active = true
main.Visible = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2
mainStroke.Color = Color3.fromRGB(0, 140, 255)
mainStroke.Parent = main

-- ============================================================
-- TOP BAR (ចំណងជើង និងប៊ូតុង Close/Mini)
-- ============================================================
local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 50)
top.BackgroundTransparency = 1
top.Active = true
top.Parent = main

-- Logo Card
local logoCard = Instance.new("Frame")
logoCard.Position = UDim2.fromOffset(10, 8)
logoCard.Size = UDim2.fromOffset(35, 35)
logoCard.BackgroundColor3 = Color3.fromRGB(7, 16, 32)
logoCard.BorderSizePixel = 0
logoCard.Parent = top

local lcCorner = Instance.new("UICorner")
lcCorner.CornerRadius = UDim.new(0, 10)
lcCorner.Parent = logoCard

local lcStroke = Instance.new("UIStroke")
lcStroke.Thickness = 1.2
lcStroke.Color = Color3.fromRGB(0, 140, 255)
lcStroke.Parent = logoCard

local logoImage = Instance.new("ImageLabel")
logoImage.BackgroundTransparency = 1
logoImage.AnchorPoint = Vector2.new(0.5, 0.5)
logoImage.Position = UDim2.fromScale(0.5, 0.5)
logoImage.Size = UDim2.fromOffset(28, 28)
logoImage.Image = "rbxassetid://97330468088484"
logoImage.Parent = logoCard

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(52, 9)
title.Size = UDim2.new(0, 150, 0, 18)
title.Font = Enum.Font.GothamBlack
title.Text = "AKIRA SCRIPT"
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.fromOffset(52, 27)
subtitle.Size = UDim2.new(0, 200, 0, 14)
subtitle.Font = Enum.Font.GothamBold
subtitle.Text = "Product BENZ • AKIRA SCRIPT"
subtitle.TextSize = 9
subtitle.TextColor3 = Color3.fromRGB(180, 195, 220)
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = top

-- ប៊ូតុង Close និង Minimize
local function createTopControl(iconId, xPos)
    local btn = Instance.new("ImageButton")
    btn.Size = UDim2.fromOffset(24, 24)
    btn.Position = UDim2.new(1, xPos, 0, 12)
    btn.AnchorPoint = Vector2.new(1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(8, 18, 38)
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = top

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    local img = Instance.new("ImageLabel")
    img.BackgroundTransparency = 1
    img.AnchorPoint = Vector2.new(0.5, 0.5)
    img.Position = UDim2.fromScale(0.5, 0.5)
    img.Size = UDim2.fromOffset(12, 12)
    img.Image = iconId
    img.ImageColor3 = Color3.fromRGB(190, 210, 240)
    img.Parent = btn

    return btn
end

local closeBtn = createTopControl("rbxassetid://10747384394", -10)
local minimizeBtn = createTopControl("rbxassetid://10709790948", -38)

-- ============================================================
-- SIDEBAR & TABS
-- ============================================================
local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.fromOffset(10, 52)
sidebar.Size = UDim2.new(0, 95, 1, -62)
sidebar.BackgroundColor3 = Color3.fromRGB(6, 13, 26)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 10)
sbCorner.Parent = sidebar

local sbStroke = Instance.new("UIStroke")
sbStroke.Thickness = 1
sbStroke.Color = Color3.fromRGB(0, 140, 255)
sbStroke.Transparency = 0.4
sbStroke.Parent = sidebar

local teleBtn = Instance.new("TextButton")
teleBtn.AnchorPoint = Vector2.new(0.5, 1)
teleBtn.Position = UDim2.new(0.5, 0, 1, -6)
teleBtn.Size = UDim2.new(1, -10, 0, 26)
teleBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
teleBtn.BorderSizePixel = 0
teleBtn.Text = "telegram"
teleBtn.Font = Enum.Font.GothamBlack
teleBtn.TextSize = 11
teleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
teleBtn.AutoButtonColor = false
teleBtn.Parent = sidebar

local tCorner = Instance.new("UICorner")
tCorner.CornerRadius = UDim.new(0, 6)
tCorner.Parent = teleBtn

local content = Instance.new("Frame")
content.Position = UDim2.new(0, 112, 0, 52)
content.Size = UDim2.new(1, -122, 1, -62)
content.BackgroundTransparency = 1
content.Parent = main

local pages = {}
local tabBtns = {}

local function createPage(name, visible)
    local p = Instance.new("ScrollingFrame")
    p.Size = UDim2.fromScale(1, 1)
    p.BackgroundTransparency = 1
    p.BorderSizePixel = 0
    p.ScrollBarThickness = 2
    p.ScrollBarImageColor3 = Color3.fromRGB(0, 140, 255)
    p.CanvasSize = UDim2.new()
    p.AutomaticCanvasSize = Enum.AutomaticSize.Y
    p.Visible = visible
    p.Parent = content

    local l = Instance.new("UIListLayout")
    l.Padding = UDim.new(0, 6)
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Parent = p

    pages[name] = p
    return p
end

local scriptsPage = createPage("ស្គ្រីប", true)
local configPage = createPage("ការកំណត់", false)
local infoPage = createPage("ព័ត៌មាន", false)

local function createTab(name, iconId, yOffset)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -8, 0, 28)
    btn.Position = UDim2.fromOffset(4, yOffset)
    btn.BackgroundColor3 = Color3.fromRGB(11, 24, 48)
    btn.BackgroundTransparency = (name == "ស្គ្រីប" and 0 or 1)
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = sidebar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.BackgroundTransparency = 1
    icon.AnchorPoint = Vector2.new(0, 0.5)
    icon.Position = UDim2.new(0, 6, 0.5, 0)
    icon.Size = UDim2.fromOffset(13, 13)
    icon.Image = iconId
    icon.ImageColor3 = (name == "ស្គ្រីប" and Color3.fromRGB(0, 190, 255) or Color3.fromRGB(120, 140, 170))
    icon.Parent = btn

    local lbl = Instance.new("TextLabel")
    lbl.Name = "Lbl"
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.fromOffset(24, 0)
    lbl.Size = UDim2.new(1, -26, 1, 0)
    lbl.Font = Enum.Font.FredokaOne
    lbl.Text = name
    lbl.TextSize = 10
    lbl.TextColor3 = (name == "ស្គ្រីប" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 140, 170))
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = btn

    btn.Activated:Connect(function()
        AkiraPlayClick()
        for tName, tBtn in pairs(tabBtns) do
            local sel = (tName == name)
            tBtn.BackgroundTransparency = sel and 0 or 1
            tBtn.Icon.ImageColor3 = sel and Color3.fromRGB(0, 190, 255) or Color3.fromRGB(120, 140, 170)
            tBtn.Lbl.TextColor3 = sel and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 140, 170)
            pages[tName].Visible = sel
        end
    end)

    tabBtns[name] = btn
    return btn
end

createTab("ស្គ្រីប", "rbxassetid://10734950309", 8)
createTab("ការកំណត់", "rbxassetid://10734950020", 40)
createTab("ព័ត៌មាន", "rbxassetid://10747373176", 72)

-- ============================================================
-- ANTI-HIT (TAB 1)
-- ============================================================
local AntiHitEnabled = false
local IsAntiHitRunning = false

local ahCard = Instance.new("Frame")
ahCard.Size = UDim2.new(1, -6, 0, 50)
ahCard.BackgroundColor3 = Color3.fromRGB(7, 16, 32)
ahCard.BorderSizePixel = 0
ahCard.Parent = scriptsPage

local ahCorner = Instance.new("UICorner")
ahCorner.CornerRadius = UDim.new(0, 8)
ahCorner.Parent = ahCard

local ahcStroke = Instance.new("UIStroke")
ahcStroke.Thickness = 1
ahcStroke.Color = Color3.fromRGB(0, 140, 255)
ahcStroke.Transparency = 0.5
ahcStroke.Parent = ahCard

local sBox = Instance.new("Frame")
sBox.Position = UDim2.fromOffset(6, 7)
sBox.Size = UDim2.fromOffset(36, 36)
sBox.BackgroundColor3 = Color3.fromRGB(12, 26, 52)
sBox.BorderSizePixel = 0
sBox.Parent = ahCard

local sbC = Instance.new("UICorner")
sbC.CornerRadius = UDim.new(0, 8)
sbC.Parent = sBox

local sImg = Instance.new("ImageLabel")
sImg.BackgroundTransparency = 1
sImg.AnchorPoint = Vector2.new(0.5, 0.5)
sImg.Position = UDim2.fromScale(0.5, 0.5)
sImg.Size = UDim2.fromOffset(20, 20)
sImg.Image = "rbxassetid://10734950309"
sImg.ImageColor3 = Color3.fromRGB(0, 160, 255)
sImg.Parent = sBox

local ahTitle = Instance.new("TextLabel")
ahTitle.BackgroundTransparency = 1
ahTitle.Position = UDim2.fromOffset(48, 8)
ahTitle.Size = UDim2.new(1, -100, 0, 16)
ahTitle.Font = Enum.Font.FredokaOne
ahTitle.RichText = true
ahTitle.Text = 'ការការពារការវាយ <font color="rgb(0, 210, 255)">(ANTI-HIT)</font>[span_0](start_span)'[span_0](end_span)
ahTitle.TextSize = 11
ahTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ahTitle.TextXAlignment = Enum.TextXAlignment.Left
ahTitle.Parent = ahCard

local ahStatus = Instance.new("TextLabel")
ahStatus.BackgroundTransparency = 1
ahStatus.Position = UDim2.fromOffset(48, 25)
ahStatus.Size = UDim2.new(1, -100, 0, 14)
ahStatus.Font = Enum.Font.FredokaOne
ahStatus.Text = "ស្ថានភាព៖ បិទ[span_1](start_span)"[span_1](end_span)
ahStatus.TextSize = 9
ahStatus.TextColor3 = Color3.fromRGB(130, 150, 180)
ahStatus.TextXAlignment = Enum.TextXAlignment.Left
ahStatus.Parent = ahCard

local ahToggle = Instance.new("TextButton")
ahToggle.AnchorPoint = Vector2.new(1, 0.5)
ahToggle.Position = UDim2.new(1, -10, 0.5, 0)
ahToggle.Size = UDim2.fromOffset(42, 20)
ahToggle.BackgroundColor3 = Color3.fromRGB(24, 40, 68)
ahToggle.BorderSizePixel = 0
ahToggle.Text = ""
ahToggle.AutoButtonColor = false
ahToggle.Parent = ahCard

local ahtC = Instance.new("UICorner")
ahtC.CornerRadius = UDim.new(1, 0)
ahtC.Parent = ahToggle

local ahThumb = Instance.new("Frame")
ahThumb.AnchorPoint = Vector2.new(0, 0.5)
ahThumb.Position = UDim2.new(0, 3, 0.5, 0)
ahThumb.Size = UDim2.fromOffset(14, 14)
ahThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ahThumb.BorderSizePixel = 0
ahThumb.Parent = ahToggle

local ahmC = Instance.new("UICorner")
ahmC.CornerRadius = UDim.new(1, 0)
ahmC.Parent = ahThumb

ahToggle.Activated:Connect(function()
    AkiraPlayClick()
    AntiHitEnabled = not AntiHitEnabled
    if AntiHitEnabled then
        ahStatus.Text = "ស្ថានភាព៖ បើកដំណើរការ"
        ahStatus.TextColor3 = Color3.fromRGB(80, 255, 140)
        ahToggle.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
        ahThumb.Position = UDim2.new(1, -17, 0.5, 0)
    else
        ahStatus.Text = "ស្ថានភាព៖ បិទ[span_2](start_span)"[span_2](end_span)
        ahStatus.TextColor3 = Color3.fromRGB(130, 150, 180)
        ahToggle.BackgroundColor3 = Color3.fromRGB(24, 40, 68)
        ahThumb.Position = UDim2.new(0, 3, 0.5, 0)
    end
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

ProximityPromptService.PromptTriggered:Connect(function(prompt, p)
    if p ~= Player or not AntiHitEnabled or IsAntiHitRunning then return end
    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not root or not hum or hum.Health <= 0 then return end

    IsAntiHitRunning = true
    task.spawn(function()
        for _, pos in ipairs(TeleportPoints) do
            if not AntiHitEnabled or not root.Parent or hum.Health <= 0 then break end
            root.CFrame = CFrame.new(pos, pos + root.CFrame.LookVector)
            task.wait(0.016)
        end
        IsAntiHitRunning = false
    end)
end)

-- ============================================================
-- MUSIC TOGGLE (TAB 2)
-- ============================================================
local mCard = Instance.new("Frame")
mCard.Size = UDim2.new(1, -6, 0, 50)
mCard.BackgroundColor3 = Color3.fromRGB(7, 16, 32)
mCard.BorderSizePixel = 0
mCard.Parent = configPage

local mcCorner = Instance.new("UICorner")
mcCorner.CornerRadius = UDim.new(0, 8)
mcCorner.Parent = mCard

local mcStroke = Instance.new("UIStroke")
mcStroke.Thickness = 1
mcStroke.Color = Color3.fromRGB(0, 140, 255)
mcStroke.Transparency = 0.5
mcStroke.Parent = mCard

local mBox = Instance.new("Frame")
mBox.Position = UDim2.fromOffset(6, 7)
mBox.Size = UDim2.fromOffset(36, 36)
mBox.BackgroundColor3 = Color3.fromRGB(12, 26, 52)
mBox.BorderSizePixel = 0
mBox.Parent = mCard

local mbC = Instance.new("UICorner")
mbC.CornerRadius = UDim.new(0, 8)
mbC.Parent = mBox

local mImg = Instance.new("ImageLabel")
mImg.BackgroundTransparency = 1
mImg.AnchorPoint = Vector2.new(0.5, 0.5)
mImg.Position = UDim2.fromScale(0.5, 0.5)
mImg.Size = UDim2.fromOffset(18, 18)
mImg.Image = "rbxassetid://10734952485"
mImg.ImageColor3 = Color3.fromRGB(0, 180, 255)
mImg.Parent = mBox

local mTitle = Instance.new("TextLabel")
mTitle.BackgroundTransparency = 1
mTitle.Position = UDim2.fromOffset(48, 8)
mTitle.Size = UDim2.new(1, -100, 0, 16)
mTitle.Font = Enum.Font.FredokaOne
mTitle.Text = "តន្ត្រីផ្ទៃខាងក្រោយ (BGM)"
mTitle.TextSize = 11
mTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
mTitle.TextXAlignment = Enum.TextXAlignment.Left
mTitle.Parent = mCard

local mStatus = Instance.new("TextLabel")
mStatus.BackgroundTransparency = 1
mStatus.Position = UDim2.fromOffset(48, 25)
mStatus.Size = UDim2.new(1, -100, 0, 14)
mStatus.Font = Enum.Font.FredokaOne
mStatus.Text = "ស្ថានភាព៖ បើក"
mStatus.TextSize = 9
mStatus.TextColor3 = Color3.fromRGB(80, 255, 140)
mStatus.TextXAlignment = Enum.TextXAlignment.Left
mStatus.Parent = mCard

local mToggle = Instance.new("TextButton")
mToggle.AnchorPoint = Vector2.new(1, 0.5)
mToggle.Position = UDim2.new(1, -10, 0.5, 0)
mToggle.Size = UDim2.fromOffset(42, 20)
mToggle.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
mToggle.BorderSizePixel = 0
mToggle.Text = ""
mToggle.AutoButtonColor = false
mToggle.Parent = mCard

local mtC = Instance.new("UICorner")
mtC.CornerRadius = UDim.new(1, 0)
mtC.Parent = mToggle

local mThumb = Instance.new("Frame")
mThumb.AnchorPoint = Vector2.new(0, 0.5)
mThumb.Position = UDim2.new(1, -17, 0.5, 0)
mThumb.Size = UDim2.fromOffset(14, 14)
mThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mThumb.BorderSizePixel = 0
mThumb.Parent = mToggle

local mmC = Instance.new("UICorner")
mmC.CornerRadius = UDim.new(1, 0)
mmC.Parent = mThumb

local isMusicOn = true
mToggle.Activated:Connect(function()
    AkiraPlayClick()
    isMusicOn = not isMusicOn
    if isMusicOn then
        pcall(function() MusicSound:Resume() end)
        mStatus.Text = "ស្ថានភាព៖ បើក"
        mStatus.TextColor3 = Color3.fromRGB(80, 255, 140)
        mToggle.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
        mThumb.Position = UDim2.new(1, -17, 0.5, 0)
    else
        pcall(function() MusicSound:Pause() end)
        mStatus.Text = "ស្ថានភាព៖ បិទ"
        mStatus.TextColor3 = Color3.fromRGB(130, 150, 180)
        mToggle.BackgroundColor3 = Color3.fromRGB(24, 40, 68)
        mThumb.Position = UDim2.new(0, 3, 0.5, 0)
    end
end)

-- ============================================================
-- DRAGGING លើ MENU
-- ============================================================
local mDragging = false
local mStart, mPos

top.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        mDragging = true
        mStart = inp.Position
        mPos = main.Position
        inp.Changed:Connect(function()
            if inp.UserInputState == Enum.UserInputState.End then
                mDragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(inp)
    if (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) and mDragging and mStart and mPos then
        local delta = inp.Position - mStart
        main.Position = UDim2.new(mPos.X.Scale, mPos.X.Offset + delta.X, mPos.Y.Scale, mPos.Y.Offset + delta.Y)
    end
end)

-- ============================================================
-- FLOATING LOGO (ពេល MINIMIZE អាច DRAG បាន)[span_3](start_span)[span_3](end_span)
-- ============================================================
local openButton = Instance.new("ImageButton")
openButton.Name = "OpenLogo"
openButton.AnchorPoint = Vector2.new(0.5, 0.5)
openButton.Position = UDim2.new(1, -40, 0.5, 0)
openButton.Size = UDim2.fromOffset(48, 48)
openButton.BackgroundColor3 = Color3.fromRGB(4, 9, 20)
openButton.Image = "rbxassetid://97330468088484"
openButton.Active = true
openButton.Visible = false
openButton.Parent = gui

local obC = Instance.new("UICorner")
obC.CornerRadius = UDim.new(1, 0)
obC.Parent = openButton

local obS = Instance.new("UIStroke")
obS.Thickness = 2
obS.Color = Color3.fromRGB(0, 140, 255)
obS.Parent = openButton

local function setMenuVisible(v)
    if v then
        openButton.Visible = false
        main.Visible = true
        main.Position = UDim2.fromScale(0.5, 0.5)
    else
        main.Visible = false
        openButton.Visible = true
    end
end

closeBtn.Activated:Connect(function() AkiraPlayClick(); setMenuVisible(false) end)
minimizeBtn.Activated:Connect(function() AkiraPlayClick(); setMenuVisible(false) end)

local lDragging = false
local lStart, lPos
local lMoved = false

openButton.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        lDragging = true
        lMoved = false
        lStart = inp.Position
        lPos = openButton.Position
    end
end)

openButton.InputChanged:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
        if lDragging and lStart and lPos then
            local delta = inp.Position - lStart
            if delta.Magnitude > 6 then lMoved = true end
            openButton.Position = UDim2.new(0, lPos.X.Offset + delta.X, 0, lPos.Y.Offset + delta.Y)
        end
    end
end)

openButton.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        lDragging = false
        if not lMoved then
            AkiraPlayClick()
            setMenuVisible(true)
        end
        lMoved = false
    end
end)

-- ============================================================
-- RGB ANIMATION[span_4](start_span)[span_4](end_span)
-- ============================================================
local rgbGrad = Instance.new("UIGradient")
rgbGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 200, 0)),
    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 100)),
    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 180, 255)),
    ColorSequenceKeypoint.new(0.80, Color3.fromRGB(180, 0, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
})
rgbGrad.Parent = mainStroke

local logoRGB = rgbGrad:Clone()
logoRGB.Parent = lcStroke

task.spawn(function()
    local rot = 0
    while gui.Parent and main.Parent do
        rot = (rot + 3) % 360
        rgbGrad.Rotation = rot
        if logoRGB.Parent then logoRGB.Rotation = rot end
        task.wait(0.03)
    end
end)
