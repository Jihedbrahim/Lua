isOpened = false

startIndex = 1
showMaxItems = 8
selectedItem = 1
local screenW, screenH = guiGetScreenSize()

addEventHandler("onClientRender", root,
    function()
        if not isOpened then return false end
        if ( isElement ( PreviewVehicle ) ) then
            local rx, ry, rz = getElementRotation ( PreviewVehicle )
            if ( rz > 360 ) then
                rz = 0
            end
            setElementRotation ( PreviewVehicle, 0, 0, rz+1 )
            local _, _, posZ = getElementPosition ( PreviewVehicle )
            --local x, y, z = vehShop VehPos
            local x, y, z = vehShop[IDShop].VehPos[1], vehShop[IDShop].VehPos[2], vehShop[IDShop].VehPos[3]
            setElementPosition ( PreviewVehicle, x, y, z)
        end
        --dxRectangle(953, 581, 316, 42, tocolor(0, 0, 0, 175), false)
        --954, 293, 316, 324
        dxText("Use arrow keys to navigate", 953, 163, 1270, 214, tocolor(255, 255, 255, 255), 0.50, "bankgothic", "center", "bottom", false, false, false, false, false)
        
        dxRectangle(953, 292, 316, 324, tocolor(0, 0, 0, 150), false)
        dxRectangle(953, 217, 316, 75, tocolor(1, 82, 166, 200), false)
        dxText(tostring(ShopType), 952, 235, 1269, 290, tocolor(255, 255, 255, 255), 2, "default-bold", "center", "center", false, false, false, false, false)
            
        for i=1, showMaxItems do
        local xy = (i-1)*40.7
            --dxRectangle(953, 292+xy, 316, 40, tocolor(0, 0, 0, 150), false)
            if i == selectedItem then
                dxRectangle(953, 292+xy, 316, 40, tocolor(0, 129, 255, 150), false)
                dxText(getVehicleNameFromModel(vehicleTable[ShopType][i][1]).." | "..vehicleTable[ShopType][i][2].."$", 953, 292+xy, 1270, 332+xy, tocolor( 255, 255, 255, 255), 1.4, "default-bold", "center", "center", false, false, false, false, false)
            else
                dxRectangle(953, 292+xy, 316, 40, tocolor(0, 0, 0, 150), false)
                dxText(getVehicleNameFromModel(vehicleTable[ShopType][i][1]).." | "..vehicleTable[ShopType][i][2].."$", 953, 292+xy, 1270, 332+xy, tocolor(255, 255, 255, 255), 1.2, "default-bold", "center", "center", false, false, false, false, false)
            end
        end

        dxRectangle(953, 622, 131, 37, tocolor(0, 82, 166, 255), false)
        dxRectangle(1139, 622, 131, 37, tocolor(0, 82, 166, 255), false)
        if isMouseInPosition(954, 623, 1085, 659) then
            dxText("Buy", 954, 623, 1085, 659, tocolor(255, 255, 255, 255), 1.2, "bankgothic", "center", "center", false, false, false, false, false)
        else
            dxText("Buy", 954, 623, 1085, 659, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
        end
        if isMouseInPosition(1139, 623, 1270, 659) then
            dxText("Close", 1139, 623, 1270, 659, tocolor(255, 255, 255, 255), 1.20, "bankgothic", "center", "center", false, false, false, false, false)
        else
            dxText("Close", 1139, 623, 1270, 659, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)

        end



    end
)     

 --table.insert(vehicleTable[ShopType], table.remove(vehicleTable[ShopType], 1))
addEventHandler( "onClientKey", root, function(b, state)
    if b and validKeys[b] and isOpened == true  then
        if b == "arrow_u" and state then
            if selectedItem > 1 then 
                selectedItem = selectedItem - 1
            else
                table.insert(vehicleTable[ShopType], 1, table.remove(vehicleTable[ShopType]))
            end
            setElementModel ( PreviewVehicle, vehicleTable[ShopType][selectedItem][1] )
            playSoundFrontEnd(1)
        elseif b == "arrow_d" and state then
            if selectedItem < showMaxItems then 
                selectedItem = selectedItem + 1
            else
                table.insert(vehicleTable[ShopType], table.remove(vehicleTable[ShopType], 1))
            end
                playSoundFrontEnd(1)
            setElementModel ( PreviewVehicle, vehicleTable[ShopType][selectedItem][1] )
        end
    end
end
)
addEventHandler("onClientClick", root, function(b, s)
    if b == "left" and s and isOpened == true then
        if isMouseInPosition(1139, 623, 1270, 659) then
            isOpened = false
            setCameraTarget( localPlayer )
            showCursor(false)
            if isElement(PreviewVehicle) then destroyElement(PreviewVehicle) end
            setElementFrozen(localPlayer, false)
        elseif isMouseInPosition(954, 623, 1085, 659) then
            triggerServerEvent("onPlayerRequestPurchase", getLocalPlayer(), getSelectedVehicle(), getSelectedPrice(),ShopLocation )
            closeShop()
        end
    end
end
)

function getSelectedVehicle()
    return vehicleTable[ShopType][selectedItem][1]
end

function getSelectedPrice()
 return vehicleTable[ShopType][selectedItem][2]
end

function closeShop()
    isOpened = false
    if isElement(PreviewVehicle) then destroyElement(PreviewVehicle) end
    setCameraTarget(localPlayer)
    setElementFrozen(localPlayer, false)
    showCursor(false)
end