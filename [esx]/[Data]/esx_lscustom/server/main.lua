ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local Vehicles = nil
local StarterVehicles = {}

RegisterServerEvent('esx_lscustom:buyMod')
AddEventHandler('esx_lscustom:buyMod', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	price = tonumber(price)

	if Config.IsMechanicJobOnly then

		local societyAccount = nil
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
			societyAccount = account
		end)
		if price < societyAccount.money then
			TriggerClientEvent('esx_lscustom:installMod', _source)
			TriggerClientEvent('esx:showNotification', _source, _U('purchased'))
			societyAccount.removeMoney(price)
		else
			TriggerClientEvent('esx_lscustom:cancelInstallMod', _source)
			TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
		end

	else

		if price < xPlayer.getAllMoney() then
			TriggerClientEvent('esx_lscustom:installMod', _source)
			TriggerClientEvent('esx:showNotification', _source, _U('purchased'))
			xPlayer.removeAllMoney(price)
		else
			TriggerClientEvent('esx_lscustom:cancelInstallMod', _source)
			TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
		end

	end
end)

RegisterServerEvent('esx_lscustom:buyrepair')
AddEventHandler('esx_lscustom:buyrepair', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	price = tonumber(price)

	if price < xPlayer.getAllMoney() then
		TriggerClientEvent('esx_lscustom:repair', _source)
		TriggerClientEvent('esx:showNotification', _source, _U('repaired',price))
		xPlayer.removeAllMoney(price)
	else
		TriggerClientEvent('esx_lscustom:GoOutOfLS', _source)
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end

end)

RegisterServerEvent('esx_lscustom:refreshOwnedVehicle')
AddEventHandler('esx_lscustom:refreshOwnedVehicle', function(myCar)
	MySQL.Async.execute('UPDATE `owned_vehicles` SET `vehicle` = @vehicle WHERE `plate` = @plate',
	{
		['@plate']   = myCar.plate,
		['@vehicle'] = json.encode(myCar)
	})
end)

ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb)
	if Vehicles == nil then
		MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)

ESX.RegisterServerCallback('esx_lscustom:hasMoneyToExit', function(source, cb, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	price = tonumber(price)
	if price < xPlayer.getAllMoney() then
		cb(true)
		TriggerClientEvent('esx:showNotification', _source, _U('purchased'))
		xPlayer.removeAllMoney(price)
	else
		cb(false)
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- RegisterServerEvent('esx_lscustom:setStarterCarServer')
-- AddEventHandler('esx_lscustom:setStarterCarServer', function(props)
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
-- 	local identifier = xPlayer.getIdentifier()
-- 	local found = false
-- 	for k,v in pairs(StarterVehicles) do
-- 		if v.identifier == identifier then
-- 			found = true
-- 			v.props = props
-- 		end
-- 	end
-- 	if not found then
-- 		table.insert(StarterVehicles, {identifier = identifier, props = props})
-- 	end
-- end)

-- AddEventHandler('playerDropped', function (reason)
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
-- 	local identifier = xPlayer.getIdentifier()
-- 	for k,v in pairs(StarterVehicles) do
-- 		if v.identifier == identifier and v.props ~= nil then
-- 			TriggerClientEvent('esx_lscustom:setVehicleProps', -1, v.props)
-- 		end
-- 	end
-- end)

--   RegisterServerEvent('esx_lscustom:removeStarterCarServer')
--   AddEventHandler('esx_lscustom:removeStarterCarServer', function()
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
-- 	local identifier = xPlayer.getIdentifier()
-- 	for k,v in pairs(StarterVehicles) do
-- 		if v.identifier == identifier then
-- 			v.props = nil
-- 		end
-- 	end
-- end)