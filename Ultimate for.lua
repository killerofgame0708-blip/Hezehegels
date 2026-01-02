-- ============================================
-- 🎮 ULTIMATE SCRIPT VERSI FINAL 🎮
-- Center Dot + Fly + Spectate + Teleport + ESP + God Mode Fix
-- ============================================

-- Tunggu game load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

-- Player
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local playerGui = player:WaitForChild("PlayerGui")

-- Hapus GUI lama jika ada
pcall(function()
    if playerGui:FindFirstChild("FinalGUI") then
        playerGui.FinalGUI:Destroy()
    end
end)

-- ============================================
-- VARIABEL UTAMA
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FinalGUI"
screenGui.DisplayOrder = 999
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- State variables
local dotEnabled = true
local flyEnabled = false
local noclipEnabled = false
local godModeEnabled = false
local spectateEnabled = false
local espEnabled = false
local flySpeed = 50
local spectatingPlayer = nil
local originalCameraType = nil
local flyBV, flyBG
local espFolder = Instance.new("Folder", Workspace)
espFolder.Name = "ESPFolder_" .. player.UserId

-- ============================================
-- 1. CENTER DOT
-- ============================================
local centerDot = Instance.new("Frame")
centerDot.Name = "CenterDot"
centerDot.AnchorPoint = Vector2.new(0.5, 0.5)
centerDot.Position = UDim2.new(0.5, 0, 0.5, 0)
centerDot.Size = UDim2.new(0, 10, 0, 10)
centerDot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
centerDot.BorderSizePixel = 0
centerDot.BackgroundTransparency = 0.3
centerDot.Visible = true
centerDot.ZIndex = 5

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = centerDot

local dotOutline = Instance.new("UIStroke")
dotOutline.Color = Color3.fromRGB(255, 255, 255)
dotOutline.Thickness = 2
dotOutline.Parent = centerDot

centerDot.Parent = screenGui

-- ============================================
-- 2. FLY CONTROLS PANEL (FIXED - TIDAK HILANG)
-- ============================================
local flyControlPanel = Instance.new("Frame")
flyControlPanel.Name = "FlyControlPanel"
flyControlPanel.Position = UDim2.new(0, 20, 1, -180)
flyControlPanel.Size = UDim2.new(0, 200, 0, 160)
flyControlPanel.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
flyControlPanel.BackgroundTransparency = 0.3
flyControlPanel.BorderSizePixel = 0
flyControlPanel.Visible = false
flyControlPanel.ZIndex = 8

local flyPanelCorner = Instance.new("UICorner")
flyPanelCorner.CornerRadius = UDim.new(0, 12)
flyPanelCorner.Parent = flyControlPanel

-- Title
local flyPanelTitle = Instance.new("TextLabel")
flyPanelTitle.Size = UDim2.new(1, 0, 0, 30)
flyPanelTitle.BackgroundColor3 = Color3.fromRGB(40, 50, 70)
flyPanelTitle.Text = "✈️ FLY CONTROLS"
flyPanelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
flyPanelTitle.Font = Enum.Font.GothamBold
flyPanelTitle.TextSize = 14
flyPanelTitle.Parent = flyControlPanel

-- Control Buttons Grid
local controlGrid = Instance.new("Frame")
controlGrid.Name = "ControlGrid"
controlGrid.Position = UDim2.new(0, 10, 0, 40)
controlGrid.Size = UDim2.new(1, -20, 1, -50)
controlGrid.BackgroundTransparency = 1
controlGrid.Parent = flyControlPanel

-- Tombol-tombol kontrol
local function createFlyButton(name, text, posX, posY, color)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Position = UDim2.new(posX, 0, posY, 0)
    button.Size = UDim2.new(0, 40, 0, 40)
    button.BackgroundColor3 = color
    button.BackgroundTransparency = 0.3
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.ZIndex = 9
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    return button
end

-- Buat tombol kontrol
local upBtn = createFlyButton("UpBtn", "↑", 0.5, 0, Color3.fromRGB(0, 200, 0))
local leftBtn = createFlyButton("LeftBtn", "←", 0, 0.5, Color3.fromRGB(200, 200, 0))
local centerBtn = createFlyButton("CenterBtn", "●", 0.5, 0.5, Color3.fromRGB(100, 100, 200))
local rightBtn = createFlyButton("RightBtn", "→", 1, 0.5, Color3.fromRGB(200, 200, 0))
local downBtn = createFlyButton("DownBtn", "↓", 0.5, 1, Color3.fromRGB(200, 0, 0))
local forwardBtn = createFlyButton("ForwardBtn", "▲", 0.5, -0.2, Color3.fromRGB(0, 150, 255))
local backBtn = createFlyButton("BackBtn", "▼", 0.5, 1.2, Color3.fromRGB(255, 150, 0))

-- Position adjustments
upBtn.Position = UDim2.new(0.5, -20, 0, 10)
leftBtn.Position = UDim2.new(0, 10, 0.5, -20)
centerBtn.Position = UDim2.new(0.5, -20, 0.5, -20)
rightBtn.Position = UDim2.new(1, -50, 0.5, -20)
downBtn.Position = UDim2.new(0.5, -20, 1, -50)
forwardBtn.Position = UDim2.new(0.5, -20, -0.2, 60)
backBtn.Position = UDim2.new(0.5, -20, 1.2, -60)

-- Parent semua tombol
upBtn.Parent = controlGrid
leftBtn.Parent = controlGrid
centerBtn.Parent = controlGrid
rightBtn.Parent = controlGrid
downBtn.Parent = controlGrid
forwardBtn.Parent = controlGrid
backBtn.Parent = controlGrid

flyControlPanel.Parent = screenGui

-- ============================================
-- 3. MAIN MENU DENGAN SCROLL
-- ============================================
local mainMenu = Instance.new("Frame")
mainMenu.Name = "MainMenu"
mainMenu.Position = UDim2.new(0, 10, 0, 70)
mainMenu.Size = UDim2.new(0, 200, 0, 350)
mainMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainMenu.BackgroundTransparency = 0.1
mainMenu.BorderSizePixel = 0
mainMenu.Visible = true
mainMenu.ZIndex = 10
mainMenu.Active = true

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 12)
menuCorner.Parent = mainMenu

-- Header Menu
local menuHeader = Instance.new("Frame")
menuHeader.Name = "Header"
menuHeader.Size = UDim2.new(1, 0, 0, 40)
menuHeader.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
menuHeader.BorderSizePixel = 0

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = menuHeader

-- Title
local menuTitle = Instance.new("TextLabel")
menuTitle.Name = "Title"
menuTitle.Size = UDim2.new(1, -40, 1, 0)
menuTitle.BackgroundTransparency = 1
menuTitle.Text = "🎮 ULTIMATE MENU"
menuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
menuTitle.Font = Enum.Font.GothamBold
menuTitle.TextSize = 14
menuTitle.TextXAlignment = Enum.TextXAlignment.Left
menuTitle.Position = UDim2.new(0, 10, 0, 0)
menuTitle.Parent = menuHeader

-- Toggle Menu Button
local toggleMenuBtn = Instance.new("TextButton")
toggleMenuBtn.Name = "ToggleMenuBtn"
toggleMenuBtn.Position = UDim2.new(1, -35, 0, 5)
toggleMenuBtn.Size = UDim2.new(0, 30, 0, 30)
toggleMenuBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
toggleMenuBtn.Text = "▼"
toggleMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleMenuBtn.Font = Enum.Font.GothamBold
toggleMenuBtn.TextSize = 16
toggleMenuBtn.Parent = menuHeader

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 6)
toggleCorner.Parent = toggleMenuBtn

-- Scrolling Frame
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Position = UDim2.new(0, 0, 0, 45)
scrollFrame.Size = UDim2.new(1, 0, 1, -45)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 8
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
scrollFrame.ZIndex = 11

menuHeader.Parent = mainMenu
scrollFrame.Parent = mainMenu
mainMenu.Parent = screenGui

-- ============================================
-- 4. QUICK ACCESS BUTTONS
-- ============================================
local quickAccess = Instance.new("Frame")
quickAccess.Name = "QuickAccess"
quickAccess.Position = UDim2.new(0, 10, 0, 10)
quickAccess.Size = UDim2.new(0, 180, 0, 50)
quickAccess.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
quickAccess.BackgroundTransparency = 0.2
quickAccess.BorderSizePixel = 0
quickAccess.ZIndex = 9

local quickCorner = Instance.new("UICorner")
quickCorner.CornerRadius = UDim.new(0, 10)
quickCorner.Parent = quickAccess

-- Dot Toggle Button
local dotQuickBtn = Instance.new("TextButton")
dotQuickBtn.Name = "DotQuickBtn"
dotQuickBtn.Position = UDim2.new(0, 10, 0, 10)
dotQuickBtn.Size = UDim2.new(0, 50, 0, 30)
dotQuickBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
dotQuickBtn.Text = "🔴"
dotQuickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
dotQuickBtn.Font = Enum.Font.GothamBold
dotQuickBtn.TextSize = 14
dotQuickBtn.Parent = quickAccess

-- Fly Toggle Button
local flyQuickBtn = Instance.new("TextButton")
flyQuickBtn.Name = "FlyQuickBtn"
flyQuickBtn.Position = UDim2.new(0, 70, 0, 10)
flyQuickBtn.Size = UDim2.new(0, 50, 0, 30)
flyQuickBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
flyQuickBtn.Text = "✈️"
flyQuickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyQuickBtn.Font = Enum.Font.GothamBold
flyQuickBtn.TextSize = 14
flyQuickBtn.Parent = quickAccess

-- Menu Toggle Button
local menuQuickBtn = Instance.new("TextButton")
menuQuickBtn.Name = "MenuQuickBtn"
menuQuickBtn.Position = UDim2.new(0, 130, 0, 10)
menuQuickBtn.Size = UDim2.new(0, 40, 0, 30)
menuQuickBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 150)
menuQuickBtn.Text = "☰"
menuQuickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
menuQuickBtn.Font = Enum.Font.GothamBold
menuQuickBtn.TextSize = 16
menuQuickBtn.Parent = quickAccess

quickAccess.Parent = screenGui

-- ============================================
-- 5. FUNGSI BUAT TOMBOL MENU
-- ============================================
local function createMenuButton(name, text, yPos, color, icon)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.Size = UDim2.new(1, -20, 0, 35)
    button.BackgroundColor3 = color
    button.Text = icon .. " " .. text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.AutoButtonColor = true
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.ZIndex = 12
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    return button
end

-- Container untuk tombol
local buttonContainer = Instance.new("Frame")
buttonContainer.Name = "ButtonContainer"
buttonContainer.Size = UDim2.new(1, 0, 0, 0)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = scrollFrame

-- ============================================
-- 6. BUAT SEMUA TOMBOL FITUR
-- ============================================
local buttons = {}
local currentY = 10

-- 1. Center Dot Toggle
buttons.dotBtn = createMenuButton("DotBtn", "Center Dot: ON", currentY, Color3.fromRGB(255, 50, 50), "🔴")
buttons.dotBtn.Parent = buttonContainer
currentY = currentY + 40

-- 2. Fly Mode
buttons.flyBtn = createMenuButton("FlyBtn", "Fly Mode: OFF", currentY, Color3.fromRGB(50, 150, 255), "✈️")
buttons.flyBtn.Parent = buttonContainer
currentY = currentY + 40

-- 3. Noclip
buttons.noclipBtn = createMenuButton("NoclipBtn", "Noclip: OFF", currentY, Color3.fromRGB(180, 100, 255), "👻")
buttons.noclipBtn.Parent = buttonContainer
currentY = currentY + 40

-- 4. God Mode (FIXED)
buttons.godBtn = createMenuButton("GodBtn", "God Mode: OFF", currentY, Color3.fromRGB(255, 200, 50), "🛡️")
buttons.godBtn.Parent = buttonContainer
currentY = currentY + 40

-- 5. ESP Players
buttons.espBtn = createMenuButton("EspBtn", "ESP Players: OFF", currentY, Color3.fromRGB(50, 200, 100), "👁️")
buttons.espBtn.Parent = buttonContainer
currentY = currentY + 40

-- 6. Spectate Mode
buttons.spectateBtn = createMenuButton("SpectateBtn", "Spectate: OFF", currentY, Color3.fromRGB(150, 100, 200), "🎥")
buttons.spectateBtn.Parent = buttonContainer
currentY = currentY + 40

-- 7. Player List for Spectate/Teleport
local playerListLabel = Instance.new("TextLabel")
playerListLabel.Name = "PlayerListLabel"
playerListLabel.Position = UDim2.new(0, 10, 0, currentY)
playerListLabel.Size = UDim2.new(1, -20, 0, 25)
playerListLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
playerListLabel.BackgroundTransparency = 0.5
playerListLabel.Text = "Select Player:"
playerListLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
playerListLabel.Font = Enum.Font.Gotham
playerListLabel.TextSize = 12
playerListLabel.TextXAlignment = Enum.TextXAlignment.Left
playerListLabel.ZIndex = 12
playerListLabel.Parent = buttonContainer
currentY = currentY + 30

-- Player Dropdown
local playerDropdown = Instance.new("TextButton")
playerDropdown.Name = "PlayerDropdown"
playerDropdown.Position = UDim2.new(0, 10, 0, currentY)
playerDropdown.Size = UDim2.new(1, -20, 0, 30)
playerDropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
playerDropdown.Text = "Click to select player"
playerDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
playerDropdown.Font = Enum.Font.Gotham
playerDropdown.TextSize = 11
playerDropdown.ZIndex = 12
playerDropdown.Parent = buttonContainer
currentY = currentY + 35

-- 8. Teleport to Player
buttons.tpBtn = createMenuButton("TpBtn", "Teleport to Player", currentY, Color3.fromRGB(255, 150, 50), "📍")
buttons.tpBtn.Parent = buttonContainer
currentY = currentY + 40

-- 9. Speed Control
local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Position = UDim2.new(0, 10, 0, currentY)
speedLabel.Size = UDim2.new(1, -20, 0, 25)
speedLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
speedLabel.BackgroundTransparency = 0.5
speedLabel.Text = "Fly Speed: " .. flySpeed
speedLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 12
speedLabel.TextXAlignment = Enum.TextXAlignment.Center
speedLabel.ZIndex = 12
speedLabel.Parent = buttonContainer
currentY = currentY + 30

-- Speed Controls
local speedControlFrame = Instance.new("Frame")
speedControlFrame.Name = "SpeedControlFrame"
speedControlFrame.Position = UDim2.new(0, 10, 0, currentY)
speedControlFrame.Size = UDim2.new(1, -20, 0, 30)
speedControlFrame.BackgroundTransparency = 1
speedControlFrame.ZIndex = 12

local speedDownBtn = Instance.new("TextButton")
speedDownBtn.Name = "SpeedDownBtn"
speedDownBtn.Position = UDim2.new(0, 0, 0, 0)
speedDownBtn.Size = UDim2.new(0, 70, 1, 0)
speedDownBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
speedDownBtn.Text = "- SPEED"
speedDownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedDownBtn.Font = Enum.Font.GothamBold
speedDownBtn.TextSize = 10

local speedUpBtn = Instance.new("TextButton")
speedUpBtn.Name = "SpeedUpBtn"
speedUpBtn.Position = UDim2.new(1, -70, 0, 0)
speedUpBtn.Size = UDim2.new(0, 70, 1, 0)
speedUpBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
speedUpBtn.Text = "+ SPEED"
speedUpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedUpBtn.Font = Enum.Font.GothamBold
speedUpBtn.TextSize = 10

speedDownBtn.Parent = speedControlFrame
speedUpBtn.Parent = speedControlFrame
speedControlFrame.Parent = buttonContainer
currentY = currentY + 40

-- 10. Walk Speed
buttons.walkBtn = createMenuButton("WalkBtn", "Walk Speed: 16", currentY, Color3.fromRGB(100, 200, 255), "🚶")
buttons.walkBtn.Parent = buttonContainer
currentY = currentY + 40

-- 11. Jump Power
buttons.jumpBtn = createMenuButton("JumpBtn", "Jump Power: 50", currentY, Color3.fromRGB(255, 150, 200), "🦘")
buttons.jumpBtn.Parent = buttonContainer
currentY = currentY + 40

-- 12. Reset Character
buttons.resetBtn = createMenuButton("ResetBtn", "Reset Character", currentY, Color3.fromRGB(255, 200, 100), "🔄")
buttons.resetBtn.Parent = buttonContainer
currentY = currentY + 40

-- 13. Close Script
buttons.closeBtn = createMenuButton("CloseBtn", "Close Script", currentY, Color3.fromRGB(255, 50, 50), "❌")
buttons.closeBtn.Parent = buttonContainer
currentY = currentY + 40

-- Update container height
buttonContainer.Size = UDim2.new(1, 0, 0, currentY + 10)

-- ============================================
-- 7. FUNGSI UTAMA
-- ============================================

-- Fungsi update UI
local function updateUI()
    -- Center Dot
    centerDot.Visible = dotEnabled
    buttons.dotBtn.Text = "🔴 Center Dot: " .. (dotEnabled and "ON" or "OFF")
    buttons.dotBtn.BackgroundColor3 = dotEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 50, 50)
    dotQuickBtn.BackgroundColor3 = dotEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 50, 50)
    
    -- Fly Mode
    buttons.flyBtn.Text = "✈️ Fly Mode: " .. (flyEnabled and "ON" or "OFF")
    buttons.flyBtn.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 150, 255)
    flyQuickBtn.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 150, 255)
    flyControlPanel.Visible = flyEnabled
    
    -- Noclip
    buttons.noclipBtn.Text = "👻 Noclip: " .. (noclipEnabled and "ON" or "OFF")
    buttons.noclipBtn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(180, 100, 255)
    
    -- God Mode
    buttons.godBtn.Text = "🛡️ God Mode: " .. (godModeEnabled and "ON" or "OFF")
    buttons.godBtn.BackgroundColor3 = godModeEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 200, 50)
    
    -- ESP
    buttons.espBtn.Text = "👁️ ESP Players: " .. (espEnabled and "ON" or "OFF")
    buttons.espBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 200, 100)
    
    -- Spectate Mode
    buttons.spectateBtn.Text = "🎥 Spectate: " .. (spectateEnabled and "ON" or "OFF")
    buttons.spectateBtn.BackgroundColor3 = spectateEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(150, 100, 200)
    
    -- Speed Label
    speedLabel.Text = "Fly Speed: " .. flySpeed
    
    -- Player Dropdown
    if spectatingPlayer then
        playerDropdown.Text = "Selected: " .. spectatingPlayer.Name
    else
        playerDropdown.Text = "Click to select player"
    end
end

-- ============================================
-- 8. ESP SYSTEM
-- ============================================
local espCache = {}

local function createESP(targetPlayer)
    if not targetPlayer or targetPlayer == player then return end
    
    local character = targetPlayer.Character
    if not character then return end
    
    -- Hapus ESP lama jika ada
    if espCache[targetPlayer] then
        espCache[targetPlayer]:Destroy()
        espCache[targetPlayer] = nil
    end
    
    -- Buat Highlight untuk ESP
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_" .. targetPlayer.Name
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 0.7
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = espFolder
    
    -- Pasang ke karakter
    highlight.Adornee = character
    
    -- Simpan di cache
    espCache[targetPlayer] = highlight
    
    -- Update jika karakter berubah
    local connection
    connection = targetPlayer.CharacterAdded:Connect(function(newChar)
        highlight.Adornee = newChar
    end)
    
    -- Cleanup saat player keluar
    targetPlayer.AncestryChanged:Connect(function()
        if not targetPlayer.Parent then
            if highlight t
