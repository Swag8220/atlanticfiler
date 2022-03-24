local playersProcessingPoppyResin = {}

RegisterServerEvent('esx_illegal:pickedUpPoppy')
AddEventHandler('esx_illegal:pickedUpPoppy', function()
	Ph1ll1pLog(source, "Herion pickup hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: pickedUpPoppy", source)
end)

RegisterServerEvent('esx_illegal:serverloggingpickedUpPoppy')
AddEventHandler('esx_illegal:serverloggingpickedUpPoppy', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('poppyresin')

	if xItem.weight == -1 and (xItem.count + 1) > xItem.weight then
		TriggerClientEvent('esx:showNotification', _source, _U('poppy_inventoryfull'))
	else
		Ph1ll1pLog3(source, "Samler Herion","okay")
		xPlayer.addInventoryItem(xItem.name, 3)
	end
end)

RegisterServerEvent('esx_illegal:processPoppyResin')
AddEventHandler('esx_illegal:processPoppyResin', function()
	Ph1ll1pLog(source, "Herion process hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: pickedUpPoppy", source)
end)

RegisterServerEvent('esx_illegal:serverloggingprocessPoppyResin')
AddEventHandler('esx_illegal:serverloggingprocessPoppyResin', function()
	if not playersProcessingPoppyResin[source] then
		local _source = source

		playersProcessingPoppyResin[_source] = ESX.SetTimeout(Config.Delays.HeroinProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xPoppyResin, xHeroin = xPlayer.getInventoryItem('poppyresin'), xPlayer.getInventoryItem('heroin')

			if xHeroin.weight == -1 and (xHeroin.count + 1) > xHeroin.weight then
				TriggerClientEvent('esx:showNotification', _source, _U('heroin_processingfull'))
			elseif xPoppyResin.count < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('heroin_processingenough'))
			else
				xPlayer.removeInventoryItem('poppyresin', 2)
				xPlayer.addInventoryItem('heroin', 3)
				Ph1ll1pLog3(_source, "Konvetere Herion","okay")
				TriggerClientEvent('esx:showNotification', _source, _U('heroin_processed'))
			end

			playersProcessingPoppyResin[_source] = nil
		end)
	else
		print(('esx_illegal: %s attempted to exploit heroin processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingPoppyResin[playerID] then
		ESX.ClearTimeout(playersProcessingPoppyResin[playerID])
		playersProcessingPoppyResin[playerID] = nil
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

Ph1ll1pLog3 = function(playerId, reason, typee)
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