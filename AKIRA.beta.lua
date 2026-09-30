if not game:IsLoaded() then
    game.Loaded:Wait()
end

do
    local str
    do
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        if not LocalPlayer then
            pcall(function()
                Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
            end)
            LocalPlayer = Players.LocalPlayer
        end

        str = tostring(LocalPlayer and LocalPlayer.UserId or 0)
    end

    local v4 = getgenv and getgenv() or _G
    local KiraHub = v4.KiraHub

    if type(KiraHub) ~= "table" then
        KiraHub = {
            slots = {}
        }
        v4.KiraHub = KiraHub
    end

    if type(KiraHub.slots) ~= "table" then
        KiraHub.slots = {}
    end

    local unload
    do
        local v6 = KiraHub.slots[str]
        if type(v6) ~= "table" then
            v6 = {}
            KiraHub.slots[str] = v6
        end

        v6.gen = (tonumber(v6.gen) or 0) + 1
        local v7 = false

        for k, v in pairs(KiraHub.slots) do
            if str ~= tostring(k) and type(v) == "table" and v.alive == true then
                v7 = true
                break
            end
        end

        if not v7 then
            v4.KiraCfgGen = (tonumber(v4.KiraCfgGen) or 0) + 1
        end

        unload = v6.unload
        v6.unload = nil
        v6.alive = false
    end

    if type(unload) == "function" then
        pcall(unload)
    elseif type(v4.KiraUnload) == "function" then
        local KiraUnloadUid = v4.KiraUnloadUid
        local v12 = KiraUnloadUid == nil or str == tostring(KiraUnloadUid)

        if KiraUnloadUid == nil then
            for k, v in pairs(KiraHub.slots) do
                if str ~= tostring(k) and type(v) == "table" and type(v.unload) == "function" then
                    v12 = false
                    break
                end
            end
        end

        if v12 then
            local KiraUnload = v4.KiraUnload
            if str == tostring(KiraUnloadUid or str) then
                v4.KiraUnload = nil
                v4.KiraUnloadUid = nil
            end
            pcall(KiraUnload)
        end
    end
end

do
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    if not LocalPlayer then
        pcall(function()
            Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        end)
        LocalPlayer = Players.LocalPlayer
    end

    local v18 = os.clock() + 60
    while LocalPlayer and v18 > os.clock() do
        local v20, v21
        do
            local Character = LocalPlayer.Character
            v20 = Character and Character:FindFirstChildOfClass("Humanoid")
            v21 = Character and Character:FindFirstChild("HumanoidRootPart")
        end

        if v20 and v21 and v20.Health > 0 then
            task.wait(0.45)
            local Character = LocalPlayer.Character
            local v23 = Character and Character:FindFirstChildOfClass("Humanoid")
            local v24 = Character and Character:FindFirstChild("HumanoidRootPart")

            if not v23 or not v24 or not (v23.Health > 0) then
                continue
            end
            break
        end
        task.wait(0.1)
    end
end

-- ==================== CONFIG & LOCALIZATION ====================
local t1 = {
    Title = "AKIRA SCRIPT HUB",
    Version = "2.0 Premium",
    Product = "Steal an Egg",
    OpenBind = Enum.KeyCode.RightShift,
    FlightBind = Enum.KeyCode.F,
    Tagline = "អូតូហ្វាម ស៊ុត និងមុខងារកម្រិតខ្ពស់",
    Status = "Premium",
    Game = "Steal an Egg",
    Discord = "https://discord.gg/ZNwS8csX3j",
    Website = "",
    Changelog = "v2.0: New Premium UI Style, Custom Logo, Dual Language Support (KH/EN)",
    Author = "AKIRA SCRIPT HUB",
    Credits = "អរគុណសម្រាប់ការគាំទ្រ AKIRA SCRIPT HUB",
    Support = "ចូលរួម Discord សម្រាប់ជំនួយបន្ថែម!"
}

local CUSTOM_LOGO_ID = "rbxassetid://97330468088484"
local currentLang = "Khmer" -- "Khmer" ឬ "English"

local LangTable = {
    Khmer = {
        ["About"] = "អំពី",
        ["Autofarm"] = "អូតូហ្វាម",
        ["Other stuff"] = "មុខងារផ្សេងៗ",
        ["Config"] = "ការកំណត់",
        ["Auto Steal"] = "លួចស៊ុតស្វ័យប្រវត្តិ",
        ["Plot"] = "ដីរបស់អ្នក",
        ["Serverhop"] = "ប្តូរ Server",
        ["Misc"] = "ផ្សេងៗ",
        ["Webhook"] = "Webhook",
        ["Settings"] = "ការកំណត់",
        ["Features"] = "មុខងារពិសេស",
        ["Links"] = "តំណភ្ជាប់",
        ["Credits"] = "ឥណទាន",
        ["Made by"] = "បង្កើតដោយ",
        ["With"] = "ជាមួយ",
        ["Support"] = "ការគាំទ្រ",
        ["Disclaimer"] = "ការបញ្ជាក់",
        ["Not official"] = "មិនមែនផ្លូវការ",
        ["Auto steal"] = "លួចស៊ុតស្វ័យប្រវត្តិ",
        ["Targeting"] = "ការកំណត់គោលដៅ",
        ["Where to look"] = "កន្លែងស្វែងរក",
        ["What qualifies"] = "លក្ខខណ្ឌ",
        ["Event"] = "ព្រឹត្តិការណ៍",
        ["Eggs & pets"] = "ស៊ុត និងសត្វ",
        ["Upgrades"] = "ការអាប់ក្រេដ",
        ["Selling"] = "ការលក់",
        ["Treadmill training"] = "ហ្វឹកហាត់ Treadmill",
        ["Auto hop"] = "ប្តូរ Server ស្វ័យប្រវត្តិ",
        ["Leave when"] = "ចាកចេញនៅពេល",
        ["Leave now"] = "ចាកចេញឥឡូវនេះ",
        ["Which servers"] = "Server ណាខ្លះ",
        ["Eggs on the map"] = "ស៊ុតនៅលើផែនទី",
        ["Eggs on your plot"] = "ស៊ុតនៅលើដីរបស់អ្នក",
        ["Stats"] = "ស្ថិតិ",
        ["Defence"] = "ការពារ",
        ["Bat"] = "ដំបង",
        ["Walking"] = "ការដើរ",
        ["Flight"] = "ហោះហើរ",
        ["Performance"] = "ប្រសិទ្ធភាព",
        ["Connection"] = "ការតភ្ជាប់",
        ["What to send"] = "អ្វីដែលត្រូវផ្ញើ",
        ["How much noise"] = "កម្រិតការជូនដំណឹង",
        ["The message"] = "សារ",
        ["Appearance"] = "រូបរាង",
        ["Keybinds"] = "ប៊ូតុងក្តារចុច",
        ["Window"] = "ផ្ទាំងកម្មវិធី",
        ["Language"] = "ភាសា / Language",
        ["Select Language"] = "ជ្រើសរើសភាសា",
        ["Filter this page"] = "ស្វែងរកមុខងារ...",
        ["Travel speed"] = "ល្បឿនធ្វើដំណើរ",
        ["Speed"] = "ល្បឿន",
        ["Steal speed"] = "ល្បឿនលួច",
        ["What to take"] = "អ្វីដែលត្រូវយក",
        ["Best value"] = "តម្លៃល្អបំផុត",
        ["Egg type filter"] = "តម្រងប្រភេទស៊ុត",
        ["Gen ($/s) snipe"] = "ស្វែងរកតាមចំណូល ($/s)",
        ["Egg ($/s) snipe"] = "ស្វែងរកស៊ុតតាមចំណូល ($/s)",
        ["Areas"] = "តំបន់",
        ["Egg types"] = "ប្រភេទស៊ុត",
        ["Use mutation filter"] = "ប្រើតម្រង Mutation",
        ["Mutations"] = "Mutation",
        ["Minimum weight (Kg)"] = "ទម្ងន់អប្បបរមា (Kg)",
        ["Auto Hungry Monster"] = "Hungry Monster ស្វ័យប្រវត្តិ",
        ["Don't feed if egg makes ($/s)"] = "កុំចិញ្ចឹម បើស៊ុតរកបាន ($/s)",
        ["Auto place eggs"] = "ដាក់ស៊ុតស្វ័យប្រវត្តិ",
        ["Never place rarer"] = "កុំដាក់ស៊ុតកម្រជាង",
        ["Only place eggs worth ($/s)"] = "ដាក់តែស៊ុតដែលមានតម្លៃ ($/s)",
        ["Auto hatch"] = "ញាស់ស៊ុតស្វ័យប្រវត្តិ",
        ["Auto place best pets"] = "ដាក់សត្វល្អបំផុតស្វ័យប្រវត្តិ",
        ["Auto upgrade trails"] = "អាប់ក្រេដផ្លូវស្វ័យប្រវត្តិ",
        ["Auto upgrade treadmill"] = "អាប់ក្រេដ Treadmill ស្វ័យប្រវត្តិ",
        ["Auto upgrade pen"] = "អាប់ក្រេដកន្លែងសត្វស្វ័យប្រវត្តិ",
        ["Keep this much money"] = "រក្សាលុយចំនួននេះ",
        ["Preview what will sell"] = "មើលអ្វីដែលនឹងលក់",
        ["Sell anything earning under ($/s)"] = "លក់អ្វីដែលរកបានក្រោម ($/s)",
        ["Auto sell pets"] = "លក់សត្វស្វ័យប្រវត្តិ",
        ["Auto sell eggs"] = "លក់ស៊ុតស្វ័យប្រវត្តិ",
        ["Auto treadmill"] = "Treadmill ស្វ័យប្រវត្តិ",
        ["Train when nothing to steal"] = "ហ្វឹកហាត់ពេលគ្មានអ្វីឲ្យលួច",
        ["Get ready early"] = "ត្រៀមខ្លួនមុន",
        ["Pages to fetch"] = "ចំនួនទំព័រត្រូវទាញ",
        ["Skip full servers"] = "រំលង Server ពេញ",
        ["Players"] = "អ្នកលេង",
        ["Egg ESP"] = "ESP ស៊ុត",
        ["Show ESP on"] = "បង្ហាញ ESP លើ",
        ["Beam to current target"] = "បាញ់ខ្សែទៅគោលដៅបច្ចុប្បន្ន",
        ["Plot egg ESP"] = "ESP ស៊ុតលើដី",
        ["Show stats panel"] = "បង្ហាញផ្ទាំងស្ថិតិ",
        ["Auto claim index"] = "ទាមទារ Index ស្វ័យប្រវត្តិ",
        ["Anti trap"] = "ការពារ Trap",
        ["Anti ragdoll"] = "ការពារ Ragdoll",
        ["Bat aura"] = "អូរ៉ា ដំបង",
        ["Bypass speed"] = "ល្បឿន Bypass",
        ["Bypass speed cap"] = "កម្រិតល្បឿន Bypass",
        ["Game optimizer"] = "បង្កើនប្រសិទ្ធភាពហ្គេម",
        ["FPS cap"] = "កំណត់ FPS",
        ["Send outbound"] = "ផ្ញើចេញ",
        ["Endpoint URL"] = "URL គោលដៅ",
        ["Test send"] = "សាកល្បងផ្ញើ",
        ["Egg stolen"] = "ស៊ុតត្រូវបានលួច",
        ["Egg hatched"] = "ស៊ុតបានញាស់",
        ["Sold pets or eggs"] = "លក់សត្វ ឬស៊ុត",
        ["Rewards claimed"] = "រង្វាន់ដែលបានទាមទារ",
        ["Only eggs earning over ($/s)"] = "តែស៊ុតដែលរកបានលើស ($/s)",
        ["Rarity floor"] = "កម្រិត Rarity",
        ["Session recap"] = "សង្ខេប Session",
        ["Ping"] = "Ping",
        ["User id"] = "User ID",
        ["Show my Roblox name and headshot"] = "បង្ហាញឈ្មោះ និង Profile",
        ["Let exported configs carry the URL"] = "ឲ្យ Config Export មាន URL",
        ["Phone layout"] = "ប្លង់ទូរស័ព្ទ",
        ["UI scale"] = "ទំហំ UI",
        ["Theme"] = "ស្ទីលពណ៌ / Theme",
        ["Start minimised"] = "ចាប់ផ្តើមជាផ្ទាំងតូច",
        ["Load config"] = "ផ្ទុក Config",
        ["Save as"] = "រក្សាទុកជា",
        ["Save config"] = "រក្សាទុក Config",
        ["Export settings"] = "Export ការកំណត់",
        ["Import settings"] = "Import ការកំណត់",
        ["Import"] = "Import",
        ["Reset position & size"] = "កំណត់ទីតាំង និងទំហំឡើងវិញ",
        ["Reset"] = "កំណត់ឡើងវិញ",
        ["Copy"] = "ចម្លង",
        ["Send"] = "ផ្ញើ",
        ["Preview"] = "មើលជាមុន",
        ["Hop now"] = "ប្តូរ Server ឥឡូវនេះ",
        ["Hop"] = "ប្តូរ"
    },
    English = {}
}

local function tr(text)
    if not text then return "" end
    if currentLang == "Khmer" then
        return LangTable.Khmer[text] or text
    end
    return text
end

local function v26(p1)
    local v328 = tostring(p1 or "Game"):gsub("[<>:\"/\\|?*]", "_"):gsub("%s+", "_"):gsub("_+", "_"):match("^%s*(.-)%s*$")
    if not v328 or v328 == "" or v328 == "_" then
        v328 = "Game"
    end
    return v328
end

-- ==================== PREMIUM THEME PALETTE ====================
-- Glassmorphism, deep obsidian background, neon cyan & gold accenting
local t2 = {
    Dark = {
        bg = Color3.fromRGB(15, 17, 23),
        rail = Color3.fromRGB(20, 24, 33),
        card = Color3.fromRGB(26, 31, 44),
        lift = Color3.fromRGB(34, 41, 58),
        fill = Color3.fromRGB(42, 50, 71),
        line = Color3.fromRGB(56, 68, 96),
        text = Color3.fromRGB(245, 247, 252),
        dim = Color3.fromRGB(160, 175, 204),
        mute = Color3.fromRGB(105, 119, 148),
        accent = Color3.fromRGB(0, 210, 255),       -- Premium Cyber Cyan
        accentDeep = Color3.fromRGB(0, 110, 150),
        accentHover = Color3.fromRGB(70, 225, 255),
        ink = Color3.fromRGB(10, 12, 16),
        ok = Color3.fromRGB(72, 220, 150),
        Kira = Color3.fromRGB(245, 247, 252)
    },
    Light = {
        bg = Color3.fromRGB(242, 245, 250),
        rail = Color3.fromRGB(232, 236, 245),
        card = Color3.fromRGB(255, 255, 255),
        lift = Color3.fromRGB(240, 243, 250),
        fill = Color3.fromRGB(222, 228, 240),
        line = Color3.fromRGB(200, 210, 228),
        text = Color3.fromRGB(20, 25, 35),
        dim = Color3.fromRGB(90, 105, 130),
        mute = Color3.fromRGB(135, 150, 175),
        accent = Color3.fromRGB(0, 150, 220),
        accentDeep = Color3.fromRGB(0, 95, 145),
        accentHover = Color3.fromRGB(30, 170, 245),
        ink = Color3.fromRGB(255, 255, 255),
        ok = Color3.fromRGB(46, 175, 110),
        Kira = Color3.fromRGB(20, 25, 35)
    }
}

local t3 = {}
for k, v in pairs(t2.Dark) do
    t3[k] = v
end

local t4 = {
    title = Enum.Font.GothamBold,
    mid = Enum.Font.GothamMedium,
    body = Enum.Font.Gotham,
    mono = Enum.Font.RobotoMono
}

local n1 = 640
local n2 = 450
local n3 = 160

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local str = tostring(LocalPlayer and LocalPlayer.UserId or 0)
local v48 = "AKIRA_UI_" .. str
local v49 = "AKIRA_WorldGui_" .. str

local t5 = {"Forest", "Desert", "Lake", "Jungle", "Snow", "Volcano", "Prehistoric", "Cosmic", "Abyss Ocean", "Cherry Blossom"}
local t6 = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Cosmic", "Secret", "Eternal", "Divine", "Titan"}
local t7 = {"Golden", "Rainbow", "Galaxy", "Crystal", "Bloom"}
local t8 = {About = "info", ["Auto Steal"] = "egg", Plot = "grid", Serverhop = "rocket", Misc = "layers", Webhook = "out", Settings = "cog"}

local t9 = {Theme = "Dark"}
local t10 = {}
local t12 = {}
local t13 = {}
local t14 = {}
local t64 = {}
local localizedLabels = {}

local u42 = UserInputService.TouchEnabled
local u66, u68, u69, u70, u71, u284
local v98, v108, v113, v151, v194, v199, v204, v210, v217, v228, v229, v250, v306

local self = setmetatable({}, {__mode = "k"})

local function v81(p5, p6, p7, p8)
    local v379 = self[p5]
    if v379 then pcall(function() v379:Cancel() end) end
    local tween = TweenService:Create(p5, TweenInfo.new(p6, p8 or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), p7)
    self[p5] = tween
    tween:Play()
end

local function v83(p12, p13, p14)
    local color = type(p13) == "string" and (t3[p13] or t3.line) or (p13 or t3.line)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = p14 or 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    if p12 then stroke.Parent = p12 end
    if type(p13) == "string" then stroke:SetAttribute("th_stroke", p13) end
    return stroke
end

local function v84(p15, p16, p17, p18, p19)
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, p16)
    pad.PaddingTop = UDim.new(0, p17 or p16)
    pad.PaddingRight = UDim.new(0, p18 or p16)
    pad.PaddingBottom = UDim.new(0, p19 or (p17 or p16))
    if p15 then pad.Parent = p15 end
    return pad
end

local function registerText(label, originalKey)
    localizedLabels[label] = originalKey
    label.Text = tr(originalKey)
end

local function refreshAllTranslations()
    for lbl, orig in pairs(localizedLabels) do
        if lbl and lbl.Parent then
            pcall(function() lbl.Text = tr(orig) end)
        else
            localizedLabels[lbl] = nil
        end
    end
    if u66 then
        v204.Text = tr(u66.name)
        v210.Text = tr(u66.subtitle)
    end
end

-- Logo Creator (Uses Asset ID 97330468088484)
local function createLogo(parent, zIndex, size)
    local frame = Instance.new("Frame")
    frame.Name = "AkiraLogo"
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.fromOffset(size or 24, size or 24)
    frame.ZIndex = zIndex or 15
    if parent then frame.Parent = parent end

    local img = Instance.new("ImageLabel")
    img.Name = "Mark"
    img.BackgroundTransparency = 1
    img.Size = UDim2.fromScale(1, 1)
    img.Image = CUSTOM_LOGO_ID
    img.ScaleType = Enum.ScaleType.Fit
    img.ZIndex = (zIndex or 15) + 1
    img.Parent = frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = img

    return frame
end

-- ==================== SCREEN GUI SETUP ====================
local coreGui = game:GetService("CoreGui")
local parentGui = (gethui and gethui()) or (pcall(function() return coreGui:FindFirstChild("PH_UI") end) and coreGui) or LocalPlayer:WaitForChild("PlayerGui")

local existing = parentGui:FindFirstChild(v48)
if existing then existing:Destroy() end

v98 = Instance.new("ScreenGui")
v98.Name = v48
v98.ResetOnSpawn = false
v98.IgnoreGuiInset = true
v98.DisplayOrder = 1200
v98.Parent = parentGui

-- Main Container Window
v113 = Instance.new("Frame")
v113.Name = "MainWindow"
v113.AnchorPoint = Vector2.new(0.5, 0.5)
v113.Position = UDim2.fromScale(0.5, 0.5)
v113.Size = UDim2.fromOffset(n1, n2)
v113.BackgroundColor3 = t3.bg
v113.BorderSizePixel = 0
v113.ClipsDescendants = false
v113.ZIndex = 10
v113.Parent = v98

local winCorner = Instance.new("UICorner")
winCorner.CornerRadius = UDim.new(0, 16)
winCorner.Parent = v113

local winStroke = v83(v113, "line", 1.5)

-- Drop Shadow
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.55
shadow.Position = UDim2.fromOffset(0, 14)
shadow.Size = UDim2.new(1, 0, 1, 0)
shadow.ZIndex = 8
shadow.BorderSizePixel = 0
shadow.Parent = v113

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 18)
shadowCorner.Parent = shadow

v108 = Instance.new("UIScale")
v108.Scale = 1
v108.Parent = v113

-- Sidebar (Rail)
v151 = Instance.new("Frame")
v151.Name = "Sidebar"
v151.BackgroundColor3 = t3.rail
v151.BorderSizePixel = 0
v151.Size = UDim2.new(0, n3, 1, 0)
v151.ZIndex = 11
v151.Parent = v113

local railCorner = Instance.new("UICorner")
railCorner.CornerRadius = UDim.new(0, 16)
railCorner.Parent = v151

-- Logo & Title Area in Sidebar
local logoContainer = Instance.new("Frame")
logoContainer.BackgroundTransparency = 1
logoContainer.Size = UDim2.new(1, 0, 0, 52)
logoContainer.Position = UDim2.fromOffset(0, 10)
logoContainer.ZIndex = 12
logoContainer.Parent = v151

local logoIcon = createLogo(logoContainer, 13, 32)
logoIcon.Position = UDim2.fromOffset(12, 10)

local titleLbl = Instance.new("TextLabel")
titleLbl.BackgroundTransparency = 1
titleLbl.Position = UDim2.fromOffset(50, 10)
titleLbl.Size = UDim2.new(1, -54, 0, 18)
titleLbl.Font = t4.title
titleLbl.Text = "AKIRA"
titleLbl.TextColor3 = t3.accent
titleLbl.TextSize = 15
titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.ZIndex = 13
titleLbl.Parent = logoContainer

local subTitleLbl = Instance.new("TextLabel")
subTitleLbl.BackgroundTransparency = 1
subTitleLbl.Position = UDim2.fromOffset(50, 28)
subTitleLbl.Size = UDim2.new(1, -54, 0, 14)
subTitleLbl.Font = t4.mono
subTitleLbl.Text = "SCRIPT HUB"
subTitleLbl.TextColor3 = t3.dim
subTitleLbl.TextSize = 9
subTitleLbl.TextXAlignment = Enum.TextXAlignment.Left
subTitleLbl.ZIndex = 13
subTitleLbl.Parent = logoContainer

-- Nav Menu Scroll
local navScroll = Instance.new("ScrollingFrame")
navScroll.BackgroundTransparency = 1
navScroll.Position = UDim2.fromOffset(0, 70)
navScroll.Size = UDim2.new(1, 0, 1, -80)
navScroll.ScrollBarThickness = 0
navScroll.ZIndex = 12
navScroll.Parent = v151

local navList = Instance.new("UIListLayout")
navList.Padding = UDim.new(0, 4)
navList.SortOrder = Enum.SortOrder.LayoutOrder
navList.Parent = navScroll
v84(navScroll, 8, 4, 8, 4)

-- Main Content Area
v194 = Instance.new("Frame")
v194.Name = "MainContent"
v194.BackgroundTransparency = 1
v194.Position = UDim2.fromOffset(n3, 0)
v194.Size = UDim2.new(1, -n3, 1, 0)
v194.ZIndex = 11
v194.Parent = v113

-- Top Header Bar
v199 = Instance.new("Frame")
v199.Name = "HeaderBar"
v199.BackgroundTransparency = 1
v199.Size = UDim2.new(1, 0, 0, 50)
v199.ZIndex = 12
v199.Parent = v194

v204 = Instance.new("TextLabel")
v204.BackgroundTransparency = 1
v204.Position = UDim2.fromOffset(18, 10)
v204.Size = UDim2.new(1, -220, 0, 18)
v204.Font = t4.title
v204.Text = "Auto Steal"
v204.TextColor3 = t3.text
v204.TextSize = 16
v204.TextXAlignment = Enum.TextXAlignment.Left
v204.ZIndex = 13
v204.Parent = v199

v210 = Instance.new("TextLabel")
v210.BackgroundTransparency = 1
v210.Position = UDim2.fromOffset(18, 28)
v210.Size = UDim2.new(1, -220, 0, 14)
v210.Font = t4.body
v210.Text = "Targeting, Filters, and Auto Farming"
v210.TextColor3 = t3.dim
v210.TextSize = 11
v210.TextXAlignment = Enum.TextXAlignment.Left
v210.ZIndex = 13
v210.Parent = v199

-- Minimize Button
v217 = Instance.new("TextButton")
v217.AnchorPoint = Vector2.new(1, 0.5)
v217.BackgroundColor3 = t3.card
v217.Position = UDim2.new(1, -16, 0.5, 0)
v217.Size = UDim2.fromOffset(26, 26)
v217.Font = t4.title
v217.Text = "—"
v217.TextColor3 = t3.dim
v217.TextSize = 12
v217.AutoButtonColor = false
v217.ZIndex = 13
v217.Parent = v199

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = v217
v83(v217, "line", 1)

-- Page Container
local pageContainer = Instance.new("Frame")
pageContainer.BackgroundTransparency = 1
pageContainer.Position = UDim2.fromOffset(10, 52)
pageContainer.Size = UDim2.new(1, -20, 1, -58)
pageContainer.ClipsDescendants = true
pageContainer.ZIndex = 12
pageContainer.Parent = v194

-- Floating Logo Orb (Minimized State)
v306 = Instance.new("TextButton")
v306.Name = "AkiraFloatingOrb"
v306.AnchorPoint = Vector2.new(0.5, 0.5)
v306.Position = UDim2.new(0, 48, 0.5, 0)
v306.Size = UDim2.fromOffset(48, 48)
v306.BackgroundColor3 = t3.rail
v306.Text = ""
v306.AutoButtonColor = false
v306.Visible = false
v306.ZIndex = 100
v306.Parent = v98

local orbCorner = Instance.new("UICorner")
orbCorner.CornerRadius = UDim.new(1, 0) -- Circular
orbCorner.Parent = v306

local orbStroke = v83(v306, "accent", 2)

local orbLogo = createLogo(v306, 101, 30)
orbLogo.AnchorPoint = Vector2.new(0.5, 0.5)
orbLogo.Position = UDim2.fromScale(0.5, 0.5)

-- Orb Click / Minimize Behavior
local isWindowVisible = true
function u70(visible)
    isWindowVisible = visible
    v113.Visible = isWindowVisible
    v306.Visible = not isWindowVisible
end

v217.MouseButton1Click:Connect(function()
    u70(false)
end)

v306.MouseButton1Click:Connect(function()
    u70(true)
end)

-- Draggable Logic for Main Window & Orb
local function makeDraggable(targetBar, moveTarget)
    local dragging = false
    local dragInput, dragStart, startPos

    targetBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = moveTarget.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    targetBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            moveTarget.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(v199, v113)
makeDraggable(v151, v113)
makeDraggable(v306, v306)

-- Hotkey to toggle UI
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == (t9.OpenBind or t1.OpenBind) then
        u70(not isWindowVisible)
    end
end)

-- ==================== PAGE CREATION HELPERS ====================
local function createPage(pageName, pageSub)
    local pageScroll = Instance.new("ScrollingFrame")
    pageScroll.Name = pageName
    pageScroll.BackgroundTransparency = 1
    pageScroll.Size = UDim2.fromScale(1, 1)
    pageScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    pageScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    pageScroll.ScrollBarThickness = 3
    pageScroll.ScrollBarImageColor3 = t3.line
    pageScroll.BorderSizePixel = 0
    pageScroll.Visible = false
    pageScroll.ZIndex = 13
    pageScroll.Parent = pageContainer

    v84(pageScroll, 4, 4, 8, 8)

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 10)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = pageScroll

    local pageData = {
        name = pageName,
        subtitle = pageSub,
        scroll = pageScroll,
        items = {},
        n = 0
    }
    t12[pageName] = pageData
    t13[#t13 + 1] = pageName
    return pageData
end

function u68(pageName)
    local target = t12[pageName]
    if not target then return end
    u66 = target

    for name, tab in pairs(t64) do
        local active = (name == pageName)
        tab.btn.BackgroundColor3 = active and t3.lift or t3.rail
        tab.lbl.TextColor3 = active and t3.accent or t3.dim
        tab.lbl.Font = active and t4.title or t4.mid
    end

    for _, p in pairs(t12) do
        p.scroll.Visible = (p == target)
    end

    v204.Text = tr(pageName)
    v210.Text = tr(target.subtitle)
end

local function addTabButton(groupName, tabs, orderStart)
    local grpLbl = Instance.new("TextLabel")
    grpLbl.BackgroundTransparency = 1
    grpLbl.Size = UDim2.new(1, 0, 0, 20)
    grpLbl.Font = t4.mono
    grpLbl.TextColor3 = t3.mute
    grpLbl.TextSize = 10
    grpLbl.TextXAlignment = Enum.TextXAlignment.Left
    grpLbl.LayoutOrder = orderStart
    grpLbl.ZIndex = 12
    grpLbl.Parent = navScroll
    registerText(grpLbl, groupName)

    for i, tabName in ipairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = t3.rail
        btn.Size = UDim2.new(1, 0, 0, 32)
        btn.AutoButtonColor = false
        btn.LayoutOrder = orderStart + i
        btn.Text = ""
        btn.ZIndex = 12
        btn.Parent = navScroll

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn

        local lbl = Instance.new("TextLabel")
        lbl.BackgroundTransparency = 1
        lbl.Position = UDim2.fromOffset(12, 0)
        lbl.Size = UDim2.new(1, -16, 1, 0)
        lbl.Font = t4.mid
        lbl.TextColor3 = t3.dim
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 13
        lbl.Parent = btn
        registerText(lbl, tabName)

        t64[tabName] = {btn = btn, lbl = lbl}

        btn.MouseEnter:Connect(function()
            if u66 and u66.name ~= tabName then
                v81(btn, 0.15, {BackgroundColor3 = t3.card})
            end
        end)
        btn.MouseLeave:Connect(function()
            if u66 and u66.name ~= tabName then
                v81(btn, 0.15, {BackgroundColor3 = t3.rail})
            end
        end)
        btn.MouseButton1Click:Connect(function()
            u68(tabName)
        end)
    end
end

local function addCardSection(page, title)
    local section = Instance.new("Frame")
    section.AutomaticSize = Enum.AutomaticSize.Y
    section.Size = UDim2.new(1, 0, 0, 0)
    section.BackgroundColor3 = t3.card
    section.BorderSizePixel = 0
    section.ZIndex = 13
    page.n = page.n + 1
    section.LayoutOrder = page.n
    section.Parent = page.scroll

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = section
    v83(section, "line", 1)

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 4)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = section
    v84(section, 12, 10, 12, 10)

    if title and title ~= "" then
        local header = Instance.new("TextLabel")
        header.BackgroundTransparency = 1
        header.Size = UDim2.new(1, 0, 0, 20)
        header.Font = t4.title
        header.TextColor3 = t3.accent
        header.TextSize = 12
        header.TextXAlignment = Enum.TextXAlignment.Left
        header.LayoutOrder = 0
        header.ZIndex = 14
        header.Parent = section
        registerText(header, title)
    end

    return section
end

local function addToggle(parentSection, flag, title, desc, defaultVal)
    t9[flag] = defaultVal or false

    local row = Instance.new("Frame")
    row.BackgroundTransparency = 1
    row.Size = UDim2.new(1, 0, 0, 36)
    row.ZIndex = 14
    row.Parent = parentSection

    local tLbl = Instance.new("TextLabel")
    tLbl.BackgroundTransparency = 1
    tLbl.Position = UDim2.fromOffset(0, 2)
    tLbl.Size = UDim2.new(1, -60, 0, 16)
    tLbl.Font = t4.mid
    tLbl.TextColor3 = t3.text
    tLbl.TextSize = 12
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    tLbl.ZIndex = 15
    tLbl.Parent = row
    registerText(tLbl, title)

    if desc and desc ~= "" then
        local dLbl = Instance.new("TextLabel")
        dLbl.BackgroundTransparency = 1
        dLbl.Position = UDim2.fromOffset(0, 18)
        dLbl.Size = UDim2.new(1, -60, 0, 14)
        dLbl.Font = t4.body
        dLbl.TextColor3 = t3.dim
        dLbl.TextSize = 10
        dLbl.TextXAlignment = Enum.TextXAlignment.Left
        dLbl.ZIndex = 15
        dLbl.Parent = row
        registerText(dLbl, desc)
    end

    local switch = Instance.new("TextButton")
    switch.AnchorPoint = Vector2.new(1, 0.5)
    switch.Position = UDim2.new(1, 0, 0.5, 0)
    switch.Size = UDim2.fromOffset(40, 20)
    switch.BackgroundColor3 = t9[flag] and t3.accent or t3.fill
    switch.Text = ""
    switch.AutoButtonColor = false
    switch.ZIndex = 15
    switch.Parent = row

    local swCorner = Instance.new("UICorner")
    swCorner.CornerRadius = UDim.new(1, 0)
    swCorner.Parent = switch

    local circle = Instance.new("Frame")
    circle.Size = UDim2.fromOffset(16, 16)
    circle.Position = t9[flag] and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.ZIndex = 16
    circle.Parent = switch

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle

    local function updateSwitch(val)
        t9[flag] = val
        v81(switch, 0.15, {BackgroundColor3 = val and t3.accent or t3.fill})
        v81(circle, 0.15, {Position = val and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2)})
        if t10[flag] and t10[flag].on then
            pcall(t10[flag].on, val)
        end
    end

    switch.MouseButton1Click:Connect(function()
        updateSwitch(not t9[flag])
    end)

    t10[flag] = {
        kind = "toggle",
        set = updateSwitch
    }
end

-- ==================== BUILD PAGES ====================
local pAbout = createPage("About", "AKIRA SCRIPT HUB Premium Edition")
local pAutoSteal = createPage("Auto Steal", "targeting, filters, travel")
local pPlot = createPage("Plot", "eggs, pets, upgrades, selling")
local pServerhop = createPage("Serverhop", "server jumping and filters")
local pMisc = createPage("Misc", "esp, defence, flight, aura")
local pWebhook = createPage("Webhook", "discord webhook logs")
local pSettings = createPage("Settings", "hub configurations and language")

addTabButton("About", {"About"}, 0)
addTabButton("Autofarm", {"Auto Steal"}, 10)
addTabButton("Other stuff", {"Plot", "Serverhop", "Misc"}, 30)
addTabButton("Config", {"Webhook", "Settings"}, 50)

-- Settings: Language Switcher Card
local sLang = addCardSection(pSettings, "Language")
local langRow = Instance.new("Frame")
langRow.BackgroundTransparency = 1
langRow.Size = UDim2.new(1, 0, 0, 36)
langRow.ZIndex = 14
langRow.Parent = sLang

local langLbl = Instance.new("TextLabel")
langLbl.BackgroundTransparency = 1
langLbl.Position = UDim2.fromOffset(0, 8)
langLbl.Size = UDim2.new(0, 160, 0, 20)
langLbl.Font = t4.mid
langLbl.TextColor3 = t3.text
langLbl.TextSize = 12
langLbl.TextXAlignment = Enum.TextXAlignment.Left
langLbl.ZIndex = 15
langLbl.Parent = langRow
registerText(langLbl, "Select Language")

local btnKhmer = Instance.new("TextButton")
btnKhmer.Size = UDim2.fromOffset(80, 26)
btnKhmer.Position = UDim2.new(1, -170, 0, 5)
btnKhmer.BackgroundColor3 = currentLang == "Khmer" and t3.accent or t3.fill
btnKhmer.Font = t4.title
btnKhmer.Text = "ភាសាខ្មែរ"
btnKhmer.TextColor3 = currentLang == "Khmer" and t3.ink or t3.text
btnKhmer.TextSize = 11
btnKhmer.AutoButtonColor = false
btnKhmer.ZIndex = 15
btnKhmer.Parent = langRow

local kCorner = Instance.new("UICorner")
kCorner.CornerRadius = UDim.new(0, 6)
kCorner.Parent = btnKhmer

local btnEnglish = Instance.new("TextButton")
btnEnglish.Size = UDim2.fromOffset(80, 26)
btnEnglish.Position = UDim2.new(1, -80, 0, 5)
btnEnglish.BackgroundColor3 = currentLang == "English" and t3.accent or t3.fill
btnEnglish.Font = t4.title
btnEnglish.Text = "English"
btnEnglish.TextColor3 = currentLang == "English" and t3.ink or t3.text
btnEnglish.TextSize = 11
btnEnglish.AutoButtonColor = false
btnEnglish.ZIndex = 15
btnEnglish.Parent = langRow

local eCorner = Instance.new("UICorner")
eCorner.CornerRadius = UDim.new(0, 6)
eCorner.Parent = btnEnglish

local function setLanguage(lang)
    currentLang = lang
    btnKhmer.BackgroundColor3 = currentLang == "Khmer" and t3.accent or t3.fill
    btnKhmer.TextColor3 = currentLang == "Khmer" and t3.ink or t3.text

    btnEnglish.BackgroundColor3 = currentLang == "English" and t3.accent or t3.fill
    btnEnglish.TextColor3 = currentLang == "English" and t3.ink or t3.text

    refreshAllTranslations()
end

btnKhmer.MouseButton1Click:Connect(function() setLanguage("Khmer") end)
btnEnglish.MouseButton1Click:Connect(function() setLanguage("English") end)

-- About Info Card
local sAbout = addCardSection(pAbout, "Features")
local aboutDesc = Instance.new("TextLabel")
aboutDesc.BackgroundTransparency = 1
aboutDesc.Size = UDim2.new(1, 0, 0, 48)
aboutDesc.Font = t4.body
aboutDesc.TextColor3 = t3.dim
aboutDesc.TextSize = 12
aboutDesc.TextWrapped = true
aboutDesc.TextXAlignment = Enum.TextXAlignment.Left
aboutDesc.ZIndex = 14
aboutDesc.Parent = sAbout
registerText(aboutDesc, "Snatch eggs and bring them to safe zone")

-- Auto Steal Toggles
local sSteal = addCardSection(pAutoSteal, "Auto steal")
addToggle(sSteal, "AutoSteal", "Auto Steal", "Snatch eggs and bring them to safe zone", false)

local sTarget = addCardSection(pAutoSteal, "Targeting")
addToggle(sTarget, "UseRarity", "Egg type filter", "What qualifies", false)
addToggle(sTarget, "UseMutation", "Use mutation filter", "Mutations", false)

-- Plot Toggles
local sPlot = addCardSection(pPlot, "Eggs & pets")
addToggle(sPlot, "AutoPlaceEggs", "Auto place eggs", "Place, hatch eggs, auto sell", false)
addToggle(sPlot, "AutoHatch", "Auto hatch", "Auto hatch", false)

-- Misc Toggles
local sMisc = addCardSection(pMisc, "Eggs on the map")
addToggle(sMisc, "EggESP", "Egg ESP", "Eggs on the map", false)
addToggle(sMisc, "BatAura", "Bat aura", "Bat", false)
addToggle(sMisc, "Flight", "Flight", "Flight", false)
addToggle(sMisc, "AntiTrap", "Anti trap", "Defence", false)

-- Initialize Default Tab
u68("Auto Steal")
refreshAllTranslations()

print("[AKIRA SCRIPT HUB] Successfully Loaded Premium Version 2.0!")
