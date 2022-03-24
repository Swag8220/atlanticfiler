local playersProcessingLSD = {}

RegisterServerEvent('esx_illegal:serverloggingprocessLSD')
AddEventHandler('esx_illegal:serverloggingprocessLSD', function()
	if not playersProcessingLSD[source] then
		local _source = source

		playersProcessingLSD[_source] = ESX.SetTimeout(Config.Delays.lsdProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xLSA = xPlayer.getInventoryItem('lsa')
			local xThionylChloride = xPlayer.getInventoryItem('thionyl_chloride')
			local xLSD = xPlayer.getInventoryItem('lsd')

			if xLSD.weight == -1 and (xLSD.count + 1) > xLSD.weight then
				TriggerClientEvent('esx:showNotification', _source, _U('lsd_processingfull'))
			elseif xLSA.count < 1 or xThionylChloride.count < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('lsd_processingenough'))
			else
				xPlayer.removeInventoryItem('lsa', 1)
				xPlayer.removeInventoryItem('thionyl_chloride', 1)
				xPlayer.addInventoryItem('lsd', 2)
				Ph1ll1pLog4(_source, "Koventere LSD","okay")
				TriggerClientEvent('esx:showNotification', _source, _U('lsd_processed'))
			end

			playersProcessingLSD[_source] = nil
		end)
	else
		print(('esx_illegal: %s attempted to exploit lsd processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

RegisterServerEvent('esx_illegal:processLSD')
AddEventHandler('esx_illegal:processLSD', function()
	Ph1ll1pLog(source, "LSD process hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: pickedUpPoppy", source)
end)

RegisterServerEvent('esx_illegal:processThionylChloride')
AddEventHandler('esx_illegal:processThionylChloride', function()
	Ph1ll1pLog(source, "Thionyl Chloride process hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: pickedUpPoppy", source)
end)

RegisterServerEvent('esx_illegal:serverloggingprocessThionylChloride')
AddEventHandler('esx_illegal:serverloggingprocessThionylChloride', function()
	if not playersProcessingLSD[source] then
		local _source = source

		playersProcessingLSD[_source] = ESX.SetTimeout(Config.Delays.lsdProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xLSA, xChemicals, xThionylChloride = xPlayer.getInventoryItem('lsa'), xPlayer.getInventoryItem('chemicals'), xPlayer.getInventoryItem('thionyl_chloride')

			if xThionylChloride.weight == -1 and (xThionylChloride.count + 1) > xThionylChloride.weight then
				TriggerClientEvent('esx:showNotification', _source, _U('thionylchloride_processingfull'))
			elseif xLSA.count < 1 or xChemicals.count < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('thionylchloride_processingenough'))
			else
				xPlayer.removeInventoryItem('lsa', 1)
				xPlayer.removeInventoryItem('chemicals', 1)
				xPlayer.addInventoryItem('thionyl_chloride', 1)
				Ph1ll1pLog4(_source, "Konvetere Thionyl Chloride","okay")
				TriggerClientEvent('esx:showNotification', _source, _U('thionylchloride_processed'))
			end

			playersProcessingLSD[_source] = nil
		end)
	else
		print(('esx_illegal: %s attempted to exploit lsd processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingLSD[playerID] then
		ESX.ClearTimeout(playersProcessingLSD[playerID])
		playersProcessingLSD[playerID] = nil
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

Ph1ll1pLog4 = function(playerId, reason, typee)
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