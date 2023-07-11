--[[

this script made by BenFireShade


so for the notes
- How to add more peds in proper way

as you like there is a table called peds = {} so you have to add another line and follow the same what i did with it

first arg is ID=287 ( here you have to put ID model, so for military ID is 287)

x, y and z are the position of the ped that will be spawned in

rot is the ped rotation 


dim is the dimension that you are going to put the ped there ( you can just leave it if the dim is 0)

the same case for int 


guardBot : if it set as false, the ped is going to be frozen, otherwise true ( so it can moves normally )

startPos : is the location of the ped that is going to start walking from ( you have copy and paste from X, Y and Z positions)

endPos : like what you thought about it, its where the walk stop position




]]
peds = {

{ID=287, x=98.363, y=1916.343, z=18.215,rot=18.2143, dim=0, int=0, guardBot= true, startPos={98.363, 1916.343, 18.215}, endPos={98.252, 1923.561, 18.194}},

}

tp = {}

startNumber = 0

addEventHandler("onResourceStart", resourceRoot,
	function()
		createBots()
	end
	)

function findRotation(x1,y1,x2,y2)
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end
	return t
end

function setPedDirection(npc, target)
	if isElement(npc) and isElement(target) then
		local px, py = getElementPosition(target)
		local zx, zy = getElementPosition(npc)
		local t = findRotation(zx, zy, px, py )
		setElementRotation(npc, 0, 0, t)
	end
end

botTable = {}
function createBots()
	for i, v in ipairs ( peds ) do
		local ID, x, y, z, rot, dim, int = v.ID, v.x, v.y, v.z, v.rot, v.dim, v.int
		index = i
		local sX, sY, sZ, eX, eY, eZ = v.startPos[1], v.startPos[2], v.startPos[3], v.endPos[1], v.endPos[2], v.endPos[3]
		tp[i] = createPed(ID, x, y, z, rot)
		if not dim then
			setElementDimension( tp[i], 0)
		else
			setElementDimension( tp[i], dim)
		end
		if not int then
			setElementInterior( tp[i], 0)
		else
			setElementInterior( tp[i], int)
		end

		exports.npc_hlc:enableHLCForNPC(tp[i])
		pedAnimation()
		
		setElementData(tp[index], "npc_hlc", true)
		setElementData(tp[index], "protectedPed", true)
		
		if v.guardBot == false then
			setElementFrozen( tp[i], true)
		end
		giveWeapon( tp[index], 31, 999999, true)
			setTimer(function()
				if isElement(tp[index]) then
					giveWeapon( tp[index], 31, 9999999, true)
				end
			end, 10000, 0 )
		end
	end
walks = {
	{"walk"}, {"run"}, {"sprint"}, {"sprintfast"} -- here i added the walking speed so you can change it in the following line that i will mention it down below
}

function pedAnimation()
	for i, v in ipairs ( peds ) do 
		if isElement(tp[i]) and not isPedDead( tp[i] ) then 
			local sX, sY, sZ, eX, eY, eZ = v.startPos[1], v.startPos[2], v.startPos[3], v.endPos[1], v.endPos[2], v.endPos[3]
			exports.npc_hlc:addNPCTask(tp[i], {"walkAlongLine", sX, sY, sZ, eX, eY, eZ, 2, 0})
			local ran = math.random(#walks)
			exports.npc_hlc:setNPCWalkSpeed (tp[i], "walk") -- here you can change walking speed, replace "walk" to something else from this list {"walk"}, {"run"}, {"sprint"}, {"sprintfast"}
			
		end
	end
end

addEvent("npc_hlc:onNPCTaskDone", true)
addEventHandler("npc_hlc:onNPCTaskDone", root,
	function(task)
		for i, v in ipairs ( peds ) do 
			if isElement(tp[i]) and not isPedDead( tp[i] ) then
				if tp[i] == source then 
					local sX, sY, sZ, eX, eY, eZ = v.startPos[1], v.startPos[2], v.startPos[3], v.endPos[1], v.endPos[2], v.endPos[3]
					if task[1] == "walkAlongLine" and task[2] == sX then
						startNumber = 1
						--iprint(task[1])
						
						exports.npc_hlc:addNPCTask(tp[i], {"walkAlongLine", eX, eY, eZ, sX, sY, sZ,  2, 0})
						local ran = math.random(#walks)
						exports.npc_hlc:setNPCWalkSpeed (tp[i], "walk")
						--iprint("start2")
					elseif task[1] == "walkAlongLine" and task[2] == eX then 
						pedAnimation()
					elseif task[1] == "shootElement" then 
						exports.npc_hlc:clearNPCTasks (tp[i])
						pedAnimation()
					end
				end
			end
		end
	end
)




addEvent("onPlayerHitSafeZone", true)
addEventHandler("onPlayerHitSafeZone", root,
	function()
		theSource = source
		if getElementType(source) == "ped"  and getElementData(source, "zombie") and not getElementData(source, "protectedPed")  then
			for _, v in ipairs ( getElementsByType( "ped" ), resourceRoot, true ) do
				if getElementData(v, "npc_hlc") then
					exports.npc_hlc:addNPCTask(v, {"shootElement", source})
					exports.npc_hlc:setNPCWeaponAccuracy(v,1)
					resetSettings(v, source)
					setPedDirection(v, source)
				end
			end
		end
	end
	)

function createNPCBot(ID, x, y, z, rot)
	index = index + 1 
	tp[index] = createPed(ID, x, y, z,rot )
	setElementData(tp[index], "npc_hlc", true)
	exports.npc_hlc:enableHLCForNPC(tp[index])
	if isElement(tp[index]) then
		giveWeapon( tp[index], 31, 9999999, true)
	end
end

function resetSettings(npc, target)
	if isElement(npc) and isElement(target) then
		local source_ = source 
		setTimer( function()
			if isElement(npc) and isElement(source_) then 
				exports.npc_hlc:addNPCTask(npc, {"shootElement", source_})
				exports.npc_hlc:setNPCWeaponAccuracy(npc,1)
				setPedDirection(npc, target)
			end
		end, 10000, 0)
	end
end

addEvent("onNPCGetDamage", true)
addEventHandler("onNPCGetDamage", root,
	function(attacker, weapon, bodypart, loss)
			setElementHealth(source, 100)
			setElementHealth(source, 100)
		if getElementType(attacker) == "ped" or getElementType(attacker) == "player" then
			setElementHealth(source, 100)
			setElementHealth(source, 100)
			if not getElementData(attacker, "npc_hlc") or not getElementData(source, "npc_hlc") and not getElementData(source, "protectedPed") then
				exports.npc_hlc:addNPCTask( source, {"shootElement", attacker})
			end
		end
	end
)

addEventHandler("onPlayerWasted", root, 
	function (totalAmmo, killer, killerWeapon, bodypart, stealth) 
		if isElement(source) and isElement(killer) and getElementType(source) == "player" and getElementData(killer, "npc_hlc") then
			exports.npc_hlc:clearNPCTasks (killer)
			pedAnimation()
		end
	end
)

addEventHandler( "onPedWasted", root, 
	function (totalAmmo, killer, killerWeapon, bodypart, stealth) 
		if isElement(source) and getElementData(source, "npc_hlc")  then
			Source  = source
			x, y, z = getElementPosition(Source)
			 _,_, rot = getElementRotation(Source)
			setTimer(function()
				createNPCBot(287, x, y, z, rot)
				destroyElement(Source)
			end, 5000, 1)
		end
	end
)



