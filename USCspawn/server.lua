local table = { -- x, y, z, rotation, cx, cy, cz, cTarx, cTary, cTarx, hospital Name 
{2032.21, -1416.697,16.992,132.831, 2034.408, -1455.984, 33.771, 2034.399, -1455.114, 33.279, "Jefferson (Los Santos)"}, 
{ 1178.898, -1324.091,14.142,272.517, 1202.607, -1342.082, 32.900, 1202.071, -1341.444, 32.347, "General Hospital (Los Santos)"}, 
{ 1243.950, 332.485,19.554,339.859, 1271.523, 340.145, 31.487, 1270.656, 339.9005, 31.053, "Montgomery Hospital"}, 
{1608.742, 1818.726,10.820,0.511, 1639.983, 1860.126, 27.143, 1639.396, 1859.443, 26.709, " Las Venturas Hospital"}, 
{-316.028, 1057.787,19.742,358.622, -312.625, 1078.876, 29.063, -312.879, 1077.985, 28.685, "Fort Carson Hospital"}, 
{ -2658.299, 635.242,14.453,178.922,  -2654.964, 635.494, 16.075, -2655.918, 635.422, 15.782, "Santa Flora Hospital"}, 
{ -2200.116, -2311.913 ,30.625,321.340,  -2169.806, -2289.567, 39.018, -2170.632, -2289.917, 38.575, "Angel Pine Hospital"}, 
}   
function spawnPlayerIntoHospital(thePlayer)     
local maxDist = 2000; 
local closestHospitalDist = 9999; 
local closestHospital; 

local x,y,z = getElementPosition( source ) -- you only need to get player position once before the loop 
local weapTable = {}
	for i=1, 12 do weapTable[i] = {getPedWeapon(source,i ), getPedTotalAmmo(source, i)} end 
	
	for i, v in ipairs( table ) do     
	local dist = getDistanceBetweenPoints3D( x,y,z, v[1],v[2],v[3] );     
		if dist < maxDist and dist < closestHospitalDist then         
		closestHospitalDist = dist;         
		closestHospital = v; -- save the closest hospital table     
		end 
	end 
	if closestHospital then -- check if the closestHospital is not = nil     
		SpawnPed( source, closestHospital[1], closestHospital[2], closestHospital[3], closestHospital[4], getElementModel( source ), 0, 0 );     
		outputChatBox( "You Have Spawned in "..closestHospital[11], source, 178, 123, 0 );
		setCameraMatrix( source, closestHospital[5],  closestHospital[6], closestHospital[7], closestHospital[8],closestHospital[9],closestHospital[10])
		setTimer(setCameraTarget, 3000, 1, source)
		for i, v in pairs ( weapTable ) do
			giveWeapon ( source, v[1], v[2] )
		end
	end 
end


addEventHandler("onPlayerWasted", root, spawnPlayerIntoHospital) 

function SpawnPed(thePlayer, x, y, z, rot, model, interior, dimension)     
	if isElement(thePlayer) then         
		fadeCamera(thePlayer, false, 0)         
		setTimer(fadeCamera, 1000, 1, thePlayer, true)         
		spawnPlayer(thePlayer, x, y, z, rot, model, interior, dimension) 
		toggleAllControls( thePlayer, false, true, false )
		setElementAlpha( thePlayer, 150 )
		setTimer(toggleAllControls, 3000, 1, thePlayer, true, true, false)
		setTimer(setElementAlpha, 7000, 1, thePlayer, 255)

		--toggleAllControls( player thePlayer, bool enabled, [ bool gtaControls = true, bool mtaControls = true ] )
	end 
end 