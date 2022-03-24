local playersProcessingMeth = {}

RegisterServerEvent('esx_illegal:serverloggingpickedUpHydrochloricAcid')
AddEventHandler('esx_illegal:serverloggingpickedUpHydrochloricAcid', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('hydrochloric_acid')

	if xItem.weight == -1 and (xItem.count + 1) > xItem.weight then
		TriggerClientEvent('esx:showNotification', _source, _U('hydrochloric_acid_inventoryfull'))
	else
		Ph1ll1pLog5(source, "Konvetere hydrochloric_acid","okay")
		xPlayer.addInventoryItem(xItem.name, 2)
	end
end)

RegisterServerEvent('esx_illegal:pickedUpHydrochloricAcid')
AddEventHandler('esx_illegal:pickedUpHydrochloricAcid', function()
	Ph1ll1pLog(source, "HydrochloricAcid pickup hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: pickedUpHydrochloricAcid", source)
end)

RegisterServerEvent('esx_illegal:serverloggingpickedUpSodiumHydroxide')
AddEventHandler('esx_illegal:serverloggingpickedUpSodiumHydroxide', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('sodium_hydroxide')

	if xItem.weight == -1 and (xItem.count + 1) > xItem.weight then
		TriggerClientEvent('esx:showNotification', _source, _U('sodium_hydroxide_inventoryfull'))
	else
		Ph1ll1pLog5(source, "Konvetere sodium_hydroxide","okay")
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_illegal:pickedUpSodiumHydroxide')
AddEventHandler('esx_illegal:pickedUpSodiumHydroxide', function()
	Ph1ll1pLog(source, "SodiumHydroxide pickup hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: pickedUpSodiumHydroxide", source)
end)

RegisterServerEvent('esx_illegal:serverloggingpickedUpSulfuricAcid')
AddEventHandler('esx_illegal:serverloggingpickedUpSulfuricAcid', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('sulfuric_acid')

	if xItem.weight == -1 and (xItem.count + 1) > xItem.weight then
		TriggerClientEvent('esx:showNotification', _source, _U('sulfuric_acid_inventoryfull'))
	else
		Ph1ll1pLog5(source, "Konvetere SulfuricAcid","okay")
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_illegal:pickedUpSulfuricAcid')
AddEventHandler('esx_illegal:pickedUpSulfuricAcid', function()
	Ph1ll1pLog(source, "SulfuricAcid pickup hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: pickedUpSulfuricAcid", source)
end)

RegisterServerEvent('esx_illegal:processMeth')
AddEventHandler('esx_illegal:processMeth', function()
	Ph1ll1pLog(source, "Meth process hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: pickedUpSulfuricAcid", source)
end)


RegisterServerEvent('esx_illegal:serverloggingprocessMeth')
AddEventHandler('esx_illegal:serverloggingprocessMeth', function()
	if not playersProcessingMeth[source] then
		local _source = source

		playersProcessingMeth[_source] = ESX.SetTimeout(Config.Delays.MethProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xhydrochloric_acid,xsulfuric_acid,xsodium_hydroxide,xmeth = xPlayer.getInventoryItem('hydrochloric_acid'),xPlayer.getInventoryItem('sulfuric_acid'),xPlayer.getInventoryItem('sodium_hydroxide'), xPlayer.getInventoryItem('meth1g')

			if xmeth.weight == -1 and (xmeth.count + 1) > xmeth.weight then
				TriggerClientEvent('esx:showNotification', _source, _U('meth_processingfull'))
			elseif xhydrochloric_acid.count < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('meth_processingenough'))
			elseif xsulfuric_acid.count < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('meth_processingenough'))
			elseif xsodium_hydroxide.count < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('meth_processingenough'))
			else
				xPlayer.removeInventoryItem('hydrochloric_acid', 1)
				xPlayer.removeInventoryItem('sulfuric_acid', 1)
				xPlayer.removeInventoryItem('sodium_hydroxide', 1)
				xPlayer.addInventoryItem('meth1g', 1)
				Ph1ll1pLog5(_source, "Konvetere Meth","okay")
				TriggerClientEvent('esx:showNotification', _source, _U('meth_processed'))
			end

			playersProcessingMeth[_source] = nil
		end)
	else
		print(('esx_illegal: %s attempted to exploit meth processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingMeth[playerID] then
		ESX.ClearTimeout(playersProcessingMeth[playerID])
		playersProcessingMeth[playerID] = nil
	end
end

RegisterServerEvent('esx_illegal:cancelProcessing')
AddEventHandler('esx_illegal:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

Ph1ll1pLog5 = function(playerId, reason, typee)
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
