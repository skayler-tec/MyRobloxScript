local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 150, 0, 45)
MainButton.Position = UDim2.new(0.85, 0, 0.5, 0) -- الزر سيكون على يمين الشاشة
MainButton.Text = "هبوط سريع"
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainButton.Font = Enum.Font.SourceSansBold
MainButton.TextSize = 20

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainButton

-- وظيفة الهبوط التلقائي
local function fastDrop()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local rootPart = character.HumanoidRootPart
        
        -- إطلاق شعاع فحص للأسفل لمسافة طويلة
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {character}
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        
        -- الشعاع ينطلق من مركز اللاعب لأسفل
        local raycastResult = workspace:Raycast(rootPart.Position, Vector3.new(0, -1000, 0), raycastParams)
        
        if raycastResult then
            -- النقل لسطح البلوك المكتشف + رفعه بمقدار بسيط جداً ليقف فوقه
            rootPart.CFrame = CFrame.new(raycastResult.Position + Vector3.new(0, 3, 0))
        end
    end
end

-- ربط الزر بالوظيفة
MainButton.MouseButton1Click:Connect(fastDrop)
