-- Chargement Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Street Life Hub|G1tan2_ikea",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by G1tan2_ikea",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "SLR_ESP",
        FileName = "Settings"
    },
    KeySystem = false
})

local ESPTab = Window:CreateTab("ESP", 4483362458)

-- Variables ESP
local ESPEnabled = false
local showName = false
local showDistance = false
local showHP = false
local civiliansColor = Color3.fromRGB(0, 255, 0)
local ESPGui = {}

-- Variables ESP Charm
local charmEnabled = false
local charmColor = Color3.fromRGB(255, 255, 255)
local charmHighlights = {}

-- Fonction ESP classique
function createESP(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    if ESPGui[player] then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP"
    billboard.Adornee = player.Character.HumanoidRootPart
    billboard.Size = UDim2.new(0, 150, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = game.CoreGui

    local textLabel = Instance.new("TextLabel", billboard)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextStrokeTransparency = 0.5
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 14
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Text = ""

    ESPGui[player] = {Gui = billboard, Label = textLabel}
end

function removeESP(player)
    if ESPGui[player] then
        ESPGui[player].Gui:Destroy()
        ESPGui[player] = nil
    end
end

function updateESP()
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local root = localPlayer.Character.HumanoidRootPart.Position

    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not ESPGui[player] then
                createESP(player)
            end

            local dist = math.floor((player.Character.HumanoidRootPart.Position - root).Magnitude)
            local hp = player.Character:FindFirstChild("Humanoid") and math.floor(player.Character.Humanoid.Health) or "?"
            local label = ESPGui[player].Label

            local text = ""
            if showName then
                text = player.Name
            end
            if showDistance then
                local distText = dist .. "m"
                text = text ~= "" and (text .. " | " .. distText) or distText
            end
            if showHP then
                local hpText = "HP: " .. hp
                text = text ~= "" and (text .. " | " .. hpText) or hpText
            end

            label.Text = text

            if player.Team and player.Team.Name == "Civilians" then
                label.TextColor3 = civiliansColor
            else
                label.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        else
            removeESP(player)
        end
    end
end

-- ESP Charm
function enableCharmESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not charmHighlights[player] then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = player.Character
                highlight.FillTransparency = 0.7
                highlight.OutlineTransparency = 0.2
                highlight.FillColor = charmColor
                highlight.OutlineColor = charmColor
                highlight.Parent = game.CoreGui
                charmHighlights[player] = highlight
            end
        end
    end
end

function updateCharmESP()
    for player, highlight in pairs(charmHighlights) do
        if highlight and player.Character then
            highlight.FillColor = charmColor
            highlight.OutlineColor = charmColor
            highlight.Adornee = player.Character
        end
    end

    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not charmHighlights[player] then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = player.Character
                highlight.FillTransparency = 0.7
                highlight.OutlineTransparency = 0.2
                highlight.FillColor = charmColor
                highlight.OutlineColor = charmColor
                highlight.Parent = game.CoreGui
                charmHighlights[player] = highlight
            end
        end
    end
end

function disableCharmESP()
    for _, highlight in pairs(charmHighlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    charmHighlights = {}
end

-- UI ESP
ESPTab:CreateToggle({
    Name = "Enable ESP",
    CurrentValue = false,
    Callback = function(state)
        ESPEnabled = state
        if not state then
            for _, player in pairs(game.Players:GetPlayers()) do
                removeESP(player)
            end
        end
    end,
})

ESPTab:CreateToggle({
    Name = "ESP Pseudo",
    CurrentValue = false,
    Callback = function(state)
        showName = state
    end,
})

ESPTab:CreateToggle({
    Name = "ESP Distance",
    CurrentValue = false,
    Callback = function(state)
        showDistance = state
    end,
})

ESPTab:CreateToggle({
    Name = "ESP HP",
    CurrentValue = false,
    Callback = function(state)
        showHP = state
    end,
})

ESPTab:CreateColorPicker({
    Name = "Color ESP",
    Color = civiliansColor,
    Callback = function(color)
        civiliansColor = color
        for player, gui in pairs(ESPGui) do
            if player.Team and player.Team.Name == "Civilians" then
                gui.Label.TextColor3 = civiliansColor
            end
        end
    end,
})

ESPTab:CreateToggle({
    Name = "ESP Charm",
    CurrentValue = false,
    Callback = function(state)
        charmEnabled = state
        if state then
            enableCharmESP()
        else
            disableCharmESP()
        end
    end,
})

ESPTab:CreateColorPicker({
    Name = "Color ESP Charm",
    Color = charmColor,
    Callback = function(color)
        charmColor = color
        for _, highlight in pairs(charmHighlights) do
            if highlight then
                highlight.FillColor = charmColor
                highlight.OutlineColor = charmColor
            end
        end
    end,
})

-- Mise à jour continue
game:GetService("RunService").RenderStepped:Connect(function()
    if ESPEnabled then
        updateESP()
    end
    if charmEnabled then
        updateCharmESP()
    end
end)

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1)
        if ESPEnabled then
            createESP(player)
        end
        if charmEnabled then
            enableCharmESP()
        end
    end)
end)
local VisualTab = Window:CreateTab("Visual", 4483362458)

-- Variables Ghost Mode
local ghostEnabled = false
local ghostColor = Color3.fromRGB(170, 0, 255) -- Violet spectral par défaut

-- Fonction pour appliquer le Ghost Mode
function applyGhostMode()
    local char = game.Players.LocalPlayer.Character
    if not char then return end

    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = 0.6
            part.Material = Enum.Material.ForceField
            part.Color = ghostColor
        end
    end
end

-- Fonction pour désactiver le Ghost Mode
function removeGhostMode()
    local char = game.Players.LocalPlayer.Character
    if not char then return end

    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = 0
            part.Material = Enum.Material.Plastic
            part.Color = Color3.fromRGB(255, 255, 255)
        end
    end
end

-- Réactivation après respawn
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    if ghostEnabled then
        applyGhostMode()
    end
end)

-- UI Visual
VisualTab:CreateSection("Mode Ghost")

VisualTab:CreateToggle({
    Name = "Mode Ghost",
    CurrentValue = false,
    Callback = function(state)
        ghostEnabled = state
        if state then
            applyGhostMode()
        else
            removeGhostMode()
        end
    end,
})

VisualTab:CreateColorPicker({
    Name = "Ghost color",
    Color = ghostColor,
    Callback = function(color)
        ghostColor = color
        if ghostEnabled then
            applyGhostMode()
        end
    end,
})
local GunTab = Window:CreateTab("Gun", 4483362458)

GunTab:CreateButton({
    Name = "Ammo infini",
    Callback = function()
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()

        -- Scan du personnage
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                if tool:GetAttribute("Ammo_Server") then
                    tool:SetAttribute("Ammo_Server", 999999)
                    print("✅ Ammo_Server modifié")
                end
                if tool:GetAttribute("Ammo_Client") then
                    tool:SetAttribute("Ammo_Client", 999999)
                    print("✅ Ammo_Client modifié")
                end
            end
        end

        -- Scan du sac à dos aussi
        for _, tool in pairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                if tool:GetAttribute("Ammo_Server") then
                    tool:SetAttribute("Ammo_Server", 999999)
                    print("✅ Ammo_Server modifié (sac)")
                end
                if tool:GetAttribute("Ammo_Client") then
                    tool:SetAttribute("Ammo_Client", 999999)
                    print("✅ Ammo_Client modifié (sac)")
                end
            end
        end
    end,
})
local FlyTab = Window:CreateTab("Fly", 4483362458)

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

local flying = false
local flySpeed = 50
local bodyVelocity = nil

local moveInput = {
    Forward = false,
    Backward = false,
    Left = false,
    Right = false,
    Up = false,
    Down = false
}

-- ✅ TOGGLE FLY
FlyTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(state)
        flying = state
        if flying then
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = root
            char:FindFirstChildOfClass("Humanoid").PlatformStand = true
        else
            if bodyVelocity then bodyVelocity:Destroy() end
            char:FindFirstChildOfClass("Humanoid").PlatformStand = false
            root.Velocity = Vector3.zero
        end
    end,
})

-- 🎚️ SLIDER VITESSE
FlyTab:CreateSlider({
    Name = "Fly speed",
    Range = {10, 200},
    Increment = 10,
    Suffix = "Studs/s",
    CurrentValue = 50,
    Callback = function(value)
        flySpeed = value
    end,
})
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.W then moveInput.Forward = true end
    if input.KeyCode == Enum.KeyCode.S then moveInput.Backward = true end
    if input.KeyCode == Enum.KeyCode.A then moveInput.Left = true end
    if input.KeyCode == Enum.KeyCode.D then moveInput.Right = true end
    if input.KeyCode == Enum.KeyCode.Space then moveInput.Up = true end
    if input.KeyCode == Enum.KeyCode.LeftControl then moveInput.Down = true end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then moveInput.Forward = false end
    if input.KeyCode == Enum.KeyCode.S then moveInput.Backward = false end
    if input.KeyCode == Enum.KeyCode.A then moveInput.Left = false end
    if input.KeyCode == Enum.KeyCode.D then moveInput.Right = false end
    if input.KeyCode == Enum.KeyCode.Space then moveInput.Up = false end
    if input.KeyCode == Enum.KeyCode.LeftControl then moveInput.Down = false end
end)
RunService.RenderStepped:Connect(function()
    if flying and bodyVelocity and root then
        local cam = workspace.CurrentCamera
        local move = Vector3.zero

        if moveInput.Forward then move += cam.CFrame.LookVector end
        if moveInput.Backward then move -= cam.CFrame.LookVector end
        if moveInput.Left then move -= cam.CFrame.RightVector end
        if moveInput.Right then move += cam.CFrame.RightVector end
        if moveInput.Up then move += Vector3.new(0, 1, 0) end
        if moveInput.Down then move -= Vector3.new(0, 1, 0) end

        bodyVelocity.Velocity = move.Magnitude > 0 and move.Unit * flySpeed or Vector3.zero
    end
end)
