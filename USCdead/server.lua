addEvent("removePedFromVehicle", true)
addEvent("spawnPlayer", true)
blip = {}

local marker = createMarker(150,245,30, "cylinder", 1.5, 255, 255, 0)

addEventHandler("removePedFromVehicle", root,
	function(seat)
		removePedFromVehicle( source )
	end
)

addEventHandler("spawnPlayer", root,
	function()
		if ( getPlayerMoney( source ) >= 4000 ) then
			takePlayerMoney( source, 4000)
		end

		local x, y, z, rot = 0,0 ,5, 0
		local modelID = getElementModel(source)
		setElementData(source, "isDeath", false)
		spawnPlayer(source, x, y, z, rot, modelID, 0,0)
		setCameraTarget( source )
		setElementModel(source, modelID)
		setElementHealth(source, 100)
		setElementDimension( source, 0)
		setElementInterior(source, 0)
		triggerClientEvent(source, "cancelEffects", source)
		if isElement(blip[source]) then
			destroyElement(blip[source])
		end

	end
)		

addEventHandler("onPlayerWasted", root,
	function()
		for _, v in ipairs ( getElementsByType("player")) do
			if isPlayerAllowedHere(v) then
				blip[source]  = createBlipAttachedTo( source, 22, 2, 255, 0, 0, 255, 0, 275, v)
			end
		end
	end
)

addEventHandler( "onMarkerHit", root, 
	function (hitElement, matchingDimension) 
		if ( hitElement ) and ( getElementType(hitElement) == "player" ) then
			if ( source == marker ) and matchingDimension then
				if ( getElementData( hitElement, "isDeath" ) ) then
					for _, p in ipairs ( getElementsByType("player") ) do
						if not isPlayerAllowedHere(p) and hitElement ~= p then
							if getPlayerMoney(hitElement) >= 5000 then
								triggerEvent( "spawnPlayer", hitElement )
								takePlayerMoney(hitElement, 5000)
							else
								outputChatBox("you dont have enough money to be healed", hitElement, 255,0,0)
								return false
							end
						else
							outputChatBox("there's medic online can heal you", hitElement, 255, 0,0)
							return false
						end
					end
				else
					outputChatBox("this marker only for dead people to be healed", hitElement, 255, 0,0)
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end
)


function isPlayerAllowedHere(player)
	local groups = "Admin"
	if not isPlayerInACLGroup(player, tostring(groups) ) then
		return false
	end
	return true
end

function isPlayerInACLGroup(player, groupName)
	local account = getPlayerAccount(player)
	if not account then
		return false
	end
	local accountName = getAccountName(account)
	for _,name in ipairs(split(groupName,',')) do
		local group = aclGetGroup(name)
		if group then
			for i,obj in ipairs(aclGroupListObjects(group)) do
				if obj == 'user.' .. accountName then
					return true
				end
			end
		end
	end
	return false
end
