--	┌───────────────┐ --
--	│               │ --
--	│    EXAMPLE    │ --
--	│               │ --
--	└───────────────┘ --

	display.setStatusBar( display.HiddenStatusBar )

--	┌───────────────────────────────────────────────────────────────────────────────────────────────
--	│ CONSTANTS
--	└───────────────────────────────────────────────────────────────────────────────────────────────

		_W = display.contentWidth
		_H = display.contentHeight
		_X = _W * 0.5
		_Y = _H * 0.5

--	┌───────────────────────────────────────────────────────────────────────────────────────────────
--	│ MODULES
--	└───────────────────────────────────────────────────────────────────────────────────────────────

		local filter = require 'filter'
		local physics = require 'physics'

--	┌───────────────────────────────────────────────────────────────────────────────────────────────
--	│ PHYSICS
--	└───────────────────────────────────────────────────────────────────────────────────────────────

		physics.start()
		physics.setGravity( 0, 9.8 )
		physics.setDrawMode( 'hybrid' )

--	┌───────────────────────────────────────────────────────────────────────────────────────────────
--	│ VECTORS
--	└───────────────────────────────────────────────────────────────────────────────────────────────

		local borderTop = display.newRect( 0, 0, _W, 5 )
		local borderRight = display.newRect( _W-5, 0, 5, _H )
		local borderBottom = display.newRect( 0, _H-5, _W, 5 )
		local borderLeft = display.newRect( 0, 0, 5, _H )

		borderTop:setFillColor( 255,255,255 )
		borderRight:setFillColor( 255,255,255 )
		borderBottom:setFillColor( 255,255,255 )
		borderLeft:setFillColor( 255,255,255 )

		borderTop.name = 'BORDER'
		borderRight.name = 'BORDER'
		borderBottom.name = 'BORDER'
		borderLeft.name = 'BORDER'
		
		local statics = display.newGroup()
		statics:insert( borderTop )
		statics:insert( borderRight )
		statics:insert( borderBottom )
		statics:insert( borderLeft )

		local redCircle = display.newCircle( 150, 150, 100 )
		local greenCircle = display.newCircle( _W-150, 150, 100 )
		local blueCircle = display.newCircle( _W-150, _H-150, 100 )
		local yellowCircle = display.newCircle( 150, _H-150, 100 )

		redCircle:setFillColor( 255,0,0 )
		greenCircle:setFillColor( 0,255,0 )
		blueCircle:setFillColor( 0,0,255 )
		yellowCircle:setFillColor( 255,225,0 )

		redCircle.name = 'RED'
		greenCircle.name = 'GREEN'
		blueCircle.name = 'BLUE'
		yellowCircle.name = 'YELLOW'
		
		local dynamics = display.newGroup()
		dynamics:insert( redCircle )
		dynamics:insert( greenCircle )
		dynamics:insert( blueCircle )
		dynamics:insert( yellowCircle )

--	------------------------------------------------------------------------------------------------

		local d = { bounce = 0.8, friction = 0.2, radius = 100 }
		local s = { bounce = 1.1, friction = 0.2 }

--	------------------------------------------------------------------------------------------------

	--	You can give the categories and the targets
	--	readable and descriptive names like this ...

--[[]]--

		physics.addBody( borderTop, 'static', filter:deploy( s, 'BORDER', { 'RED','GREEN','BLUE','YELLOW' } ) )
		physics.addBody( borderRight,'static', filter:deploy( s, 'BORDER', { 'RED','GREEN','BLUE','YELLOW' } ) )
		physics.addBody( borderBottom, 'static', filter:deploy( s, 'BORDER', { 'RED','GREEN','BLUE','YELLOW' } ) )
		physics.addBody( borderLeft, 'static', filter:deploy( s, 'BORDER', { 'RED','GREEN','BLUE','YELLOW' } ) )
	
		physics.addBody( redCircle,'dynamic',		filter:deploy( d, 'RED',	{ 'BLUE','YELLOW','BORDER' } ) )
		physics.addBody( greenCircle, 'dynamic',	filter:deploy( d, 'GREEN',	{ 'BLUE','YELLOW','BORDER' } ) )
		physics.addBody( blueCircle, 'dynamic',		filter:deploy( d, 'BLUE',	{ 'RED','GREEN','YELLOW','BORDER' } ) )
		physics.addBody( yellowCircle, 'dynamic',	filter:deploy( d, 'YELLOW',	{ 'RED','GREEN','BORDER' } ) )

--[[]]--

	--	Or you can just make use
	--	of numbers like this ...

--[[

		physics.addBody( borderTop, 'static', filter:deploy( s, 1, { 2,3,4,5 } ) )
		physics.addBody( borderRight,'static', filter:deploy( s, 1, { 2,3,4,5 } ) )
		physics.addBody( borderBottom, 'static', filter:deploy( s, 1, { 2,3,4,5 } ) )
		physics.addBody( borderLeft, 'static', filter:deploy( s, 1, { 2,3,4,5 } ) )
	
		physics.addBody( redCircle,'dynamic', filter:deploy( d, 2, { 1,4,5 } ) )
		physics.addBody( greenCircle, 'dynamic', filter:deploy( d, 3, { 1,4,5 } ) )
		physics.addBody( blueCircle, 'dynamic', filter:deploy( d, 4, { 1,2,3,5 } ) )
		physics.addBody( yellowCircle, 'dynamic', filter:deploy( d, 5, { 1,2,3 } ) )

]]--

--	------------------------------------------------------------------------------------------------

		redCircle:applyLinearImpulse( 5, 5, redCircle.x, redCircle.y )
		greenCircle:applyLinearImpulse( 5, 5, redCircle.x, redCircle.y )
		blueCircle:applyLinearImpulse( 5, 5, redCircle.x, redCircle.y )
		yellowCircle:applyLinearImpulse( 5, 5, redCircle.x, redCircle.y )

--	------------------------------------------------------------------------------------------------

		local collision = function( s, e )

			if e.phase == 'began' then

			--	print( s.name .. ' collided with ' .. e.other.name )

			end

		end

--	------------------------------------------------------------------------------------------------	

		for i=1, #statics do
		
			statics[i].collision = collision
			statics[i]:addEventListener( 'collision', statics[i] )
		
		end
		
		for i=1, #dynamics do
		
			dynamics[i].collision = collision
			dynamics[i]:addEventListener( 'collision', dynamics[i] )
		
		end	
	
	
