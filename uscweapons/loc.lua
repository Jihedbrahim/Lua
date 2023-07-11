shopTable = {
{ids=1,x= 288.4264831543, y=-108.98882293701, z=1001.515625, dim= 8, int= 6, weapPos={286.299, -105.440, 1002.526}, cameraView={287.509, -106.1995, 1002.253, 286.7363, -105.602, 1002.4683}}, -- middle, near paramedic shop
{ids=2,x= 288.4264831543, y=-108.98882293701, z=1001.515625, dim= 7, int= 6, weapPos={286.299, -105.440, 1002.526}, cameraView={287.509, -106.1995, 1002.253, 286.7363, -105.602, 1002.4683}}, -- middle, near paramedic shop
{ids=3,x= 288.4264831543, y=-108.98882293701, z=1001.515625, dim= 9, int= 6, weapPos={286.299, -105.440, 1002.526}, cameraView={287.509, -106.1995, 1002.253, 286.7363, -105.602, 1002.4683}}, -- middle, near paramedic shop
{ids=4,x= 288.4264831543, y=-108.98882293701, z=1001.515625, dim= 10, int= 6, weapPos={286.299, -105.440, 1002.526}, cameraView={287.509, -106.1995, 1002.253, 286.7363, -105.602, 1002.4683}}, -- middle, near paramedic shop


{ids=5,x= 312.31240844727, y=-165.5792388916, z=999.60101318359, dim= 11, int= 6,weapPos={314.424, -168.185, 1000.674}, cameraView={315.37, -167.746, 1000.255, 314.587, -168.36, 1000.16}},

{ids=6,x= 290.63088989258, y=-83.607963562012, z=1001.515625, dim= 3, int = 4, weapPos={298.00445556641, -81.792, 1002.534}, cameraView={297.29022216797, -80.38111114502, 1002.1819458008, 297.72796630859, -81.279945373535, 1002.2038574219}}, -- start lv
{ids=7,x= 290.63088989258, y=-83.607963562012, z=1001.515625, dim= 4, int = 4, weapPos={298.00445556641, -81.792, 1002.534}, cameraView={297.29022216797, -80.38111114502, 1002.1819458008, 297.72796630859, -81.279945373535, 1002.2038574219}}, -- start lv
{ids=8,x= 290.63088989258, y=-83.607963562012, z=1001.515625, dim= 5, int= 4, weapPos={298.00445556641, -81.792, 1002.534}, cameraView={297.29022216797, -80.38111114502, 1002.1819458008, 297.72796630859, -81.279945373535, 1002.2038574219}}, -- start lv
{ids=9,x= 290.63088989258, y=-83.607963562012, z=1001.515625, dim= 6, int = 4, weapPos={298.00445556641, -81.792, 1002.534}, cameraView={297.29022216797, -80.38111114502, 1002.1819458008, 297.72796630859, -81.279945373535, 1002.2038574219}}, -- start lv

{ids=10,x= 313.49261474609, y=-133.77299499512, z=999.6015625, dim= 1, int= 7, weapPos={315.92660522461, -135.44859313965, 1000.6015625}, cameraView={315.20593261719, -136.3842010498, 1000.3321533203, 316.01733398438, -135.84294128418, 1000.111572265}},

{ids=11,x= 296.2705078125, y=-37.595581054688, z=1001.515625, dim= 2, int= 1, weapPos={298.162, -39.382, 1002.529}, cameraView={297.978, -38.128, 1003.147, 298.054, -39.0357, 1002.73}},

}



items = 
{
	["Pistols"]= 
	{
		{ "9mm", 22, 240, 346 },
		{ "Silenced 9mm", 23, 720, 347 },
		{ "Desert Eagle", 24, 1440, 348 },
 	},
	
	["Micro SMGs"]= 
	{
		{ "Tec-9", 32, 360, 372 },
		{ "Micro SMF/Uzi", 28, 600, 352 },
	},
	
	["Shotguns"]= 
	{
		{ "Shotgun", 25, 720, 349 },
		{ "Sawnoff", 26, 960, 350 },
		{ "Combat Shotgun", 27, 1200, 351 },
	},
	
	["Thrown"]= 
	{ 
		{ "Grenade", 16, 360, 342 },
		{ "Remote Explosive", 39, 2400, 363 },
	},
	
	
	["SMG"]=
	{ 
		{ "SMG/MP5", 29, 2400, 353 }
	},
	
	["Rifles"]=
	{ 
		{ "Rifle", 33, 1200, 357 },
		{ "Sniper Rifle", 34, 6000, 358 },
	},
	
	["Assault"]= { 
		{ "AK47", 30, 4200, 355 },
		{ "M4", 31, 5400, 356 },
	},
	
}
main = {
	{"Pistols"}, 
	{"Micro SMGs"},
	{"Shotguns"},
	{"Thrown"},
	{"SMG"},
	{"Rifles"},
	{"Assault"},
}

function getSelectedWeapon(index)
    if (items[getSelectedCategory(index)][1]) then
        return items[getSelectedCategory(index)][1]
    end
end

function getSelectedCategory(index)
    if (main[index]) then
        return main[index][1]
    end
end
markerTable = {}

for i, v in ipairs (shopTable) do
	local x, y, z = v.x,v.y, v.z
	local dim, int = v.dim, v.int
	--wx, wy, wz = v.weapPos[1], v.weapPos[2], v.weapPos[3]
	--cx, cy, cz, lx, ly,lz = v.cameraView[1], v.cameraView[2], v.cameraView[3], v.cameraView[4], v.cameraView[5], v.cameraView[6]
	markerTable[i] = createMarker(x, y, z-1, "cylinder", 1.2, 66, 66, 66, 150)
	setElementData(markerTable[i], "CameraInterior", int)
	setElementDimension(markerTable[i], dim)
	setElementInterior(markerTable[i], int)
	setElementData(markerTable[i], "WeaponShop", true)
	setElementData(markerTable[i], "wsID", shopTable[i].ids)
end

addEventHandler("onClientMarkerHit", root,
	function(hitmarker, dim)
		if hitmarker == localPlayer and dim and getElementData(source, "WeaponShop") then
			iprint(getElementData(source,"wsID" ))
			
	        isOpened = true
	        iprint(getElementData(source, "wsID"))
			addEventHandler("onClientRender", root, mainShop)
			addEventHandler("onClientRender", root, secondShop)
			for i, v in ipairs (shopTable) do
				if getElementData(source, "wsID") == i then 
					local cx, cy, cz, lx, ly,lz = v.cameraView[1], v.cameraView[2], v.cameraView[3], v.cameraView[4], v.cameraView[5], v.cameraView[6]
					local wx, wy, wz = v.weapPos[1], v.weapPos[2], v.weapPos[3]
					setCameraMatrix(cx, cy, cz, lx, ly,lz)
					makeWeapon(wx, wy, wz)
				end
			end
			--setCameraInterior( getElementData(source, "CameraInterior"))
			setElementFrozen(getLocalPlayer(), true)
		end 
	end
	)

function makeWeapon(wx, wy, wz)
		Object = createObject(346, 0, 0, 0)
        setElementDimension(Object, getElementDimension(getLocalPlayer()))
        setElementInterior(Object, getElementInterior(getLocalPlayer()))
        setElementPosition(Object, wx, wy, wz)
end