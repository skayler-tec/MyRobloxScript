-- إنشاء واجهة بسيطة (GUI)
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 200, 0, 50)
MainButton.Position = UDim2.new(0.5, -100, 0.4, 0)
MainButton.Text = "انتقال لأقرب أرض"
MainButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

-- وظيفة البحث عن أقرب ارتفاع أقل (Raycasting)
local function teleportToGround()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local rootPart = character.HumanoidRootPart
        
        -- إرسال شعاع وهمي للأسفل لمسافة 500 متر
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {character}
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        
        local raycastResult = workspace:Raycast(rootPart.Position, Vector3.new(0, -500, 0), raycastParams)
        
        if raycastResult then
            -- نقل اللاعب لنقطة التصادم (الأرض) مع رفعه قليلاً لكي لا يغرز
            rootPart.CFrame = CFrame.new(raycastResult.Position + Vector3.new(0, 3, 0))
            print("تم الانتقال بنجاح!")
        else
            print("لم يتم العثور على أرض تحتك!")
        end
    end
end

-- تشغيل الوظيفة عند الضغط على الزر
MainButton.MouseButton1Click:Connect(teleportToGround)
