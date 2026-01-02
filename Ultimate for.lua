-- Ultimate Center Dot + Fly Script for Mobile
-- By: YourName
-- Version: 1.0

local function Main()
    -- Tunggu game load
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end

    -- Services
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    
    -- Player
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Hapus GUI lama jika ada
    if playerGui:FindFirstChild("UltimateDotGUI") then
        playerGui.UltimateDotGUI:Destroy()
    end
    
    -- ============================================
    -- BUAT GUI
    -- ============================================
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UltimateDotGUI"
    screenGui.DisplayOrder = 999
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- ============================================
    -- CENTER DOT
    -- ============================================
    local centerDot = Instance.new("Frame")
    centerDot.Name = "CenterDot"
    centerDot.AnchorPoint = Vector2.new(0.5, 0.5)
    centerDot.Position = UDim2.new(0.5, 0, 0.5, 0)
    centerDot.Size = UDim2.new(0, 12, 0, 12)
    centerDot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    centerDot.BorderSizePixel = 0
    centerDot.BackgroundTransparency = 0.3
    centerDot.Visible = true
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = centerDot
    
    local dotOutline = Instance.new("UIStroke")
    dotOutline.Color = Color3.fromRGB(255, 255, 255)
    dotOutline.Thickness = 2
    dotOutline.Parent = centerDot
    
    centerDot.Parent = screenGui
    
    -- ============================================
    -- MAIN MENU
    -- ============================================
    local mainMenu = Instance.new("Frame")
    mainMenu.Name = "MainMenu"
    mainMenu.Position = UDim2.new(0, 20, 0, 20)
    mainMenu.Size = UDim2.new(0, 180, 0, 300)
    mainMenu.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
    mainMenu.BackgroundTransparency = 0.1
    mainMenu.BorderSizePixel = 0
    
    local menuCorner = Instance.new("UICorner")
    menuCorner.CornerRadius = UDim.new(0, 12)
    menuCorner.Parent = mainMenu
    
    -- Header
    local menuHeader = Instance.new("Frame")
    menuHeader.Name = "Header"
    menuHeader.Size = UDim2.new(1, 0, 0, 40)
    menuHeader.BackgroundColor3 = Color3.fromRGB(40, 50, 70)
    menuHeader.BorderSizePixel = 0
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = menuHeader
    
    -- Title
    local menuTitle = Instance.new("TextLabel")
    menuTitle.Name = "Title"
    menuTitle.Size = UDim2.new(1, -40, 1, 0)
    menuTitle.BackgroundTransparency = 1
    menuTitle.Text = "🎮 DOT MENU"
    menuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    menuTitle.Font = Enum.Font.GothamBold
    menuTitle.TextSize = 14
    menuTitle.TextXAlignment = Enum.TextXAlignment.Left
    menuTitle.Position = UDim2.new(0, 10, 0, 0)
    menuTitle.Parent = menuHeader
    
    -- Close Button
    local closeMenuBtn = Instance.new("TextButton")
    closeMenuBtn.Name = "CloseMenuBtn"
    closeMenuBtn.Position = UDim2.new(1, -35, 0, 5)
    closeMenuBtn.Size = UDim2.new(0, 30, 0, 30)
    closeMenuBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    closeMenuBtn.Text = "X"
    closeMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeMenuBtn.Font = Enum.Font.GothamBold
    closeMenuBtn.TextSize = 14
    closeMenuBtn.Parent = menuHeader
    
    local closeBtnCorner = Instance.new("UICorner")
    closeBtnCorner.CornerRadius = UDim.new(0, 6)
    closeBtnCorner.Parent = closeMenuBtn
    
    -- Scrolling Frame
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ScrollFrame"
    scrollFrame.Position = UDim2.new(0, 0, 0, 45)
    scrollFrame.Size = UDim2.new(1, 0, 1, -45)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    menuHeader.Parent = mainMenu
    closeMenuBtn.Parent = menuHeader
    scrollFrame.Parent = mainMenu
    mainMenu.Parent = screenGui
    
    -- ============================================
    -- QUICK ACCESS BUTTONS
    -- ============================================
    local quickAccess = Instance.new("Frame")
    quickAccess.Name = "QuickAccess"
    quickAccess.Position = UDim2.new(0, 20, 0, 330)
    quickAccess.Size = UDim2.new(0, 180, 0, 40)
    quickAccess.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
    quickAccess.BackgroundTransparency = 0.2
    quickAccess.BorderSizePixel = 0
    
    local quickCorner = Instance.new("UICorner")
    quickCorner.CornerRadius = UDim.new(0, 8)
    quickCorner.Parent = quickAccess
    
    -- Dot Button
    local dotQuickBtn = Instance.new("TextButton")
    dotQuickBtn.Name = "DotQuickBtn"
    dotQuickBtn.Position = UDim2.new(0, 10, 0, 5)
    dotQuickBtn.Size = UDim2.new(0, 50, 0, 30)
    dotQuickBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    dotQuickBtn.Text = "🔴"
    dotQuickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    dotQuickBtn.Font = Enum.Font.GothamBold
    dotQuickBtn.TextSize = 14
    dotQuickBtn.Parent = quickAccess
    
    -- Fly Button
    local flyQuickBtn = Instance.new("TextButton")
    flyQuickBtn.Name = "FlyQuickBtn"
    flyQuickBtn.Position = UDim2.new(0, 70, 0, 5)
    flyQuickBtn.Size = UDim2.new(0, 50, 0, 30)
    flyQuickBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    flyQuickBtn.Text = "✈️"
    flyQuickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    flyQuickBtn.Font = Enum.Font.GothamBold
    flyQuickBtn.TextSize = 14
    flyQuickBtn.Parent = quickAccess
    
    -- Menu Button
    local menuQuickBtn = Instance.new("TextButton")
    menuQuickBtn.Name = "MenuQuickBtn"
    menuQuickBtn.Position = UDim2.new(0, 130, 0, 5)
    menuQuickBtn.Size = UDim2.new(0, 40, 0, 30)
    menuQuickBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 150)
    menuQuickBtn.Text = "☰"
    menuQuickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    menuQuickBtn.Font = Enum.Font.GothamBold
    menuQuickBtn.TextSize = 16
    menuQuickBtn.Parent = quickAccess
    
    quickAccess.Parent = screenGui
    
    -- ============================================
    -- BUTTON CONTAINER
    -- ============================================
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = "ButtonContainer"
    buttonContainer.Size = UDim2.new(1, 0, 0, 0)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = scrollFrame
    
    -- ============================================
    -- STATE VARIABLES
    -- ============================================
    local dotEnabled = true
    local flyEnabled = false
    local noclipEnabled = false
    local godModeEnabled = false
    local flySpeed = 50
    local flyBV, flyBG
    
    -- ============================================
    -- FUNGSI BUAT TOMBOL
    -- ============================================
    local function createMenuButton(text, yPos, color, icon)
        local button = Instance.new("TextButton")
        button.Position = UDim2.new(0, 10, 0, yPos)
        button.Size = UDim2.new(1, -20, 0, 35)
        button.BackgroundColor3 = color
        button.Text = icon .. " " .. text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.GothamBold
        button.TextSize = 12
        button.AutoButtonColor = true
        button.TextXAlignment = Enum.TextXAlignment.Left
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = button
        
        return button
    end
    
    -- ============================================
    -- BUAT TOMBOL-TOMBOL
    -- ============================================
    local buttons = {}
    local currentY = 10
    
    -- 1. Center Dot
    buttons.dotBtn = createMenuButton("Center Dot: ON", currentY, Color3.fromRGB(255, 50, 50), "🔴")
    buttons.dotBtn.Parent = buttonContainer
    currentY = currentY + 40
    
    -- 2. Fly Mode
    buttons.flyBtn = createMenuButton("Fly Mode: OFF", currentY, Color3.fromRGB(50, 150, 255), "✈️")
    buttons.flyBtn.Parent = buttonContainer
    currentY = currentY + 40
    
    -- 3. Noclip
    buttons.noclipBtn = createMenuButton("Noclip: OFF", currentY, Color3.fromRGB(180, 100, 255), "👻")
    buttons.noclipBtn.Parent = buttonContainer
    currentY = currentY + 40
    
    -- 4. God Mode
    buttons.godBtn = createMenuButton("God Mode: OFF", currentY, Color3.fromRGB(255, 200, 50), "🛡️")
    buttons.godBtn.Parent = buttonContainer
    currentY = currentY + 40
    
    -- 5. Speed Label
    local speedLabel = Instance.new("TextLabel")
    speedLabel.Position = UDim2.new(0, 10, 0, currentY)
    speedLabel.Size = UDim2.new(1, -20, 0, 25)
    speedLabel.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    speedLabel.BackgroundTransparency = 0.5
    speedLabel.Text = "Fly Speed: " .. flySpeed
    speedLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
    speedLabel.Font = Enum.Font.Gotham
    speedLabel.TextSize = 12
    speedLabel.TextXAlignment = Enum.TextXAlignment.Center
    speedLabel.Parent = buttonContainer
    currentY = currentY + 30
    
    -- 6. Speed Controls
    local speedControlFrame = Instance.new("Frame")
    speedControlFrame.Position = UDim2.new(0, 10, 0, currentY)
    speedControlFrame.Size = UDim2.new(1, -20, 0, 30)
    speedControlFrame.BackgroundTransparency = 1
    
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
    currentY = currentY + 35
    
    -- 7. Walk Speed
    buttons.walkBtn = createMenuButton("Walk Speed: 16", currentY, Color3.fromRGB(100, 200, 255), "🚶")
    buttons.walkBtn.Parent = buttonContainer
    currentY = currentY + 40
    
    -- 8. Jump Power
    buttons.jumpBtn = createMenuButton("Jump Power: 50", currentY, Color3.fromRGB(255, 150, 200), "🦘")
    buttons.jumpBtn.Parent = buttonContainer
    currentY = currentY + 40
    
    -- 9. Teleport Spawn
    buttons.tpBtn = createMenuButton("Teleport Spawn", currentY, Color3.fromRGB(150, 255, 150), "📍")
    buttons.tpBtn.Parent = buttonContainer
    currentY = currentY + 40
    
    -- 10. Reset Character
    buttons.resetBtn = createMenuButton("Reset Character", currentY, Color3.fromRGB(255, 200, 100), "🔄")
    buttons.resetBtn.Parent = buttonContainer
    currentY = currentY + 40
    
    -- 11. Close Script
    buttons.closeBtn = createMenuButton("Close Script", currentY, Color3.fromRGB(255, 50, 50), "❌")
    buttons.closeBtn.Parent = buttonContainer
    
    -- Update container height
    buttonContainer.Size = UDim2.new(1, 0, 0, currentY + 50)
    
    -- ============================================
    -- FUNGSI UPDATE UI
    -- ============================================
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
        
        -- Noclip
        buttons.noclipBtn.Text = "👻 Noclip: " .. (noclipEnabled and "ON" or "OFF")
        buttons.noclipBtn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(180, 100, 255)
        
        -- God Mode
        buttons.godBtn.Text = "🛡️ God Mode: " .. (godModeEnabled and "ON" or "OFF")
        buttons.godBtn.BackgroundColor3 = godModeEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 200, 50)
        
        -- Speed Label
        speedLabel.Text = "Fly Speed: " .. flySpeed
    end
    
    -- ============================================
    -- FUNGSI-FUNGSI FITUR
    -- ============================================
    
    -- 1. Center Dot
    buttons.dotBtn.MouseButton1Click:Connect(function()
        dotEnabled = not dotEnabled
        updateUI()
    end)
    
    dotQuickBtn.MouseButton1Click:Connect(function()
        dotEnabled = not dotEnabled
        updateUI()
    end)
    
    -- 2. Fly Mode
    local function enableFly()
        if flyEnabled then return end
        
        flyEnabled = true
        
        -- Buat BodyVelocity dan BodyGyro
        flyBV = Instance.new("BodyVelocity")
        flyBV.Velocity = Vector3.new(0, 0, 0)
        flyBV.MaxForce = Vector3.new(40000, 40000, 40000)
        flyBV.P = 10000
        
        flyBG = Instance.new("BodyGyro")
        flyBG.MaxTorque = Vector3.new(40000, 40000, 40000)
        flyBG.P = 10000
        flyBG.CFrame = humanoidRootPart.CFrame
        
        -- Pasang ke karakter
        flyBV.Parent = humanoidRootPart
        flyBG.Parent = humanoidRootPart
        
        -- Nonaktifkan gravitasi
        humanoid.PlatformStand = true
        
        updateUI()
    end
    
    local function disableFly()
        if not flyEnabled then return end
        
        flyEnabled = false
        
        -- Hapus BodyVelocity dan BodyGyro
        if flyBV then flyBV:Destroy() end
        if flyBG then flyBG:Destroy() end
        
        -- Aktifkan gravitasi
        humanoid.PlatformStand = false
        
        updateUI()
    end
    
    buttons.flyBtn.MouseButton1Click:Connect(function()
        if flyEnabled then
            disableFly()
        else
            enableFly()
        end
    end)
    
    flyQuickBtn.MouseButton1Click:Connect(function()
        if flyEnabled then
            disableFly()
        else
            enableFly()
        end
    end)
    
    -- Kontrol Fly dengan Keyboard
    RunService.RenderStepped:Connect(function()
        if not flyEnabled or not flyBV then return end
        
        local camera = workspace.CurrentCamera
        if not camera then return end
        
        local forward = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
        local up = Vector3.new(0, 1, 0)
        
        local moveDirection = Vector3.new(0, 0, 0)
        
        -- Kontrol keyboard
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + forward end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - forward end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - right end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + right end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + up end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDirection = moveDirection - up end
        
        -- Terapkan speed
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit * flySpeed
        end
        
        flyBV.Velocity = moveDirection
        
        if flyBG then
            flyBG.CFrame = CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + camera.CFrame.LookVector)
        end
    end)
    
    -- 3. Noclip
    buttons.noclipBtn.MouseButton1Click:Connect(function()
        noclipEnabled = not noclipEnabled
        
        if noclipEnabled then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        else
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        
        updateUI()
    end)
    
    -- Auto noclip saat karakter berubah
    player.CharacterAdded:Connect(function(newChar)
        character = newChar
        humanoid = newChar:WaitForChild("Humanoid")
        humanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
        
        if noclipEnabled then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        
        if flyEnabled then
            wait(0.5)
            enableFly()
        end
    end)
    
    -- 4. God Mode
    buttons.godBtn.MouseButton1Click:Connect(function()
        godModeEnabled = not godModeEnabled
        
        if godModeEnabled then
            humanoid.MaxHealth = math.huge
            humanoid.Health = humanoid.MaxHealth
        else
            humanoid.MaxHealth = 100
            humanoid.Health = 100
        end
        
        updateUI()
    end)
    
    -- 5. Speed Control
    speedUpBtn.MouseButton1Click:Connect(function()
        flySpeed = math.min(200, flySpeed + 10)
        updateUI()
    end)
    
    speedDownBtn.MouseButton1Click:Connect(function()
        flySpeed = math.max(10, flySpeed - 10)
        updateUI()
    end)
    
    -- 6. Walk Speed
    local walkSpeed = 16
    buttons.walkBtn.MouseButton1Click:Connect(function()
        walkSpeed = walkSpeed == 16 and 50 or (walkSpeed == 50 and 100 or 16)
        humanoid.WalkSpeed = walkSpeed
        buttons.walkBtn.Text = "🚶 Walk Speed: " .. walkSpeed
    end)
    
    -- 7. Jump Power
    local jumpPower = 50
    buttons.jumpBtn.MouseButton1Click:Connect(function()
        jumpPower = jumpPower == 50 and 100 or (jumpPower == 100 and 200 or 50)
        humanoid.JumpPower = jumpPower
        buttons.jumpBtn.Text = "🦘 Jump Power: " .. jumpPower
    end)
    
    -- 8. Teleport Spawn
    buttons.tpBtn.MouseButton1Click:Connect(function()
        disableFly()
        
        -- Cari spawn location
        local spawnLocation = workspace:FindFirstChild("SpawnLocation") or workspace
        local spawnPosition = Vector3.new(0, 10, 0)
        
        if spawnLocation:IsA("SpawnLocation") then
            spawnPosition = spawnLocation.Position
        end
        
        humanoidRootPart.CFrame = CFrame.new(spawnPosition)
    end)
    
    -- 9. Reset Character
    buttons.resetBtn.MouseButton1Click:Connect(function()
        disableFly()
        humanoid.Health = 0
    end)
    
    -- 10. Close Script
    buttons.closeBtn.MouseButton1Click:Connect(function()
        disableFly()
        screenGui:Destroy()
    end)
    
    -- ============================================
    -- TOGGLE MENU
    -- ============================================
    closeMenuBtn.MouseButton1Click:Connect(function()
        mainMenu.Visible = not mainMenu.Visible
        quickAccess.Visible = not quickAccess.Visible
    end)
    
    menuQuickBtn.MouseButton1Click:Connect(function()
        mainMenu.Visible = not mainMenu.Visible
        quickAccess.Visible = not quickAccess.Visible
    end)
    
    -- ============================================
    -- DRAG MENU
    -- ============================================
    local dragging = false
    local dragStart, startPos
    
    menuHeader.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainMenu.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            mainMenu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            quickAccess.Position = UDim2.new(0, mainMenu.Position.X.Offset, 0, mainMenu.Position.Y.Offset + 310)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    -- ============================================
    -- ANIMASI DOT
    -- ============================================
    RunService.RenderStepped:Connect(function()
        if dotEnabled then
            local pulse = math.sin(tick() * 3) * 0.1 + 0.9
            centerDot.BackgroundTransparency = 0.3 + (0.2 * (1 - pulse))
            centerDot.Size = UDim2.new(0, 12 * pulse, 0, 12 * pulse)
        end
    end)
    
    -- ============================================
    -- INITIAL UPDATE
    -- ============================================
    updateUI()
    
    print("🎮 Ultimate Dot Script Loaded Successfully!")
    print("✅ Center Dot: ON")
    print("✅ Menu: Ready")
    print("✅ Features: Dot, Fly, Noclip, God Mode")
    
    return screenGui
end

-- Jalankan script
local success, result = pcall(Main)
if not success then
    warn("Error loading script: " .. result)
end
