module(..., package.seeall)

local FileWriter = require("scripts.FileWriter")

-- Singleton of logic
local instance

function getInstance()
	if instance == nil then
		instance = Logic:new()
	end

	return instance
end

Logic = {}

function Logic:new()
	if instance ~= nil then
		assert( false )
		return instance
	end
	
	local obj = {
		mPoint = 5000,
		mSelectedMatchIndex = 0,
		mPredictionList = {},
	}
    
    setmetatable(obj, self)
    self.__index = self
    
    obj.__newindex = function(t, k, v) assert(false, "Logic--"..k .. "__newindex not exist") end
    
    instance = obj
    return obj 
end

function Logic:getSelectedMatchIndex()
	return self.mSelectedMatchIndex
end

function Logic:setSelectedMatchIndex( index )
	self.mSelectedMatchIndex = index
end

function Logic:getPoint()
	return self.mPoint
end

function Logic:setPoint( p )
	self.mPoint = p
end

function Logic:consumePoint( v )
	if self.mPoint > v then
		self:setPoint( self.mPoint - v )
	else
		self:setPoint( 0 )
	end
end

function Logic:getPredictionList()
	return self.mPredictionList
end

function Logic:addPrediction( predictionIndex, prediciton )
	print("Index "..predictionIndex.." value "..prediciton)
	self.mPredictionList[""..predictionIndex] = prediciton		-- use tonumber("3")

	FileWriter.writeTableToFile( "prediction.json", self.mPredictionList )
end