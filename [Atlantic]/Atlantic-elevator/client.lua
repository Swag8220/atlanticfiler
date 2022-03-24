ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

time = 0
menuData = {open = false, id = nil}
currentElevator = nil

table1 = {
	subtable1 = {},
	subtable2 = {}
	}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = GetPlayerPed(-1)
		for j,elevator in pairs(Config.positions) do
			for k,v in pairs(elevator) do 
				if GetDistanceBetweenCoords(GetEntityCoords(ped), v.pos[1], v.pos[2], v.pos[3], true) <= Config.DrawDistance then
					DrawMarker(Config.Marker.Type, v.pos[1], v.pos[2], v.pos[3]-0.98, 0, 0, 0, 0, 0, 0, 2.75, 2.75, 2.75, Config.Marker.r, Config.Marker.g, Config.Marker.b, 100, 0, 0, 0, 0)
					if GetDistanceBetweenCoords(GetEntityCoords(ped), v.pos[1], v.pos[2], v.pos[3], true) <= Config.TriggerDistance then
						if not menuData.open then
							ESX.ShowHelpNotification("Tryk på ~INPUT_TALK~ for at bruge elevatoren")
							if IsControlJustPressed(1, 46) then
								if time == 0 then
									time = 2
									menuData.id = tonumber(k)
									currentElevator = elevator
									OpenTeleportMenu(v.etage,j)
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
		Citizen.Wait(1)
		if menuData.open == true and menuData.id ~= nil then
			local ped = GetPlayerPed(-1)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), currentElevator[menuData.id].pos[1], currentElevator[menuData.id].pos[2], currentElevator[menuData.id].pos[3], true) > Config.TriggerDistance then
				ESX.UI.Menu.CloseAll()
				menuData.open = false
				menuData.id = nil
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		 Citizen.Wait(1000)
		 if time > 0 then
			  time = time - 1
		 end
	end
end)

function OpenTeleportMenu(etage, name)
	menuData.open = true
	local elements = {}
	for k,v in pairs(currentElevator) do
		if etage ~= v.etage then
			table.insert(elements, {
				label = "Etage "..v.etage..": "..v.name,
				value = v.pos,
				permissions = v.permissions
			})
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = name,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		local isAllowed = false
		if ESX.PlayerData.job and (data.current.permissions ~= nil) then
			for k,perm in pairs(data.current.permissions) do
				if ESX.PlayerData.job.name == perm then
					isAllowed = true
					break
				end
			end
		else
			isAllowed = true
		end
		if isAllowed then
			SetEntityCoords(GetPlayerPed(-1), data.current.value[1], data.current.value[2], data.current.value[3])
			menu.close()
			menuData.open = false
			menuData.id = nil
		else
			ESX.ShowNotification("Du har ikke adgang til denne etage!")
		end
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)