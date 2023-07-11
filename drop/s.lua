positions = {
        { 1497.5999755859, -1853.0999755859, 2516, 21.0},
        {1457.99597, -1841.08655, 2516.02661, 294.84 },
		{1480.47534, -1794.83948, 2516.02661, 202.91},
        }
matrix = {
    {1497.362, -1849.923, 2517.053, 1506.192, -1946.816, 2493.948},
    {1460.486, -1838.625, 2517.458, 1388.673, -1902.72, 2490.353},
    {1480.922, -1798.879, 2517.028, 1468.11, -1701.148, 2500.1628},
}

colAreas = {
    {1493.0939941406, -1828.0065917969, 2516.0266113281, 40}, -- 40
        }

areas = {}

disabledKeys = {"next_weapon", "previous_weapon"}

addEventHandler("onResourceStart", resourceRoot,
    function()
        for i, v in ipairs( colAreas ) do
            local x, y, z, rad = v[1], v[2], v[3], v[4]
            local col = createColSphere(x, y, z, rad)
            setElementDimension(col, 2)
            setElementData(col, "pvpZone", true)
            areas[col] = true
            for i, v in ipairs ( getElementsByType ( "player" ) ) do
                setElementData(v, "sniperMode", false)
            end
        end
    end
)

addEventHandler( "onElementColShapeHit", root, 
    function (c, m) 
        iprint(m)
        if areas[c] and m then
            iprint("works1")
            if getElementType(source) == "player" then
                if isPedWearingJetpack( source ) then
                    setPedWearingJetpack( source, false)
                end
                iprint("works2")
                setElementData(source, "sniperMode", true)
                    iprint("works3")
                    giveWeapon( source, 34 , 500, true )
                    --setPedWeaponSlot( source, 6)
                    for i,k in ipairs(disabledKeys) do
                        toggleControl( source,k, false)
                    end
            end
        end
    end
)


--The source of this event is the player or vehicle that collided with the colshape.






addCommandHandler("drop", 
    function(p)
        if not isPlayerInsideArea(p) then
            if getPedOccupiedVehicle(p) then
                removePedFromVehicle( p )
            end
            local random = math.random(#positions)
            local mx, my,mz, tx, ty, tz = unpack(matrix[random])
            local x, y, z, rot = unpack(positions[random])
            setElementPosition(p, x, y, z+1)
            setElementRotation(p, 0, 0, rot)
            setCameraMatrix( p, mx, my,mz, tx, ty, tz)
            fadeCamera(p, false, 0)         
            setTimer(fadeCamera, 1000, 1, p, true) 
            
            setTimer(setCameraTarget, 3000, 1, p)
            toggleAllControls( p, false, true, false )
            setElementAlpha( p, 150 )
            setElementData(p, "protected", true)
            setTimer(toggleAllControls, 3000, 1, p, true, true, false)
            setTimer(setElementAlpha, 7000, 1, p, 255)
            setTimer(setElementData, 7000, 1, p, "protected", false)
            giveWeapon( p, 34 , 500, true )
            setElementModel(p, 0)
            setElementHealth( p, 100)
            setPedArmor( p,100 )
            setElementDimension(p, 2)
            --setElementData(p, "sniperMode", true)
            outputChatBox("you have been set to PVP sniper mode", p, 255, 255, 0)
            
        else
            outputChatBox("you are already inside the pvp arena", p, 255, 0,0)
        end
    end
)


addEventHandler("onPlayerDamage", root,
    function(attacker, weapon, bodypart, loss)
        if isPlayerInsideArea(attacker) and isPlayerInsideArea(source) then
            if not isElement(attacker) or not getElementType(attacker)=="player" then 
                cancelEvent() 
            end
            if getElementDimension(source) ~= 2 or getElementDimension(attacker) ~= 2 then
                cancelEvent()
            end
            if weapon ~= 34 or bodypart ~= 9 then
                cancelEvent( )
            end
        end
    end
)



function isPlayerInsideArea(player)
    if not player or getElementType(player) ~= "player" then return false end
    for i,col in ipairs(getElementsByType("colshape", resourceRoot)) do
        if (isElementWithinColShape(player, col) and getElementData(col, "pvpZone")) then
            return true
        else
            return false
        end
    end
end



addEventHandler("onPlayerWasted", root, 
    function(ammo, killer, weapon, bodypart)
        --if not isElement(killer) or not getElementType(killer) ~= "player" then return false end
        --if getElementDimension(killer) == 2 and getElementDimension(source) == 2 then
            --if isElement(killer) and getElementType(killer) == "player" and getElementData(killer, "sniperMode") then
                --if isElement(source) and getElementType(source) == "player" and getElementData(source, "sniperMode") then
                    source_ = source
                    local random = math.random(#positions)
                    local mx, my,mz, tx, ty, tz = unpack(matrix[random])
                    local x, y, z, rot = unpack(positions[random])
                    setCameraMatrix( source_, mx, my,mz, tx, ty, tz)
                    setElementRotation(source_, 0, 0, rot)
                    setTimer(setCameraTarget, 3000, 1, source_)
                    if isElement(source_) then
                        local x, y, z, rot = unpack(positions[random])
                        SpawnPed( source_, x, y, z, rot, 0,  0, 2)
                    end
                         
                --end
            --end
        --end
    end
)



function SpawnPed(thePlayer, x, y, z, rot, model, interior, dimension)     
    if isElement(thePlayer) then         
        fadeCamera(thePlayer, false, 0)         
        setTimer(fadeCamera, 1000, 1, thePlayer, true)         
        spawnPlayer(thePlayer, x, y, z, rot, model, interior, dimension) 
        giveWeapon( thePlayer, 34 , 500, true )
        toggleAllControls( thePlayer, false, true, false )
        setElementAlpha( thePlayer, 150 )
        setElementData(thePlayer, "protected", true)
        setTimer(toggleAllControls, 3000, 1, thePlayer, true, true, false)
        setTimer(setElementAlpha, 7000, 1, thePlayer, 255)
        setTimer(setElementData, 7000, 1, thePlayer, "protected", false)
        --toggleAllControls( player thePlayer, bool enabled, [ bool gtaControls = true, bool mtaControls = true ] )
    end 
end 