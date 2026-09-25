local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "My Rayfield Menu",
    LoadingTitle = "Loading Suite...",
    LoadingSubtitle = "by Developer",
    Theme = "Default",
    ConfigurationSaving = {
        Enabled = false
    }
})

local MainTab = Window:CreateTab("Main Features", "home")

MainTab:CreateSection("Movement")

MainTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 100},
    Increment = 1,
    Suffix = " Speed",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        local character = game.Players.LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid.WalkSpeed = Value
        end
    end
})

MainTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 150},
    Increment = 1,
    Suffix = " Power",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        local character = game.Players.LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid.JumpPower = Value
        end
    end
})

MainTab:CreateToggle({
    Name = "Reset Movement",
    CurrentValue = false,
    Flag = "ResetMovement",
    Callback = function(Value)
        if Value then
            local character = game.Players.LocalPlayer.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")

            if humanoid then
                humanoid.WalkSpeed = 16
                humanoid.JumpPower = 50
            end
        end
    end
})
