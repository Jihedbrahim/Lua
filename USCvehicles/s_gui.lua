vehicleBlip = {}
function updateVehicleInfo()
	if not isElement(source) then return false end
	local vehTables = getPlayerVehicles(source)
	local posX, posY, posZ = vehTables["posX"], vehTables["posY"], vehTables["posZ"]
	local id = vehTables["id"]
	triggerClientEvent(source,"updateVehicleInfo",source,vehTables,vehTables["vehicleid"],vehTables["health"], posX, posY, posZ, id)
end
addEvent("refreshGridListInfo", true)
addEventHandler("refreshGridListInfo", root, updateVehicleInfo)

addEvent("SetVehicleVisible", true)

addEventHandler("SetVehicleVisible", root, 
	function(id, visible )
		showVehicle(id, visible)
	end
	)

function showVehicle ( id, stat, player)
	if stat then 
		if ( not isElement ( vehicles[id] ) ) then
			local query = dbQuery(db, "SELECT * FROM vehicles WHERE id=? LIMIT 1", (id) )
	    	local q = dbPoll(query, -1)
			if ( q and type ( q ) == 'table' and #q > 0 ) then
				local d = q[1]
				local health =  tonumber( d["health"] )
				local owner, vehID = tostring ( d["owner"] ), tonumber ( d["vehicleid"] )
				local color, upgrades = d["color"], d["upgrades"]
				local color = fromJSON ( color )
				local color = split ( color, ', ' )
				local r, g, b = tonumber ( color[1] ), tonumber ( color[2] ), tonumber ( color[3] )
				local upgrades = fromJSON ( upgrades )
				local x, y, z = d["posX"], d["posY"], d["posZ"]
				local rot =  ( d["rotation"])
				local locked = tonumber ( d["locked"])
				local rot = fromJSON ( rot )
				local rot = split ( rot, ', ' )
				local rx, ry, rz = tonumber ( rot[1] ), tonumber ( rot[2] ), tonumber ( rot[3] )
				if locked == 1 then locked = true else locked = false end					
				vehicles[id] = createVehicle ( vehID, x, y, z, rx, ry, rz )
				iprint(getElementHealth(vehicles[id]))
				setElementData ( vehicles[id], "Owner", tostring ( owner ) )
				setElementHealth ( vehicles[id],  ( health ) )
				setVehicleLocked(vehicles[id], locked)
				setVehicleColor ( vehicles[id], r, g, b )
				for i, v in ipairs ( upgrades ) do 
					addVehicleUpgrade ( vehicles[id], tonumber ( v ) ) 
				end
				dbExec(db, "UPDATE vehicles SET spawned=? WHERE id=?", "1", id )
			end
		end
	else
		if ( isElement ( vehicles[id] ) ) then
			local x, y, z = getElementPosition(vehicles[id])
			local rot = toJSON ( createToString ( getElementRotation ( vehicles[id] ) ) )
			local health = tostring ( getElementHealth ( vehicles[id] ) )
			local owner = getElementData(vehicles[id], "Owner")
			local model = getElementModel ( vehicles[id] )
			local color = toJSON ( createToString ( getVehicleColor ( vehicles[id], true ) ) )
			local upgrades = toJSON ( getVehicleUpgrades ( vehicles[id] ) )
			dbExec(db, "UPDATE vehicles SET posX=?, posY=?, posZ=?, rotation=?, health=?, owner=?, locked=?, color=?, upgrades=? WHERE id=?", x, y, z, rot, health, owner, isVehicleLocked(vehicles[id]),color, upgrades, id )
			if isElement(vehicleBlip[id]) then
			destroyElement(vehicleBlip[id])
			vehicleBlip[id] = nil
			end
			destroyElement ( vehicles[id] )
			vehicles[id] = nil
			dbExec(db, "UPDATE vehicles SET spawned=? WHERE id=?", "0", id )
			iprint(getPlayerName ( source ).." hid their "..getVehicleNameFromModel ( model ) )
		end
	end
end

		

recoverPosition = {--x, y,z, rot
	["Automobile"] = 
	{
		{-2571.8447, 631.990, 13.902,89.92}, -- SF
	
		{1690.8834, -1060.419, 23.356,0.571},-- LS
		{1741.929, 1996.7789, 10.2493,267.970},--LV
	},
	["Bike"] = 
	{
		{-2571.8447, 631.990, 13.902,89.92}, -- SF
	
		{1690.8834, -1060.419, 23.356,0.571},-- LS
		{1741.929, 1996.7789, 10.2493,267.970},--LV
	},
	["Plane"] = 
	{
			{ 2021.44, -2619.91, 14.54, 47 },
			{ -1687.54, -254.3, 15.14, 320},
			{1556.43, 1320.08, 11.87, 83},
		},
}

addEventHandler("onVehicleEnter", root, 
function (thePlayer, seat, jacked) 
	iprint(getVehicleType(source))
end)





local maxDist = 200000; 
local closestRespawnLoc = 99999999; 
local closestRespawn;
	function closestLocRecover(element)
		if isElement ( element ) and getElementType(element) == "vehicle" then
			local px,py,_ = getElementPosition(element)
			local vehType = getVehicleType(element)
			iprint(vehType)
			local dist
			for i, v in ipairs( recoverPosition[vehType] ) do
				local dist = getDistanceBetweenPoints2D( px,py,v[1],v[2]);
				if dist < maxDist and dist < closestRespawnLoc then         
					closestRespawnLoc = dist;         
					closestRespawn = v;     
				end
			end
			if closestRespawn then
				return closestRespawn[1], closestRespawn[2], closestRespawn[3], closestRespawn[4]
			end
		end
	end  

addEvent("onPlayerVehicleRecover", true)
addEventHandler("onPlayerVehicleRecover", root, 
	function ( id )
		local x, y, z, rot = closestLocRecover(vehicles[id])
		setElementPosition(vehicles[id], x, y, z)
		setElementRotation(vehicles[id], 0, 0, rot)
		setElementDimension(vehicles[id], 0)
		setElementInterior(vehicles[id], 0)
	end
)

addEvent("onPlayerLockVehicle", true)
addEventHandler("onPlayerLockVehicle", root, 
	function ( id )
		if isVehicleLocked(vehicles[id]) then
			setVehicleLocked( vehicles[id], false )
			outputChatBox("You have unlocked your vehicle!", source, 0, 255, 0)
			dbExec(db, "UPDATE vehicles SET locked=? WHERE id=?", "0", id )
			
		else
			setVehicleLocked(vehicles[id], true)
			outputChatBox("You have locked your vehicle!", source, 0, 255, 0 )
			dbExec(db, "UPDATE vehicles SET locked=? WHERE id=?", "1", id )
		end
	end
	)





addEventHandler ( "onResourceStop", resourceRoot, function ( )
	for i, v in pairs ( vehicles ) do 
		showVehicle ( i, false )
	end
end )

addEvent("onPlayerVehicleMark", true)
addEventHandler("onPlayerVehicleMark", root, 
	function(id)
		if isElement(vehicleBlip[id]) then
			destroyElement(vehicleBlip[id])
			vehicleBlip[id] = nil
		else
			if isElement ( vehicles[id] ) then
				vehicleBlip[id] = createBlipAttachedTo ( vehicles[id], 51, 2, 255, 255, 255, 255, 0, 1500, source )
				setElementData(vehicleBlip[id], "blipName", "My "..getVehicleName( vehicles[id]))
			else
				outputChatBox("You have to spawn the vehicle first", source, 255, 0 ,0 )
			end
		end
	end
	)

function createToString ( x, y, z ) 
	return table.concat ( { x, y, z }, ", " )
end