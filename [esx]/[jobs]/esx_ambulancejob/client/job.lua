local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local IsBusy, isInService = false, false
local spawnedVehicles, isInShopMenu = {}, false
local PlayerData, dragStatus = nil, {}
dragStatus.isDragged = false

function OpenAmbulanceActionsMenu()
	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'}
	}

	--[[if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end]]--

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = "Læge",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenAmbulanceBossMenu()
	local elements = {}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_boss_actions', {
		title    = "Læge",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
			menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenMobileAmbulanceActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
		title    = "Læge Menu",
		align    = 'top-left',
		elements = {
			{label = _U('ems_menu_revive'), value = 'revive'},
			{label = _U('ems_menu_small'), value = 'small'},
			{label = _U('ems_menu_big'), value = 'big'},
			{label = _U('ems_menu_putincar'), value = 'put_in_vehicle'},
			{label = _U('ems_menu_takeoutcar'), value = 'take_out_vehicle'},
			{label = "Eskorter", value = 'escort_person'}
		}
	}, function(data, menu)

		if data.current.value == 'get_dna' then
			local player, distance = ESX.Game.GetClosestPlayer()
  
			if distance ~= -1 and distance <= 2.0 then
				TriggerEvent('jsfour-dna:get', player)
			end
		end
				
		if IsBusy then return end

		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

		if closestPlayer == -1 or closestDistance > 2.5 then
			ESX.ShowNotification(_U('no_players'))
		else

			if data.current.value == 'revive' then

				IsBusy = true

				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local closestPlayerPed = GetPlayerPed(closestPlayer)
						local id = GetPlayerServerId(closestPlayer)
						ESX.TriggerServerCallback('esx_ambulancejob:playerDead', function(deathStatus)
							
							if deathStatus then
								local playerPed = PlayerPedId()
								ESX.ShowNotification(_U('revive_inprogress'))
	
								local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
	
								for i=1, 15, 1 do
									Citizen.Wait(900)
									
									ESX.Streaming.RequestAnimDict(lib, function()
										TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
									end)
								end
	
								TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
								TriggerServerEvent('esx2_ambulancejob:revive', GetPlayerServerId(closestPlayer))
	
								-- Show revive award?
								if Config.ReviveReward > 0 then
									ESX.ShowNotification(_U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward))
								else
									ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
								end
							else
								ESX.ShowNotification(_U('player_not_unconscious'))
							end
						end,id)
					else
						ESX.ShowNotification(_U('not_enough_medikit'))
					end

					IsBusy = false

				end, 'medikit')

			elseif data.current.value == 'small' then

				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local closestPlayerPed = GetPlayerPed(closestPlayer)
						local health = GetEntityHealth(closestPlayerPed)

						if health > 0 then
							local playerPed = PlayerPedId()

							IsBusy = true
							ESX.ShowNotification(_U('heal_inprogress'))
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							Citizen.Wait(10000)
							ClearPedTasks(playerPed)

							TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
							TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
							ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
							IsBusy = false
						else
							ESX.ShowNotification(_U('player_not_conscious'))
						end
					else
						ESX.ShowNotification(_U('not_enough_bandage'))
					end
				end, 'bandage')

			elseif data.current.value == 'big' then

				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local closestPlayerPed = GetPlayerPed(closestPlayer)
						local health = GetEntityHealth(closestPlayerPed)

						if health > 0 then
							local playerPed = PlayerPedId()

							IsBusy = true
							ESX.ShowNotification(_U('heal_inprogress'))
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							Citizen.Wait(10000)
							ClearPedTasks(playerPed)

							TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
							TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
							ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
							IsBusy = false
						else
							ESX.ShowNotification(_U('player_not_conscious'))
						end
					else
						ESX.ShowNotification(_U('not_enough_medikit'))
					end
				end, 'medikit')

			elseif data.current.value == 'put_in_vehicle' then
				TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))

			elseif data.current.value == 'escort_person' then
				TriggerServerEvent('esx_ambulancejob:drag', GetPlayerServerId(closestPlayer))

			elseif data.current.value == 'take_out_vehicle' then
				TriggerServerEvent('esx_ambulancejob:OutVehicle', GetPlayerServerId(closestPlayer))
				TriggerServerEvent('esx_ambulancejob:drag', GetPlayerServerId(closestPlayer))
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end

function FastTravel(coords, heading)
	local playerPed = PlayerPedId()

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(500)
	end

	ESX.Game.Teleport(playerPed, coords, function()
		DoScreenFadeIn(800)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end

-- Draw markers & Marker logic
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local letSleep, isInMarker, hasExited = true, false, false
		local currentHospital, currentPart, currentPartNum
		
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			for hospitalNum,hospital in pairs(Config.Hospitals) do

				if hospital.jobStart ~= nil then
					for k,v in ipairs(hospital.jobStart) do
						local distance = GetDistanceBetweenCoords(playerCoords, v, true)

						if distance < Config.DrawDistance then
							DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
							letSleep = false
						end

						if distance < Config.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'JobStart', k
						end
					end
				end

				-- Ambulance Actions
				if hospital.Pharmacies ~= nil and isInService then
					for k,v in ipairs(hospital.AmbulanceActions) do
						local distance = GetDistanceBetweenCoords(playerCoords, v, true)

						if distance < Config.DrawDistance then
							DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
							letSleep = false
						end

						if distance < Config.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
						end
					end
				end

				-- Ambulance Cloakroom Menu
				if hospital.Pharmacies ~= nil and isInService then
					for k,v in ipairs(hospital.OpenCloakroomMenu) do
						local distance = GetDistanceBetweenCoords(playerCoords, v, true)

						if distance < Config.DrawDistance then
							DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
							letSleep = false
						end

						if distance < Config.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'OpenCloakroomMenu', k
						end
					end
				end

				-- Ambulance Boss Actions
				if hospital.Pharmacies ~= nil and isInService then
					for k,v in ipairs(hospital.AmbulanceBossActions) do
						local distance = GetDistanceBetweenCoords(playerCoords, v, true)

						if distance < Config.DrawDistance then
							DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
							letSleep = false
						end

						if distance < Config.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceBossActions', k
						end
					end
				end

				-- Pharmacies
				if hospital.Pharmacies ~= nil and isInService then
					for k,v in ipairs(hospital.Pharmacies) do
						local distance = GetDistanceBetweenCoords(playerCoords, v, true)

						if distance < Config.DrawDistance then
							DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
							letSleep = false
						end

						if distance < Config.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Pharmacy', k
						end
					end
				end

				-- Vehicle Spawners
				if hospital.Vehicles ~= nil and isInService then
					for k,v in ipairs(hospital.Vehicles) do
						local distanceSpawn = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)
						local distanceDeSpawn = GetDistanceBetweenCoords(playerCoords, v.DeSpawner, true)
						if distanceSpawn < Config.DrawDistance then
							DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
							DrawMarker(v.Marker.type, v.DeSpawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, 255,0,0,100, false, false, 2, v.Marker.rotate, nil, nil, false)
							letSleep = false
						end

						if distanceSpawn < v.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
						elseif distanceDeSpawn < v.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Delete', k
						end
					end
				end

				-- Helicopter Spawners
				if hospital.Helicopters ~= nil and isInService then
					for k,v in ipairs(hospital.Helicopters) do
						local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

						if distance < Config.DrawDistance then
							DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
							letSleep = false
						end

						if distance < v.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Helicopters', k
						end
					end
				end

			end

			-- Logic for exiting & entering markers
			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

				if
					(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

				TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)

			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance'  then
		
		if part == 'AmbulanceActions'and isInService then
			CurrentAction = part
			CurrentActionMsg = _U('actions_prompt')
			CurrentActionData = {}
		elseif part == 'AmbulanceBossActions'and isInService then
			CurrentAction = part
			CurrentActionMsg = _U('boss_prompt')
			CurrentActionData = {}
		elseif part == 'OpenCloakroomMenu'and isInService then
			CurrentAction = part
			CurrentActionMsg = _U('cloakroom_prompt')
			CurrentActionData = {}
		elseif part == 'Pharmacy' and isInService then
			CurrentAction = part
			CurrentActionMsg = _U('pharmacy_prompt')
			CurrentActionData = {}
		elseif part == 'Vehicles' and isInService then
			CurrentAction = part
			CurrentActionMsg = _U('garage_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'Helicopters' and isInService then
			CurrentAction = part
			CurrentActionMsg = _U('helicopter_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'Delete' and isInService then
			CurrentAction = part
			CurrentActionMsg = "Yikes"
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'JobStart' then
			CurrentAction = part
			CurrentActionMsg = "Tryk på ~INPUT_CONTEXT~ for at gå på arbejde"
			CurrentActionData = {hospital = hospital, partNum = partNum}
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(hospital, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CurrentAction == 'Delete' then
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
				ESX.ShowHelpNotification("Tryk på ~INPUT_CONTEXT~ for at slette dit ~r~Køretøj~s~")
				if IsControlJustReleased(0, 51) then
					DeleteEntity(GetVehiclePedIsIn(GetPlayerPed(-1)))
				end
			end
		elseif CurrentAction == "JobStart" then
			if isInService   then
				ESX.ShowHelpNotification("Tryk på ~INPUT_CONTEXT~ for at gå af ~y~arbejde~s~")
				if IsControlJustPressed(0, 51) then
					TriggerEvent("ems:fixService",false)
					TriggerEvent('esx_ambulancejob:updateBlip')
				end
			else 
				ESX.ShowHelpNotification("Tryk på ~INPUT_CONTEXT~ for at gå på ~y~arbejde~s~")
				if IsControlJustPressed(0, 51) then
					TriggerEvent("ems:fixService",true)
					TriggerEvent('esx_ambulancejob:updateBlip')
				end
				
			end
		elseif CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustPressed(0, Keys['E']) then

				if CurrentAction == 'AmbulanceActions' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'AmbulanceBossActions' then
					OpenAmbulanceBossMenu()
				elseif CurrentAction == 'OpenCloakroomMenu' then
					OpenCloakroomMenu()
				elseif CurrentAction == 'Pharmacy' then
					OpenPharmacyMenu()
				elseif CurrentAction == 'Vehicles' then
					OpenVehicleSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'Helicopters' then
					OpenHelicopterSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'FastTravelsPrompt' then
					FastTravel(CurrentActionData.to, CurrentActionData.heading)
				end

				CurrentAction = nil

			end
		elseif ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and not isDead then
			if IsControlJustReleased(0, 167) then
				OpenMobileAmbulanceActionsMenu()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:openEMSMenu')
AddEventHandler('esx_ambulancejob:openEMSMenu', function()
	if not IsDead then
		OpenMobileAmbulanceActionsMenu()
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				SetPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:OutVehicle')
AddEventHandler('esx_ambulancejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.EmsId))
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local p = GetEntityCoords(targetPed)
	SetEntityCoords(playerPed,p.x,p.y,p.z)
end)

RegisterNetEvent('esx_ambulancejob:drag')
AddEventHandler('esx_ambulancejob:drag', function(emsId)

	dragStatus.isDragged = not dragStatus.isDragged
	playerPed = PlayerPedId()
	local coords = GetEntityCoords(GetPlayerPed(-1))
	SetEntityCoords(GetPlayerPed(-1),coords.x,coords.y,coords.z+1)
	if dragStatus.isDragged == false then
		DetachEntity(playerPed, true, false)
	end
	dragStatus.EmsId = emsId
end)

-- Fix det her pls :(
Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsDead then
			playerPed = PlayerPedId()
			SetPlayerInvincible(playerPed, true)
			if dragStatus.isDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.EmsId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function OpenCloakroomMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = _U('ems_clothes_ems'), value = 'ambulance_wear'},
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'ambulance_wear' then
			
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function OpenVehicleSpawnerMenu(hospital, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	local elements = {
		{label = _U('garage_storeitem'), action = 'store_garage'},
		{label = _U('garage_buyitem'), action = 'buy_vehicle'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()
		if data.current.action == 'buy_vehicle' then
			local shopCoords = Config.Hospitals[hospital].Vehicles[partNum].InsideShop
			local shopElements = {}

			local authorizedVehicles = Config.AuthorizedVehicles[ESX.PlayerData.job.grade_name]

			if #authorizedVehicles > 0 then
				for k,vehicle in ipairs(authorizedVehicles) do
					table.insert(shopElements, {
						label = vehicle.label,
						name  = vehicle.label,
						model = vehicle.model,
						price = vehicle.price,
						type  = 'car'
					})
				end
			else
				return
			end

			OpenShopMenu(shopElements, playerCoords, shopCoords)
		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function StoreNearbyVehicle(playerCoords)
	local vehicle,dist = ESX.Game.GetClosestVehicle(playerCoords)
	if dist < 2 then
		DeleteEntity(vehicle)
		ESX.ShowNotification("Du har sat køretøjet i garagen")
	end
end

function GetAvailableVehicleSpawnPoint(hospital, part, partNum)
	local spawnPoints = Config.Hospitals[hospital][part][partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification(_U('garage_blocked'))
		return false
	end
end

function OpenHelicopterSpawnerMenu(hospital, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	ESX.PlayerData = ESX.GetPlayerData()
	local elements = {
		{label = _U('helicopter_store'), action = 'store_garage'},
		{label = _U('helicopter_buy'), action = 'buy_helicopter'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_spawner', {
		title    = _U('helicopter_title'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		menu.close()
		if data.current.action == 'buy_helicopter' then
			local shopCoords = Config.Hospitals[hospital].Helicopters[partNum].InsideShop
			local shopElements = {}

			local authorizedHelicopters = Config.AuthorizedHelicopters[ESX.PlayerData.job.grade_name]

			if #authorizedHelicopters > 0 then
				for k,helicopter in ipairs(authorizedHelicopters) do
					table.insert(shopElements, {
						label = ('%s - <span style="color:green;">%s</span>'):format(helicopter.label, _U('shop_item', ESX.Math.GroupDigits(helicopter.price))),
						name  = helicopter.label,
						model = helicopter.model,
						price = helicopter.price,
						type  = 'helicopter'
					})
				end
			else
				ESX.ShowNotification(_U('helicopter_notauthorized'))
				return
			end

			OpenShopMenu(shopElements, playerCoords, shopCoords)
		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function OpenShopMenu(elements, restoreCoords, shopCoords)
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	isInShopMenu = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title    = _U('vehicleshop_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()
		local plate = exports['esx_vehicleshop']:GeneratePlate()
		WaitForVehicleToLoad(data.current.model)
		local veh = CreateVehicle(data.current.model,pos.x,pos.y,pos.z,GetEntityHeading(playerPed),true,false)
		SetPedIntoVehicle(GetPlayerPed(-1),veh,-1)
		SetVehicleNumberPlateText(veh,plate)
	end, function(data, menu)
		menu.close()
	end)
end

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)

			DisableControlAction(0, Keys['TOP'], true)
			DisableControlAction(0, Keys['DOWN'], true)
			DisableControlAction(0, Keys['LEFT'], true)
			DisableControlAction(0, Keys['RIGHT'], true)
			DisableControlAction(0, 176, true) -- ENTER key
			DisableControlAction(0, Keys['BACKSPACE'], true)

			drawLoadingText(_U('vehicleshop_awaiting_model'), 255, 255, 255, 255)
		end
	end
end

function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
		title    = _U('pharmacy_menu_title'),
		align    = 'top-left',
		elements = {
			{label = _U('pharmacy_take', _U('medikit')), value = 'medikit'},
			{label = _U('pharmacy_take', _U('bandage')), value = 'bandage'},
			{label = _U('pharmacy_take', _U('stretcher')), value = 'stretcher'}
		}
	}, function(data, menu)
		TriggerServerEvent('esx_ambulancejob:giveItem', data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function WarpPedInClosestVehicle(ped)
	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

	if distance ~= -1 and distance <= 5.0 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end
	else
		ESX.ShowNotification(_U('no_vehicles'))
	end
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)

RegisterNetEvent('ems:fixService')
AddEventHandler('ems:fixService', function(state)
	isInService = state
	TriggerEvent("esx_personmeny:emsService",state)
end)



local blipsEMS = {}
RegisterNetEvent('esx_ambulancejob:updateBlip')
AddEventHandler('esx_ambulancejob:updateBlip', function()
	PlayerData = ESX.GetPlayerData()
	-- Refresh all blips
	for k, existingBlip in pairs(blipsEMS) do
		RemoveBlip(existingBlip)
	end

	-- Clean the blip table
	blipsEMS = {}

	-- Enable blip?
	if not isInService then
		return
	end

	-- Is the player a cop? In that case show all the blips for other cops
	if PlayerData.job and PlayerData.job.name == 'ambulance' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'ambulance' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlipo(GetPlayerServerId(id),id)
					end
				end
			end
		end)
	end

end)

function createBlipo(id,player)
	local ped = GetPlayerPed(player)
	local blip = GetBlipFromEntity(ped)

	ESX.TriggerServerCallback("getrpname",function(name)
		if not DoesBlipExist(blip) then -- Add blip and create head display on player
			blip = AddBlipForEntity(ped)
			SetBlipSprite(blip, 1)
			SetBlipColour(blip, 24)
			ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
			SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
			AddTextEntry('MYBLIP', "[~a~]")
			BeginTextCommandSetBlipName('MYBLIP')
			AddTextComponentSubstringPlayerName(name)
			EndTextCommandSetBlipName(blip)
			SetBlipScale(blip, 0.85) -- set scale
			SetBlipAsShortRange(blip, true)
	
			table.insert(blipsEMS, blip) -- add blip to array so we can remove it later
		end
	end,id)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.TriggerServerCallback('esx_service:isInService', function(isInServicey)
		isInService = isInServicey
		TriggerEvent("ems:fixService",isInServicey)
	end,"ambulance")
end)