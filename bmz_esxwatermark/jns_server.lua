RegisterServerEvent("bmz-servermark")
AddEventHandler("bmz-servermark", function() TriggerClientEvent("bmzersej", source, GetPlayers())
end)

function GetPlayers()
    local num = GetNumPlayerIndices()
    local label = "undefined"
        label = "Online " .. num.."/45 | Dit id: ".. source

    return label
end
