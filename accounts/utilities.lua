local timer
function isClientSpam()
	if ( isTimer(timer) ) then
		return true
	end

	timer = setTimer(function() end, 4000, 1)
	return false
end

function getNetworkStatus()
	if ( getNetworkStats().packetlossLastSecond < 5 ) then
		return true
	end
	
	return false
end
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