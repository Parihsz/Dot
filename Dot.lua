local Dot = {}
Dot.__index = Dot

local player = game.Players.LocalPlayer

function Dot.new(uiElement, serial, centralUI, sizeMultiplier, speed, perspective, radius, n)
	local self = setmetatable({}, Dot)
	self.uiElement = uiElement
	self.originalSize = uiElement.Size
	self.radius = radius or 0.8
	self.theta = 0
	local phiStep = math.pi / n
	self.phi = phiStep * serial + serial 
	self.central = centralUI
	self.sizeMultiplier = sizeMultiplier
	self.speed = speed
	self.perspective = perspective
	
	return self
end

function Dot:Project(deltaTime, speed)
	self.x = self.radius * math.sin(self.phi) * math.cos(self.theta)
	self.y = self.radius * math.cos(self.phi)
	self.z = self.radius * math.sin(self.phi) * math.sin(self.theta) + self.radius

	self.theta = self.theta + self.speed * deltaTime * self.speed
	if self.theta > (2 * math.pi) then
		self.theta = self.theta - (2 * math.pi)
	end

	self.scaleProjected = self.perspective / (self.perspective + self.z)

	local scaledSizeX = self.originalSize.X.Scale * self.scaleProjected * self.sizeMultiplier
	local scaledSizeY = self.originalSize.Y.Scale * self.scaleProjected * self.sizeMultiplier

	self.uiElement.Position = UDim2.new(
		self.central.Position.X.Scale + (self.x * self.scaleProjected), 0,
		self.central.Position.Y.Scale + (self.y * self.scaleProjected), 0
	)
	self.uiElement.Size = UDim2.new(scaledSizeX, 0, scaledSizeY, 0)
end


return Dot
