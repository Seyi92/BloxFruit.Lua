local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

local Window = Rayfield:CreateWindow({
    name = "Heavenly Hub",
    subtitle = "Heavenly",
    sidebarLayout = true,
})

local PlayerTab = Window:CreateTab({
    name = "Player",
})
PlayerTab:CreateToggle({
    name = "Player ESP",
    default = false,

    callback = function(Value)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local esp = player.Character:FindFirstChild("PlayerESP")

                if Value then
                    if not esp then
                        esp = Instance.new("Highlight")
                        esp.Name = "PlayerESP"
                        esp.Adornee = player.Character
                        esp.FillTransparency = 0.5
                        esp.OutlineTransparency = 0
                        esp.Parent = player.Character
                    end
                elseif esp then
                    esp:Destroy()
                end
            end
        end
    end,
})

local MiscTab = Window:CreateTab({
    name = "Misc",
})

local TravelTab = Window:CreateTab({
    name = "Travel",
})

local SeaTab = Window:CreateTab({
    name = "Sea",
})

local FarmingTab = Window:CreateTab({
    name = "Farming",
})
