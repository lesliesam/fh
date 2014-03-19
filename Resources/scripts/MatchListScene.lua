module(..., package.seeall)

local Constants = require("scripts.Constants")
local SceneManager = require("scripts.SceneManager")
local TeamConfig = require("scripts.config.Team")
local MatchConfig = require("scripts.config.Match")
local MatchPredictionScene = require("scripts.MatchPredictionScene")
local Logic = require("scripts.Logic").getInstance()


local mMatchNum = MatchConfig.getConfigNum()

function loadFrame()
	local widget = GUIReader:shareReader():widgetFromJsonFile("scenes/MatchList/MatchListScene.ExportJson")
    SceneManager.clearNAddWidget(widget)


    local contentContainer = tolua.cast( widget:getChildByName("ScrollView"), "ScrollView" )
    local layoutParameter = LinearLayoutParameter:create()
    layoutParameter:setGravity(LINEAR_GRAVITY_LEFT)
    local contentHeight = 0

    for i = 1, mMatchNum do
        local eventHandler = function( sender, eventType )
            if eventType == TOUCH_EVENT_ENDED then
                enterMatch( i )
            end
        end

        local content = GUIReader:shareReader():widgetFromJsonFile("scenes/MatchList/MatchListContent.ExportJson")
        helperInitMatchInfo( content, i )

        content:setLayoutParameter( layoutParameter )
        contentContainer:addChild( content )
        contentHeight = contentHeight + content:getSize().height

        local vsBt = content:getChildByName("VS")
        vsBt:addTouchEventListener( eventHandler )
    end

    contentContainer:setInnerContainerSize( CCSize:new( 0, contentHeight ) )
    local layout = tolua.cast( contentContainer, "Layout" )
    layout:requestDoLayout()
end

function enterMatch( index )
    Logic:setSelectedMatchIndex( index )
    MatchPredictionScene.loadFrame()
end

function helperInitMatchInfo( content, matchIndex )
    local team1 = tolua.cast( content:getChildByName("team1"), "ImageView" )
    local team2 = tolua.cast( content:getChildByName("team2"), "ImageView" )
    local team1Name = tolua.cast( content:getChildByName("team1Name"), "Label" )
    local team2Name = tolua.cast( content:getChildByName("team2Name"), "Label" )
    team1:loadTexture( Constants.TEAM_IMAGE_PATH..TeamConfig.getLogo( MatchConfig.getTeam1( matchIndex ) ) )
    team2:loadTexture( Constants.TEAM_IMAGE_PATH..TeamConfig.getLogo( MatchConfig.getTeam2( matchIndex ) ) )
    team1Name:setText( TeamConfig.getDisplayName( MatchConfig.getTeam1( matchIndex ) ) )
    team2Name:setText( TeamConfig.getDisplayName( MatchConfig.getTeam2( matchIndex ) ) )
end