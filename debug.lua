--local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Boxking776/kocmoc/main/library.lua"))()
ver_type, ver = 'debug', '0.1'

--game:GetService("ReplicatedStorage").Events.ToolCollect:FireServer()


--local api = loadstring(game:HttpGet('https://raw.githubusercontent.com/qmwdev/testing/main/debug.lua'))()

--variables
local flower_zones = game.Workspace.FlowerZones
local flower_decos = game.Workspace.FieldDecos
local collectibles = game.Workspace.Collectibles
local localplayer = game.Players.LocalPlayer
local NPCBees = game.Workspace.NPCBees
local Vicious_bee = game.Workspace.Particles --.Vicious
local Puffshrooms = game.Workspace.Happenings.Puffshrooms
local HiddenStickers = game.Workspace.HiddenStickers
local Monsters = game.Workspace.Monsters
local MonsterSpawners = game.Workspace.MonsterSpawners
local NPCs = game.Workspace.NPCs
local shops = game.Workspace.Shops
local Toys = game.Workspace.Toys
--local Sprouts = game.Workspace.Sprouts
-----------------------------------------------------------------------------------------------------------------------------------------------

--UI

-----------------------------------------------------------------------------------------------------------------------------------------------

-- functions

local notify = function(Title, Text, Icon, Duration)
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = Title, -- Required
        Text = Text, -- Required
        Icon = Icon or "rbxassetid://1234567890", -- Optional
        Duration = Duration or 5,
    })
end


local all_fields = {}
local all_fields_coordinates = {}


local fields = function(variable)
    for i, v in pairs(variable:GetChildren()) do
        if v:IsA("BasePart") then
            --print(v.Name)
            if not string.find(v.Name, 'Brick') and not string.find(v.Name, 'Hub') and not string.find(v.Name, 'Ant') then
                table.insert(all_fields, v.Name)
                table.insert(all_fields_coordinates, v.Position)
            end
        end
    end
end
fields(flower_zones)

local HiddenStickers_array = {}
local HiddenStickersfunc = function(variable)
    for i, v in pairs(variable:GetChildren()) do
        if v:IsA("BasePart") then
            print(v.Position)
            table.insert(HiddenStickers_array, v.Name .. tostring(i))
        end
    end
end
HiddenStickersfunc(HiddenStickers)

local MonsterSpawners_array = {}
local MonsterSpawnersfunc = function(variable)
    for i, v in pairs(variable:GetChildren()) do
        if v:IsA("BasePart") then
            print(v.Territory.Value)
            table.insert(MonsterSpawners_array, v.Name)
        end
    end
end
MonsterSpawnersfunc(MonsterSpawners)

-- NPCBees, HiddenStickers, Monsters, MonsterSpawners, NPCs, shops


local collect_collectibles = function(variable)
    notify('QWM','Collectibles Started')
    for i, v in pairs(variable:GetChildren()) do
        if v:IsA("BasePart") then
            wait(3)
            game.Players.LocalPlayer.Character:MoveTo(v.Position)
        end
    end
end


local a = 0
local count_collectibles = function(variable)
    for i, v in pairs(variable:GetChildren()) do
        if v:IsA("BasePart") then
            a = a+1
            print(a)
        end
    end
    return a
end


hives = game.Workspace.Honeycombs:GetChildren()
for i = #hives, 1, -1 do
    v = game.Workspace.Honeycombs:GetChildren()[i]
    if v.Owner.Value == nil then
        game.ReplicatedStorage.Events.ClaimHive:FireServer(v.HiveID.Value)
    end
end


--------------------------------------------------------------------------------------------------------------

--collect_collectibles(api.collectibles)
--fields(api.flower_zones)


notify('QMW | Bee Swarm Simulator', 'Succesfully Loaded Functions!')











local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/weakhoes/Roblox-UI-Libs/main/Venus%20Lib/Venus%20Lib%20Source.lua"))()

--local watermark = library:Watermark("watermark | 60 fps | v4.20 | dev")
-- watermark:Set("Watermark Set")
-- watermark:Hide() -- toggles watermark

local main = library:Load{
    Name = "QWM | Bee Swarm",
    SizeX = 600,
    SizeY = 500,
    Theme = "Midnight",
    Extension = "json", -- config file extension
    Folder = "qwm_bss" -- config folder name
}

-- library.Extension = "txt" (config file extension)
-- library.Folder = "config folder name"

local tab = main:Tab("Farm")

local section = tab:Section{
    Name = "Main Farming Options",
    Side = "Left"
}

local label = section:Label('One-time functions')

section:Button{
    Name = 'Get All Collectibles',
    Callback = function()
        collect_collectibles(collectibles)
    end
}

section:Button{
    Name = 'Get All Daily Stickers',
    Callback = function()
        for i = 1 ,100 do
            game:GetService("ReplicatedStorage").Events.HiddenStickerEvent:FireServer(i)
            print(i)
        end
    end
}


local seperator = section:Separator("Separator")

local Farming_section = tab:Section{
    Name = 'Main Farming Options',
    Side = 'Left'
}








local teleports = main:Tab("Teleports")

local teleports_section = teleports:section{
    Name = 'Teleports',
    Side = 'Left'
}
-- NPCBees, HiddenStickers, Monsters, MonsterSpawners, NPCs, shops
teleports_section:Dropdown{
    Name = 'Fields Teleporter',
    Content = all_fields,
    Flag = 'Dropdown 1',
    Scrollable = true,
    ScrollingMax = 8,
    Callback = function(option)
        if option ~= nil then
            localplayer.Character.HumanoidRootPart.CFrame = flower_zones:FindFirstChild(option).CFrame
        end
    end
}

teleports_section:Dropdown{
    Name = 'Hidden Stickers Teleporter',
    Content = HiddenStickers_array,
    Flag = 'Dropdown 1',
    Scrollable = true,
    ScrollingMax = 8,
    Callback = function(option)
        if option ~= nil then
            localplayer.Character.HumanoidRootPart.CFrame = HiddenStickers:FindFirstChild(option).CFrame
        end
    end
}

teleports_section:Dropdown{
    Name = 'Monsters Spawner Teleporter',
    Content = MonsterSpawners_array,
    Flag = 'Dropdown 1',
    Scrollable = true,
    ScrollingMax = 8,
    Callback = function(option)
        if option ~= nil then
            localplayer.Character.HumanoidRootPart.CFrame = MonsterSpawners:FindFirstChild(option).CFrame
        end
    end
}



local Misc = main:Tab("Misc")

local Misc_section = Misc:Section{
    Name = 'World Settings',
    Side = 'Left'
}

Misc_section:Slider{
    Name = 'WalkSpeed',
    Text = '[value]/1',
    Default = 50,
    Min = 50,
    Max = 200,
    Flag = 'WalkSpeed Flag 1',
    Callback = function(value)
        --game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
}





local Settings = main:Tab("Settings")

local Settings_world = Settings:Section{
    Name = 'World Settings',
    Side = 'Left'
}

Settings_world:Button{
    Name = 'Disable Decorations',
    Callback = function()
        for i,v in ipairs(flower_decos:GetChildren()) do
            if v:IsA("BasePart") then
                v.Transparency = 0.5
                v.CanCollide = false
            end
        end
    end
}

Settings_world:Toggle{
    Name = 'Auto Dig',
    Flag = 'Auto Dig Flag',
    Callback = function(bool)
        print('Fuck roblox loops')
    end
}


local Timers = main:Tab("Timers")

local Timers_section = Timers:section{
    Name = 'Timers for Mobs',
    Side = 'Left'
}




local configs = main:Tab("Configuration")

local themes = configs:Section{Name = "Theme", Side = "Left"}

local themepickers = {}

local themelist = themes:Dropdown{
    Name = "Theme",
    Default = library.currenttheme,
    Content = library:GetThemes(),
    Flag = "Theme Dropdown",
    Callback = function(option)
        if option then
            library:SetTheme(option)

            for option, picker in next, themepickers do
                picker:Set(library.theme[option])
            end
        end
    end
}

library:ConfigIgnore("Theme Dropdown")

local namebox = themes:Box{
    Name = "Custom Theme Name",
    Placeholder = "Custom Theme",
    Flag = "Custom Theme"
}

library:ConfigIgnore("Custom Theme")

themes:Button{
    Name = "Save Custom Theme",
    Callback = function()
        if library:SaveCustomTheme(library.flags["Custom Theme"]) then
            themelist:Refresh(library:GetThemes())
            themelist:Set(library.flags["Custom Theme"])
            namebox:Set("")
        end
    end
}

local customtheme = configs:Section{Name = "Custom Theme", Side = "Right"}

themepickers["Accent"] = customtheme:ColorPicker{
    Name = "Accent",
    Default = library.theme["Accent"],
    Flag = "Accent",
    Callback = function(color)
        library:ChangeThemeOption("Accent", color)
    end
}

library:ConfigIgnore("Accent")

themepickers["Window Background"] = customtheme:ColorPicker{
    Name = "Window Background",
    Default = library.theme["Window Background"],
    Flag = "Window Background",
    Callback = function(color)
        library:ChangeThemeOption("Window Background", color)
    end
}

library:ConfigIgnore("Window Background")

themepickers["Window Border"] = customtheme:ColorPicker{
    Name = "Window Border",
    Default = library.theme["Window Border"],
    Flag = "Window Border",
    Callback = function(color)
        library:ChangeThemeOption("Window Border", color)
    end
}

library:ConfigIgnore("Window Border")

themepickers["Tab Background"] = customtheme:ColorPicker{
    Name = "Tab Background",
    Default = library.theme["Tab Background"],
    Flag = "Tab Background",
    Callback = function(color)
        library:ChangeThemeOption("Tab Background", color)
    end
}

library:ConfigIgnore("Tab Background")

themepickers["Tab Border"] = customtheme:ColorPicker{
    Name = "Tab Border",
    Default = library.theme["Tab Border"],
    Flag = "Tab Border",
    Callback = function(color)
        library:ChangeThemeOption("Tab Border", color)
    end
}

library:ConfigIgnore("Tab Border")

themepickers["Tab Toggle Background"] = customtheme:ColorPicker{
    Name = "Tab Toggle Background",
    Default = library.theme["Tab Toggle Background"],
    Flag = "Tab Toggle Background",
    Callback = function(color)
        library:ChangeThemeOption("Tab Toggle Background", color)
    end
}

library:ConfigIgnore("Tab Toggle Background")

themepickers["Section Background"] = customtheme:ColorPicker{
    Name = "Section Background",
    Default = library.theme["Section Background"],
    Flag = "Section Background",
    Callback = function(color)
        library:ChangeThemeOption("Section Background", color)
    end
}

library:ConfigIgnore("Section Background")

themepickers["Section Border"] = customtheme:ColorPicker{
    Name = "Section Border",
    Default = library.theme["Section Border"],
    Flag = "Section Border",
    Callback = function(color)
        library:ChangeThemeOption("Section Border", color)
    end
}

library:ConfigIgnore("Section Border")

themepickers["Text"] = customtheme:ColorPicker{
    Name = "Text",
    Default = library.theme["Text"],
    Flag = "Text",
    Callback = function(color)
        library:ChangeThemeOption("Text", color)
    end
}

library:ConfigIgnore("Text")

themepickers["Disabled Text"] = customtheme:ColorPicker{
    Name = "Disabled Text",
    Default = library.theme["Disabled Text"],
    Flag = "Disabled Text",
    Callback = function(color)
        library:ChangeThemeOption("Disabled Text", color)
    end
}

library:ConfigIgnore("Disabled Text")

themepickers["Object Background"] = customtheme:ColorPicker{
    Name = "Object Background",
    Default = library.theme["Object Background"],
    Flag = "Object Background",
    Callback = function(color)
        library:ChangeThemeOption("Object Background", color)
    end
}

library:ConfigIgnore("Object Background")

themepickers["Object Border"] = customtheme:ColorPicker{
    Name = "Object Border",
    Default = library.theme["Object Border"],
    Flag = "Object Border",
    Callback = function(color)
        library:ChangeThemeOption("Object Border", color)
    end
}

library:ConfigIgnore("Object Border")

themepickers["Dropdown Option Background"] = customtheme:ColorPicker{
    Name = "Dropdown Option Background",
    Default = library.theme["Dropdown Option Background"],
    Flag = "Dropdown Option Background",
    Callback = function(color)
        library:ChangeThemeOption("Dropdown Option Background", color)
    end
}

library:ConfigIgnore("Dropdown Option Background")

local configsection = configs:Section{Name = "Configs", Side = "Left"}

local configlist = configsection:Dropdown{
    Name = "Configs",
    Content = library:GetConfigs(), -- GetConfigs(true) if you want universal configs
    Flag = "Config Dropdown"
}

library:ConfigIgnore("Config Dropdown")

local loadconfig = configsection:Button{
    Name = "Load Config",
    Callback = function()
        library:LoadConfig(library.flags["Config Dropdown"]) -- LoadConfig(library.flags["Config Dropdown"], true)  if you want universal configs
    end
}

local delconfig = configsection:Button{
    Name = "Delete Config",
    Callback = function()
        library:DeleteConfig(library.flags["Config Dropdown"]) -- DeleteConfig(library.flags["Config Dropdown"], true)  if you want universal configs
        configlist:Refresh(library:GetConfigs())
    end
}


local configbox = configsection:Box{
    Name = "Config Name",
    Placeholder = "Config Name",
    Flag = "Config Name"
}

library:ConfigIgnore("Config Name")

local save = configsection:Button{
    Name = "Save Config",
    Callback = function()
        library:SaveConfig(library.flags["Config Dropdown"] or library.flags["Config Name"]) -- SaveConfig(library.flags["Config Name"], true) if you want universal configs
        configlist:Refresh(library:GetConfigs())
    end
}

local keybindsection = configs:Section{Name = "UI Toggle Keybind", Side = "Left"}

keybindsection:Keybind{
    Name = "UI Toggle",
    Flag = "UI Toggle",
    Default = Enum.KeyCode.Insert,
    Blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3},
    Callback = function(_, fromsetting)
        if not fromsetting then
            library:Close()
        end
    end
}

keybindsection:Keybind{
    Name = "Destroy UI",
    Flag = "Unload UI",
    Default = Enum.KeyCode.Delete,
    Blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3},
    Callback = function(_, fromsetting)
        if not fromsetting then
            library:Unload()
        end
    end
}


--library:Close()
--library:Unload()


notify('QMW | Bee Swarm Simulator', 'Succesfully Loaded UI!')
