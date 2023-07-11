isOpened = false 
showMaxItems = 7
selectedItem = 1
totalCartPrice = 0
categoryClothes = {}
for ID=0,17 do
    categoryClothes[ID] = {}
end



isSecondDXOpened = false
local medium = dxCreateFont("fonts/sp.ttf", 30)
addEventHandler("onClientRender", root,
    function()
        if isOpened == false then return false end
        if isSecondDXOpened == true then return false end
        dxRectangle(953, 292, 316, 284, tocolor(0, 0, 0, 191), false)
        
        dxRectangle(953, 217, 316, 75, tocolor(1, 82, 166, 223), false)
        dxText(1,"Clothes Shop - CJ", 952, 235, 1269, 290, tocolor(255, 255, 255, 255), 1.00, medium, "center", "center", false, false, false, false, false)
        
        for i=1, showMaxItems do
            local xy = (i-1)*40.7
            dxRectangle(953, 292+xy, 316, 40, tocolor(0, 0, 0, 150), false)
            if i == selectedItem then 
                dxRectangle(953, 292+xy, 316, 40, tocolor(0, 129, 255, 191), false)
                dxText(1,tostring((getSelectedCategory(i))), 953, 292+xy, 1270, 332+xy, tocolor(255, 255, 255, 255), 1.70, "default-bold", "center", "center", false, false, false, false, false)
                
            else
                dxText(1,tostring((getSelectedCategory(i))), 953, 292+xy, 1270, 332+xy, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
                
            end
            --dxText(1,tostring(i).."/"..tostring(#categoryNames), 1208, 263, 1269, 292, tocolor(255, 255, 255, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        
        end
    end
)


selectedNewItem = 1
maxShowNewItem = 7
selectedClothes = 1
posY = 0
local nextPage = false
addEventHandler("onClientRender", root,
    function()
        --dxText(1,tostring(totalCartPrice), 500, 500, 1269, 290, tocolor(255, 0, 0, 255), 1.00, medium, "center", "center", false, false, false, false, false)
        if isOpened == true or isSecondDXOpened == true then
        dxRectangle(953, 581, 316, 42, tocolor(0, 0, 0, 175), false)
        dxText(1,"Total Price : "..totalCartPrice.." $", 953, 588, 1268, 624, tocolor(255, 255, 255, 255), 1.00, medium, "center", "center", false, false, false, false, false)
        end

        if isSecondDXOpened == false then return false end

        dxRectangle(953, 292, 316, 284, tocolor(0, 0, 0, 150), false)
        dxRectangle(953, 217, 316, 75, tocolor(1, 82, 166, 200), false)
        dxText(1,selectedItemFromList, 952, 235, 1269, 290, tocolor(255, 255, 255, 255), 1.00, medium, "center", "center", false, false, false, false, false)
        
        for i=1, maxShowNewItem do
            local xy = (i-1)*40.7
            dxRectangle(953, 292+xy, 316, 40, tocolor(0, 0, 0, 150), false)
            if newClothes[selectedItemFromList][selectedClothes].texture == categoryClothes[selectedIDFromList].tex and newClothes[selectedItemFromList][selectedClothes].model == categoryClothes[selectedIDFromList].mod then
                r, g, b = 255, 255, 0
            else
                r, g, b = 255, 255, 255
            end
            local slot = 0
            for k, v in ipairs (newClothes[selectedItemFromList]) do
                if ( k > nextPage and slot < 7) then 
                    slot = slot + 1 
                    posY = posY + 30
                    sp = (k-1) * 40.7
                    --local sp = (i)*40.7
                    if k  == nextPage then
                        dxRectangle(953, 292+(sp), 316, 40, tocolor(0, 129, 255, 191), false)
                        dxText(1,tostring(v.name.." | "..tostring(v.price).." $" ), 953, 292+(sp), 1270, 332+(sp), tocolor(r, g, b, 255), 1.7, "default-bold", "center", "center", false, false, false, false, false)
                    else

                        dxText(1,tostring(v.name.." | "..tostring(v.price).." $" ), 953, 292+(sp), 1270, 332+(sp), tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
                    end
                end
        
        end

        end
    end
)

function getSelectedClothes(index)
    if (clothes[getSelectedCategory(index)][1].name) then
        return clothes[getSelectedCategory(index)][1].name
    end
end

function getSelectedCategory(index)
    if (types[index].name) then
        return types[index].name, types[index].id
    end
end


addEventHandler( "onClientKey", root, 
    function(b, s)
        if isSecondDXOpened == false then
            if b == "arrow_u" and s then
                if selectedItem > 1 then 
                    selectedItem = selectedItem - 1
                else
                    table.insert(types, 1, table.remove(types))
                end
                playSound( "sounds/move.wav", false)

                elseif b == "arrow_d" and s then
                if selectedItem < showMaxItems then 
                    selectedItem = selectedItem + 1
                else
                    table.insert(types, table.remove(types, 1))
                end
                    --playSoundFrontEnd(1)
                    playSound( "sounds/move.wav", false)
            elseif b == "enter" and s== false and isOpened == true and isSecondDXOpened == false then
                selectedItemFromList, selectedIDFromList = getSelectedCategory(selectedItem)
                iprint(selectedItemFromList)
                iprint(selectedIDFromList)
                isSecondDXOpened = true
                isOpened = false
                selectedClothes = 1
                nextPage = 0   
                playSound( "sounds/open.wav", false)
            elseif b =="backspace" and s and isOpened == true and isSecondDXOpened == false then
                if totalCartPrice == 0 then
                    isOpened = false
                    isSecondDXOpened = false
                    totalCartPrice = 0
                    setElementFrozen(getLocalPlayer(), false)
                    setCameraTarget(getLocalPlayer())
                    playSound( "sounds/remove.wav", false)
                else

                    if ( getPlayerMoney( localPlayer ) >= tonumber( totalCartPrice ) ) then
                        outputChatBox("you have enough to buy", 0, 255, 0)
                        isOpened = false
                        totalCartPrice = 0
                        setElementFrozen(getLocalPlayer(), false)
                        setCameraTarget(getLocalPlayer())
                        playSound( "sounds/remove.wav", false)
                        triggerServerEvent("onPlayerBuyClothes", localPlayer, categoryClothes, totalCartPrice)
                        for ID=0,17 do
                            categoryClothes[ID] = {}
                        end
                    else
                        outputChatBox("You dont have enough money to buy clothes", 255, 0 ,0)
                    end
                end
                
            end
        end
    end
    )







addEventHandler("onClientKey", root, 
    function(b, s)
        if isOpened == false and isSecondDXOpened == true then
            if b == "backspace" and s then
                isSecondDXOpened = false
                isOpened = true
                playSound( "sounds/remove.wav", false)
            elseif b == "arrow_d" and s then
                nextPage = nextPage + 1 
                if (nextPage > #newClothes[selectedItemFromList]- 10 ) then
                    nextPage = #newClothes[selectedItemFromList] - 10
                end
                playSound( "sounds/move.wav", false)
            elseif b == "arrow_u" and s then 
                if (nextPage > 0 ) then 
                    nextPage = nextPage - 1
                end
                playSound( "sounds/move.wav", false)
                    local texture, model, id = newClothes[selectedItemFromList][selectedClothes].texture, newClothes[selectedItemFromList][selectedClothes].model, newClothes[selectedItemFromList][selectedClothes].id
                    addPedClothes(cj, texture, model, id)
                    --playSoundFrontEnd(1) 
                    playSound( "sounds/move.wav", false)   

                elseif b == "enter" and s == true and isSecondDXOpened == true and isOpened == false then
                    if newClothes[selectedItemFromList][selectedClothes].texture == categoryClothes[selectedIDFromList].tex and newClothes[selectedItemFromList][selectedClothes].model == categoryClothes[selectedIDFromList].mod then
                       removeClothesFromCart(selectedIDFromList,newClothes[selectedItemFromList][selectedClothes].price )
                        iprint(newClothes[selectedItemFromList][selectedClothes].price)
                        outputChatBox("You have removed "..newClothes[selectedItemFromList][selectedClothes].name.." From the Cart", 255, 255, 0)
                        playSound( "sounds/remove.wav", false)
                    else
                        addClothesToCart(selectedIDFromList,newClothes[selectedItemFromList][selectedClothes].texture,newClothes[selectedItemFromList][selectedClothes].model, newClothes[selectedItemFromList][selectedClothes].price  )
                        outputChatBox("You have added "..newClothes[selectedItemFromList][selectedClothes].name.." To the Cart!", 255, 255, 0)
                        playSound( "sounds/open.wav", false)
                    end
            end
        end
    end
    )



function addClothesToCart(slot, tex, mod, price)
    if categoryClothes[slot] then
        removeClothesFromCart(slot)
    end
        categoryClothes[slot] = {tex=tex,mod=mod, price=price}
        totalCartPrice = totalCartPrice + price
end

function removeClothesFromCart(slot)
   local price = categoryClothes[slot].price
   iprint("TEST "..tostring(price))
   if price then
        totalCartPrice = math.max(0,totalCartPrice - price )
        categoryClothes[slot] = {}
    end
end




 weapon = createWeapon( 24, 8, 8, 3 )
addEventHandler("onClientRender", root,
    function()

        
    end
    )
