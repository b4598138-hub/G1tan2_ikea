-- 📥 Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local MainWindow = Rayfield:CreateWindow({
    Name = "GitanX Hub",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "GitanX Hub",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Universal"
    },
    Discord = { Enabled = false },
    KeySystem = false
})

-- 🧩 Onglet Scripts
local ScriptTab = MainWindow:CreateTab("📜 Scripts", 4483362458)

-- 🥋 War Chicago Realistic
ScriptTab:CreateButton({
    Name = "War Chicago Realistic",
    Callback = function()
        if game.PlaceId == 89166445585239 then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/GitanX/G1tan2_ikea/refs/heads/main/hdfhs.lua"))()
        else
            Rayfield:Notify({
                Title = "Bad game",
                Content = "Go in the game War chicago realistic.",
                Duration = 4
            })
        end
    end
})

-- 🚨 Emergency Hamburg
ScriptTab:CreateButton({
    Name = "Emergency Hamburg",
    Callback = function()
        if game.PlaceId == 7711635737 then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/GitanX/G1tan2_ikea/refs/heads/main/fgdy.lua"))()
        else
            Rayfield:Notify({
                Title = "Bad game",
                Content = "Go in the game Emergency Hamburg",
                Duration = 4
            })
        end
    end
})

ScriptTab:CreateButton({
    Name = "Blade Ball",
    Callback = function()
        if game.PlaceId == 13772394625  then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/HIT_hub.lua"))()
        else
            Rayfield:Notify({
                Title = "Bad game",
                Content = "Go in the game Blade Ball",
                Duration = 4
            })
        end
    end
})

-- 🏙️ Street Life Remastered
ScriptTab:CreateButton({
    Name = "Street Life Remastered",
    Callback = function()
        if game.PlaceId == 71600459831333 then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/GitanX/G1tan2_ikea/main/Gitan2_ikea.lua"))()
        else
            Rayfield:Notify({
                Title = "Bad game",
                Content = "Go in the game Street Life Remastered",
                Duration = 4
            })
        end
    end
})
local CreditsTab = MainWindow:CreateTab("📜 Crédits", 6031075938)
CreditsTab:CreateParagraph({
    Title = "Important",
    Content = "You must be in the game and open the script for this game for it to work."
})
CreditsTab:CreateParagraph({
    Title = "Owner",
    Content = "G1tan2_ikea"
})
CreditsTab:CreateParagraph({
    Title = "Co-Owner",
    Content = "arracheur2_92i"
})


CreditsTab:CreateButton({
    Name = "Copy Discord",
    Callback = function()
        setclipboard("https://discord.gg/nqVTXUeDHk")
        Rayfield:Notify({
            Title = "Link copied",
            Content = "Discord copied",
            Duration = 3
        })
    end
})
