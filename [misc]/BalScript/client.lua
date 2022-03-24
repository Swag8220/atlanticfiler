local SendToServerSide = false

Citizen.CreateThread(function()
    while true do 
      Citizen.Wait(0) 
      if GetDistanceBetweenCoords(-1400.6136474609,-1534.4090576172,2.5804295539856, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then
        --DrawMarker(27, 1093.3168945313, -2252.130859375, 31.233898162842+1 - 1, 0, 0, 0, 0, 0, 0, 0.250, 0.250, 0.250, 100, 500, 2, 500, 0, 1, 0, 5)
        DrawText3Ds( -1400.6136474609,-1534.4090576172,2.5804295539856, "Tryk ~g~E~w~ For at lave et bål")
           if IsControlJustPressed(1, 38) then
            TriggerEvent("TBZ:Start")
            end
        end
    end
end)

RegisterNetEvent("TBZ:Start")
AddEventHandler("TBZ:Start", function()
    TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    local hamburg = "prop_box_wood03a"
    local hamburghash = GetHashKey(hamburg)
    local hamburger = CreateObject(hamburghash, -1403.6539306641,-1528.4161376953,0.90919375419617, true, true, true)
end)

local GetCallBacksToServerSide = true

if GetCallBacksToServerSide == true then
print("^2"..GetCurrentResourceName().." ^4started!")
else
    print("^5Script could not be started")
end

if TriggerServerEvent("TBZ:IsClientSideAndCBConnected") then
    print("^2Callback Strings to multiple handle executing was enabled and the script was succesfully started!")
    SendToServerSide = true
else
    print("^6Could not connect to Callbacks to handle any form off other cb packs, stopping current resource!")
end

RegisterCommand("StartB", function()
    TriggerEvent("TBZ:Start")
end)