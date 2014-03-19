module(..., package.seeall)

local JsonConfigReader = require("scripts.config.JsonConfigReader")


local FILE_NAME = "config/matchs.json"
local mConfig = {}
local mConfigNum = 0

mConfig, mConfigNum = JsonConfigReader.read( FILE_NAME, "id" )

function getConfig( id )
	assert( mConfig[id] ~= nil, FILE_NAME.." dosen't has "..id )

	return mConfig[id]
end

function getConfigNum()
	return mConfigNum
end

--[[
	Provide additional getters.
--]]

function getTeam1( id )
	local config = getConfig( id )
	return config["team1"]
end

function getTeam2( id )
	local config = getConfig( id )
	return config["team2"]
end

function getTeam1WinOdds( id )
	local config = getConfig( id )
	return config["team1WinOdds"]
end

function getTeam2WinOdds( id )
	local config = getConfig( id )
	return config["team2WinOdds"]
end

function getDrawOdds( id )
	local config = getConfig( id )
	return config["drawOdds"]
end