--!native
--!optimize 2

local create = buffer.create

local writef32 = buffer.writef32
local readf32 = buffer.readf32

local vector3_new = Vector3.new
local cframe_new = CFrame.new
local cframe_xyz = CFrame.fromEulerAnglesXYZ

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
		local x, y, z = readf32(buf, offset), readf32(buf, offset + 4), readf32(buf, offset + 8)
		return vector3_new(x, y, z)
	end
}

data_types.CFrame = {
	Write = function(buf: buffer, offset: number, value: CFrame): buffer
		buf = buf or create(CFRAME_SIZE)

		local x, y, z = value:ToEulerAnglesXYZ()
		local pos = value.Position

		writef32(buf, offset, pos.X)
		writef32(buf, offset + 4, pos.Y)
		writef32(buf, offset + 8, pos.Z)
		writef32(buf, offset + 12, x)
		writef32(buf, offset + 16, y)
		writef32(buf, offset + 20, z)

		return buf
	end,
	
	Read = function(buf: buffer, offset: number): CFrame
		local pos = vector3_new(readf32(buf, offset), readf32(buf, offset + 4), readf32(buf, offset + 8))
		local angles = cframe_xyz(readf32(buf, offset + 12), readf32(buf, offset + 16), readf32(buf, offset + 20))

		return cframe_new(pos) * angles
	end
}

return data_types