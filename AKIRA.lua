-- // ========================================== //
-- //   AKIRA SCRIPT - ULTRA REBUILT v5.0        //
-- //   CLEAN STABLE & OPTIMIZED ENGINE          //
-- // ========================================== //

local function getService(name)
    local serv = game:GetService(name)
    return cloneref and cloneref(serv) or serv
end

local Players = getService("Players")
local TweenService = getService("TweenService")
local UserInputService = getService("UserInputService")
local Workspace = getService("Workspace")
local RunService = getService("RunService")
local VirtualUser = getService("VirtualUser")
local TeleportService = getService("TeleportService")
local HttpService = getService("HttpService")
local GuiService = getService("GuiService")

local LocalPlayer = Players.LocalPlayer

-- ========================================================
-- 1. SECURITY & BYPASS MODULE (CLEAN METATABLE HOOKS)
-- ========================================================
local Security = {
    Active = true,
    SpoofedWalkSpeed = 16,
    SpoofedJumpPower = 50
}

local function InitSecurityEngine()
    if not (hookmetamethod and getnamecallmethod and checkcaller) then return end

    -- Safe __namecall Hooking (Anti-Kick & Remote Intercept)
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()

        if not checkcaller() and Security.Active then
            local lowerMethod = string.lower(method)

            -- ទប់ស្កាត់ Client-side Kick
            if lowerMethod == "kick" then
                return nil
            end

            -- ទប់ស្កាត់ការបញ្ជូនទិន្នន័យ Anti-Cheat / Report ទៅ Server
            if lowerMethod == "fireserver" and typeof(self) == "Instance" and self:IsA("RemoteEvent") then
                local remoteName = string.lower(self.Name)
                local flaggedWords = {"ban", "cheat", "detect", "flag", "report", "exploit", "hack", "log", "security"}
                for _, word in ipairs(flaggedWords) do
                    if string.find(remoteName, word) then
                        return nil
                    end
                end
            end
        end

        return oldNamecall(self, ...)
    end)

    -- Safe __index Hooking (WalkSpeed & JumpPower Spoofing)
    local oldIndex
    oldIndex = hookmetamethod(game, "__index", function(self, key)
        if not checkcaller() and Security.Active and typeof(self) == "Instance" then
            if self:IsA("Humanoid") then
                local prop = tostring(key)
                if prop == "WalkSpeed" then
                    return Security.SpoofedWalkSpeed
                elseif prop == "JumpPower" then
                    return Security.SpoofedJumpPower
                end
            end
        end
        return oldIndex(self, key)
    end)
end

pcall(InitSecurityEngine)

-- ========================================================
-- 2. SECURE GUI CONTAINER
-- ========================================================
local uiParent = nil
if gethui then
    uiParent = gethui()
elseif (syn and syn.protect_gui) then
    local pgui = Instance.new("Folder")
    syn.protect_gui(pgui)
    pgui.Parent = getService("CoreGui")
    uiParent = pgui
else
    uiParent = LocalPlayer:WaitForChild("PlayerGui")
end

local existingUI = uiParent:FindFirstChild("AkiraSecureUI")
if existingUI then existingUI:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AkiraSecureUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = uiParent

-- Main Window
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
Title.Text = '<font color="rgb(255,35,60)">AKIRA</font> <font color="rgb(255,255,255)">SCRIPT</font> <font color="rgb(140,140,160)">[v5.0 REBUILT]</font>'
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
Instance.new("UIPadding", Sidebar).PaddingTop = UDim.new(0, 8)

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

-- ========================================================
-- 3. UI ELEMENT HELPERS
-- ========================================================
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
-- 4. DATABASE & ENGINE SYSTEMS
-- ========================================================
local FarmPage = CreateTab("Auto Farm")
local SelectEggPage = CreateTab("Select Eggs")
local SecurityPage = CreateTab("Security 🛡️")
local UtilityPage = CreateTab("Utility")
local MovementPage = CreateTab("Movement")

Pages["Auto Farm"].Visible = true
TabButtons["Auto Farm"].BackgroundColor3 = Color3.fromRGB(255, 35, 60)
TabButtons["Auto Farm"].TextColor3 = Color3.new(1, 1, 1)

local EggDatabase = {
    ["eternal"] = { Name = "Eternal Egg", Price = "5,000,000+", Color = Color3.fromRGB(150, 0, 255) },
    ["divine"] = { Name = "Divine Egg", Price = "1,000,000+", Color = Color3.fromRGB(0, 230, 255) },
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
local farmSpeed = 35 -- Safe default speed
local customEggInput = ""

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

local function IsEggWanted(name)
    name = string.lower(name)
    if customEggInput ~= "" and string.find(name, string.lower(customEggInput)) then
        return true
    end
    for eggName, isSelected in pairs(SelectedEggs) do
        if isSelected then
            local keyword = string.lower(string.split(eggName, " ")[1])
            if string.find(name, keyword) then return true end
        end
    end
    return false
end

local function MoveToTarget(targetPos)
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local distance = (root.Position - targetPos).Magnitude
    local timeToReach = math.clamp(distance / farmSpeed, 0.1, 12)

    local tweenInfo = TweenInfo.new(timeToReach, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(targetPos + Vector3.new(0, 1.5, 0))})
    tween:Play()
    tween.Completed:Wait()
end

-- ========================================================
-- 5. TAB IMPLEMENTATION
-- ========================================================

-- [AUTO FARM]
local fastRunFarm = false
AddToggle(FarmPage, "Auto Farm (រត់ប្រមូលពង)", false, function(s)
    fastRunFarm = s
    if s then
        task.spawn(function()
            while fastRunFarm do
                task.wait(0.2)
                pcall(function()
                    local char = LocalPlayer.Character
                    local root = char and char:FindFirstChild("HumanoidRootPart")
                    if not root then return end

                    -- Check If Player Has Egg
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
                            task.wait(0.5)
                        end
                    else
                        -- Scan for Closest Wanted Egg Prompt
                        local closestPrompt = nil
                        local shortestDist = 500

                        for _, obj in ipairs(Workspace:GetDescendants()) do
                            if obj:IsA("ProximityPrompt") then
                                local parent = obj.Parent
                                if parent and parent:IsA("BasePart") then
                                    local dist = (root.Position - parent.Position).Magnitude
                                    if dist < shortestDist then
                                        local promptText = string.lower(obj.ActionText .. " " .. obj.ObjectText .. " " .. parent.Name)
                                        if string.find(promptText, "egg") and IsEggWanted(promptText) then
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
                            task.wait(0.25)
                        end
                    end
                end)
            end
        end)
    end
end)

AddSlider(FarmPage, "Movement Speed (ល្បឿនផ្លាស់ទី)", 20, 60, 35, function(v)
    farmSpeed = v
end)

AddButton(FarmPage, "Set Current Spot as Base (កន្លែងទម្លាក់ពង)", function()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        myBasePos = root.Position
    end
end)

-- [SELECT EGGS]
for eggName, _ in pairs(SelectedEggs) do
    AddToggle(SelectEggPage, eggName, SelectedEggs[eggName], function(state)
        SelectedEggs[eggName] = state
    end)
end

-- [SECURITY]
AddToggle(SecurityPage, "Bypass Engine (Spoofing & Kick Block)", true, function(s)
    Security.Active = s
end)

local antiStaff = false
local function CheckStaff(player)
    if not antiStaff or player == LocalPlayer then return end
    pcall(function()
        if game.CreatorType == Enum.CreatorType.Group and player:GetRankInGroup(game.CreatorId) >= 100 then
            LocalPlayer:Kick("Akira Guard: Staff detected!")
        elseif player.UserId == game.CreatorId then
            LocalPlayer:Kick("Akira Guard: Game Creator joined!")
        end
    end)
end

AddToggle(SecurityPage, "Anti-Staff (ចាកចេញពេលមាន Admin)", false, function(s)
    antiStaff = s
    if s then
        for _, p in ipairs(Players:GetPlayers()) do CheckStaff(p) end
    end
end)
Players.PlayerAdded:Connect(CheckStaff)

-- [UTILITY - ESP (OPTIMIZED CACHE)]
local eggEspActive = false
local trackedEggParts = {}

local function ClearESP()
    for part, gui in pairs(trackedEggParts) do
        if gui and gui.Parent then gui:Destroy() end
    end
    table.clear(trackedEggParts)
end

local function ApplyEggBillboard(part)
    if not eggEspActive or trackedEggParts[part] then return end
    local realName, price, col = GetEggDetails(part.Name)

    local bb = Instance.new("BillboardGui")
    bb.Name = "AkiraEggESP"
    bb.Adornee = part
    bb.Size = UDim2.new(0, 130, 0, 40)
    bb.StudsOffset = Vector3.new(0, 2, 0)
    bb.AlwaysOnTop = true

    local titleLbl = Instance.new("TextLabel", bb)
    titleLbl.Size = UDim2.new(1, 0, 0.5, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = realName
    titleLbl.TextColor3 = col
    titleLbl.Font = Enum.Font.ArialBold
    titleLbl.TextSize = 12
    titleLbl.TextStrokeTransparency = 0.2

    local priceLbl = Instance.new("TextLabel", bb)
    priceLbl.Position = UDim2.new(0, 0, 0.5, 0)
    priceLbl.Size = UDim2.new(1, 0, 0.5, 0)
    priceLbl.BackgroundTransparency = 1
    priceLbl.Text = price .. " 🪙"
    priceLbl.TextColor3 = Color3.fromRGB(255, 215, 0)
    priceLbl.Font = Enum.Font.ArialBold
    priceLbl.TextSize = 11
    priceLbl.TextStrokeTransparency = 0.2

    bb.Parent = part
    trackedEggParts[part] = bb
end

AddToggle(UtilityPage, "Egg Price & ESP (បង្ហាញតម្លៃពង)", false, function(s)
    eggEspActive = s
    if s then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and string.find(string.lower(obj.Name), "egg") then
                ApplyEggBillboard(obj)
            end
        end
    else
        ClearESP()
    end
end)

Workspace.DescendantAdded:Connect(function(descendant)
    if eggEspActive and descendant:IsA("BasePart") and string.find(string.lower(descendant.Name), "egg") then
        task.wait(0.2)
        ApplyEggBillboard(descendant)
    end
end)

-- [MOVEMENT]
local noclip = false
local noclipConn = nil
AddToggle(MovementPage, "Noclip (ដើរកាត់ជញ្ជាំង)", false, function(s)
    noclip = s
    if s then
        noclipConn = RunService.Stepped:Connect(function()
            if noclip and LocalPlayer.Character then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConn then
            noclipConn:Disconnect()
            noclipConn = nil
        end
    end
end)

-- Window Minimize Control
CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    local OpenBtn = ScreenGui:FindFirstChild("AkiraOpenBtn")
    if not OpenBtn then
        OpenBtn = Instance.new("TextButton", ScreenGui)
        OpenBtn.Name = "AkiraOpenBtn"
        OpenBtn.Size = UDim2.fromOffset(75, 30)
        OpenBtn.Position = UDim2.fromOffset(20, 20)
        OpenBtn.BackgroundColor3 = Color3.fromRGB(255, 35, 60)
        OpenBtn.Text = "AKIRA"
        OpenBtn.TextColor3 = Color3.new(1, 1, 1)
        OpenBtn.Font = Enum.Font.ArialBold
        OpenBtn.TextSize = 12
        OpenBtn.Active = true
        OpenBtn.Draggable = true
        Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)

        OpenBtn.MouseButton1Click:Connect(function()
            Main.Visible = true
            OpenBtn:Destroy()
        end)
    end
end)
