camera = {
	[1] = { 1240.27, -936.21, 150.21, 1642.19, -1619.45, 76.21, 1281.33, -1184.23, 94.22},
	[2] = { 2953.32007, -2079.47217, 80.95277, 2902.98071, -2083.04590, 2.02448, 2899.27417, -2082.65, 2.50},
	[3] = { -1881.52, 358.50, 94.68, -1592.52, 632.09, 71.23,-1591.7819, 632.765, 71.32},
	[4] = {-2295.220, 1400.186, 17.501, -2648.546, 1863.905, 101.285,   -2649.0891113281, 1864.7237548828, 101.47338104248}
}



local dx = 0.0
local ID = math.random(1, #camera)

function interpolateCam()
		dx = dx + 0.0009
		local ix, iy, iz = interpolateBetween(camera[ID][1], camera[ID][2], camera[ID][3], camera[ID][4], camera[ID][5], camera[ID][6], dx, "OutQuad")
		setCameraMatrix(ix, iy, iz, camera[ID][7], camera[ID][8], camera[ID][9] )
end
addEventHandler("onClientRender", root, interpolateCam)
