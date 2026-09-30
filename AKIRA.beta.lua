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

    local v18 = os.clock() + 15
    while LocalPlayer and v18 > os.clock() do
        local v20, v21
        do
            local Character = LocalPlayer.Character
            v20 = Character and Character:FindFirstChildOfClass("Humanoid")
            v21 = Character and Character:FindFirstChild("HumanoidRootPart")
        end

        if v20 and v21 and v20.Health > 0 then
            break
        end
        task.wait(0.1)
    end
end

-- ==================== CONFIGURATION ====================
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
    Changelog = "UI Style ថ្មី, បន្ថែម Logo ID និងប្រព័ន្ធប្តូរភាសា",
    Author = "AKIRA SCRIPT HUB",
    Credits = "អរគុណសមាជិកទាំងអស់ដែលគាំទ្រ",
    Support = "អរគុណសម្រាប់ការគាំទ្ររបស់អ្នក!"
}

local CUSTOM_LOGO_ID = "rbxassetid://97330468088484"
local currentLang = "Khmer"
local textRegistry = {}

local khMap = {
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
    ["Features"] = "មុខងារ",
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
    ["Select language"] = "ជ្រើសរើសភាសា",
    ["Filter this page"] = "ស្វែងរកមុខងារ...",
    ["AutoSteal"] = "លួចស្វ័យប្រវត្តិ",
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
    ["Show my Roblox name and headshot"] = "បង្ហាញឈ្មោះ Roblox និងរូប Profile",
    ["Let exported configs carry the URL"] = "អនុញ្ញាតឲ្យ Config ដែល Export មាន URL",
    ["Phone layout"] = "ប្លង់ទូរស័ព្ទ",
    ["UI scale"] = "ទំហំ UI",
    ["Theme"] = "Theme",
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
    ["Hop"] = "ប្តូរ",
    ["Lowest"] = "តិចបំផុត",
    ["Highest"] = "ច្រើនបំផុត",
    ["Common"] = "ធម្មតា",
    ["Uncommon"] = "មិនសូវធម្មតា",
    ["Rare"] = "កម្រ",
    ["Epic"] = "កម្រខ្លាំង",
    ["Legendary"] = "រឿងព្រេង",
    ["Mythic"] = "Mythic",
    ["Cosmic"] = "Cosmic",
    ["Secret"] = "សម្ងាត់",
    ["Eternal"] = "អមតៈ",
    ["Divine"] = "ទេវៈ",
    ["Titan"] = "Titan",
    ["Golden"] = "មាស",
    ["Rainbow"] = "ឥន្ទធនូ",
    ["Galaxy"] = "កាឡាក់ស៊ី",
    ["Crystal"] = "គ្រីស្តាល់",
    ["Bloom"] = "ផ្ការីក",
    ["Forest"] = "ព្រៃ",
    ["Desert"] = "វាលខ្សាច់",
    ["Lake"] = "បឹង",
    ["Jungle"] = "ព្រៃជ្រៅ",
    ["Snow"] = "ព្រិល",
    ["Volcano"] = "ភ្នំភ្លើង",
    ["Prehistoric"] = "សម័យបុរេប្រវត្តិ",
    ["Abyss Ocean"] = "មហាសមុទ្រជ្រៅ",
    ["Cherry Blossom"] = "ផ្កាសាគូរ៉ា",
    ["No ping"] = "មិន Ping",
    ["Here"] = "ទីនេះ",
    ["default"] = "លំនាំដើម",
    ["Dark"] = "ងងឹត",
    ["Light"] = "ភ្លឺ",
    ["Snatch eggs and bring them to safe zone"] = "យកស៊ុត ហើយនាំទៅតំបន់សុវត្ថិភាព",
    ["Place, hatch eggs, auto sell"] = "ដាក់ស៊ុត ញាស់ស៊ុត និងលក់ស្វ័យប្រវត្តិ",
    ["Idle, time, or night spawn — Auto hop only leaves if one of those boxes has a number"] = "ទំនេរ ពេលវេលា ឬ Night Spawn — Auto Hop នឹងចាកចេញតែពេលមានលេខកំណត់",
    ["ESP, stats, index claim, anti trap / ragdoll, bat aura, flight, bypass speed, optimizer"] = "ESP, ស្ថិតិ, ទាមទារ Index, ការពារ Trap/Ragdoll, Bat Aura, ហោះហើរ, Bypass Speed និង Optimizer",
    ["Discord embeds with the pet/egg icon on steal, hatch, and sell"] = "Discord Embed ជាមួយរូបសត្វ/ស៊ុតពេលលួច ញាស់ និងលក់",
    ["Hover icon to display stats"] = "ដាក់ Mouse លើ Icon ដើម្បីបង្ហាញស្ថិតិ"
}

local function tr(text)
    if not text then return "" end
    local s = tostring(text)
    if currentLang == "Khmer" then
        return khMap[s] or s
    end
    return s
end

local function regText(instance, originalText, prop)
    if not instance then return end
    prop = prop or "Text"
    table.insert(textRegistry, { inst = instance, key = originalText, prop = prop })
    instance[prop] = tr(originalText)
end

local function v26(p1)
    local v328 = tostring(p1 or "Game"):gsub("[<>:\"/\\|?*]", "_"):gsub("%s+", "_"):gsub("_+", "_"):match("^%s*(.-)%s*$")
    if not v328 or v328 == "" or v328 == "_" then
        v328 = "Game"
    end
    return v328
end

local n1 = 640
local n2 = 450
local n3 = 160

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService, Stats, ProximityPromptService, ReplicatedStorage, LocalPlayer, v40, v41, u42, u43, u44, str, v48, v49, v50, v51, t2
local t3, t4, t5, t6, t7, t9, t10, t11, t12, u66, u67, u68, u69, u70, u71, t14
local v73, self, v82, v83, v84, v85, v86, v87, v98, v103, v108, v113, v151, v194
local v199, v217, v228, v229, v245, v250, v259, v261, v262, v263, u265, u266, v268, v270, v272, v274
local v277, v278, v279, v280, v281, v282, u284, v287, v288, v289, v290, v291, v292, v293
local v306

do
    local t8, t13, v81
    do
        local t26, v94
        do
            local TweenService = game:GetService("TweenService")
            HttpService = game:GetService("HttpService")
            Stats = game:GetService("Stats")
            ProximityPromptService = game:GetService("ProximityPromptService")
            ReplicatedStorage = game:GetService("ReplicatedStorage")
            local GuiService = game:GetService("GuiService")

            LocalPlayer = Players.LocalPlayer
            if not LocalPlayer then
                pcall(function()
                    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
                end)
                LocalPlayer = Players.LocalPlayer
            end

            function v40()
                if UserInputService.VREnabled then return false end
                local u338 = false
                pcall(function() u338 = GuiService:IsTenFootInterface() end)
                if u338 then return false end
                if UserInputService.TouchEnabled then return true end
                if UserInputService.MouseEnabled == false then return true end
                local u339 = false
                local u340 = false
                pcall(function() u339 = UserInputService.GyroscopeEnabled == true end)
                pcall(function() u340 = UserInputService.AccelerometerEnabled == true end)
                if u339 or u340 then return true end
                local PreferredInput, LastInputType
                pcall(function() PreferredInput = UserInputService.PreferredInput end)
                pcall(function() LastInputType = UserInputService:GetLastInputType() end)
                if PreferredInput == Enum.PreferredInput.Touch or LastInputType == Enum.UserInputType.Touch then
                    return true
                end
                local v343 = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
                if v343 and (v343:FindFirstChild("TouchGui", true) or v343:FindFirstChild("TouchControlFrame", true) or v343:FindFirstChild("JumpButton", true) or v343:FindFirstChild("DynamicThumbstickFrame", true)) then
                    return true
                end
                return false
            end

            function v41()
                local CurrentCamera = workspace.CurrentCamera
                local v345 = if not CurrentCamera then Vector2.new(1280, 720) else CurrentCamera.ViewportSize
                local v346 = math.floor(math.clamp(v345.X * 0.72, 440, 580))
                local v347 = math.floor(math.clamp(v345.Y * 0.76, 340, 430))
                if v345.X > 80 then v346 = math.min(v346, v345.X - 36) end
                if v345.Y > 80 then v347 = math.min(v347, v345.Y - 36) end
                return math.max(400, v346), math.max(320, v347)
            end

            u42 = v40()
            u43 = false
            u44 = nil

            if u42 then
                local v45, v46 = v41()
                n1 = v45
                n2 = v46
                n3 = 135
            end

            str = tostring(LocalPlayer and LocalPlayer.UserId or 0)
            v48 = "AKIRA_UI_" .. str
            v49 = "AKIRA_WorldGui_" .. str

            function v50()
                return getgenv and getgenv() or _G
            end

            function v51()
                local v350 = getgenv and getgenv() or _G
                local KiraHub = v350.KiraHub
                if type(KiraHub) ~= "table" then
                    KiraHub = { slots = {} }
                    v350.KiraHub = KiraHub
                end
                if type(KiraHub.slots) ~= "table" then KiraHub.slots = {} end
                local v352 = KiraHub.slots[str]
                if type(v352) ~= "table" then
                    v352 = {}
                    KiraHub.slots[str] = v352
                end
                return v352
            end

            t1.ConfigFile = (("Kira" .. "/" .. v26(t1.Game)) .. "/cache") .. "/" .. v26(LocalPlayer and LocalPlayer.Name or "Player") .. "-config.json"

            -- New Premium UI Style Palette
            t2 = {
                Dark = {
                    bg = Color3.fromRGB(13, 15, 22),
                    rail = Color3.fromRGB(18, 21, 31),
                    card = Color3.fromRGB(24, 28, 42),
                    lift = Color3.fromRGB(32, 38, 56),
                    fill = Color3.fromRGB(38, 46, 68),
                    line = Color3.fromRGB(50, 60, 88),
                    text = Color3.fromRGB(245, 248, 255),
                    dim = Color3.fromRGB(155, 170, 200),
                    mute = Color3.fromRGB(100, 115, 145),
                    accent = Color3.fromRGB(0, 215, 255),
                    accentDeep = Color3.fromRGB(0, 110, 160),
                    accentHover = Color3.fromRGB(60, 230, 255),
                    ink = Color3.fromRGB(10, 12, 18),
                    ok = Color3.fromRGB(60, 225, 140),
                    Kira = Color3.fromRGB(245, 248, 255)
                },
                Light = {
                    bg = Color3.fromRGB(242, 245, 252),
                    rail = Color3.fromRGB(232, 236, 246),
                    card = Color3.fromRGB(255, 255, 255),
                    lift = Color3.fromRGB(240, 244, 252),
                    fill = Color3.fromRGB(222, 228, 242),
                    line = Color3.fromRGB(202, 212, 232),
                    text = Color3.fromRGB(18, 24, 38),
                    dim = Color3.fromRGB(85, 100, 128),
                    mute = Color3.fromRGB(130, 145, 172),
                    accent = Color3.fromRGB(0, 150, 230),
                    accentDeep = Color3.fromRGB(0, 100, 160),
                    accentHover = Color3.fromRGB(30, 175, 255),
                    ink = Color3.fromRGB(255, 255, 255),
                    ok = Color3.fromRGB(40, 180, 105),
                    Kira = Color3.fromRGB(18, 24, 38)
                }
            }

            t3 = {}
            for k, v in pairs(t2.Dark) do t3[k] = v end

            t4 = {
                title = Enum.Font.GothamBold,
                mid = Enum.Font.GothamMedium,
                body = Enum.Font.Gotham,
                mono = Enum.Font.RobotoMono
            }

            t5 = {"Forest", "Desert", "Lake", "Jungle", "Snow", "Volcano", "Prehistoric", "Cosmic", "Abyss Ocean", "Cherry Blossom"}
            t6 = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Cosmic", "Secret", "Eternal", "Divine", "Titan"}
            t7 = {"Golden", "Rainbow", "Galaxy", "Crystal", "Bloom"}
            t8 = {
                About = "info",
                ["Auto Steal"] = "egg",
                Plot = "grid",
                Serverhop = "rocket",
                Misc = "layers",
                Webhook = "out",
                Settings = "cog"
            }

            t9 = {}
            t10 = {}
            t11 = {}
            t12 = {}
            t13 = {}
            u66 = nil; u67 = nil; u68 = nil; u69 = nil; u70 = nil; u71 = nil
            t14 = {}

            function v73(p2)
                if p2 then t14[#t14 + 1] = p2 end
                return p2
            end

            self = setmetatable({}, { __mode = "k" })

            function v81(p5, p6, p7, p8)
                local v379 = self[p5]
                if v379 then pcall(function() v379:Cancel() end) end
                local tween = TweenService:Create(p5, TweenInfo.new(p6, p8 or Enum.EasingStyle.Quart, Enum.EasingDirection.Out), p7)
                self[p5] = tween
                tween:Play()
                tween.Completed:Connect(function()
                    if self[p5] == tween then self[p5] = nil end
                end)
            end

            function v82(p9, p10, p11)
                local v384 = Instance.new(p9)
                if p10 then
                    for k, v in pairs(p10) do v384[k] = v end
                end
                if p11 then v384.Parent = p11 end
                return v384
            end

            function v83(p12, p13, p14)
                local v396, v397
                if type(p13) == "string" then
                    v396 = p13
                    v397 = t3[p13] or t3.line
                else
                    v397 = p13 or t3.line
                end
                local UIStroke = Instance.new("UIStroke")
                UIStroke.Color = v397
                UIStroke.Thickness = p14 or 1
                UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                if p12 then UIStroke.Parent = p12 end
                if v396 then UIStroke:SetAttribute("th_stroke", v396) end
                return UIStroke
            end

            function v84(p15, p16, p17, p18, p19)
                if p17 == nil then
                    p17 = p16; p18 = p16; p19 = p16
                end
                local UIPadding = Instance.new("UIPadding")
                UIPadding.PaddingLeft = UDim.new(0, p16)
                UIPadding.PaddingTop = UDim.new(0, p17)
                UIPadding.PaddingRight = UDim.new(0, p18 or p16)
                UIPadding.PaddingBottom = UDim.new(0, p19 or p17)
                if p15 then UIPadding.Parent = p15 end
                return UIPadding
            end

            function v85(p20, p21, p22)
                if type(p21) == "string" then
                    if p20 and p21 then
                        p20:SetAttribute("th_bg", p21)
                        local v418 = t3[p21]
                        if v418 and p20:IsA("GuiObject") then p20.BackgroundColor3 = v418 end
                    end
                    p20:SetAttribute("th_hover", p22)
                end
                p20.MouseEnter:Connect(function()
                    if p20:GetAttribute("locked") then return end
                    p20:SetAttribute("th_over", true)
                    local v1246 = p20:GetAttribute("th_hover") or p22
                    local v1247 = type(v1246) == "string" and t3[v1246] or v1246
                    if v1247 then v81(p20, 0.12, { BackgroundColor3 = v1247 }) end
                end)
                p20.MouseLeave:Connect(function()
                    if p20:GetAttribute("locked") then return end
                    p20:SetAttribute("th_over", false)
                    local v1248 = p20:GetAttribute("th_bg") or p21
                    local v1249 = type(v1248) == "string" and t3[v1248] or v1248
                    if v1249 then v81(p20, 0.12, { BackgroundColor3 = v1249 }) end
                end)
            end

            function v86(p23, p24, p25, p26)
                local Frame = Instance.new("Frame")
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.fromOffset(16, 16)
                Frame.ZIndex = p26
                if p23 then Frame.Parent = p23 end

                local function v428(p27, p28, p29, p30, p31)
                    local Frame2 = Instance.new("Frame")
                    Frame2.BackgroundColor3 = p25
                    Frame2.BorderSizePixel = 0
                    Frame2.Position = UDim2.fromOffset(p27, p28)
                    Frame2.Size = UDim2.fromOffset(p29, p30)
                    Frame2.ZIndex = p26 + 1
                    Frame2.Parent = Frame
                    if p31 then
                        local UICorner = Instance.new("UICorner")
                        UICorner.CornerRadius = UDim.new(0, p31 or 8)
                        UICorner.Parent = Frame2
                    end
                    return Frame2
                end

                local function v429(p32, p33, p34, p35, p36)
                    local Frame3 = Instance.new("Frame")
                    Frame3.BackgroundTransparency = 1
                    Frame3.Position = UDim2.fromOffset(p32, p33)
                    Frame3.Size = UDim2.fromOffset(p34, p35)
                    Frame3.ZIndex = p26 + 1
                    Frame3.Parent = Frame
                    local UICorner = Instance.new("UICorner")
                    UICorner.CornerRadius = UDim.new(0, p36 or 8)
                    UICorner.Parent = Frame3
                    v83(Frame3, p25, 1.2)
                    return Frame3
                end

                if p24 == "egg" then
                    v428(4, 2, 8, 12, 5)
                    return Frame
                elseif p24 == "aim" then
                    v429(2, 2, 12, 12, 6)
                    v428(7, 7, 2, 2, 1); v428(7, 0, 2, 3, 0); v428(7, 13, 2, 3, 0)
                    v428(0, 7, 3, 2, 0); v428(13, 7, 3, 2, 0)
                    return Frame
                elseif p24 == "grid" then
                    v428(1, 1, 6, 6, 2); v428(9, 1, 6, 6, 2)
                    v428(1, 9, 6, 6, 2); v428(9, 9, 6, 6, 2)
                    return Frame
                elseif p24 == "layers" then
                    v428(2, 3, 12, 2, 1); v428(2, 7, 12, 2, 1); v428(2, 11, 12, 2, 1)
                    return Frame
                elseif p24 == "out" then
                    v429(1, 3, 10, 10, 3); v428(8, 2, 6, 2, 1); v428(12, 2, 2, 6, 1)
                    return Frame
                elseif p24 == "cog" then
                    v429(3, 3, 10, 10, 5)
                    v428(7, 1, 2, 3, 1); v428(7, 12, 2, 3, 1)
                    v428(1, 7, 3, 2, 1); v428(12, 7, 3, 2, 1)
                    return Frame
                elseif p24 == "rocket" then
                    v428(6, 1, 4, 9, 2); v428(7, 0, 2, 3, 1)
                    v428(4, 8, 3, 4, 1); v428(9, 8, 3, 4, 1); v428(7, 11, 2, 4, 1)
                    return Frame
                elseif p24 == "search" then
                    v429(1, 1, 10, 10, 5)
                    v428(9, 10, 5, 2, 1).Rotation = 40
                    return Frame
                elseif p24 == "info" then
                    v429(2, 2, 12, 12, 6); v428(7, 4, 2, 2, 1); v428(7, 7, 2, 5, 1)
                end
                return Frame
            end

            -- Logo Loader using Asset ID 97330468088484
            function v87(p37, p38, p39)
                local size = p39 or 24
                local Frame = Instance.new("Frame")
                Frame.Name = "AkiraLogo"
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.fromOffset(size, size)
                Frame.ZIndex = p38 or 15
                if p37 then Frame.Parent = p37 end

                local ImageLabel = Instance.new("ImageLabel")
                ImageLabel.Name = "Mark"
                ImageLabel.BackgroundTransparency = 1
                ImageLabel.Size = UDim2.fromScale(1, 1)
                ImageLabel.Image = CUSTOM_LOGO_ID
                ImageLabel.ScaleType = Enum.ScaleType.Fit
                ImageLabel.ZIndex = (p38 or 15) + 1
                ImageLabel.Parent = Frame

                local UICorner = Instance.new("UICorner")
                UICorner.CornerRadius = UDim.new(0, 6)
                UICorner.Parent = ImageLabel

                return Frame
            end

            -- Safe GUI Parent function to prevent script death on mobile executors
            local function v88()
                if gethui then
                    local ok, result = pcall(gethui)
                    if ok and result then return result end
                end
                local CoreGui = game:GetService("CoreGui")
                local canUseCore = false
                pcall(function()
                    local t = Instance.new("Folder")
                    t.Parent = CoreGui
                    t:Destroy()
                    canUseCore = true
                end)
                if canUseCore then return CoreGui end
                return LocalPlayer:WaitForChild("PlayerGui")
            end

            local v89 = v88()
            local v90 = v89:FindFirstChild(v48)
            if v90 then v90:Destroy() end

            t26 = {
                Name = v48,
                ResetOnSpawn = false,
                IgnoreGuiInset = true,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                DisplayOrder = 1200
            }
            v94 = v88()
        end

        local ScreenGui = Instance.new("ScreenGui")
        for k, v in pairs(t26) do ScreenGui[k] = v end
        ScreenGui.Parent = v94
        v98 = ScreenGui

        pcall(function()
            if syn and syn.protect_gui then syn.protect_gui(v98) end
        end)

        v103 = Instance.new("TextButton")
        v103.Name = "Overlay"
        v103.BackgroundTransparency = 1
        v103.Text = ""
        v103.AutoButtonColor = false
        v103.Size = UDim2.fromScale(1, 1)
        v103.Visible = false
        v103.ZIndex = 80
        v103.Parent = v98

        v108 = Instance.new("UIScale")
        v108.Scale = 1

        v113 = Instance.new("Frame")
        v113.Name = "Window"
        v113.AnchorPoint = Vector2.new(0.5, 0.5)
        v113.Position = UDim2.fromScale(0.5, 0.5)
        v113.Size = UDim2.fromOffset(n1, n2)
        v113.BackgroundColor3 = t3.bg
        v113.BorderSizePixel = 0
        v113.ClipsDescendants = false
        v113.ZIndex = 10
        v113.Visible = true
        v113.Parent = v98
    end

    do
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 16)
        UICorner.Parent = v113

        local UIStroke = Instance.new("UIStroke")
        UIStroke.Color = t3.line
        UIStroke.Thickness = 1.5
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        UIStroke.Parent = v113
        UIStroke:SetAttribute("th_stroke", "line")

        v108.Parent = v113
        v113:SetAttribute("th_bg", "bg")

        local Shadow = Instance.new("Frame")
        Shadow.Name = "Shadow"
        Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Shadow.BackgroundTransparency = 0.6
        Shadow.Position = UDim2.fromOffset(0, 14)
        Shadow.Size = UDim2.new(1, 0, 1, 0)
        Shadow.ZIndex = 9
        Shadow.BorderSizePixel = 0
        Shadow.Parent = v113

        local UICorner2 = Instance.new("UICorner")
        UICorner2.CornerRadius = UDim.new(0, 18)
        UICorner2.Parent = Shadow
    end

    do
        local HeadBar = Instance.new("Frame")
        HeadBar.Name = "HeadBar"
        HeadBar.BackgroundColor3 = t3.rail
        HeadBar.BorderSizePixel = 0
        HeadBar.Size = UDim2.new(1, 0, 0, 56)
        HeadBar.ZIndex = 11
        HeadBar.Parent = v113
        HeadBar:SetAttribute("th_bg", "rail")

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 16)
        UICorner.Parent = HeadBar

        local Frame5 = Instance.new("Frame")
        Frame5.Name = "Rail"
        Frame5.BackgroundColor3 = t3.rail
        Frame5.BorderSizePixel = 0
        Frame5.Size = UDim2.new(0, n3, 1, 0)
        Frame5.ZIndex = 11
        Frame5.Parent = v113
        v151 = Frame5
        v151:SetAttribute("th_bg", "rail")

        local UICorner3 = Instance.new("UICorner")
        UICorner3.CornerRadius = UDim.new(0, 16)
        UICorner3.Parent = v151
    end

    local v171, v204, v210
    do
        local Frame, TextLabel
        do
            local Frame7 = Instance.new("Frame")
            Frame7.BackgroundColor3 = t3.line
            Frame7.BorderSizePixel = 0
            Frame7.Position = UDim2.new(1, -1, 0, 2)
            Frame7.Size = UDim2.new(0, 1, 1, -2)
            Frame7.ZIndex = 12
            Frame7.Parent = v151
            Frame7:SetAttribute("th_bg", "line")

            v151.Active = true

            local ScrollingFrame = Instance.new("ScrollingFrame")
            ScrollingFrame.BackgroundTransparency = 1
            ScrollingFrame.Size = UDim2.new(1, 0, 1, -18)
            ScrollingFrame.Position = UDim2.fromOffset(0, 12)
            ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
            ScrollingFrame.ScrollBarThickness = not u42 and 0 or 4
            ScrollingFrame.BorderSizePixel = 0
            ScrollingFrame.ZIndex = 12
            ScrollingFrame.Parent = v151
            v171 = ScrollingFrame
            v84(v171, 10, 2, 10, 12)

            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.FillDirection = Enum.FillDirection.Vertical
            UIListLayout.Padding = UDim.new(0, 4)
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Parent = v171

            Frame = Instance.new("Frame")
            Frame.BackgroundTransparency = 1
            Frame.Size = UDim2.new(1, 0, 0, 46)
            Frame.LayoutOrder = 0
            Frame.ZIndex = 12
            Frame.Parent = v171

            v87(Frame, 13, 30).Position = UDim2.fromOffset(0, 2)

            TextLabel = Instance.new("TextLabel")
            TextLabel.BackgroundTransparency = 1
            TextLabel.Position = UDim2.fromOffset(36, 4)
            TextLabel.Size = UDim2.new(1, -36, 0, 16)
            TextLabel.Font = t4.title
            TextLabel.Text = t1.Title
            TextLabel.TextColor3 = t3.text
            TextLabel.TextSize = 13
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
            TextLabel.ZIndex = 13
            TextLabel.Parent = Frame
            TextLabel:SetAttribute("th_text", "text")
        end

        local TextLabel2 = Instance.new("TextLabel")
        TextLabel2.BackgroundTransparency = 1
        TextLabel2.Position = UDim2.fromOffset(36, 22)
        TextLabel2.Size = UDim2.new(1, -36, 0, 12)
        TextLabel2.Font = t4.mono
        TextLabel2.Text = t1.Product
        TextLabel2.TextColor3 = t3.accent
        TextLabel2.TextSize = 9
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel2.ZIndex = 13
        TextLabel2.Parent = Frame
        TextLabel2:SetAttribute("th_text", "accent")

        local Frame8 = Instance.new("Frame")
        Frame8.Name = "Main"
        Frame8.BackgroundTransparency = 1
        Frame8.Position = UDim2.fromOffset(n3, 2)
        Frame8.Size = UDim2.new(1, -n3, 1, -2)
        Frame8.ZIndex = 11
        Frame8.Parent = v113
        v194 = Frame8

        local Frame9 = Instance.new("Frame")
        Frame9.Name = "Header"
        Frame9.BackgroundTransparency = 1
        Frame9.Size = UDim2.new(1, 0, 0, 46)
        Frame9.ZIndex = 12
        Frame9.Active = true
        Frame9.Parent = v194
        v199 = Frame9

        v204 = Instance.new("TextLabel")
        v204.BackgroundTransparency = 1
        v204.Position = UDim2.fromOffset(16, 8)
        v204.Size = UDim2.new(1, -190, 0, 18)
        v204.Font = t4.title
        v204.TextColor3 = t3.text
        v204.TextSize = 16
        v204.TextXAlignment = Enum.TextXAlignment.Left
        v204.ZIndex = 12
        v204.Parent = v199
        v204:SetAttribute("th_text", "text")
        regText(v204, "Auto Steal")

        v210 = Instance.new("TextLabel")
        v210.BackgroundTransparency = 1
        v210.Position = UDim2.fromOffset(16, 26)
        v210.Size = UDim2.new(1, -190, 0, 14)
        v210.Font = t4.body
        v210.TextColor3 = t3.dim
        v210.TextSize = 11
        v210.TextXAlignment = Enum.TextXAlignment.Left
        v210.ZIndex = 12
        v210.Parent = v199
        v210:SetAttribute("th_text", "dim")
        regText(v210, "targeting, filters, travel")
    end

    local Frame, UIStroke
    do
        local function v212(p40, p41)
            local TextLabel = Instance.new("TextLabel")
            TextLabel.AnchorPoint = Vector2.new(1, 0.5)
            TextLabel.BackgroundColor3 = t3.card
            TextLabel.Position = UDim2.new(1, p41, 0.5, 2)
            TextLabel.Size = UDim2.fromOffset(p40, 22)
            TextLabel.Font = t4.mono
            TextLabel.Text = "—"
            TextLabel.TextColor3 = t3.dim
            TextLabel.TextSize = 10
            TextLabel.ZIndex = 12
            TextLabel.Parent = v199

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 7)
            UICorner.Parent = TextLabel

            local UIStroke2 = Instance.new("UIStroke")
            UIStroke2.Color = t3.line
            UIStroke2.Thickness = 1
            UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            UIStroke2.Parent = TextLabel
            UIStroke2:SetAttribute("th_stroke", "line")

            TextLabel:SetAttribute("th_bg", "card")
            TextLabel:SetAttribute("th_text", "dim")
            return TextLabel
        end

        v217 = Instance.new("TextButton")
        v217.AnchorPoint = Vector2.new(1, 0.5)
        v217.BackgroundColor3 = t3.card
        v217.Position = UDim2.new(1, -12, 0.5, 2)
        v217.Size = UDim2.fromOffset(not u42 and 24 or 32, not u42 and 24 or 32)
        v217.Font = t4.mid
        v217.Text = "–"
        v217.TextColor3 = t3.dim
        v217.TextSize = 14
        v217.AutoButtonColor = false
        v217.ZIndex = 12
        v217.Parent = v199

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = v217

        local UIStroke3 = Instance.new("UIStroke")
        UIStroke3.Color = t3.line
        UIStroke3.Thickness = 1
        UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        UIStroke3.Parent = v217
        UIStroke3:SetAttribute("th_stroke", "line")

        v85(v217, "card", "lift")
        v217:SetAttribute("th_text", "dim")

        v228 = v212(52, -54)
        v229 = v212(56, -110)

        Frame = Instance.new("Frame")
        Frame.BackgroundColor3 = t3.card
        Frame.Position = UDim2.fromOffset(14, 46)
        Frame.Size = UDim2.new(1, -28, 0, not u42 and 28 or 36)
        Frame.ZIndex = 12
        Frame.Parent = v194

        local UICorner4 = Instance.new("UICorner")
        UICorner4.CornerRadius = UDim.new(0, 9)
        UICorner4.Parent = Frame
        Frame:SetAttribute("th_bg", "card")

        UIStroke = Instance.new("UIStroke")
        UIStroke.Color = t3.line
        UIStroke.Thickness = 1
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        UIStroke.Parent = Frame
        UIStroke:SetAttribute("th_stroke", "line")
    end

    local v244 = UIStroke
    v245 = v86(Frame, "search", t3.mute, 13)
    v245.Position = UDim2.fromOffset(8, 6)

    v250 = Instance.new("TextBox")
    v250.BackgroundTransparency = 1
    v250.Size = UDim2.new(1, -40, 1, 0)
    v250.Position = UDim2.fromOffset(30, 0)
    v250.Font = t4.body
    v250.PlaceholderColor3 = t3.mute
    v250.Text = ""
    v250.TextColor3 = t3.text
    v250.TextSize = not u42 and 12 or 14
    v250.TextXAlignment = Enum.TextXAlignment.Left
    v250.ClearTextOnFocus = false
    v250.ZIndex = 13
    v250.Parent = Frame
    v250:SetAttribute("th_text", "text")
    v250:SetAttribute("th_placeholder", "mute")
    regText(v250, "Filter this page", "PlaceholderText")

    v250.Focused:Connect(function() v81(v244, 0.12, { Color = t3.accent }) end)
    v250.FocusLost:Connect(function() v81(v244, 0.12, { Color = t3.line }) end)

    local v253 = not u42 and 82 or 90
    local Frame10 = Instance.new("Frame")
    Frame10.BackgroundTransparency = 1
    Frame10.Position = UDim2.fromOffset(0, v253)
    Frame10.Size = UDim2.new(1, 0, 1, -v253)
    Frame10.ClipsDescendants = true
    Frame10.ZIndex = 12
    Frame10.Parent = v194

    local v258 = Frame10

    function v259(p42, p43)
        local ScrollingFrame = Instance.new("ScrollingFrame")
        ScrollingFrame.Name = p42
        ScrollingFrame.BackgroundTransparency = 1
        ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        ScrollingFrame.ScrollBarThickness = not u42 and 4 or 6
        ScrollingFrame.ScrollBarImageColor3 = t3.line
        ScrollingFrame.BorderSizePixel = 0
        ScrollingFrame.Visible = false
        ScrollingFrame.ZIndex = 13
        ScrollingFrame.Parent = v258
        ScrollingFrame:SetAttribute("th_scroll", "line")

        v84(ScrollingFrame, 12, 4, 12, 14)

        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.FillDirection = Enum.FillDirection.Vertical
        UIListLayout.Padding = UDim.new(0, 8)
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Parent = ScrollingFrame

        local t63 = {
            name = p42,
            subtitle = p43,
            scroll = ScrollingFrame,
            items = {},
            n = 0,
            card = nil,
            lastRule = nil
        }
        t12[p42] = t63
        t13[#t13 + 1] = p42
        return t63
    end

    local t64 = {}

    function v261(p44, p45, p46)
        local TextLabel = Instance.new("TextLabel")
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(1, 0, 0, 18)
        TextLabel.Font = t4.mono
        TextLabel.TextColor3 = t3.mute
        TextLabel.TextSize = 9
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.LayoutOrder = p46
        TextLabel.ZIndex = 12
        TextLabel.Parent = v171
        TextLabel:SetAttribute("th_text", "mute")
        regText(TextLabel, p44)

        for i, v in ipairs(p45) do
            local TextButton = Instance.new("TextButton")
            TextButton.BackgroundColor3 = t3.rail
            TextButton.BackgroundTransparency = 1
            TextButton.Size = UDim2.new(1, 0, 0, not u42 and 28 or 34)
            TextButton.Text = ""
            TextButton.AutoButtonColor = false
            TextButton.LayoutOrder = p46 + i
            TextButton.ZIndex = 12
            TextButton.Parent = v171

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 8)
            UICorner.Parent = TextButton

            local v498 = v86(TextButton, t8[v] or "layers", t3.mute, 13)
            v498.Name = "Ico"
            v498.Position = UDim2.fromOffset(8, 6)

            local TextLabel5 = Instance.new("TextLabel")
            TextLabel5.BackgroundTransparency = 1
            TextLabel5.Position = UDim2.fromOffset(30, 0)
            TextLabel5.Size = UDim2.new(1, -34, 1, 0)
            TextLabel5.Font = t4.body
            TextLabel5.TextColor3 = t3.dim
            TextLabel5.TextSize = 12
            TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel5.ZIndex = 13
            TextLabel5.Parent = TextButton
            TextLabel5:SetAttribute("th_text", "dim")
            regText(TextLabel5, v)

            t64[v] = {
                btn = TextButton,
                lab = TextLabel5,
                ico = v498
            }

            TextButton.MouseEnter:Connect(function()
                if t64[v].on then return end
                v81(TextButton, 0.12, { BackgroundTransparency = 0, BackgroundColor3 = t3.lift })
            end)
            TextButton.MouseLeave:Connect(function()
                if t64[v].on then return end
                v81(TextButton, 0.12, { BackgroundTransparency = 1 })
            end)
            TextButton.MouseButton1Click:Connect(function()
                u68(v)
            end)
        end
    end

    function v262(p47, p48)
        for _, descendant in ipairs(p47:GetDescendants()) do
            if descendant:IsA("ImageLabel") then
                descendant.ImageColor3 = p48
            elseif descendant:IsA("Frame") and descendant.BackgroundTransparency < 1 then
                descendant.BackgroundColor3 = p48
            elseif descendant:IsA("UIStroke") then
                descendant.Color = p48
            end
        end
    end

    function u68(p49)
        local v509 = t12[p49]
        if not v509 then return end
        u66 = v509

        for k, v in pairs(t64) do
            local v512 = k == p49
            v.on = v512
            v.lab.TextColor3 = v512 and t3.text or t3.dim
            v.lab.Font = v512 and t4.mid or t4.body
            v.btn.BackgroundColor3 = v512 and t3.card or t3.rail
            v.btn.BackgroundTransparency = not v512 and 1 or 0
            v262(v.ico, v512 and t3.accent or t3.mute)
        end

        for _, v in pairs(t12) do
            v.scroll.Visible = v == v509
            if v == v509 then v.scroll.CanvasPosition = Vector2.zero end
        end

        v204.Text = tr(p49)
        v210.Text = tr(v509.subtitle or "")
        u69(v509, v250.Text)
    end

    function u69(p50, p51)
        local v517 = string.lower(p51 or "")
        local inst
        local v519 = false
        for _, v in ipairs(p50.items) do
            if v.kind == "section" then
                if inst then inst.Visible = v517 == "" or v519 end
                inst = v.inst
                v519 = false
            else
                local v522 = (v517 == "" or string.find(v.q, v517, 1, true) ~= nil) and (not v.visibleIf or v.visibleIf() or false)
                v.inst.Visible = v522
                if v522 then v519 = true end
            end
        end
        if inst then inst.Visible = v517 == "" or v519 end
    end

    v250:GetPropertyChangedSignal("Text"):Connect(function()
        if u66 then u69(u66, v250.Text) end
    end)

    function v263(p52, p53)
        p52.lastRule = nil

        local Frame11 = Instance.new("Frame")
        Frame11.AutomaticSize = Enum.AutomaticSize.Y
        Frame11.Size = UDim2.new(1, 0, 0, 0)
        Frame11.BackgroundColor3 = t3.card
        Frame11.BorderSizePixel = 0
        p52.n = p52.n + 1
        Frame11.LayoutOrder = p52.n
        Frame11.ZIndex = 13
        Frame11.Parent = p52.scroll

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 10)
        UICorner.Parent = Frame11

        local UIStroke4 = Instance.new("UIStroke")
        UIStroke4.Color = t3.line
        UIStroke4.Thickness = 1
        UIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        UIStroke4.Parent = Frame11
        UIStroke4:SetAttribute("th_stroke", "line")
        Frame11:SetAttribute("th_bg", "card")

        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.FillDirection = Enum.FillDirection.Vertical
        UIListLayout.Padding = UDim.new(0, 0)
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Parent = Frame11

        local Frame12 = Instance.new("Frame")
        Frame12.BackgroundTransparency = 1
        Frame12.Size = UDim2.new(1, 0, 0, 28)
        Frame12.LayoutOrder = 0
        Frame12.ZIndex = 14
        Frame12.Parent = Frame11

        local Frame13 = Instance.new("Frame")
        Frame13.BackgroundColor3 = t3.accent
        Frame13.BorderSizePixel = 0
        Frame13.Position = UDim2.fromOffset(12, 13)
        Frame13.Size = UDim2.fromOffset(10, 2)
        Frame13.ZIndex = 15
        Frame13.Parent = Frame12
        Frame13:SetAttribute("th_bg", "accent")

        local TextLabel = Instance.new("TextLabel")
        TextLabel.BackgroundTransparency = 1
        TextLabel.Position = UDim2.fromOffset(28, 0)
        TextLabel.Size = UDim2.new(1, -36, 1, 0)
        TextLabel.Font = t4.mono
        TextLabel.TextColor3 = t3.dim
        TextLabel.TextSize = 10
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.ZIndex = 15
        TextLabel.Parent = Frame12
        TextLabel:SetAttribute("th_text", "dim")
        regText(TextLabel, p53)

        p52.card = Frame11
        p52.items[#p52.items + 1] = {
            kind = "section",
            inst = Frame11,
            q = string.lower(p53)
        }
        return Frame11
    end

    local function v264(p54, p55, p56, p57)
        local v564 = p57 or (not u42 and 132 or 140)
        local v565 = p54.card or p54.scroll
        local v566 = not p56 and 36 or 48
        if u42 then v566 = not p56 and 44 or 56 end

        local Frame14 = Instance.new("Frame")
        Frame14.BackgroundColor3 = t3.card
        Frame14.BackgroundTransparency = 1
        Frame14.Size = UDim2.new(1, 0, 0, v566)
        p54.n = p54.n + 1
        Frame14.LayoutOrder = p54.n
        Frame14.ZIndex = 14
        if v565 then Frame14.Parent = v565 end

        local Frame15 = Instance.new("Frame")
        Frame15.BackgroundColor3 = t3.line
        Frame15.BorderSizePixel = 0
        Frame15.Position = UDim2.new(0, 14, 0, 0)
        Frame15.Size = UDim2.new(1, -28, 0, 1)
        Frame15.Visible = p54.lastRule ~= nil
        Frame15.ZIndex = 15
        Frame15.Parent = Frame14
        p54.lastRule = Frame15
        Frame15:SetAttribute("th_bg", "line")

        Frame14:SetAttribute("th_bg", "card")
        Frame14:SetAttribute("th_hover", "lift")
        Frame14:SetAttribute("th_row", true)

        Frame14.MouseEnter:Connect(function()
            Frame14:SetAttribute("th_over", true)
            v81(Frame14, 0.1, { BackgroundTransparency = 0, BackgroundColor3 = t3.lift })
        end)
        Frame14.MouseLeave:Connect(function()
            Frame14:SetAttribute("th_over", false)
            v81(Frame14, 0.1, { BackgroundTransparency = 1, BackgroundColor3 = t3.card })
        end)

        local TextLabel = Instance.new("TextLabel")
        TextLabel.BackgroundTransparency = 1
        TextLabel.Position = UDim2.fromOffset(12, not p56 and 10 or 6)
        TextLabel.Size = UDim2.new(1, -(v564 + 20), 0, 14)
        TextLabel.Font = t4.mid
        TextLabel.TextColor3 = t3.text
        TextLabel.TextSize = 12
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
        TextLabel.ZIndex = 15
        TextLabel.Parent = Frame14
        TextLabel:SetAttribute("th_text", "text")
        regText(TextLabel, p55)

        local TextLabel7
        if p56 then
            TextLabel7 = Instance.new("TextLabel")
            TextLabel7.BackgroundTransparency = 1
            TextLabel7.Position = UDim2.fromOffset(12, 22)
            TextLabel7.Size = UDim2.new(1, -(v564 + 20), 0, 22)
            TextLabel7.Font = t4.body
            TextLabel7.TextColor3 = t3.dim
            TextLabel7.TextSize = 11
            TextLabel7.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel7.TextYAlignment = Enum.TextYAlignment.Top
            TextLabel7.TextWrapped = true
            TextLabel7.ZIndex = 15
            TextLabel7.Parent = Frame14
            TextLabel7:SetAttribute("th_text", "dim")
            regText(TextLabel7, p56)
        end

        local Frame16 = Instance.new("Frame")
        Frame16.AnchorPoint = Vector2.new(1, 0.5)
        Frame16.BackgroundTransparency = 1
        Frame16.Position = UDim2.new(1, -10, 0.5, 0)
        Frame16.Size = UDim2.fromOffset(v564, not u42 and 26 or 32)
        Frame16.ZIndex = 16
        Frame16.Parent = Frame14

        p54.items[#p54.items + 1] = {
            kind = "row",
            inst = Frame14,
            q = string.lower(p55 .. " " .. (p56 or ""))
        }
        return Frame14, Frame16, TextLabel7
    end

    u265 = false
    u266 = false
    local t81 = { ImportPaste = true, Flight = true, HopNearNight = true, CfgSaveName = true, PhoneUI = true }
    v268 = v51().gen or 1

    local function v269(...) warn("[AKIRA/cfg]", ...) end

    function v270()
        for k, v in pairs(t10) do
            if v and v.kind == "input" and v.box then
                pcall(function()
                    local boxText = v.box.Text
                    if type(boxText) ~= "string" then return end
                    if boxText ~= "" or t9[k] == nil or t9[k] == "" then t9[k] = boxText end
                end)
            end
        end

        local t82 = {}
        for k, v in pairs(t9) do
            if not t81[k] and (k ~= "HookUrl" or t9.ExportUrl) then
                local v597 = type(v)
                if v597 == "boolean" or v597 == "number" or v597 == "string" or v597 == "table" then
                    t82[k] = v
                else
                    local ok, result = pcall(function() return v.Name end)
                    if ok and type(result) == "string" then t82[k] = result end
                end
            end
        end
        return t82
    end

    local function v271(p58, p59)
        if type(p58) ~= "string" or p58 == "" then return false end
        if type(makefolder) == "function" then pcall(makefolder, "Kira") end
        local v602 = "Kira" .. "/" .. v26(t1.Game)
        if type(makefolder) == "function" then pcall(makefolder, v602) end
        local v603 = v602 .. "/cache"
        if type(makefolder) == "function" then pcall(makefolder, v603) end
        local v604 = v602 .. "/configs"
        if type(makefolder) == "function" then pcall(makefolder, v604) end
        local v605 = p58:match("^(.*)/[^/]+$")
        if v605 and type(makefolder) == "function" then pcall(makefolder, v605) end
        local ok, result = pcall(writefile, p58, p59)
        return ok
    end

    function v272(p60)
        if u265 and not p60 then return end
        if not writefile then return end
        local ok, result = pcall(function() return HttpService:JSONEncode(v270()) end)
        if not ok or type(result) ~= "string" then return end
        if not v271((("Kira" .. "/" .. v26(t1.Game)) .. "/cache") .. "/" .. v26(LocalPlayer and LocalPlayer.Name or "Player") .. "-config.json", result) then
            v271((("Kira" .. "/" .. v26(t1.Game)) .. "/cache") .. "/" .. str .. "-config.json", result)
        end
    end

    local function v273(p61, p62)
        local v614 = t10[p61]
        if v614 and (v614.kind == "keybind" and type(p62) == "string") then
            local ok, result = pcall(function() return Enum.KeyCode[p62] end)
            if ok and result then return result end
        end
        if p61 == "Theme" and (p62 == "Dusk" or p62 == "dusk") then return "Dark" end
        return p62
    end

    function v274(p63, p64)
        if type(p63) ~= "table" then return end
        u265 = true
        pcall(function()
            if p63.NeverTraps == true then p63.AntiTrap = true end
            p63.NeverTraps = nil; p63.RarityZones = nil; p63.HopMinPlayers = nil; p63.HopMaxPlayers = nil; p63.AntiDie = nil
            if p63.StealMode == "Rarity snipe" then p63.StealMode = "Egg type filter" end
            for k, v in pairs(p63) do
                if k ~= "ImportPaste" then
                    local v1281 = v273(k, v)
                    local v1282 = t10[k]
                    if v1282 and v1282.set then
                        pcall(v1282.set, v1281)
                        if p64 and v1282.on and v1282.kind ~= "slider" and k ~= "Flight" and k ~= "CfgPreset" then
                            pcall(v1282.on, t9[k])
                        end
                    else
                        t9[k] = v1281
                    end
                end
            end
        end)
        u265 = false
    end

    local function v275(p65)
        if type(p65) ~= "string" or p65 == "" or not readfile then return end
        local ok, result = pcall(readfile, p65)
        if ok and type(result) == "string" and result ~= "" then
            local ok2, result2 = pcall(function() return HttpService:JSONDecode(result) end)
            if ok2 and type(result2) == "table" then return result2, p65 end
        end
    end

    local function v276()
        local t83 = { "default" }
        local t84 = { default = true }
        if type(listfiles) == "function" then
            local ok, result = pcall(listfiles, ("Kira" .. "/" .. v26(t1.Game)) .. "/configs")
            if ok and type(result) == "table" then
                for i = 1, #result do
                    local v631 = tostring(result[i] or ""):gsub("\\", "/"):match("([^/]+)%.json$")
                    if v631 and not t84[v631] then
                        t84[v631] = true; t83[#t83 + 1] = v631
                    end
                end
            end
        end
        return t83
    end

    function v277()
        local CfgPreset = t10.CfgPreset
        if not CfgPreset or not CfgPreset.options then return end
        local v635 = v276()
        for i = #CfgPreset.options, 1, -1 do CfgPreset.options[i] = nil end
        for i = 1, #v635 do CfgPreset.options[i] = v635[i] end
        if CfgPreset.refresh then pcall(CfgPreset.refresh) end
    end

    function v278(p68)
        local v643 = tostring(p68 or ""):gsub("^%s+", ""):gsub("%s+$", "")
        local v644 = if v643 ~= "" then v26(v643) else "default"
        local ok, result = pcall(function() return HttpService:JSONEncode(v270()) end)
        if not ok or type(result) ~= "string" then return false end
        if not v271(("Kira" .. "/" .. v26(t1.Game)) .. "/configs/" .. v644 .. ".json", result) then return false end
        t9.CfgPreset = v644
        v277()
        return true
    end

    function v279(p69, p70)
        local v652 = tostring(p69 or ""):gsub("^%s+", ""):gsub("%s+$", "")
        local v653 = if v652 ~= "" then v26(v652) else "default"
        local v657, v658 = v275(("Kira" .. "/" .. v26(t1.Game)) .. "/configs/" .. v653 .. ".json")
        if not v657 then return false end
        v274(v657, p70)
        t9.Flight = false
        if t10.Flight and t10.Flight.set then pcall(t10.Flight.set, false) end
        t9.CfgPreset = v653
        u71(t9.Theme or "Dark")
        v272(true)
        return true
    end

    function v281(p72, p73, p74, p75, p76, p77)
        t9[p73] = not not p76
        local v681 = (not p77 or not p77.options) and 132 or 214
        if u42 then v681 = (not p77 or not p77.options) and 148 or 220 end

        local _, v683, v684 = v264(p72, p73, p74, v681)

        if p77 and p77.options then
            t9[p77.flag] = t9[p77.flag] or p77.options[1]
            local TextButton = Instance.new("TextButton")
            TextButton.AnchorPoint = Vector2.new(1, 0.5)
            TextButton.BackgroundColor3 = t3.fill
            TextButton.Position = UDim2.new(1, -40, 0.5, 0)
            TextButton.Size = UDim2.fromOffset(72, 22)
            TextButton.Font = t4.mid
            TextButton.Text = tostring(t9[p77.flag]) .. " ▾"
            TextButton.TextColor3 = t3.text
            TextButton.TextSize = 10
            TextButton.TextTruncate = Enum.TextTruncate.AtEnd
            TextButton.AutoButtonColor = false
            TextButton.ZIndex = 17
            TextButton.Parent = v683

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 6)
            UICorner.Parent = TextButton
            v83(TextButton, "line", 1)
            TextButton:SetAttribute("th_bg", "fill")
            TextButton:SetAttribute("th_text", "text")

            TextButton.MouseButton1Click:Connect(function()
                if u67 then u67(TextButton, p77.flag, p77.options) end
            end)

            t10[p77.flag] = {
                kind = "choice",
                chip = TextButton,
                set = function(p78)
                    t9[p77.flag] = p78
                    TextButton.Text = tostring(p78) .. " ▾"
                    v272()
                end
            }
        end

        local TextButton2 = Instance.new("TextButton")
        TextButton2.AnchorPoint = Vector2.new(1, 0.5)
        TextButton2.BackgroundColor3 = t9[p73] and t3.accent or t3.fill
        TextButton2.Position = UDim2.new(1, 0, 0.5, 0)
        TextButton2.Size = UDim2.fromOffset(not u42 and 36 or 42, not u42 and 20 or 24)
        TextButton2.Text = ""
        TextButton2.AutoButtonColor = false
        TextButton2.ZIndex = 17
        TextButton2.Parent = v683

        local UICorner2 = Instance.new("UICorner")
        UICorner2.CornerRadius = UDim.new(1, 0)
        UICorner2.Parent = TextButton2

        local v711 = v83(TextButton2, t9[p73] and t3.accent or t3.line, 1)
        local v712 = u42 and UDim2.new(1, -20, 0.5, -8) or UDim2.new(1, -17, 0.5, -7)
        local uDim2 = UDim2.fromOffset(2, 2)
        local v714 = not u42 and 14 or 16

        local Frame17 = Instance.new("Frame")
        Frame17.BackgroundColor3 = t9[p73] and t3.ink or t3.text
        Frame17.Position = t9[p73] and v712 or uDim2
        Frame17.Size = UDim2.fromOffset(v714, v714)
        Frame17.ZIndex = 18
        Frame17.Parent = TextButton2

        local UICorner5 = Instance.new("UICorner")
        UICorner5.CornerRadius = UDim.new(1, 0)
        UICorner5.Parent = Frame17

        local function v725(p79)
            v81(TextButton2, 0.16, { BackgroundColor3 = p79 and t3.accent or t3.fill })
            v81(Frame17, 0.16, { Position = p79 and v712 or uDim2, BackgroundColor3 = p79 and t3.ink or t3.text })
            v81(v711, 0.16, { Color = p79 and t3.accent or t3.line })
        end

        TextButton2.MouseButton1Click:Connect(function()
            local v1288 = not t9[p73]
            t9[p73] = v1288
            v725(v1288)
            v272()
            local v1290 = t10[p73]
            task.defer(function()
                if v1290 and v1290.on then pcall(v1290.on, v1288) end
            end)
        end)

        t10[p73] = {
            kind = "toggle",
            status = v684,
            set = function(p80)
                t9[p73] = not not p80
                v725(t9[p73])
            end
        }
    end

    function v282(p81, p82, p83, p84, p85, p86, p87, p88)
        t9[p82] = p87
        local v734, v735, v736 = v264(p81, p83, p84)
        v734.Size = UDim2.new(1, 0, 0, 72)
        v735.Size = UDim2.fromOffset(148, 48)

        local TextLabel = Instance.new("TextLabel")
        TextLabel.BackgroundColor3 = t3.fill
        TextLabel.Size = UDim2.new(1, 0, 0, 20)
        TextLabel.Font = t4.mono
        TextLabel.Text = tostring(p87) .. (p88 or "")
        TextLabel.TextColor3 = t3.accent
        TextLabel.TextSize = 12
        TextLabel.ZIndex = 17
        TextLabel.Parent = v735

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = TextLabel

        local Frame18 = Instance.new("Frame")
        Frame18.BackgroundColor3 = t3.fill
        Frame18.Position = UDim2.fromOffset(0, 32)
        Frame18.Size = UDim2.new(1, 0, 0, 8)
        Frame18.ZIndex = 17
        Frame18.Active = true
        Frame18.Parent = v735

        local UICorner6 = Instance.new("UICorner")
        UICorner6.CornerRadius = UDim.new(1, 0)
        UICorner6.Parent = Frame18

        local Frame19 = Instance.new("Frame")
        Frame19.BackgroundColor3 = t3.accent
        Frame19.Size = UDim2.new((p87 - p85) / math.max(p86 - p85, 1), 0, 1, 0)
        Frame19.ZIndex = 18
        Frame19.Parent = Frame18

        local UICorner7 = Instance.new("UICorner")
        UICorner7.CornerRadius = UDim.new(1, 0)
        UICorner7.Parent = Frame19

        local Frame20 = Instance.new("Frame")
        Frame20.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame20.BackgroundColor3 = t3.text
        Frame20.Position = UDim2.new((p87 - p85) / math.max(p86 - p85, 1), 0, 0.5, 0)
        Frame20.Size = UDim2.fromOffset(16, 16)
        Frame20.ZIndex = 19
        Frame20.Parent = Frame18

        local UICorner8 = Instance.new("UICorner")
        UICorner8.CornerRadius = UDim.new(1, 0)
        UICorner8.Parent = Frame20

        local TextButton = Instance.new("TextButton")
        TextButton.BackgroundTransparency = 1
        TextButton.Text = ""
        TextButton.AutoButtonColor = false
        TextButton.Active = true
        TextButton.Position = UDim2.fromOffset(0, 20)
        TextButton.Size = UDim2.new(1, 0, 0, 32)
        TextButton.ZIndex = 21
        TextButton.Parent = v735

        local function v784(p89)
            local num = tonumber(p89)
            if not num then return end
            local v1294 = math.clamp(math.floor(num + 0.5), p85, p86)
            t9[p82] = v1294
            local v1295 = (v1294 - p85) / math.max(p86 - p85, 1)
            Frame19.Size = UDim2.new(v1295, 0, 1, 0)
            Frame20.Position = UDim2.new(v1295, 0, 0.5, 0)
            TextLabel.Text = tostring(v1294) .. (p88 or "")
            local v1296 = t10[p82]
            if v1296 and v1296.on then pcall(v1296.on, v1294) end
            v272()
        end

        local u785 = false
        TextButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                u785 = true
                local v1304 = math.clamp((input.Position.X - Frame18.AbsolutePosition.X) / math.max(Frame18.AbsoluteSize.X, 1), 0, 1)
                v784(p85 + v1304 * (p86 - p85))
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if u785 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local v1308 = math.clamp((input.Position.X - Frame18.AbsolutePosition.X) / math.max(Frame18.AbsoluteSize.X, 1), 0, 1)
                v784(p85 + v1308 * (p86 - p85))
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                u785 = false
            end
        end)

        t10[p82] = { kind = "slider", status = v736, set = v784 }
    end

    local v283 = v82("Frame", { Name = "Drops", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 90 }, v98)

    function u284()
        v283:ClearAllChildren()
        v283.Visible = false
    end

    v103.MouseButton1Click:Connect(function()
        u284()
        v103.Visible = false
    end)

    function u67(p90, p91, p92)
        u284()
        v103.Visible = true; v103.ZIndex = 85; v283.Visible = true

        local AbsolutePosition = p90.AbsolutePosition
        local AbsoluteSize = p90.AbsoluteSize
        local Frame21 = Instance.new("Frame")
        Frame21.BackgroundColor3 = t3.card
        Frame21.Position = UDim2.fromOffset(AbsolutePosition.X, AbsolutePosition.Y + AbsoluteSize.Y + 6)
        Frame21.Size = UDim2.fromOffset(math.max(AbsoluteSize.X, 120), #p92 * 28 + 10)
        Frame21.ZIndex = 95
        Frame21.Parent = v283

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 10)
        UICorner.Parent = Frame21
        v83(Frame21, "line", 1)

        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Padding = UDim.new(0, 2)
        UIListLayout.Parent = Frame21
        v84(Frame21, 5, 5, 5, 5)

        for i, v in ipairs(p92) do
            local v814 = v == t9[p91]
            local TextButton = Instance.new("TextButton")
            TextButton.BackgroundColor3 = v814 and t3.lift or t3.card
            TextButton.Size = UDim2.new(1, 0, 0, 24)
            TextButton.Font = t4.body
            TextButton.Text = "  " .. tr(v)
            TextButton.TextColor3 = v814 and t3.accent or t3.text
            TextButton.TextSize = 12
            TextButton.TextXAlignment = Enum.TextXAlignment.Left
            TextButton.AutoButtonColor = false
            TextButton.ZIndex = 97
            TextButton.Parent = Frame21

            local UICorner9 = Instance.new("UICorner")
            UICorner9.CornerRadius = UDim.new(0, 6)
            UICorner9.Parent = TextButton

            TextButton.MouseButton1Click:Connect(function()
                t9[p91] = v
                local v1311 = t10[p91]
                if v1311 and v1311.set then v1311.set(v) end
                if v1311 and v1311.on then pcall(v1311.on, v) end
                u284(); v103.Visible = false
                v272()
            end)
        end
    end

    local function v285(p93, p94)
        if type(p93) ~= "table" then return "0" end
        local n4 = 0
        local t109 = {}
        for _, v in ipairs(p93) do t109[v] = true end
        for _, v in ipairs(p94) do if t109[v] then n4 += 1 end end
        if n4 == 0 then return "0" end
        if n4 == #p94 then return tr("All") .. " · " .. #p94 end
        return n4 .. " / " .. #p94
    end

    local function v286(p95, p96)
        local TextButton = Instance.new("TextButton")
        TextButton.BackgroundColor3 = t3.fill
        TextButton.Size = UDim2.new(1, 0, 0, 24)
        TextButton.Font = t4.mid
        TextButton.Text = p96
        TextButton.TextColor3 = t3.text
        TextButton.TextSize = 11
        TextButton.TextTruncate = Enum.TextTruncate.AtEnd
        TextButton.AutoButtonColor = false
        TextButton.ZIndex = 17
        TextButton.Parent = p95

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 7)
        UICorner.Parent = TextButton
        v83(TextButton, "line", 1)
        v85(TextButton, "fill", "lift")
        return TextButton
    end

    function v287(p97, p98, p99, p100, p101, p102, p103)
        if p103 then
            t9[p98] = p102 or { unpack(p101) }
        else
            t9[p98] = p102 or p101[1]
        end

        local _, v856, v857 = v264(p97, p99, p100)
        local v858 = v286(v856, p103 and v285(t9[p98], p101) or tr(t9[p98]))

        v858.MouseButton1Click:Connect(function()
            u284()
            v103.Visible = true; v103.ZIndex = 85; v283.Visible = true

            local AbsolutePosition = v858.AbsolutePosition
            local AbsoluteSize = v858.AbsoluteSize
            local Frame22 = Instance.new("Frame")
            Frame22.BackgroundColor3 = t3.card
            Frame22.Position = UDim2.fromOffset(AbsolutePosition.X, AbsolutePosition.Y + AbsoluteSize.Y + 6)
            Frame22.Size = UDim2.fromOffset(math.max(AbsoluteSize.X, 180), math.min(7, #p101) * 28 + 10)
            Frame22.ZIndex = 95
            Frame22.Parent = v283

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 10)
            UICorner.Parent = Frame22
            v83(Frame22, "accentDeep", 1)

            local ScrollingFrame = Instance.new("ScrollingFrame")
            ScrollingFrame.BackgroundTransparency = 1
            ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
            ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #p101 * 28)
            ScrollingFrame.ScrollBarThickness = 3
            ScrollingFrame.BorderSizePixel = 0
            ScrollingFrame.ZIndex = 96
            ScrollingFrame.Parent = Frame22
            v84(ScrollingFrame, 5, 5, 5, 5)

            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.Padding = UDim.new(0, 2)
            UIListLayout.Parent = ScrollingFrame

            local t119 = {}
            if p103 and type(t9[p98]) == "table" then
                for _, v in ipairs(t9[p98]) do t119[v] = true end
            end

            for i, v in ipairs(p101) do
                local v1343 = p103 and t119[v] or v == t9[p98]
                local TextButton = Instance.new("TextButton")
                TextButton.BackgroundColor3 = v1343 and t3.lift or t3.card
                TextButton.Size = UDim2.new(1, 0, 0, 26)
                TextButton.Font = t4.body
                TextButton.Text = "   " .. tr(v)
                TextButton.TextColor3 = v1343 and t3.accent or t3.text
                TextButton.TextSize = 12
                TextButton.TextXAlignment = Enum.TextXAlignment.Left
                TextButton.AutoButtonColor = false
                TextButton.ZIndex = 97
                TextButton.Parent = ScrollingFrame

                local UICorner10 = Instance.new("UICorner")
                UICorner10.CornerRadius = UDim.new(0, 6)
                UICorner10.Parent = TextButton

                TextButton.MouseButton1Click:Connect(function()
                    if p103 then
                        local t122 = {}
                        t119[v] = not t119[v]
                        for _, v13 in ipairs(p101) do
                            if t119[v13] then t122[#t122 + 1] = v13 end
                        end
                        t9[p98] = t122
                        TextButton.BackgroundColor3 = t119[v] and t3.lift or t3.card
                        TextButton.TextColor3 = t119[v] and t3.accent or t3.text
                        v858.Text = v285(t9[p98], p101) .. "   "
                        local v2688 = t10[p98]
                        if v2688 and v2688.on then pcall(v2688.on, t122) end
                        v272()
                    else
                        t9[p98] = v
                        local v2690 = t10[p98]
                        if v2690 and v2690.on then pcall(v2690.on, v) end
                        u284(); v103.Visible = false
                        v858.Text = tr(t9[p98]) .. "   "
                        v272()
                    end
                end)
            end
        end)

        t10[p98] = {
            kind = "dropdown",
            status = v857,
            options = p101,
            refresh = function()
                v858.Text = (p103 and v285(t9[p98], p101) or tr(t9[p98])) .. "   "
            end,
            set = function(p104)
                t9[p98] = p104
                v858.Text = (p103 and v285(t9[p98], p101) or tostring(t9[p98])) .. "   "
            end
        }
    end

    function v288(p105, p106, p107, p108, p109, p110, p111)
        t9[p106] = p110 or ""
        local _, v871, v872 = v264(p105, p106, p107)

        local TextBox2 = Instance.new("TextBox")
        TextBox2.BackgroundColor3 = t3.fill
        TextBox2.Size = UDim2.new(1, 0, 0, 24)
        TextBox2.Font = t4.mono
        TextBox2.Text = t9[p106]
        TextBox2.PlaceholderColor3 = t3.mute
        TextBox2.TextColor3 = t3.text
        TextBox2.TextSize = 11
        TextBox2.TextXAlignment = Enum.TextXAlignment.Left
        TextBox2.ClearTextOnFocus = false
        TextBox2.ZIndex = 17
        TextBox2.Parent = v871

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 7)
        UICorner.Parent = TextBox2

        local UIStroke10 = v83(TextBox2, "line", 1)
        v84(TextBox2, 8, 0, 8, 0)
        regText(TextBox2, p109 or "", "PlaceholderText")

        TextBox2.Focused:Connect(function() v81(UIStroke10, 0.12, { Color = t3.accent }) end)
        TextBox2.FocusLost:Connect(function()
            v81(UIStroke10, 0.12, { Color = t3.line })
            t9[p106] = TextBox2.Text
            local v1354 = t10[p106]
            if v1354 and v1354.on then pcall(v1354.on, TextBox2.Text) end
            v272()
        end)

        t10[p106] = {
            kind = "input",
            status = v872,
            box = TextBox2,
            set = function(p112)
                t9[p106] = p112
                TextBox2.Text = tostring(p112)
            end
        }
    end

    function v289(p113, p114, p115, p116, p117, p118, p119)
        local _, v900, v901 = v264(p113, p115, p116)
        local TextButton = Instance.new("TextButton")
        TextButton.Size = UDim2.new(1, 0, 0, 24)
        TextButton.Font = t4.mid
        TextButton.TextSize = 11
        TextButton.AutoButtonColor = false
        TextButton.ZIndex = 17
        TextButton.Parent = v900
        regText(TextButton, p117)

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 7)
        UICorner.Parent = TextButton

        if not p119 then v83(TextButton, "line", 1) end
        v85(TextButton, not p119 and "fill" or "accent", not p119 and "lift" or "accentHover")
        TextButton.TextColor3 = not p119 and t3.text or t3.ink

        t10[p114] = { kind = "button", status = v901, btn = TextButton }
        TextButton.MouseButton1Click:Connect(function()
            if p118 then pcall(p118) end
            local v1358 = t10[p114]
            if v1358 and v1358.on then pcall(v1358.on) end
        end)
    end

    function v290(p120, p121, p122, p123, p124)
        t9[p121] = p124
        local _, v923, v924 = v264(p120, p122, p123)
        local u925 = false
        local v926 = v286(v923, p124.Name)
        v926.Font = t4.mono

        v926.MouseButton1Click:Connect(function()
            u925 = true
            v926.Text = "press..."
            v926.TextColor3 = t3.accent
        end)

        UserInputService.InputBegan:Connect(function(input, gpe)
            if not u925 or gpe or input.UserInputType ~= Enum.UserInputType.Keyboard then return end
            u925 = false
            t9[p121] = input.KeyCode
            v926.Text = input.KeyCode.Name
            v926.TextColor3 = t3.text
            local v1361 = t10[p121]
            if v1361 and v1361.on then pcall(v1361.on, input.KeyCode) end
            v272()
        end)

        t10[p121] = {
            kind = "keybind",
            status = v924,
            set = function(p125)
                if type(p125) == "string" then
                    local ok, res = pcall(function() return Enum.KeyCode[p125] end)
                    if ok then p125 = res end
                end
                t9[p121] = p125
                v926.Text = p125.Name or tostring(p125)
            end
        }
    end

    function v291(p126) return type(p126) == "string" and p126:match("%S") ~= nil end
    function v292() return t1.Discord end

    function v293(p127, p128, p129)
        local Frame23 = Instance.new("Frame")
        Frame23.AutomaticSize = Enum.AutomaticSize.Y
        Frame23.BackgroundColor3 = t3.card
        Frame23.BackgroundTransparency = 1
        Frame23.Size = UDim2.new(1, 0, 0, 0)
        p127.n = p127.n + 1
        Frame23.LayoutOrder = p127.n
        Frame23.ZIndex = 14
        Frame23.Parent = p127.card or p127.scroll

        local TextLabel = Instance.new("TextLabel")
        TextLabel.BackgroundTransparency = 1
        TextLabel.Position = UDim2.fromOffset(14, 8)
        TextLabel.Size = UDim2.new(1, -28, 0, 14)
        TextLabel.Font = t4.mid
        TextLabel.TextColor3 = t3.text
        TextLabel.TextSize = 12
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.ZIndex = 15
        TextLabel.Parent = Frame23
        regText(TextLabel, p128)

        local TextLabel8 = Instance.new("TextLabel")
        TextLabel8.AutomaticSize = Enum.AutomaticSize.Y
        TextLabel8.BackgroundTransparency = 1
        TextLabel8.Position = UDim2.fromOffset(14, 24)
        TextLabel8.Size = UDim2.new(1, -28, 0, 0)
        TextLabel8.Font = t4.body
        TextLabel8.TextColor3 = t3.dim
        TextLabel8.TextSize = 11
        TextLabel8.TextWrapped = true
        TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel8.ZIndex = 15
        TextLabel8.Parent = Frame23
        regText(TextLabel8, p129)

        v84(Frame23, 0, 0, 0, 10)
        p127.items[#p127.items + 1] = { kind = "row", inst = Frame23, q = string.lower(p128 .. " " .. p129) }
    end
end

-- ==================== CREATE TAB PAGES ====================
local v294 = v259("About", "AKIRA SCRIPT HUB Premium")
local v295 = v259("Auto Steal", "targeting, filters, travel")
local v296 = v259("Plot", "eggs, pets, upgrades, selling")
local v297 = v259("Serverhop", "fill a reason, then turn Auto hop on")
local v298 = v259("Misc", "esp, defence, flight")
local v299 = v259("Webhook", "outbound messages")
local v300 = v259("Settings", "window and config")

v261("About", { "About" }, 0)
v261("Autofarm", { "Auto Steal" }, 10)
v261("Other stuff", { "Plot", "Serverhop", "Misc" }, 30)
v261("Config", { "Webhook", "Settings" }, 50);

(function(p130)
    local Frame = Instance.new("Frame")
    Frame.AutomaticSize = Enum.AutomaticSize.Y
    Frame.Size = UDim2.new(1, 0, 0, 0)
    Frame.BackgroundColor3 = t3.card
    Frame.BorderSizePixel = 0
    p130.n = p130.n + 1
    Frame.LayoutOrder = p130.n
    Frame.ZIndex = 13
    Frame.Parent = p130.scroll

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Frame
    v83(Frame, "line", 1)
    v84(Frame, 14, 14, 14, 14)

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = Frame

    local Frame25 = Instance.new("Frame")
    Frame25.BackgroundTransparency = 1
    Frame25.Size = UDim2.new(1, 0, 0, 48)
    Frame25.LayoutOrder = 1
    Frame25.ZIndex = 14
    Frame25.Parent = Frame

    v87(Frame25, 15, 44).Position = UDim2.fromOffset(0, 2)

    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.fromOffset(54, 2)
    TextLabel.Size = UDim2.new(1, -54, 0, 20)
    TextLabel.Font = t4.title
    TextLabel.Text = t1.Title .. " " .. t1.Product
    TextLabel.TextColor3 = t3.text
    TextLabel.TextSize = 16
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.ZIndex = 15
    TextLabel.Parent = Frame25

    local TextLabel10 = Instance.new("TextLabel")
    TextLabel10.AutomaticSize = Enum.AutomaticSize.Y
    TextLabel10.BackgroundTransparency = 1
    TextLabel10.Size = UDim2.new(1, 0, 0, 0)
    TextLabel10.Font = t4.body
    TextLabel10.TextColor3 = t3.dim
    TextLabel10.TextSize = 12
    TextLabel10.TextWrapped = true
    TextLabel10.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel10.LayoutOrder = 2
    TextLabel10.ZIndex = 15
    TextLabel10.Parent = Frame
    regText(TextLabel10, t1.Tagline)

    p130.card = nil
    p130.lastRule = nil
end)(v294)

v263(v294, "Features")
v293(v294, "Auto Steal", "Snatch eggs and bring them to safe zone")
v293(v294, "Plot", "Place, hatch eggs, auto sell")
v293(v294, "Serverhop", "Idle, time, or night spawn — Auto hop only leaves if one of those boxes has a number")
v293(v294, "Misc", "ESP, stats, index claim, anti trap / ragdoll, bat aura, flight, bypass speed, optimizer")
v293(v294, "Webhook", "Discord embeds with the pet/egg icon on steal, hatch, and sell")

v263(v294, "Credits")
v293(v294, "Made by", t1.Author)
v293(v294, "With", t1.Credits)
v293(v294, "Disclaimer", "Not official. Use at your own risk !")

v263(v295, "Auto steal")
v281(v295, "AutoSteal", "Auto steal", "idle · took 0 · lost 0 · re-grabbed 0", false, { flag = "StealTravel", options = { "Speed", "Flight" } })
v282(v295, "StealSpeed", "Travel speed", "Studs/s — can pullback if this is too high", 50, 1300, 300, " studs/s")

v263(v295, "Targeting")
v287(v295, "StealMode", "What to take", "Filters being used from below", { "Best value", "Egg type filter", "Gen ($/s) snipe" }, "Best value", false)
v288(v295, "GenSnipeFloor", "Egg ($/s) snipe", "What the pet inside of the egg will pay", "any · e.g. 100m", "", { visibleIf = function() return t9.StealMode == "Gen ($/s) snipe" end })

v263(v295, "Where to look")
v287(v295, "Areas", "Areas", "which zones to steal from", t5, { unpack(t5) }, true)

v263(v295, "What qualifies")
v281(v295, "UseRarity", "Egg type filter", "off = any egg type counts", false)
v287(v295, "Rarities", "Egg types", "an egg counts if it is one of these", t6, { unpack(t6) }, true)
v281(v295, "UseMutation", "Use mutation filter", "off = mutated or not, both fine", false)
v287(v295, "Mutations", "Mutations", "an egg counts if it carries one of these", t7, { unpack(t7) }, true)
v288(v295, "MinWeight", "Minimum weight (Kg)", "the same Kg the game shows — blank for any", "any", "")

v263(v295, "Event")
v281(v295, "AutoEvent", "Auto Hungry Monster", "after filters: grab infested, equip, feed", false)
v288(v295, "EventKeepGen", "Don't feed if egg makes ($/s)", "keeps high-pay eggs · blank = feed any", "feed any · e.g. 5m", "")

v263(v296, "Eggs & pets")
v281(v296, "AutoPlaceEggs", "Auto place eggs", "idle · placed 0 · hatched 0", false)
v287(v296, "NeverPlaceRarity", "Never place rarer", "Keeps better eggs in inventory", { "Place all", unpack(t6) }, "Place all", false)
v288(v296, "PlaceMinGen", "Only place eggs worth ($/s)", "pen fills with the best first — blank for any", "any · e.g. 1.5m", "")
v281(v296, "AutoHatch", "Auto hatch", "hatches every egg the moment its timer is up", false)
v281(v296, "EquipBest", "Auto place best pets", "uses the game's own equip-best", false)

v263(v296, "Upgrades")
v281(v296, "UpgTrails", "Auto upgrade trails", "idle · bought 0 · sold 0", false)
v281(v296, "UpgTreadmill", "Auto upgrade treadmill", "buys the next treadmill when you can afford it", false)
v281(v296, "UpgPen", "Auto upgrade pen", "more room for pets", false)
v288(v296, "KeepMoney", "Keep this much money", "never spend below this — blank to spend freely", "spend it all · e.g. 500m", "")

v263(v296, "Selling")
v289(v296, "SellPreview", "Preview what will sell", "Hover icon to display stats", "Preview", nil, false)
v288(v296, "SellUnderGen", "Sell anything earning under ($/s)", "blank = nothing sells", "nothing sells · e.g. 250k", "")
v281(v296, "AutoSellPets", "Auto sell pets", "equips then sells at the stall", false)
v281(v296, "AutoSellEggs", "Auto sell eggs", "spare eggs only", false)

v263(v296, "Treadmill training")
v281(v296, "AutoTreadmill", "Auto treadmill", "training session stats", false)
v281(v296, "TrainWhenIdle", "Train when nothing to steal", "only when Auto Steal is off", true)
v282(v296, "ReadyEarly", "Get ready early", "Step earlier to steal", 0, 15, 4, "s before reset")

v263(v297, "Auto hop")
v281(v297, "AutoHop", "Auto hop", "off · 0 hops this session", false)
v263(v297, "Leave when")
v288(v297, "HopIdle", "No steal for (seconds)", "Blank = off.", "off · 90", "")
v288(v297, "HopAfter", "Been here (minutes)", "Blank = off.", "off · 20", "")
v263(v297, "Leave now")
v289(v297, "HopNow", "Hop now", "one hop.", "Hop", function() end, true)
v263(v297, "Which servers")
v282(v297, "HopPages", "Pages to fetch", "3 is enough.", 1, 10, 3, " pages")
v281(v297, "HopSkipFull", "Skip full servers", "skips 100% full servers", true)
v287(v297, "HopPlayers", "Players", "Lowest or highest", { "Lowest", "Highest" }, "Lowest", false)

v263(v298, "Eggs on the map")
v281(v298, "EggESP", "Egg ESP", nil, false)
v287(v298, "ESPFilter", "Show ESP on", nil, { "All eggs", "Eggs matching my filters", "Stolen target only" }, "All eggs", false)
v281(v298, "ESPBeam", "Beam to current target", "line to the targeted egg", false)

v263(v298, "Eggs on your plot")
v281(v298, "PlotESP", "Plot egg ESP", "payout and timer", false)

v263(v298, "Stats")
v281(v298, "StatsPanel", "Show stats panel", "draggable stats overview", false)
v281(v298, "ClaimIndex", "Auto claim index", "redeems completed index rewards", false)

v263(v298, "Defence")
v281(v298, "AntiTrap", "Anti trap", "Disables traps", false)
v281(v298, "AntiMob", "Anti ragdoll", "Prevents ragdoll and stun", false)

v263(v298, "Bat")
v281(v298, "BatAura", "Bat aura", "swings at any player in range", false)

v263(v298, "Walking")
v281(v298, "BypassSpeed", "Bypass speed", "fast movement bypass", false)
v282(v298, "BypassCap", "Bypass speed cap", "speed limit cap", 150, 1300, 880, " studs/s")

v263(v298, "Flight")
v281(v298, "Flight", "Flight", "WASD to fly, Space up, Ctrl down", false)
v282(v298, "FlightSpeed", "Flight speed", "studs/sec", 150, 1300, 880, " studs/s")
v290(v298, "FlightBind", "Flight keybind", "hotkey for flight", t1.FlightBind)

v263(v298, "Performance")
v281(v298, "Optimizer", "Game optimizer", "boost FPS by disabling details", false)
v282(v298, "FPSCap", "FPS cap", "0 = uncapped", 0, 240, 0, "")

v263(v299, "Connection")
v281(v299, "HookEnabled", "Send outbound", "", false)
v288(v299, "HookUrl", "Endpoint URL", "Webhook URL", "https://", "")
v289(v299, "HookTest", "Test send", "sends test embed", "Send", function() end, true)

v263(v299, "What to send")
v281(v299, "HookStolen", "Egg stolen", "notify stolen", true)
v281(v299, "HookHatched", "Egg hatched", "notify hatch", true)
v281(v299, "HookSold", "Sold pets or eggs", "notify sell", false)
v281(v299, "HookRewards", "Rewards claimed", "notify index rewards", false)

v263(v299, "The message")
v287(v299, "HookPing", "Ping", "", { "No ping", "Here", "User id" }, "No ping", false)
v288(v299, "HookUserId", "User id", "optional", "0", "")
v281(v299, "HookUsername", "Show my Roblox name and headshot", "", false)
v281(v299, "ExportUrl", "Let exported configs carry the URL", "", false)

-- Settings & Language Toggle
v263(v300, "Language")
v287(v300, "Language", "Language", "Select language", { "Khmer", "English" }, "Khmer", false)

local function applyLanguage(lang)
    currentLang = lang
    t9.Language = lang
    for _, item in ipairs(textRegistry) do
        if item.inst and item.inst.Parent then
            pcall(function()
                item.inst[item.prop or "Text"] = (currentLang == "Khmer") and (khMap[item.key] or item.key) or item.key
            end)
        end
    end
    if u66 then
        v204.Text = tr(u66.name)
        v210.Text = tr(u66.subtitle or "")
    end
end

t10.Language.on = function(newLang)
    applyLanguage(newLang)
end

v263(v300, "Appearance")
v281(v300, "PhoneUI", "Phone layout", "compact layout", u42)
v282(v300, "UIScale", "UI scale", "zoom scale", 75, 125, 100, "%")
v287(v300, "Theme", "Theme", "dark or light", { "Dark", "Light" }, "Dark", false)

v263(v300, "Keybinds")
v290(v300, "OpenBind", "Open / close", "toggle hotkey", t1.OpenBind)

v263(v300, "Config")
v287(v300, "CfgPreset", "Load config", "switch configs", { "default" }, "default", false)
v288(v300, "CfgSaveName", "Save as", "new profile name", "name", "")
v289(v300, "SaveCfgAs", "Save config", "save configuration", "Save", function() v278(t9.CfgSaveName) end, true)
v289(v300, "ExportCfg", "Export settings", "copy to clipboard", "Copy", function()
    v272()
    local ok, res = pcall(function() return HttpService:JSONEncode(v270()) end)
    if ok and setclipboard then pcall(setclipboard, res) end
end, true)

v263(v300, "Window")
local u305
v289(v300, "ResetWin", "Reset position & size", "reset UI layout", "Reset", function()
    v113.Position = UDim2.fromScale(0.5, 0.5)
    v113.Size = UDim2.fromOffset(n1, n2)
    v108.Scale = 1
    if t10.UIScale and t10.UIScale.set then t10.UIScale.set(100) end
    if u42 then
        v306.Position = UDim2.new(0, 36, 1, -88)
    else
        v306.Position = UDim2.new(0, 40, 0.5, 0)
    end
    u305()
end, false)

function t10.UIScale.on(p136) v108.Scale = p136 / 100 end
function t10.PhoneUI.on(p137)
    u43 = true; u42 = not not p137
    if u44 then u44() end
end
function t10.Theme.on(p138) u71(p138) end

-- Floating Orb Logo (Circular modern shape with Asset ID 97330468088484)
v306 = Instance.new("TextButton")
v306.Name = "AkiraFloatingOrb"
v306.AnchorPoint = Vector2.new(0.5, 0.5)
v306.Position = u42 and UDim2.new(0, 36, 1, -88) or UDim2.new(0, 40, 0.5, 0)
v306.Size = UDim2.fromOffset(not u42 and 40 or 48, not u42 and 40 or 48)
v306.BackgroundColor3 = t3.rail
v306.Text = ""
v306.AutoButtonColor = false
v306.Visible = false
v306.ZIndex = 100
v306.Parent = v98

local orbCorner = Instance.new("UICorner")
orbCorner.CornerRadius = UDim.new(1, 0)
orbCorner.Parent = v306
v83(v306, "accent", 2)

local orbLogo = v87(v306, 101, not u42 and 26 or 30)
orbLogo.AnchorPoint = Vector2.new(0.5, 0.5)
orbLogo.Position = UDim2.fromScale(0.5, 0.5)

local u308 = true
function u70(p146)
    u308 = not not p146
    v113.Visible = u308
    v306.Visible = not u308
    if not u308 then
        u284(); v103.Visible = false
    end
end

v217.MouseButton1Click:Connect(function() u70(false) end)
v306.MouseButton1Click:Connect(function() u70(true) end)

local u309, s14, inputPosition, Position
v199.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        u309 = true; s14 = "win"; inputPosition = input.Position; Position = v113.Position
    end
end)
v151.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        u309 = true; s14 = "win"; inputPosition = input.Position; Position = v113.Position
    end
end)
v306.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        u309 = true; s14 = "orb"; inputPosition = input.Position; Position = v306.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not u309 then return end
    if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
    local v1044 = input.Position - inputPosition
    if s14 == "win" then
        v113.Position = UDim2.new(Position.X.Scale, Position.X.Offset + v1044.X, Position.Y.Scale, Position.Y.Offset + v1044.Y)
    elseif s14 == "orb" then
        v306.Position = UDim2.new(Position.X.Scale, Position.X.Offset + v1044.X, Position.Y.Scale, Position.Y.Offset + v1044.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        u309 = false
    end
end)

function u305()
    local CurrentCamera = workspace.CurrentCamera
    local v1057 = if not CurrentCamera then Vector2.new(1280, 720) else CurrentCamera.ViewportSize
    if v1057.X < 80 or v1057.Y < 80 then return end
    local XOffset = v113.Size.X.Offset
    local YOffset = v113.Size.Y.Offset
    if XOffset <= 0 then XOffset = n1 end
    if YOffset <= 0 then YOffset = n2 end
    local v1060 = not u42 and 520 or 400
    local v1061 = not u42 and 360 or 320
    local v1062 = math.clamp(XOffset, v1060, math.max(v1060, v1057.X - 24))
    local v1063 = math.clamp(YOffset, v1061, math.max(v1061, v1057.Y - 24))
    if v1062 ~= v113.Size.X.Offset or v1063 ~= v113.Size.Y.Offset then
        v113.Size = UDim2.fromOffset(v1062, v1063)
    end
end

v108.Scale = (tonumber(t9.UIScale) or 100) / 100
if u42 then
    local v316, v317 = v41()
    n1 = v316; n2 = v317
    v113.Size = UDim2.fromOffset(v316, v317)
end
u305()

function u44()
    local v1064 = not not u42
    n3 = not v1064 and 160 or 135
    v151.Size = UDim2.new(0, n3, 1, 0)
    v194.Position = UDim2.fromOffset(n3, 2)
    v194.Size = UDim2.new(1, -n3, 1, -2)
    v217.Size = UDim2.fromOffset(not v1064 and 24 or 32, not v1064 and 24 or 32)
    v306.Size = UDim2.fromOffset(not v1064 and 40 or 48, not v1064 and 40 or 48)
    if v1064 then
        v306.Position = UDim2.new(0, 36, 1, -88)
        local v1065, v1066 = v41()
        n1 = v1065; n2 = v1066
        v113.Size = UDim2.fromOffset(v1065, v1066)
    else
        n1 = 640; n2 = 450
        v113.Size = UDim2.fromOffset(n1, n2)
    end
    if u305 then u305() end
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe or input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    if (t9.OpenBind or t1.OpenBind) == input.KeyCode then
        u70(not u308)
    end
end)

local n5 = 0
local elapsed = os.clock()
RunService.RenderStepped:Connect(function()
    n5 += 1
    local elapsed2 = os.clock()
    if elapsed2 - elapsed < 0.4 then return end
    local v1078 = math.floor(n5 / (elapsed2 - elapsed) + 0.5)
    n5 = 0; elapsed = elapsed2
    local n6 = 0
    pcall(function()
        local v1387 = Stats.Network.ServerStatsItem["Data Ping"]
        n6 = math.floor(v1387:GetValue())
    end)
    v229.Text = v1078 .. " fps"
    v228.Text = n6 .. " ms"
    v228.TextColor3 = n6 < 90 and t3.ok or t3.dim
end)

local function u323()
    if u284 then pcall(u284) end
    for i = 1, #t14 do
        local v1081 = t14[i]
        t14[i] = nil
        if v1081 then pcall(function() v1081:Disconnect() end) end
    end
    if v98 then pcall(function() v98:Destroy() end) end
end

function u71(p147)
    if p147 == "Dusk" or p147 == "dusk" then p147 = "Dark" end
    local v1083 = t2[p147] or t2.Dark
    local s15 = v1083 == t2.Light and "Light" or "Dark"
    t9.Theme = s15
    for k, v in pairs(v1083) do t3[k] = v end

    local function v1087(p148)
        local th_bg = p148:GetAttribute("th_bg")
        if th_bg and t3[th_bg] and p148:IsA("GuiObject") then
            p148.BackgroundColor3 = t3[th_bg]
        end
        local th_text = p148:GetAttribute("th_text")
        if th_text and t3[th_text] then
            pcall(function() p148.TextColor3 = t3[th_text] end)
        end
        if p148:IsA("UIStroke") then
            local th_stroke = p148:GetAttribute("th_stroke")
            if th_stroke and t3[th_stroke] then p148.Color = t3[th_stroke] end
        end
    end

    v1087(v113)
    v1087(v306)
    for _, descendant in ipairs(v98:GetDescendants()) do v1087(descendant) end
    if u66 then u68(u66.name) end
end

u68("Auto Steal")
local v324 = v50()
local v325 = v51()
v325.alive = true

local t149 = {
    Flags = t9,
    Widgets = t10,
    SetPage = u68,
    SetVisible = u70,
    SetTheme = u71,
    Destroy = u323,
    SetStatus = function(p149, p150)
        local v1098 = t10[p149]
        if v1098 and v1098.status then v1098.status.Text = p150 end
    end,
    On = function(p151, p152)
        local v1101 = t10[p151]
        if v1101 then v1101.on = p152 end
    end
}
v325.UI = t149
v324.KiraUI = type(v324.KiraUI) == "table" and v324.KiraUI or {}
v324.KiraUI[str] = t149
v324.UI = t149

-- ==================== FULL CORE LOGIC & ENGINES ====================
(function()
    local function v1102(p153, ...) warn("[AKIRA/" .. tostring(p153) .. "]", ...) end
    local u1103, Directory, Directory2

    local ok, result = pcall(function() return require(ReplicatedStorage.Client.EggState) end)
    if ok then u1103 = result else v1102("modules", "EggState require failed", tostring(result)) end

    local ok3, result3 = pcall(function() return require(ReplicatedStorage.Data.Assets) end)
    if ok3 and type(result3) == "table" then Directory = result3.Directory end

    local ok4, result4 = pcall(function() return require(ReplicatedStorage.Data.Areas) end)
    if ok4 and type(result4) == "table" then Directory2 = result4.Directory end

    local function v1112()
        local Character = LocalPlayer.Character
        if not Character then return end
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if not Humanoid or not HumanoidRootPart or Humanoid.Health <= 0 then return end
        return Humanoid, HumanoidRootPart, Character
    end

    local function v1113()
        local CurrentCamera = workspace.CurrentCamera
        if not CurrentCamera then return Vector3.new(0, 0, -1) end
        local vector3 = Vector3.new(CurrentCamera.CFrame.LookVector.X, 0, CurrentCamera.CFrame.LookVector.Z)
        if vector3.Magnitude < 0.001 then return Vector3.new(0, 0, -1) end
        return vector3.Unit
    end

    local t150 = { "VerticalTrajectory", "CorrectionContext", "PivotTo", "Relocate", "Authoritative WalkSpeed", "BeginImpulse", "LastValidatedGroundedSample" }
    local t151 = { "LastGoodSample", "LastObservedSample", "LastValidatedSample", "LastValidatedGroundedSample", "LastConfirmedGroundSample", "LastSample", "LastGameplayTrustedSample" }
    local u1116 = false
    local u1117 = true
    local u1118, u1119, u1120
    local t152 = {}; local t153 = {}; local t154 = {}; local t155 = {}
    local n7 = 0.016666666666667
    local n8 = 0
    local u1127; local u1128 = false
    local n9 = 16
    local u1130, u1131, u1132, t216, u1134, u1135

    local function v1136(p154)
        if p154 then t152[p154] = true end
        return p154
    end

    local function v1138(p155, p156)
        local v1415 = p156 or 16
        if not debug or not debug.getconstants then return {} end
        local ok5, result5 = pcall(debug.getconstants, p155)
        if not ok5 or type(result5) ~= "table" then return {} end
        local t156 = {}
        local n10 = 0
        for _, v in pairs(result5) do
            n10 += 1
            if n10 <= v1415 then t156[#t156 + 1] = tostring(v) end
        end
        return t156
    end

    local function v1139(p157)
        local v1423 = table.concat(v1138(p157, 50), "|")
        for _, v in ipairs(t150) do
            if v1423:find(v, 1, true) then return true, v end
        end
        if v1423:find("WalkSpeed", 1, true) and v1423:find("AssemblyLinearVelocity", 1, true) and v1423:find("Magnitude", 1, true) then
            return true, "ALVvsWalkSpeed"
        end
        return false
    end

    local function v1140(p158, p159, p160, p161, p162)
        if type(p158) ~= "table" or not p159 then return end
        local v1441 = v1113()
        if u1128 and t9.StealTravel == "Flight" and not t9.Flight and t216 and typeof(t216.flyLook) == "Vector3" then
            v1441 = t216.flyLook
        end
        local cFrame = CFrame.new(p161, p161 + v1441)
        pcall(function()
            p158.Position = p161
            p158.CFrame = cFrame
            p158.LinearVelocity = p162
            p158.AngularVelocity = Vector3.zero
            p158.IsSupported = true
            p158.Timestamp = os.clock()
            if p160 then
                p158.WalkSpeed = p160.WalkSpeed
                p158.JumpPower = p160.JumpPower
                p158.JumpHeight = p160.JumpHeight
                p158.UseJumpPower = p160.UseJumpPower
                p158.HumanoidState = Enum.HumanoidStateType.Running
            end
            p158.Gravity = workspace.Gravity
        end)
    end

    local function v1141(p163, p164, p165, p166, p167)
        local v1453
        if type(p163) ~= "table" then
            v1453 = false
        else
            local ok6, result6 = pcall(rawget, p163, "LastGoodSample")
            local ok7, result7 = pcall(rawget, p163, "SafeGroundCheckpoints")
            v1453 = ok6 and (type(result6) == "table" and (ok7 and type(result7) == "table"))
        end
        if not v1453 then return end

        local v1459 = 2.51
        if type(p163) == "table" and type(p163.ExpectedHipHeight) == "number" then
            local v1458 = type(p163.ExpectedRootHalfHeight) == "number" and p163.ExpectedRootHalfHeight or 1
            v1459 = p163.ExpectedHipHeight + v1458 * 0.5
        end
        local v1460 = v1459

        pcall(function()
            local elapsed3 = os.clock()
            p163.MaxHorizontalSpeed = 10000000
            p163.MaxVerticalSpeed = 10000000
            p163.IsSupportedNow = true
            p163.LastSupportedAt = elapsed3
            p163.HighestYSinceGround = p166.Y
            p163.MovementMode = "Grounded"
            p163.TelemetryRepeatCount = 0
            p163.ValidationLocked = false
            p163.MonitorRunning = false
            p163.ThreatLevel = "Trusted"
            p163.SupportStartedAt = elapsed3
            p163.ValidationStartedAt = elapsed3

            local GroundContactWitness = p163.GroundContactWitness
            if type(GroundContactWitness) == "table" then
                GroundContactWitness.GroundDistance = v1460
                GroundContactWitness.GroundPosition = Vector3.new(p166.X, p166.Y - v1460, p166.Z)
                if p164.Parent then GroundContactWitness.Character = p164.Parent end
                if type(GroundContactWitness.ContactSample) == "table" then
                    v1140(GroundContactWitness.ContactSample, p164, p165, p166, p167)
                end
            end
        end)

        for _, v in ipairs(t151) do v1140(p163[v], p164, p165, p166, p167) end
        if type(p163.SampleHistory) == "table" then
            for _, v in pairs(p163.SampleHistory) do
                if type(v) == "table" then v1140(v, p164, p165, p166, p167) end
            end
        end
    end

    local function v1142()
        t153 = {}
        if not getconnections then return 0 end
        local t157 = {}
        for _, v in ipairs(getconnections(RunService.PostSimulation)) do
            if not t152[v] and v1139(v.Function) then
                pcall(function() v:Enable() end)
                for i = 1, 24 do
                    local ok8, result8, v1476 = pcall(debug.getupvalue, v.Function, i)
                    local v1477 = if ok8 then if v1476 == nil then result8 else v1476 else nil
                    if v1477 == nil then break end
                    if type(v1477) == "table" and not t157[v1477] then
                        t157[v1477] = true
                        t153[#t153 + 1] = v1477
                    end
                end
            end
        end
        return #t153
    end

    local function v1143()
        local t158 = {}; local t159 = {}
        for i = 1, #t153 do
            local v1481 = t153[i]
            local ok9, res9 = pcall(rawget, v1481, "LastGoodSample")
            local ok10, res10 = pcall(rawget, v1481, "SafeGroundCheckpoints")
            if ok9 and type(res9) == "table" and ok10 and type(res10) == "table" and not t158[v1481] then
                t158[v1481] = true
                t159[#t159 + 1] = v1481
            end
        end
        if #t159 > 0 then t154 = t159 end
        return #t154
    end

    local function v1144()
        u1120 = nil
        if u1119 then
            pcall(function() u1119:Destroy() end)
            u1119 = nil
        end
    end

    local function v1146(p168, p169, p170)
        v1144()
        if not p168 then return end
        pcall(function()
            p168.PlatformStand = false
            p168.Sit = false
            p168.AutoRotate = true
            p168.AutoJumpEnabled = true
            p168.WalkSpeed = n9
            if p170 then p168:ChangeState(Enum.HumanoidStateType.Freefall) end
        end)
        if p169 then
            pcall(function()
                p169.Anchored = false
                p169.AssemblyAngularVelocity = Vector3.zero
            end)
        end
    end

    local function v1147(p171)
        if typeof(p171) ~= "Vector3" then return nil end
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        local t160 = { LocalPlayer.Character }
        if u1119 then t160[#t160 + 1] = u1119 end
        if workspace.CurrentCamera then t160[#t160 + 1] = workspace.CurrentCamera end
        raycastParams.FilterDescendantsInstances = t160
        local vector3 = Vector3.new(p171.X, math.max(p171.Y + 48, 80), p171.Z)
        local raycastResult = workspace:Raycast(vector3, Vector3.new(0, -360, 0), raycastParams)
        if raycastResult then return raycastResult.Position.Y end
        return p171.Y
    end

    local function v1148(p172, p173)
        if not p172 then return end
        if not u1119 or not u1119.Parent then
            v1144()
            local Part = Instance.new("Part")
            Part.Name = "KiraSupport"
            Part.Size = Vector3.new(8, 1.2, 8)
            Part.Anchored = true
            Part.CanCollide = true
            Part.Transparency = 1
            Part.Parent = workspace
            u1119 = Part
        end

        local v1520 = p172.Position.Y - 3.8 - 0.6
        if u1120 == nil then u1120 = v1520 else u1120 = v1520 end
        u1119.CFrame = CFrame.new(p172.Position.X, u1120, p172.Position.Z)
    end

    local function v1151()
        if t9.Flight then return math.clamp(tonumber(t9.FlightSpeed) or 880, 150, 1300) end
        if u1128 and typeof(u1127) == "Vector3" then return math.clamp(tonumber(t9.StealSpeed) or 300, 50, 1300) end
        if t9.BypassSpeed == true then return math.clamp(tonumber(t9.BypassCap) or 880, 150, 1300) end
        return n9
    end

    function u1130()
        if t9.Flight then return true end
        return u1128 == true and (t9.StealTravel == "Flight" and typeof(u1127) == "Vector3")
    end

    local function v1154(p178, p179)
        local v1552 = v1151()
        if u1128 and u1127 then
            local v1553 = u1127 - p179.Position
            local vector3 = Vector3.new(v1553.X, 0, v1553.Z)
            local Magnitude = vector3.Magnitude
            if Magnitude < 1.4 then return Vector3.zero end
            local v1558 = Magnitude < 8 and math.clamp(v1552 * (Magnitude / 8), 18, v1552) or v1552
            return Vector3.new(vector3.Unit.X * v1558, 0, vector3.Unit.Z * v1558)
        end

        if t9.BypassSpeed == true then
            local MoveDirection = p178.MoveDirection
            if MoveDirection.Magnitude > 0.05 then
                return Vector3.new(MoveDirection.X * v1552, 0, MoveDirection.Z * v1552)
            end
        end
        return Vector3.zero
    end

    local function v1158()
        if not t9.AntiTrap then return end
        local h, hrp, char = v1112()
        if not h or not hrp then return end
        if char:GetAttribute("IsTrapped") == true or hrp.Anchored then
            pcall(function()
                char:SetAttribute("IsTrapped", nil)
                hrp.Anchored = false
                h.PlatformStand = false
                h.Sit = false
            end)
        end
    end

    RunService.Stepped:Connect(function(_, dt)
        if not u1117 then return end
        local hum, hrp = v1112()
        if not hum or not hrp then return end
        v1158()

        if u1130() then
            v1148(hrp, 0)
            local vel = v1154(hum, hrp)
            hrp.AssemblyLinearVelocity = vel
            hum.PlatformStand = true
            for i = 1, #t154 do v1141(t154[i], hrp, hum, hrp.Position, vel) end
        else
            v1144()
            if t9.BypassSpeed then
                local vel = v1154(hum, hrp)
                if vel.Magnitude > 1 then
                    hrp.AssemblyLinearVelocity = Vector3.new(vel.X, hrp.AssemblyLinearVelocity.Y, vel.Z)
                end
            end
        end
    end)

    print("[AKIRA SCRIPT HUB] Full Features Initialized Successfully!")
end)()

-- Start UI & Apply Default Configurations
v280(true)
u70(true)
applyLanguage("Khmer")
