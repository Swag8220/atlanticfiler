local PlayerData, CurrentActionData, handcuffTimer, dragStatus = {}, {}, {}, {}
local IsHandcuffed = false
dragStatus.isDragged = false
local IsHandcuffed            = false
ESX = nil
blip = nil
local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastStation             = nil
local LastPart                = nil
local LastPartNum             = nil
local LastEntity              = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsHandcuffed            = false
local HandcuffTimer           = {}
local DragStatus              = {}
DragStatus.IsDragged          = false
local hasAlreadyJoined        = false
local blipsCops               = {}
local isDead                  = false
local CurrentTask             = {}
local playerInService         = false
local strips 				  = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    Citizen.Wait(5000)
    PlayerData = ESX.GetPlayerData()
end)


Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
	local playerPed = GetPlayerPed(-1)
		if IsControlJustReleased(0, 28) and not IsEntityDead(playerPed)  then
			OpenSearchActionsMenu()
        end
    end
end)

function OpenSearchActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'interakce', {
		css      = 'interakce',
		title    = 'Funktioner',
		align    = 'top-left',
		elements = {
            {label = ('Strips på / af'), value = 'handcuff'},
--            {label = ('Uncuff'), value = 'uncuff'},
            {label = ('Eskorter'), value = 'drag'},
		--	{label = ('Tjek Lommer'), value = 'body_search'},
            {label = ('Sæt i køretøj'), value = 'put_in_vehicle'},
            {label = ('Tag ud af køretøj'), value = 'out_the_vehicle'},
	}}, function(data, menu)

		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			local action = data.current.value

			if data.current.value == 'body_search' then
				TriggerServerEvent('esx_okradanie:message', GetPlayerServerId(closestPlayer), ('Du bliver visiteret.'))
				OpenBodySearchMenu(closestPlayer)
			elseif data.current.value == 'handcuff' then
			if strips == false then
				print(strips)
				
				local target, distance = ESX.Game.GetClosestPlayer()
				playerheading = GetEntityHeading(GetPlayerPed(-1))
				playerlocation = GetEntityForwardVector(PlayerPedId())
				playerCoords = GetEntityCoords(GetPlayerPed(-1))
				local target_id = GetPlayerServerId(target)

				if distance <= 2.0 then
					ESX.TriggerServerCallback('esx_okradanie:sitem', function(quantity)
						if quantity >= 1 then
							TriggerEvent('3dme:triggerDisplay', "Sætter strips på nærmeste person!",  -1)
							strips = true
							TriggerServerEvent('Atlantic_thiefmenu:handcuff', GetPlayerServerId(closestPlayer))
							TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'zipties', 0.2)
						else
							ESX.ShowNotification('Du har ikke strips')
						end
					end, 'strips') -- change item here
				end
			else
				strips = false
	TriggerServerEvent('Atlantic_thiefmenu:handcuff2', GetPlayerServerId(closestPlayer))
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'scissors', 0.2)
			end
			elseif data.current.value == 'drag' then
				TriggerServerEvent('Atlantic_thiefmenu:drag', GetPlayerServerId(closestPlayer))
			elseif data.current.value == 'put_in_vehicle' then
				TriggerServerEvent('Atlantic_thiefmenu:putInVehicle', GetPlayerServerId(closestPlayer))
			elseif data.current.value == 'out_the_vehicle' then
				TriggerServerEvent('Atlantic_thiefmenu:OutVehicle', GetPlayerServerId(closestPlayer))
			end
		else
			ESX.ShowNotification('Ingen spiller ved siden!')
		end
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('Atlantic_thiefmenu:putInVehicle')
AddEventHandler('Atlantic_thiefmenu:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if not IsHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				DragStatus.IsDragged = false
			end
		end
	end
end)

--[[function OpenBodySearchMenu(player)
	TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(player), GetPlayerName(player))
end]]

function OpenBodySearchMenu(player)
	if strips == true then
		ESX.TriggerServerCallback('Atlantic_thiefmenu:getOtherPlayerData', function(data)
			TriggerEvent('3dme:triggerDisplay', "Tjekker persons lommer!",  -1)

			local elements = {}

			for i=1, #data.accounts, 1 do

				if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then

					table.insert(elements, {
						label    = _U('confiscate_dirty', ESX.Round(data.accounts[i].money)),
						value    = 'black_money',
						itemType = 'item_account',
						amount   = data.accounts[i].money
					})

					break
				end

			end

			table.insert(elements, {label = _U('guns_label'), value = nil})

			for i=1, #data.weapons, 1 do
				table.insert(elements, {
					label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
					value    = data.weapons[i].name,
					itemType = 'item_weapon',
					amount   = data.weapons[i].ammo
				})
			end

			table.insert(elements, {label = _U('inventory_label'), value = nil})

			for i=1, #data.inventory, 1 do
				if data.inventory[i].count > 0 then
					table.insert(elements, {
						label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
						value    = data.inventory[i].name,
						itemType = 'item_standard',
						amount   = data.inventory[i].count
					})
				end
			end


			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search',
			{
				title    = _U('search'),
				align    = 'top-left',
				elements = elements,
			},
			function(data, menu)

				local itemType = data.current.itemType
				local itemName = data.current.value
				local amount   = data.current.amount

				if data.current.value ~= nil then
					TriggerServerEvent('Atlantic_thiefmenu:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)
					OpenBodySearchMenu(player)
				end

			end, function(data, menu)
				menu.close()
			end)

		end, GetPlayerServerId(player))
	else
		ESX.ShowNotification('Personen er ikke i strips')
	end

end


RegisterNetEvent('Atlantic_thiefmenu:handcuff')
AddEventHandler('Atlantic_thiefmenu:handcuff', function()
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if IsHandcuffed then

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

--			xPlayer.removeInventoryItem('strips', 1) -- Virker ikke optimalt
			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
--			FreezeEntityPosition(playerPed, true)
			DisplayRadar(false)
			TriggerEvent("esx_policejob:sounds", "handcuffed", 0.8)

			if Config.EnableHandcuffTimer then

				if HandcuffTimer.Active then
					ESX.ClearTimeout(HandcuffTimer.Task)
				end

				StartHandcuffTimer()
			end

		else

			if Config.EnableHandcuffTimer and HandcuffTimer.Active then
				ESX.ClearTimeout(HandcuffTimer.Task)
			end

			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
			DisplayRadar(true)
		end
	end)

end)

RegisterNetEvent('esx_okradanie:handcuff')
AddEventHandler('esx_okradanie:handcuff', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	if isHandcuffed then
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)
		FreezeEntityPosition(playerPed, true)
		DisplayRadar(false)

	else

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)

RegisterNetEvent('Atlantic_thiefmenu:OutVehicle')
AddEventHandler('Atlantic_thiefmenu:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsHandcuffed then
		return
	end

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

RegisterNetEvent('esx_okradanie:unrestrain')
AddEventHandler('esx_okradanie:unrestrain', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

	end
end)

RegisterNetEvent('Atlantic_thiefmenu:drag')
AddEventHandler('Atlantic_thiefmenu:drag', function(copID)
	if not IsHandcuffed then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)
end)

RegisterNetEvent('esx_okradanie:drag')
AddEventHandler('esx_okradanie:drag', function(copId)
	if isHandcuffed then
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsHandcuffed then
			playerPed = PlayerPedId()

			if DragStatus.IsDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)


RegisterNetEvent('esx_okradanie:putInVehicle')
AddEventHandler('esx_okradanie:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if not IsHandcuffed then
		return
	end

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
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if IsHandcuffed then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 21, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
			DisableControlAction(0, 23, true) -- Disable enter vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)