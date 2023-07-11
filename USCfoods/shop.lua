drink = 1
fries = 1
burger = 1
meal = 1

isOpened = false

function closeShop()
    drink = 1
    fries = 1
    burger = 1
    meal = 1
    isOpened = false
    showCursor(false)

end

addEventHandler("onClientClick", root, 
    function(b, s)
        if isOpened == true then 
            if b == "left" and s == "down" then
            
                if isMouseInPosition(1000, 198, 1033, 229) then
                    closeShop()
                elseif isCursorOverRectangle(392, 453, 26, 27) then
                    if drink < 10 then
                    drink = drink + 1
                    end
                elseif isCursorOverRectangle(273, 453, 26, 27) then
                    if drink > 1 then
                        drink = drink - 1
                    end
                elseif isCursorOverRectangle(595, 453, 26, 27) then
                     if fries < 10 then
                        fries = fries + 1
                    end
                elseif isCursorOverRectangle(453, 443, 183, 48) then
                    if fries > 1 then
                        fries = fries - 1
                    end
                elseif isCursorOverRectangle(793, 453, 26, 27) then
                    if burger < 10 then
                        burger = burger + 1
                    end
                elseif isCursorOverRectangle(651, 443, 183, 48) then
                    if burger > 1 then
                        burger = burger - 1
                    end
                elseif isCursorOverRectangle(988, 453, 26, 27) then
                    if meal < 10 then
                        meal = meal + 1 
                    end   
                elseif isCursorOverRectangle(846, 443, 183, 48) then
                    if meal > 1 then
                        meal = meal - 1
                    end
                end
            end
        end
    end
    )






    function FoodShop()
        if isOpened == true then
            local px, py, pz = getElementPosition(getLocalPlayer())
            if  getDistanceBetweenPoints3D( px, py, pz, mx, my, mz ) > 3 then 
                closeShop()
            end
            dxRectangle(242, 194, 797, 356, tocolor(0, 0, 0, 175), false)
            dxRectangle(242, 194, 797, 40, tocolor(0, 0, 0, 175), false)
            dxText(1,"Supermarket", 242, 193, 1039, 234, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
            
            if isMouseInPosition(999, 196, 1033, 229) then
            dxRectangle(999, 196, 34, 33, tocolor(255, 0, 0, 175), false)
            dxText(1,"X", 1000, 198, 1033, 229, tocolor(255, 255, 255, 255), 1.2, "bankgothic", "center", "center", false, false, false, false, false)
            else
            dxRectangle(999, 196, 34, 33, tocolor(200, 0, 0, 175), false)
            dxText(1,"X", 1000, 198, 1033, 229, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
            end
            dxRectangle(252, 239, 185, 291, tocolor(100, 100, 100, 200), false)
            dxDrawImage(252, 239, 185, 178, "img/drink.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxRectangle(451, 239, 185, 291, tocolor(100, 100, 100, 200), false)
            dxRectangle(649, 239, 185, 291, tocolor(100, 100, 100, 200), false)
            dxRectangle(844, 239, 185, 291, tocolor(100, 100, 100, 200), false)
            dxDrawImage(451, 239, 185, 178, "img/fries.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawImage(649, 239, 185, 178, "img/burger.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawImage(844, 239, 185, 178, "img/meal.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxText(1,"McDonalds Drink\n 5$", 257, 407, 437, 443, tocolor(255, 255, 255, 255), 0.60, "bankgothic", "center", "top", false, false, false, false, false)
            dxText(1,"McDonalds Fries \n 10$", 451, 407, 631, 443, tocolor(255, 255, 255, 255), 0.60, "bankgothic", "center", "top", false, false, false, false, false)
            dxText(1,"McDonalds Meal \n 15$", 649, 407, 829, 443, tocolor(255, 255, 255, 255), 0.60, "bankgothic", "center", "top", false, false, false, false, false)
            dxText(1,"McDonalds Burger \n 20$", 844, 407, 1024, 443, tocolor(255, 255, 255, 255), 0.60, "bankgothic", "center", "top", false, false, false, false, false)
            dxDrawImage(254, 443, 183, 48, "img/bar.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawImage(392, 453, 26, 27, "img/plus.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxText(1,""..(drink), 315, 452, 382, 480, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
            dxDrawImage(273, 453, 26, 27, "img/minus.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawImage(453, 443, 183, 48, "img/bar.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawImage(595, 453, 26, 27, "img/plus.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxText(1,tostring(fries), 509, 453, 576, 481, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
            dxDrawImage(466, 453, 26, 27, "img/minus.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawImage(651, 443, 183, 48, "img/bar.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawImage(793, 453, 26, 27, "img/plus.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxText(1,tostring(burger), 709, 453, 776, 481, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
            dxDrawImage(665, 453, 26, 27, "img/minus.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawImage(846, 443, 183, 48, "img/bar.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawImage(988, 453, 26, 27, "img/plus.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxText(1,tostring(meal), 902, 453, 969, 481, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
            dxDrawImage(863, 453, 26, 27, "img/minus.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        

            dxRectangle(276, 491, 139, 28, tocolor(0, 241, 102, 191), false)
            if isMouseInPosition(276, 491, 415, 519) then
                dxText(1,"Buy", 276, 491, 415, 519, tocolor(255, 255, 255, 255), 1.20, "bankgothic", "center", "center", false, false, false, false, false)
            else
                dxText(1,"Buy", 276, 491, 415, 519, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
            end

            dxRectangle(473, 491, 139, 28, tocolor(0, 241, 102, 191), false)
            if isMouseInPosition(473, 491, 612, 519) then
                dxText(1,"Buy", 473, 491, 612, 519, tocolor(255, 255, 255, 255), 1.20, "bankgothic", "center", "center", false, false, false, false, false)
            else
                dxText(1,"Buy", 473, 491, 612, 519, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
            end
            dxRectangle(676, 491, 139, 28, tocolor(0, 241, 102, 191), false)
            if isMouseInPosition(676, 491, 815, 519) then
                dxText(1,"Buy", 676, 491, 815, 519, tocolor(255, 255, 255, 255), 1.20, "bankgothic", "center", "center", false, false, false, false, false)
            else
                dxText(1,"Buy", 676, 491, 815, 519, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
            end
            dxRectangle(870, 491, 139, 28, tocolor(0, 241, 102, 191), false)
            if isMouseInPosition(870, 491, 1009, 519) then 

                dxText(1,"Buy", 870, 491, 1009, 519, tocolor(255, 255, 255, 255), 1.20, "bankgothic", "center", "center", false, false, false, false, false)
            else
                dxText(1,"Buy", 870, 491, 1009, 519, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
            end

        end
    end

addEventHandler("onClientRender", root, FoodShop)

