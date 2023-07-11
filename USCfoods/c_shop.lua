dataMarkers = {
	{x=376.526, y=-67.611, z=1001.515, dim=3, int=10},

}


	function openShop(hitmark, dim)
		if hitmark == localPlayer and dim then 
			local px, py, pz = getElementPosition(localPlayer)
			mx, my, mz = getElementPosition(source)
			if ( hitmark == localPlayer ) and ( pz-1.5 < mz ) and ( pz+1.5 > mz ) and dim then
				isOpened = true
				showCursor(true)

			end
		end
	end




markerTable = {}
for i, v in ipairs ( dataMarkers ) do
	local x, y, z, dim, int = v.x, v.y, v.z, v.dim, v.int
	markerTable[i] = createMarker(x, y, z-1, "cylinder", 1.2, 255, 255, 0, 150)
	setElementDimension(markerTable[i], dim)
	setElementInterior(markerTable[i], int)
	addEventHandler("onClientMarkerHit", markerTable[i],openShop)
end