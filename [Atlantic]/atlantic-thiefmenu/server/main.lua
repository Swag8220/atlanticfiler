ESX = nil
local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/895311798708891650/_F25hUe0_PMmDQgL-lTcxKQGVatpksk70YjOnOhSFtrGO1BldisxCMbHabDBdmpJyDPf"
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx_okradanie:handcuff')
AddEventHandler('esx_okradanie:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('strips', 1)
	TriggerClientEvent('esx_okradanie:handcuff', target)
end)

RegisterServerEvent('Atlantic_thiefmenu:drag')
AddEventHandler('Atlantic_thiefmenu:drag', function(target)
	TriggerClientEvent('Atlantic_thiefmenu:drag', target, source)
end)

RegisterServerEvent('Atlantic_thiefmenu:handcuff')
AddEventHandler('Atlantic_thiefmenu:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('strips', 1)
	TriggerClientEvent('Atlantic_thiefmenu:handcuff', target)
end)
RegisterServerEvent('Atlantic_thiefmenu:handcuff2')
AddEventHandler('Atlantic_thiefmenu:handcuff2', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('Atlantic_thiefmenu:handcuff', target)
end)

RegisterNetEvent('esx_okradanie:drag')
AddEventHandler('esx_okradanie:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_okradanie:drag', target, source)
end)

RegisterServerEvent('esx_okradanie:putInVehicle')
AddEventHandler('esx_okradanie:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_okradanie:putInVehicle', target)
end)

RegisterServerEvent('esx_okradanie:OutVehicle')
AddEventHandler('esx_okradanie:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('esx_okradanie:OutVehicle', target)
end)

RegisterServerEvent('esx_okradanie:message')
AddEventHandler('esx_okradanie:message', function(target, msg)
	local steam = GetPlayerName(source)
	local steam2 = GetPlayerName(target)
	PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({content = steam.." visiterede "..steam2 .. "!", tts = false}), { ['Content-Type'] = 'application/json' })
	TriggerClientEvent('esx:showNotification', target, msg)
end)

ESX.RegisterServerCallback('esx_okradanie:sitem', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local quantity = xPlayer.getInventoryItem(item).count
    cb(quantity)
end)

RegisterServerEvent('Atlantic_thiefmenu:confiscatePlayerItem')
AddEventHandler('Atlantic_thiefmenu:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local steam = GetPlayerName(_source)
	local steam2 = GetPlayerName(target)

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then
		
			-- can the player carry the said amount of x item?
			if sourceItem.weight >= 30 then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
				PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({content = steam.." tog " ..amount.. " " ..itemName .. " fra " .. steam2.. "!", tts = false}), { ['Content-Type'] = 'application/json' })
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_account', amount, itemName, targetXPlayer.name))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_account', amount, itemName, sourceXPlayer.name))
		PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({content = steam.." tog " ..amount..itemName .. " fra " .. steam2.. "!", tts = false}), { ['Content-Type'] = 'application/json' })

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
		PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({content = steam.." tog " ..itemName .. " med " ..amount.. " fra " ..steam2.. "!", tts = false}), { ['Content-Type'] = 'application/json' })
	end
end)

ESX.RegisterServerCallback('Atlantic_thiefmenu:getOtherPlayerData', function(source, cb, target)

	if Config.EnableESXIdentity then

		local xPlayer = ESX.GetPlayerFromId(target)

		local identifier = GetPlayerIdentifiers(target)[1]

		local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
			['@identifier'] = identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth
		local height    = result[1].height

		local data = {
			name      = GetPlayerName(target),
			job       = xPlayer.job,
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			weapons   = xPlayer.loadout,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end

	else

		local xPlayer = ESX.GetPlayerFromId(target)

		local data = {
			name       = GetPlayerName(target),
			job        = xPlayer.job,
			inventory  = xPlayer.inventory,
			accounts   = xPlayer.accounts,
			weapons    = xPlayer.loadout
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)

	end

end)

RegisterServerEvent('Atlantic_thiefmenu:OutVehicle')
AddEventHandler('Atlantic_thiefmenu:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('Atlantic_thiefmenu:OutVehicle', target)
end)

RegisterServerEvent('Atlantic_thiefmenu:putInVehicle')
AddEventHandler('Atlantic_thiefmenu:putInVehicle', function(target)
	TriggerClientEvent('Atlantic_thiefmenu:putInVehicle', target)
end)
