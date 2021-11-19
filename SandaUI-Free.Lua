--11/17/2021
--by Sanda#9197

do
    if game:GetService("CoreGui"):FindFirstChild("NisclsFreeSmallUI") then
        game:GetService("CoreGui"):FindFirstChild("NisclsFreeSmallUI"):Destroy()
    else
        print("No Current UI Detected")
    end
end

local NisclsSmallUI = {}

_G.ThemeColor = nil
_G.ShadowColor = nil

function NisclsSmallUI:Create(class, properties)
	local object = Instance.new(class)

	for prop, val in next, properties do
		if object[prop] and prop ~= "Parent" then
			object[prop] = val
		end
	end

	return object
end

function NisclsSmallUI:DebugWindow(WindowDebug)
    _G.ThemeColor = WindowDebug.Theme
    _G.ShadowColor = WindowDebug.ShadowColor
    local Window = {}
    local SelfWindow = Window
    local DebugGui = NisclsSmallUI

    SelfWindow.NisclsFreeSmallUI = DebugGui:Create("ScreenGui",{
        Name = "NisclsFreeSmallUI",
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false
    }) SelfWindow.NisclsFreeSmallUI.Parent = game.CoreGui

    SelfWindow.ambientShadow = DebugGui:Create("ImageLabel",{
        Name = "ambientShadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1.000,
        BorderSizePixel = 0,
        Position = WindowDebug.Position or UDim2.new(0, 581, 0, 355),
        Size = WindowDebug.Size or UDim2.new(0, 460, 0, 260),
        ZIndex = 2,
        Image = "rbxassetid://1316045217",
        ImageColor3 = _G.ShadowColor,
        ImageTransparency = 0.400,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118)
    }) SelfWindow.ambientShadow.Parent = SelfWindow.NisclsFreeSmallUI

    SelfWindow.Window = DebugGui:Create("Frame",{
        Name = "Window",
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 5, 0, 5),
        Size = UDim2.new(0, SelfWindow.ambientShadow.Size.X.Offset - 10, 0, SelfWindow.ambientShadow.Size.Y.Offset - 10),
        ZIndex = 3
    }) SelfWindow.Window.Parent = SelfWindow.ambientShadow

    SelfWindow.WindowUICorner = DebugGui:Create("UICorner",{
        Name = "WindowUICorner",
        CornerRadius = UDim.new(0, 4)
    }) SelfWindow.WindowUICorner.Parent = SelfWindow.Window

    SelfWindow.WindowTitle = DebugGui:Create("TextLabel",{
        Name = "WindowTitle",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1.000,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 5, 0, 0),
        Size = UDim2.new(0, SelfWindow.Window.Size.X.Offset, 0, 18),
        ZIndex = 3,
        Font = Enum.Font.GothamBold,
        Text = WindowDebug.WindowTitle or "Nislcs Small UI By Sanda#9197",
        TextColor3 = WindowDebug.TitleColor,
        TextSize = 11.000,
        TextXAlignment = Enum.TextXAlignment.Left
    }) SelfWindow.WindowTitle.Parent = SelfWindow.Window

    SelfWindow.TabWindow = DebugGui:Create("Frame",{
        Name = "TabWindow",
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderColor3 = Color3.fromRGB(35, 35, 35),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 0, 20),
        Size = UDim2.new(0, SelfWindow.Window.Size.X.Offset - 20, 0, 18),
        ZIndex = 4
    }) SelfWindow.TabWindow.Parent = SelfWindow.Window

    SelfWindow.TabWindowList = DebugGui:Create("UIListLayout",{
        Name = "TabWindowList",
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder
    }) SelfWindow.TabWindowList.Parent = SelfWindow.TabWindow

    SelfWindow.TabWindowUICorner = DebugGui:Create("UICorner",{
        CornerRadius = UDim.new(0, 4),
        Name = "TabWindowUICorner"
    }) SelfWindow.TabWindowUICorner.Parent = SelfWindow.TabWindow

    SelfWindow.ContainerHolder = DebugGui:Create("Frame",{
        Name = "ContainerHolder",
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 38),
        Size = UDim2.new(0, SelfWindow.Window.Size.X.Offset, 0, SelfWindow.Window.Size.Y.Offset - 38),
        ZIndex = 5
    }) SelfWindow.ContainerHolder.Parent = SelfWindow.Window

    SelfWindow.WindowDragPart = DebugGui:Create("Frame",{
        Name = "WindowDragPart",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1.000,
        BorderSizePixel = 0,
        Size =  UDim2.new(0, SelfWindow.Window.Size.X.Offset, 0, 20),
        ZIndex = -1
    }) SelfWindow.WindowDragPart.Parent = SelfWindow.Window

    function Dragpart(dragger, todrag)
        local UserInputService = game:GetService("UserInputService")
        
        local gui = dragger
        local guitodrag = todrag
        
        local dragging
        local dragInput
        local dragStart
        local startPos
        
        local function update(input)
            local delta = input.Position - dragStart
            guitodrag:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), "InOut", "Linear", 0.06, true)
        end
        
        gui.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = guitodrag.Position
        
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        gui.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end
    Dragpart(SelfWindow.WindowDragPart, SelfWindow.ambientShadow)

    local NisclsWindow = {}

    function NisclsWindow:NewPage(PageDebug)
        local ContainerStuff = {}
        local SelfCont = ContainerStuff
        local DebugGui1 = NisclsSmallUI
        SelfCont.Container = DebugGui1:Create("ScrollingFrame",{
            Name = PageDebug.Title or "Container",
            Active = true,
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 5, 0, 6),
            Size = UDim2.new(0, SelfWindow.ContainerHolder.Size.X.Offset - 10, 0, SelfWindow.ContainerHolder.Size.Y.Offset - 10),
            ZIndex = 6,
            ScrollBarThickness = 2,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarImageColor3 = _G.ThemeColor,
            Visible = false
        }) SelfCont.Container.Parent = SelfWindow.ContainerHolder

        SelfCont.ContainerList = DebugGui1:Create("UIListLayout",{
            Name = PageDebug.Title.."List" or "ContainerList",
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 5)
        }) SelfCont.ContainerList.Parent = SelfCont.Container

        SelfCont.TabButton = DebugGui1:Create("TextButton",{
            Name = PageDebug.PageTitle or "TabButton",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            BorderSizePixel = 0,
            ZIndex = 5,
            Font = Enum.Font.GothamSemibold,
            Text = PageDebug.Title or "Page",
            Size = UDim2.new(0, 0, 0, 0),
            TextColor3 = Color3.fromRGB(125, 125, 125),
            TextSize = 12.000,
            TextXAlignment = Enum.TextXAlignment.Left
        }) SelfCont.TabButton.Parent = SelfWindow.TabWindow
        SelfCont.TabButton.Size = UDim2.new(0, 10 + SelfCont.TabButton.TextBounds.X, 0, 16)

        SelfCont.TabButtonBackground = DebugGui1:Create("Frame",{
            Name = "TabButtonBackground",
            BackgroundColor3 = _G.ThemeColor,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 16),
            Size = UDim2.new(0, 0, 0, 1),
            ZIndex = 5
        }) SelfCont.TabButtonBackground.Parent = SelfCont.TabButton

        local function ResizeButton()
            SelfCont.TabButton.Size = UDim2.new(0, 10 + SelfCont.TabButton.TextBounds.X, 0, 16)
        end
        ResizeButton()
        
        SelfCont.TabButton:GetPropertyChangedSignal("Text"):Connect(ResizeButton)

        SelfCont.TabButton.MouseButton1Click:Connect(function()
            for c, ct in pairs(SelfWindow.ContainerHolder:GetChildren()) do
                if ct:IsA("ScrollingFrame") then
                    ct.Visible = false
                end
            end
            for t, tb in pairs(SelfWindow.TabWindow:GetDescendants()) do
                if tb:IsA("Frame") then
                    game:GetService("TweenService"):Create(tb, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 0, 1)}):Play()
                end
            end
            for x, tx in pairs(SelfWindow.TabWindow:GetChildren()) do
                if tx:IsA("TextButton") then
                    game:GetService("TweenService"):Create(tx, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(125, 125, 125)}):Play()
                end
            end
            game:GetService("TweenService"):Create(SelfCont.TabButton, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(180, 180, 180)}):Play()
            game:GetService("TweenService"):Create(SelfCont.TabButtonBackground, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 15, 0, 1)}):Play()
            SelfCont.Container.Visible = true
        end)

        local function ResizeContainer()
            SelfCont.Container.CanvasSize = UDim2.new(0, 0, 0, 0 + SelfCont.ContainerList.AbsoluteContentSize.Y + SelfCont.ContainerList.Padding.Offset)
        end
        SelfCont.ContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(ResizeContainer)

        if PageDebug.Opened == true then
            game:GetService("TweenService"):Create(SelfCont.TabButton, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(180, 180, 180)}):Play()
            game:GetService("TweenService"):Create(SelfCont.TabButtonBackground, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 15, 0, 1)}):Play()
            SelfCont.Container.Visible = true
        end

        local NisclsPage = {}

        function NisclsPage:NewFeatures(debugfeatures)
            local FeaturesStuff = {}
            local SelfFeatures = FeaturesStuff
            local DebugGui2 = NisclsSmallUI

            if string.lower(debugfeatures.Type) == "button" then
                SelfFeatures.ButtonHolder = DebugGui1:Create("TextButton",{
                    Name = debugfeatures.Title or "ButtonHolder",
                    BackgroundColor3 = Color3.fromRGB(26, 26, 26),
                    BorderSizePixel = 0,
                    Size = UDim2.new(0, SelfCont.Container.Size.X.Offset - 40, 0, 32),
                    ZIndex = 8,
                    AutoButtonColor = false,
                    Font = Enum.Font.SourceSans,
                    Text = "",
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    TextSize = 14.000
                }) SelfFeatures.ButtonHolder.Parent = SelfCont.Container

                SelfFeatures.ButtonHolderUICorner = DebugGui1:Create("UICorner",{
                    CornerRadius = UDim.new(0, 4),
                    Name = "ButtonHolderUICorner",
                }) SelfFeatures.ButtonHolderUICorner.Parent = SelfFeatures.ButtonHolder

                SelfFeatures.ButtonHolderTitle = DebugGui1:Create("TextLabel",{
                    Name = "ButtonHolderTitle",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1.000,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 10, 0, 0),
                    Size = UDim2.new(0, 390, 0, 0 + 32),
                    ZIndex = 9,
                    Font = Enum.Font.GothamSemibold,
                    Text = debugfeatures.Title or "Button Example",
                    TextColor3 = Color3.fromRGB(165, 165, 165),
                    TextSize = 13.000,
                    TextXAlignment = Enum.TextXAlignment.Left
                }) SelfFeatures.ButtonHolderTitle.Parent = SelfFeatures.ButtonHolder
                
                SelfFeatures.ButtonHolder.MouseEnter:Connect(function()
                    game:GetService("TweenService"):Create(SelfFeatures.ButtonHolder, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                end)
                SelfFeatures.ButtonHolder.MouseLeave:Connect(function()
                    game:GetService("TweenService"):Create(SelfFeatures.ButtonHolder, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(26, 26, 26)}):Play()
                end)       
                SelfFeatures.ButtonHolder.MouseButton1Click:Connect(function()
                    pcall(function()
                        debugfeatures.Callback()
                    end)
                end)
            elseif string.lower(debugfeatures.Type) == "checkbox" then

                SelfFeatures.ToggleHolder = DebugGui1:Create("Frame",{
                    Name = debugfeatures.Title or "ToggleHolder",
                    BackgroundColor3 = Color3.fromRGB(26, 26, 26),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(0, SelfCont.Container.Size.X.Offset - 40, 0, 0 + 32),
                    ZIndex = 8
                }) SelfFeatures.ToggleHolder.Parent = SelfCont.Container

                SelfFeatures.ToggleHolderTitle = DebugGui1:Create("TextLabel",{
                    Name = "ToggleHolderTitle",
                    Parent = SelfFeatures.ToggleHolder,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1.000,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 10, 0, 0),
                    Size = UDim2.new(0, SelfFeatures.ToggleHolder.Size.X.Offset -10 , 0, 32),
                    ZIndex = 9,
                    Font = Enum.Font.GothamSemibold,
                    Text = debugfeatures.Title or "Checkbox Example",
                    TextColor3 = Color3.fromRGB(165, 165, 165),
                    TextSize = 13.000,
                    TextXAlignment = Enum.TextXAlignment.Left
                }) SelfFeatures.ToggleHolderTitle.Parent = SelfFeatures.ToggleHolder

                SelfFeatures.ToggleHolderUICorner = DebugGui1:Create("UICorner",{
                    CornerRadius = UDim.new(0, 4),
                    Name = "ToggleHolderUICorner"
                }) SelfFeatures.ToggleHolderUICorner.Parent = SelfFeatures.ToggleHolder

                SelfFeatures.ToggleButtonImage = DebugGui1:Create("ImageButton",{
                    Name = "ToggleButtonImage",
                    BackgroundColor3 = _G.ThemeColor or Color3.fromRGB(16, 67, 185),
                    BackgroundTransparency = 0.500,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, SelfFeatures.ToggleHolder.Size.X.Offset - 22, 0, 8),
                    Size = UDim2.new(0, 16, 0, 16),
                    ZIndex = 10,
                    AutoButtonColor = false,
                    Image = "rbxassetid://7986568406",
                    ImageTransparency = 1.000
                }) SelfFeatures.ToggleButtonImage.Parent = SelfFeatures.ToggleHolder

                SelfFeatures.ToggleButtonImageUICorner = DebugGui1:Create("UICorner",{
                    CornerRadius = UDim.new(0, 2),
                    Name = "ToggleButtonImageUICorner"
                }) SelfFeatures.ToggleButtonImageUICorner.Parent = SelfFeatures.ToggleButtonImage

                local toggled = false
                SelfFeatures.ToggleButtonImage.MouseEnter:Connect(function()
                    if toggled then
                        game:GetService("TweenService"):Create(SelfFeatures.ToggleButtonImage, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.2}):Play()
                    else
                        game:GetService("TweenService"):Create(SelfFeatures.ToggleButtonImage, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.2}):Play()
                    end
                end)
                SelfFeatures.ToggleButtonImage.MouseLeave:Connect(function()
                    if toggled then
                        game:GetService("TweenService"):Create(SelfFeatures.ToggleButtonImage, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 0}):Play()
                    else
                        game:GetService("TweenService"):Create(SelfFeatures.ToggleButtonImage, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.3}):Play()
                    end
                end)
                SelfFeatures.ToggleButtonImage.MouseButton1Click:Connect(function()
                    if toggled then
                        toggled = false
                        game:GetService("TweenService"):Create(SelfFeatures.ToggleButtonImage, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.3, ImageTransparency = 1}):Play()
                        pcall(function()
                            debugfeatures.Callback(toggled)
                        end)
                        
                    else
                        toggled = true
                        game:GetService("TweenService"):Create(SelfFeatures.ToggleButtonImage, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 0, ImageTransparency = 0}):Play()
                        pcall(function()
                            debugfeatures.Callback(toggled)
                        end)
                        
                    end
                end)
            elseif string.lower(debugfeatures.Type) == "slider" then
                local SliderHolder = Instance.new("TextButton")


                local SliderHolderTitle = Instance.new("TextLabel")
                local SliderHolderUICorner = Instance.new("UICorner")
                local SliderButton = Instance.new("Frame")
                local SliderButtonUICorner = Instance.new("UICorner")
                local SliderFrame = Instance.new("Frame")
                local SliderFrameUICorner = Instance.new("UICorner")
                local SliderCircleDesign = Instance.new("Frame")
                local SliderCircleDesignUICorner = Instance.new("UICorner")
                local Val = Instance.new("TextLabel")
                
                --Properties:

                SliderHolder.Name = debugfeatures.Title or "SliderHolder"
                SliderHolder.Parent = SelfCont.Container
                SliderHolder.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                SliderHolder.BorderSizePixel = 0
                SliderHolder.Size = UDim2.new(0, SelfCont.Container.Size.X.Offset - 40, 0, 0 + 38)
                SliderHolder.ZIndex = 8
                SliderHolder.AutoButtonColor = false
                SliderHolder.Font = Enum.Font.SourceSans
                SliderHolder.Text = ""
                SliderHolder.TextColor3 = Color3.fromRGB(0, 0, 0)
                SliderHolder.TextSize = 14.000
                
                SliderHolderTitle.Name = "SliderHolderTitle"
                SliderHolderTitle.Parent = SliderHolder
                SliderHolderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderHolderTitle.BackgroundTransparency = 1.000
                SliderHolderTitle.BorderSizePixel = 0
                SliderHolderTitle.Position = UDim2.new(0, 10, 0, 0)
                SliderHolderTitle.Size = UDim2.new(0, 390, 0, 26)
                SliderHolderTitle.ZIndex = 9
                SliderHolderTitle.Font = Enum.Font.GothamSemibold
                SliderHolderTitle.Text = debugfeatures.Title or "WalkSpeed / JumpPower"
                SliderHolderTitle.TextColor3 = Color3.fromRGB(165, 165, 165)
                SliderHolderTitle.TextSize = 13.000
                SliderHolderTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                SliderHolderUICorner.CornerRadius = UDim.new(0, 4)
                SliderHolderUICorner.Name = "SliderHolderUICorner"
                SliderHolderUICorner.Parent = SliderHolder
                
                SliderButton.Name = "SliderButton"
                SliderButton.Parent = SliderHolder
                SliderButton.BackgroundColor3 = Color3.fromRGB(16, 67, 185)
                SliderButton.BackgroundTransparency = 0.600
                SliderButton.BorderSizePixel = 0
                SliderButton.Position = UDim2.new(0, 15, 0, 26)
                SliderButton.Size = UDim2.new(0, SliderHolder.Size.X.Offset - 25, 0, 2)
                SliderButton.ZIndex = 12
                
                SliderButtonUICorner.CornerRadius = UDim.new(0, 1000)
                SliderButtonUICorner.Name = "SliderButtonUICorner"
                SliderButtonUICorner.Parent = SliderButton
                
                SliderFrame.Name = "SliderFrame"
                SliderFrame.Parent = SliderButton
                SliderFrame.BackgroundColor3 = _G.ThemeColor
                SliderFrame.BackgroundTransparency = 0.4
                SliderFrame.BorderSizePixel = 0
                SliderFrame.Size = UDim2.new(0, 0, 0, 2)
                SliderFrame.ZIndex = 13
                
                SliderFrameUICorner.CornerRadius = UDim.new(0, 1000)
                SliderFrameUICorner.Name = "SliderFrameUICorner"
                SliderFrameUICorner.Parent = SliderFrame
                
                SliderCircleDesign.Name = "SliderCircleDesign"
                SliderCircleDesign.Parent = SliderFrame
                SliderCircleDesign.BackgroundColor3 = _G.ThemeColor
                SliderCircleDesign.BorderSizePixel = 0
                SliderCircleDesign.Position = UDim2.new(0, SliderFrame.Size.X.Offset - 8, 0, -3)
                SliderCircleDesign.Size = UDim2.new(0, 8, 0, 8)
                SliderCircleDesign.ZIndex = 15
                
                SliderCircleDesignUICorner.CornerRadius = UDim.new(0, 1000)
                SliderCircleDesignUICorner.Name = "SliderCircleDesignUICorner"
                SliderCircleDesignUICorner.Parent = SliderCircleDesign
                
                Val.Name = "Val"
                Val.Parent = SliderHolder
                Val.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Val.BackgroundTransparency = 1.000
                Val.BorderSizePixel = 0
                Val.Position = UDim2.new(0.862500012, 0, 0, 0)
                Val.Size = UDim2.new(0, 50, 0, 23)
                Val.ZIndex = 20
                Val.Font = Enum.Font.GothamSemibold
                Val.Text = debugfeatures.MinValue or "0"
                Val.TextColor3 = Color3.fromRGB(100, 100, 100)
                Val.TextSize = 12.000
                Val.TextXAlignment = Enum.TextXAlignment.Right

                local function repositionSliderCircle()
                    SliderCircleDesign.Position = UDim2.new(0, 0 + SliderFrame.Size.X.Offset - 8, 0, -3)
                end
                repositionSliderCircle()
                SliderFrame:GetPropertyChangedSignal("Position"):Connect(repositionSliderCircle)
                SliderFrame:GetPropertyChangedSignal("Size"):Connect(repositionSliderCircle)
                
                minvalue = debugfeatures.MinValue or 0
                maxvalue = debugfeatures.maxvalue or 100
                
                
                -----Callback-----
                callback = callback or function() end
                
                
                -----Variables-----
                local mouse = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")
                local Value;
                
                SliderHolder.MouseButton1Down:Connect(function()
                    Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / SliderButton.Size.X.Offset) * SliderFrame.AbsoluteSize.X) + tonumber(minvalue)) or 0
                    pcall(function()
                        debugfeatures.Callback(Value)
                    end)
                    SliderFrame.Size = UDim2.new(0, math.clamp(mouse.X - SliderFrame.AbsolutePosition.X, 0, SliderButton.Size.X.Offset), 0, 2)
                    moveconnection = mouse.Move:Connect(function()
                        Val.Text = Value
                        Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / SliderButton.Size.X.Offset) * SliderFrame.AbsoluteSize.X) + tonumber(minvalue))
                        pcall(function()
                            debugfeatures.Callback(Value)
                        end)
                        SliderFrame.Size = UDim2.new(0, math.clamp(mouse.X - SliderFrame.AbsolutePosition.X, 0, SliderButton.Size.X.Offset), 0, 2)
                    end)
                    releaseconnection = uis.InputEnded:Connect(function(Mouse)
                        if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                            Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / SliderButton.Size.X.Offset) * SliderFrame.AbsoluteSize.X) + tonumber(minvalue))
                            pcall(function()
                                debugfeatures.Callback(Value)
                            end)
                            SliderFrame.Size = UDim2.new(0, math.clamp(mouse.X - SliderFrame.AbsolutePosition.X, 0, SliderButton.Size.X.Offset), 0, 2)
                            moveconnection:Disconnect()
                            releaseconnection:Disconnect()
                        end
                    end)
                end)

            elseif string.lower(debugfeatures.Type) == "dropdown" then
                debugfeatures.List = debugfeatures.List or {}

                local DropdownHolder = Instance.new("TextButton")
                local DropdownHolderUICorner = Instance.new("UICorner")
                local DropdownHolderTitle = Instance.new("TextLabel")
                local DropdownImage = Instance.new("ImageLabel")
                local DropdownIn = Instance.new("Frame")
                local DropdownInList = Instance.new("UIListLayout")
                local DropdownButton = Instance.new("TextButton")
                
                --Properties:
                
                DropdownHolder.Name = debugfeatures.Title or "DropdownHolder"
                DropdownHolder.Parent = SelfCont.Container
                DropdownHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                DropdownHolder.BorderSizePixel = 0
                DropdownHolder.ClipsDescendants = true
                DropdownHolder.Size = UDim2.new(0, SelfCont.Container.Size.X.Offset - 40, 0, 0 + 37)
                DropdownHolder.ZIndex = 8
                DropdownHolder.AutoButtonColor = false
                DropdownHolder.Font = Enum.Font.SourceSans
                DropdownHolder.Text = ""
                DropdownHolder.TextColor3 = Color3.fromRGB(0, 0, 0)
                DropdownHolder.TextSize = 14.000
                
                DropdownHolderUICorner.CornerRadius = UDim.new(0, 4)
                DropdownHolderUICorner.Name = "DropdownHolderUICorner"
                DropdownHolderUICorner.Parent = DropdownHolder
                
                DropdownHolderTitle.Name = "DropdownHolderTitle"
                DropdownHolderTitle.Parent = DropdownHolder
                DropdownHolderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownHolderTitle.BackgroundTransparency = 1.000
                DropdownHolderTitle.BorderSizePixel = 0
                DropdownHolderTitle.Position = UDim2.new(0, 10, 0, 0)
                DropdownHolderTitle.Size = UDim2.new(0, 390, 0, 32)
                DropdownHolderTitle.ZIndex = 9
                DropdownHolderTitle.Font = Enum.Font.GothamSemibold
                DropdownHolderTitle.Text = debugfeatures.Title or "Pick Random Item"
                DropdownHolderTitle.TextColor3 = Color3.fromRGB(165, 165, 165)
                DropdownHolderTitle.TextSize = 13.000
                DropdownHolderTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                DropdownImage.Name = "DropdownImage"
                DropdownImage.Parent = DropdownHolder
                DropdownImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownImage.BackgroundTransparency = 1.000
                DropdownImage.BorderSizePixel = 0
                DropdownImage.Position = UDim2.new(0, DropdownHolder.Size.X.Offset - 20, 0, 5)
                DropdownImage.Size = UDim2.new(0, 22, 0, 22)
                DropdownImage.ZIndex = 10
                DropdownImage.Image = "rbxassetid://7987007324"
                DropdownImage.ImageColor3 = Color3.fromRGB(100, 100, 100)
                
                DropdownIn.Name = "DropdownIn"
                DropdownIn.Parent = DropdownHolder
                DropdownIn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownIn.BackgroundTransparency = 1.000
                DropdownIn.BorderSizePixel = 0
                DropdownIn.Position = UDim2.new(0, 0, 0, 37)
                DropdownIn.Size = UDim2.new(0, SelfCont.Container.Size.X.Offset - 40, 0, 0 + 1)
                DropdownIn.ZIndex = 9
                
                DropdownInList.Name = "DropdownInList"
                DropdownInList.Parent = DropdownIn
                DropdownInList.HorizontalAlignment = Enum.HorizontalAlignment.Center
                DropdownInList.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownInList.Padding = UDim.new(0, 5)
                
                DropdownButton.Name = "DropdownButton"
                DropdownButton.Parent = DropdownHolder
                DropdownButton.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                DropdownButton.BorderSizePixel = 0
                DropdownButton.Size = UDim2.new(0, SelfCont.Container.Size.X.Offset - 40, 0, 0 + 32)
                DropdownButton.ZIndex = 8
                DropdownButton.AutoButtonColor = false
                DropdownButton.Font = Enum.Font.SourceSans
                DropdownButton.Text = ""
                DropdownButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                DropdownButton.TextSize = 14.000

                DropdownButton.MouseEnter:Connect(function()
                    game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                end)
                DropdownButton.MouseLeave:Connect(function()
                    game:GetService("TweenService"):Create(DropdownButton, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(26, 26, 26)}):Play()
                end)
                DropdownButton.MouseButton1Click:Connect(function()
                    game:GetService("TweenService"):Create(DropdownHolder, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, SelfCont.Container.Size.X.Offset - 40, 0, 37 + DropdownInList.AbsoluteContentSize.Y + DropdownInList.Padding.Offset)}):Play()
                    game:GetService("TweenService"):Create(DropdownImage, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Rotation = 90}):Play()
                end)

                for indexdrop, valuedrop in next, debugfeatures.List do
                    local DropdownList = Instance.new("TextButton")
                    local DropdownListUICorner = Instance.new("UICorner")
                    
                    DropdownList.Name = valuedrop or "DropdownList"
                    DropdownList.Parent = DropdownIn
                    DropdownList.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                    DropdownList.BorderSizePixel = 0
                    DropdownList.Size = UDim2.new(0, DropdownHolder.Size.X.Offset, 0, 18)
                    DropdownList.ZIndex = 10
                    DropdownList.AutoButtonColor = false
                    DropdownList.Font = Enum.Font.GothamSemibold
                    DropdownList.Text = valuedrop or "None"
                    DropdownList.TextColor3 = Color3.fromRGB(120, 120, 120)
                    DropdownList.TextSize = 13.000
                    
                    DropdownListUICorner.CornerRadius = UDim.new(0, 4)
                    DropdownListUICorner.Name = "DropdownListUICorner"
                    DropdownListUICorner.Parent = DropdownList

                    DropdownList.MouseEnter:Connect(function()
                        game:GetService("TweenService"):Create(DropdownList, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                    end)
                    DropdownList.MouseLeave:Connect(function()
                        game:GetService("TweenService"):Create(DropdownList, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(26, 26, 26)}):Play()
                    end)
                    DropdownList.MouseButton1Click:Connect(function()
                        game:GetService("TweenService"):Create(DropdownHolder, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, SelfCont.Container.Size.X.Offset - 40, 0, 37)}):Play()
                        game:GetService("TweenService"):Create(DropdownImage, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Rotation = 0}):Play()
                        pcall(function()
                            debugfeatures.Callback(DropdownList.Text)
                        end)
                    end)

                end
            end
        end

        return NisclsPage
    end

    return NisclsWindow
end

return NisclsSmallUI
