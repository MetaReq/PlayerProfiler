local module = {}
local RunService = game:GetService("RunService")

module.GetFPS = function()
	local TimeFunction = RunService:IsRunning() and time or os.clock

	local LastIteration, Start
	local FrameUpdateTable = {}
	local fps = 0
	local function HeartbeatUpdate()
		LastIteration = TimeFunction()
		for Index = #FrameUpdateTable, 1, -1 do
			FrameUpdateTable[Index + 1] = FrameUpdateTable[Index] >= LastIteration - 1 and FrameUpdateTable[Index] or nil
		end

		FrameUpdateTable[1] = LastIteration
		fps = tostring(math.floor(TimeFunction() - Start >= 1 and #FrameUpdateTable or #FrameUpdateTable / (TimeFunction() - Start)))
	end

	Start = TimeFunction()
	RunService.Heartbeat:Connect(HeartbeatUpdate)
	return tonumber(fps)
end

return module
