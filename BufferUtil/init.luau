--!native
--!optimize 2
--!strict

local create = buffer.create

local writeu8 = buffer.writeu8
local writef64 = buffer.writef64
local writef32 = buffer.writef32

local readu8 = buffer.readu8
local readf64 = buffer.readf64
local readf32 = buffer.readf32

local SIZE_8 = 1
local SIZE_32 = 4
local SIZE_64 = 8

local data_types = require("@self/DataTypes")

local buffer_util = {}

buffer_util = setmetatable(buffer_util, {__index = data_types})

buffer_util.Float = {
	Write = function(buf: buffer, offset: number, value: number): buffer
		buf = buf or create(SIZE_32)
		writef32(buf, offset, value)

		return buf
	end,
	
	Read = function(buf: buffer, offset: number): number
		return readf32(buf, offset)
	end
}

buffer_util.Double = {
	Write = function(buf: buffer, offset: number, value: number): buffer
		buf = buf or create(SIZE_64)
		writef64(buf, offset, value)

		return buf
	end,
	
	Read = function(buf: buffer, offset: number): number
		return readf64(buf, offset)
	end
}

buffer_util.Boolean = {
	Write = function(buf: buffer, offset: number, value: boolean): buffer
		buf = buf or create(SIZE_8)
		writeu8(buf, offset, value and 1 or 0)

		return buf
	end,
	
	Read = function(buf: buffer, offset: number): boolean
		return readu8(buf, offset) == 1 and true or false
	end
}

return buffer_util