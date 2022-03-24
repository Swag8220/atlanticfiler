ESX              = nil
local PlayerData = {}
local kanNightvision = false
local Mand = false

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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


Citizen.CreateThread(function()
    while true do
        if IsControlJustReleased(0, 166) then
            local gender = nil
            isNightvision = not isNightvision
            TriggerEvent('skinchanger:getSkin', function(skin)
                local helmet = skin.helmet_1

                if skin.sex == 0 then
                    Mand = true
                else
                    Mand = false
                end

                if helmet == 116 or helmet == 117 then
                    kanNightvision = true
                else
                    kanNightvision = false
                end
            end)

            if Mand then
                gender = 0
            else
                gender = 1
            end

            if kanNightvision and isNightvision then
                TriggerEvent('skinchanger:loadSkin', {
                    sex = gender,
                    helmet_1 = 116
                })
            SetNightvision(true)
            elseif kanNightvision and isNightvision == false then
                TriggerEvent('skinchanger:loadSkin', {
                    sex = gender,
                    helmet_1 = 117
                })
                SetNightvision(false)
            end
        end
        Citizen.Wait(5)
    end
end)