local BufferUtilOnedps = require("@self/onedps")
local BufferUtilSleitnick = require("@self/Sleitnick")
local Sera = require("@self/Sera")

local sera_vector = buffer.create(12)
local sera_cframe = buffer.create(48)

local onedps_vector = buffer.create(12)
local onedps_cframe = buffer.create(24)

local sleitnick_cframe = BufferUtilSleitnick.writer(48)
local sleitnick_vector = BufferUtilSleitnick.writer(12)

return {
    Name = "BufferUtilTest",

	Parameter = function()
		local rand = math.random()
		return Vector3.new(rand, rand, rand)
	end,
	BeforeAll = function() end,
	AfterAll = function() end,
	BeforeEach = function() end,
	AfterEach = function() end,

	Functions = {
	        ["onedps"] = function(lib, value)
			lib.profilebegin("CFrame")
				BufferUtilOnedps.CFrame.Write(onedps_cframe, 0, CFrame.new(value, value))
				BufferUtilOnedps.CFrame.Read(onedps_cframe, 0)
			lib.profileend()

			lib.profilebegin("Vector3")
				BufferUtilOnedps.Vector3.Write(onedps_vector, 0, value)
				BufferUtilOnedps.Vector3.Read(onedps_vector, 0)
			lib.profileend()
		end,
		
		["Sleitnick"] = function(lib, value)
			lib.profilebegin("CFrame")
				sleitnick_cframe:WriteDataType(CFrame.new(value, value))
				local sleitnick_reader_cframe = BufferUtilSleitnick.reader(sleitnick_cframe)
				sleitnick_reader_cframe:ReadDataType(CFrame)
	        	lib.profileend()

			lib.profilebegin("Vector3")
				sleitnick_vector:WriteDataType(value)
				local sleitnick_reader_vector = BufferUtilSleitnick.reader(sleitnick_vector)
				sleitnick_reader_vector:ReadDataType(Vector3)
	        	lib.profileend()
		end,
		
		["Sera"] = function(lib, value)
			lib.profilebegin("CFrame")
				-- using lossy because its on same level with onedps cframe
				Sera.LossyCFrame.Ser(sera_cframe, 0, CFrame.new(value, value))
				Sera.LossyCFrame.Des(sera_cframe, 0)
			lib.profileend()

			lib.profilebegin("Vector3")
				Sera.Vector3.Ser(sera_vector, 0, value)
				Sera.Vector3.Des(sera_vector, 0)
			lib.profileend()
		end,
	}
}
