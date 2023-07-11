isOpen = false

screen = {guiGetScreenSize()}
	if screen[1] >= 1280 and screen[2]>= 800 then
		currentScreenX, currentScreenY = 1280, 800
	else 
	 	currentScreenX, currentScreenY = 1024, 768
	end
	csX, csY =  (screen[1]/currentScreenX), (screen[2]/currentScreenY)
	
topKillers = {}
topDeaths = {}

function getKeyFromVal(table, name)
	if (not name ) then
		return false
	end
	if (type(table) ~= "table" ) then
		return false 
	end
	for i, v in pairs ( table ) do
		if ( v[1] == name ) then 
			return i
		end
	end
	return false
end

function addKill(name, num)
    if (not name or not num) then
        return false
    end
    local key = getKeyFromVal(topKillers, name)
   	if (not topKillers[key] ) then 
    	table.insert(topKillers, {name, 0})
    end
	
	local key = getKeyFromVal(topKillers, name)
    if topKillers[key] then
	    topKillers[key][2] = topKillers[key][2] + num
	    
	end
end

function addDeath(name, num)
    if (not name or not num) then
        return false
    end
    local key = getKeyFromVal(topDeaths, name)
   	if (not topDeaths[key] ) then 
    	table.insert(topDeaths, {name, 0})
    end
	
	local key = getKeyFromVal(topDeaths, name)
    if topDeaths[key] then
	    topDeaths[key][2] = topDeaths[key][2] + num
	    
	end
end

function sortKills()
	setTimer(function()
				table.sort(topKillers, 
					function (a, b) 
						return a[2] > b[2] 
					end
				)
				end, 1000, 0)
	return topKillers
end	


function sortDeath()
	setTimer(function()
				table.sort(topDeaths, 
					function (a, b) 
						return a[2] > b[2] 
					end
				)
				end, 1000, 0)
	return topDeaths
end	

function isPlayerInsideArea(player)
    for i,col in ipairs(getElementsByType("colshape", resourceRoot)) do
        if (isElementWithinColShape(player, col) and getElementData(col, "pvpZone")) then
            return true
        else
            return false
        end
    end
end

function drawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning)
	if not text or type(text) ~= "string" then return false end
	if not left or type(left) ~= "number" then return false end
	if not top or type(top) ~= "number" then return false end
	if not bottom or type(bottom) ~= "number" then return false end 
	if not color then color = tocolor(255, 255, 255, 255) end 
	if not scale then scale = 1 end 
	if not font then font = "default-bold" end
	if not alignX then alignX = "left" end
	if not alignY then alignY = "center" end
	if not clip then clip = false end
	if not wordBreak then wordBreak = false end
	if not postGUI then postGUI = false end
	if not colorCoded then colorCoded = true end
	if not subPixelPositioning then subPixelPositioning = false end
	 dxDrawText(text, left * csX, top * csY, right * csX, bottom * csY, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning)
	 
end

function dxText( text, x, y, h, w, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded,
                            subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	local outline = 1.5
	drawText( text:gsub( "#%x%x%x%x%x%x", "" ), (x - outline), (y - outline),(h - outline), (w - outline), tocolor( 0, 0, 0, 225 ), scale, font,
	            alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	drawText( text:gsub( "#%x%x%x%x%x%x", "" ),(x + outline), (y - outline),(h + outline), (w - outline), tocolor( 0, 0, 0, 225 ), scale, font,
	            alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	drawText( text:gsub( "#%x%x%x%x%x%x", "" ),(x - outline), (y + outline),(h - outline), (w + outline), tocolor( 0, 0, 0, 225 ), scale, font,
	            alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	drawText( text:gsub( "#%x%x%x%x%x%x", "" ),(x + outline), (y + outline),(h + outline), (w + outline), tocolor( 0, 0, 0, 225 ), scale, font,
	            alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	drawText( text:gsub( "#%x%x%x%x%x%x", "" ),(x - outline), (y),(h - outline), (w), tocolor( 0, 0, 0, 225 ), scale, font, alignX, alignY,
	            clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	drawText( text:gsub( "#%x%x%x%x%x%x", "" ),(x + outline), (y),(h + outline), (w), tocolor( 0, 0, 0, 225 ), scale, font, alignX, alignY,
	            clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	drawText( text:gsub( "#%x%x%x%x%x%x", "" ),(x), (y - outline),(h), (w - outline), tocolor( 0, 0, 0, 225 ), scale, font, alignX, alignY,
	            clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	drawText( text:gsub( "#%x%x%x%x%x%x", "" ),(x), (y + outline),(h), (w + outline), tocolor( 0, 0, 0, 225 ), scale, font, alignX, alignY,
	            clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY )
	drawText( text,(x), (y),(h), (w), color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation,
	            fRotationCenterX, fRotationCenterY )
end

function drawRectangle(x, y, w, h, color, postGUI)
	if not x or type(x) ~= "number" then return false end
	if not y or type(y) ~="number" then return false end 
	if not w or type(w) ~= "number" then return false end
	if not h or type(h) ~= "number" then return false end 
	if not color then color = tocolor(0, 0, 0, 200) end 
	if not postGUI then postGUI = false end 

	return dxDrawRectangle( x * csX, y * csY, w * csX, h * csY, color, postGUI )
end

function dxLine(x, y, w, h, color, width, postGUI)
	if not x or type(x) ~= "number" then return false end
	if not y or type(y) ~="number" then return false end 
	if not w or type(w) ~= "number" then return false end
	if not h or type(h) ~= "number" then return false end 
	if not width then width = 1 end
	if not color then color = tocolor(255, 255, 255, 175) end 
	if not postGUI then postGUI = false end
	
	 return dxDrawLine(x* csX, y* csY, w* csX, h* csY, color, width, postGUI)
end

function dxRectangle( x, y, w, h, color, postGUI )
	local _width = 1 
	drawRectangle( (x + 1), (y + 1), (w - 1), (h - 1), color, postGUI )
	dxLine( x, y, (x + w), y, tocolor( 9, 130, 253 ), _width, postGUI ) -- Top
	dxLine( x, y, x, (y + h), tocolor( 9, 130, 253 ), _width, postGUI ) -- Left
	dxLine( x, (y + h), (x + w), (y + h), tocolor( 9, 130, 253), _width, postGUI ) -- Bottom
	dxLine( (x + w), y, (x + w), (y + h), tocolor( 9, 130, 253 ), _width, postGUI ) -- Right
end

addEventHandler("onClientPlayerWasted", root, 
	function(killer, weapon, bodypart)
		if isElement(killer) and getElementType(killer) == "player" and killer == getLocalPlayer() then
			if isPlayerInsideArea(killer) and isPlayerInsideArea(source) then
				if getElementDimension(killer) == 2 and getElementDimension(source) == 2 then
					if weapon == 34 and bodypart == 9 then
						soundvolume = playSound("data/headshot.mp3") 
						setSoundVolume(soundvolume,0.5)
					end
				end
			end
		end
	end
)
fileDelete( "m.lua")