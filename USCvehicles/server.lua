db = dbConnect("sqlite", "database.sql")
	if not db then
		return outputDebugString( "Database doesnt work", 3, 255, 0 ,0)
	else
		return outputDebugString("Database has been connected!", 3, 0, 255, 0)
	end

recoverPosition = {--x, y,z, rot
	["vehicle"] = {
		{-2571.8447, 631.990, 13.902,89.92}, -- SF
		{1690.8834, -1060.419, 23.356,0.571},-- LS
		{1741.929, 1996.7789, 10.2493,267.970},--LV


	},
}


function closestLocRecover(element)
	if isElement ( element ) and getElementsByType(element) == "vehicle" then
		local px,py,_ = getElementPosition(element)
		local vehType = getVehicleType(model)
		local x,y,z,rotation
		local dist
		local vehicle = vehicles[id]
		for i=1,#recoverPosition[vehType] do
			local rx,ry,rz,rRotation = unpack(recoverPosition[vehType][i])
			local distance = getDistanceBetweenPoints2D(px,py,rx,ry)
			if not dist or distance < dist then
				dist = distance
				if isElement(vehicle) and not isElementFrozen(vehicle) then
					x,y,z,rotation = rx+math.random(-2,2),ry+math.random(-2,2),rz+math.random(0,4),rRotation -- +random for the ugly way of preventing vehicles getting stuck
				else
					x,y,z,rotation = rx+math.random(-2,2),ry+math.random(-2,2),rz,rRotation -- +random for the ugly way of preventing vehicles getting stuck
				end
			end
		return x,y,z,rotation
		end
	end
end