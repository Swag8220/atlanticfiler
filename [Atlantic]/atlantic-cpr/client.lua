AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:spawnPlayer() -- Ensure player spawns into server.
	Citizen.Wait(2500)
	exports.spawnmanager:setAutoSpawn(false)
end)

local tries = 0
RegisterCommand('cpr', function()
	if (GetGameTimer() - 1000) > (1 * 10000) then
		closest, distance = GetClosestPlayer()
		if closest ~= nil and DoesEntityExist(GetPlayerPed(closest)) then
			if distance -1 and distance < 3 then
				if IsPedDeadOrDying(GetPlayerPed(closest)) then
					if tries < 5 then 
						local closestID = GetPlayerServerId(closest)
						local chance = math.random(0, 100)
						loadAnimDict("mini@cpr@char_a@cpr_str")
						loadAnimDict("mini@cpr@char_a@cpr_def")

						TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_def", "cpr_intro", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
						Citizen.Wait(2000)
						TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, 1.0, -1, 9, 0, 0, 0, 0)
						Citizen.Wait(7000)
						TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_def", "cpr_success", 8.0, 1.0, -1, 2, 0, 0, 0, 0)

						tries = tries + 1
						if chance <= 25 then
							TriggerServerEvent('reviveServer', closestID)
							exports['mythic_notify']:DoHudText('inform', 'Du fik ' .. GetPlayerName(closest) .. ' op på (' .. tries ..'/5 Forsøg brugte)', { ['background-color'] = '#7b4ab0', ['color'] = '#ffffff' })
						else
							exports['mythic_notify']:DoHudText('inform', 'Du fejlede dit CPR forsøg ' .. GetPlayerName(closest) .. ' prøv igen! (' .. tries ..'/5 Forsøg brugte)', { ['background-color'] = '#ab1a32', ['color'] = '#ffffff' })
						end
					else
						exports['mythic_notify']:DoHudText('inform', 'Du er for sløj til at udøve CPR.', { ['background-color'] = '#ab1a32', ['color'] = '#ffffff' })
						Citizen.Wait(60 * 60000)
						tries = 0
						exports['mythic_notify']:DoHudText('inform', 'Dit energiniveau steg. Du kan nu udøve CPR igen.', { ['background-color'] = '#7b4ab0', ['color'] = '#ffffff' })
					end
				else
					exports['mythic_notify']:DoHudText('inform', '' .. GetPlayerName(closest) .. ' har ikke brug for CPR!', { ['background-color'] = '#ab1a32', ['color'] = '#ffffff' })
				end
			else
				exports['mythic_notify']:DoHudText('inform', 'Ingen spillere i nærheden!', { ['background-color'] = '#ab1a32', ['color'] = '#ffffff' })
			end
		end
	else
		exports['mythic_notify']:SendAlert('error', 'Du kan ikke spamme /CPR', 5000)
	end
end)

RegisterNetEvent('reviveClient')
AddEventHandler('reviveClient', function()
	local plyCoords = GetEntityCoords(PlayerPedId(), true)
	TriggerEvent('esx2_ambulancejob:revive')
	ResurrectPed(PlayerPedId())
	SetEntityHealth(PlayerPedId(), 200)
	ClearPedTasksImmediately(PlayerPedId())
	SetEntityCoords(PlayerPedId(), plyCoords.x, plyCoords.y, plyCoords.z + 1.0, 0, 0, 0, 0)
end)

function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
			table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if target ~= ply then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end