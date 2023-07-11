isValidAccount = {}
loggedInAccount = {}
addEvent("onClientLoginAttempt", true)
addEvent("onClientRegisterAttempt", true)

addEventHandler("onClientLoginAttempt", root,
	function(username, password)
		if ( not exports.mysql:getDatabase() ) then
			outputDebugString("Failed to connect with SQL!", 3, 255, 0 ,0)
			return false
		end
		if ( not username or not password ) then
			return false
		end

		local accountID = false
		local q = exports.mysql:DatabaseQuery("SELECT accountID FROM accounts WHERE username=? LIMIT 1",( username))
		if ( q and #q == 1 ) then
			accountID = q[1].accountID
		end
		if ( not accountID ) then
			outputChatBox("this username doesnt exist", source, 255, 0, 0)
			return false
		end

		local query = exports.mysql:DatabaseQuery("SELECT accountID FROM accounts WHERE accountID = ? AND password = ? LIMIT 1",
			accountID, password)
		if ( #query == 1 ) then
			if ( loggedInAccount[username] == nil ) then
				loggedInAccount[username] = true
			elseif ( loggedInAccount[username] == true ) then
				return false
			end
		end
		logIn(source, getAccount(username), password)
		
		local account = exports.mysql:DatabaseQuery("SELECT * FROM accounts WHERE accountID = ? LIMIT 1",accountID)

		setElementData( source, "accountID", accountID)
		setElementData( source, "email", account[1].email)
		setElementData( source, "language", account[1].language)
		setElementData( source, "serial", getPlayerSerial(source))
		setElementData( source, "IP", getPlayerIP(source))
		setElementData( source, "playtime", account[1].playtime)
		setElementData( source, "registrationData", account[1].registrationDate)
		setElementData( source, "joinTime", getRealTime().timestamp)

		setElementData( source, "adminLevel", account[1].adminLevel)
		setElementData( source, "helperLevel", account[1].helperLevel)
		
		setElementData( source, "isPlayerLoggedin", true)
		spawnClient(source, account[1])

		triggerEvent("onClientPlayerLogin", source, username, accountID)
		triggerClientEvent(source, "onClientSpawn", source)
		
	end
)

addEventHandler("onClientRegisterAttempt", root,
	function(user, password, email)
		
		if (  #exports.mysql:DatabaseQuery("SELECT username FROM accounts WHERE username=?", string.lower(user))>=1) then
			outputChatBox("this username is already taken by someone else!", source, 255, 0,0 )
		elseif ( #exports.mysql:DatabaseQuery("SELECT * FROM accounts WHERE serial=? LIMIT 1", getPlayerSerial(source) ) >=1 ) then
			outputChatBox("you can only register one account per serial", source, 255, 0, 0)
		else
			
		 exports.mysql:DatabaseExec("INSERT INTO `accounts` (username,password,email,serial,registrationDate) VALUES (?,?,?,?,?)", string.lower(user), sha256( password ), email, getPlayerSerial(source), getRealTime().timestamp)
				triggerClientEvent(source, "setLoginVisible", source)
				addAccount( user, password)
		end

	end
)		


addEventHandler( "onPlayerJoin", root, 
	function () 
		if ( #exports.mysql:DatabaseQuery("SELECT * FROM accounts WHERE serial=? LIMIT 1", getPlayerSerial(source) ) >=1 ) then
			triggerClientEvent(source, "setPanelVisible", source, "login")
		else
			triggerClientEvent(source, "setPanelVisible",source, "register")
		end
	end
)

function spawnClient(p, data)
	if ( isElement( p )  and getElementType( p ) == "player" and data ) then
		if getElementData(p, "isPlayerLoggedin") then
			setCameraTarget(p, p)
			showChat(p,true)
			
			local pos = fromJSON(data.position)
			if ( pos ) then 
				local skinID = 0
				spawned = spawnPlayer(p, pos.x, pos.y, pos.z+1, pos.rotation, skinID)
				setElementDimension(p, pos.dim)
				setElementInterior(p, pos.int)
			end

			
			setPlayerMoney(p, data.money)
			setCameraTarget( p, p )
			showChat( p, true )
			setPlayerHudComponentVisible ( p, "radar", true )
			setPlayerHudComponentVisible ( p, "area_name", true )
			if ( data.health == 0 ) then
				killPed(p)
			else
				setElementHealth( p, data.health)
			end	
			setPedArmor(p, data.armor)
			setElementData(p, "WL", data.wanted)
		end
	end
end

addEventHandler("onPlayerQuit", root,
	function()

		local x, y, z = getElementPosition(source)
		local _,_,rotation = getElementRotation(source)
		local int, dim = getElementInterior(source), getElementDimension(source)
		local position = toJSON({x=x, y=y, z=z, rotation=rotation, dim=dim, int=int})
		exports.mysql:DatabaseExec("UPDATE accounts SET position = ?, money=?, health=?, armor=? WHERE accountID=?", position, getPlayerMoney( source), getElementHealth(source), getPedArmor(source),getElementData(source, "accountID"))
end
)


addEventHandler("onResourceStart", root,
	function()
		setGameType( "RPG V1")
		setElementData(root, "serverName", getServerName())
		setElementData(root, "maxPlayers", getMaxPlayers())
		setTime( getRealTime().hour, getRealTime().minute )
		setMinuteDuration( 60000 )
		setOcclusionsEnabled( false )
	end
)
addEventHandler( "onPlayerConnect", root,
function ( _, _, _, serial)
	for _, p in pairs ( getElementsByType ( "player" ) ) do
		if ( getPlayerSerial( p ) == serial ) then
			cancelEvent( true)
			return
		end
	end
end
)

addEventHandler("onPlayerJoin", root,
	function()
		local p = source
		if ( spawnPlayer( p, 0, 0, 0 ) ) then
			setCameraTarget ( p )
			fadeCamera( p, true, 1.0, 0, 0, 0 )
			setPlayerHudComponentVisible ( p, "radar", true )
			setPlayerHudComponentVisible ( p, "area_name", true )
			setElementDimension(source, 6000+math.random(3000))
			showChat(p, false)
		end
	end
	)