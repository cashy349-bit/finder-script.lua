-- Configuration
local players = game:GetService("Players")
local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local mythicalFruits = {
	"Dragon Fruit",
	"Leopard Fruit",
	"Gas Fruit",
	"Spirit Fruit",
	"Venom Fruit",
	"Control Fruit",
	"Shadow Fruit",
	"Dough Fruit",
	"T-Rex Fruit",
	"Mammoth Fruit",
	"Gravity Fruit",
	"Blizzard Fruit",
	"Pain Fruit",
	"Sound Fruit",
	"Phoenix Fruit",
	"Portal Fruit",
	"Yeti Fruit",
	"Kitsune Fruit",
	"Lightning Fruit",
	"Creation Fruit"
}

-- Fruit Detection & Teleport
local function findFruits()
	for _, fruit in pairs(workspace:GetDescendants()) do
		if fruit:IsA("Model") and table.find(mythicalFruits, fruit.Name) then
			local primaryPart = fruit.PrimaryPart

			if primaryPart then
				local distance =
					(character.HumanoidRootPart.Position - primaryPart.Position).Magnitude

				spawn(function()
					createNotification(fruit, distance)
				end)

				teleportToFruit(fruit)
			end
		end
	end
end

-- Auto Server Hop
local function serverHop()
	while true do
		local success = false

		for _, fruit in pairs(workspace:GetDescendants()) do
			if fruit:IsA("Model")
				and table.find(mythicalFruits, fruit.Name) then

				success = true
				break
			end
		end

		if not success then
			game:GetService("TeleportService"):Teleport(game.PlaceId)
			wait(5)
		else
			break
		end
	end
end

-- Notification System
local function createNotification(fruit, distance)
	if not fruit:FindFirstChild("Notification") then
		local notification = Instance.new("BillboardGui")

		notification.Parent = fruit.PrimaryPart
		notification.Size = UDim2.new(0, 200, 0, 20)
		notification.StudsOffset = Vector3.new(0, 2, 0)
		notification.AlwaysOnTop = true

		local textLabel = Instance.new("TextLabel")
		textLabel.Parent = notification
		textLabel.Text = fruit.Name .. ": " .. math.floor(distance) .. " studs"
		textLabel.TextColor3 = Color3.new(1, 1, 1)
		textLabel.BackgroundTransparency = 1
	end
end

-- Teleport Logic
function teleportToFruit(fruit)
	local humanoid = character:WaitForChild("Humanoid")
	humanoid:ChangeState(Enum.HumanoidStateType.Teleport)
	fruit:WaitForChild("Teleport"):FireServer()
end

-- Main Execution
spawn(serverHop)

while wait(1) do
	findFruits()
end
