-- Du kan bruge exports.logo:toggle() i et script for at slå det til og fra

local toggle = true

CreateThread(function()
    while true do
        TriggerServerEvent('logo:getPlayerCount')
        Wait(100)
    end
end)

RegisterNetEvent('logo:sendPlayerCount', function(data)
    SendNUIMessage({
        type = "update",
        playerId = data.source,
        serverMaxCount = data.max,
        serverPlayerCount = data.playerCount
    })
end)

exports('toggle', function()
    toggle = not toggle
    SendNUIMessage({
        type = "toggle",
        toggle
    })
end)