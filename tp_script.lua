local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local FlyBtn = Instance.new("TextButton")
local NoclipBtn = Instance.new("TextButton")
local DropBtn = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 160, 0, 150)
Frame.Position = UDim2.new(0.85, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

UIListLayout.Parent = Frame
UIListLayout.Padding =集中.new(0, 5)

-- وظيفة تحسين الأزرار
local function styleButton(btn, text)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Text = text
    btn.Parent = Frame
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end

styleButton(FlyBtn, "طيران: مغلق")
styleButton(NoclipBtn, "اختراق: مغلق")
styleButton(DropBtn, "هبوط سريع")

-- [1] ميزة الهبوط السريع
DropBtn.MouseButton1Click:Connect(function()
    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    local result = workspace:Raycast(root.Position, Vector3.new(0, -1000, 0))
    if result then root.CFrame = CFrame.new(result.Position + Vector3.new(0, 3, 0)) end
end)

-- [2] ميزة اختراق الجدران (Noclip)
local noclip = false
NoclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    NoclipBtn.Text = noclip and "اختراق: مفعل" or "اختراق: مغلق"
    NoclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
end)

game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- [3] ميزة الطيران (Fly) مبسطة
local flying = false
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    FlyBtn.Text = flying and "طيران: مفعل" or "طيران: مغلق"
    FlyBtn.BackgroundColor3 = flying and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
    
    local char = game.Players.LocalPlayer.Character
    if flying then
        local bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
        bv.Name = "XenoFly"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 50, 0) -- يطير للأعلى ببطء
    else
        if char.HumanoidRootPart:FindFirstChild("XenoFly") then
            char.HumanoidRootPart.XenoFly:Destroy()
        end
    end
end)
