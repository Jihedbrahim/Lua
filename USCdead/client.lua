lp = getLocalPlayer()
local render = false
local sX, sY = guiGetScreenSize()

local timing
function startDeath()
	local vehicle = getPedOccupiedVehicle( lp )
	local seat = nil
		if ( vehicle ) then
			seat = getPedOccupiedVehicleSeat( lp )
			triggerServerEvent("removePedFromVehicle", lp, seat)
		end
	setElementData(lp,"isDeath", true)
	seconds = 40
	toggleAllControls( false )
	local interior = getElementInterior(localPlayer)
    setCameraInterior(interior)
	setElementCollisionsEnabled( lp, false)
	render = true
	local posX, posY, posZ = getElementPosition(lp)
	setCameraMatrix( posX, posY, posZ+1, posX, posY, posZ+25)
	setTimer(
		function()
			secondCounting()
		end,500, 1
	)
	bloodEffect = setTimer(
		function()
			if ( getElementData(lp, "isDeath") ) then
				local posX, posY, posZ = getElementPosition(lp)
				fxAddBlood(posX, posY, posZ-0.6, 0, 0, 0, 1000, 1.0)
			else
				if isTimer(bloodEffect) then
					killTimer(bloodEffect)
				end
			end
		end, 2500, 0)

end

function secondCounting()
	addEventHandler("onClientRender", root, renderText)
	render = true
	timing = setTimer(
		function()
			seconds = seconds - 1
			if seconds < 0 then
				triggerServerEvent("spawnPlayer", lp)
			end
		end,1000, 0)
end


function stopDeath()
	if render then
		removeEventHandler("onClientRender", root, renderText)
		render = false
	end

	if isTimer(timing) then
		killTimer(timing)
	end
end


addEventHandler("onClientResourceStart", resourceRoot,
	function()
		if ( getElementData(lp,"isDeath") ) then
			startDeath()
		end
	end
)

addEventHandler("onClientPlayerWasted", lp,
	function()
		if not render then
			startDeath()
		end
	end
)
addEvent("cancelEffects", true)
addEventHandler("cancelEffects", root,
		function()
			toggleAllControls(true)
			setElementData(lp,"isDeath", false)
			stopDeath()
		end
	)

addEventHandler( "onClientPlayerDamage", root, 
	function (attacker, damage_causing, bodypart, loss) 
		if ( getElementData(source, "isDeath") ) then
			cancelEvent()
		end
	end
)

addEventHandler( "onClientElementStreamIn", root, 
	function () 
		if ( getElementType(source) == "player")  then
			if ( getElementData(source, "isDeath") ) then
				if ( isElementInWater( source ) ) then
					setTimer(setPedAnimation, 50, 2, source, "ped", "Drown", -1, false, true, false)
                else
                    setTimer(setPedAnimation, 50, 2, source, "ped", "FLOOR_hit_f", -1, false, true, false)
                end
            end
        end
    end
)

addEventHandler("onClientElementDataChange",root,
	function(data)
		if source == lp then 
    		if data == "isDead" then 
        		if getElementData(lp,"isDeath") == true then 
            		startDeath()
        		else 
            		stopDeath()
        		end
    		end
		end
	end
)



function SecondsToClock(seconds)
    local seconds = tonumber(seconds)
    if seconds and seconds <= 0 then
        return "00:00";
    else
	    hours = string.format("%02.f", math.floor(seconds/3600));
	    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
	    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
	    return mins..":"..secs
    end
end


local bColor = tocolor(0,0,0, 225)
local size = 1
local font = dxCreateFont( "p.ttf", 12)

function renderText()
	local seconds  = SecondsToClock(seconds)
	local x, y = sX/2, sY-15
	local text = "PLEASE WAIT FOR EMS \n        WAIT #FF0000"..seconds.."#FFFFFF TO BE REBORN\nPRESS #FF0000[E] #FFFFFFTO REQUEST HELP"
	local width = dxGetTextWidth(text, size, font)
	--dxDrawRectangle(x,y-40,width*0.75,60, tocolor(0, 0,0,150 ), false)

    dxText(text, x+2, y-50, x, y)
end



function dxText(text, x, y, w, h)
	--dxDrawBorderedText(2,text,x, y+2, x, y+2,size,bColor,font,"left", "top", false, false, false, true)
	--dxDrawBorderedText(text,x, y-2, x, y-2,size,bColor,font,"left", "top", false, false, false, true)
	--dxDrawBorderedText(text, x-2, y, x-2, y,size,bColor,font,"left", "top", false, false, false, true)
	--dxDrawBorderedText(text, x+2, y, x+2, y,size,bColor,font, "left", "top", false, false, false, true) -- Jobb
    
    dxDrawBorderedText(0.5,text, x, y, x, y,tocolor(255, 255, 255, 225),size, font, "left", "top", false, false, false, true) -- Jobb
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