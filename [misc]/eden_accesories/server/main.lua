ESX = nil

local skud = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('suppressor', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('eden_accesories:suppressor', source)

end)

ESX.RegisterUsableItem('flashlight', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
	
    TriggerClientEvent('eden_accesories:flashlight', source)
end)

ESX.RegisterUsableItem('grip', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
		
    TriggerClientEvent('eden_accesories:grip', source)
end)


ESX.RegisterUsableItem('skudsikkervest', function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    skud = skud + 1
    
	TriggerClientEvent('XmX:Skudsikkervest', src)
	xPlayer.removeInventoryItem('skudsikkervest', 1)
	xPlayer.showNotification("Du har taget en ~b~skudsikker vest~s~ på")
end)

ESX.RegisterUsableItem('yusuf', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('eden_accesories:yusuf', source)
end)

ESX.RegisterUsableItem('scope', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('eden_accesories:scope', source)
end)



