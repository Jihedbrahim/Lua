vehicleSpawn = {
    {vehShop="Downtown SF",x=-1634.832, y=1202.064, z=6.772, rot=248.040},
    {vehShop="Wang Shop",x=-1971.143, y=299.172, z=34.759, rot=87.053},

    {vehShop="Garcia SF",x=-2239.643, y=101.663, z=35.358,rot=87.251},

    {vehShop="Airport SF", x=-1435.465, y=-534.226, z=15.020, rot=206.824},
    {vehShop="Angel Pine",x=-1986.498, y=-2435.444, z=30.654, rot=230.609},
    {vehShop="Tierra Robada", x=-2213.987, y=2412.498, z=0.803, rot=44.72},
}


function getSpawnLocation(loc)
    for i, v in ipairs ( vehicleSpawn ) do
        if v.vehShop == loc then
            return v.x, v.y, v.z, v.rot
        end
    end
end

pVehicle = {}
vehicles = {}
addEvent("onPlayerRequestPurchase", true)
    addEventHandler("onPlayerRequestPurchase", root, 
    function (vehicle, price, location)
        if vehicle and price and location then
            if getPlayerMoney (source) >= price then
                local query = dbQuery(db, "SELECT id FROM vehicles")
                local tables = dbPoll(query, -1)
                id = math.random(0, 999999999)
                local ids = {}

                for i, v in ipairs ( tables ) do 
                    ids[v["id"]] = true 
                end


                if ( q and type ( tables ) == "table" ) then
                    for _, v in pairs ( q ) do 
                        ids[v.id] = true
                    end
                end
                while ( ids[id] ) do 
                    id = math.random ( 0, 999999999 );
                end

                takePlayerMoney( source, price )
                local x, y, z, rot = getSpawnLocation(location)
                
                

                vehicles[id] = createVehicle(vehicle, x, y, z,0,0, rot)
                createPlayerVehicle(source, vehicle, 1000, price, x, y, z, rot, id )
                warpPedIntoVehicle( source, vehicles[id], 0 )
                outputChatBox( "You have bought "..getVehicleNameFromModel(vehicle), source, 0, 255, 0)
                setElementData(vehicles[id], "Owner", source)  
                setElementData(vehicles[id], "vehicleOwnerAccount",getAccountName ( getPlayerAccount ( source ) ) )
            else
                 outputChatBox("You dont have enought money to buy "..getVehicleNameFromModel(vehicle),source, 255, 0, 0) 
            end
        end
    end
)

function createPlayerVehicle(player, vehicle, health, boughtprice, posX, posY, posZ, rotation,id, locked, color)
    dbExec(db, "INSERT INTO `vehicles` (vehicleid, owner, health, boughtprice, posX, posY, posZ, rotation, locked, color, accountname, spawned, id) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
           vehicle, getPlayerName(player), 1000, boughtprice, posX, posY, posZ, rotation, locked, color, getAccountName( getPlayerAccount( player)), 1, id  )
end

function getPlayerVehicles(player)
    local cars = { }
    local query = dbQuery(db, "SELECT * FROM vehicles WHERE accountname=?", getAccountName( getPlayerAccount( player)))
    local tables = dbPoll(query, -1)
    for i, v in ipairs ( tables ) do
    table.insert(cars, v)
    end
    return cars
end


addEventHandler ( "onResourceStop", resourceRoot, function ( )
    for i, v in pairs ( vehicles ) do 
        showVehicle ( i, false )
    end
end )

function destroyAccountVehicles ( acc )
    for i, v in pairs ( vehicles ) do 
        if ( tostring ( getElementData ( v, "vehicleOwnerAccount" ) ) == acc ) then
            showVehicle ( i, false )
        end
    end
end
addEventHandler ( "onPlayerLogout", root, function ( acc ) destroyAccountVehicles ( acc ) end )
addEventHandler ( "onPlayerQuit", root, function ( ) if ( isGuestAccount(  getPlayerAccount ( source ) ) ) then return end destroyAccountVehicles ( getAccountName ( getPlayerAccount ( source ) ) ) end )



addCommandHandler( "cd", function(player)
    
        iprint( getPlayerVehicles(player))
end
)
