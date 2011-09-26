--Create Text "Hello world" & Content size
local testWord = display.newText("Hello world!!", 50, 50, native.systemFont, 24)
testWord:setTextColor(255,255,0)
testWord.yScale = 2

local showWidth = display.newText(display.contentWidth,  50,  80, native.systemFont, 24)
local showHeight= display.newText(display.contentHeight, 50, 110, native.systemFont, 24)


--Create Sound
local beepSound = audio.loadSound("beep.wav")


--Create Button & Button event
local button = display.newImage( "button.png" )
button.x = display.contentWidth / 2
button.y = display.contentHeight - 50

function button:tap( event )
	local r = math.random( 0, 255 )
	local g = math.random( 0, 255 )
	local b = math.random( 0, 255 )

	testWord:setTextColor( r, g, b )
	audio.play(beepSound)
end
button:addEventListener( "tap", button )


--Create Square
local square = display.newRect(display.contentWidth *0.5,
                               display.contentHeight*0.5,
							   10,
							   10)
square:setFillColor(255, 255, 255)


--FrameEvent
local xdir = 1
local ydir = 0
local screenTop = display.screenOriginY
local screenBottom = display.viewableContentHeight + display.screenOriginY
local screenLeft = display.screenOriginX
local screenRight = display.viewableContentWidth + display.screenOriginX

local function animate(event)
    local xpos = square.x
	local ypos = square.y
	if xpos+xdir > screenRight or xpos+xdir < screenLeft then
	  xdir = xdir * -1
	end
	if ypos+ydir > screenBottom or ypos+ydir < screenTop then
	  ydir = ydir * -1
	end
	square:translate( xdir, ydir )
	--print(event.time)
end
Runtime:addEventListener( "enterFrame", animate );


--TouchEvent
local xin = 0;
local yin = 0;
local function touch(event)

	
    local phase = event.phase
	if phase == "began" then
	  print("x:"..event.x, "y:"..event.y)
	  xin = event.x
	  yin = event.y
	elseif phase == "ended" then
	  print("x:"..event.x, "y:"..event.y)
	  local hor = math.abs(event.x - xin)
	  local ver = math.abs(event.y - yin)
	  print("xin:"..xin, "yin:"..yin)
	  print("hor:"..hor, "ver:"..ver)
	  
	  if hor > ver then
	    if event.x > xin then xdir = 1 else xdir = -1 end
		ydir = 0
	  elseif ver > hor then
	    xdir = 0
		if event.y > yin then ydir = 1 else ydir = -1 end
	  end
	  print("xdir:"..xdir, "ydir:"..ydir)
	end
end
Runtime:addEventListener( "touch", touch )


--ShowOrientation
local function showOrientation(event)
	print(event.type)
end
Runtime:addEventListener( "orientation", showOrientation)