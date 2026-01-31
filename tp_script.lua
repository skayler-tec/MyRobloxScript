-- إنشاء واجهة مستخدم (Menu) احترافية
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local UICorner = Instance.new("UICorner")
local Header = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 180, 0, 220)
MainFrame.Position = UDim2.new(0.8, 0, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true -- يمكنك تحريك القائمة في الشاشة

UICorner.Parent = MainFrame

Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 35)
Header.Text = "Xeno Hub"
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Header.Font = Enum.Font.SourceSansBold
Header.TextSize = 20

UIListLayout.Parent = MainFrame
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- وظيفة لإنشاء الأزرار بسهولة
local function createBtn(text, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 160, 0, 40)
    btn.Text = text
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Parent = MainFrame
    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 6)
    bCorner.Parent = btn
    return btn
end

local DropBtn = createBtn("هبوط سريع", Color3.fromRGB(60, 60, 60))
local FlyBtn = createBtn("طيران: مغلق", Color3.fromRGB(60, 60, 60))
local NoclipBtn = createBtn("اختراق: مغلق", Color3.fromRGB(60, 60, 60))

-- 1. ميزة الهبوط السريع (Raycast)
DropBtn.MouseButton1Click:Connect(function()
    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    local raycastResult = workspace:Raycast(root.Position, Vector3.new(0, -1000, 0))
    if raycastResult then
        root.CFrame = CFrame.new(raycastResult.Position + Vector3.new(0, 3, 0))
    end
end)

-- 2. ميزة اختراق الجدران (Noclip)
local noclip = false
NoclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    NoclipBtn.Text = noclip and "اختراق: مفعل" or "اختراق: مغلق"
    NoclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
end)

game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- 3. ميزة الطيران (Fly) - تتحرك مع اتجاه الكاميرا
local flying = false
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    FlyBtn.Text = flying and "طيران: مفعل" or "طيران: مغلق"
    FlyBtn.BackgroundColor3 = flying and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
    
    local char = game.Players.LocalPlayer.Character
    local root = char.HumanoidRootPart
    
    if flying then
        local bv = Instance.new("BodyVelocity", root)
        bv.Name = "FlyVel"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        
        local bg = Instance.new("BodyGyro", root)
        bg.Name = "FlyGyro"
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        
        task.spawn(function()
            while flying do
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
                bg.CFrame = workspace.CurrentCamera.CFrame
                task.wait()
            end
            bv:Destroy()
            bg:Destroy()
        end)
    end
end)
