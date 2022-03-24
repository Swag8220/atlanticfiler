ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--RegisterServerEvent('esx_outlawalert:carJackInProgress')
--AddEventHandler('esx_outlawalert:carJackInProgress', function(targetCoords, streetName, vehicleLabel, playerGender, plate2, playerCoords)
    local plate2 = plate2
--    TriggerEvent("omik_callist:addTable", nil, "Bil tyveri: " ..vehicleLabel.. " Nummerplade: " ..plate2..'.', "police", playerCoords.x, playerCoords.y, playerCoords.z)
--end, false)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('esx_outlawalert:combatInProgress')
AddEventHandler('esx_outlawalert:combatInProgress', function(targetCoords, streetName, playerGender)
    TriggerEvent("mdt:newCall", "Nogle er oppe og slås!", "Ukendt", vector3(targetCoords.x, targetCoords.y, targetCoords.z))
end, false)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('esx_outlawalert:gunshotInProgress')
AddEventHandler('esx_outlawalert:gunshotInProgress', function(targetCoords, streetName, playerGender)
	mytype = 'police'
    data = {["code"] = 'SKYDERI', ["name"] = 'igangværende skyderi', ["loc"] = streetName}
    length = 3500
    TriggerEvent("mdt:newCall", "Nogen skyder!", "Ukendt", vector3(targetCoords.x, targetCoords.y, targetCoords.z))
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
     TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
end, false)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('esx_outlawalert:panicButton')
AddEventHandler('esx_outlawalert:panicButton', function(targetCoords, streetName, playerGender)
	mytype = 'police'
    data = {["code"] = 'KODE 3', ["name"] = 'KOLLEGA I NØD', ["loc"] = streetName}
    length = 7000
    TriggerClientEvent('esx_outlawalert:outlawNotify2', -1, mytype, data, length)
     TriggerClientEvent('esx_outlawalert:panicButton', -1, targetCoords)
    TriggerEvent("omik_callist:addTable", nil, "KOLLEGA I NØD ved: "..streetName, "police", targetCoords.x, targetCoords.y, targetCoords.z)

end, false)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('esx_outlawalert:robberyInProgress')
AddEventHandler('esx_outlawalert:robberyInProgress', function(targetCoords, streetName, playerGender)
	mytype = 'police'
    data = {["code"] = 'RØVERI', ["name"] = 'igangværende Butiksrøveri', ["loc"] = streetName}
    length = 3500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
     TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
    TriggerEvent("omik_callist:addTable", nil, "Butiksrøveri igang ved: "..streetName, "police", targetCoords.x, targetCoords.y, targetCoords.z)

end, false)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('esx_outlawalert:jailbreak')
AddEventHandler('esx_outlawalert:jailbreak', function(playerCoords, streetName, playerGender)
	mytype = 'police'
    data = {["code"] = 'UDBRUD', ["name"] = 'igangværende Fængsel udbrud', ["loc"] = streetName}
    length = 5000
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
     TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, playerCoords)
    TriggerEvent("omik_callist:addTable", nil, "Fængsel udbrud igang ved: "..streetName, "police", playerCoords.x, playerCoords.y, playerCoords.z)

end, false)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('esx_outlawalert:houseRobberyinProgress')
AddEventHandler('esx_outlawalert:houseRobberyinProgress', function(targetCoords, streetName, playerGender)
	mytype = 'police'
    data = {["code"] = 'ADFÆRD', ["name"] = 'Mistænktligt Adfærd', ["loc"] = streetName}
    length = 3500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
     TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
    TriggerEvent("omik_callist:addTable", nil, "Mistænktligt Adfærd ved: "..streetName, "police", targetCoords.x, targetCoords.y, targetCoords.z)

end, false)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent('esx_outlawalert:pengetransporter')
AddEventHandler('esx_outlawalert:pengetransporter', function(targetCoords, streetName, playerGender)
	mytype = 'police'
    data = {["code"] = 'RØVERI', ["name"] = 'igangværende Pengetransporter røveri!', ["loc"] = streetName}
    length = 5000
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerEvent("omik_callist:addTable", nil, "Pengetransporter røveri ved: "..streetName, "police", targetCoords.x, targetCoords.y, targetCoords.z)

end, false)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ESX.RegisterServerCallback('esx_outlawalert:isVehicleOwner', function(source, cb, plate)
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)
