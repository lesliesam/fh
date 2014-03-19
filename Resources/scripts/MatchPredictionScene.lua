module(..., package.seeall)

local Constants = require("scripts.Constants")
local SceneManager = require("scripts.SceneManager")
local TeamConfig = require("scripts.config.Team")
local MatchConfig = require("scripts.config.Match")
local MatchListScene = require("scripts.MatchListScene")
local Logic = require("scripts.Logic").getInstance()

local mMatchIndex = 0

function loadFrame()
    mMatchIndex = Logic:getSelectedMatchIndex()

	local widget = GUIReader:shareReader():widgetFromJsonFile("scenes/MatchPrediction/MatchPrediction.ExportJson")
    SceneManager.clearNAddWidget(widget)

    local backBt = widget:getChildByName("Back")
    backBt:addTouchEventListener( backEventHandler )
    local team1WinBt = widget:getChildByName("team1Win")
    team1WinBt:addTouchEventListener( team1WinEventHandler )
    local team2WinBt = widget:getChildByName("team2Win")
    team2WinBt:addTouchEventListener( team2WinEventHandler )
    local drawBt = widget:getChildByName("draw")
    drawBt:addTouchEventListener( drawEventHandler )

    helperUpdatePoint( widget )
    helperInitMatchInfo( widget, mMatchIndex )
end

function team1WinEventHandler( sender, eventType )
    if eventType == TOUCH_EVENT_ENDED then
        Logic:addPrediction( mMatchIndex, Constants.TEAM1_WIN )
    end
end

function team2WinEventHandler( sender, eventType )
    if eventType == TOUCH_EVENT_ENDED then
        Logic:addPrediction( mMatchIndex, Constants.TEAM2_WIN )
    end
end

function drawEventHandler( sender, eventType )
    if eventType == TOUCH_EVENT_ENDED then
       Logic:addPrediction( mMatchIndex, Constants.DRAW )
    end
end

function backEventHandler( sender, eventType )
    if eventType == TOUCH_EVENT_ENDED then
        MatchListScene.loadFrame()
    end
end

function helperUpdatePoint( content )
    local point = Logic:getPoint()
    local pointLabel = tolua.cast( content:getChildByName("myPoint"), "Label" )
    pointLabel:setText( point )
end

function helperInitMatchInfo( content, matchIndex )
    local team1 = tolua.cast( content:getChildByName("team1"), "ImageView" )
    local team2 = tolua.cast( content:getChildByName("team2"), "ImageView" )
    local team1Name = tolua.cast( content:getChildByName("team1Name"), "Label" )
    local team2Name = tolua.cast( content:getChildByName("team2Name"), "Label" )
    local team1WinPoint = tolua.cast( content:getChildByName("team1WinPoint"), "Label" )
    local team2WinPoint = tolua.cast( content:getChildByName("team2WinPoint"), "Label" )
    local drawPoint = tolua.cast( content:getChildByName("drawPoint"), "Label" )

    team1:loadTexture( Constants.TEAM_IMAGE_PATH..TeamConfig.getLogo( MatchConfig.getTeam1( matchIndex ) ) )
    team2:loadTexture( Constants.TEAM_IMAGE_PATH..TeamConfig.getLogo( MatchConfig.getTeam2( matchIndex ) ) )
    team1Name:setText( TeamConfig.getDisplayName( MatchConfig.getTeam1( matchIndex ) ) )
    team2Name:setText( TeamConfig.getDisplayName( MatchConfig.getTeam2( matchIndex ) ) )
    team1WinPoint:setText( MatchConfig.getTeam1WinOdds( matchIndex ) )
    team2WinPoint:setText( MatchConfig.getTeam2WinOdds( matchIndex ) )
    drawPoint:setText( MatchConfig.getDrawOdds( matchIndex ) )
end