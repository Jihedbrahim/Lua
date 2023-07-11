screen = {guiGetScreenSize()}
iW, iH = 391, 256
local maximumLetter = 20
local actualEditing = ""
local usernameEditBoxLogin = ""
local passwordEditBoxLogin = ""

function isCursorInPosition(rectX, rectY, rectW, rectH)
	if not isCursorShowing() then return false end
	local cursorX, cursorY = getCursorPosition()
	local cursorX, cursorY = cursorX * screen[1], cursorY * screen[2]
	return (cursorX >= rectX and cursorX <= rectX+rectW) and (cursorY >= rectY and cursorY <= rectY+rectH)
end

function isCursorOverText( posX, posY, sizeX, sizeY )
	if (not isCursorShowing()) then return false end
	local cX, cY = getCursorPosition()
	local screenWidth, screenHeight = guiGetScreenSize()
	local cX, cY = (cX * screenWidth), (cY * screenHeight)

	return ((cX >= posX and cX <= posX + (sizeX - posX)) and (cY >= posY and cY <= posY + (sizeY - posY)))
end

addEventHandler("onClientRender", root,
	function()
		--dxDrawRectangle(0, 0, screen[1], screen[2], tocolor(0, 0,0, 175), false)
		if isCursorInPosition(463, 449, 355, 54) then
			dxDrawImage( (screen[1]/2)-(iW/2), (screen[2]/2)-(iH/2), (iW), (iH), "files/new login.png")
		else 
			dxDrawImage( (screen[1]/2)-(iW/2), (screen[2]/2)-(iH/2), (iW), (iH), "files/new login hover.png")
		
		end

		if isCursorOverText( 459, 289, 824, 330) or actualEditing == "LoginUsername" then
			dxDrawBorderedText(0.5,"Username : "..usernameEditBoxLogin, 459, 289, 824, 330, tocolor(255, 255, 255, 255), 1.20, "default-bold", "left", "center", false, false, true, false, false)
        else
        	dxDrawBorderedText(0.5,"Username : "..usernameEditBoxLogin, 459, 289, 824, 330, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, true, false, false)
        end	

        if isCursorOverText( 459, 346, 824, 387) or actualEditing == "LoginPassword" then
        	dxDrawBorderedText(0.5,"Password : "..passwordEditBoxLogin, 459, 346, 824, 387, tocolor(255, 255, 255, 255), 1.20, "default-bold", "left", "center", false, false, true, false, false)
    	else
    		dxDrawBorderedText(0.5,"Password : "..passwordEditBoxLogin, 459, 346, 824, 387, tocolor(255, 255, 255, 255), 1.0, "default-bold", "left", "center", false, false, true, false, false)
    	end
	end
	)
	

camera = {
	[1] = { 1240.27, -936.21, 150.21, 1642.19, -1619.45, 76.21, 1281.33, -1184.23, 94.22},
	[2] = { 2953.32007, -2079.47217, 80.95277, 2902.98071, -2083.04590, 2.02448, 2899.27417, -2082.65, 2.50},
	[3] = { -1881.52, 358.50, 94.68, -1592.52, 632.09, 71.23,-1591.7819, 632.765, 71.32},
	[4] = {-2295.220, 1400.186, 17.501, -2648.546, 1863.905, 101.285,   -2649.0891113281, 1864.7237548828, 101.47338104248}
}



local dx = 0.0
local ID = math.random(1, #camera)

function interpolateCam()
		dx = dx + 0.0009
		local ix, iy, iz = interpolateBetween(camera[ID][1], camera[ID][2], camera[ID][3], camera[ID][4], camera[ID][5], camera[ID][6], dx, "OutQuad")
		setCameraMatrix(ix, iy, iz, camera[ID][7], camera[ID][8], camera[ID][9] )
end
addEventHandler("onClientRender", root, interpolateCam)


addEventHandler( "onClientCharacter", root, 
	function (character)
		if actualEditing == "LoginUsername" then
			maximumLetter = 20
		end
		
		if (utf8.len(usernameEditBoxLogin) <= maximumLetter) then
			usernameEditBoxLogin = usernameEditBoxLogin..character
		end
	end
)



addEventHandler("onClientKey", root,
	function(button, state)

		if not state then return false end
		if button ~= "mouse1" or button ~= "backspace" then return false end
		if actualEditing == "" then return false end
		if button == "mouse1" then
			actualEditing = ""
			if isCursorOverText(459, 289, 824, 330) then
				actualEditing = "LoginUsername"
				iprint("username")
			end
		end
		if button == "backspace" then
			if utf8.len(usernameEditBoxLogin) >= 1 then
				usernameEditBoxLogin = utf8.sub(usernameEditBoxLogin, 1, utf8.len(usernameEditBoxLogin)-1)
			end
		end
	end
	)

function dxDrawBorderedText(outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded,
                            subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	local outline = (scale or 1) * (1.333333333333334 * (outline or 1))
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left - outline, top - outline, right - outline, bottom - outline, tocolor( 0, 0, 0, 225 ), scale, font,
	            alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left + outline, top - outline, right + outline, bottom - outline, tocolor( 0, 0, 0, 225 ), scale, font,
	            alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left - outline, top + outline, right - outline, bottom + outline, tocolor( 0, 0, 0, 225 ), scale, font,
	            alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left + outline, top + outline, right + outline, bottom + outline, tocolor( 0, 0, 0, 225 ), scale, font,
	            alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left - outline, top, right - outline, bottom, tocolor( 0, 0, 0, 225 ), scale, font, alignX, alignY,
	            clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left + outline, top, right + outline, bottom, tocolor( 0, 0, 0, 225 ), scale, font, alignX, alignY,
	            clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left, top - outline, right, bottom - outline, tocolor( 0, 0, 0, 225 ), scale, font, alignX, alignY,
	            clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left, top + outline, right, bottom + outline, tocolor( 0, 0, 0, 225 ), scale, font, alignX, alignY,
	            clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation,
	            fRotationCenterX, fRotationCenterY )
end