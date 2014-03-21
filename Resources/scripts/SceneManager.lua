module(..., package.seeall)

local mSceneGameLayer

function init()
	local eglView = CCEGLView:sharedOpenGLView()
	if CCApplication:sharedApplication():getTargetPlatform() == kTargetWindows then
		eglView:setFrameSize( 640, 960 )
	end
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