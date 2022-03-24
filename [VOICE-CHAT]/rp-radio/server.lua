ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("checkradio")
AddEventHandler("checkradio", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local item_radio = xPlayer.getInventoryItem('radio').count
		if item_radio >= 1 then
			TriggerClientEvent("doeshaveradio", source)
		else
			TriggerClientEvent("doesnthaveradio", source)
		end
	end
end)





ESX.RegisterUsableItem('radio', function(source) local xPlayer = ESX.GetPlayerFromId(source) TriggerClientEvent('Radio.Set', source, true) TriggerClientEvent('Radio.Toggle', source) end)