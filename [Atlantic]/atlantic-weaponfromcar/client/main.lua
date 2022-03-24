local lastweapon, weaponout = nil, false

RegisterNetEvent('elf3dme:triggerDisplay')
AddEventHandler('elf3dme:triggerDisplay', function(text, source)
    Display(GetPlayerFromServerId(source), text)
end)

function Display(mePlayer, text)
    local displaying = true
    Citizen.CreateThread(function()
        Wait(Config.ActionTime*1000)
        displaying = false
    end)
    Citizen.CreateThread(function()
        while displaying do
            Wait(0)
			local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
			local x, y, z = table.unpack(GetEntityCoords(ped))
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 2500 then
                DrawText3Ds(coordsMe['x'], coordsMe['y'], coordsMe['z']+0.2, text)
            end
        end
    end)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(Config.ActionColor.r, Config.ActionColor.g, Config.ActionColor.b, Config.ActionColor.a)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

local isWep = function(wep)
	for k,v in pairs(Config.Weps) do
		v = string.upper(v)
		if wep == GetHashKey(v) then
			return true
		end
	end
	return false
end

local getName = function(wep)
	local name
	for k,v in pairs(Config.Weps) do
		v = string.upper(v)
		if wep == GetHashKey(v) then
			name = v
		end
	end
	name = string.gsub(name, 'WEAPON_', '')
	if string.find(_U(string.lower(name)), 'Translation') then
		return name
	elseif string.find(_U(string.lower(name)), 'Locale') then
		return name
	end
	return _U(string.lower(name))
end

local hasBag = function(ped)
	local playerPed = GetPlayerPed(-1)
	if IsPedModel(playerPed,1885233650) then
		for k,v in pairs(Config.Bags.male) do
			if v == GetPedDrawableVariation(ped,5) then
				return true
			end
		end
	else
		for k,v in pairs(Config.Bags.female) do
			if v == GetPedDrawableVariation(ped,5) then
				return true
			end
		end
	end
	return false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(25)
		playerPed = GetPlayerPed(-1)
		if playerPed then
			local weapon = GetSelectedPedWeapon(playerPed)
			if weaponout == true and lastweapon ~= weapon then
				local vehicle = VehicleInFront()
				if GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
					weaponout = false
					lastweapon = nil
					SetVehicleDoorOpen(vehicle, 5, false, false)
					Citizen.Wait(2000)
					SetVehicleDoorShut(vehicle, 5, false)
				else
					if GetVehiclePedIsIn(playerPed, false) == 0 then
						if hasBag(playerPed) then
							weaponout = false
							lastweapon = nil
						else
							exports['mythic_notify']:DoHudText('error', _U('err_rem_msg'))
							SetCurrentPedWeapon(playerPed, lastweapon)
						end
					end
				end
			elseif isWep(weapon) then
				local vehicle = VehicleInFront()
				if GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) and weaponout == false then
					weaponout = true
					lastweapon = weapon
					SetVehicleDoorOpen(vehicle, 5, false, false)
					if Config.Actiontxt == true then
						local text = _U('equiping_weapon', getName(weapon))
						TriggerServerEvent('elf3dme:shareDisplay', text)
					end
					Citizen.Wait(2000)
					SetVehicleDoorShut(vehicle, 5, false)
				elseif Config.AllowBag == true then
					if weaponout == false and GetVehiclePedIsIn(playerPed, false) == 0 then
						if hasBag(playerPed) then
							weaponout = true
							lastweapon = weapon
							if Config.Actiontxt == true then
								local text = _U('equiping_weapon_bag', getName(weapon))
								TriggerServerEvent('elf3dme:shareDisplay', text)
							end
						else
							exports['mythic_notify']:DoHudText('error', _U('err_pull_msg'))
							SetCurrentPedWeapon(playerPed, -1569615261)
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		playerPed = GetPlayerPed(-1)
		if playerPed then
			local weapon = GetSelectedPedWeapon(playerPed, true)
			if not isWep(weapon) and weaponout == true then
				Wait(100)
				weaponout = false
				lastweapon = nil
			end
		end
	end
end)

function VehicleInFront()
	local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end