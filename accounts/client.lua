screen = {guiGetScreenSize()}
iW, iH = 391, 256
local maximumLetter = 20

userRegister = 0.9
PassRegister = 0.9
emailSize = 0.9
userSize = 0.9
passSize = 0.9


-- Current Editing
local actualEditing = ""
local actualTyping = ""

-- Login Edits
local usernameEditBoxLogin = ""
local usernameEditBoxRegister = ""
local passwordEditBoxLogin = ""
local passwordEditBoxRegister = ""
local emailEditBoxRegister = ""
 
--Font files
local Font = dxCreateFont("files/roboto.ttf", 16)

local isLoginScreenVisible = true
local isRegisterScreenVisible = false
local cursorTick = false
local lastCursorTick = 0

function onClientType(char)
	if ( actualEditing == "username" ) then
		maximumLetter = 20
	end

	if ( utf8.len(actualTyping) <= maximumLetter ) then
		actualTyping = actualTyping..char
	end
end
addEventHandler( "onClientCharacter", root, onClientType)

function onClientClick(button, pressState)
	
	if ( not pressState ) then 
		return 
	end
	
	if ( button ~= "mouse1" and button ~= "backspace" ) then
		return false
	end

	if ( button == "mouse1" ) then
		actualEditing = ""
		-- 1280, 800
		--  640, 400
		if isLoginScreenVisible then
			if isCursorOverText(screen[1]/2-181, screen[2]/2-111, screen[1]/2+184, screen[2]/2-70) then

				actualEditing = "username"
				actualTyping = usernameEditBoxLogin
			elseif isCursorOverText(screen[1]/2-181, screen[2]/2-54, screen[1]/2+184, screen[2]/2-13) then
				actualEditing = "password"
				actualTyping = passwordEditBoxLogin
			elseif isCursorInPosition(screen[1]/2-177, screen[2]/2+49, screen[1]/2-285, screen[2]/2-346) then
				loginAction("login")

			end
			iprint(actualEditing)
		end

		-- username :  462, 283, 816, 320
			-- password :  462, 334, 816, 371
			-- email : 462, 382, 816, 419
		if isRegisterScreenVisible then
			if isCursorOverText(screen[1]/2-178, screen[2]/2-117, screen[1]/2+176, screen[2]/2-80) then
				actualEditing = "UserRegister"
				actualTyping = usernameEditBoxRegister
			elseif isCursorOverText(screen[1]/2-178, screen[2]/2-66, screen[1]/2+176, screen[2]/2-29) then
				actualEditing = "PassRegister"
				actualTyping = passwordEditBoxRegister
			elseif isCursorOverText(screen[1]/2-178, screen[2]/2-18, screen[1]/2+176, screen[2]/2+19) then
				actualEditing = "email"
				actualTyping = emailEditBoxRegister
			elseif isCursorInPosition(screen[1]/2-178, screen[2]/2+71, screen[1]/2-284, screen[2]/2-358) then
				loginAction("register")
			end
		end


	end

	if ( button == "backspace" ) then
		if ( utf8.len(actualTyping) ) >= 1 then
			actualTyping = utf8.sub(actualTyping, 1, utf8.len(actualTyping)-1)
		end
	end
end
addEventHandler("onClientKey", root, onClientClick)


	function renderLoginPanel()
		local tick = getTickCount() - lastCursorTick
		if tick >= 400 then
			cursorTick = not cursorTick
			lastCursorTick = getTickCount()
		end

		if isRegisterScreenVisible then

			dxDrawImage((screen[1]/2)-(iW/2), (screen[2]/2)-(iH/2), (iW), (iH), "files/register panel.png")
			if ( actualEditing == "UserRegister") then
				usernameEditBoxRegister = actualTyping
				if cursorTick then
					local wid = dxGetTextWidth( usernameEditBoxRegister, userRegister, Font)
					dxDrawLine(screen[1]/2-56+wid, screen[2]/2-109, screen[1]/2-56+wid, screen[2]/2-87, tocolor(66, 66, 66, 255), 2, false)
	    		end
	    	end

	    	
			if ( isCursorOverText(screen[1]/2-178, screen[2]/2-117, screen[1]/2+176, screen[2]/2-80) or actualEditing == "UserRegister" ) then
				userRegister = 1
				dxDrawText("Username : "..usernameEditBoxRegister, screen[1]/2-178, screen[2]/2-117, screen[1]/2+176, screen[2]/2-80, tocolor(0, 0, 0, 255), userRegister, Font, "left", "center", false, false, true, false, false)
	        	
	        else
	        	userRegister = 0.9
	        	dxDrawText("Username : "..usernameEditBoxRegister, screen[1]/2-178, screen[2]/2-117, screen[1]/2+176, screen[2]/2-80, tocolor(0, 0, 0, 255), userRegister, Font, "left", "center", false, false, true, false, false)
	        end	
			
			actualRegisterPassword = passwordEditBoxRegister
	    	local hiddenPassword = ""
	    	for i=1, #actualRegisterPassword do
	    		hiddenPassword = hiddenPassword.."*"
	    	end

	    	if ( actualEditing == "PassRegister") then
				passwordEditBoxRegister = actualTyping
				if cursorTick then
					local wid = dxGetTextWidth( hiddenPassword, PassRegister, Font)
					dxDrawLine(screen[1]/2-58+wid, screen[2]/2-59, screen[1]/2-58+wid, screen[2]/2-37, tocolor(66, 66, 66, 255), 2, false)
	    		end
	    	end
	        if ( isCursorOverText(screen[1]/2-178, screen[2]/2-66, screen[1]/2+176, screen[2]/2-29) or actualEditing == "PassRegister" ) then
				PassRegister = 1
				dxDrawText("Password : "..hiddenPassword, screen[1]/2-178, screen[2]/2-66, screen[1]/2+176, screen[2]/2-29, tocolor(0, 0, 0, 255), PassRegister, Font, "left", "center", false, false, true, false, false)
	        else
	        	PassRegister = 0.9
	        	dxDrawText("Password : "..hiddenPassword, screen[1]/2-178, screen[2]/2-66, screen[1]/2+176, screen[2]/2-29, tocolor(0, 0, 0, 255), PassRegister, Font, "left", "center", false, false, true, false, false)
	        end		        	


	        if ( actualEditing == "email") then
				emailEditBoxRegister = actualTyping
				if cursorTick then
					local wid = dxGetTextWidth( emailEditBoxRegister, emailSize, Font)
					dxDrawLine(screen[1]/2-105+wid, screen[2]/2-8, screen[1]/2-105+wid, screen[2]/2+14, tocolor(66, 66, 66, 255), 2, false)
	    		end
	    	end

	        if ( isCursorOverText( screen[1]/2-178, screen[2]/2-18, screen[1]/2+176, screen[2]/2+19 ) or actualEditing == "email") then
	        	emailSize = 1
	        	dxDrawText("Email : "..emailEditBoxRegister,  screen[1]/2-178, screen[2]/2-18, screen[1]/2+176, screen[2]/2+19 , tocolor(0, 0, 0, 255), emailSize, Font, "left", "center", false, false, true, false, false)
	        else
	        	emailSize = 0.9
	        	dxDrawText("Email : "..emailEditBoxRegister,  screen[1]/2-178, screen[2]/2-18, screen[1]/2+176, screen[2]/2+19 , tocolor(0, 0, 0, 255), emailSize, Font, "left", "center", false, false, true, false, false)
	        end	

		end
		--dxDrawRectangle(0, 0, screen[1], screen[2], tocolor(0, 0,0, 175), false)
		if isLoginScreenVisible then

			if isCursorInPosition(screen[1]/2-177, screen[2]/2+49, screen[1]/2-285, screen[2]/2-346) then
				dxDrawImage( (screen[1]/2)-(iW/2), (screen[2]/2)-(iH/2), (iW), (iH), "files/new login.png")
			else 
				dxDrawImage( (screen[1]/2)-(iW/2), (screen[2]/2)-(iH/2), (iW), (iH), "files/new login hover.png")
			
			end


			if ( actualEditing == "username") then
				usernameEditBoxLogin = actualTyping
				if cursorTick then
					local wid = dxGetTextWidth( usernameEditBoxLogin, userSize, Font)
					dxDrawLine(screen[1]/2-58+wid, screen[2]/2-104, screen[1]/2-58+wid, screen[2]/2-77, tocolor(66, 66, 66, 255), 2, false)
	    		end
	    	end

	    	actualPassword = passwordEditBoxLogin
	    	local hiddenPassword = ""
	    	for i=1, #actualPassword do
	    		hiddenPassword = hiddenPassword.."*"
	    	end

	    	if ( actualEditing == "password" ) then
	    		passwordEditBoxLogin = actualTyping
	    		if cursorTick then
	    			local wid = dxGetTextWidth( hiddenPassword, passSize, Font)
	    			dxDrawLine(screen[1]/2-62+wid, screen[2]/2-45, screen[1]/2-62+wid, screen[2]/2-18, tocolor(66, 66, 66, 255), 2, false)

	    		end
	    	end

			if isCursorOverText( screen[1]/2-181, screen[2]/2-111, screen[1]/2+184, screen[2]/2-70) or actualEditing == "username" then
				userSize = 1
				dxDrawText("Username : "..usernameEditBoxLogin, screen[1]/2-181, screen[2]/2-111, screen[1]/2+184, screen[2]/2-70, tocolor(0, 0, 0, 255), userSize, Font, "left", "center", false, false, true, false, false)
	        else
	        	userSize = 0.9
	        	dxDrawText("Username : "..usernameEditBoxLogin, screen[1]/2-181, screen[2]/2-111, screen[1]/2+184, screen[2]/2-70, tocolor(0, 0, 0, 255), userSize, Font, "left", "center", false, false, true, false, false)
	        end	

	        if isCursorOverText( screen[1]/2-181, screen[2]/2-54, screen[1]/2+184, screen[2]/2-23) or actualEditing == "password" then
	        	passSize = 1
	        	dxDrawText("Password : "..hiddenPassword, screen[1]/2-181, screen[2]/2-42, screen[1]/2+184, screen[2]/2-23, tocolor(0, 0, 0, 255), passSize, Font, "left", "center", false, false, true, false, false)
	    	else
	    		passSize = 0.9
	    		dxDrawText("Password : "..hiddenPassword, screen[1]/2-181, screen[2]/2-42, screen[1]/2+184, screen[2]/2-23, tocolor(0, 0, 0, 255), passSize, Font, "left", "center", false, false, true, false, false)
	    	end
	    end
	end
	

function loginAction(action)
	if isClientSpam() or not getNetworkStatus() then
		return false
	end
	if action ~= "login" and action ~= "register" then
		return false
	end

	if ( action == "login") then
		local username = usernameEditBoxLogin
		local password = passwordEditBoxLogin

		if ( utf8.len( username )  <= 3 ) then
			outputChatBox("Username can not be lower than 3", 255, 0,0)
		elseif ( utf8.len( password ) ) < 7 then
			outputChatBox("Password should be higher than 7", 255, 0, 0)
		elseif ( utf8.find( username, ";", 0) or utf8.find( username, "/", 0) or utf8.find( username, "'", 0) or utf8.find( username, "?", 0) or utf8.find( username, "!", 0) or utf8.find( username, ",", 0) or utf8.find( username, "@", 0) or utf8.find( username, "#", 0) ) then
			outputChatBox("Username shouldnt contain special character!", 255, 0,0)
		else
			triggerServerEvent("onClientLoginAttempt", getLocalPlayer(), username, password)
		end
	else
		local username = usernameEditBoxRegister
		local password = passwordEditBoxRegister
		local email = emailEditBoxRegister
		if ( utf8.len( username )  <= 3 ) then
			outputChatBox("Username can not be lower than 3", 255, 0,0)
		elseif ( utf8.len( password ) ) < 7 then
			outputChatBox("Password should be higher than 7", 255, 0, 0)
		elseif ( utf8.find( username, ";", 0) or utf8.find( username, "/", 0) or utf8.find( username, "'", 0) or utf8.find( username, "?", 0) or utf8.find( username, "!", 0) or utf8.find( username, ",", 0) or utf8.find( username, "@", 0) or utf8.find( username, "#", 0) ) then
			outputChatBox("Username shouldnt contain special character!", 255, 0,0)
		elseif ( not utf8.find( email, "@", 0) ) then
			outputChatBox("you have entered invalid email!", 255, 0,0)
		else
			triggerServerEvent("onClientRegisterAttempt", getLocalPlayer(), username, password, email)	
		end
	end
end

addEvent("setLoginVisible", true)
addEventHandler("setLoginVisible",root,
	function()
		if isRegisterScreenVisible then
			isRegisterScreenVisible = false
			isLoginScreenVisible = true
		end
	end
)

addEvent("setPanelVisible", true)
addEventHandler("setPanelVisible", root,
	function(p)
		if (p == "register") then
			isRegisterScreenVisible = true
			isLoginScreenVisible = false
			showCursor( true )
			showChat( false )

		elseif (p == "login" ) then
			isRegisterScreenVisible = false
			isLoginScreenVisible = true
			showCursor( true )
			showChat( false )
		end
		addEventHandler("onClientRender", root, renderLoginPanel)
	end
)

--[[
bindKey("n", "down",
	function()
		iprint(getElementData(localPlayer, "accountID"))
	end
	)
]]
addEvent("onClientSpawn", true)
addEventHandler("onClientSpawn", root,
	function()
		isRegisterScreenVisible = false
		isLoginScreenVisible = false
		showCursor( false )
		showChat( true )
		removeEventHandler("onClientRender", root, interpolateCam)
		removeEventHandler("onClientRender", root, renderLoginPanel)
	end
)

function renderServerInfo()
local text = getElementData(root, "serverName").. " | "..#getElementsByType("player").."/"..getElementData(root, "maxPlayers").." Players | "
	dxDrawText(text, screen[1]-88,screen[2],screen[1]-88,screen[2], tocolor(255,255,255,100), 1, "default", "right", "bottom")
end
addEventHandler("onClientRender", root, renderServerInfo)