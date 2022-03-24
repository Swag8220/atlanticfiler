local PlayerData = nil
local ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:lawyer:openLawyer')
AddEventHandler('esx:lawyer:openLawyer', function(xPlayer)
	ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'cruise_control_actions',
			{
			  title    = "Advokat",
			  align    = 'center',
			  elements = {
				{label = "Lav nyt Firma", data = "ccvr"},
				{label = "Kig på Firmaer",  data = "gcvr"},
			}
			},function(data, menu)	
				if data.current.data ==  "ccvr" then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
					else
						print(closestPlayer)
						ESX.UI.Menu.CloseAll()
						menu.close()
						TriggerEvent('esx:lawyer:createCVR',closestPlayer)
					end
					
				elseif data.current.data ==  "gcvr" then
					ESX.UI.Menu.CloseAll()
					menu.close()
					TriggerEvent('esx:lawyer:getCVR')
				end
			end
			,function(data, menu)
				menu.close()
	end)
end)
 

RegisterNetEvent('esx:lawyer:createCVR')
AddEventHandler('esx:lawyer:createCVR', function(id)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'buisname', {
		title = "Firma Navn"
		}, function(data2, menu2)
		menu2.close()
		local quantity = data2.value
		ESX.TriggerServerCallback('esx_lawyer:createCVR',function(orn) end,GetPlayerServerId(id),quantity)
		
	  end, function(data2, menu2)
		menu2.close()
	  end)
	
end)

RegisterNetEvent('esx:lawyer:getCVR')
AddEventHandler('esx:lawyer:getCVR', function(xPlayer)
	ESX.TriggerServerCallback('esx_lawyer:getCVR',function(orn)

		local elements = {}
		for k,v in pairs(orn) do
			table.insert(elements, {label = "Navn: " .. orn[k].firmanavn, data = "Ejer: " .. orn[k].navn .. "  CPR: " .. orn[k].CPR .. "  CVR: " .. orn[k].CVR})
		end
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'cruise_control_actions',
			{
			  title    = "Firmaer",
			  align    = 'center',
			  elements = elements
			},function(data, menu)
				ESX.ShowNotification(data.current.data)
			end
			,function(data, menu)
				menu.close()
		end)
	end)
end)