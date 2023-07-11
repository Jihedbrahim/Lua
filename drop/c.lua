addEventHandler("onClientPlayerWasted", root,
		function(killer, weapon, bodypart)
			if ( isElement(killer) and getElementType(killer) == "player" ) then
				if getElementDimension(killer) == 2 and getElementDimension(source) == 2 then
					if isPlayerInsideArea(killer) and isPlayerInsideArea(source) then
						if weapon == 34 and bodypart == 9 then
							addKill(killer, 1)
							addDeath(source, 1)
						end
					end
				end
			end
		end
		)

addEventHandler( "onClientPlayerDamage", root, 
	function (attacker, weapon, bodypart, loss) 
		if (isElement(attacker) and getElementType(attacker) == "player") then
			if getElementDimension(attacker) == 2 and getElementDimension(source) == 2 then
				if isPlayerInsideArea(attacker) and isPlayerInsideArea(source) then 
					if weapon ~= 34 or bodypart ~= 9 then
						cancelEvent()
					end
					if getElementData(source, "protected") then
						cancelEvent()
					end
				end
			end
		end
	end
)


addEventHandler( "onClientProjectileCreation", root, 
	function (creator) 
		if getElementDimension(creator) == 2 then
			if isElement(source) then
				destroyElement( source )

			end
		end
	end
)

addEventHandler("onClientPlayerWeaponSwitch",root,
	function( prevSlot, newSlot )
		if getElementDimension(localPlayer) ~= 2 then return false end
		--if getPedWeapon( localPlayer ) ~= 34 then
		if newSlot ~= 34 then
			--cancelEvent()
			setPedWeaponSlot( localPlayer, 6)
		end
	end
)




bindKey( "f2", "down",
	function()
		isOpen = not isOpen
		if isOpen then
			isOpen = true
			addEventHandler("onClientRender", root,render)
		else
			isOpen = false
			removeEventHandler("onClientRender", root,render)
		end
	end
)


--
    function render()
        if getElementDimension( localPlayer ) ~= 2 then return false end
        if not isOpen then return false end
        dxRectangle(7, 181, 377, 356, tocolor(0, 0, 0, 175), false)
        dxText("Top PVP Stats", 7, 181, 384, 230, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
        dxLine(7, 230, 384, 230, tocolor(9, 130, 253, 175), 3, false)
        dxText("Top killers", 7, 229, 194, 278, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
        dxText("Top deaths", 195, 229, 382, 278, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
        dxLine(7, 278, 384, 278, tocolor(9, 130, 253, 175), 3, false)
        dxLine(193, 230, 193, 540, tocolor(9, 130, 253, 175), 3, false)
        
        local xy = -  51
        local slot = 0

       	for i, v in pairs ( sortKills() ) do
       		slot = slot + 1
       		if slot <= 5 then
	        	xy = xy + 51
	        	if v[2] and v[1] then
	        		textKill = ("( "..tonumber( v[2] ).." ) | "..getPlayerName( ( v[1] ) ) ) 
	        	else
	        		textKill = "( N/A ) | N/A"
	        	end
	        	if v[1] == (localPlayer) then
		        	dxRectangle(8, 280+xy, 182, 49, tocolor(0, 0, 0, 175), false)
		        	dxText(textKill , 9, 280+xy, 191, 331+xy, tocolor(9, 130, 253, 255), 1.1, "default-bold", "center", "center", false, false, false, false, false)
        		else
        			dxRectangle(8, 280+xy, 182, 49, tocolor(0, 0, 0, 175), false)
	        		dxText(textKill , 9, 280+xy, 191, 331+xy, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
        		end
        	end
        end
		local xx = -  51
        local slot2 = 0
        for i, v in pairs ( sortDeath() ) do
        	slot2 = slot2 + 1
        	if slot2 <= 5 then
        		if v then
					textDeath = ("( "..tonumber( v[2] ).." ) | "..getPlayerName( ( v[1] ) ) )
	        	else
	        		textDeath =  "( N/A ) | N/A"
	        	end
	        	local xx = xx + 51
	        	if v[1] == localPlayer then
					dxRectangle(196, 280+xx, 187, 49, tocolor(0, 0, 0, 175), false)
			        dxText(textDeath, 199, 280+xx, 381, 331+xx, tocolor(9, 130, 253, 255), 1.1, "default-bold", "center", "center", false, false, false, false, false)
	    		else
	    			dxRectangle(196, 280+xx, 187, 49, tocolor(0, 0, 0, 175), false)
			        dxText(textDeath, 199, 280+xx, 381, 331+xx, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
	    		end
	    	end
	    end
    end

fileDelete("c.lua")