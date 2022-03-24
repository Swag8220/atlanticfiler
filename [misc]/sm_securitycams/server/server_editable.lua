ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'secworker', 'secworkera', true, true)
TriggerEvent('esx_society:registerSociety', 'secworker', 'secworker', 'secworker', 'secworker', 'secworker', {type = 'public'})

ESX.RegisterUsableItem('camtablet', function(source, data)
	TriggerClientEvent("sg_cams:playertbl",source)
end)
RegisterCommand('sectablet', function(source,args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "secworker" then
		TriggerClientEvent("sg_cams:worktbl",source)
	end
end)
RegisterCommand('camera', function(source,args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "secworker" then
		TriggerClientEvent("sg_cams:camcam",source)
	end
end)

RegisterServerEvent("cams:givetablet")
AddEventHandler("cams:givetablet",function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.addInventoryItem("camtablet", amount)
	end 
end)

RegisterServerEvent("cams:openstorage")
AddEventHandler("cams:openstorage",function(amount)
	TriggerClientEvent("esx_inventoryhud:openStorageInventory", source, "secworker")
end)

--rare5m.com