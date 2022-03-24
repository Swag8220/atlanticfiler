bedNames = { 'v_med_bed1', 'v_med_bed2'} -- Add more model strings here if you'd like
bedHashes = {}
animDict = 'anim@gangops@morgue@table@'
animName = 'ko_front'
isOnBed = false

CreateThread(function()
    for k,v in ipairs(bedNames) do
        table.insert( bedHashes, GetHashKey(v))
    end
end)

RegisterCommand('bed', function()
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        if isOnBed then
            ClearPedTasksImmediately(playerPed)
            isOnBed = false
            return
        end

        local playerPos = GetEntityCoords(playerPed, true)

        local bed = nil

        for k,v in ipairs(bedHashes) do
            bed = GetClosestObjectOfType(playerPos.x, playerPos.y, playerPos.z, 4.0, v, false, false, false)
            if bed ~= 0 then
                break
            end
        end

        if bed ~= nil and DoesEntityExist(bed) then
            if not HasAnimDictLoaded(animDict) then
                RequestAnimDict(animDict)
            end
            local bedCoords = GetEntityCoords(bed)
            FreezeEntityPosition(object, true)
            FreezeEntityPosition(ped, true)
            SetEntityCoords(playerPed, bedCoords.x , bedCoords.y, bedCoords.z, 1, 1, 0, 0)
            SetEntityHeading(playerPed, GetEntityHeading(bed) + 180.0)
            TaskPlayAnim(playerPed,animDict, animName, 8.0, 1.0, -1, 45, 1.0, 0, 0, 0)
            local ply = PlayerPedId()
            local health = GetEntityHealth(ply)
            print(health)
            if health > 100 and health <= 199 then
                exports['progressBars']:startUI(30000, "Healer")
                Citizen.Wait(30000)
                SetEntityHealth(ply, health + 100)
            elseif health <= 100 then
                exports['progressBars']:startUI(30000, "Healer")
                Citizen.Wait(30000)
                TriggerEvent('esx2_ambulancejob:revive')
            end

            isOnBed = true
        end
    end)
end, false)

--[[RegisterCommand('end', function()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed, true)
    local bedHash = GetHashKey('v_med_bed1')
    CreateObject(bedHash, playerPos.x, playerPos.y + 1.0, playerPos.z - 0.95, true, true, true)
end, false)]]