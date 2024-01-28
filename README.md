# Dot
🖼️ Library to render 3D in 2D canvas.

# Quick Installation
https://create.roblox.com/store/asset/16151925204/Dot

# Showcase
[![Watch the video](https://img.youtube.com/vi/LpYMHcKd4BA/maxresdefault.jpg)](https://youtu.be/LpYMHcKd4BA)

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
