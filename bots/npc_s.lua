local loadedNpcs = {}
local npcp = {
	--{skin, name, x, y, z, rx, ry, ry, dim, int} 
	{287, "Attacker1", 222.02971, 1901.08447, 17.64806, 0, 0, 90, 0, 0, {"", ""}},
	{287, "Attacker2", 218.97380, 1877.73926, 17.64062, 0, 0, 90, 0, 0, {"", ""}},
	{287, "Attacker3", 208.89284, 1876.56873, 17.64062, 0, 0, 270, 0, 0, {"", ""}},
	{287, "Attacker4", 205.33968, 1899.24438, 17.64062, 0, 0, 270, 0, 0, {"", ""}},
	{287, "Attacker5", 215.45078, 1901.98047, 17.64062, 0, 0, 0, 0, 0, {"", ""}},
	{287, "Attacker6", 210.85074, 1902.15796, 17.64062, 0, 0, 0, 0, 0, {"", ""}},
}

local pedmarker = {}
local newTeam = createTeam("GUARDS")
local answerPed
local helperPed

addEventHandler("onResourceStart", resourceRoot, function()
	setTimer(function()
	db = 1
	veg = 3
	answerPed = exports.slothbot:spawnBot(216.60623, 1877.10681, 13.14062, 0, 287, 0, 0, newTeam, 31, "waiting", "chasing")
	setElementData(answerPed, "protectedPed", true)
	helperPed = createPed(1, -2850.87134, -1420.88977, 135.36185)
	exports.slothbot:setBotAttackEnabled(answerPed, false)
	setElementData(answerPed, "slothbot", true)
	setElementData (answerPed, "stasisstatus", "waiting" )
	exports.slothbot:setBotGuard(answerPed, 216.60623, 1877.10681, 13.14062, true)
		for i, id in pairs(npcp) do
				loadedNpcs[db] = exports.slothbot:spawnBot(id[3], id[4], id[5], id[8], id[1], id[10], id[9], newTeam, 31, "guarding", "chasing") --createPed(id[1], id[3], id[4], id[5])
				if isElement(loadedNpcs[db]) then
					setElementSyncer(loadedNpcs[db], true)
					exports.slothbot:setBotGuard(loadedNpcs[db], id[3], id[4], id[5], true)
					--setElementDimension(loadedNpcs[db], id[9])
					--setElementInterior(loadedNpcs[db], id[10])						
					--setElementRotation(loadedNpcs[db], id[6], id[7], id[8])		
					setElementData(loadedNpcs[db], "ped:name", id[2])						
					setElementData(loadedNpcs[db], "name:tags", "NPC")
					setElementData(loadedNpcs[db], "ped:anims", id[11])
					setElementData(loadedNpcs[db], "Npc:ID", db)
					setElementData(loadedNpcs[db], "bandit", true)
					setElementData(loadedNpcs[db], "protectedPed", true)
					setElementData(loadedNpcs[db], "attacking", false)
					setElementData(loadedNpcs[db], "slothbot", true)
					setElementData (loadedNpcs[db], "stasisstatus", "guarding" )
					--pedmarker[db] = createMarker ( id[3], id[4], id[5], "cylinder", 7, 255, 255, 0, 0 )
					--addEventHandler("onMarkerHit", pedmarker[db], handlePlayerMarker)
					db = db+1
					
				end
		end
		--setPlayerTeam(answerPed, newTeam)
		setElementFrozen(helperPed, true)
		setElementFrozen(answerPed, true)
		--toggleControl ( answerPed, "fire", false )
		--toggleControl ( answerPed, "forwards", false )
		--toggleControl ( answerPed, "jump", false )
		--toggleControl ( answerPed, "aim_weapon", false )
		--setPedAimTargetSRV(loadedNpcs[1], playerSource)
		addEventHandler("onPedDamage", answerPed, cancelPedDamage)
		addEventHandler("onPedDamage", helperPed, cancelPedDamage)
	end, 1000, 1)
end)

function cancelPedDamage()
	setElementHealth(answerPed, 100)
	setElementHealth(helperPed, 100)
end

function onBotFollow ()
	--setBotWait (source)
end
addEventHandler ( "onBotFollow", getRootElement(), onBotFollow )

function player_Spawn ( posX, posY, posZ, spawnRotation, theTeam, theSkin, theInterior, theDimension )
	setPlayerTeam(source, newTeam)
end
addEventHandler ( "onPlayerSpawn", getRootElement(), player_Spawn )

function handlePlayerMarker(hitElement)
	for i=1,#npcp do
		if source == pedmarker[i] then
			--outputChatBox("FASZ::: "..i)
			if(getElementData(hitElement, "zombie") == true) and not getElementData(hitElement, "protectedPed") then
				setPedAimTargetSRV(hitElement, loadedNpcs[i])
				--outputChatBox("FASZ2: " .. i)
			end
		end
	end
end

function targetMe ( pS )
	for i=1,#npcp do
		setPedAimTargetSRV(pS, loadedNpcs[i])
	end
end

function stopTargetMe ( pS )
	for i=1,#npcp do
		stopTargetMeSRV(pS, loadedNpcs[i])
	end
end

function setPedAimTargetSRV(theTarget, ped)
	--setElementData(ped, "attacking", true)
	triggerClientEvent ( theTarget, "targetThePlayer", theTarget, theTarget, ped)
end
addEvent("setPedAimTargetSRV", true)
addEventHandler( "setPedAimTargetSRV", getRootElement(), setPedAimTargetSRV )

function addPlayerToGuardTeam(assd)
	setPlayerTeam(assd, newTeam)
end
addEvent("addPlayerToGuardTeam", true)
addEventHandler( "addPlayerToGuardTeam", getRootElement(), addPlayerToGuardTeam )

function removePlayerFromGuardTeam(assd)
	setPlayerTeam(assd, nil)
end
addEvent("removePlayerFromGuardTeam", true)
addEventHandler( "removePlayerFromGuardTeam", getRootElement(), removePlayerFromGuardTeam )

function stopTargetMeSRV(theTarget, ped)
	setElementData(ped, "attacking", false)
	triggerClientEvent ( theTarget, "stopTargetThePlayer", theTarget, theTarget, ped)
end

addEvent("stopPedAimTargetSRV", true)
addEventHandler( "stopPedAimTargetSRV", getRootElement(), stopTargetMeSRV )

--addCommandHandler ( "targetme", targetMe )

--addCommandHandler ( "stopattack", stopTargetMe )

addEvent("everyoneAttackThePlayer", true)
addEventHandler( "everyoneAttackThePlayer", getRootElement(), targetMe)

addEvent("everyoneStopAttackThePlayer", true)
addEventHandler( "everyoneStopAttackThePlayer", getRootElement(), stopTargetMe)

function displayLoadedRes ( res )
	if(res == getThisResource ()) then
	end
end
addEventHandler ( "onResourceStart", getRootElement(), displayLoadedRes)

addEventHandler("onResourceStart", root,
	function()
		for i, v in ipairs ( getElementsByType( "ped" ) )
			if getElementData(v, "protectedPed") or getElementData(v, "slothbot") or getElementData(v, "npc_hlc") then
				setElementData(v, "BotTeam", "GUARDS")
			end
		end
	end
)