ESX = nil
local IsDead = false
local skud = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer 
end)

RegisterNetEvent('XmX:Skudsikkervest')
AddEventHandler('XmX:Skudsikkervest', function()
	skud = skud + 1
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict('clothingshirt')
    while not HasAnimDictLoaded('clothingshirt') do
        Citizen.Wait(1)
    end
    TaskPlayAnim(playerPed, "clothingshirt", "check_out_b", 3.5, -8, -1, 49, 0, 0, 0, 0)

    Citizen.Wait(5000)
    ClearPedTasks(playerPed)

	AddArmourToPed(playerPed, 100)
	SetPedArmour(playerPed, 100)
end)


RegisterNetEvent('eden_accesories:scope')
AddEventHandler('eden_accesories:scope', function(duration)
	local inventory = ESX.GetPlayerData().inventory
	local scope = 0

		for i=1, #inventory, 1 do
		  if inventory[i].name == 'scope' then
			scope = inventory[i].count
		  end
		end

local ped = PlayerPedId()
local currentWeaponHash = GetSelectedPedWeapon(ped)

		if used < scope then

		  	if currentWeaponHash == GetHashKey("WEAPON_SMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en sigtekorn. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
		  		 	used = used + 1
			elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
				GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_SCOPE_MACRO"))  
				ESX.ShowNotification(("Du har netop udstyret dig med en sigtekorn. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
					used = used + 1

		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en sigtekorn. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
					used = used + 1


		  	else 
		  		  ESX.ShowNotification(("Du har intet våben i hånden, ellers kan dit våben ik få en lygte på."))	
			end
			else
					  		 ESX.ShowNotification(("Du har brugt alle dine sigtekorn.")) 
		end
end)

local used122 = 0

RegisterNetEvent('eden_accesories:suppressor')
AddEventHandler('eden_accesories:suppressor', function(duration)
	local inventory = ESX.GetPlayerData().inventory
	local suppressor = 0

		for i=1, #inventory, 1 do
		  if inventory[i].name == 'suppressor' then
			suppressor = inventory[i].count
		  end
		end

local ped = PlayerPedId()
local currentWeaponHash = GetSelectedPedWeapon(ped)

		if used122 < suppressor then
			if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("component_at_pi_supp_02"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen")) 
				   used122 = used122 + 1


		  	elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_VINTAGEPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen."))
				   used122 = used122 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1

			elseif currentWeaponHash == GetHashKey("WEAPON_MACHINEPISTOL") then
				GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MACHINEPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
				ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				used122 = used122 + 1	


		  	elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1
				

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1
		  		

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1
		  		 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_SR_SUPP"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1
			  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_SNIPERRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
		  		 ESX.ShowNotification(("Du har netop udstyret dig med en suppressor. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
				   used122 = used122 + 1

		  	else 
		  		  ESX.ShowNotification(("Du har intet våben i hånden, ellers kan dit våben ikke undertrykke."))	
			end
			else
					  		 ESX.ShowNotification(("Du har brugt al din undertrykker.")) 
		end
end)
				local used2 = 0

RegisterNetEvent('eden_accesories:flashlight')
AddEventHandler('eden_accesories:flashlight', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local flashlight = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'flashlight' then
						flashlight = inventory[i].count
					  end
					end

local ped = PlayerPedId()
local currentWeaponHash = GetSelectedPedWeapon(ped)

		if used2 < flashlight then
			if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
		  		 	used2 = used2 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
		  		 	used2 = used2 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1
 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1	

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1
		  		 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used2 = used2 + 1
elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
	ESX.ShowNotification(("Du har lige udstyret dig med en lygte. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
used2 = used2 + 1

		  	else 
		  		  ESX.ShowNotification(("Vous n'avez pas d'arme en main ou votre arme ne peux pas supporter de lampe."))
			end
		else
				  ESX.ShowNotification(("Vous avez utiliser toutes vos lampes."))
		end
end)

local used3 = 0

RegisterNetEvent('eden_accesories:grip')
AddEventHandler('eden_accesories:grip', function(duration)
	local inventory = ESX.GetPlayerData().inventory
	local grip = 0
		for i=1, #inventory, 1 do
		  if inventory[i].name == 'grip' then
			grip = inventory[i].count
		  end
		end

local ped = PlayerPedId()
local currentWeaponHash = GetSelectedPedWeapon(ped)

		if used3 < grip then
			if currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et håndtag. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
		  				used3 = used3 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et håndtag. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used3 = used3 + 1
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et håndtag. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used3 = used3 + 1	

		  	elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et håndtag. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used3 = used3 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et håndtag. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used3 = used3 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et håndtag. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used3 = used3 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et håndtag. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used3 = used3 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et håndtag. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used3 = used3 + 1
			  	elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et greb. Det skal genudstyres, hver gang du vender tilbage til byen..")) 
	used4 = used4 + 1
elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"))  
	ESX.ShowNotification(("Du har lige udstyret dig med et greb. Det skal genudstyres, hver gang du vender tilbage til byen..")) 
used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et håndtag. Det skal genudstyres, hver gang du vender tilbage til byen.")) 
	used3 = used3 + 1

		  	else 
		  		  ESX.ShowNotification(("Vous n'avez pas d'arme en main ou votre arme ne peux pas supporter de poignée."))

			end
		else
				  ESX.ShowNotification(("Vous avez utiliser toutes vos poignées."))
		end
end)

local used4 = 0

RegisterNetEvent('eden_accesories:yusuf')
AddEventHandler('eden_accesories:yusuf', function(duration)
	local inventory = ESX.GetPlayerData().inventory
	local yusuf = 0
		for i=1, #inventory, 1 do
		  if inventory[i].name == 'yusuf' then
			yusuf = inventory[i].count
		  end
		end
		
local ped = PlayerPedId()
local currentWeaponHash = GetSelectedPedWeapon(ped)

		if used4 < yusuf then
			if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_PISTOL_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et greb. Det skal genudstyres, hver gang du vender tilbage til byen..")) 
		  		 	used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_PISTOL50_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et greb. Det skal genudstyres, hver gang du vender tilbage til byen..")) 
	used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_APPISTOL_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et greb. Det skal genudstyres, hver gang du vender tilbage til byen..")) 
	used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_HEAVYPISTOL_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et greb. Det skal genudstyres, hver gang du vender tilbage til byen..")) 
	used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_SMG_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et greb. Det skal genudstyres, hver gang du vender tilbage til byen..")) 
	used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_MICROSMG_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et greb. Det skal genudstyres, hver gang du vender tilbage til byen..")) 
	used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et greb. Det skal genudstyres, hver gang du vender tilbage til byen..")) 
	used4 = used4 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_CARBINERIFLE_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et greb. Det skal genudstyres, hver gang du vender tilbage til byen..")) 
	used4 = used4 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"))  
		  		 ESX.ShowNotification(("Du har lige udstyret dig med et greb. Det skal genudstyres, hver gang du vender tilbage til byen..")) 
	used4 = used4 + 1
			elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE_MK2") then
				GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"))  
				ESX.ShowNotification(("Du har lige udstyret dig med et greb. Det skal genudstyres, hver gang du vender tilbage til byen..")) 
 used4 = used4 + 1

		  	else 
		  		  ESX.ShowNotification(("Vous n'avez pas d'arme en main ou votre arme ne peux pas supporter de look de luxe."))
			end
		else
				  ESX.ShowNotification(("Vous avez utiliser tout vos skins de luxe."))
		end
end)

AddEventHandler('playerSpawned', function()
  used = 0
  used2 = 0
  used3 = 0
  used4 = 0
end)