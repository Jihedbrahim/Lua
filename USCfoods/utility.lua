screen = {guiGetScreenSize()}
function dxText(outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded,
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


function isCursorOverRectangle(pos_x, pos_y, wigth, height)
	if (not isCursorShowing()) then
		return false
	end
	local cursor_x, cursor_y = getCursorPosition()
	local cursor_x, cursor_y = (cursor_x * screen[1]), (cursor_y * screen[2])
	return ((cursor_x >= pos_x and cursor_x <= pos_x + wigth) and (cursor_y >= pos_y and cursor_y <= pos_y + height))
end


validKeys = {
	["arrow_u"] = true,
	["arrow_d"] = true,
	["backspace"] = true,
	["space"] = true,
}

function dxRectangle( x, y, width, height, color1, postGUI )
	local _width = 0.07
	dxDrawRectangle( x + 1, y + 1, width - 1, height - 1, color1, postGUI )
	dxDrawLine( x, y, x + width, y, tocolor( 255, 255,255 ), _width, postGUI ) -- Top
	dxDrawLine( x, y, x, y + height, tocolor( 255, 255,255 ), _width, postGUI ) -- Left
	dxDrawLine( x, y + height, x + width, y + height, tocolor( 255, 255,255 ), _width, postGUI ) -- Bottom
	dxDrawLine( x + width, y, x + width, y + height, tocolor( 255, 255,255 ), _width, postGUI ) -- Right
end

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

