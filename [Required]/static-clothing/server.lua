
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


AddEventHandler('esx:playerLoaded', function(source)
    if first_spawn then
		TriggerClientEvent('raid_clothes:FirstSpawn', source)
		TriggerClientEvent('raid_clothes:LoadShit', source)
		--TriggerEvent("raid_clothes:retrieve_tats")
	else
		TriggerClientEvent('raid_clothes:LoadShit', source)
		--TriggerEvent("raid_clothes:retrieve_tats")
    end
end)


RegisterServerEvent('raid_clothes:save')
AddEventHandler('raid_clothes:save', function(data)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET `skin` = @data WHERE identifier = @identifier',
	{
		['@data']       = json.encode(data),
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('raid_clothes:loadclothes')
AddEventHandler('raid_clothes:loadclothes', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		local user = users[1]
		local skin = nil

		if user.skin ~= nil then
			skin = json.decode(user.skin)
		end

		TriggerClientEvent('raid_clothes:loadclothes', skin)
	end)


end)

ESX.RegisterServerCallback('raid_clothes:getPlayerSkin', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		local user = users[1]
		local skin = nil


		if user.skin ~= nil then
			skin = json.decode(user.skin)
		end

		cb(skin)
	end)
end)

RegisterServerEvent("raid_clothes:retrieve_tats")
AddEventHandler("raid_clothes:retrieve_tats", function(pSrc)
    --local src = (not pSrc and source or pSrc)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
        MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
		if(#result == 1) then
			TriggerClientEvent("raid_clothes:settattoos", src, json.decode(result[1].tattoos))
		else
			local tattooValue = "{}"
            MySQL.Async.execute("INSERT INTO users (identifier, tattoos) VALUES  (@identifier, @tattoo)", {['@identifier'] = xPlayer.identifier, ['@tattoo'] = tattooValue})
            TriggerClientEvent("raid_clothes:settattoos", src, {})
		end
	end)
end)

RegisterServerEvent("raid_clothes:set_tats")
AddEventHandler("raid_clothes:set_tats", function(tattoosList)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
    --local char = getCurrentCharacter(user)
   -- print(user.identifier)
	--MySQL.Async.execute("UPDATE playerstattoos SET tattoos = @tattoos WHERE identifier = @identifier", {['@tattoos'] = json.encode(tattoosList), ['@identifier'] = user.identifier})
    MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
		['@tattoos'] = json.encode(tattoosList),
		['@identifier'] = xPlayer.identifier
	})

end)

RegisterNetEvent("static-clothing:getoutfits")
AddEventHandler("static-clothing:getoutfits", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
        TriggerClientEvent("static-clothing:sendoutfits", source, data[1].outfits)
    end)
end)

RegisterNetEvent("static-clothing:useoutfit")
AddEventHandler("static-clothing:useoutfit", function(outfit)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
		local Sets = json.decode(data[1].outfits) or {}
		if Sets[outfit] ~= nil then
			TriggerClientEvent("static-clothing:loadoutfit", source, Sets[outfit])
		else
			TriggerClientEvent("static-clothing:sendoutfits2", source, data)
			TriggerClientEvent("t-notify:client:Custom", source, {
				style = 'error',
				title = 'Fejl!',
				message = 'Der opstod en fejl, det ligner ikke at det outfit findes. Prøv venligst igen.',
				duration = 5000,
				position = 'bottom-center'
			})
		end
	end)
end)

RegisterNetEvent("static-clothing:savenewoutfit")
AddEventHandler("static-clothing:savenewoutfit", function(name, outfit)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if name ~= "" then
		MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
			local Sets = json.decode(data[1].outfits) or {}
			
			if Sets[name] == nil then
				Sets[name] = outfit
				local Sets2 = json.encode(Sets)
		MySQL.Async.execute('UPDATE users SET `outfits` = @data WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier, ['@data'] = Sets2})

				TriggerClientEvent("static-clothing:sendoutfits2", source, Sets2)
			else
				TriggerClientEvent("t-notify:client:Custom", source, {
					style = 'error',
					title = 'Fejl!',
					message = 'Du har allerede et outfit med det navn!',
					duration = 5000,
					position = 'bottom-center'
				})
			end
		end)
	else
		TriggerClientEvent("t-notify:client:Custom", source, {
			style = 'error',
			title = 'Fejl!',
			message = 'Du skal skrive et navn!',
			duration = 5000,
			position = 'bottom-center'
		})
	end
end)

RegisterNetEvent("static-clothing:overrideoutfit")
AddEventHandler("static-clothing:overrideoutfit", function(outfit, info)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
		local Sets = json.decode(data[1].outfits) or {}
		
		if Sets[outfit] ~= nil then
			Sets[outfit] = info
			local Sets2 = json.encode(Sets)
	MySQL.Async.execute('UPDATE users SET `outfits` = @data WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier, ['@data'] = Sets2})

			TriggerClientEvent("static-clothing:sendoutfits2", source, Sets2)
		else
			TriggerClientEvent("static-clothing:sendoutfits2", source, data)
			TriggerClientEvent("t-notify:client:Custom", source, {
				style = 'error',
				title = 'Fejl!',
				message = 'Der opstod en fejl, det ligner ikke at det outfit findes. Prøv venligst igen.',
				duration = 5000,
				position = 'bottom-center'
			})
		end
	end)
end)

RegisterNetEvent("static-clothing:deleteoutfit")
AddEventHandler("static-clothing:deleteoutfit", function(outfit)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
		local Sets = json.decode(data[1].outfits) or {}
		
		if Sets[outfit] ~= nil then
			Sets[outfit] = nil
			local Sets2 = json.encode(Sets)
			MySQL.Async.execute('UPDATE users SET `outfits` = @data WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier, ['@data'] = Sets2})

			TriggerClientEvent("static-clothing:sendoutfits2", source, Sets2)
		else
			TriggerClientEvent("static-clothing:sendoutfits2", source, data)
			TriggerClientEvent("t-notify:client:Custom", source, {
				style = 'error',
				title = 'Fejl!',
				message = 'Der opstod en fejl, det ligner ikke at det outfit findes. Prøv venligst igen.',
				duration = 5000,
				position = 'bottom-center'
			})
		end
	end)
end)

RegisterNetEvent("static-clothing:renameoutfit")
AddEventHandler("static-clothing:renameoutfit", function(outfit, name)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if name ~= "" then
		MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
			
			local Sets = json.decode(data[1].outfits) or {}
			
			if Sets[outfit] ~= nil then
				if Sets[name] == nil then
					local outfitinfo = Sets[outfit]
					Sets[outfit] = nil
					Sets[name] = outfitinfo
					local Sets2 = json.encode(Sets)
					MySQL.Async.execute('UPDATE users SET `outfits` = @data WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier, ['@data'] = Sets2})

					TriggerClientEvent("static-clothing:sendoutfits2", source, Sets2)
				else
					TriggerClientEvent("t-notify:client:Custom", source, {
						style = 'error',
						title = 'Fejl!',
						message = 'Du har allerede et outfit med det navn!',
						duration = 5000,
						position = 'bottom-center'
					})
				end
			else
				TriggerClientEvent("static-clothing:sendoutfits2", source, data)
				TriggerClientEvent("t-notify:client:Custom", source, {
					style = 'error',
					title = 'Fejl!',
					message = 'Der opstod en fejl, det ligner ikke at det outfit findes. Prøv venligst igen.',
					duration = 5000,
					position = 'bottom-center'
				})
			end
		end)
	else
		TriggerClientEvent("t-notify:client:Custom", source, {
			style = 'error',
			title = 'Fejl!',
			message = 'Du skal skrive et navn!',
			duration = 5000,
			position = 'bottom-center'
		})
	end
end)

RegisterCommand('karakter', function(source)
	TriggerClientEvent('Command:Karakter', source)
end)


ESX.RegisterServerCallback('raid_clothes:GetGender', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sex
	MySQL.Async.fetchAll('SELECT sex FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		for k,v in pairs(result) do
			sex = v.sex
		end
		cb(sex)
	end)
end)