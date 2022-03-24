local show = true

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        TriggerServerEvent("bmz-servermark")
    end
end)

RegisterCommand("watermark", function()
    if show == true then
        show = false
        TriggerEvent('t-notify:client:Custom', {
            style = 'error',
            duration = 7500,
            title = 'Indstillinger',
            image = "https://i.imgur.com/xvTlNI8.png",
            message = '**OPDATERET** \n Du har nu fjernet dit watermark. Den vil forsvinde inden for 30 sekunder.',
            sound = true,
            custom = true
          })
    elseif show == false then
        show = true
        TriggerEvent('t-notify:client:Custom', {
            style = 'success',
            duration = 7500,
            title = 'Indstillinger',
            image = "",
            message = '**OPDATERET** \n Du har nu tilføjet dit watermark. Den vil komme inden for 30 sekunder.',
            sound = true,
            custom = true
          })
    end
end)

RegisterNetEvent("bmzersej")
AddEventHandler("bmzersej", function(player)
    SendNUIMessage({players = player, showmark = show})
end)


function closeGui()
    show = false
    SetNuiFocus(false)
    SendNUIMessage({show = false})
  end