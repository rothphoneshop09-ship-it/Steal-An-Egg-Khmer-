-- // ========================================== //
-- //   AKIRA SCRIPT - EGG PRICE & VALUE v4.7    //
-- //   FULL ANTI-BYPASS & SECURITY ENGINE       //
-- // ========================================== //

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ========================================================
-- CORE ANTI-BYPASS ENGINE (METATABLE HOOKING)
-- ========================================================
local antiBypassActive = true
local realWalkSpeed = 16
local realJumpPower = 50

local function InitAntiBypass()
    if hookmetamethod and getnamecallmethod and checkcaller then
        -- 1. Anti-Kick & Remote Detection Bypass
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            if not checkcaller() and antiBypassActive then
                -- ទប់ស្កាត់ Client-Sided Kick
                if method == "Kick" or method == "kick" then
                    return nil
                end

                -- ទប់ស្កាត់ការ Report / Flag តាម RemoteEvent របស់ហ្គេម
                if method == "FireServer" and self:IsA("RemoteEvent") then
                    local name = string.lower(self.Name)
                    if string.find(name, "cheat") or string.find(name, "ban") or string.find(name, "detect") or string.find(name, "flag") or string.find(name, "report") then
                        return nil
                    end
                end
            end

            return oldNamecall(self, ...)
        end)

        -- 2. Anti WalkSpeed & JumpPower Detection Bypass (Property Spoofing)
        local oldIndex
        oldIndex = hookmetamethod(game, "__index", function(self, key)
            if not checkcaller() and antiBypassActive then
                if tostring(key) == "WalkSpeed" and self:IsA("Humanoid") then
                    return 16 -- បង្ហាញទៅ Anti-Cheat ថាដើរល្បឿនធម្មតា
                elseif tostring(key) == "JumpPower" and self:IsA("Humanoid") then
                    return 50 -- បង្ហាញថា Jump កម្ពស់ធម្មតា
                end
            end
            return oldIndex(self, key)
        end)
    end
end

pcall(InitAntiBypass)

-- ========================================================
-- UI CREATION
-- ========================================================
local existingUI = PlayerGui:FindFirstChild("AkiraPremiumUI")
if existingUI then existingUI:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AkiraPremiumUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(530, 360)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(255, 35, 60)
MainStroke.Thickness = 1.8

-- TopBar
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 44)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 14)

local TopFix = Instance.new("Frame", TopBar)
TopFix.Size = UDim2.new(1, 0, 0, 12)
TopFix.Position = UDim2.new(0, 0, 1, -12)
TopFix.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
TopFix.BorderSizePixel = 0

local Title = Instance.new("TextLabel", TopBar)
Title.Position = UDim2.fromOffset(16, 0)
Title.Size = UDim2.new(0.65, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.RichText = true
Title.Text = '<font color="rgb(255,35,60)">AKIRA</font> <font color="rgb(255,255,255)">SCRIPT</font> <font color="rgb(140,140,160)">[BYPASS v4.7]</font>'
Title.Font = Enum.Font.ArialBold
Title.TextSize = 14
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.fromOffset(28, 28)
CloseBtn.Position = UDim2.new(1, -38, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
CloseBtn.Font = Enum.Font.ArialBold
CloseBtn.TextSize = 13
CloseBtn.AutoButtonColor = false
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 130, 1, -44)
Sidebar.Position = UDim2.fromOffset(0, 44)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Sidebar.BorderSizePixel = 0

local SideLayout = Instance.new("UIListLayout", Sidebar)
SideLayout.Padding = UDim.new(0, 6)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local SidePadding = Instance.new("UIPadding", Sidebar)
SidePadding.PaddingTop = UDim.new(0, 8)

-- Content Area
local ContentHolder = Instance.new("Frame", Main)
ContentHolder.Size = UDim2.new(1, -142, 1, -54)
ContentHolder.Position = UDim2.fromOffset(136, 48)
ContentHolder.BackgroundTransparency = 1

local Pages = {}
local TabButtons = {}

local function CreateTab(name)
    local Page = Instance.new("ScrollingFrame", ContentHolder)
    Page.Name = name .. "Page"
    Page.Size = UDim2.fromScale(1, 1)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(255, 35, 60)
    Page.Visible = false

    local Layout = Instance.new("UIListLayout", Page)
    Layout.Padding = UDim.new(0, 8)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    local Pad = Instance.new("UIPadding", Page)
    Pad.PaddingRight = UDim.new(0, 6)
    Pad.PaddingTop = UDim.new(0, 4)

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 16)
    end)

    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.new(1, -16, 0, 32)
    TabBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
    TabBtn.Font = Enum.Font.ArialBold
    TabBtn.TextSize = 11
    TabBtn.AutoButtonColor = false
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)

    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(TabButtons) do 
            TweenService:Create(b, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(24, 24, 32),
                TextColor3 = Color3.fromRGB(180, 180, 190)
            }):Play()
        end
        Page.Visible = true
        TweenService:Create(TabBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 35, 60),
            TextColor3 = Color3.new(1, 1, 1)
        }):Play()
    end)

    Pages[name] = Page
    TabButtons[name] = TabBtn
    return Page
end

local FarmPage = CreateTab("Auto Farm")
local SelectEggPage = CreateTab("Select Eggs")
local SecurityPage = CreateTab("Bypass & Sec 🛡️")
local UtilityPage = CreateTab("Utility")
local MovementPage = CreateTab("Movement")
local MiscPage = CreateTab("Misc")

Pages["Auto Farm"].Visible = true
TabButtons["Auto Farm"].BackgroundColor3 = Color3.fromRGB(255, 35, 60)
TabButtons["Auto Farm"].TextColor3 = Color3.new(1, 1, 1)

-- Helpers
local function AddToggle(parent, title, default, callback)
    local state = default or false
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, 0, 0, 42)
    Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
    Frame.BorderSizePixel = 0
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

    local Lbl = Instance.new("TextLabel", Frame)
    Lbl.Position = UDim2.fromOffset(12, 0)
    Lbl.Size = UDim2.new(0.68, 0, 1, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = title
    Lbl.TextColor3 = Color3.fromRGB(230, 230, 240)
    Lbl.Font = Enum.Font.Arial
    Lbl.TextSize = 13
    Lbl.TextXAlignment = Enum.TextXAlignment.Left

    local Btn = Instance.new("TextButton", Frame)
    Btn.Position = UDim2.new(1, -62, 0.5, -12)
    Btn.Size = UDim2.fromOffset(50, 24)
    Btn.BackgroundColor3 = state and Color3.fromRGB(255, 35, 60) or Color3.fromRGB(44, 44, 58)
    Btn.Text = state and "ON" or "OFF"
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.ArialBold
    Btn.TextSize = 11
    Btn.AutoButtonColor = false
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12)

    Btn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(Btn, TweenInfo.new(0.18), {
            BackgroundColor3 = state and Color3.fromRGB(255, 35, 60) or Color3.fromRGB(44, 44, 58)
        }):Play()
        Btn.Text = state and "ON" or "OFF"
        callback(state)
    end)
end

local function AddButton(parent, title, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, 0, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    Btn.Text = title
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.ArialBold
    Btn.TextSize = 12
    Btn.AutoButtonColor = false
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

    local Stroke = Instance.new("UIStroke", Btn)
    Stroke.Color = Color3.fromRGB(255, 35, 60)
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Thickness = 1

    Btn.MouseButton1Click:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 35, 60)}):Play()
        task.delay(0.12, function()
            TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 30, 42)}):Play()
        end)
        callback()
    end)
end

local function AddSlider(parent, title, min, max, default, callback)
    local val = default or min
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, 0, 0, 52)
    Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
    Frame.BorderSizePixel = 0
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

    local Lbl = Instance.new("TextLabel", Frame)
    Lbl.Position = UDim2.fromOffset(12, 4)
    Lbl.Size = UDim2.new(0.6, 0, 0, 20)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = title
    Lbl.TextColor3 = Color3.fromRGB(230, 230, 240)
    Lbl.Font = Enum.Font.Arial
    Lbl.TextSize = 13
    Lbl.TextXAlignment = Enum.TextXAlignment.Left

    local ValLbl = Instance.new("TextLabel", Frame)
    ValLbl.Position = UDim2.new(1, -62, 0, 4)
    ValLbl.Size = UDim2.fromOffset(50, 20)
    ValLbl.BackgroundTransparency = 1
    ValLbl.Text = tostring(val)
    ValLbl.TextColor3 = Color3.fromRGB(255, 35, 60)
    ValLbl.Font = Enum.Font.ArialBold
    ValLbl.TextSize = 13
    ValLbl.TextXAlignment = Enum.TextXAlignment.Right

    local Bar = Instance.new("TextButton", Frame)
    Bar.Position = UDim2.fromOffset(12, 32)
    Bar.Size = UDim2.new(1, -24, 0, 6)
    Bar.BackgroundColor3 = Color3.fromRGB(44, 44, 58)
    Bar.Text = ""
    Bar.AutoButtonColor = false
    Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame", Bar)
    Fill.Size = UDim2.fromScale((val - min)/(max - min), 1)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 35, 60)
    Fill.BorderSizePixel = 0
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function Update(input)
        local pos = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        val = math.floor(min + ((max - min) * pos))
        ValLbl.Text = tostring(val)
        Fill.Size = UDim2.fromScale(pos, 1)
        callback(val)
    end

    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            Update(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            Update(input)
        end
    end)
end

-- ========================================================
-- DATABASE & ENGINE
-- ========================================================
local EggDatabase = {
    ["eternal"] = { Name = "Eternal Egg", Price = "5,000,000+", Color = Color3.fromRGB(150, 0, 255) },
    ["enternal"] = { Name = "Eternal Egg", Price = "5,000,000+", Color = Color3.fromRGB(150, 0, 255) },
    ["divine"] = { Name = "Divine Egg", Price = "1,000,000+", Color = Color3.fromRGB(0, 230, 255) },
    ["divan"] = { Name = "Divine Egg", Price = "1,000,000+", Color = Color3.fromRGB(0, 230, 255) },
    ["mythic"] = { Name = "Mythic Egg", Price = "250,000+", Color = Color3.fromRGB(255, 30, 60) },
    ["legendary"] = { Name = "Legendary Egg", Price = "50,000+", Color = Color3.fromRGB(255, 215, 0) },
    ["golden"] = { Name = "Golden Egg", Price = "25,000+", Color = Color3.fromRGB(255, 180, 0) },
    ["epic"] = { Name = "Epic Egg", Price = "10,000+", Color = Color3.fromRGB(255, 80, 255) },
    ["rare"] = { Name = "Rare Egg", Price = "2,500+", Color = Color3.fromRGB(0, 140, 255) },
    ["common"] = { Name = "Common Egg", Price = "500", Color = Color3.fromRGB(200, 200, 200) }
}

local function GetEggDetails(objName)
    local low = string.lower(objName)
    for key, data in pairs(EggDatabase) do
        if string.find(low, key) then
            return data.Name, data.Price, data.Color
        end
    end
    return "Egg", "Unknown Value", Color3.fromRGB(255, 255, 255)
end

local myBasePos = nil
local farmSpeed = 45

local SelectedEggs = {
    ["Eternal Egg"] = true,
    ["Divine Egg"] = true,
    ["Mythic Egg"] = true,
    ["Legendary Egg"] = true,
    ["Epic Egg"] = true,
    ["Rare Egg"] = true,
    ["Common Egg"] = true,
    ["Golden Egg"] = true
}

local customEggInput = ""

local function MoveToTarget(targetPos)
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local distance = (root.Position - targetPos).Magnitude
    local timeToReach = math.clamp(distance / farmSpeed, 0.05, 15)

    local tweenInfo = TweenInfo.new(timeToReach, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(targetPos + Vector3.new(0, 1.5, 0))})
    
    tween:Play()
    tween.Completed:Wait()
end

task.spawn(function()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart", 10)
    if root then myBasePos = root.Position end
end)

local function IsEggWanted(name)
    name = string.lower(name)
    if customEggInput ~= "" and string.find(name, string.lower(customEggInput)) then
        return true
    end
    for eggName, isSelected in pairs(SelectedEggs) do
        if isSelected then
            local keyword = string.lower(string.split(eggName, " ")[1])
            if string.find(name, keyword) or (keyword == "eternal" and string.find(name, "enternal")) or (keyword == "divine" and string.find(name, "divan")) then
                return true
            end
        end
    end
    return false
end

-- ========================================================
-- SECURITY FUNCTIONS
-- ========================================================
local antiStaffActive = false
local antiFlingActive = false
local nameProtectActive = false
local antiVoidActive = true

local function ServerHop()
    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local success, response = pcall(function() return game:HttpGet(url) end)
    if success and response then
        local data = HttpService:JSONDecode(response)
        if data and data.data then
            for _, server in ipairs(data.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                    return
                end
            end
        end
    end
    LocalPlayer:Kick("Akira Guard: Exited safely!")
end

local function CheckForStaff(player)
    if not antiStaffActive or player == LocalPlayer then return end
    pcall(function()
        if game.CreatorType == Enum.CreatorType.Group and player:GetRankInGroup(game.CreatorId) >= 100 then
            ServerHop()
        elseif player.UserId == game.CreatorId then
            ServerHop()
        end
    end)
end

Players.PlayerAdded:Connect(CheckForStaff)

-- Anti Void Protection
RunService.Heartbeat:Connect(function()
    if antiVoidActive and LocalPlayer.Character then
        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root and root.Position.Y < -50 and myBasePos then
            root.Velocity = Vector3.zero
            root.CFrame = CFrame.new(myBasePos + Vector3.new(0, 5, 0))
        end
    end
end)

-- Anti Fling Loop
RunService.Stepped:Connect(function()
    if antiFlingActive and LocalPlayer.Character then
        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= LocalPlayer and otherPlayer.Character then
                for _, opPart in ipairs(otherPlayer.Character:GetDescendants()) do
                    if opPart:IsA("BasePart") then
                        opPart.CanCollide = false
                    end
                end
            end
        end
    end
end)

-- [TAB: AUTO FARM]
local fastRunFarm = false
AddToggle(FarmPage, "Fast Run Farm (រត់លួចពង)", false, function(s)
    fastRunFarm = s
    if s then
        task.spawn(function()
            while fastRunFarm do
                task.wait(0.15)
                pcall(function()
                    local char = LocalPlayer.Character
                    local root = char and char:FindFirstChild("HumanoidRootPart")
                    if not root then return end

                    local hasEgg = false
                    for _, child in ipairs(char:GetChildren()) do
                        if child:IsA("Tool") or string.find(string.lower(child.Name), "egg") then
                            hasEgg = true
                            break
                        end
                    end

                    if hasEgg then
                        if myBasePos then
                            MoveToTarget(myBasePos)
                            task.wait(0.4)
                        end
                    else
                        local closestPrompt = nil
                        local shortestDist = math.huge

                        for _, obj in ipairs(Workspace:GetDescendants()) do
                            if obj:IsA("ProximityPrompt") then
                                local text = string.lower(obj.ActionText .. " " .. obj.ObjectText .. " " .. obj.Parent.Name)
                                if string.find(text, "egg") and IsEggWanted(text) then
                                    local part = obj.Parent
                                    if part and part:IsA("BasePart") then
                                        local dist = (root.Position - part.Position).Magnitude
                                        if dist < shortestDist then
                                            shortestDist = dist
                                            closestPrompt = obj
                                        end
                                    end
                                end
                            end
                        end

                        if closestPrompt and closestPrompt.Parent and fastRunFarm then
                            MoveToTarget(closestPrompt.Parent.Position)
                            task.wait(0.1)
                            if fireproximityprompt then
                                fireproximityprompt(closestPrompt)
                            end
                            task.wait(0.2)
                        end
                    end
                end)
            end
        end)
    end
end)

AddSlider(FarmPage, "Farm Speed (ល្បឿនរត់កាត់ដី)", 25, 80, 45, function(v)
    farmSpeed = v
end)

local instantPrompt = false
AddToggle(FarmPage, "Instant Steal (ចុចលួចភ្លាមៗ)", false, function(s)
    instantPrompt = s
    if s then
        for _, prompt in ipairs(Workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then prompt.HoldDuration = 0 end
        end
    end
end)

Workspace.DescendantAdded:Connect(function(descendant)
    if instantPrompt and descendant:IsA("ProximityPrompt") then
        descendant.HoldDuration = 0
    end
end)

AddButton(FarmPage, "Set Current Spot as Base (កំណត់កន្លែងទុក)", function()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then myBasePos = root.Position end
end)

-- [TAB: SELECT EGGS]
for eggName, _ in pairs(SelectedEggs) do
    AddToggle(SelectEggPage, eggName, SelectedEggs[eggName], function(state)
        SelectedEggs[eggName] = state
    end)
end

local InputFrame = Instance.new("Frame", SelectEggPage)
InputFrame.Size = UDim2.new(1, 0, 0, 50)
InputFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
InputFrame.BorderSizePixel = 0
Instance.new("UICorner", InputFrame).CornerRadius = UDim.new(0, 8)

local CustomBox = Instance.new("TextBox", InputFrame)
CustomBox.Size = UDim2.new(1, -20, 1, -14)
CustomBox.Position = UDim2.fromOffset(10, 7)
CustomBox.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
CustomBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CustomBox.PlaceholderText = "វាយឈ្មោះពងពិសេសផ្សេងទៀត..."
CustomBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 150)
CustomBox.Font = Enum.Font.Arial
CustomBox.TextSize = 12
Instance.new("UICorner", CustomBox).CornerRadius = UDim.new(0, 6)

CustomBox.FocusLost:Connect(function()
    customEggInput = CustomBox.Text
end)

-- [TAB: BYPASS & SECURITY 🛡️]
AddToggle(SecurityPage, "Anti-Bypass (ទប់ស្កាត់ Kick/Detect)", true, function(s)
    antiBypassActive = s
end)

AddToggle(SecurityPage, "Anti-Void (ការពារកុំឱ្យធ្លាក់ផែនដី)", true, function(s)
    antiVoidActive = s
end)

AddToggle(SecurityPage, "Anti-Staff (ដូរ Server បើមាន Admin)", true, function(s)
    antiStaffActive = s
    if s then
        for _, p in ipairs(Players:GetPlayers()) do CheckForStaff(p) end
    end
end)

AddToggle(SecurityPage, "Anti-Fling (ការពារគេបុកឱ្យហោះ)", true, function(s)
    antiFlingActive = s
end)

AddToggle(SecurityPage, "Name Protect (បិទបាំងឈ្មោះពិត)", false, function(s)
    nameProtectActive = s
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.DisplayName = s and "Protected_User" or LocalPlayer.DisplayName
    end
end)

AddButton(SecurityPage, "Panic Button (បិទស្គ្រីប និង Reset ភ្លាម)", function()
    fastRunFarm = false
    ScreenGui:Destroy()
end)

-- [TAB: UTILITY]
local eggEspActive = false
local function ClearAllEggESP()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name == "AkiraEggBillboard" or obj.Name == "AkiraEggHighlight" then
            obj:Destroy()
        end
    end
end

AddToggle(UtilityPage, "Show Egg Price & ESP (បង្ហាញតម្លៃពង)", false, function(s)
    eggEspActive = s
    if s then
        task.spawn(function()
            while eggEspActive do
                pcall(function()
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if not eggEspActive then break end
                        if obj:IsA("BasePart") and string.find(string.lower(obj.Name), "egg") and not obj:IsDescendantOf(LocalPlayer.Character) then
                            if not obj:FindFirstChild("AkiraEggBillboard") then
                                local realName, price, col = GetEggDetails(obj.Name)

                                local bb = Instance.new("BillboardGui")
                                bb.Name = "AkiraEggBillboard"
                                bb.Adornee = obj
                                bb.Size = UDim2.new(0, 140, 0, 45)
                                bb.StudsOffset = Vector3.new(0, 2.5, 0)
                                bb.AlwaysOnTop = true
                                bb.Parent = obj

                                local titleLbl = Instance.new("TextLabel", bb)
                                titleLbl.Size = UDim2.new(1, 0, 0.5, 0)
                                titleLbl.BackgroundTransparency = 1
                                titleLbl.Text = realName
                                titleLbl.TextColor3 = col
                                titleLbl.Font = Enum.Font.ArialBold
                                titleLbl.TextSize = 13
                                titleLbl.TextStrokeTransparency = 0.2

                                local priceLbl = Instance.new("TextLabel", bb)
                                priceLbl.Position = UDim2.new(0, 0, 0.5, 0)
                                priceLbl.Size = UDim2.new(1, 0, 0.5, 0)
                                priceLbl.BackgroundTransparency = 1
                                priceLbl.Text = "តម្លៃ: " .. price .. " 🪙"
                                priceLbl.TextColor3 = Color3.fromRGB(255, 215, 0)
                                priceLbl.Font = Enum.Font.ArialBold
                                priceLbl.TextSize = 12
                                priceLbl.TextStrokeTransparency = 0.2

                                local hl = Instance.new("Highlight")
                                hl.Name = "AkiraEggHighlight"
                                hl.FillColor = col
                                hl.OutlineColor = Color3.new(1, 1, 1)
                                hl.FillTransparency = 0.4
                                hl.Parent = obj
                            end
                        end
                    end
                end)
                task.wait(2)
            end
        end)
    else
        ClearAllEggESP()
    end
end)

local autoRejoinEnabled = true
AddToggle(UtilityPage, "Auto Rejoin (ចូលវិញពេលដាច់)", true, function(s)
    autoRejoinEnabled = s
end)

GuiService.ErrorMessageChanged:Connect(function()
    if autoRejoinEnabled then
        task.wait(0.5)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
end)

AddButton(UtilityPage, "Server Hop (រក Server មនុស្សតិច)", function()
    ServerHop()
end)

-- [TAB: MOVEMENT]
local noclip = false
local noclipConnection = nil

AddToggle(MovementPage, "Noclip (ដើរកាត់ជញ្ជាំង)", false, function(s)
    noclip = s
    if noclip then
        if not noclipConnection then
            noclipConnection = RunService.Stepped:Connect(function()
                if noclip and LocalPlayer.Character then
                    for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
end)

local infJump = false
AddToggle(MovementPage, "Infinite Jump (លោតលើអាកាស)", false, function(s)
    infJump = s
end)

UserInputService.JumpRequest:Connect(function()
    if infJump and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

AddSlider(MovementPage, "WalkSpeed (ល្បឿនរត់)", 16, 150, 16, function(v)
    realWalkSpeed = v
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = v
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if hum and realWalkSpeed ~= 16 then
        hum.WalkSpeed = realWalkSpeed
    end
    if nameProtectActive and hum then
        hum.DisplayName = "Protected_User"
    end
end)

-- [TAB: MISC]
local antiAfkEnabled = true
LocalPlayer.Idled:Connect(function()
    if antiAfkEnabled then
        VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
    end
end)

AddToggle(MiscPage, "Anti-AFK (ការពារ Disconnect)", true, function(s)
    antiAfkEnabled = s
end)

AddButton(MiscPage, "Copy Discord Server", function()
    if setclipboard then
        setclipboard("https://discord.gg/8cqVS3DUzu")
    elseif toclipboard then
        toclipboard("https://discord.gg/8cqVS3DUzu")
    end
end)

-- Toggle Menu Button
CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    local OpenBtn = ScreenGui:FindFirstChild("AkiraOpenBtn")
    if not OpenBtn then
        OpenBtn = Instance.new("TextButton", ScreenGui)
        OpenBtn.Name = "AkiraOpenBtn"
        OpenBtn.Size = UDim2.fromOffset(80, 32)
        OpenBtn.Position = UDim2.fromOffset(24, 24)
        OpenBtn.BackgroundColor3 = Color3.fromRGB(255, 35, 60)
        OpenBtn.Text = "AKIRA"
        OpenBtn.TextColor3 = Color3.new(1, 1, 1)
        OpenBtn.Font = Enum.Font.ArialBold
        OpenBtn.TextSize = 12
        OpenBtn.Active = true
        OpenBtn.Draggable = true
        Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)

        local Glow = Instance.new("UIStroke", OpenBtn)
        Glow.Color = Color3.fromRGB(255, 255, 255)
        Glow.Thickness = 1

        OpenBtn.MouseButton1Click:Connect(function()
            Main.Visible = true
            OpenBtn:Destroy()
        end)
    end
end)
