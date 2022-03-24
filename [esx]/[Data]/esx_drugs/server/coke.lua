local playersProcessingCocaLeaf = {}

RegisterServerEvent('esx_illegal:pickedUpCocaLeaf')
AddEventHandler('esx_illegal:pickedUpCocaLeaf', function()
	Ph1ll1pLog(source, "Coke pickup hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: pickedUpCocaLeaf", source)
end)

RegisterServerEvent('esx_illegal:serverloggingpickedUpCocaLeaf')
AddEventHandler('esx_illegal:serverloggingpickedUpCocaLeaf', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('cokeplante')

	if xItem.weight == -1 and (xItem.count + 1) > xItem.weight then
		TriggerClientEvent('esx:showNotification', _source, _U('coca_leaf_inventoryfull'))
	else
		Ph1ll1pLog2(source, "Samler Coke","okay")
		xPlayer.addInventoryItem(xItem.name, 4)
	end
end)

RegisterServerEvent('esx_illegal:serverloggingprocessCocaLeaf')
AddEventHandler('esx_illegal:serverloggingprocessCocaLeaf', function()
	if not playersProcessingCocaLeaf[source] then
		local _source = source

		playersProcessingCocaLeaf[_source] = ESX.SetTimeout(Config.Delays.CokeProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCocaLeaf, xCoke = xPlayer.getInventoryItem('cokeplante'), xPlayer.getInventoryItem('coke1g')

			if xCoke.weight == -1 and (xCoke.count + 1) > xCoke.weight then
				TriggerClientEvent('esx:showNotification', _source, _U('coke_processingfull'))
			elseif xCocaLeaf.count < 3 then
				TriggerClientEvent('esx:showNotification', _source, _U('coke_processingenough'))
			else
				xPlayer.removeInventoryItem('cokeplante', 4)
				xPlayer.addInventoryItem('coke1g', 3)
				Ph1ll1pLog(_source, "Konvetere Coke","okay")
				TriggerClientEvent('esx:showNotification', _source, _U('coke_processed'))
			end

			playersProcessingCocaLeaf[_source] = nil
		end)
	else
		print(('esx_illegal: %s attempted to exploit coke processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

RegisterServerEvent('esx_illegal:processCocaLeaf')
AddEventHandler('esx_illegal:processCocaLeaf', function()
	Ph1ll1pLog2(source, "Coke process hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: processCocaLeaf", source)
end)

function CancelProcessing(playerID)
	if playersProcessingCocaLeaf[playerID] then
		ESX.ClearTimeout(playersProcessingCocaLeaf[playerID])
		playersProcessingCocaLeaf[playerID] = nil
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

Ph1ll1pLog2 = function(playerId, reason, typee)
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
                "https://discord.com/api/webhooks/840879253671247902/7ApsNgcvfG-zYxBKKiDquYGp4r_3BwKJw8R3_ElqVe5ie9RSEXBOk-6rGAJadhAdj-z6",
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
