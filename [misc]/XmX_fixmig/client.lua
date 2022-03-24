RegisterCommand('fixmig', function(source, args)
    SetEntityVisible(PlayerPedId(), true)
    FreezeEntityPosition(PlayerPedId(), false)
end)