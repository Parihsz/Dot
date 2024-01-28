# Dot
🖼️ Library to render 3D in 2D canvas.

# Quick Installation
https://create.roblox.com/store/asset/16151925204/Dot

# Showcase
[![Watch the video](https://img.youtube.com/vi/LpYMHcKd4BA/maxresdefault.jpg)](https://youtu.be/LpYMHcKd4BA)

# API
## Constructor: 
```lua
Dot.new(uiElement, serial, centralUI, sizeMultiplier, speed, perspective, radius)
```
Parameters:
* uiElement (UI element): The UI element that represents the dot.
* serial (Number): An identifier or sequential number for the dot.
* centralUI (UI element): The central UI element used as a reference for positioning.
* sizeMultiplier (Number): Multiplier to scale the size of the dot.
* speed (Number): The speed at which the dot moves.
* perspective (Number): The perspective value used for 3D projection.
* radius (Number, optional): The radius of the dot's movement. Default is 0.8.

Returns:
* A new instance of the Dot Class.

## Methods:
```lua
Dot:Project(deltaTime, speed)
```
Parameters:
* deltaTime (Number): The change in time, used to calculate movement.
* speed (Number): Speed factor for the dot's movement.

Returns:
None

# Usage
```lua
local RunService = game:GetService("RunService")
local Dot = require(script:WaitForChild("Dot"))

local player = game.Players.LocalPlayer

local centralUI = script.Parent.Menu

local orbitingUIs = {
	{Element = centralUI["Talents [BT]"]},
	{Element = centralUI["Inventory [BT]"]},
	{Element = centralUI["Settings [BT]"]},
	{Element = centralUI["Stats [BT]"]},
	{Element = centralUI["PaidPurchases [BT]"]},
}

local angleIncrement = (2 * math.pi) / 5

local dots = {}
for i, info in orbitingUIs do
	local dot = Dot.new(info.Element, i, centralUI, 1.3, 1.5, 0.8, nil)
	dot.theta = i
	table.insert(dots, dot)
end

local lastUpdateTime = tick()

local function update()
	local currentTime = tick()
	local deltaTime = currentTime - lastUpdateTime
	lastUpdateTime = currentTime
	for _, dot in dots do
		dot:Project(deltaTime, 1.3)
	end
end

RunService.Heartbeat:Connect(update)
```
