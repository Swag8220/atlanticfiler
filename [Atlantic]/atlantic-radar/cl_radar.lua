--[[------------------------------------------------------------------------

    Wraith Radar System - v1.02
    Created by WolfKnight - Heavily modified by DPL <3 DumpDump

------------------------------------------------------------------------]]--

--[[------------------------------------------------------------------------
    Resource Rename Fix 
------------------------------------------------------------------------]]--
Citizen.CreateThread( function()
    Citizen.Wait( 1000 )
    local resourceName = GetCurrentResourceName()
    SendNUIMessage( { resourcename = resourceName } )
end )

--[[------------------------------------------------------------------------
    Utils 
------------------------------------------------------------------------]]--
function round( num )
    return tonumber( string.format( "%.0f", num ) )
end

function oppang( ang )
    return ( ang + 180 ) % 360 
end 

function FormatSpeed( speed )
    return speed
end 

function GetVehicleInDirectionSphere( entFrom, coordFrom, coordTo )
    local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 2.0, 10, entFrom, 7 )
    local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
    return vehicle
end

function IsEntityInMyHeading( myAng, tarAng, range )
    local rangeStartFront = myAng - ( range / 2 )
    local rangeEndFront = myAng + ( range / 2 )

    local opp = oppang( myAng )

    local rangeStartBack = opp - ( range / 2 )
    local rangeEndBack = opp + ( range / 2 )

    if ( ( tarAng > rangeStartFront ) and ( tarAng < rangeEndFront ) ) then 
        return true 
    elseif ( ( tarAng > rangeStartBack ) and ( tarAng < rangeEndBack ) ) then 
        return false 
    else 
        return nil 
    end 
end 


--[[------------------------------------------------------------------------
    Police Vehicle Radar 
------------------------------------------------------------------------]]--
local radarEnabled = false 
local hidden = false 
local radarInfo = 
{ 
    patrolSpeed = "0", 

    speedType = "kmh", 

    fwdPrevVeh = 0,
    
    fwdXmit = true, 
    fwdMode = "same", 
    fwdSpeed = "0", 
    fwdFast = "0", 
    fwdFastLocked = false, 
    fwdDir = nil, 
    fwdFastSpeed = 0,
    fwdCarModel = "None",
    fwdFastCarModel = "None",
	fwdFastCarNumberPlate = "None",

    bwdPrevVeh = 0, 
    bwdXmit = true, 
    bwdMode = "same", 
    bwdSpeed = "0", 
    bwdFast = "0",
    bwdFastLocked = false, 
    bwdDir = nil, 
    bwdFastSpeed = 0, 
    bwdCarModel = "None",
    bwdFastCarModel = "None",
	bwdFastCarNumberPlate = "None",

    fastResetLimit = 150,
    fastLimit = 55, 

    angles = { [ "same" ] = { x = 0.0, y = 50.0, z = 0.0 }, [ "opp" ] = { x = -10.0, y = 50.0, z = 0.0 } },

    lockBeep = true 
}

local theLimits = {50, 80, 130}
local currentSelected = 1

RegisterNetEvent( 'wk:toggleRadar' )
AddEventHandler( 'wk:toggleRadar', function()
    local ped = GetPlayerPed( -1 )

    if ( IsPedSittingInAnyVehicle( ped ) ) then 
        local vehicle = GetVehiclePedIsIn( ped, false )

        if ( GetVehicleClass( vehicle ) == 18 ) then
            radarEnabled = not radarEnabled

            if ( radarEnabled ) then 
                Notify( "~b~Radar slået til." )
            else 
                Notify( "~b~Radar slået fra." )
            end 

            ResetFrontAntenna()
            ResetRearAntenna()

            SendNUIMessage({
                toggleradar = true, 
                fwdxmit = radarInfo.fwdXmit, 
                fwdmode = radarInfo.fwdMode, 
                bwdxmit = radarInfo.bwdXmit, 
                bwdmode = radarInfo.bwdMode
            })
        else 
            Notify( "~r~Du skal være i et politikøretøj." )
        end 
    else 
        Notify( "~r~Du skal være i et køretøj." )
    end 
end )

RegisterNetEvent( 'wk:changeRadarLimit' )
AddEventHandler( 'wk:changeRadarLimit', function( speed ) 
    radarInfo.fastLimit = speed 
end )






function ResetFrontAntenna()
    if ( radarInfo.fwdXmit ) then 
        radarInfo.fwdSpeed = "0"
        radarInfo.fwdFast = "0"  
    else 
        radarInfo.fwdSpeed = "OFF"
        radarInfo.fwdFast = "   "  
    end 

    radarInfo.fwdDir = nil
    radarInfo.fwdFastSpeed = 0 
    radarInfo.fwdFastLocked = false
    radarInfo.fwdCarModel = "none"
	radarInfo.fwdCarNumberPlate = "none"
end 

function ResetRearAntenna()
    if ( radarInfo.bwdXmit ) then
        radarInfo.bwdSpeed = "0"
        radarInfo.bwdFast = "0"
    else 
        radarInfo.bwdSpeed = "OFF"
        radarInfo.bwdFast = "   "
    end 

    radarInfo.bwdDir = nil
    radarInfo.bwdFastSpeed = 0 
    radarInfo.bwdFastLocked = false
    radarInfo.bwdCarModel = "none"
	radarInfo.bwdCarNumberPlate = "none"
end 

function ResetFrontFast()
    if ( radarInfo.fwdXmit ) then 
        radarInfo.fwdFast = "0"
        radarInfo.fwdFastSpeed = 0
        radarInfo.fwdFastLocked = false 
        radarInfo.fwdFastCarModel = "none"
		radarInfo.fwdFastCarNumberPlate = "none"

        SendNUIMessage( { lockfwdfast = false } )
    end 
end 

function ResetRearFast()
    if ( radarInfo.bwdXmit ) then 
        radarInfo.bwdFast = "0"
        radarInfo.bwdFastSpeed = 0
        radarInfo.bwdFastLocked = false 
        radarInfo.bwdFastCarModel = "none"
		radarInfo.bwdFastCarNumberPlate = "none"

        SendNUIMessage( { lockbwdfast = false } )
    end 
end

function ToggleLockRadar()
        if ( radarInfo.fwdFastLocked and radarInfo.bwdFastLocked ) then
            radarInfo.fwdFastLocked = false
            radarInfo.bwdFastLocked = false

            SendNUIMessage( { lockfwdfast = false } )
            SendNUIMessage( { lockbwdfast = false } )
        else
            radarInfo.fwdFastLocked = true
            radarInfo.bwdFastLocked = true

            SendNUIMessage( { lockfwdfast = true } )
            SendNUIMessage( { lockbwdfast = true } )
        end
end

function CloseRadarRC()
    SendNUIMessage({
        toggleradarrc = true
    })

    TriggerEvent( 'wk:toggleMenuControlLock', false )

    SetNuiFocus( false )
end 

function ToggleSpeedType()
    if ( radarInfo.speedType == "mph" ) then 
        radarInfo.speedType = "kmh"
        Notify( "~b~Speed type set to Km/h." )
    else 
        radarInfo.speedType = "mph"
        Notify( "~b~Speed type set to MPH." )
    end
end 

function ToggleLockBeep()
    if ( radarInfo.lockBeep ) then 
        radarInfo.lockBeep = false 
        Notify( "~b~Radar fast lock beep disabled." )
    else 
        radarInfo.lockBeep = true
        Notify( "~b~Radar fast lock beep enabled." )
    end    
end 

function GetVehSpeed( veh )
    if ( radarInfo.speedType == "mph" ) then 
        return GetEntitySpeed( veh ) * 2.236936
    else 
        return GetEntitySpeed( veh ) * 3.6
    end 
end 

function ManageVehicleRadar()
    if ( radarEnabled ) then 
        local ped = GetPlayerPed( -1 )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped and GetVehicleClass( vehicle ) == 18 ) then 
                
            
                
                
                
                -- Patrol speed 
                local vehicleSpeed = round( GetVehSpeed( vehicle ), 0 )

                radarInfo.patrolSpeed = vehicleSpeed

                -- Rest of the radar options 
                local vehiclePos = GetEntityCoords( vehicle, true )
                local h = round( GetEntityHeading( vehicle ), 0 )

                -- Front Antenna 
                if ( radarInfo.fwdXmit ) then  
                    local forwardPosition = GetOffsetFromEntityInWorldCoords( vehicle, radarInfo.angles[ radarInfo.fwdMode ].x, radarInfo.angles[ radarInfo.fwdMode ].y, radarInfo.angles[ radarInfo.fwdMode ].z )
                    local fwdPos = { x = forwardPosition.x, y = forwardPosition.y, z = forwardPosition.z }
                    local _, fwdZ = GetGroundZFor_3dCoord( fwdPos.x, fwdPos.y, fwdPos.z + 500.0 )

                    if ( fwdPos.z < fwdZ and not ( fwdZ > vehiclePos.z + 1.0 ) ) then 
                        fwdPos.z = fwdZ + 0.5
                    end 

                    local packedFwdPos = vector3( fwdPos.x, fwdPos.y, fwdPos.z )
                    local fwdVeh = GetVehicleInDirectionSphere( vehicle, vehiclePos, packedFwdPos )

                    if ( DoesEntityExist( fwdVeh ) and IsEntityAVehicle( fwdVeh ) ) then 
                        local fwdVehSpeed = round( GetVehSpeed( fwdVeh ), 0 )

                        local fwdVehHeading = round( GetEntityHeading( fwdVeh ), 0 )
                        local dir = IsEntityInMyHeading( h, fwdVehHeading, 100 )
                        radarInfo.fwdCarModel = GetDisplayNameFromVehicleModel(GetEntityModel(fwdVeh))
                        radarInfo.fwdCarNumberPlate = GetVehicleNumberPlateText(fwdVeh)
                        radarInfo.fwdSpeed = FormatSpeed( fwdVehSpeed )
                        radarInfo.fwdDir = dir 
                        if (fwdVehSpeed ~= 0) then
                            if ( fwdVehSpeed > radarInfo.fastLimit and not radarInfo.fwdFastLocked) then
                                if(fwdVehSpeed > radarInfo.fwdFastSpeed) then
                                        if ( radarInfo.lockBeep ) then 
                                            PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
                                        end

                                        radarInfo.fwdFastSpeed = fwdVehSpeed
                                        radarInfo.fwdFastCarModel = GetDisplayNameFromVehicleModel(GetEntityModel(fwdVeh))
                                        radarInfo.fwdFastCarNumberPlate = GetVehicleNumberPlateText(fwdVeh)
                                        --radarInfo.fwdFastLocked = true 

                                        --SendNUIMessage( { lockfwdfast = true } )
                                end
                            end 
                        end
                        radarInfo.fwdFast = FormatSpeed( radarInfo.fwdFastSpeed )

                        radarInfo.fwdPrevVeh = fwdVeh 
                    end
                end 

                -- Rear Antenna 
                if ( radarInfo.bwdXmit ) then 
                    local backwardPosition = GetOffsetFromEntityInWorldCoords( vehicle, radarInfo.angles[ radarInfo.bwdMode ].x, -radarInfo.angles[ radarInfo.bwdMode ].y, radarInfo.angles[ radarInfo.bwdMode ].z )
                    local bwdPos = { x = backwardPosition.x, y = backwardPosition.y, z = backwardPosition.z }
                    local _, bwdZ = GetGroundZFor_3dCoord( bwdPos.x, bwdPos.y, bwdPos.z + 500.0 )              

                    if ( bwdPos.z < bwdZ and not ( bwdZ > vehiclePos.z + 1000.0 ) ) then 
                        bwdPos.z = bwdZ + 0.5
                    end

                    local packedBwdPos = vector3( bwdPos.x, bwdPos.y, bwdPos.z )                
                    local bwdVeh = GetVehicleInDirectionSphere( vehicle, vehiclePos, packedBwdPos )

                    if ( DoesEntityExist( bwdVeh ) and IsEntityAVehicle( bwdVeh ) ) then
                        local bwdVehSpeed = round( GetVehSpeed( bwdVeh ), 0 )

                        local bwdVehHeading = round( GetEntityHeading( bwdVeh ), 0 )
                        local dir = IsEntityInMyHeading( h, bwdVehHeading, 100 )
                        radarInfo.bwdCarModel = GetDisplayNameFromVehicleModel(GetEntityModel(bwdVeh))
                        radarInfo.bwdCarNumberPlate = GetVehicleNumberPlateText(bwdVeh)
                        radarInfo.bwdSpeed = FormatSpeed( bwdVehSpeed )
                        radarInfo.bwdDir = dir 

                        if ( bwdVehSpeed > radarInfo.fastLimit and not radarInfo.bwdFastLocked ) then
                            if(bwdVehSpeed > radarInfo.bwdFastSpeed) then
                                    if ( radarInfo.lockBeep ) then 
                                        PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
                                    end 

                                    radarInfo.bwdFastSpeed = bwdVehSpeed
                                    radarInfo.bwdFastCarModel = GetDisplayNameFromVehicleModel(GetEntityModel(bwdVeh))
									radarInfo.bwdFastCarNumberPlate = GetVehicleNumberPlateText(bwdVeh)
                                    --radarInfo.bwdFastLocked = true 

                                    --SendNUIMessage( { lockbwdfast = true } )
                            end
                        end 

                        radarInfo.bwdFast = FormatSpeed( radarInfo.bwdFastSpeed )

                        radarInfo.bwdPrevVeh = bwdVeh 
                    end  
                end  

                SendNUIMessage({
                    patrolspeed = radarInfo.patrolSpeed, 
                    fwdspeed = radarInfo.fwdSpeed, 
                    fwdfast = radarInfo.fwdFast, 
                    fwddir = radarInfo.fwdDir, 
                    bwdspeed = radarInfo.bwdSpeed, 
                    bwdfast = radarInfo.bwdFast, 
                    bwddir = radarInfo.bwdDir,
                    fwdcarmodel = radarInfo.fwdCarModel,
                    fwdcarnumberplate = radarInfo.fwdCarNumberPlate,
                    fwdfastcarmodel = radarInfo.fwdFastCarModel,
					fwdfastcarnumberplate = radarInfo.fwdFastCarNumberPlate,
                    bwdcarmodel = radarInfo.bwdCarModel,
                    bwdcarnumberplate = radarInfo.bwdCarNumberPlate,
                    bwdfastcarmodel = radarInfo.bwdFastCarModel,
					bwdfastcarnumberplate = radarInfo.bwdFastCarNumberPlate
                })
            end 
        end 
    end 
end 

RegisterNetEvent( 'wk:radarRC' )
AddEventHandler( 'wk:radarRC', function()
    Citizen.Wait( 10 )

    TriggerEvent( 'wk:toggleMenuControlLock', true )

    SendNUIMessage({
        toggleradarrc = true
    })

    SetNuiFocus( true, true )
end )

RegisterNUICallback( "RadarRC", function( data, cb ) 
    -- Toggle Radar
    if ( data == "radar_toggle" ) then 
        TriggerEvent( 'wk:toggleRadar' )

    -- Front Antenna 
    elseif ( data == "radar_frontopp" and radarInfo.fwdXmit ) then
        radarInfo.fwdMode = "opp"
        SendNUIMessage( { fwdmode = radarInfo.fwdMode } )
    elseif ( data == "radar_frontxmit" ) then 
        radarInfo.fwdXmit = not radarInfo.fwdXmit 
        ResetFrontAntenna()
        SendNUIMessage( { fwdxmit = radarInfo.fwdXmit } )

        if ( radarInfo.fwdXmit == false ) then 
            radarInfo.fwdMode = "none" 
        else 
            radarInfo.fwdMode = "same" 
        end 

        SendNUIMessage( { fwdmode = radarInfo.fwdMode } )
    elseif ( data == "radar_frontsame" and radarInfo.fwdXmit ) then 
        radarInfo.fwdMode = "same"
        SendNUIMessage( { fwdmode = radarInfo.fwdMode } )

    -- Rear Antenna 
    elseif ( data == "radar_rearopp" and radarInfo.bwdXmit ) then
        radarInfo.bwdMode = "opp"
        SendNUIMessage( { bwdmode = radarInfo.bwdMode } )
    elseif ( data == "radar_rearxmit" ) then 
        radarInfo.bwdXmit = not radarInfo.bwdXmit 
        ResetRearAntenna()
        SendNUIMessage( { bwdxmit = radarInfo.bwdXmit } )

        if ( radarInfo.bwdXmit == false ) then 
            radarInfo.bwdMode = "none" 
        else 
            radarInfo.bwdMode = "same" 
        end 

        SendNUIMessage( { bwdmode = radarInfo.bwdMode } )
    elseif ( data == "radar_rearsame" and radarInfo.bwdXmit ) then 
        radarInfo.bwdMode = "same"
        SendNUIMessage( { bwdmode = radarInfo.bwdMode } )

    -- Set Fast Limit 
    elseif ( data == "radar_setlimit" ) then 
        CloseRadarRC()
        Radar_SetLimit()

    -- Speed Type 
    elseif ( data == "radar_speedtype" ) then 
        ToggleSpeedType()

    elseif ( data == "radar_lockbeep" ) then 
        ToggleLockBeep()

    -- Close 
    elseif ( data == "close" ) then 
        CloseRadarRC()
    end 

    if ( cb ) then cb( 'ok' ) end 
end )

Citizen.CreateThread( function()
    SetNuiFocus( false ) 

    while true do 
        ManageVehicleRadar()

        -- Only run 10 times a second, more realistic, also prevents spam 
        Citizen.Wait( 100 )
    end
end )

Citizen.CreateThread( function()
    while true do 
        local ped = GetPlayerPed( -1 )

        -- These control pressed natives must be the disabled check ones. 

        -- LCtrl is pressed and M has just been pressed 
        if ( IsDisabledControlPressed( 1, 21 ) and IsDisabledControlJustPressed( 1, 19 ) and IsPedSittingInAnyVehicle( ped ) ) then 
            TriggerEvent( 'wk:toggleRadar' )
        end

        -- LCtrl is not being pressed and M has just been pressed 
        if ( IsDisabledControlJustPressed( 1, 73 ) and IsPedSittingInAnyVehicle( ped ) ) then 
            ResetFrontAntenna()
            ResetRearAntenna()
            ResetFrontFast()
            ResetRearFast()
        end

        if (IsDisabledControlJustPressed( 1, 21 ) and IsPedSittingInAnyVehicle( ped ) ) then
            ToggleLockRadar()
        end

        local inVeh = IsPedSittingInAnyVehicle( ped )
        local veh = nil 

        if ( inVeh ) then
            veh = GetVehiclePedIsIn( ped, false )
        end 

        if ( ( (not inVeh or (inVeh and GetVehicleClass( veh ) ~= 18)) and radarEnabled and not hidden) or IsPauseMenuActive() and radarEnabled ) then 
            hidden = true 
            SendNUIMessage( { hideradar = true } )
        elseif ( inVeh and GetVehicleClass( veh ) == 18 and radarEnabled and hidden ) then 
            hidden = false 
            SendNUIMessage( { hideradar = false } )
        end 
    
            if (IsDisabledControlJustPressed(1, 10)) then
                if(currentSelected ~= 3) then
                currentSelected = currentSelected + 1
                speed = theLimits[currentSelected]
                TriggerEvent( 'wk:changeRadarLimit', speed )
                SendNUIMessage( { changeLimit = speed } )
                end
            end
            if (IsDisabledControlJustPressed(1, 11)) then
                if(currentSelected ~= 1) then
                currentSelected = currentSelected - 1
                speed = theLimits[currentSelected]
                TriggerEvent( 'wk:changeRadarLimit', speed )
                SendNUIMessage( { changeLimit = speed } )
                end
            end



        Citizen.Wait( 0 )
    end 
end )


--[[------------------------------------------------------------------------
    Menu Control Lock - Prevents certain actions 
    Thanks to the authors of the ES Banking script. 
------------------------------------------------------------------------]]--
local locked = false 

RegisterNetEvent( 'wk:toggleMenuControlLock' )
AddEventHandler( 'wk:toggleMenuControlLock', function( lock ) 
    locked = lock 
end )

Citizen.CreateThread( function()
    while true do
        if ( locked ) then 
            local ped = GetPlayerPed( -1 )  

            DisableControlAction( 0, 1, true ) -- LookLeftRight
            DisableControlAction( 0, 2, true ) -- LookUpDown
            DisableControlAction( 0, 24, true ) -- Attack
            DisablePlayerFiring( ped, true ) -- Disable weapon firing
            DisableControlAction( 0, 142, true ) -- MeleeAttackAlternate
            DisableControlAction( 0, 106, true ) -- VehicleMouseControlOverride

            SetPauseMenuActive( false )
        end 

        Citizen.Wait( 0 )
    end 
end )


--[[------------------------------------------------------------------------
    Notify  
------------------------------------------------------------------------]]--
function Notify( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentSubstringPlayerName( text )
    DrawNotification( false, true )
end 