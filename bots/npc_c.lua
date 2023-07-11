
local amarker = createMarker ( 216.60623, 1877.10681, 13.14062, "cylinder", 3, 255, 255, 0, 0 )
local hmarker = createMarker ( -2850.87134, -1420.88977, 135.36185, "cylinder", 3, 255, 255, 0, 0 )

local font = dxCreateFont('ZMB.ttf', 16, false, 'proof') or 'default'
local bfont = dxCreateFont('ZMB.ttf', 18, false, 'proof') or 'default'

local x,y = guiGetScreenSize()  -- Get players resolution.
local playerName = getPlayerName ( localPlayer )  -- Get players name.
local Text = "You have to enter the correct password to get inside, \nor my friends will attack you!"
local mkeystate = false
local apanelState = false
local hpanelState = false
local HelpMessages = {
	{"I’m tall when I’m young, and I’m short when I’m old. What am I?"},
	{"What is full of holes but still holds water?"},
	{"What goes up but never comes down?"}
}
local AnswerMessages = {
	{"Candle"},
	{"Sponge"},
	{"Age"}
}

local randomnum



addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function()
		--setElementData(answerPed, "answerNPC", true)
		--setElementData(helperPed, "helperNPC", true)
		--setElementFrozen(helperPed, true)
		--setElementFrozen(answerPed, true)
		randomnum = math.random(1,#HelpMessages)
		--triggerServerEvent("addPlayerToGuardTeam", resourceRoot, answerPed)
		setTimer(function()
			triggerServerEvent("addPlayerToGuardTeam", resourceRoot, localPlayer)
		end, 1000, 1)
		--setTeam(answerPed, getTeamFromName("GUARDS"))
		--setTeam(answerPed, getTeamFromName("GUARDS"))
	end
)

--[[local rotationtimer = {}
local servertimer = {}
local endattacktimer

function targetThePlayer (target, ped)
	local random = math.random(1,2)
	if getElementData(ped,"attacking") == true then
		if(random == 1) then
			setPedControlState(ped, "fire", true)
			setPedControlState(ped, "forwards", false)
			rotationtimer[ped] = setTimer(function()
				if((not isPedDead(ped)) and (getElementData(ped,"attacking") == true)) then
					local x, y, z = getElementPosition(target)
					local px, py, pz = getElementPosition(ped)
					setPedAimTarget ( ped, x, y, z )
					setPedLookAt ( ped, x, y, z, 0, 0, target)
					setPedRotation(ped, (math.atan2(y - py, x - px) * 180 / math.pi)-90)
				else
					stopAttacking(target, ped)
					triggerServerEvent("stopPedAimTargetSRV", resourceRoot, target, ped)
				end
			end, 500, 0)
			servertimer[ped] = setTimer(function()
				if(isTimer(rotationtimer[ped])) then
					killTimer(rotationtimer[ped])
				end
				if(isTimer(servertimer[ped])) then
					killTimer(servertimer[ped])
				end
				triggerServerEvent("setPedAimTargetSRV", resourceRoot, target, ped)
			end, 5000, 1)
			
		else
			rotationtimer[ped] = setTimer(function()
				if((not isPedDead(ped)) and (getElementData(ped,"attacking") == true)) then
					local x, y, z = getElementPosition(target)
					local px, py, pz = getElementPosition(ped)
					setPedAimTarget ( ped, x, y, z )
					setPedLookAt ( ped, x, y, z, 0, 0, target)
					setPedRotation(ped, (math.atan2(y - py, x - px) * 180 / math.pi)-90)
				else
					stopAttacking(target, ped)
					triggerServerEvent("stopPedAimTargetSRV", resourceRoot, target, ped)
				end
			end, 500, 0)
			setPedControlState(ped, "fire", false)
			setPedControlState(ped, "forwards", true)
			servertimer[ped] = setTimer(function()
				if(isTimer(rotationtimer[ped])) then
					killTimer(rotationtimer[ped])
				end
				if(isTimer(servertimer[ped])) then
					killTimer(servertimer[ped])
				end
				triggerServerEvent("setPedAimTargetSRV", resourceRoot, target, ped)
			end, 3000, 1)
		end
	end
end

function stopAttacking(theTarget, ped)
	--outputChatBox("ASD")
	if(isTimer(rotationtimer[ped])) then
		killTimer(rotationtimer[ped])
	end
	if(isTimer(servertimer[ped])) then
		killTimer(servertimer[ped])
	end
	setPedControlState(ped, "fire", false)
	setPedControlState(ped, "forwards", false)
end

addEvent( "stopTargetThePlayer", true )
addEventHandler( "stopTargetThePlayer", root, stopAttacking)

addEvent( "targetThePlayer", true )
addEventHandler( "targetThePlayer", root, targetThePlayer )]]



addEventHandler( "onClientKey", root, function(button,press) 
    
    --[[if button == "m" and press == true then
        mkeystate = not mkeystate
    end
	showCursor ( mkeystate )]]
	if button == "backspace" and press == true then
		if hpanelState == true then
			hpanelState = false
		end
    end
end )

local gbutton -- = guiCreateButton( 0.7, 0.1, 0.2, 0.1, "OK", true )
local editBox -- = guiCreateEdit( 0.3, 0.1, 0.4, 0.1, "", true )

--[[function PedClick(button, state, absX, absY, wx, wy, wz, element)
	if element and getElementData(element,"answerNPC") then
		if state == "down" and button == "left" then
			local x, y, z = getElementPosition(getLocalPlayer())
			if getDistanceBetweenPoints3D(x, y, z, wx, wy, wz) <= 5 then 
				apanelState = not apanelState
				if(apanelState == true) then
					gbutton = guiCreateButton( 0.6, 0.6, 0.1, 0.025, "OK", true )
					editBox = guiCreateEdit( 0.3, 0.6, 0.3, 0.025, "", true )
					guiEditSetMaxLength ( editBox, 64 )
					addEventHandler ( "onClientGUIClick", gbutton, outputEditBox )
				else
					if(isElement(gbutton)) then
						removeEventHandler( "onClientGUIClick", gbutton, outputEditBox )
						destroyElement(gbutton)
					end
					if(isElement(editBox)) then
						destroyElement(editBox)
					end
				end
			else
				outputChatBox("#0576B5You're to far away!", 255, 255, 255, true)
			end
		end
	end
	if element and getElementData(element,"helperNPC") then
		if state == "down" and button == "left" then
			local x, y, z = getElementPosition(getLocalPlayer())
			if getDistanceBetweenPoints3D(x, y, z, wx, wy, wz) <= 5 then 
				hpanelState = not hpanelState
			else
				outputChatBox("#0576B5You're to far away!", 255, 255, 255, true)
			end
		end
	end
end]]
--addEventHandler("onClientClick", getRootElement(), PedClick, true)

function MarkerHit ( hitPlayer, matchingDimension )
	if source == amarker then
		apanelState = true
		showCursor(true)
		if(apanelState == true) then
					gbutton = guiCreateButton( 0.6, 0.6, 0.1, 0.025, "OK", true )
					editBox = guiCreateEdit( 0.3, 0.6, 0.3, 0.025, "", true )
					guiEditSetMaxLength ( editBox, 64 )
					outputChatBox(HelpMessages[randomnum][1], 255, 255, 0)
					addEventHandler ( "onClientGUIClick", gbutton, outputEditBox )
				else
					if(isElement(gbutton)) then
						removeEventHandler( "onClientGUIClick", gbutton, outputEditBox )
						destroyElement(gbutton)
					end
					if(isElement(editBox)) then
						destroyElement(editBox)
					end
		end
	end
	if source == hmarker then
		hpanelState = true
	end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

function drawStuff()
	local jX, jY, jZ = getElementPosition(getLocalPlayer())
	--local bX, bY, bZ = getElementPosition(answerPed)
	--local hX, hY, hZ = getElementPosition(helperPed)
	--[[if (getDistanceBetweenPoints3D(jX, jY, jZ, hX, hY, hZ) > 5 ) then 
		hpanelState = false 
		return 
	elseif (getDistanceBetweenPoints3D(jX, jY, jZ, bX, bY, bZ) > 5 ) then 
		apanelState = false
		if(isElement(gbutton)) then
			removeEventHandler( "onClientGUIClick", gbutton, outputEditBox )
			destroyElement(gbutton)
		end
		if(isElement(editBox)) then
			destroyElement(editBox)
		end
		return 
	end]]
	if apanelState --[[and getDistanceBetweenPoints3D(jX, jY, jZ, bX, bY, bZ) < 5]]  then
			dxDrawImage (x/3.8, y/3.8, x/2.02, y/2, "images/bg.png", 0, 0, 0, tocolor ( 255, 255, 255, 255 ) ) 
			dxDrawText ( "Hello traveler!" --[[.. playerName]], x/3.8, y/3.6, x/3.8+x/2.02, y/2, tocolor ( 150, 0, 0, 255 ), 1, bfont, "center" )
			dxDrawLine ( x/3.6, y/3.25, x/1.35, y/3.25, tocolor ( 150, 0, 0, 255 ), 2 ) 
			dxDrawLine ( x/3.59, y/3.225, x/1.348, y/3.225, tocolor ( 0, 0, 0, 255 ), 2 ) 
			dxDrawText ( Text, x/3.6, y/3, x, y, tocolor ( 150, 0, 0, 255 ), 1, font )
	else
			apanelState = false
			if(isElement(gbutton)) then
				removeEventHandler( "onClientGUIClick", gbutton, outputEditBox )
				destroyElement(gbutton)
			end
			if(isElement(editBox)) then
				destroyElement(editBox)
			end
			--showCursor(false)
	end
	if hpanelState --[[and getDistanceBetweenPoints3D(jX, jY, jZ, hX, hY, hZ) < 5]]  then
		dxDrawImage ( x/3.8, y/3.8, x/2.02, y/2, "images/bg.png", 0, 0, 0, tocolor ( 255, 255, 255, 255 ) ) 
		dxDrawText ( "Hello traveler!" --[[.. playerName]], x/3.8, y/3.6, x/3.8+x/2.02, y/2, tocolor ( 150, 0, 0, 255 ), 1, bfont, "center" )
		dxDrawLine ( x/3.6, y/3.25, x/1.35, y/3.25, tocolor ( 150, 0, 0, 255 ), 2 ) 
		dxDrawLine ( x/3.59, y/3.225, x/1.348, y/3.225, tocolor ( 0, 0, 0, 255 ), 2 ) 
		dxDrawText ( "I give you some hint, you have to answer this question somewhere: \n" .. HelpMessages[randomnum][1], x/3.6, y/3, x, y, tocolor ( 150, 0, 0, 255 ), 1, font )
	else
		hpanelState = false 
		--showCursor(false)
	end	
end

local obj = createObject(3037, 214.10000610352, 1875.5999755859, 13.89999961853, 0, 0, 90)

addEventHandler("onClientRender", root, drawStuff)

function outputEditBox ()
        local text = guiGetText ( editBox )
        if text == AnswerMessages[randomnum][1] then
			--outputChatBox("Correct")
			moveObject ( obj, 5000, 214.10000610352, 1875.5999755859, 9.89999961853 )
			playSound("door.mp3")
			triggerServerEvent("addPlayerToGuardTeam", resourceRoot, localPlayer)
			setTimer(function()
				moveObject ( obj, 5000, 214.10000610352, 1875.5999755859, 13.89999961853 )
			end, 5*60000, 1)
			showCursor(false)
			apanelState = false
			if(isElement(gbutton)) then
				removeEventHandler( "onClientGUIClick", gbutton, outputEditBox )
				destroyElement(gbutton)
			end
			if(isElement(editBox)) then
				destroyElement(editBox)
			end
		else
			--triggerServerEvent("everyoneAttackThePlayer", resourceRoot, localPlayer)
			setTimer(function()
				--triggerServerEvent("everyoneStopAttackThePlayer", resourceRoot, localPlayer)
				triggerServerEvent("addPlayerToGuardTeam", resourceRoot, localPlayer)
			end, 60000, 1)
			showCursor(false)
			apanelState = false
			triggerServerEvent("removePlayerFromGuardTeam", resourceRoot, localPlayer)
			if(isElement(gbutton)) then
				removeEventHandler( "onClientGUIClick", gbutton, outputEditBox )
				destroyElement(gbutton)
			end
			if(isElement(editBox)) then
				destroyElement(editBox)
			end
		end
end

function shootAttacker ( attacker )
	if getElementData(source, "bandit") == true and getElementData(source, "attacking") == false then
	--outputChatBox("ASD")
		--triggerServerEvent("everyoneAttackThePlayer", resourceRoot, attacker)
		if attacker == localPlayer or then
			triggerServerEvent("removePlayerFromGuardTeam", resourceRoot, localPlayer)
			setTimer(function()
			--triggerServerEvent("everyoneStopAttackThePlayer", resourceRoot, attacker)
			triggerServerEvent("addPlayerToGuardTeam", resourceRoot, attacker)
		end, 60000, 1)
		end
	end
end
addEventHandler ( "onClientPedDamage", getRootElement(), shootAttacker )