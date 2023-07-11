
showMaxItems = 7
selectedItem = 1
isOpened = true
isSecondDXOpened = false
local medium = dxCreateFont("fonts/sp.ttf", 30)

    function mainShop()
        if isOpened == false then return false end
        if isSecondDXOpened == true then return false end
        if isOpened == false and isSecondDXOpened == true then
            if isElement(Object) then destroyElement(Object) end end
        dxRectangle(953, 292, 316, 284, tocolor(0, 0, 0, 191), false)
        
        dxRectangle(953, 217, 316, 75, tocolor(1, 82, 166, 200), false)
        dxText(1,"Ammunation Shop", 952, 235, 1269, 290, tocolor(255, 255, 255, 255), 1.00, medium, "center", "center", false, false, false, false, false)
        dxDrawImage(953, 579, 317, 35, "menunav.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
    
        for i=1, showMaxItems do
            local xy = (i-1)*40.7
            dxRectangle(953, 292+xy, 316, 40, tocolor(0, 0, 0, 150), false)
            if i == selectedItem then 
                dxRectangle(953, 292+xy, 316, 40, tocolor(0, 129, 255, 140), false)
                dxText(1,tostring((getSelectedCategory(i))), 953, 292+xy, 1270, 332+xy, tocolor(255, 255, 255, 255), 1.70, "default-bold", "center", "center", false, false, false, false, false)
                
            else
                dxText(1,tostring((getSelectedCategory(i))), 953, 292+xy, 1270, 332+xy, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
                
            end
            --dxText(1,tostring(selectedItem).."/"..tostring(#main), 1208, 263, 1269, 292, tocolor(255, 255, 255, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        
        end
    end



selectedNewItem = 1
maxShowNewItem = 7
selectedWeap = 1
    function secondShop()
        --dxText(1,tostring(totalCartPrice), 500, 500, 1269, 290, tocolor(255, 0, 0, 255), 1.00, medium, "center", "center", false, false, false, false, false)
        
        --if isElement(Object) then destroyElement( Object)end 


        if ( isElement ( Object ) ) then
        local rx, ry, rz = getElementRotation ( Object )
        if ( rz > 360 ) then
            rz = 0
        end
        setElementRotation ( Object, 0, 0, rz+5 )
        end
        if isSecondDXOpened == false then return false end
        for i=1, #items[selectedItemFromList] do
            yx = (i)*40.7
        end
            dxRectangle(953, 292, 316, yx, tocolor(0, 0, 0, 150), false)
            dxRectangle(953, 217, 316, 75, tocolor(1, 82, 166, 200), false)
            dxText(1,selectedItemFromList, 952, 235, 1269, 290, tocolor(255, 255, 255, 255), 1.00, medium, "center", "center", false, false, false, false, false)
            dxDrawImage(953, 293+yx, 317, 35, "menunav.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
    
        

        for i=1, #items[selectedItemFromList] do
            local xy = (i-1)*40.7
            
            dxRectangle(953, 292+xy, 316, 40, tocolor(0, 0, 0, 150), false)
            if i == selectedWeap then
                dxRectangle(953, 292+xy, 316, 40, tocolor(0, 129, 255, 191), false)
                dxText(1,tostring(items[selectedItemFromList][i][1].." | "..tostring(items[selectedItemFromList][i][3]).." $" ), 953, 292+xy, 1270, 332+xy, tocolor(255, 255, 255, 255), 1.7, "default-bold", "center", "center", false, false, false, false, false)
            else

                dxText(1,tostring(items[selectedItemFromList][i][1].." | "..tostring(items[selectedItemFromList][i][3]).." $" ), 953, 292+xy, 1270, 332+xy, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
            end


        end
    end



addEventHandler( "onClientKey", root, 
    function(b, s)
        if isSecondDXOpened == false and isOpened == true then
            if b == "arrow_u" and s== false then
                if selectedItem > 1 then 
                    selectedItem = selectedItem - 1
                else
                    table.insert(main, 1, table.remove(main))
                end
                playSound( "sounds/move.wav", false)

            elseif b == "arrow_d" and s== false then
                if selectedItem < showMaxItems then 
                    selectedItem = selectedItem + 1
                else
                    table.insert(main, table.remove(main, 1))
                end
                    --playSoundFrontEnd(1)
                    playSound( "sounds/move.wav", false)
            elseif b == "enter" and s== false then
                selectedItemFromList = getSelectedCategory(selectedItem)
                iprint(selectedItemFromList)
                --iprint(selectedIDFromList)
                isSecondDXOpened = true
                isOpened = false
                selectedWeap = 1
                setElementModel(Object,items[selectedItemFromList][selectedWeap][4] )
                playSound( "sounds/open.wav", false)
                
            elseif b == "backspace" and s == false then
                if isElement(Object) then destroyElement( Object)end
                selectedItem = 1
                removeEventHandler("onClientRender", root, mainShop)
                removeEventHandler("onClientRender", root, secondShop)
                isOpened = false
                setCameraTarget(localPlayer)
                setElementFrozen(getLocalPlayer(), false)
            end
        end
    end
    )


addEventHandler("onClientKey", root,
    function(b, s)
        if isSecondDXOpened == true and isOpened == false then
            if b == "backspace" and s == false then
                isSecondDXOpened = false
                isOpened = true
                playSound( "sounds/remove.wav", false)
            elseif b == "arrow_u" and s == false then
                if selectedWeap > 1 then 
                    selectedWeap = selectedWeap - 1
                else
                    table.insert(items[selectedItemFromList], 1, table.remove(items[selectedItemFromList]))
                end
                
                setElementModel(Object,items[selectedItemFromList][selectedWeap][4] )
            elseif b == "arrow_d" and s == false then
                if selectedWeap < #items[selectedItemFromList] then 
                    selectedWeap = selectedWeap + 1
                else
                    table.insert(items[selectedItemFromList], table.remove(items[selectedItemFromList], 1))
                end
                setElementModel(Object,items[selectedItemFromList][selectedWeap][4] )
            end
        end
    end
)
