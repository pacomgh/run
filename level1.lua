-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

function scene:create( event )

	sceneGroup = self.view

	function scrollBgnd( self, event )
		if self.x < -477 then
			self.x = 480
		else
			self.x = self.x - self.speed
		end
	end

	bg1 = display.newImageRect( "Assets/backgroundElements/Samples/colored_talltrees.png", screenW, screenH )
	bg1.anchorX, bg1.anchorY =0, 0
	bg1.x, bg1.y = 0, 0
	bg1.speed = 1.5

	bg2 = display.newImageRect( "Assets/backgroundElements/Samples/colored_talltrees.png", screenW, screenH )
	bg2.anchorX, bg2.anchorY =0, 0
	bg2.x, bg2.y = 480, 0
	bg2.speed = 1.5

	floor1 = display.newImageRect( "Assets/backgroundElements/Floor/castle_floor3.jpg.png", 393, 41 )
	floor1.x, floor1.y = display.contentWidth/2, 310
	floor1.yScale = .5
	floor1.xScale = 1.5
	floor1.speed = 1.5

	floor2 = display.newImageRect( "Assets/backgroundElements/Floor/castle_floor3.jpg.png", 393, 41 )
	floor2.x, floor2.y = display.contentWidth*1.6, 310
	floor2.yScale = .5
	floor2.xScale = 1.5
	floor2.speed = 1.5

	dataSheetMegaMan = { width=65, height=48, numFrames=3, sheetContentWidth=195, sheetContentHeight=48  }
	megaman = graphics.newImageSheet( "Assets/megaman2a.png", dataSheetMegaMan )
	sequenceDataMegaMan = { name="movMega", start=1, count=4, time=300 }
	megaSprite = display.newSprite( megaman, sequenceDataMegaMan  )

	sceneGroup:insert( bg1 )
	sceneGroup:insert( floor1 )
	sceneGroup:insert( bg2 )
	sceneGroup:insert( floor2 )
	sceneGroup:insert( megaSprite )

	bg1.enterFrame = scrollBgnd
	Runtime:addEventListener( "enterFrame", bg1 )

	floor1.enterFrame = scrollBgnd
	Runtime:addEventListener( "enterFrame", floor1 )

	bg2.enterFrame = scrollBgnd
	Runtime:addEventListener( "enterFrame", bg2 )

	floor2.enterFrame = scrollBgnd
	Runtime:addEventListener( "enterFrame", floor2 )

end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		megaSprite.x, megaSprite.y = 50, 280
		megaSprite:setSequence( "movMega" )
		megaSprite:play(  )
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene