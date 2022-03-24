--[[

  ESX RP Chat

--]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end

AddEventHandler('chatMessage', function(source, name, message)
    if string.sub(message, 1, string.len("/")) ~= "/" then
        local name = getIdentity(source)
      TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, message)
    end
    CancelEvent()
end)

AddEventHandler('chatMessage', function(source, name, message)
    if string.sub(message, 1, string.len("/")) == "/" and string.sub(message, 1, string.len("/ool")) == "/ool" then
        local name = GetPlayerName(source)
        local _message = message:gsub("/ool", "")
        TriggerClientEvent('poke_rpchat:sendProximityMessageB', -1, source, 'Lokal OOC '..name, _message, {128, 128, 128})
    end
    CancelEvent()
end)


--  AddEventHandler('chatMessage', function(source, name, message)
--       if string.sub(message, 1, string.len("/")) ~= "/" then
--           local name = getIdentity(source)
-- 		TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, message)
--       end
--       CancelEvent()
--   end)
  
  -- TriggerEvent('es:addCommand', 'me', function(source, args, user)
  --    local name = getIdentity(source)
  --    TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
  -- end) 



  --- TriggerEvent('es:addCommand', 'me', function(source, args, user)
  ---    local name = getIdentity(source)
  ---    TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
  -- end) 
  TriggerEvent('es:addCommand', 'me', function(source, args, user)
    local name = getIdentity(source)
    table.remove(args, 2)
    TriggerClientEvent('esx-qalle-chat:me', -1, source, name.firstname, table.concat(args, " "))
end)

--[[RegisterCommand('tweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
        args = { fal, msg }
    })
end, false)]]

--  RegisterCommand('anontweet', function(source, args, rawCommand)
--     local playerName = GetPlayerName(source)
--     local msg = rawCommand:sub(11)
--     local name = getIdentity(source)
--     fal = name.firstname .. " " .. name.lastname
--     TriggerClientEvent('chat:addMessage', -1, {
--         template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @Ukendt:<br> {1}</div>',
--         args = { fal, msg }
--     })
-- end, false)


TriggerEvent('es:addCommand', 'ool', function(source, args, user)
    table.remove(args, 1)
    local pname = GetPlayerName(source)
    TriggerClientEvent("sendProximityMessageB", -1, source, pname, table.concat(args, " "))
end, function(source, args, user)
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end)

RegisterCommand('ad', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; background-color: rgba(214, 168, 0, 1); border-radius: 6px; display: inline-block; max-width: 500px; word-break: break-word;"><i class=""></i> Reklame @{0}: {1}</div>',
        args = { fal, msg }
    })
end, false)

RegisterCommand('pa', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(4)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(9, 41, 69, 1); border-radius: 3px;"><i class="fas fa-star"></i> Politi:<br> {1}<br></div>',
            args = { fal, msg }
        })
    end
end, false)

RegisterCommand('tweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 6px; display: inline-block; max-width: 500px; word-break: break-word;"><i class="fab fa-twitter        "></i> Twitter @{0}: {1}</div>',
        args = { fal, msg }
    })
end, false)


RegisterCommand('ooc', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    local name = getIdentity(source)

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; background-color: rgba(41, 41, 41, 0.8); border-radius: 6px; display: inline-block; max-width: 500px; word-break: break-word;"><i class="fas fa-globe"></i> OOC @{0}: {1}</div>',
        args = { playerName, msg }
    })
end, false)


RegisterCommand('staff', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getGroup() ~= 'user' then
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(5)
        local name = getIdentity(source)
        fal = name.firstname .. " " .. name.lastname
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; background-color: rgba(204, 27, 86); border-radius: 6px; display: inline-block; max-width: 500px; word-break: break-word;"><i class="fas fa-globe"></i> STAFF @{0}: {1}</div>'            ,
            args = { fal, msg }
        })
    end
end, false)


RegisterServerEvent('gcPhone:twitter_postTweets')
AddEventHandler('gcPhone:twitter_postTweets', function(username, password, message)
  local _source = source
  local sourcePlayer = tonumber(_source)
  local srcIdentifier = ESX.GetPlayerFromId(_source).identifier
  fal = name.firstname .. " " .. name.lastname
  TwitterPostTweet(username, password, message, sourcePlayer, srcIdentifier)
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
    args = { username, message }
})
end)


function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
