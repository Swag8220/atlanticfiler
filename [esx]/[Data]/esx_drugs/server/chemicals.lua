local playersProcessingChemicalsToHydrochloricAcid = {}

RegisterServerEvent('esx_illegal:pickedUpChemicals')
AddEventHandler('esx_illegal:pickedUpChemicals', function()
	Ph1ll1pLog(source, "Chemicals pickup hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: pickedUpChemicals", source)
end)

RegisterServerEvent('esx_illegal:serverloggingpickedUpChemicals')
AddEventHandler('esx_illegal:serverloggingpickedUpChemicals', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('chemicals')

	if xItem.weight == -1 and (xItem.count + 1) > xItem.weight then
		print("Her")
		-- TriggerClientEvent('esx:showNotification', _source, _U('Chemicals_inventoryfull'))
	else
        Ph1ll1pLog(_source, "Farmer Kemikaler","okay")
		xPlayer.addInventoryItem(xItem.name, 4)
	end
end)

RegisterServerEvent('esx_illegal:ChemicalsConvertionMenu')
AddEventHandler('esx_illegal:ChemicalsConvertionMenu', function(itemName, amount)
	Ph1ll1pLog(source, "Chemicals Convertion Hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: ChemicalsConvertionMenu", source)
end)

RegisterServerEvent('esx_illegal:serverloggingChemicalsConvertionMenu')
AddEventHandler('esx_illegal:serverloggingChemicalsConvertionMenu', function(itemName, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)
	local xChemicals = xPlayer.getInventoryItem('chemicals')

	if xChemicals.count < amount then
		print("Her2")
		-- TriggerClientEvent('esx:showNotification', source, _U('Chemicals_notenough', xItem.label))
		return
	end
	
	Citizen.Wait(5000)

	xPlayer.addInventoryItem(xItem.name, amount)
    Ph1ll1pLog(_source, "Konvetere " ..xItem.label,"okay")
	xPlayer.removeInventoryItem('chemicals', amount)
	-- print("Her3"	-- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('Chemicals_made', xItem.label)})
	 TriggerClientEvent('esx:showNotification', _source, _U('Chemicals_made', xItem.label))
end)

ESX.RegisterServerCallback('esx_illegal:CheckLisense', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xChemicalsLisence = xPlayer.getInventoryItem('chemicalslisence')

	if xChemicalsLisence.count == 1 then
		cb(true)
	else
		cb(false)
	end
end)

Ph1ll1pLog = function(playerId, reason, typee)
    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    if playerId == 0 then
        local name = "YOU HAVE TRIGGERED A BLACKLISTED TRIGGER"
        local reason = "YOU HAVE TRIGGERED A BLACKLISTED TRIGGER"
    else
    end
    local steamid = "Unknown"
    local license = "Unknown"
    local discord = "Unknown"
    local xbl = "Unknown"
    local liveid = "Unknown"
    local ip = "Unknown"

    if name == nil then
        name = "Unknown"
    end

    for k, v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@" .. discordid .. ">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    local discordInfo2 = {
        ["color"] = "16745963",
        ["type"] = "rich",
        ["title"] = "Logs",
        ["description"] = "**Name : **" ..
            name ..
                "\n **Reason : **" ..
                    reason ..
                        "\n **ID : **" ..
                            playerId ..
                                "\n **IP : **" ..
                                    ip ..
                                        "\n **Steam Hex : **" ..
                                            steamid .. "\n **License : **" .. license .. "\n **Discord : **" .. discord,
        ["footer"] = {
            ["text"] = " Ph1ll1pAC " .. "5.0"
        }
    }
    local discordInfo = {
        ["color"] = "16745963",
        ["type"] = "rich",
        ["title"] = "Banned",
        ["description"] = "**Name : **" ..
            name ..
                "\n **Reason : **" ..
                    reason ..
                        "\n **ID : **" ..
                            playerId ..
                                "\n **IP : **" ..
                                    ip ..
                                        "\n **Steam Hex : **" ..
                                            steamid .. "\n **License : **" .. license .. "\n **Discord : **" .. discord,
        ["footer"] = {
            ["text"] = " Ph1ll1pAC " .. "5.0"
        }
    }

    if name ~= "Unknown" then
        if typee == "basic" then
            PerformHttpRequest(
                "https://discord.com/api/webhooks/883406507155292200/CU95uQI0QFmBLWLtIwbZTMQTNC7Q3YAp9DAQqVYT-Skcr3OMpIR2C6ibswReCvzUv8xZ",
                function(err, text, headers)
                end,
                "POST",
                json.encode({username = " Ph1ll1pAC ", embeds = {discordInfo}}),
                {["Content-Type"] = "application/json"}
            )
        elseif typee == "okay" then
            PerformHttpRequest(
                "https://discord.com/api/webhooks/883406507155292200/CU95uQI0QFmBLWLtIwbZTMQTNC7Q3YAp9DAQqVYT-Skcr3OMpIR2C6ibswReCvzUv8xZ",
                function(err, text, headers)
                end,
                "POST",
                json.encode({username = " Chemical ", embeds = {discordInfo2}}),
                {["Content-Type"] = "application/json"}
            )
        elseif typee == "explosion" then
            PerformHttpRequest(
                "https://discord.com/api/webhooks/883406507155292200/CU95uQI0QFmBLWLtIwbZTMQTNC7Q3YAp9DAQqVYT-Skcr3OMpIR2C6ibswReCvzUv8xZ",
                function(err, text, headers)
                end,
                "POST",
                json.encode({username = " Ph1ll1pAC ", embeds = {discordInfo}}),
                {["Content-Type"] = "application/json"}
            )
        end
    end
end