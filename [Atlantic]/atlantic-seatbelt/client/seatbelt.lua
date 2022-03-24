-----------------------------------------------------------------------------
--- VEHICLE SEATBELT FOR FIVEM MADE IndianaBonesUrMomBY EDITED BY Kiminaze --
-----------------------------------------------------------------------------

-- Attach / detach your seatbelt
-- If seatbelt is not attached you can fly out of your vehicle through the windscreen


--------------------------------------------------
------------------- VARIABLES --------------------
--------------------------------------------------

local speedBuffer = {}
local velBuffer   = {}
local seatbelt    = false
local isInVehicle = false
local isInVehicleForNotification = false

local GUITime = 0

Citizen.CreateThread(function()
while true do
    if isInVehicle then
        Citizen.Wait(0)
        DisableControlAction(0, 82, true)
    else
        Citizen.Wait(500)
    end
end
end)


Citizen.CreateThread(function()
	Citizen.Wait(2500)
    
	while true do
		Citizen.Wait(1)
		
		local playerPed     = GetPlayerPed(-1)
        
        if (IsPedInAnyVehicle(playerPed, false)) then
            isInVehicle = true

            if seatbelt then 
                DisableControlAction(0, 75)
            end
            
            local playerVehicle = GetVehiclePedIsIn(playerPed)
            local vehClass = GetVehicleClass(playerVehicle)
            
            if ((vehClass >= 0 and vehClass <= 7) or (vehClass >= 9 and vehClass <= 12) or (vehClass >= 17 and vehClass <= 20)) then
                speedBuffer[2] = speedBuffer[1]
                speedBuffer[1] = GetEntitySpeed(playerVehicle)
                
                velBuffer[2] = velBuffer[1]
                velBuffer[1] = GetEntityVelocity(playerVehicle)
                
                -- perform extreme stunting exercise
                if ((speedBuffer[2] ~= nil and velBuffer[2] ~= nil and not seatbelt) and ((speedBuffer[2] > (Config.MinSpeed / 3.6) and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * Config.DiffTrigger)) or (speedBuffer[1] > (Config.MinSpeed / 7.2) and (speedBuffer[1] - speedBuffer[2]) > (speedBuffer[2] * Config.DiffTrigger)))) then
                    local co = GetEntityCoords(playerPed)
                    local fw = Fwv(playerPed)
                    if (IsVehicleWindowIntact(playerVehicle, 6)) then
                        SmashVehicleWindow(playerVehicle, 6)
                    end
                    SetEntityCoords(playerPed, co.x + fw.x, co.y + fw.y, co.z-0.47, true, true, true)
                    Citizen.Wait(1)
                    SetEntityHealth(playerPed, 130)
                    Citizen.Wait(1)
                    SetPedToRagdoll(playerPed, Config.BlackoutTime, Config.BlackoutTime, 0, 0, 0, 0)
                    SetEntityVelocity(playerPed, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
                    Citizen.Wait(1)
                    blackout()
                end

                if ((speedBuffer[2] ~= nil and velBuffer[2] ~= nil and seatbelt) and ((speedBuffer[2] > (Config.MinSpeedBlackout / 3.6) and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * Config.DiffTrigger)) or (speedBuffer[1] > (Config.MinSpeedBlackout / 7.2) and (speedBuffer[1] - speedBuffer[2]) > (speedBuffer[2] * Config.DiffTrigger)))) then
                    --math.randomseed(GetGameTimer())
                    --randomBlackout = math.random(1,10)
                    --randomHealthLoss = math.random(5,60)
                    --getCurrentHealth = GetEntityHealth(playerPed)
                    --newHealth = getCurrentHealth - randomHealthLoss
                    --SetEntityHealth(playerPed, newHealth)
                    if(randomBlackout == 1 or randomBlackout == 3 or randomBlackout == 5 or random == 7 or randomBlackout == 10) then
                        blackout()
                    end
                end
                
                -- attach / detach seatbelt
                if (IsDisabledControlJustReleased(0, Config.SeatbeltButton)) and (GetGameTimer() - GUITime) > 1000 and not (UpdateOnscreenKeyboard() == 0) then
                    seatbelt = not seatbelt
                    if (seatbelt) then
                        Notification(_U('seatbelt_on'), 'success', 3000)
                        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'seatbelton', 0.3)
                    else
                        Notification(_U('seatbelt_off'), 'error', 3000)
                        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'seatbeltoff', 0.3)
                    end
                    TriggerEvent("Atlantic_UI:toggleSeatbelt", seatbelt)
                    GUITime = GetGameTimer()
                end
            end
        elseif (isInVehicle and not IsPedInAnyVehicle(playerPed, false)) then
            isInVehicle = false
            seatbelt    = false
            speedBuffer[1], speedBuffer[2] = 0.0, 0.0
        end

        if isBlackedOut and Config.DisableControlsOnBlackout then
			DisableControlAction(0,71,true) -- veh forward
			DisableControlAction(0,72,true) -- veh backwards
			DisableControlAction(0,63,true) -- veh turn left
			DisableControlAction(0,64,true) -- veh turn right
			DisableControlAction(0,75,true) -- disable exit vehicle
		end
        
        if (not isInVehicleForNotification and IsPedInAnyVehicle(playerPed, false)) then
            local playerVehicle = GetVehiclePedIsIn(playerPed)
            local vehClass = GetVehicleClass(playerVehicle)
            
            if ((vehClass >= 0 and vehClass <= 7) or (vehClass >= 9 and vehClass <= 12) or (vehClass >= 17 and vehClass <= 20)) then
                if IsEntityVisible(playerPed) then
                    Notification(_U('seatbelt_help_text'), 'inform', 3000)
                end
            end
            
            isInVehicleForNotification = true
        elseif (isInVehicleForNotification and not IsPedInAnyVehicle(playerPed, false)) then
            isInVehicleForNotification = false
        end
    end
end)

function Fwv(entity)
    local hr = GetEntityHeading(entity) + 90.0
    if hr < 0.0 then hr = 360.0 + hr end
    hr = hr * 0.0174533
    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

function blackout()
	-- Only blackout once to prevent an extended blackout if both speed and damage thresholds were met
	if not isBlackedOut then
		isBlackedOut = true
		-- This thread will black out the user's screen for the specified time
        Citizen.CreateThread(function()
            local playerPed = GetPlayerPed(-1)
            if IsEntityDead(playerPed) ~= 1 then
			DoScreenFadeOut(100)
			while not IsScreenFadedOut() do
				Citizen.Wait(0)
			end
			Citizen.Wait(Config.BlackoutTime)
            DoScreenFadeIn(250)
            end
			isBlackedOut = false
		end)
	end
end

function Notification(message, messageType, messageTimeout)
    exports['mythic_notify']:DoHudText(messageType, message, messageTimeout)
end