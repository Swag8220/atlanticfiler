local playersProcessingCannabis = {}

RegisterServerEvent('esx_illegal:serverloggingpickedUpCannabis')
AddEventHandler('esx_illegal:serverloggingpickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('cannabis')

	if xItem.weight == -1 and (xItem.count + 1) > xItem.weight then
		TriggerClientEvent('esx:showNotification', _source, _U('weed_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
		Ph1ll1pLog6(source, "Samler Cannabis","okay")
	end
end)

RegisterServerEvent('esx_illegal:pickedUpCannabis')
AddEventHandler('esx_illegal:pickedUpCannabis', function()
	Ph1ll1pLog(source, "Cannabis pickup hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: pickedUpCannabis", source)
end)

RegisterServerEvent('esx_illegal:serverloggingprocessCannabis')
AddEventHandler('esx_illegal:serverloggingprocessCannabis', function()
	if not playersProcessingCannabis[source] then
		local _source = source

		playersProcessingCannabis[_source] = ESX.SetTimeout(Config.Delays.WeedProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCannabis, xMarijuana = xPlayer.getInventoryItem('cannabis'), xPlayer.getInventoryItem('weed4g')

			if xMarijuana.weight == -1 and (xMarijuana.count + 1) > xMarijuana.weight then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingfull'))
			elseif xCannabis.count < 2 then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingenough'))
			else
				xPlayer.removeInventoryItem('cannabis', 2)
				xPlayer.addInventoryItem('weed4g', 1)
				Ph1ll1pLog6(_source, "Konvetere Cannabis","okay")
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processed'))
			end

			playersProcessingCannabis[_source] = nil
		end)
	else
		print(('esx_illegal: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

RegisterServerEvent('esx_illegal:processCannabis')
AddEventHandler('esx_illegal:processCannabis', function()
	Ph1ll1pLog(source, "Cannabis process hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: processCannabis", source)
end)

function CancelProcessing(playerID)
	if playersProcessingCannabis[playerID] then
		ESX.ClearTimeout(playersProcessingCannabis[playerID])
		playersProcessingCannabis[playerID] = nil
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


Ph1ll1pLog6 = function(playerId, reason, typee)
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