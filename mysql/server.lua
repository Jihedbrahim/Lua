local hostType = "mysql"
local dbname = "mta"
local host = "127.0.0.1"
local user = "root"
local pass = ""

local connection = false

addEventHandler("onResourceStart", resourceRoot,
	function()
		connection = dbConnect(hostType, "dbname="..dbname..";host="..host, user, pass)
		
		if ( connection ) then
			outputDebugString("Server is now connected to SQL database!", 3, 0, 255, 0)
			return true
		else
			outputDebugString("Connection with SQL database is failed!", 3, 255, 0,0)
			return false
		end
	end
)

function getDatabase()
	if ( connection ) then
		return connection 
	else
		return false
	end
end

function DatabaseExec(...)
	if ( connection ) then
		return dbExec(connection, ...)
	else
		return false
	end
end

function DatabaseQuery(...)
	if ( connection ) then
		local query = dbQuery(connection, ...)
		return dbPoll(query, -1)
	else
		return false
	end
end
