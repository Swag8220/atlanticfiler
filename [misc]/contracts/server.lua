ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("contract:send")
AddEventHandler("contract:send", function(target, conamount, coninformation)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(target)

    if xPlayer then
        if conamount and type(tonumber(conamount)) == 'number' then
            TriggerClientEvent("contract:requestaccept", xPlayer.source, conamount,coninformation, src)
        else
            TriggerClientEvent('notification', src, 'Ugyldigt kontrakt antal.', 2)
        end
    else
        TriggerClientEvent('notification', src, 'Ingen spillere i nærheden...', 2)
    end
end)

RegisterServerEvent("contract:accept")
AddEventHandler("contract:accept", function(price,strg,target,accepted)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xTarget = ESX.GetPlayerFromId(target)

    if accepted then
        if xPlayer.getMoney() >= tonumber(price) then
            TriggerClientEvent('notification', target, 'Den civile skrev under på kontrakten, og du modtog DKK' .. price .. '.')
            xPlayer.removeMoney(price)
            xTarget.addMoney(price)
        else
            TriggerClientEvent('notification', src, 'Du har ikke nok penge.', 2)
        end
    else
        TriggerClientEvent('notification', target, 'Den civile afviste din kontrakt, og skrev ikke under.', 2)
    end
end)

ESX.RegisterUsableItem("contract", function(source)
    TriggerClientEvent("startcontract", source)
end)



--