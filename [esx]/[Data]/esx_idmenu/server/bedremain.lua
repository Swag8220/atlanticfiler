ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent("esx_idMenu:showMenu")
AddEventHandler("esx_idMenu:showMenu", function(players)
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	local elements = {}
	for k,v in pairs(players) do
		local xPlayer = ESX.GetPlayerFromId(v)
		local steamanme = GetPlayerName(v)
		if xPlayer ~= nil then
			table.insert(elements, {label = "ID: ".. v, id = v, name = steamanme, identifier = xPlayer.getIdentifier()})
		end
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("esx_idMenu:showMenu",source,elements)
	-- TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, xPlayer.getRPname(), " kigger på listen over byens borgere", { 255, 0, 0 })
end)
