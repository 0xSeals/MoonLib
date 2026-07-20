local Library = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

repeat task.wait() until Players.LocalPlayer

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")


local function GetTheme()

	return ({
		Purple = {
			MainFrame = Color3.fromRGB(40,28,49),
			TopFrame = Color3.fromRGB(30,20,40),
			TabFrame = Color3.fromRGB(30,20,40),
			TabButton = Color3.fromRGB(55,35,70)
		},

		Blue = {
			MainFrame = Color3.fromRGB(35,50,85),
			TopFrame = Color3.fromRGB(25,35,60),
			TabFrame = Color3.fromRGB(25,35,60),
			TabButton = Color3.fromRGB(40,65,120)
		},

		Green = {
			MainFrame = Color3.fromRGB(35,65,35),
			TopFrame = Color3.fromRGB(25,50,25),
			TabFrame = Color3.fromRGB(25,50,25),
			TabButton = Color3.fromRGB(40,90,40)
		}

	})[Theme] or {

		MainFrame = Color3.fromRGB(45,45,45),
		TopFrame = Color3.fromRGB(35,35,35),
		TabFrame = Color3.fromRGB(35,35,35),
		TabButton = Color3.fromRGB(60,60,60)

	}

end



function Library.CreateLib(Title, ThemeName)

	Name = Title
	Theme = ThemeName


	local Window = {}

	local ThemeData = GetTheme()



	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = Name
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = PlayerGui



	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Parent = ScreenGui

	MainFrame.AnchorPoint = Vector2.new(.5,.5)
	MainFrame.Position = UDim2.fromScale(.5,.5)
	MainFrame.Size = UDim2.fromOffset(650,400)

	MainFrame.BackgroundColor3 = ThemeData.MainFrame
	MainFrame.BorderSizePixel = 0



	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,15)
	Corner.Parent = MainFrame



	local TabHolder = Instance.new("Frame")
	TabHolder.Name = "TabHolder"
	TabHolder.Parent = MainFrame

	TabHolder.Size = UDim2.fromOffset(175,400)

	TabHolder.BackgroundColor3 = ThemeData.TabFrame
	TabHolder.BorderSizePixel = 0



	local Layout = Instance.new("UIListLayout")
	Layout.Parent = TabHolder

	Layout.Padding = UDim.new(0,8)
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center



	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Parent = MainFrame

	TopBar.Size = UDim2.new(1,0,0,50)
	TopBar.BackgroundColor3 = ThemeData.TopFrame
	TopBar.Active = true



	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Parent = TopBar

	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Position = UDim2.fromOffset(15,0)
	TitleLabel.Size = UDim2.new(1,-70,1,0)

	TitleLabel.Text = Name
	TitleLabel.Font = Font
	TitleLabel.TextSize = 22
	TitleLabel.TextColor3 = Color3.new(1,1,1)
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left



	-- EXIT BUTTON

	local Exit = Instance.new("TextButton")

	Exit.Parent = TopBar

	Exit.Size = UDim2.fromOffset(50,50)

	Exit.Position = UDim2.new(1,-50,0,0)

	Exit.BackgroundTransparency = 1

	Exit.Text = "✕"

	Exit.Font = Font

	Exit.TextSize = 24

	Exit.TextColor3 = Color3.new(1,1,1)



	Exit.MouseButton1Click:Connect(function()

		ScreenGui:Destroy()

	end)



	Exit.MouseEnter:Connect(function()

		TweenService:Create(
			Exit,
			TweenInfo.new(.15),
			{
				TextColor3 = Color3.fromRGB(255,90,90)
			}
		):Play()

	end)



	Exit.MouseLeave:Connect(function()

		TweenService:Create(
			Exit,
			TweenInfo.new(.15),
			{
				TextColor3 = Color3.new(1,1,1)
			}
		):Play()

	end)





	-- NEW TAB

	function Window:NewTab(TabName)


		local Tab = {}



		local Button = Instance.new("TextButton")

		Button.Name = TabName

		Button.Parent = TabHolder


		Button.Size = UDim2.fromOffset(150,40)


		Button.BackgroundColor3 = ThemeData.TabButton

		Button.BorderSizePixel = 0


		Button.Text = TabName

		Button.Font = Font

		Button.TextSize = 16

		Button.TextColor3 = Color3.new(1,1,1)



		local ButtonCorner = Instance.new("UICorner")

		ButtonCorner.CornerRadius = UDim.new(0,8)

		ButtonCorner.Parent = Button





		Button.MouseEnter:Connect(function()


			TweenService:Create(
				Button,
				TweenInfo.new(.15),
				{
					Size = UDim2.fromOffset(160,40)
				}
			):Play()


		end)



		Button.MouseLeave:Connect(function()


			TweenService:Create(
				Button,
				TweenInfo.new(.15),
				{
					Size = UDim2.fromOffset(150,40)
				}
			):Play()


		end)



		return Tab

	end





	-- DRAG SYSTEM


	local Dragging = false

	local DragStart

	local StartPosition



	TopBar.InputBegan:Connect(function(Input)


		if Input.UserInputType == Enum.UserInputType.MouseButton1 then


			Dragging = true


			DragStart = Input.Position

			StartPosition = MainFrame.Position


		end


	end)




	UserInputService.InputChanged:Connect(function(Input)


		if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then


			local Delta = Input.Position - DragStart



			MainFrame.Position = UDim2.new(

				StartPosition.X.Scale,

				StartPosition.X.Offset + Delta.X,


				StartPosition.Y.Scale,

				StartPosition.Y.Offset + Delta.Y

			)


		end


	end)




	UserInputService.InputEnded:Connect(function(Input)


		if Input.UserInputType == Enum.UserInputType.MouseButton1 then


			Dragging = false


		end


	end)



	return Window

end





-- OPTIONAL SETTINGS

function Library:SetFont(Value)

	Font = Value

end



return Library
