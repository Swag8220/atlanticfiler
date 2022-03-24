RegisterCommand("silencer230",
    function()
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x65EA7EBB)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x837445AA)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xA73D4664)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xC304849A)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xE608B35E)
    end)

    RegisterCommand("fjernsilencer230",
    function()
        RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x65EA7EBB)
        RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x837445AA)
        RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xA73D4664)
        RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xC304849A)
        RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xE608B35E)
    end)

    RegisterCommand("mag230",
    function()
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x91109691)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xB92C6979)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xED265A1C)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x64F9C62B)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xD9D3AC92)
    end)

    RegisterCommand("carbine23",
    function()
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x91109691)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x7BC4CDDC)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xA0D89C42)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x837445AA)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xC164F53)
    end)

    RegisterCommand("micro230",
    function()
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x10E6BA2B)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x9D2FBF29)
        GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xA73D4664)
    end)