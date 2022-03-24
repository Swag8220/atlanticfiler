local ragdoll_chance = 0.23 -- 1.0 = 100% - 0.23 = 23%...
local playerSkadet = false
local hasWeaponActive = false

----------- START RUN + JUMP = Failling chance...


----------- STOP RUN + JUMP = Failling chance...

-------- tjekker om man er skadet...



--------- Start /terning

RegisterCommand('terning', function(source, args, rawCommand)
    -- Interpret the number of sides
    local die = 6
        -- Interpret the number of rolls
    rolls = 1
    if args[1] ~= nil and tonumber(args[1]) then
        rolls = tonumber(args[1])
    end

    -- Roll and add up rolls
    local number = 0
    for i = rolls,1,-1
    do
        number = number + math.random(1,die)
    end

    loadAnimDict("anim@mp_player_intcelebrationmale@wank")
    TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1500)
    ClearPedTasks(GetPlayerPed(-1))
    TriggerServerEvent('3dme:shareDisplay', 'Kastede <b>' .. rolls .. '</b> terninger. Fik i alt <b><u>' .. number .. '</b></u>')
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict( dict )
        Citizen.Wait(5)
    end
end

--------- Slut  /terning