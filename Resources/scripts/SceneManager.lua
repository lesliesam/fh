module(..., package.seeall)

local FileWriter = require("scripts.FileWriter")

local mSceneGameLayer

function init()
	local eglView = CCEGLView:sharedOpenGLView()
	eglView:setFrameSize( 640, 960 )
	eglView:setDesignResolutionSize( 640, 960, kResolutionShowAll )

	local sceneGame = CCScene:create()
    CCDirector:sharedDirector():runWithScene(sceneGame)
    mSceneGameLayer = TouchGroup:create()
    sceneGame:addChild(mSceneGameLayer)
end

function clearNAddWidget( widget )
	mSceneGameLayer:clear()
	addWidget(widget)
end

function addWidget(widget)
	mSceneGameLayer:addWidget(widget)
end