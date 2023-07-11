

vehShop = {
		{vehShop="Downtown SF", blipID=55, type="Sport", x=-1660.701, y=1213.952, z=7.25, VehPos={-1657.79, 1209.51, 20.78}, viewVeh={-1659.43, 1217.59, 27.85, -1659.33, 1216.84, 27.19}},--
		{vehShop="Wang Shop", blipID=55, type="Sport", x=-1958.71, y=281.65, z=35.468,VehPos={-1917.324, 282.28, 40.56}, viewVeh={-1917, 267.63, 46.626, -1917.02, 268.56, 46.26}},

		{vehShop="Garcia SF", blipID=54, type="Bike", x=-2236.718, y=113.303, z=35.320, VehPos={-2221.137, 113.488, 35.353}, viewVeh={-2229.966, 111.751, 40.4264, -2229.0959, 111.881, 39.952}},

		{vehShop="Airport SF", blipID=5, type="Plane", x=-1455.31, y=-570.771, z=14.148, VehPos={-1623.498, -632.98, 15.241}, viewVeh={-1603.34, -635.088, 24.021, -1604.20, -634.88, 23.547}},


		{vehShop="Angel Pine", blipID=11, type="Heavy", x=-1957.6295166016, y=-2442.2673339844, z=30.625, VehPos={-1931.325, -2448.776, 31.423}, viewVeh={-1943.98, -2447.867, 37.598, -1943.11, -2448.08, 37.15}},


		{vehShop="Tierra Robada",blipID=9, type="Boat",x=-2188.525, y=2413.056, z=5.15625, VehPos={-2204.947, 2446.597, 0.818}, viewVeh={-2188.502, 2444.930, 9.588, -2189.333, 2445.136, 9.072}},
}

function onPlayerHitMarker(hitmark, matchDim)
	local px, py, pz = getElementPosition(localPlayer)
	local mx, my, mz = getElementPosition(source)
	ID = getElementData(source, "vehicleShopID")
	vehicleType = getElementData( source, "vehicleShopType" )
	--markJob = table[ID]
	--iprint(getElementData( localPlayer, "Job" ).." / "..markJob.job)
	--iprint(getElementType(source))
	iprint(ID)
	iprint(vehicleType)
	if ( hitmark == localPlayer ) and ( pz-1.5 < mz ) and ( pz+1.5 > mz ) then
		if not getPedOccupiedVehicle( localPlayer ) then
				setElementFrozen(localPlayer, true)
				isOpened = true
				ShopType = vehicleType
				IDShop = ID
				showCursor( true )
				ShopLocation = getElementData(source, "ShopLocation")
				PreviewVehicle = createVehicle ( vehicleTable[ShopType][1][1], vehShop[IDShop].VehPos[1], vehShop[IDShop].VehPos[2], vehShop[IDShop].VehPos[3]+1 )
				setVehicleLocked ( PreviewVehicle, true )
				setVehicleDamageProof ( PreviewVehicle, true )
				setCameraMatrix( vehShop[IDShop].viewVeh[1], vehShop[IDShop].viewVeh[2], vehShop[IDShop].viewVeh[3], vehShop[IDShop].viewVeh[4], vehShop[IDShop].viewVeh[5], vehShop[IDShop].viewVeh[6])
		end
	end
end


markerTable = {}
blips = {}
for i, v in ipairs ( vehShop ) do
	local x, y, z = v.x, v.y, v.z
	markerTable[i] = createMarker(x, y, z-1, "cylinder", 2, 255, 255, 0, 0)
	blips[i] = createBlipAttachedTo(markerTable[i], v.blipID)
	setElementData(blips[i], "blipName", v.type)
	setElementData(markerTable[i], "vehicleShopID", i)
	setElementData(markerTable[i], "vehicleShopType", v.type)
	setElementData(markerTable[i], "ShopLocation", v.vehShop)
	addEventHandler("onClientMarkerHit", markerTable[i], onPlayerHitMarker)
end