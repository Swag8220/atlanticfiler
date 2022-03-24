RegisterNetEvent('logo:getPlayerCount', function()
    local source = source
    local max = GetConvarInt('sv_maxclients', 80)
    local playerCunt = 0

    for k,v in pairs(GetPlayers()) do
        playerCunt = playerCunt+1
    end

    TriggerClientEvent('logo:sendPlayerCount', source, {
        max = max,
        source = source,
        playerCount = playerCunt
    })
end)