messages = {}
lastMessage = ""
displayTimer = 12000
font = dxCreateFont("signpainter.ttf", 18)
msg = {
	{"Test 1"},
	{"Test 2"},
	{"Test 3"},
}


function DxMessage(text, r, g, b)
	local tick = getTickCount()
	if (type(text) ~= "string" or type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number") then return false end
	if (r > 255 or g > 255 or b > 255) then return false end
	if text == lastMessage then return false end
	playSoundFrontEnd(11)
	table.insert(messages, {text, r, g, b, tick + displayTimer, 170})
	outputConsole( "[DX Message] : "..text)
	iprint( "[DX Message] : "..text ) 
	lastMessage = text
	setTimer(function() lastMessage = "" end, 10000, 1)
end
addEvent("USCDXMessage", true)
addEventHandler("USCDXMessage", root, DxMessage)

local sX, sY = guiGetScreenSize()

function renderText()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible()) then return end
	local tick = getTickCount()
	if #messages > 6 then table.remove(messages, 1) end

	for i, v in ipairs (messages) do
		DxDrawBorderedRectangle(sX/2 - 400, (-26)+(i*25), 800, 25, tocolor(0, 0, 0, v[6]), 0.5)
		dxDrawBorderedText(2, v[1], sX/2, (-25)+(i*50), sX/2, 0, tocolor(v[2], v[3], v[4],
			v[6]), 0.7, "bankgothic", "center", "center", false, true, false, false)

		if tick >= v[5] then
			messages[i][6] = v[6]-2
			if v[6] <= 30 then table.remove(messages, i) end
		end
	end
end
addEventHandler("onClientRender", root, renderText)
setTimer( function() DxMessage("This dx text made by BenFireShade", 255, 0,0) end, 1000, 0)


function dxDrawBorderedText(outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded,
                            subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	local outline = (scale or 1) * (1.333333333333334 * (outline or 1))
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left - outline, top - outline, right - outline, bottom - outline, tocolor( 0, 0, 0, 150 ), scale, font,
	            alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left + outline, top - outline, right + outline, bottom - outline, tocolor( 0, 0, 0, 150 ), scale, font,
	            alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left - outline, top + outline, right - outline, bottom + outline, tocolor( 0, 0, 0, 150 ), scale, font,
	            alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left + outline, top + outline, right + outline, bottom + outline, tocolor( 0, 0, 0, 150 ), scale, font,
	            alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left - outline, top, right - outline, bottom, tocolor( 0, 0, 0, 150 ), scale, font, alignX, alignY,
	            clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left + outline, top, right + outline, bottom, tocolor( 0, 0, 0, 150 ), scale, font, alignX, alignY,
	            clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left, top - outline, right, bottom - outline, tocolor( 0, 0, 0, 150 ), scale, font, alignX, alignY,
	            clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text:gsub( "#%x%x%x%x%x%x", "" ), left, top + outline, right, bottom + outline, tocolor( 0, 0, 0, 150 ), scale, font, alignX, alignY,
	            clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	dxDrawText( text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation,
	            fRotationCenterX, fRotationCenterY )
end


function DxDrawBorderedRectangle( x, y, width, height, color1, _width, postGUI )
	local _width = _width or 1
	dxDrawRectangle( x + 1, y + 1, width - 1, height - 1, color1, postGUI )
	dxDrawLine( x, y, x + width, y, tocolor( 255, 255, 255 ), _width, postGUI ) -- Top
	dxDrawLine( x, y, x, y + height, tocolor( 255, 255, 255 ), _width, postGUI ) -- Left
	dxDrawLine( x, y + height, x + width, y + height, tocolor( 255, 255, 255 ), _width, postGUI ) -- Bottom
	dxDrawLine( x + width, y, x + width, y + height, tocolor( 255, 255, 255 ), _width, postGUI ) -- Right
end