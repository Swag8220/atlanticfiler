local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false
local currentSpot = 0

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

function OpenMechanicActionsMenu()
	local elements = {
		{label = _U('vehicle_list'),   value = 'vehicle_list'},
		{label = _U('work_wear'),      value = 'cloakroom'},
		{label = _U('civ_wear'),       value = 'cloakroom2'},
		{label = _U('deposit_stock'),  value = 'put_stock'},
		{label = _U('withdraw_stock'), value = 'get_stock'}
	}
	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_actions', {
		title    = _U('mechanic'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'vehicle_list' then
			if Config.EnableSocietyOwnedVehicles then

				local elements = {}

				ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
					for i=1, #vehicles, 1 do
						table.insert(elements, {
							label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
							value = vehicles[i]
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
						title    = _U('service_vehicle'),
						align    = 'center',
						elements = elements
					}, function(data, menu)
						menu.close()
						local vehicleProps = data.current.value
						ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos[currentSpot], 270.0, function(vehicle)
							ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						end)

						TriggerServerEvent('esx_society:removeVehicleFromGarage', 'mechanic', vehicleProps)
					end, function(data, menu)
						menu.close()
					end)
				end, 'mechanic')

			else

				local elements = {
					{label = _U('tow_truck'),  value = 'towtruck'},
					{label = _U('tow_truck2'), value = 'towtruck2'},
					{label = _U('flat_bed'), value = 'flatbed'}
				}

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
					title    = _U('service_vehicle'),
					align    = 'top-right',
					elements = elements
				}, function(data, menu)
					if Config.MaxInService == -1 then
						ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos[currentSpot], 358.0, function(vehicle)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						end)
					else
						ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
							if canTakeService then
								ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos[currentSpot], 358.0, function(vehicle)
									local playerPed = PlayerPedId()
									TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
								end)

							else
								ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
							end
						end, 'mechanic')
					end

					menu.close()
				end, function(data, menu)
					menu.close()
					OpenMechanicActionsMenu()
				end)

			end
		elseif data.current.value == 'cloakroom' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		elseif data.current.value == 'cloakroom2' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'mechanic', function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	end)
end

RegisterNetEvent('esx_mechanicjob:openmenu')
AddEventHandler('esx_mechanicjob:openmenu', function()
	OpenMobileMechanicActionsMenu()
end)

function OpenMobileMechanicActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_mechanic_actions', {
		title    = _U('mechanic'),
		align    = 'center',
		elements = {
			{label = _U('billing'),       value = 'billing'},
			{label = _U('hijack'),        value = 'hijack_vehicle'},
			{label = _U('repair'),        value = 'fix_vehicle'},
			{label = _U('repair_lift'),   value = 'fix_vehicle_lift'},
			{label = _U('clean'),         value = 'clean_vehicle'},
			{label = _U('imp_veh'),       value = 'del_vehicle'},
			{label = _U('load_vehicle'),  value = 'dep_vehicle'},
			{label = _U('place_objects'), value = 'object_spawner'}
	}}, function(data, menu)
		if isBusy then return end

		if data.current.value == 'billing' then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = _U('invoice_amount')
			}, function(data, menu)
				local amount = tonumber(data.value)

				if amount == nil or amount < 0 then
					ESX.ShowNotification(_U('amount_invalid'))
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('no_players_nearby'))
					else
						menu.close()
						TriggerServerEvent('esx_billing:serverloggingsendBill', GetPlayerServerId(closestPlayer), 'society_mechanic', _U('mechanic'), amount)
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		elseif data.current.value == 'hijack_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)

					ESX.ShowNotification(_U('vehicle_unlocked'))
					isBusy = false
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		elseif data.current.value == 'fix_vehicle' then 
			TriggerEvent('esx_mechanicjob:repairVehEng')
			--TriggerEvent('iens:repair')
		elseif data.current.value == 'fix_vehicle_lift' then
			TriggerEvent('esx_mechanicjob:repairVeh_lift')
		elseif data.current.value == 'clean_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDirtLevel(vehicle, 0)
					ClearPedTasksImmediately(playerPed)

					ESX.ShowNotification(_U('vehicle_cleaned'))
					isBusy = false
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		elseif data.current.value == 'del_vehicle' then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)

				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					ESX.ShowNotification(_U('vehicle_impounded'))
					ESX.Game.DeleteVehicle(vehicle)
				else
					ESX.ShowNotification(_U('must_seat_driver'))
				end
			else
				local vehicle = ESX.Game.GetVehicleInDirection()

				if DoesEntityExist(vehicle) then
					ESX.ShowNotification(_U('vehicle_impounded'))
					ESX.Game.DeleteVehicle(vehicle)
				else
					ESX.ShowNotification(_U('must_near'))
				end
			end
		elseif data.current.value == 'dep_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(playerPed, true)

			local towmodel = GetHashKey('flatbed')
			local isVehicleTow = IsVehicleModel(vehicle, towmodel)

			if isVehicleTow then
				local targetVehicle = ESX.Game.GetVehicleInDirection()

				if CurrentlyTowedVehicle == nil then
					if targetVehicle ~= 0 then
						if not IsPedInAnyVehicle(playerPed, true) then
							if vehicle ~= targetVehicle then
								AttachEntityToEntity(targetVehicle, vehicle, 54, 0.0, -2.35, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
								CurrentlyTowedVehicle = targetVehicle
								ESX.ShowNotification(_U('vehicle_success_attached'))

								if NPCOnJob then
									if NPCTargetTowable == targetVehicle then
										ESX.ShowNotification(_U('please_drop_off'))
										Config.Zones.VehicleDelivery.Type = 1

										if Blips['NPCTargetTowableZone'] then
											RemoveBlip(Blips['NPCTargetTowableZone'])
											Blips['NPCTargetTowableZone'] = nil
										end

										Blips['NPCDelivery'] = AddBlipForCoord(Config.Zones.VehicleDelivery.Pos.x, Config.Zones.VehicleDelivery.Pos.y, Config.Zones.VehicleDelivery.Pos.z)
										SetBlipRoute(Blips['NPCDelivery'], true)
									end
								end
							else
								ESX.ShowNotification(_U('cant_attach_own_tt'))
							end
						end
					else
						ESX.ShowNotification(_U('no_veh_att'))
					end
				else
					--AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 54, 0.0, -9.5, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
					DetachEntity(CurrentlyTowedVehicle, true, true)

					if NPCOnJob then
						if NPCTargetDeleterZone then

							if CurrentlyTowedVehicle == NPCTargetTowable then
								ESX.Game.DeleteVehicle(NPCTargetTowable)
								TriggerServerEvent('esx_mechanicjob:onNPCJobMissionCompleted')
								StopNPCJob()
								NPCTargetDeleterZone = false
							else
								ESX.ShowNotification(_U('not_right_veh'))
							end

						else
							ESX.ShowNotification(_U('not_right_place'))
						end
					end

					CurrentlyTowedVehicle = nil
					ESX.ShowNotification(_U('veh_det_succ'))
				end
			else
				ESX.ShowNotification(_U('imp_flatbed'))
			end
		elseif data.current.value == 'object_spawner' then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_mechanic_actions_spawn', {
				title    = _U('objects'),
				align    = 'top-right',
				elements = {
					{label = _U('roadcone'), value = 'prop_roadcone02a'},
					{label = _U('toolbox'),  value = 'prop_toolchest_01'}
			}}, function(data2, menu2)
				local model   = data2.current.value
				local coords  = GetEntityCoords(playerPed)
				local forward = GetEntityForwardVector(playerPed)
				local x, y, z = table.unpack(coords + forward * 1.0)

				if model == 'prop_roadcone02a' then
					z = z - 2.0
				elseif model == 'prop_toolchest_01' then
					z = z - 2.0
				end

				ESX.Game.SpawnObject(model, {x = x, y = y, z = z}, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_mechanicjob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('mechanic_stock'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_mechanicjob:getStockItem', itemName, count)

					Citizen.Wait(1000)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_mechanicjob:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type  = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('inventory'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_mechanicjob:putStockItems', itemName, count)

					Citizen.Wait(1000)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx_mechanicjob:repairVehEng')
AddEventHandler('esx_mechanicjob:repairVehEng', function()
    local ped = GetPlayerPed(-1)
	local vehicle   = ESX.Game.GetVehicleInDirection()
	if DoesEntityExist(vehicle) then
		isBusy = true
		TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BUM_BIN', 0, true)
		SetVehicleDoorOpen(vehicle, 4, false, false)
		Citizen.CreateThread(function()
			Citizen.Wait(60000)

			SetVehicleDeformationFixed(vehicle)
			SetVehicleUndriveable(vehicle, false)
			SetVehicleFixed(vehicle)
			SetVehicleDoorOpen(vehicle, 4, false, true)
			ClearPedTasks(ped)
			Citizen.Wait(2300)
			SetVehicleDoorShut(vehicle, 4, false)

			ESX.ShowNotification(_U('vehicle_repaired'))
			isBusy = false
		end)
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end
end)

RegisterNetEvent('esx_mechanicjob:repairVeh')
AddEventHandler('esx_mechanicjob:repairVeh', function(veh)
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)
	reparing = true

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('inside_vehicle'))
		return
	end

	if veh ~= nil then
		vehicle = veh
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
		SetVehicleDoorOpen(vehicle, 4, false, false)
		Citizen.CreateThread(function()
			Citizen.Wait(60000)

			SetVehicleDeformationFixed(vehicle)
			SetVehicleUndriveable(vehicle, false)
			SetVehicleFixed(vehicle)
			SetVehicleDoorOpen(vehicle, 4, false, true)
			ClearPedTasks(playerPed)
			Citizen.Wait(2300)
			SetVehicleDoorShut(vehicle, 4, false)

			ESX.ShowNotification(_U('vehicle_repaired'))
			isBusy = false
		end)
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end
	reparing = false
end)

RegisterNetEvent('esx_mechanicjob:repairVeh_lift')
AddEventHandler('esx_mechanicjob:repairVeh_lift', function(veh)
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('inside_vehicle'))
		return
	end

	if veh ~= nil then
		vehicle = veh
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
		SetVehicleDoorOpen(vehicle, 4, false, false)
		Citizen.CreateThread(function()
			Citizen.Wait(60000)

			SetVehicleDeformationFixed(vehicle)
			SetVehicleUndriveable(vehicle, false)
			SetVehicleFixed(vehicle)
			SetVehicleDoorOpen(vehicle, 4, false, true)
			ClearPedTasks(playerPed)
			Citizen.Wait(2300)
			SetVehicleDoorShut(vehicle, 4, false)

			ESX.ShowNotification(_U('vehicle_repaired'))
			isBusy = false
		end)
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end
end)

RegisterNetEvent('esx_mechanicjob:onHijack')
AddEventHandler('esx_mechanicjob:onHijack', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end

			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification(_U('veh_unlocked'))
				else
					ESX.ShowNotification(_U('hijack_failed'))
					ClearPedTasksImmediately(playerPed)
				end
			end)
		end
	end
end)

RegisterNetEvent('esx_mechanicjob:onCarokit')
AddEventHandler('esx_mechanicjob:onCarokit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('body_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('esx_mechanicjob:onFixkit')
AddEventHandler('esx_mechanicjob:onFixkit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(20000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('veh_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('esx_mechanicjob:hasEnteredMarker', function(zone)
	if zone == 'NPCJobTargetTowable' then

	elseif zone =='VehicleDelivery' then
		NPCTargetDeleterZone = true
	elseif zone == 'MechanicActions' then
		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed,  false)

			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = _U('veh_stored')
			CurrentActionData = {vehicle = vehicle}
		end
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedMarker', function(zone)
	if zone =='VehicleDelivery' then
		NPCTargetDeleterZone = false
	elseif zone == 'Craft' then
		TriggerServerEvent('esx_mechanicjob:stopCraft')
		TriggerServerEvent('esx_mechanicjob:stopCraft2')
		TriggerServerEvent('esx_mechanicjob:stopCraft3')
	elseif zone == 'Garage' then
		TriggerServerEvent('esx_mechanicjob:stopHarvest')
		TriggerServerEvent('esx_mechanicjob:stopHarvest2')
		TriggerServerEvent('esx_mechanicjob:stopHarvest3')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('esx_mechanicjob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' and not IsPedInAnyVehicle(playerPed, false) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('press_remove_obj')
		CurrentActionData = {entity = entity}
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('mechanic'),
		number     = 'mechanic',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)



-- Pop NPC mission vehicle when inside area
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if NPCTargetTowableZone and not NPCHasSpawnedTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCSpawnDistance then
				local model = Config.Vehicles[GetRandomIntInRange(1,  #Config.Vehicles)]

				ESX.Game.SpawnVehicle(model, zone.Pos, 0, function(vehicle)
					NPCTargetTowable = vehicle
				end)

				NPCHasSpawnedTowable = true
			end
		end

		if NPCTargetTowableZone and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCNextToDistance then
				ESX.ShowNotification(_U('please_tow'))
				NPCHasBeenNextToTowable = true
			end
		end
	end
end)

-- Create Blips
-- Citizen.CreateThread(function()
-- 	local blip = AddBlipForCoord(Config.Zones.MechanicActions.Pos.x, Config.Zones.MechanicActions.Pos.y, Config.Zones.MechanicActions.Pos.z)

-- 	SetBlipSprite (blip, 446)
-- 	SetBlipDisplay(blip, 4)
-- 	SetBlipScale  (blip, 0.7)
-- 	SetBlipColour (blip, 5)
-- 	SetBlipAsShortRange(blip, true)

-- 	BeginTextCommandSetBlipName('STRING')
-- 	AddTextComponentSubstringPlayerName(_U('mechanic'))
-- 	EndTextCommandSetBlipName(blip)
-- end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k,v in pairs(Config.Zones) do
				for i,pos in pairs(v.Pos) do
					if v.Type ~= -1 and GetDistanceBetweenCoords(coords, pos[1], pos[2], pos[3], true) < Config.DrawDistance then
						DrawMarker(v.Type, pos[1], pos[2], pos[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
						letSleep = false
					end
				end
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then

			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				for i,pos in pairs(v.Pos) do
					if(GetDistanceBetweenCoords(coords, pos[1], pos[2], pos[3], true) < v.Size.x+1) then
						isInMarker  = true
						currentZone = k
						currentSpot = tonumber(i)
					end
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_mechanicjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_mechanicjob:hasExitedMarker', LastZone)
			end

		end
	end
end)

Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_toolchest_01'
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
			--	TriggerEvent('esx_mechanicjob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('esx_mechanicjob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then

				if CurrentAction == 'mechanic_actions_menu' then
					OpenMechanicActionsMenu()
				elseif CurrentAction == 'delete_vehicle' then

					if Config.EnableSocietyOwnedVehicles then

						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx2_society:putVehicleInGarage', 'mechanic', vehicleProps)

					else

						if
							GetEntityModel(vehicle) == GetHashKey('flatbed')   or
							GetEntityModel(vehicle) == GetHashKey('towtruck') or
							GetEntityModel(vehicle) == GetHashKey('towtruck2')
						then
							TriggerServerEvent('esx_service:disableService', 'mechanic')
						end

					end

					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)

				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
			end
		end

		if IsControlJustReleased(0, 167) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			OpenMobileMechanicActionsMenu()
		end

	end
end)

local timer = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			for k, item in pairs(Config.lifts) do
				local Pped = GetPlayerPed(-1)
				if GetDistanceBetweenCoords(GetEntityCoords(Pped), item.enteryPos[1], item.enteryPos[2], item.enteryPos[3], true ) < 20 then
					DrawMarker(27, item.enteryPos[1], item.enteryPos[2], item.enteryPos[3]-0.99, 0, 0, 0, 0, 0, 0, 1.75, 1.75, 1.75, 255, 16, 16, 100, 0, 0, 1, 0.5)
					if GetDistanceBetweenCoords(GetEntityCoords(Pped), item.enteryPos[1], item.enteryPos[2], item.enteryPos[3], true ) < 2.5 then
						if IsPedInAnyVehicle(Pped) then
							drawTxt("Tryk ~INPUT_TALK~ for at sætte køretøjet op.")
							if IsControlJustPressed(1,46) then
								if item.currentVeh == nil then
								item.currentVeh = GetVehiclePedIsIn(Pped,false)
								TaskLeaveVehicle(Pped,item.currentVeh,0)
								Wait(3000)
								FreezeEntityPosition(item.currentVeh, true)
								SetEntityCoordsNoOffset(item.currentVeh, item.liftPos[1], item.liftPos[2], item.liftPos[3],1,0,0,1)
								SetEntityHeading(item.currentVeh, item.liftPos[4])
								item.localcurrentVeh = item.currentVeh
								TriggerServerEvent('esx_mechanicjob:synchServer', item.id, item.currentVeh)
								else
									ESX.ShowNotification("Der er allerde et køretøj på liften!")
								end
							end
						else
							if item.currentVeh ~= nil and item.localcurrentVeh ~= nil then
								drawTxt("Tryk ~INPUT_TALK~ for at tage køretøjet ned.")
								if IsControlJustPressed(1,46) then
									ESX.ShowNotification("Køretøjet er på vej ned af liften!")
									Wait(3000)
									FreezeEntityPosition(item.currentVeh, false)
									SetEntityCoords(item.currentVeh, item.enteryPos[1], item.enteryPos[2], item.enteryPos[3],1,0,0,1)
									item.currentVeh = nil
									item.localcurrentVeh = nil
									TriggerServerEvent('esx_mechanicjob:synchServer', item.id,nil)
								end
							end
						end
					end
				end

				if GetDistanceBetweenCoords(GetEntityCoords(Pped), item.adjustPos[1], item.adjustPos[2], item.adjustPos[3], true ) < 10 then
					DrawMarker(27, item.adjustPos[1], item.adjustPos[2], item.adjustPos[3]-0.99, 0, 0, 0, 0, 0, 0, 0.75, 0.75, 0.75, 255, 16, 16, 100, 0, 0, 1, 0.5)
					if GetDistanceBetweenCoords(GetEntityCoords(Pped), item.adjustPos[1], item.adjustPos[2], item.adjustPos[3], true ) < 0.5 then
						drawTxt("Brug ~g~Piletasterne~s~ til at justere")
						if item.currentVeh ~= nil then
							if IsControlJustPressed(1,172) then -- Up
								if item.liftPos[3] < item.liftPosUpper then
									item.liftPos[3] =  item.liftPos[3] + 0.1
									SetEntityCoordsNoOffset(item.currentVeh, item.liftPos[1], item.liftPos[2], item.liftPos[3],1,0,0,1)
								else
									ESX.ShowNotification("køretøjet kan ikke blive lyftet højere!")
								end
							elseif IsControlJustPressed(1,173) then -- Down
								if item.liftPos[3] > item.liftPosLower then
									item.liftPos[3] =  item.liftPos[3] - 0.1
									SetEntityCoordsNoOffset(item.currentVeh, item.liftPos[1], item.liftPos[2], item.liftPos[3],1,0,0,1)
								else
									ESX.ShowNotification("køretøjet kan ikke blive sænket lavere!")
								end
							elseif IsControlJustPressed(1,174) then -- left
								item.liftPos[4] = item.liftPos[4] + 0.5
								SetEntityHeading(item.currentVeh, item.liftPos[4])
							elseif IsControlJustPressed(1,175) then -- riigt
								item.liftPos[4] = item.liftPos[4] - 0.5
								SetEntityHeading(item.currentVeh, item.liftPos[4])
							end
						end
					end
				end
			end
		end
  	end
end)


Citizen.CreateThread(function()
	while true do
		Wait(1000)
		if timer > 0 then
			timer=timer-1
		end
	end
end)

function drawTxt(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local mechaniconline = false

function updatemechs(connectedPlayers)
	mechaniconline = false
	for k,v in pairs(connectedPlayers) do
		if v.job == 'mechanic' then
			mechaniconline = true
		end
	end
end

local reparing = false
local isreparable = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if (ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic') then
			local ped = GetPlayerPed(-1)
			for k, pos in pairs(Config.RepairPoints.Pos) do
				if GetDistanceBetweenCoords(GetEntityCoords(ped), pos[1], pos[2], pos[3], true ) < Config.DrawDistance then
					if pos.veh == nil then
						DrawMarker(Config.RepairPoints.Type, pos[1], pos[2], pos[3], 0, 0, 0, 0, 0, 0,Config.RepairPoints.Size.x, Config.RepairPoints.Size.y, Config.RepairPoints.Size.z, Config.RepairPoints.Color.r, Config.RepairPoints.Color.g, Config.RepairPoints.Color.b, 100, 0, 0, 1, 0)
					end
					if GetDistanceBetweenCoords(GetEntityCoords(ped), pos[1], pos[2], pos[3], true ) < Config.RepairPoints.Size.x+1 then
						if IsPedInAnyVehicle(ped) and pos.veh == nil then
							drawTxt("Tryk ~INPUT_FRONTEND_ACCEPT~ for at begynde at arbejde med køretøjet")
							if IsControlJustPressed(1,201) then
								local vehicle = GetVehiclePedIsIn(ped, false)
								FreezeEntityPosition(vehicle, true)
								pos.veh = vehicle
							end
						elseif pos.veh ~= nil then
							local vehicle = GetVehiclePedIsIn(ped, false)
							local inveh = false
							if vehicle == pos.veh then
								if reparing == false then
									inveh = true
									drawTxt("Tryk ~INPUT_FRONTEND_ACCEPT~ frigøre køretøjet")
									if IsControlJustPressed(1,201) then
										FreezeEntityPosition(pos.veh, false)
										pos.veh = nil
										isreparable = false
									end
								end
							else
								local x,y,z = table.unpack(GetEntityCoords(pos.veh,true))
								local dx,dy = table.unpack(GetEntityForwardVector(pos.veh))
								local fx,fy = x+dx*2, y+dy*2
								local bx,by = x+dx*-2, y+dy*-2
								local lx,ly = x+(-dy),y+dx
								local rx,ry = x-(-dy),y-dx
								if GetDistanceBetweenCoords(GetEntityCoords(ped), lx, ly, z, false ) < 1.5 then
									ESX.Game.Utils.DrawText3D({x = lx, y = ly, z = z}, 'Tryk på [~g~ENTER~w~] for at åbne venstre sidedøre', 0.55)
									if IsControlJustPressed(1,201) then
										if IsVehicleDoorFullyOpen(pos.veh, 0) == false and IsVehicleDoorFullyOpen(pos.veh, 2) == false then
											SetVehicleDoorOpen(pos.veh, 0, true, true)
											SetVehicleDoorOpen(pos.veh, 2, true, true)
										else
											SetVehicleDoorShut(pos.veh, 0, false)
											SetVehicleDoorShut(pos.veh, 2, false)
										end
									end
								elseif GetDistanceBetweenCoords(GetEntityCoords(ped), rx, ry, z, false ) < 1.5 then
									ESX.Game.Utils.DrawText3D({x = rx, y = ry, z = z}, 'Tryk på [~g~ENTER~w~] for at åbne højre sidedøre', 0.55)
									if IsControlJustPressed(1,201) then
										if IsVehicleDoorFullyOpen(pos.veh, 1) == false and IsVehicleDoorFullyOpen(pos.veh, 3) == false then
											SetVehicleDoorOpen(pos.veh, 1, true, true)
											SetVehicleDoorOpen(pos.veh, 3, true, true)
										else
											SetVehicleDoorShut(pos.veh, 1, false)
											SetVehicleDoorShut(pos.veh, 3, false)
										end
									end
								elseif GetDistanceBetweenCoords(GetEntityCoords(ped), fx, fy, z, false ) < 3.5 then
									ESX.Game.Utils.DrawText3D({x = fx, y = fy, z = z}, 'Tryk på [~g~ENTER~w~] for at åbne kølerhjelmen', 0.55)
									if IsControlJustPressed(1,201) then
										if IsVehicleDoorFullyOpen(pos.veh, 4) == false then
											SetVehicleDoorOpen(pos.veh, 4, true, true)
											isreparable = true
										else
											SetVehicleDoorShut(pos.veh, 4, false)
											isreparable = false
										end
									end
								elseif GetDistanceBetweenCoords(GetEntityCoords(ped), bx, by, z, false ) < 3.5 then
									ESX.Game.Utils.DrawText3D({x = bx, y = by, z = z}, 'Tryk på [~g~ENTER~w~] for at åbne bagagerummet', 0.55)
									if IsControlJustPressed(1,201) then
										if IsVehicleDoorFullyOpen(pos.veh, 5) == false then
											SetVehicleDoorOpen(pos.veh, 5, true, true)
										else
											SetVehicleDoorShut(pos.veh, 5, false)
										end
									end
								end
							end
							if isreparable and not inveh and not reparing then
								drawTxt("Tryk ~INPUT_TALK~ for at reparere køretøjet")
								if IsControlJustPressed(1,46) then
									TriggerEvent('esx_mechanicjob:repairVeh', pos.veh)
								end
							end
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		ESX.TriggerServerCallback('esx_mechanicjob:getConnectedPlayers', function(connectedPlayers)
			updatemechs(connectedPlayers)
		end)
		Citizen.Wait(20000)
	end
end)

RegisterNetEvent('esx_mechanicjob:updateConnectedPlayers')
AddEventHandler('esx_mechanicjob:updateConnectedPlayers', function(connectedPlayers)
	updatemechs(connectedPlayers)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

-- ESX VEHICLE PUSH

local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)

local Vehicle = {Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil}
Citizen.CreateThread(function()
    Citizen.Wait(200)
    while true do
        local ped = PlayerPedId()
        local closestVehicle, Distance = ESX.Game.GetClosestVehicle()
        local vehicleCoords = GetEntityCoords(closestVehicle)
        local dimension = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)
        if Distance < 6.0  and not IsPedInAnyVehicle(ped, false) then
            Vehicle.Coords = vehicleCoords
            Vehicle.Dimensions = dimension
            Vehicle.Vehicle = closestVehicle
            Vehicle.Distance = Distance
            if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
                Vehicle.IsInFront = false
            else
                Vehicle.IsInFront = true
            end
        else
            Vehicle = {Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil}
        end
        Citizen.Wait(500)
    end
end)

function DrawText3Ds(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())

	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
	end
end



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if GetEntityHealth(ped) ~= 100 then
			if Vehicle.Vehicle ~= nil then

				if IsVehicleSeatFree(Vehicle.Vehicle, -1) and GetVehicleEngineHealth(Vehicle.Vehicle) <= Config.DamageNeeded then
					--ESX.Game.Utils.DrawText3D({x = Vehicle.Coords.x, y = Vehicle.Coords.y, z = Vehicle.Coords.z}, 'Tryk på [~g~CAPS~w~] for at skubbe køretøjet', 0.55)
					DrawText3Ds(Vehicle.Coords.x,Vehicle.Coords.y,Vehicle.Coords.z, "[~g~CAPS~w~] for at skubbe køretøjet")
				end


				if IsControlPressed(0, Keys["CAPS"]) and IsVehicleSeatFree(Vehicle.Vehicle, -1) and not IsEntityAttachedToEntity(ped, Vehicle.Vehicle) and GetVehicleEngineHealth(Vehicle.Vehicle) <= Config.DamageNeeded then
					NetworkRequestControlOfEntity(Vehicle.Vehicle)
					local coords = GetEntityCoords(ped)
					if Vehicle.IsInFront then
						AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y * -1 + 0.1 , Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
					else
						AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y - 0.3, Vehicle.Dimensions.z  + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
					end

					ESX.Streaming.RequestAnimDict('missfinale_c2ig_11')
					TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
					Citizen.Wait(200)

					local currentVehicle = Vehicle.Vehicle
					while true do
						Citizen.Wait(5)
						if IsDisabledControlPressed(0, Keys["A"]) then
							TaskVehicleTempAction(PlayerPedId(), currentVehicle, 11, 1000)
						end

						if IsDisabledControlPressed(0, Keys["D"]) then
							TaskVehicleTempAction(PlayerPedId(), currentVehicle, 10, 1000)
						end

						if Vehicle.IsInFront then
							SetVehicleForwardSpeed(currentVehicle, -1.0)
						else
							SetVehicleForwardSpeed(currentVehicle, 1.0)
						end

						if HasEntityCollidedWithAnything(currentVehicle) then
							SetVehicleOnGroundProperly(currentVehicle)
						end

						if not IsDisabledControlPressed(0, Keys["CAPS"]) then
							DetachEntity(ped, false, false)
							StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
							FreezeEntityPosition(ped, false)
							break
						end
					end
				end
			end
		end
	end
end)
