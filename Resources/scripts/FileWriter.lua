module(..., package.seeall)

local Json = require("json")

function writeTableToFile( fileName, content )
	local platformType = CCApplication:sharedApplication():getTargetPlatform()
	if platformType ~= kTargetWindows then
		return
	end

	local fileUtils = CCFileUtils:sharedFileUtils()
	local writePath = fileUtils:getWritablePath()..fileName
	local fileHandle, errorCode = io.open( writePath, "w+" )
	print( "Write to: "..writePath )
	if fileHandle == nil then
		assert( false, "Write failed to file"..fileName.." with error: "..errorCode )
		return
	end
	
	local text = Json.encode( content )
	fileHandle:write( text )
	fileHandle:close()
end
