local blip
ESX = nil
playerJob = nil
local storageOpen = false
playerJobName = ""
playerLoaded = false
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
  while ESX.GetPlayerData().job == nil do
    Citizen.Wait(1)
  end
  playerJob = ESX.GetPlayerData().job
  if playerJob then
    playerJobName = playerJob.name
    createBlip()
  end
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  playerJob = xPlayer.job
  if playerJob then
      playerJobName = playerJob.name
      createBlip()
  end
  TriggerServerEvent("_playerjoins_")
  playerLoaded = true
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  playerJob = job
  if playerJob then
      playerJobName = playerJob.name
      createBlip()
  end
end)

-- We just add one blip to first vehiclespawn location --
-- Only players with this job will see this marker --
function createBlip()
  if playerJobName == "secworker" then
    if not blip then
      if Config.vehiclespawns[1] then
        local pos = Config.vehiclespawns[1].coords
        blip = AddBlipForCoord(pos.x,pos.y)
        SetBlipSprite (blip, 473)
        SetBlipDisplay(blip,   4)
        SetBlipScale  (blip, 0.7)
        SetBlipColour (blip, 4)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Overvågningsteknikker Arbejdsplads") -- <-- name of company
        EndTextCommandSetBlipName(blip)
      end
    end
  else
    if blip then
      RemoveBlip(blip)
      blip = nil
    end
  end
end
----------------

AddTextEntry("cams:craft", lang["press"]..Config.keybinds["E"].name..lang["tocraft"])
AddTextEntry("cams:spawnveh", lang["press"]..Config.keybinds["E"].name..lang["tospawnvehicle"])
AddTextEntry("cams:deleteveh", lang["press"]..Config.keybinds["E"].name..lang["todeletevehicle"])
AddTextEntry("cams:openStorage", lang["press"]..Config.keybinds["E"].name..lang["toopenstorage"])

local minigameKeys = {
    {key = 32, label = "W"},
    {key = 33, label = "S"},
    {key = 34, label = "A"},
    {key = 35, label = "D"}
}

CreateThread(function()
  while true do

    if playerJobName == "secworker" then
      local player = PlayerPedId()
      local coords = GetEntityCoords(player)
      local heading = GetEntityHeading(player)
      local closeAt = false

      -- Tablet crafting --

      for k,v in pairs(Config.tabletCraftingLocations) do
          local distance = GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true)
          if distance < 50.0 then
            closeAt = true
            DrawMarker(v.markertype, v.coords.x, v.coords.y, v.coords.z , 0, 0, 0, 0, 0, 0, v.markersize, v.markersize, v.markerheight, v.markercolor, 0, 0, 0, 0)
            if distance <= v.markersize then
                showHelpText("cams:craft")
                if IsControlJustReleased(0,Config.keybinds["E"].key) then
                  FreezeEntityPosition(player, true)
                  local crafted = 0
                  local taps = math.random(Config.minigame.minTaps,Config.minigame.maxTaps)
                  local currentKey = minigameKeys[math.random(#minigameKeys)]
                  local time = math.random(Config.minigame.minSpeed,Config.minigame.maxSpeed)
                  local timer = GetGameTimer()

                  craftingStarted()

                  --
                -- Traalalaalalaa here we craft tablets
                  while true do
                  -- Tiny minigame

                    local coords = GetEntityCoords(player)
                    Draw3DText(coords.x,coords.y,coords.z,"[ "..currentKey.label.." ]", 1.0 * (((time * 1000 - (GetGameTimer() - timer)) / 1000) / (time)))
                    drawTxt__(0.9,0.9, lang["crafted"].." "..crafted)

                    for i=1,#minigameKeys do
                      if IsControlJustReleased(0, minigameKeys[i].key) then
                        if currentKey.key == minigameKeys[i].key then
                            currentKey = minigameKeys[math.random(#minigameKeys)]
                            time = math.random(Config.minigame.minSpeed,Config.minigame.maxSpeed)
                            timer = GetGameTimer()
                            taps = taps - 1
                            if taps <= 0 then
                              crafted = crafted + 1
                              taps = math.random(Config.minigame.minTaps,Config.minigame.maxTaps)
                            end
                        else
                          timer = 0
                        end
                      end
                    end

                    if GetGameTimer() - timer >= time*1000 then
                      break
                    end

                  Wait(1)
                  end
                  if crafted > 0 then
                    TriggerServerEvent("cams:givetablet", crafted)
                  end
                  ClearPedTasks(player)
                  FreezeEntityPosition(player, false)
                end
                break
            end
          end
      end

      -- Vehicle spawning --

      for k,v in pairs(Config.vehiclespawns) do
        local distance = GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true)
          if distance < 50.0 then
            closeAt = true
            DrawMarker(v.markertype, v.coords.x, v.coords.y, v.coords.z , 0, 0, 0, 0, 0, 0, v.markersize, v.markersize, v.markerheight, v.markercolor, 0, 0, 0, 0)
            if distance <= v.markersize then
              local vehicle = GetVehiclePedIsIn(player)
              if vehicle == 0 then showHelpText("cams:spawnveh") else showHelpText("cams:deleteveh") end
                if IsControlJustReleased(0,Config.keybinds["E"].key) then
                  if vehicle == 0 then 
                    local veh = createVehicle(v.coords, v.vehiclemodel)
                    TaskWarpPedIntoVehicle(player,veh,-1)
                    Wait(5000) -- 
                  else
                    SetEntityAsMissionEntity(vehicle,true,true)
                    DeleteVehicle(vehicle)
                    Wait(5000) --
                  end
              end
            end
        end
      end

      -- Storage stuff --
      local distance = GetDistanceBetweenCoords(coords, Config.storage.coords.x, Config.storage.coords.y, Config.storage.coords.z , true) 
      if distance <= 50.0 then
        closeAt = true
          DrawMarker(Config.storage.markertype, Config.storage.coords.x, Config.storage.coords.y, Config.storage.coords.z , 0, 0, 0, 0, 0, 0, Config.storage.markersize, Config.storage.markersize, Config.storage.markerheight, Config.storage.markercolor, 0, 0, 0, 0)
          if distance <= Config.storage.markersize and not storageOpen then
            showHelpText("cams:openStorage")
            if IsControlJustReleased(0,Config.keybinds["E"].key) then
               TriggerServerEvent("cams:openstorage")
            end
          end
      end

      ----------try---------

      if not closeAt then
        Wait(1000)
      end

    else
        Wait(5000)
    end

    Wait(1)
  end
end)


function craftingStarted()
    --Animation
    local animDictionary = "mini@repair"
    local animationName = "fixing_a_player"
    
    if not HasAnimDictLoaded(animDictionary) then
      RequestAnimDict(animDictionary)
      while not HasAnimDictLoaded(animDictionary) do
          Wait(500)
      end
    end
    TaskPlayAnim(PlayerPedId(), animDictionary , animationName, 8.0, -8.0, -1, 1, 1, 0, 0, 0)
    RemoveAnimDict(animDictionary)
end

function createVehicle(coords, vehiclemodel)
  local hash = GetHashKey(vehiclemodel)
  if not HasModelLoaded(hash) then
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(1) end
  end

  local vehicle = CreateVehicle(
      hash, 
      coords,
      true, 
      true
    )
  SetModelAsNoLongerNeeded(hash)
  return vehicle
end

function Draw3DText(x,y,z,txt,sc)
   local px,py,pz=table.unpack(GetGameplayCamCoords())
   local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
   local scale = (1/dist)*20
   local fov = (1/GetGameplayCamFov())*100
   local scale = scale*fov   
   SetTextScale(sc, sc)
   SetTextFont(4)
   SetTextProportional(1)
   SetTextColour(250, 250, 250, 255)    -- You can change the text color here
   SetTextDropshadow(1, 1, 1, 1, 255)
   SetTextEdge(2, 0, 0, 0, 150)
   SetTextDropShadow()
   SetTextOutline()
   SetTextEntry("STRING")
   SetTextCentre(1)
   AddTextComponentString(txt)
   SetDrawOrigin(x,y,z+1.2, 0)
   DrawText(0.0, 0.0)
   ClearDrawOrigin()
end

function drawTxt__(x,y, text)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end
