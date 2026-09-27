--[[
    AKIRA SCRIPT CAMBODIA • LUXURY EDITION
    Layout based directly on user reference template:
    - Emerald Green Top Header (AKIRA SCRIPT CAMBODIA)
    - Deep Midnight Slate Body (#0F1626)
    - Amber/Gold 3D Layered Toggle Pill
    - Emerald Config Pill
    - Sleek Footer (PRODUCT : BENZ • AKIRA SCRIPT)
    - Floating Cambodia Logo Image Button
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

-- Premium Palette matched to image
local Pal = {
    Header = Color3.fromRGB(22, 160, 133),      -- Emerald Teal Header
    HeaderDark = Color3.fromRGB(16, 122, 102),  -- Header Darker Tone
    Body = Color3.fromRGB(15, 22, 38),          -- Deep Midnight Navy Body
    GoldMain = Color3.fromRGB(255, 176, 0),     -- Warm Amber/Gold
    GoldShadow = Color3.fromRGB(216, 106, 0),   -- 3D Depth Shadow
    EmeraldBtn = Color3.fromRGB(18, 150, 126),  -- Secondary Teal Button
    EmeraldShadow = Color3.fromRGB(12, 105, 88),-- Secondary Shadow
    TextWhite = Color3.fromRGB(255, 255, 255),
    BrandTeal = Color3.fromRGB(38, 204, 172)
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
    UDim2.fromOffset(330, 310),
    UDim2.fromOffset(370, 345),
    UDim2.fromOffset(415, 385),
}
local SizeIndex = 2

-- Ambient Drop Shadow
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
shadowCorner.CornerRadius = UDim.new(0, 26)
shadowCorner.Parent = shadow

-- Outer Shell Frame
local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.fromScale(0.5, 0.48)
main.Size = Sizes[SizeIndex]
main.BackgroundColor3 = Pal.Header
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 26)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2
mainStroke.Color = Color3.fromRGB(12, 95, 80)
mainStroke.Parent = main

-- Top Bar
local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 48)
top.BackgroundTransparency = 1
top.Parent = main

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(20, 0)
title.Size = UDim2.new(1, -95, 1, 0)
title.Font = Enum.Font.FredokaOne
title.Text = "AKIRA SCRIPT CAMBODIA"
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(10, 50, 42)
title.Parent = top

local function makeTopBtn(text, xPos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(26, 22)
    b.Position = UDim2.new(1, xPos, 0.5, 0)
    b.AnchorPoint = Vector2.new(1, 0.5)
    b.BackgroundColor3 = Color3.fromRGB(12, 105, 88)
    b.BorderSizePixel = 0
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.TextColor3 = Color3.fromRGB(8, 45, 38)
    b.AutoButtonColor = false
    b.Parent = top
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b
    return b
end

local minimize = makeTopBtn("—", -40)
local close = makeTopBtn("×", -10)

-- Midnight Navy Inner Body Frame
local body = Instance.new("Frame")
body.Name = "Body"
body.Position = UDim2.fromOffset(0, 46)
body.Size = UDim2.new(1, 0, 1, -46)
body.BackgroundColor3 = Pal.Body
body.BorderSizePixel = 0
body.Parent = main

local bodyCorner = Instance.new("UICorner")
bodyCorner.CornerRadius = UDim.new(0, 24)
bodyCorner.Parent = body

-- Content Scroll Area
local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.Position = UDim2.fromOffset(16, 14)
content.Size = UDim2.new(1, -32, 1, -78)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 2
content.ScrollBarImageColor3 = Pal.BrandTeal
content.CanvasSize = UDim2.new()
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.ScrollingDirection = Enum.ScrollingDirection.Y
content.Parent = body

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 14)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

-- ============================================================
-- 3D LAYERED GOLD AMBER BUTTON: ANTI-HIT
-- ============================================================
local AntiHitEnabled = false
local IsAntiHitRunning = false
local ANTI_HIT_SPEED = 0.016

local goldBtnContainer = Instance.new("Frame")
goldBtnContainer.Name = "AntiHitBtnContainer"
goldBtnContainer.Size = UDim2.new(0.86, 0, 0, 68)
goldBtnContainer.BackgroundTransparency = 1
goldBtnContainer.Parent = content

-- Bottom 3D Depth Plate
local goldShadowPlate = Instance.new("Frame")
goldShadowPlate.Size = UDim2.new(0.90, 0, 0, 36)
goldShadowPlate.Position = UDim2.fromScale(0.5, 1)
goldShadowPlate.AnchorPoint = Vector2.new(0.5, 1)
goldShadowPlate.BackgroundColor3 = Pal.GoldShadow
goldShadowPlate.BorderSizePixel = 0
goldShadowPlate.Parent = goldBtnContainer

local gsc = Instance.new("UICorner")
gsc.CornerRadius = UDim.new(0, 12)
gsc.Parent = goldShadowPlate

-- Top Active Gold Plate
local goldMainPlate = Instance.new("TextButton")
goldMainPlate.Size = UDim2.new(1, 0, 0, 52)
goldMainPlate.Position = UDim2.fromScale(0.5, 0)
goldMainPlate.AnchorPoint = Vector2.new(0.5, 0)
goldMainPlate.BackgroundColor3 = Pal.GoldMain
goldMainPlate.BorderSizePixel = 0
goldMainPlate.Text = ""
goldMainPlate.AutoButtonColor = false
goldMainPlate.ZIndex = 5
goldMainPlate.Parent = goldBtnContainer

local gmc = Instance.new("UICorner")
gmc.CornerRadius = UDim.new(0, 16)
gmc.Parent = goldMainPlate

local goldTitle = Instance.new("TextLabel")
goldTitle.BackgroundTransparency = 1
goldTitle.Size = UDim2.new(1, -20, 0, 22)
goldTitle.Position = UDim2.fromOffset(10, 8)
goldTitle.Font = Enum.Font.FredokaOne
goldTitle.Text = "🛡  ANTI-HIT (ការពារការវាយ)"
goldTitle.TextSize = 13
goldTitle.TextColor3 = Color3.fromRGB(75, 40, 0)
goldTitle.ZIndex = 6
goldTitle.Parent = goldMainPlate

local goldStatus = Instance.new("TextLabel")
goldStatus.BackgroundTransparency = 1
goldStatus.Size = UDim2.new(1, -20, 0, 16)
goldStatus.Position = UDim2.fromOffset(10, 28)
goldStatus.Font = Enum.Font.FredokaOne
goldStatus.Text = "ស្ថានភាព៖ បិទ [ចុចដើម្បីបើក]"
goldStatus.TextSize = 10
goldStatus.TextColor3 = Color3.fromRGB(120, 68, 0)
goldStatus.ZIndex = 6
goldStatus.Parent = goldMainPlate

local function setAntiHitVisual(enabled)
    if enabled then
        goldMainPlate.BackgroundColor3 = Color3.fromRGB(255, 198, 45)
        goldShadowPlate.BackgroundColor3 = Color3.fromRGB(235, 130, 0)
        goldStatus.Text = "ស្ថានភាព៖ កំពុងបើកដំណើរការ ✓"
        goldStatus.TextColor3 = Color3.fromRGB(40, 105, 0)
        goldTitle.TextColor3 = Color3.fromRGB(35, 80, 0)
        tween(goldMainPlate, TweenInfo.new(0.12, Enum.EasingStyle.Quart), {Position = UDim2.fromScale(0.5, 0.05)})
    else
        goldMainPlate.BackgroundColor3 = Pal.GoldMain
        goldShadowPlate.BackgroundColor3 = Pal.GoldShadow
        goldStatus.Text = "ស្ថានភាព៖ បិទ [ចុចដើម្បីបើក]"
        goldStatus.TextColor3 = Color3.fromRGB(120, 68, 0)
        goldTitle.TextColor3 = Color3.fromRGB(75, 40, 0)
        tween(goldMainPlate, TweenInfo.new(0.12, Enum.EasingStyle.Quart), {Position = UDim2.fromScale(0.5, 0)})
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

goldMainPlate.Activated:Connect(function()
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
-- EMERALD PILL: CONFIGURATION (SIZE CHANGER)
-- ============================================================
local emeraldBtnContainer = Instance.new("Frame")
emeraldBtnContainer.Name = "ConfigBtnContainer"
emeraldBtnContainer.Size = UDim2.new(0.72, 0, 0, 42)
emeraldBtnContainer.BackgroundTransparency = 1
emeraldBtnContainer.Parent = content

local emeraldMainPlate = Instance.new("TextButton")
emeraldMainPlate.Size = UDim2.new(1, 0, 1, 0)
emeraldMainPlate.BackgroundColor3 = Pal.EmeraldBtn
emeraldMainPlate.BorderSizePixel = 0
emeraldMainPlate.Text = ""
emeraldMainPlate.AutoButtonColor = false
emeraldMainPlate.Parent = emeraldBtnContainer

local emc = Instance.new("UICorner")
emc.CornerRadius = UDim.new(0, 14)
emc.Parent = emeraldMainPlate

local emeraldLabel = Instance.new("TextLabel")
emeraldLabel.BackgroundTransparency = 1
emeraldLabel.Size = UDim2.fromScale(1, 1)
emeraldLabel.Font = Enum.Font.FredokaOne
emeraldLabel.Text = "⚙  ទំហំផ្ទាំង MENU ៖ មធ្យម"
emeraldLabel.TextSize = 11
emeraldLabel.TextColor3 = Color3.fromRGB(240, 255, 250)
emeraldLabel.Parent = emeraldMainPlate

local sizeNames = {"តូច", "មធ្យម", "ធំ"}
emeraldMainPlate.Activated:Connect(function()
    AkiraPlayClick()
    SizeIndex = (SizeIndex % #Sizes) + 1
    emeraldLabel.Text = "⚙  ទំហំផ្ទាំង MENU ៖ " .. sizeNames[SizeIndex]
    local target = Sizes[SizeIndex]
    tween(main, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
    tween(shadow, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
end)

-- ============================================================
-- FOOTER BRANDING (MATCHED TO REFERENCE)
-- ============================================================
local footer = Instance.new("Frame")
footer.Name = "Footer"
footer.Size = UDim2.new(1, 0, 0, 52)
footer.Position = UDim2.new(0, 0, 1, -52)
footer.BackgroundTransparency = 1
footer.Parent = body

local footerBrand = Instance.new("TextLabel")
footerBrand.BackgroundTransparency = 1
footerBrand.Size = UDim2.new(1, 0, 0, 20)
footerBrand.Position = UDim2.fromOffset(0, 6)
footerBrand.Font = Enum.Font.GothamBold
footerBrand.Text = "AKIRA SCRIPT"
footerBrand.TextSize = 15
footerBrand.TextXAlignment = Enum.TextXAlignment.Center
footerBrand.TextColor3 = Pal.BrandTeal
footerBrand.Parent = footer

local footerSub = Instance.new("TextLabel")
footerSub.BackgroundTransparency = 1
footerSub.Size = UDim2.new(1, 0, 0, 16)
footerSub.Position = UDim2.fromOffset(0, 26)
footerSub.Font = Enum.Font.FredokaOne
footerSub.Text = "PRODUCT : BENZ • AKIRA SCRIPT"
footerSub.TextSize = 9
footerSub.TextXAlignment = Enum.TextXAlignment.Center
footerSub.TextColor3 = Color3.fromRGB(165, 185, 205)
footerSub.Parent = footer

-- Drag & Resize Logic
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
dragVisual.Size = UDim2.fromOffset(72, 3)
dragVisual.BackgroundColor3 = Pal.Header
dragVisual.BorderSizePixel = 0
dragVisual.ZIndex = 61
dragVisual.Parent = dragHandle

local dragCorner = Instance.new("UICorner")
dragCorner.CornerRadius = UDim.new(1, 0)
dragCorner.Parent = dragVisual

local function updateFloatingControls()
    local x = main.Position.X.Scale
    local ox = main.Position.X.Offset
    local y = main.Position.Y.Scale
    local oy = main.Position.Y.Offset
    local halfH = main.AbsoluteSize.Y * 0.5
    dragHandle.Position = UDim2.new(x, ox, y, oy + halfH + 12)
end

local dragging = false
local dragStart
local startPos

dragHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        main.Position = newPos
        shadow.Position = newPos
        updateFloatingControls()
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- ============================================================
-- CAMBODIA AKIRA FLOATING LOGO BUTTON
-- ============================================================
local LOGO_IMAGE_ID = "rbxassetid://97330468088484"

local openButton = Instance.new("ImageButton")
openButton.Name = "OpenAkiraLogo"
openButton.AnchorPoint = Vector2.new(1, 0.5)
openButton.Position = UDim2.new(1, -18, 0.5, 0)
openButton.Size = UDim2.fromOffset(60, 60)
openButton.BackgroundColor3 = Pal.Body
openButton.BackgroundTransparency = 0.1
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
openStroke.Color = Pal.Header
openStroke.Transparency = 0.15
openStroke.Parent = openButton

task.spawn(function()
    while gui.Parent and openButton.Parent do
        local t1 = tween(openStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Pal.Header,
            Transparency = 0.1
        })
        t1.Completed:Wait()
        local t2 = tween(openStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Color3.fromRGB(255, 255, 255),
            Transparency = 0.35
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
        body.Visible = true
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
    if gui.Parent and (main.Visible or dragHandle.Visible) then
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
        body.Visible = true
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
        body.Visible = false
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

-- Initial Startup Show
main.Visible = true
shadow.Visible = true
dragHandle.Visible = true
updateFloatingControls()
