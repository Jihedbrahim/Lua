markerTable = {
{x= 181.42840576172, y=-88.426177978516, z=1002.0307006836, dim= 1, int= 18, pedPos={179.5108795166, -92.437881469727, 1002.0234375}},


}


function onPlayerHitMarker(hitmarker, dim)
	--if hitmarker == getLocalPlayer() and dim then
	if getElementData(source, "CJShop") and hitmarker == getLocalPlayer() and dim then
		if getElementModel( localPlayer ) ~= 0 then return outputChatBox("you have to be on CJ skin") end
		isOpened = true
		totalCartPrice = 0
		setCameraMatrix(181.8477935791, -89.73999786377, 1002.9439697266, 181.20561218262, -90.488441467285, 1002.7783203125)
		setElementFrozen(getLocalPlayer(), true)
		playSound( "sounds/open.wav", false)
	end
end


markers = {}
for i, v in ipairs ( markerTable ) do
	local x, y, z, dim, int = v.x, v.y, v.z, v.dim, v.int
	markers[i] = createMarker(x, y, z-1, "cylinder", 1.5, 66, 66, 66, 150)
	setElementDimension(markers[i], dim)
	setElementInterior(markers[i], int)
	setElementData(markers[i], "CJShopID", i)
	setElementData(markers[i], "CJShop", true)

	cj = createPed(0,v.pedPos[1], v.pedPos[2], v.pedPos[3])
	setElementDimension(cj, dim)
	setElementInterior(cj, int)
	addEventHandler("onClientMarkerHit", markers[i], onPlayerHitMarker)
end


addEventHandler("onClientRender", root,
	function()
		if isElement(cj) then
			local rx, ry, rz = getElementRotation(cj)
			setElementRotation(cj, rx, ry, rz+5)
		end
	end
	)

