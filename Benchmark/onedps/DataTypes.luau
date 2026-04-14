--!native
--!optimize 2
--!strict

local create = buffer.create

local writef32 = buffer.writef32
local readf32 = buffer.readf32

local vector3_new = Vector3.new

local cframe_new = CFrame.new
local cframe_fromxyz = CFrame.fromEulerAnglesXYZ
local cframe_toxyz = CFrame.new().ToEulerAnglesXYZ

local VECTOR3_SIZE = 12
local CFRAME_SIZE = 24

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
		writef32(buf, offset + 12, x)
		writef32(buf, offset + 16, y)
		writef32(buf, offset + 20, z)

		return buf
	end,
	
	Read = function(buf: buffer, offset: number): CFrame
		local cframe = cframe_new(readf32(buf, offset), readf32(buf, offset + 4), readf32(buf, offset + 8))
		local angles = cframe_fromxyz(readf32(buf, offset + 12), readf32(buf, offset + 16), readf32(buf, offset + 20))

		return cframe * angles
	end
}

return data_types