--==================================================
-- RAYFIELD TEST HUB
--==================================================

local Rayfield = loadstring(game:HttpGet(
    "https://sirius.menu/rayfield"
))()

--==================================================
-- WINDOW
--==================================================

local Window = Rayfield:CreateWindow({
    Name = "Blox-Style Test Hub",
    LoadingTitle = "Blox-Style Test Hub",
    LoadingSubtitle = "Rayfield",
    Theme = "Default",

    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BloxStyleTestHub",
        FileName = "Configuration"
    },

    Discord = {
        Enabled = false
    },

    KeySystem = false
})

--==================================================
-- TABS
--==================================================

local Main = Window:CreateTab("Main")
local Movement = Window:CreateTab("Movement")
local Combat = Window:CreateTab("Combat")
local Sea = Window:CreateTab("Sea Events")
local Stats = Window:CreateTab("Stats")
local Player = Window:CreateTab("Player")
local Teleport = Window:CreateTab("Teleport")
local Developer = Window:CreateTab("Developer")
local Server = Window:CreateTab("Server")
local Settings = Window:CreateTab("Settings")

--==================================================
-- SETTINGS
--==================================================

local Config = {
    Fly = false,
    Noclip = false,
    InfiniteJump = false,
    WalkSpeed = 16,
    JumpPower = 50,

    AimAssist = false,
    CameraLock = false,
    AutoFlashStep = false,
    InfiniteEnergy = false,

    LevelFarm = false,
    MaxLevelFarm = false,
    AutoAttack = false,
    AutoSelectEnemy = false,
    AutoEquip = false,

    SeaFarm = false,
    AutoSail = false,
    AutoFindEvent = false,
    AutoAttackEvent = false,
    AutoCollectRewards = false,

    DamageTesting = false,
    CooldownTesting = false,
    HitboxTesting = false,

    DangerLevel = "Level 1 - Low",

    TargetPlayer = nil,

    X = 0,
    Y = 0,
    Z = 0
}

--==================================================
-- NOTIFICATION
--==================================================

local function Notify(title, message)
    Rayfield:Notify({
        Title = title,
        Content = message,
        Duration = 3
    })
end

--==================================================
-- MAIN
--==================================================

Main:CreateSection("Farming")

Main:CreateToggle({
    Name = "Level Farm",
    CurrentValue = false,
    Flag = "LevelFarm",

    Callback = function(Value)
        Config.LevelFarm = Value
    end
})

Main:CreateToggle({
    Name = "Farm to Max Level",
    CurrentValue = false,
    Flag = "MaxLevelFarm",

    Callback = function(Value)
        Config.MaxLevelFarm = Value
    end
})

Main:CreateToggle({
    Name = "Auto Attack",
    CurrentValue = false,
    Flag = "AutoAttack",

    Callback = function(Value)
        Config.AutoAttack = Value
    end
})

Main:CreateToggle({
    Name = "Auto Select Enemy",
    CurrentValue = false,
    Flag = "AutoSelectEnemy",

    Callback = function(Value)
        Config.AutoSelectEnemy = Value
    end
})

Main:CreateToggle({
    Name = "Auto Equip Weapon",
    CurrentValue = false,
    Flag = "AutoEquip",

    Callback = function(Value)
        Config.AutoEquip = Value
    end
})

--==================================================
-- MOVEMENT
--==================================================

Movement:CreateSection("Movement")

Movement:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "Fly",

    Callback = function(Value)
        Config.Fly = Value
    end
})

Movement:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "Noclip",

    Callback = function(Value)
        Config.Noclip = Value
    end
})

Movement:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJump",

    Callback = function(Value)
        Config.InfiniteJump = Value
    end
})

Movement:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 150},
    Increment = 1,
    Suffix = " Speed",
    CurrentValue = 16,
    Flag = "WalkSpeed",

    Callback = function(Value)
        Config.WalkSpeed = Value
    end
})

Movement:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200},
    Increment = 1,
    Suffix = " Power",
    CurrentValue = 50,
    Flag = "JumpPower",

    Callback = function(Value)
        Config.JumpPower = Value
    end
})

Movement:CreateButton({
    Name = "Reset Movement",

    Callback = function()
        Config.Fly = false
        Config.Noclip = false
        Config.InfiniteJump = false
        Config.WalkSpeed = 16
        Config.JumpPower = 50

        Notify("Movement", "Movement settings reset")
    end
})

--==================================================
-- COMBAT
--==================================================

Combat:CreateSection("Testing")

Combat:CreateToggle({
    Name = "Damage Testing",
    CurrentValue = false,
    Flag = "DamageTesting",

    Callback = function(Value)
        Config.DamageTesting = Value
    end
})

Combat:CreateToggle({
    Name = "Cooldown Testing",
    CurrentValue = false,
    Flag = "CooldownTesting",

    Callback = function(Value)
        Config.CooldownTesting = Value
    end
})

Combat:CreateToggle({
    Name = "Hitbox Testing",
    CurrentValue = false,
    Flag = "HitboxTesting",

    Callback = function(Value)
        Config.HitboxTesting = Value
    end
})

Combat:CreateButton({
    Name = "Training Dummy",

    Callback = function()
        Notify("Combat", "Training Dummy triggered")
    end
})

--==================================================
-- SEA EVENTS
--==================================================

Sea:CreateSection("Sea Event Farming")

Sea:CreateToggle({
    Name = "Sea Event Farm",
    CurrentValue = false,
    Flag = "SeaEventFarm",

    Callback = function(Value)
        Config.SeaFarm = Value
    end
})

Sea:CreateDropdown({
    Name = "Danger Level",

    Options = {
        "Level 1 - Low",
        "Level 2 - Medium",
        "Level 3 - High",
        "Level 4 - Extreme",
        "Level 5 - Crazy",
        "Level 6 - ???"
    },

    CurrentOption = {"Level 1 - Low"},
    MultipleOptions = false,
    Flag = "DangerLevel",

    Callback = function(Option)
        Config.DangerLevel = Option[1]
    end
})

Sea:CreateToggle({
    Name = "Auto Sail",
    CurrentValue = false,
    Flag = "AutoSail",

    Callback = function(Value)
        Config.AutoSail = Value
    end
})

Sea:CreateToggle({
    Name = "Auto Find Event",
    CurrentValue = false,
    Flag = "AutoFindEvent",

    Callback = function(Value)
        Config.AutoFindEvent = Value
    end
})

Sea:CreateToggle({
    Name = "Auto Attack Event",
    CurrentValue = false,
    Flag = "AutoAttackEvent",

    Callback = function(Value)
        Config.AutoAttackEvent = Value
    end
})

Sea:CreateToggle({
    Name = "Auto Collect Rewards",
    CurrentValue = false,
    Flag = "AutoCollectRewards",

    Callback = function(Value)
        Config.AutoCollectRewards = Value
    end
})

--==================================================
-- STATS
--==================================================

Stats:CreateSection("Stat Points")

local statNames = {
    "Melee",
    "Defense",
    "Sword",
    "Gun",
    "Fruit"
}

for _, StatName in ipairs(statNames) do

    Stats:CreateSlider({
        Name = StatName .. " Points",
        Range = {0, 1000},
        Increment = 1,
        Suffix = " Points",
        CurrentValue = 0,
        Flag = StatName .. "Points",

        Callback = function(Value)
            -- Connect to your own game's stat system here.
        end
    })

end

Stats:CreateButton({
    Name = "Reset Stat Allocation",

    Callback = function()
        Notify("Stats", "Stat allocation reset")
    end
})

--==================================================
-- PLAYER
--==================================================

Player:CreateSection("Targeting")

Player:CreateDropdown({
    Name = "Target Player",
    Options = {},
    CurrentOption = {},
    MultipleOptions = false,
    Flag = "TargetPlayer",

    Callback = function(Option)
        Config.TargetPlayer = Option[1]
    end
})

Player:CreateButton({
    Name = "Refresh Players",

    Callback = function()

        local Players = game:GetService("Players")
        local Names = {}

        for _, Plr in ipairs(Players:GetPlayers()) do
            table.insert(Names, Plr.Name)
        end

        Notify(
            "Players",
            "Found " .. tostring(#Names) .. " players"
        )
    end
})

Player:CreateToggle({
    Name = "Auto Flash Step",
    CurrentValue = false,
    Flag = "AutoFlashStep",

    Callback = function(Value)
        Config.AutoFlashStep = Value
    end
})

Player:CreateToggle({
    Name = "Camera Lock",
    CurrentValue = false,
    Flag = "CameraLock",

    Callback = function(Value)
        Config.CameraLock = Value
    end
})

Player:CreateToggle({
    Name = "Aim Assist",
    CurrentValue = false,
    Flag = "AimAssist",

    Callback = function(Value)
        Config.AimAssist = Value
    end
})

Player:CreateButton({
    Name = "Heal",

    Callback = function()
        Notify("Player", "Heal triggered")
    end
})

Player:CreateButton({
    Name = "Reset Character",

    Callback = function()

        local Character =
            game.Players.LocalPlayer.Character

        local Humanoid =
            Character and
            Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            Humanoid.Health = 0
        end
    end
})

Player:CreateToggle({
    Name = "Infinite Energy",
    CurrentValue = false,
    Flag = "InfiniteEnergy",

    Callback = function(Value)
        Config.InfiniteEnergy = Value
    end
})

--==================================================
-- TELEPORT
--==================================================

Teleport:CreateSection("Teleport")

Teleport:CreateButton({
    Name = "Teleport to Spawn",

    Callback = function()
        Notify("Teleport", "Spawn teleport triggered")
    end
})

Teleport:CreateInput({
    Name = "X Coordinate",
    PlaceholderText = "X",
    RemoveTextAfterFocusLost = false,
    Flag = "XCoordinate",

    Callback = function(Text)
        Config.X = tonumber(Text) or 0
    end
})

Teleport:CreateInput({
    Name = "Y Coordinate",
    PlaceholderText = "Y",
    RemoveTextAfterFocusLost = false,
    Flag = "YCoordinate",

    Callback = function(Text)
        Config.Y = tonumber(Text) or 0
    end
})

Teleport:CreateInput({
    Name = "Z Coordinate",
    PlaceholderText = "Z",
    RemoveTextAfterFocusLost = false,
    Flag = "ZCoordinate",

    Callback = function(Text)
        Config.Z = tonumber(Text) or 0
    end
})

Teleport:CreateButton({
    Name = "Teleport to Coordinates",

    Callback = function()

        local Character =
            game.Players.LocalPlayer.Character

        local Root =
            Character and
            Character:FindFirstChild("HumanoidRootPart")

        if Root then
            Root.CFrame = CFrame.new(
                Config.X,
                Config.Y,
                Config.Z
            )
        end
    end
})

--==================================================
-- DEVELOPER
--==================================================

Developer:CreateSection("Developer Tools")

Developer:CreateToggle({
    Name = "FPS Display",
    CurrentValue = false,
    Flag = "FPSDisplay",

    Callback = function(Value)
        Notify("Developer", "FPS Display: " .. tostring(Value))
    end
})

Developer:CreateToggle({
    Name = "Ping Display",
    CurrentValue = false,
    Flag = "PingDisplay",

    Callback = function(Value)
        Notify("Developer", "Ping Display: " .. tostring(Value))
    end
})

Developer:CreateToggle({
    Name = "Position Display",
    CurrentValue = false,
    Flag = "PositionDisplay",

    Callback = function(Value)
        Notify("Developer", "Position Display: " .. tostring(Value))
    end
})

Developer:CreateButton({
    Name = "Character Info",

    Callback = function()

        local Character =
            game.Players.LocalPlayer.Character

        local Humanoid =
            Character and
            Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then

            Notify(
                "Character Info",
                "Health: " ..
                math.floor(Humanoid.Health)
            )

        end
    end
})

--==================================================
-- SERVER
--==================================================

Server:CreateSection("Server")

Server:CreateButton({
    Name = "Rejoin Server",

    Callback = function()

        game:GetService("TeleportService"):Teleport(
            game.PlaceId,
            game.Players.LocalPlayer
        )
    end
})

Server:CreateButton({
    Name = "Copy Job ID",

    Callback = function()

        if setclipboard then

            setclipboard(game.JobId)

            Notify(
                "Server",
                "Job ID copied"
            )

        else

            Notify(
                "Server",
                "Clipboard unavailable"
            )

        end
    end
})

--==================================================
-- SETTINGS
--==================================================

Settings:CreateSection("Configuration")

Settings:CreateButton({
    Name = "Save Configuration",

    Callback = function()

        pcall(function()
            Rayfield:SaveConfiguration()
        end)

        Notify(
            "Settings",
            "Configuration saved"
        )
    end
})

Settings:CreateButton({
    Name = "Reset Movement",

    Callback = function()

        Config.Fly = false
        Config.Noclip = false
        Config.InfiniteJump = false
        Config.WalkSpeed = 16
        Config.JumpPower = 50

        Notify(
            "Settings",
            "Movement reset"
        )
    end
})

--==================================================
-- LOADED
--==================================================

Rayfield:Notify({
    Title = "Test Hub",
    Content = "Rayfield UI loaded successfully!",
    Duration = 5
})
