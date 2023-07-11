AreaTables = {-- startX, startY,start Z,  endX, endY, endZ

	{96.683, 1798.932, 17.640625 , 285.30496, 1940.2816, 17.640625},
	{1698.29, 2724.489, 10.835, 1916.121, 2881.942, 10.83},
	{2313.904, -1287.755, 27.9, 2360.442, -1167.225, 27.9},

}

areas = {}
radarArea = {}

addEventHandler("onClientResourceStart", resourceRoot, 
	function()
		for i, v in ipairs( AreaTables ) do
			local x, y,z, w,h, d = v[1], v[2],v[3], v[4]-v[1], v[5]-v[2], v[6]
			local col = createColCuboid(x, y,z-6, w,h, d)
			
			areas[col] = true
			setElementData(col, "SafeZone", true)
			radarArea[col] = createRadarArea( x, y, w, h, 50, 255, 50, 100)

		end
	end
)

addEventHandler("onClientPreRender", root, 
	function()
		for i, v in ipairs ( AreaTables ) do
			local x, y,z, w,h, d = v[1], v[2],v[3], v[4], v[5], v[6]
			--local wx, hy = w-x, h-y
			dxDrawBordered3DLine(x, y, z-0.5, w,h, d-0.5,tocolor(255, 255, 0, 150), 10)
		
			--dxDrawBordered3DLine(x, y, z+17.96, w, h, d+17.96,tocolor(255, 255, 0, 150), 10)
		

		end
	end
	)

function dxDrawBordered3DLine(x, y, z, w, h, d, color, width)
	width = width or 1
	local w, h = w-x, h-y
	dxDrawLine3D( x, y,z, x+w,y, d, color, width)--up
	dxDrawLine3D( x, y,z, x,y+h, d, color, width)--left
	dxDrawLine3D(x, y+h, z, x+w, y+h, d, color, width)-- bottom
	dxDrawLine3D(x+w, y, z, x+w, y+h,d, color, width)--right
end


function hitSafeZone(p, dim)
	if getElementType(p) == "player" or getElementType(p) =="ped" and dim and areas[source] then
	
		
		triggerServerEvent( "onPlayerHitSafeZone", p)
	end
		
end
addEventHandler("onClientColShapeHit", resourceRoot, hitSafeZone)



function leaveSafeZone(p, dim)
	if getElementType(p) == "player" or getElementType(p) =="ped" and dim and areas[source] then

		outputChatBox("you have left the safeZone")
		local _,_, z = getElementPosition(p)
		iprint(z)
		triggerServerEvent("onPlayerLeaveSafeZone", p)
	end
end
addEventHandler("onClientColShapeLeave", resourceRoot, leaveSafeZone)




addEventHandler("onClientPedDamage", root,
	function(attacker, weapon, bodypart, loss)
		if isElement(attacker) and getElementData(source, "npc_hlc") then
				triggerServerEvent("onNPCGetDamage", source, attacker, weapon, bodypart, loss)
		end

	end
)

