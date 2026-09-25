local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

local Window = Rayfield:CreateWindow({
    name = "Game Hub",
    subtitle = "Rayfield Gen2",
    sidebarLayout = true,
})

local PlayerTab = Window:CreateTab({
    name = "Player",
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
