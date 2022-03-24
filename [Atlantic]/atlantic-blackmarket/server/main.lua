ESX             = nil
local ShopItems = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM blackmarket LEFT JOIN items ON items.name = blackmarket.item', {}, function(shopResult)
		for i=1, #shopResult, 1 do
			if shopResult[i].name then
				if ShopItems[shopResult[i].store] == nil then
					ShopItems[shopResult[i].store] = {}
				end

				table.insert(ShopItems[shopResult[i].store], {
					label = shopResult[i].label,
					item  = shopResult[i].item,
					price = shopResult[i].price,
				})
			else
				print(('esx_blackmarket: invalid item "%s" found!'):format(shopResult[i].item))
			end
		end
	end)
end)

ESX.RegisterServerCallback('esx_blackmarket:requestDBItems', function(source, cb)
	cb(ShopItems)
end)

RegisterServerEvent('esx_blackmarket:buyItem')
AddEventHandler('esx_blackmarket:buyItem', function(itemName, amount, zone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	amount = ESX.Math.Round(amount)

	-- is the player trying to exploit?
	if amount < 0 then
		print('esx_blackmarket: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		return
	end

	-- get price
	local price = 0
	local itemLabel = ''

	for i=1, #ShopItems[zone], 1 do
		if ShopItems[zone][i].item == itemName then
			price = ShopItems[zone][i].price
			itemLabel = ShopItems[zone][i].label
			break
		end
	end

	price = price * amount

	-- can the player afford this item?
	if xPlayer.getAllMoney() >= price then
		-- can the player carry the said amount of x item?
		if xPlayer.canCarryItem(itemName, amount) then
			xPlayer.removeAllMoney(price)
			xPlayer.addInventoryItem(itemName, amount)
			xPlayer.showNotification(_U('bought', amount, itemLabel, ESX.Math.GroupDigits(price)))
		else
			xPlayer.showNotification(_U('player_cannot_hold'))
		end
	else
		local missingMoney = price - xPlayer.getAllMoney()
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Du har ikke nok penge', style = { ['background-color'] = '#ff0000', ['color'] = '#ffffff' } })
	end
end)
