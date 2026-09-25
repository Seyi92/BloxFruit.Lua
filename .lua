--// Blox Fruits Style - Rayfield Testing Hub
--// For use in your own Roblox experience

local Rayfield = loadstring(game:HttpGet(
    "https://sirius.menu/rayfield"
))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    Name = "Blox Fruits | Testing Hub",
    LoadingTitle = "Blox Fruits Testing Hub",
    LoadingSubtitle = "Development / Testing",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BFTestingHub",
        FileName = "Settings"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

--// Variables
local Speed = 16
local JumpPower = 50
local FlyEnabled = false
local NoclipEnabled = false
local ESPEnabled = false
local InfEnergy = false

local FlyConnection
local NoclipConnection
local ESPConnection

--// Character
local function GetCharacter()
    return Player.Character or Player.CharacterAdded:Wait()
end

local function GetHumanoid()
    local Character = GetCharacter()
    return Character:FindFirstChildOfClass("Humanoid")
end

--// MAIN
local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 150},
    Increment = 1,
    Suffix = " Speed",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        Speed = Value

        local Humanoid = GetHumanoid()
        if Humanoid then
            Humanoid.WalkSpeed = Value
        end
    end
})

MainTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200},
    Increment = 1,
    Suffix = " Power",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        JumpPower = Value

        local Humanoid = GetHumanoid()
        if Humanoid then
            Humanoid.UseJumpPower = true
            Humanoid.JumpPower = Value
        end
    end
})

MainTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(Value)

        FlyEnabled = Value

        if FlyConnection then
            FlyConnection:Disconnect()
            FlyConnection = nil
        end

        if not Value then
            return
        end

        FlyConnection = RunService.RenderStepped:Connect(function()
            local Character = Player.Character
            local Root = Character and Character:FindFirstChild("HumanoidRootPart")

            if not Root then
                return
            end

            local Camera = workspace.CurrentCamera
            local Direction = Vector3.zero

            if UIS:IsKeyDown(Enum.KeyCode.W) then
                Direction += Camera.CFrame.LookVector
            end

            if UIS:IsKeyDown(Enum.KeyCode.S) then
                Direction -= Camera.CFrame.LookVector
            end

            if UIS:IsKeyDown(Enum.KeyCode.A) then
                Direction -= Camera.CFrame.RightVector
            end

            if UIS:IsKeyDown(Enum.KeyCode.D) then
                Direction += Camera.CFrame.RightVector
            end

            if UIS:IsKeyDown(Enum.KeyCode.Space) then
                Direction += Vector3.new(0, 1, 0)
            end

            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
                Direction -= Vector3.new(0, 1, 0)
            end

            if Direction.Magnitude > 0 then
                Root.AssemblyLinearVelocity =
                    Direction.Unit * Speed
            else
                Root.AssemblyLinearVelocity = Vector3.zero
            end
        end)
    end
})

MainTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(Value)

        NoclipEnabled = Value

        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end

        if not Value then
            return
        end

        NoclipConnection = RunService.Stepped:Connect(function()

            if not NoclipEnabled then
                return
            end

            local Character = Player.Character

            if Character then
                for _, Object in ipairs(Character:GetDescendants()) do
                    if Object:IsA("BasePart") then
                        Object.CanCollide = false
                    end
                end
            end
        end)
    end
})

MainTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        local Humanoid = GetHumanoid()

        if Humanoid then
            Humanoid.Health = 0
        end
    end
})

--// PLAYER TAB
local PlayerTab = Window:CreateTab("Player", 4483362458)

PlayerTab:CreateToggle({
    Name = "Infinite Energy",
    CurrentValue = false,
    Flag = "InfiniteEnergy",
    Callback = function(Value)
        InfEnergy = Value

        task.spawn(function()
            while InfEnergy do
                local Character = Player.Character

                if Character then
                    local Energy = Character:FindFirstChild("Energy")

                    if Energy and Energy:IsA("NumberValue") then
                        Energy.Value = Energy.MaxValue or 100
                    end
                end

                task.wait(0.1)
            end
        end)
    end
})

PlayerTab:CreateButton({
    Name = "Restore Health",
    Callback = function()
        local Humanoid = GetHumanoid()

        if Humanoid then
            Humanoid.Health = Humanoid.MaxHealth
        end
    end
})

PlayerTab:CreateButton({
    Name = "Restore Energy",
    Callback = function()
        local Character = GetCharacter()
        local Energy = Character:FindFirstChild("Energy")

        if Energy and Energy:IsA("NumberValue") then
            Energy.Value = Energy.MaxValue or 100
        end
    end
})

--// TELEPORT TAB
local TeleportTab = Window:CreateTab("Teleport", 4483362458)

local Locations = {}

for _, Object in ipairs(workspace:GetDescendants()) do
    if Object:IsA("BasePart") and Object.Name == "TeleportPoint" then
        table.insert(Locations, Object.Name)
    end
end

TeleportTab:CreateInput({
    Name = "Teleport Position",
    PlaceholderText = "X, Y, Z",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)

        local X, Y, Z = Text:match(
            "([%-%.%d]+)%s*,%s*([%-%.%d]+)%s*,%s*([%-%.%d]+)"
        )

        if X and Y and Z then
            local Character = GetCharacter()
            local Root = Character:FindFirstChild("HumanoidRootPart")

            if Root then
                Root.CFrame = CFrame.new(
                    tonumber(X),
                    tonumber(Y),
                    tonumber(Z)
                )
            end
        end
    end
})

--// ESP / DEBUG TAB
local ESPTab = Window:CreateTab("ESP / Debug", 4483362458)

local ESPObjects = {}

local function RemoveESP()

    for _, Object in pairs(ESPObjects) do
        if Object then
            Object:Destroy()
        end
    end

    table.clear(ESPObjects)
end

local function CreateESP(PlayerObject)

    if PlayerObject == Player then
        return
    end

    local Character = PlayerObject.Character

    if not Character then
        return
    end

    local Head = Character:FindFirstChild("Head")

    if not Head then
        return
    end

    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "DebugESP"
    Billboard.Size = UDim2.new(0, 150, 0, 40)
    Billboard.StudsOffset = Vector3.new(0, 3, 0)
    Billboard.AlwaysOnTop = true
    Billboard.Parent = Head

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.fromScale(1, 1)
    Label.BackgroundTransparency = 1
    Label.Text = PlayerObject.Name
    Label.TextScaled = true
    Label.TextStrokeTransparency = 0
    Label.Parent = Billboard

    table.insert(ESPObjects, Billboard)
end

ESPTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Flag = "PlayerESP",
    Callback = function(Value)

        ESPEnabled = Value

        RemoveESP()

        if not Value then
            return
        end

        for _, PlayerObject in ipairs(Players:GetPlayers()) do
            CreateESP(PlayerObject)
        end
    end
})

Players.PlayerAdded:Connect(function(PlayerObject)

    if ESPEnabled then
        PlayerObject.CharacterAdded:Connect(function()
            task.wait(1)

            if ESPEnabled then
                CreateESP(PlayerObject)
            end
        end)
    end
end)

--// COMBAT TESTING
local CombatTab = Window:CreateTab("Combat", 4483362458)

CombatTab:CreateDropdown({
    Name = "Target Player",
    Options = {},
    CurrentOption = {},
    MultipleOptions = false,
    Flag = "TargetPlayer",
    Callback = function(Option)
        -- Target selection can be connected
        -- to your game's combat-testing system.
    end
})

CombatTab:CreateButton({
    Name = "Refresh Players",
    Callback = function()

        local Names = {}

        for _, PlayerObject in ipairs(Players:GetPlayers()) do
            if PlayerObject ~= Player then
                table.insert(Names, PlayerObject.Name)
            end
        end

        Rayfield:Notify({
            Title = "Players",
            Content = "Found " .. #Names .. " players.",
            Duration = 3
        })
    end
})

--// SETTINGS
local SettingsTab = Window:CreateTab("Settings", 4483362458)

SettingsTab:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        RemoveESP()

        if FlyConnection then
            FlyConnection:Disconnect()
        end

        if NoclipConnection then
            NoclipConnection:Disconnect()
        end

        Rayfield:Destroy()
    end
})

Rayfield:Notify({
    Title = "Testing Hub Loaded",
    Content = "Rayfield testing menu is ready.",
    Duration = 5
})
