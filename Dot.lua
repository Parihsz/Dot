--!strict
export type DotType = {
	uiElement: GuiObject,
	originalSize: UDim2,
	radius: number,
	theta: number,
	phi: number,
	central: GuiObject,
	sizeMultiplier: number,
	speed: number,
	perspective: number,
	Project: (self: DotType, deltaTime: number, hovering: boolean) -> (),
}

local function new(
	uiElement: GuiObject,
	serial: number,
	centralUI: GuiObject,
	sizeMultiplier: number?,
	speed: number?,
	perspective: number?,
	radius: number?,
	n: number?
): DotType
	local theta = 0
	local phiStep = math.pi * 2 / (n or 5)
	local phi = phiStep * serial

	local function Project(self: DotType, deltaTime: number, hovering: boolean)
		local x = self.radius * math.sin(self.phi) * math.cos(self.theta)
		local y = self.radius * math.cos(self.phi)
		local z = self.radius * math.sin(self.phi) * math.sin(self.theta) + self.radius

		local speedMultiplier
		if hovering then
			speedMultiplier = 0.2
		elseif z > 1.3 then
			speedMultiplier = 4
		else
			speedMultiplier = 1.3
		end

		self.theta = self.theta + self.speed * deltaTime * speedMultiplier
		if self.theta > (2 * math.pi) then
			self.theta = self.theta - (2 * math.pi)
		end

		local scaleProjected = self.perspective / (self.perspective + z)
		local scaledSizeX = self.originalSize.X.Scale * scaleProjected * self.sizeMultiplier
		local scaledSizeY = self.originalSize.Y.Scale * scaleProjected * self.sizeMultiplier

		self.uiElement.Position = UDim2.new(
			self.central.Position.X.Scale + (x * scaleProjected),
			0,
			self.central.Position.Y.Scale + (y * scaleProjected),
			0
		)
		self.uiElement.Size = UDim2.new(scaledSizeX, 0, scaledSizeY, 0)
	end

	local dot: DotType = {
		uiElement = uiElement,
		originalSize = uiElement.Size,
		radius = radius or 0.8,
		theta = theta,
		phi = phi,
		central = centralUI,
		sizeMultiplier = sizeMultiplier or 1,
		speed = speed or 1,
		perspective = perspective or 1,
		Project = Project,
	}

	return dot
end

return {
	new = new,
}
