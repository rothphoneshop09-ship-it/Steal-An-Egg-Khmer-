--[[
    AKIRA SCRIPT CAMBODIA • ULTRA LUXURY EDITION
    Enhanced with:
    - 3D Dynamic Spring Bounces on Actions
    - Shimmer Sweeping Gradients on Emerald & Gold plates
    - Ambient Breathing Glow around Frame & Floating Logo
    - Staggered Smooth UI Entrances
    - Clean Khmer Localization
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
AkiraClickSound.Volume = 0.32
AkiraClickSound.Parent = AkiraSoundFolder

local function AkiraPlayClick(speed, volume)
    pcall(function()
        AkiraClickSound:Stop()
        AkiraClickSound.TimePosition = 0
        AkiraClickSound.PlaybackSpeed = speed or 1
        AkiraClickSound.Volume = volume or 0.32
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

-- Luxury Palette
local Pal = {
    Header = Color3.fromRGB(24, 185, 155),
    HeaderGlow = Color3.fromRGB(36, 235, 195),
    Body = Color3.fromRGB(13, 19, 34),
    BodyGrad = Color3.fromRGB(18, 27, 48),
    GoldTop = Color3.fromRGB(255, 188, 15),
    GoldBottom = Color3.fromRGB(230, 130, 0),
    GoldDepth = Color3.fromRGB(185, 85, 0),
    EmeraldBtn = Color3.fromRGB(18, 168, 140),
    EmeraldDepth = Color3.fromRGB(10, 110, 92),
    TextTitle = Color3.fromRGB(7, 48, 40),
    BrandCyan = Color3.fromRGB(45, 230, 195)
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
    UDim2.fromOffset(375, 350),
    UDim2.fromOffset(420, 390),
}
local SizeIndex = 2

-- Ambient Drop Shadow / Glow
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.fromScale(0.5, 0.515)
shadow.Size = Sizes[SizeIndex]
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.42
shadow.BorderSizePixel = 0
shadow.Parent = gui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 26)
shadowCorner.Parent = shadow

-- Outer Main Shell
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
mainStroke.Thickness = 2.4
mainStroke.Color = Pal.HeaderGlow
mainStroke.Transparency = 0.25
mainStroke.Parent = main

-- Breathing Aura Animation for Header Stroke
task.spawn(function()
    while gui.Parent and main.Parent do
        local t1 = tween(mainStroke, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Pal.HeaderGlow,
            Transparency = 0.15
        })
        t1.Completed:Wait()
        local t2 = tween(mainStroke, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Color3.fromRGB(15, 120, 100),
            Transparency = 0.5
        })
        t2.Completed:Wait()
    end
end)

-- Top Header Frame
local top = Instance.new("Frame")
top.Name = "TopBar"
top.Size = UDim2.new(1, 0, 0, 50)
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
title.TextColor3 = Pal.TextTitle
title.Parent = top

local titleShimmer = Instance.new("UIGradient")
titleShimmer.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Pal.TextTitle),
    ColorSequenceKeypoint.new(0.4, Pal.TextTitle),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.6, Pal.TextTitle),
    ColorSequenceKeypoint.new(1.0, Pal.TextTitle)
})
titleShimmer.Offset = Vector2.new(-1.2, 0)
titleShimmer.Parent = title

task.spawn(function()
    while gui.Parent and title.Parent do
        local tw = tween(titleShimmer, TweenInfo.new(2.4, Enum.EasingStyle.Linear), {Offset = Vector2.new(1.2, 0)})
        tw.Completed:Wait()
        titleShimmer.Offset = Vector2.new(-1.2, 0)
        task.wait(1.5)
    end
end)

local function makeTopBtn(text, xPos)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(26, 22)
    b.Position = UDim2.new(1, xPos, 0.5, 0)
    b.AnchorPoint = Vector2.new(1, 0.5)
    b.BackgroundColor3 = Color3.fromRGB(14, 115, 96)
    b.BorderSizePixel = 0
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.TextColor3 = Color3.fromRGB(8, 48, 40)
    b.AutoButtonColor = false
    b.Parent = top
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b
    
    b.MouseEnter:Connect(function()
        tween(b, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(20, 140, 118), TextColor3 = Color3.new(1, 1, 1)})
    end)
    b.MouseLeave:Connect(function()
        tween(b, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(14, 115, 96), TextColor3 = Color3.fromRGB(8, 48, 40)})
    end)
    return b
end

local minimize = makeTopBtn("—", -40)
local close = makeTopBtn("×", -10)

-- Midnight Navy Inner Body Frame
local body = Instance.new("Frame")
body.Name = "Body"
body.Position = UDim2.fromOffset(0, 48)
body.Size = UDim2.new(1, 0, 1, -48)
body.BackgroundColor3 = Pal.Body
body.BorderSizePixel = 0
body.Parent = main

local bodyCorner = Instance.new("UICorner")
bodyCorner.CornerRadius = UDim.new(0, 24)
bodyCorner.Parent = body

local bodyGradient = Instance.new("UIGradient")
bodyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Pal.Body),
    ColorSequenceKeypoint.new(1.0, Pal.BodyGrad)
})
bodyGradient.Rotation = 90
bodyGradient.Parent = body

-- Content Area
local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.fromOffset(16, 18)
content.Size = UDim2.new(1, -32, 1, -80)
content.BackgroundTransparency = 1
content.Parent = body

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 15)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

-- ============================================================
-- 3D BOUNCY GOLD PLATE: ANTI-HIT (ការពារការវាយ)
-- ============================================================
local AntiHitEnabled = false
local IsAntiHitRunning = false
local ANTI_HIT_SPEED = 0.016

local goldBtnContainer = Instance.new("Frame")
goldBtnContainer.Name = "AntiHitBtnContainer"
goldBtnContainer.Size = UDim2.new(0.88, 0, 0, 72)
goldBtnContainer.BackgroundTransparency = 1
goldBtnContainer.Parent = content

-- Depth 3D Shadow Base
local goldShadowPlate = Instance.new("Frame")
goldShadowPlate.Name = "DepthShadow"
goldShadowPlate.Size = UDim2.new(0.92, 0, 0, 42)
goldShadowPlate.Position = UDim2.fromScale(0.5, 1)
goldShadowPlate.AnchorPoint = Vector2.new(0.5, 1)
goldShadowPlate.BackgroundColor3 = Pal.GoldDepth
goldShadowPlate.BorderSizePixel = 0
goldShadowPlate.Parent = goldBtnContainer

local gsc = Instance.new("UICorner")
gsc.CornerRadius = UDim.new(0, 14)
gsc.Parent = goldShadowPlate

-- Interactive Front Plate
local goldMainPlate = Instance.new("TextButton")
goldMainPlate.Name = "InteractivePlate"
goldMainPlate.Size = UDim2.new(1, 0, 0, 56)
goldMainPlate.Position = UDim2.fromScale(0.5, 0)
goldMainPlate.AnchorPoint = Vector2.new(0.5, 0)
goldMainPlate.BackgroundColor3 = Pal.GoldTop
goldMainPlate.BorderSizePixel = 0
goldMainPlate.Text = ""
goldMainPlate.AutoButtonColor = false
goldMainPlate.ZIndex = 5
goldMainPlate.Parent = goldBtnContainer

local gmc = Instance.new("UICorner")
gmc.CornerRadius = UDim.new(0, 16)
gmc.Parent = goldMainPlate

local goldGrad = Instance.new("UIGradient")
goldGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Pal.GoldTop),
    ColorSequenceKeypoint.new(1.0, Pal.GoldBottom)
})
goldGrad.Rotation = 90
goldGrad.Parent = goldMainPlate

local goldTitle = Instance.new("TextLabel")
goldTitle.BackgroundTransparency = 1
goldTitle.Size = UDim2.new(1, -20, 0, 22)
goldTitle.Position = UDim2.fromOffset(10, 9)
goldTitle.Font = Enum.Font.FredokaOne
goldTitle.Text = "🛡  ANTI-HIT (ការពារការវាយ)"
goldTitle.TextSize = 13.5
goldTitle.TextColor3 = Color3.fromRGB(72, 38, 0)
goldTitle.ZIndex = 6
goldTitle.Parent = goldMainPlate

local goldStatus = Instance.new("TextLabel")
goldStatus.BackgroundTransparency = 1
goldStatus.Size = UDim2.new(1, -20, 0, 16)
goldStatus.Position = UDim2.fromOffset(10, 31)
goldStatus.Font = Enum.Font.FredokaOne
goldStatus.Text = "ស្ថានភាព៖ បិទ [ចុចដើម្បីបើក]"
goldStatus.TextSize = 10.5
goldStatus.TextColor3 = Color3.fromRGB(115, 62, 0)
goldStatus.ZIndex = 6
goldStatus.Parent = goldMainPlate

local function setAntiHitVisual(enabled)
    if enabled then
        goldStatus.Text = "ស្ថានភាព៖ កំពុងដំណើរការ ✓"
        goldStatus.TextColor3 = Color3.fromRGB(25, 95, 0)
        goldTitle.TextColor3 = Color3.fromRGB(20, 75, 0)
        goldGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 215, 70)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 175, 20))
        })
        goldShadowPlate.BackgroundColor3 = Color3.fromRGB(210, 115, 0)
    else
        goldStatus.Text = "ស្ថានភាព៖ បិទ [ចុចដើម្បីបើក]"
        goldStatus.TextColor3 = Color3.fromRGB(115, 62, 0)
        goldTitle.TextColor3 = Color3.fromRGB(72, 38, 0)
        goldGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Pal.GoldTop),
            ColorSequenceKeypoint.new(1.0, Pal.GoldBottom)
        })
        goldShadowPlate.BackgroundColor3 = Pal.GoldDepth
    end
end

-- 3D Physical Bounce Effect
goldMainPlate.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        tween(goldMainPlate, TweenInfo.new(0.08, Enum.EasingStyle.Quart), {Position = UDim2.fromScale(0.5, 0.08)})
    end
end)

local function finishGoldClick()
    tween(goldMainPlate, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5, 0)})
    AkiraPlayClick(1.0, 0.32)
    AntiHitEnabled = not AntiHitEnabled
    setAntiHitVisual(AntiHitEnabled)
end

goldMainPlate.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        finishGoldClick()
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
-- EMERALD PILL: CONFIG (ទំហំផ្ទាំង MENU)
-- ============================================================
local emeraldBtnContainer = Instance.new("Frame")
emeraldBtnContainer.Name = "ConfigBtnContainer"
emeraldBtnContainer.Size = UDim2.new(0.74, 0, 0, 44)
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

local emeraldStroke = Instance.new("UIStroke")
emeraldStroke.Thickness = 1.2
emeraldStroke.Color = Pal.HeaderGlow
emeraldStroke.Transparency = 0.5
emeraldStroke.Parent = emeraldMainPlate

local emeraldLabel = Instance.new("TextLabel")
emeraldLabel.BackgroundTransparency = 1
emeraldLabel.Size = UDim2.fromScale(1, 1)
emeraldLabel.Font = Enum.Font.FredokaOne
emeraldLabel.Text = "⚙  ទំហំផ្ទាំង MENU ៖ មធ្យម"
emeraldLabel.TextSize = 11.5
emeraldLabel.TextColor3 = Color3.fromRGB(240, 255, 250)
emeraldLabel.Parent = emeraldMainPlate

local sizeNames = {"តូច", "មធ្យម", "ធំ"}
emeraldMainPlate.Activated:Connect(function()
    AkiraPlayClick(1.08, 0.3)
    tween(emeraldBtnContainer, TweenInfo.new(0.1, Enum.EasingStyle.Quart), {Size = UDim2.new(0.70, 0, 0, 41)}).Completed:Wait()
    tween(emeraldBtnContainer, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.74, 0, 0, 44)})
    
    SizeIndex = (SizeIndex % #Sizes) + 1
    emeraldLabel.Text = "⚙  ទំហំផ្ទាំង MENU ៖ " .. sizeNames[SizeIndex]
    local target = Sizes[SizeIndex]
    tween(main, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
    tween(shadow, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = target})
end)

-- ============================================================
-- FOOTER BRANDING (ចលនាភ្លឺរលោង)
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
footerBrand.TextColor3 = Pal.BrandCyan
footerBrand.Parent = footer

local footerBrandShimmer = Instance.new("UIGradient")
footerBrandShimmer.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Pal.BrandCyan),
    ColorSequenceKeypoint.new(0.4, Pal.BrandCyan),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.6, Pal.BrandCyan),
    ColorSequenceKeypoint.new(1.0, Pal.BrandCyan)
})
footerBrandShimmer.Offset = Vector2.new(-1.2, 0)
footerBrandShimmer.Parent = footerBrand

task.spawn(function()
    while gui.Parent and footerBrand.Parent do
        local tw = tween(footerBrandShimmer, TweenInfo.new(2.8, Enum.EasingStyle.Linear), {Offset = Vector2.new(1.2, 0)})
        tw.Completed:Wait()
        footerBrandShimmer.Offset = Vector2.new(-1.2, 0)
        task.wait(2)
    end
end)

local footerSub = Instance.new("TextLabel")
footerSub.BackgroundTransparency = 1
footerSub.Size = UDim2.new(1, 0, 0, 16)
footerSub.Position = UDim2.fromOffset(0, 26)
footerSub.Font = Enum.Font.FredokaOne
footerSub.Text = "PRODUCT : BENZ • AKIRA SCRIPT"
footerSub.TextSize = 9
footerSub.TextXAlignment = Enum.TextXAlignment.Center
footerSub.TextColor3 = Color3.fromRGB(160, 185, 210)
footerSub.Parent = footer

-- Touch Drag Bar
local dragHandle = Instance.new("TextButton")
dragHandle.Name = "AkiraDragHandle"
dragHandle.AnchorPoint = Vector2.new(0.5, 0.5)
dragHandle.Size = UDim2.fromOffset(115, 18)
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
        tween(dragVisual, TweenInfo.new(0.12, Enum.EasingStyle.Quart), {Size = UDim2.fromOffset(96, 5)})
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
        tween(dragVisual, TweenInfo.new(0.16, Enum.EasingStyle.Quart), {Size = UDim2.fromOffset(72, 3)})
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
openStroke.Thickness = 2.6
openStroke.Color = Pal.Header
openStroke.Transparency = 0.15
openStroke.Parent = openButton

task.spawn(function()
    while gui.Parent and openButton.Parent do
        local t1 = tween(openStroke, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Pal.HeaderGlow,
            Transparency = 0.05
        })
        t1.Completed:Wait()
        local t2 = tween(openStroke, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Color = Pal.Header,
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
    main.BackgroundTransparency = 0
    shadow.BackgroundTransparency = 0.42
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
        body.Visible = true
        dragHandle.Visible = true
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
        body.Visible = false
        dragHandle.Visible = false
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

-- Initial Startup Show
main.Visible = true
shadow.Visible = true
dragHandle.Visible = true
updateFloatingControls()
