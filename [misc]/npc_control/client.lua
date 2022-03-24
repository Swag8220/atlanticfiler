ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100) 
        for ped in EnumeratePeds() do
            if DoesEntityExist(ped) then
				for i,model in pairs(cfg.peds) do
					if (GetEntityModel(ped) == GetHashKey(model)) then
						veh = GetVehiclePedIsIn(ped, false)
						SetEntityAsNoLongerNeeded(ped)
						SetEntityCoords(ped,3000.0,8000.0,0.0,1,0,0,1)
						if veh ~= nil then
							SetEntityAsNoLongerNeeded(veh)
							SetEntityCoords(ped,3000.0,8000.0,0.0,1,0,0,1)
						end
					end
				end
				for i,model in pairs(cfg.noguns) do
					if (GetEntityModel(ped) == GetHashKey(model)) then
						RemoveAllPedWeapons(ped, true)
					end
				end
				for i,model in pairs(cfg.nodrops) do
					if (GetEntityModel(ped) == GetHashKey(model)) then
						SetPedDropsWeaponsWhenDead(ped,false) 
					end
				end
			end
			Citizen.Wait(2)
		end
        for k,veh in pairs(ESX.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1), false), 100)) do
            if DoesEntityExist(veh) then
				for i,model in pairs(cfg.vehs) do
					if (GetEntityModel(veh) == GetHashKey(model)) then
						SetEntityAsNoLongerNeeded(veh)
						SetEntityCoords(ped,3000.0,8000.0,0.0,1,0,0,1)
					end
				end
			end
		end
    end
end)

Citizen.CreateThread(function()
    while true 
        do
         -- These natives has to be called every frame.
        SetPedDensityMultiplierThisFrame(cfg.density.peds)
        SetScenarioPedDensityMultiplierThisFrame(cfg.density.peds, cfg.density.peds)
        SetVehicleDensityMultiplierThisFrame(cfg.density.vehicles)
        SetRandomVehicleDensityMultiplierThisFrame(cfg.density.vehicles)
        SetParkedVehicleDensityMultiplierThisFrame(cfg.density.vehicles)
        Citizen.Wait(0)
    end
end)
