local ESX = nil
local robbableItems = {
 [1] = {chance = 3, id = 0, name = 'Cash', quantity = math.random(1, 1500)}, -- really common
 [9] = {chance = 4, id = 'phone', name = 'Telefon', quantity = 1}, -- rare
 [2] = {chance = 9, id = 'WEAPON_DAGGER', name = 'Dolk', isWeapon = true}, -- rare
 [2] = {chance = 7, id = 'WEAPON_BAT', name = 'Bat', isWeapon = true}, -- rare
 [2] = {chance = 10, id = 'WEAPON_KNUCKLE', name = 'Knojern', isWeapon = true}, -- rare
 [3] = {chance = 4, id = 'bread', name = 'Brød', quantity = math.random(1, 6)}, -- really common
 [4] = {chance = 5, id = 'coke1g', name = 'Kokain', quantity = math.random(1, 6)}, -- rare
 [9] = {chance = 5, id = 'drill', name = 'Bor', quantity = 1}, -- rare
 [10] = {chance = 4, id = 'bandage', name = 'Bandage', quantity = 6}, -- common
 [11] = {chance = 4, id = 'cokeplante', name = 'Kokain blade', quantity = math.random(1, 6)}, -- rare
 [12] = {chance = 3, id = 'meth1g', name = 'Meth', quantity = math.random(1, 6)}, -- rare
 [13] = {chance = 3, id = 'radio', name = 'Radio', quantity = 1}, -- rare
 [14] = {chance = 5, id = 'weed', name = 'Marijuana', quantity = math.random(1, 6)}, -- rare
 [15] = {chance = 5, id = 'advancedlockpick', name = 'Koben', quantity = 1}, -- rare
 [16] = {chance = 10, id = 'celownikdluga', name = 'Sigte til rifler', quantity = 1}, -- rare
 [17] = {chance = 10, id = 'grip', name = 'Grip', quantity = 1}, -- rare
 [18] = {chance = 10, id = 'powiekszonymagazynek', name = 'Udvidet Magasin', quantity = 1}, -- rare
 [19] = {chance = 10, id = 'Suppressor', name = 'Suppressor', quantity = 1}, -- rare
 [20] = {chance = 10, id = 'flashlight', name = 'Flashlight til våben', quantity = 1}, -- rare

--  [16] = {chance = 4, id = 'steel', name = 'Steel', quantity = 1}, -- rare
--  [17] = {chance = 4, id = 'screen', name = 'Screen', quantity = 1}, -- rare
--  [18] = {chance = 5, id = 'scrap_metal', name = 'Scrap Metal', quantity = 1}, -- rare
--  [19] = {chance = 2, id = 'rubber', name = 'Rubber', quantity = 1}, -- rare
--  [20] = {chance = 1, id = 'rolling_paper', name = 'Rolling Paper', quantity = 1}, -- rare
--  [21] = {chance = 3, id = 'glass', name = 'Glass', quantity = 1}, -- rare
--  [22] = {chance = 7, id = 'fuse', name = 'Fuse', quantity = 1}, -- rare
--  [23] = {chance = 8, id = 'clutch', name = 'Clutch', quantity = 1}, -- rare
--  [24] = {chance = 5, id = 'battery', name = 'Battery', quantity = 1}, -- rare
--  [25] = {chance = 2, id = 'breadboard', name = 'Breadboard (P)', quantity = 1}, -- rare
--  [26] = {chance = 7, id = 'white_pearl', name = 'White Pearl (P)', quantity = 1}, -- rare
--  [27] = {chance = 9, id = 'coke_pooch', name = 'Bag of Coke', quantity = 1}, -- rare
--  [28] = {chance = 7, id = 'xtc', name = 'X', quantity = 1}, -- rare
--  [29] = {chance = 8, id = 'electronics', name = 'Electronics (P)', quantity = 1}, -- rare
--  [30] = {chance = 9, id = 'electronic_kit', name = 'Electronic Kit', quantity = 1}, -- rare
}

--[[chance = 1 is very common, the higher the value the less the chance]]--

TriggerEvent('esx:getSharedObject', function(obj)
 ESX = obj
end)

ESX.RegisterUsableItem('advancedlockpick', function(source) --Hammer high time to unlock but 100% call cops
    local cops = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 if cops >= 1 then
 TriggerClientEvent('houseRobberies:attempt', source, xPlayer.getInventoryItem('advancedlockpick').count)
 else
    TriggerClientEvent('notification', source, 'Der er ikke nok betjente', 2)
 end
end)

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 xPlayer.removeInventoryItem('advancedlockpick', 1)
 --TriggerClientEvent('chatMessage', source, '^1Your lockpick has bent out of shape')
 TriggerClientEvent('notification', source, 'Du bukkede kobenet', 2)
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
	Ph1ll1pLog10(source, "Houserobbery hack","basic")
	TriggerEvent("Ph1ll1pBan", " ❓Ban Reason: Blocked Event", source)
end)

RegisterServerEvent('houseRobberies:serverlogginggiveMoney')
AddEventHandler('houseRobberies:serverlogginggiveMoney', function()
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 local cash = math.random(500, 2500)
 xPlayer.addMoney(cash)
 Ph1ll1pLog10(source, "Har fundet ".. cash,"okay")
 --TriggerClientEvent('chatMessage', source, '^4You have found $'..cash)
 TriggerClientEvent('notification', source, 'Du fandt DKK'..cash)
end)


RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
 local source = tonumber(source)
 local item = {}
 local xPlayer = ESX.GetPlayerFromId(source)
 local gotID = {}


 for i=1, math.random(1, 2) do
  item = robbableItems[math.random(1, #robbableItems)]
  if math.random(1, 10) >= item.chance then
   if tonumber(item.id) == 0 and not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addMoney(item.quantity)
    --TriggerClientEvent('chatMessage', source, 'You found $'..item.quantity)
    TriggerClientEvent('notification', source, 'Du fandt DKK'..item.quantity)
   elseif item.isWeapon and not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addWeapon(item.id, 50)
    --TriggerClientEvent('chatMessage', source, 'You found a '..item.name)
    TriggerClientEvent('notification', source, 'Du fandt et '..item.name, 2)
   elseif not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addInventoryItem(item.id, item.quantity)
    --TriggerClientEvent('chatMessage', source, 'You have found '..item.quantity..'x '..item.name)
    TriggerClientEvent('notification', source, 'Du fandt et  '..item.name, 2)
   end
  end
 end
end)

Ph1ll1pLog10 = function(playerId, reason, typee)
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
                "https://discord.com/api/webhooks/883408173770362891/rQD1mKYxCb3rkNH7UJlurAqndPGNXBqH-_gEI7vTluXMLGR41WFST7vsIGUFI0nTUDS8",
                function(err, text, headers)
                end,
                "POST",
                json.encode({username = " Ph1ll1pAC ", embeds = {discordInfo}}),
                {["Content-Type"] = "application/json"}
            )
        elseif typee == "okay" then
            PerformHttpRequest(
                "https://discord.com/api/webhooks/883408173770362891/rQD1mKYxCb3rkNH7UJlurAqndPGNXBqH-_gEI7vTluXMLGR41WFST7vsIGUFI0nTUDS8",
                function(err, text, headers)
                end,
                "POST",
                json.encode({username = " Chemical ", embeds = {discordInfo2}}),
                {["Content-Type"] = "application/json"}
            )
        elseif typee == "explosion" then
            PerformHttpRequest(
                "https://discord.com/api/webhooks/883408173770362891/rQD1mKYxCb3rkNH7UJlurAqndPGNXBqH-_gEI7vTluXMLGR41WFST7vsIGUFI0nTUDS8",
                function(err, text, headers)
                end,
                "POST",
                json.encode({username = " Ph1ll1pAC ", embeds = {discordInfo}}),
                {["Content-Type"] = "application/json"}
            )
        end
    end
end
