--!native
--!optimize 2
--!strict

local create = buffer.create

local writef32 = buffer.writef32
local writeu16 = buffer.writeu16
local readf32 = buffer.readf32
local readu16 = buffer.readu16

local vector3_new = Vector3.new

local cframe_new = CFrame.new
local cframe_fromxyz = CFrame.fromEulerAnglesXYZ
local cframe_toxyz = CFrame.new().ToEulerAnglesXYZ

local PI = math.pi
local TAU = math.tau

local VECTOR3_SIZE = 12
local CFRAME_SIZE = 18

local MAX_U16 = 65535

local quantize_angle = function(rad: number): number
	local a = rad % TAU
	if a > PI then a = a - TAU end

	return math.floor((a + PI) / TAU * MAX_U16 + 0.5)
end

local data_types = {}

data_types.Vector3 = {
	Write = function(buf: buffer, offset: number, value: Vector3): buffer
		buf = buf or create(VECTOR3_SIZE)

		writef32(buf, offset, value.X)
		writef32(buf, offset + 4, value.Y)
		writef32(buf, offset + 8, value.Z)

		return buf
	end,
	
	Read = function(buf: buffer, offset: number): Vector3
		return vector3_new(readf32(buf, offset), readf32(buf, offset + 4), readf32(buf, offset + 8))
	end
}

data_types.CFrame = {
	Write = function(buf: buffer, offset: number, value: CFrame): buffer
		buf = buf or create(CFRAME_SIZE)

		local x, y, z = cframe_toxyz(value)

		writef32(buf, offset, value.X)
		writef32(buf, offset + 4, value.Y)
		writef32(buf, offset + 8, value.Z)
		writeu16(buf, offset + 12, quantize_angle(x))
		writeu16(buf, offset + 14, quantize_angle(y))
		writeu16(buf, offset + 16, quantize_angle(z))

		return buf
	end,
	
	Read = function(buf: buffer, offset: number): CFrame
		local cframe = cframe_new(readf32(buf, offset), readf32(buf, offset + 4), readf32(buf, offset + 8))
		
		local qx = readu16(buf, offset + 12)
		local qy = readu16(buf, offset + 14)
		local qz = readu16(buf, offset + 16)

		local angles = cframe_fromxyz(
			(qx / 0xFFFF) * TAU - PI,
			(qy / 0xFFFF) * TAU - PI,
			(qz / 0xFFFF) * TAU - PI
		)

		return cframe * angles
	end
}

return data_types