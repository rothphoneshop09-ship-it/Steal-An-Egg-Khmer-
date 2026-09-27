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

-- Logic ទាញអូស Logo Akira លើ Mobile Touch & Mouse
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

            -- គណនាព្រំដែនអេក្រង់ទូរស័ព្ទ កុំឱ្យអូសធ្លាក់បាត់ចេញក្រៅ
            local camera = workspace.CurrentCamera
            local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
            local btnSize = openButton.AbsoluteSize.X * 0.5

            local rawX = logoStartPos.X.Offset + delta.X
            local rawY = logoStartPos.Y.Offset + delta.Y

            -- កំណត់ព្រំដែន Clamp
            local clampedX = math.clamp(rawX, btnSize + 10, viewport.X - btnSize - 10)
            local clampedY = math.clamp(rawY, btnSize + 10, viewport.Y - btnSize - 10)

            openButton.Position = UDim2.new(0, clampedX, 0, clampedY)
        end
    end
end)

openButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        logoDragging = false
        -- បើគ្រាន់តែចុច (មិនបានអូស) ទើបធ្វើការបើក Menu
        if not hasMoved then
            AkiraPlayClick()
            toggleGUI(true)
        end
        hasMoved = false
    end
end)
