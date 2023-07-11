validKeys = {
	["arrow_u"] = true,
	["arrow_d"] = true,
}

function dxText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded,
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

function isMouseInPosition( posX, posY, sizeX, sizeY )
	if (not isCursorShowing()) then return false end
	local cX, cY = getCursorPosition()
	local screenWidth, screenHeight = guiGetScreenSize()
	local cX, cY = (cX * screenWidth), (cY * screenHeight)

	return ((cX >= posX and cX <= posX + (sizeX - posX)) and (cY >= posY and cY <= posY + (sizeY - posY)))
end





function dxRectangle( x, y, width, height, color1, postGUI )
	local _width = _width or 1
	dxDrawRectangle( x + 1, y + 1, width - 1, height - 1, color1, postGUI )
	dxDrawLine( x, y, x + width, y, tocolor( 255, 255, 255, 50 ), _width, postGUI ) -- Top
	dxDrawLine( x, y, x, y + height, tocolor(  255, 255, 255, 50 ), _width, postGUI ) -- Left
	dxDrawLine( x, y + height, x + width, y + height, tocolor(  255, 255, 255, 50 ), _width, postGUI ) -- Bottom
	dxDrawLine( x + width, y, x + width, y + height, tocolor(  255, 255, 255, 50 ), _width, postGUI ) -- Right
end


function getMyTime (  )
	local time = getRealTime()

	local year = time.year + 1900
	local month = time.month + 1
	local day = time.monthday
	local hour = time.hour
	local minute = time.minute

	return "" .. hour ..":" .. minute .." - " .. month .."/" .. day .."/" .. year ..""
end
bindKey( 'F4', 'down', function()
	if isCursorShowing() == true then
		showCursor( false )
		isDXopened = false
	else
		showCursor( true )
		isDXopened = true
		triggerServerEvent( "onPlayerRequestVIPinfo", getLocalPlayer())
	end
	-- body
end )

function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end
