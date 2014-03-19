module(..., package.seeall)

local Json = require("json")

function read( fileName, primaryKey )
	local config = {}
	local configNum = 0

	local fileHandle, errorCode = io.open( fileName, "r" )
	local text = fileHandle:read( "*all" )
	fileHandle:close()

	local jsonObject = Json.decode( text )
	for i,v in pairs(jsonObject) do
	    local id = v[primaryKey]

	    config[id] = v
	    configNum = configNum + 1
	end

	return config, configNum
end