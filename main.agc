
// Project: jump 
// Created: 2020-10-26

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "jump" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

// Loading the floor
LoadImage(14, "floor.png")
CreateSprite(14,14) // create floor 
// variables to set floor coordinates
FloorX = 0
FloorY = 470
// increasing the size of floor to extend across the screen
SetSpriteSize(14,2000,200)
SetSpritePosition(14, FloorX, FloorY) // set sprite position

// player sprite and variables 
CreateImageColor(1,255,255,255,255) // White
CreateSprite(1,1)
SetSpriteSize(1,40,40)
SpriteX = 0
SpriteY = GetVirtualHeight() - 300
SetSpritePosition(1, SpriteX, SpriteY)

/* Timer variable that we will use to determine how long
sprite will move up the screen. 
*/
JumpTimer = 0
Jump = 0 // variable to check whether sprite is in the jump
Fall = 0 // variable to check whether sprite is falling

do
    gosub spritemove

    Print( GetRawLastKey() )
    Print(SpriteY)
    Sync()
loop

spritemove:

// Manages the left and right movement 
if GetRawKeyState(68) = 1 // D key
	SpriteX = SpriteX + 5
else
	if GetRawKeyState(65) = 1 // A key
		SpriteX = SpriteX - 5
	endif
endif

// --- Jump key --- //
if GetRawKeyPressed(32) // Space Key
	Jump = 1
endif

if GetSpriteCollision(1,14) = 1 or Jump = 1 
	Fall = 0
else
	Fall = 1
	
endif

if Fall = 0
	SpriteY = SpriteY + 0 // not going down
elseif Fall = 1
	SpriteY = SpriteY + 3 // goes down at 3 px/s
endif

if Jump = 1
	Fall = 0 
	JumpTimer = JumpTimer + 1
	Movement = 2
		if JumpTimer < 80
			SpriteY = SpriteY - Movement // sprite is going up
		elseif JumpTimer > 80
			SpriteY = SpriteY + Movement // sprite is going down
		endif
		
		if GetSpriteCollision(1,14) = 1 and JumpTimer > 80 // sprite is on the floor
			// reset all variables associated with jumping
			Movement = 0
			Fall = 0
			JumpTimer = 0
			Jump = 0 
		endif
endif
	
SetSpritePosition(1, SpriteX, SpriteY)
return
