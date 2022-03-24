ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("jail", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)


	if xPlayer["job"]["name"] == "police" then

		local jailPlayer = args[1]
		local jailTime = tonumber(args[2])
		local jailReason = args[3]
		local TargetPlayer = ESX.GetPlayerFromId(jailPlayer)

		if GetPlayerName(jailPlayer) ~= nil then

			if jailTime ~= nil then
				JailPlayer(jailPlayer, jailTime)
				TriggerClientEvent("esx:showNotification", src, TargetPlayer.getName() .. " blev fængslet i " .. jailTime .. " minutter!")
				
				if args[3] ~= nil then
					GetRPName(jailPlayer, function(Firstname, Lastname)
						TriggerClientEvent('chat:addMessage', -1, { args = { "JUDGE",  Firstname .. " " .. Lastname .. " Is now in jail for the reason: " .. args[3] }, color = { 249, 166, 0 } })
					end)
				end
			else
				TriggerClientEvent("esx:showNotification", src, "Denne tid er ugyldig!")
			end
		else
			TriggerClientEvent("esx:showNotification", src, "Dette ID er ikke online!")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "Du er ikke betjent!")
	end
end)

RegisterCommand("unjail", function(src, args)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" then

		local jailPlayer = args[1]

		if GetPlayerName(jailPlayer) ~= nil then
			UnJail(jailPlayer)
		else
			TriggerClientEvent("esx:showNotification", src, "Dette ID er ikke online!")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "Du er ikke betjent!")
	end
end)

RegisterServerEvent("esx2-qalle-jail:jailPlayer")
AddEventHandler("esx2-qalle-jail:jailPlayer", function(targetSrc, jailTime, jailReason, src)
    local src = source
    local targetSrc = tonumber(targetSrc)
    local xPlayer = ESX.GetPlayerFromId(src)
	local TargetPlayer = ESX.GetPlayerFromId(targetSrc)

    if xPlayer["job"]["name"] == "police" then
        JailPlayer(targetSrc, jailTime)

        GetRPName(targetSrc, function(Firstname, Lastname)
            -- TriggerClientEvent('chat:addMessage', -1, { args = { "Unity",  Firstname .. " " .. Lastname .. " Blev fængslet for : " .. jailReason }, color = { 249, 166, 0 } })
        end)

        TriggerClientEvent("esx:showNotification", src, TargetPlayer.getName() .. " fængslet i " .. jailTime .. " minutter!")
    else
        TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: Mass jail", source)
    end
end)

RegisterServerEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function(targetIdentifier)
	local src = source
	local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)

	if xPlayer ~= nil then
		UnJail(xPlayer.source)
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
	end

	TriggerClientEvent("esx:showNotification", src, xPlayer.name .. " er nu løsladt!")
end)

RegisterServerEvent("esx-qalle-jail:updateJailTime")
AddEventHandler("esx-qalle-jail:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("esx-qalle-jail:prisonWorkReward")
AddEventHandler("esx-qalle-jail:prisonWorkReward", function()
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)

	-- xPlayer.addMoney(math.random(1300, 2100))

	TriggerClientEvent("esx:reward", src)

	TriggerClientEvent("esx:showNotification", src, "Godt arbejde! Din straf er nedsat med 5 minutter.")
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("esx2-qalle-jail:jailPlayer", jailPlayer, jailTime)

	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx-qalle-jail:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			local Target = ESX.GetPlayerFromIdentifier(result[i].identifier)
			local retval = false
			if Target ~= nil then retval = true end
		
			if retval then
				online = "Online"
			else
				online = "Offline"
			end
			table.insert(jailedPersons, { name = result[i].firstname.. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier, status = online })
		end

		cb(jailedPersons)
		
	end)
end)

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].jail)

		if JailTime > 0 then

			cb(true, JailTime)
		else
			cb(false, 0)
		end

	end)
end)