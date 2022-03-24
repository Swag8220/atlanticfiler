local labels = {
  ['en'] = {
    ['Entry']       = "Indgang",
    ['Exit']        = "Udgang",
    ['Garage']      = "Garage",
    ['Wardrobe']    = "Garderobe",
    ['Inventory']   = "Inventar",
    ['InventoryLocation']   = "Inventar",

    ['LeavingHouse']      = "Gå ud af huset",

    ['AccessHouseMenu']   = "Tilgå hus menuen",

    ['InteractDrawText']  = "["..Config.TextColors[Config.MarkerSelection].."E~s~] ",
    ['InteractHelpText']  = "~INPUT_PICKUP~ ",

    ['AcceptDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."G~s~] ",
    ['AcceptHelpText']    = "~INPUT_DETONATE~ ",

    ['FurniDrawText']     = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",
    ['CancelDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",

    ['VehicleStored']     = "Bilen/motorcyklen blev sat i garagen",
    ['CantStoreVehicle']  = "Du kan ikke sætte Bilen/motorcyklen i garagen",

    ['HouseNotOwned']     = "Du ejer ikke det her hus",
    ['InvitedInside']     = "Accepter invitation",
    ['MovedTooFar']       = "Du gik for langt væk fra døren",
    ['KnockAtDoor']       = "Nogle banker på din dør",

    ['TrackMessage']      = "Track message",

    ['Unlocked']          = "Hus låst op",
    ['Locked']            = "Hus låst",

    ['WardrobeSet']       = "Placer din Garderobe",
    ['InventorySet']      = "Placer dit inventar",

    ['ToggleFurni']       = "Skift møbel -brugergrænseflade",

    ['GivingKeys']        = "Giver nølger til spilleren",
    ['TakingKeys']        = "Tager nølger fra spilleren",

    ['GarageSet']         = "Garage Lokation Sat",
    ['GarageTooFar']      = "Garagen er for langt væk",

    ['PurchasedHouse']    = "Du har købt huset for $%d",
    ['CantAffordHouse']   = "Du har ikke råd til huset",

    ['MortgagedHouse']    = "You mortgaged the house for $%d",

    ['NoLockpick']        = "Du har ingen lockpick",
    ['LockpickFailed']    = "Du knækkede lockpicken",
    ['LockpickSuccess']   = "LockpickSuccess ",

    ['NotifyRobbery']     = "Nogen forsøger at stjæle et hus ved %s",

    ['ProgressLockpicking'] = "Lockpicker Dør",

    ['InvalidShell']        = "Ugyldig husskal: %s, rapporter venligst til din serverejer.",
    ['ShellNotLoaded']      = "ville ikke indlæse: %s, rapporter venligst til din serverejer.",
    ['BrokenOffset']        = "Offset er rodet til hus med ID %s, rapporter venligst til din serverejer.",

    ['UpgradeHouse']        = "Opgrader dit hus for: %s",
    ['CantAffordUpgrade']   = "Du har ikke råd til denne opgradering",

    ['SetSalePrice']        = "Set Salgs pris",
    ['InvalidAmount']       = "Ikke gyldigt talt skrevet",
    ['InvalidSale']         = ".......",
    ['InvalidMoney']        = "Du har ikke nok penge",

    ['EvictingTenants']     = "Evicting tenants",

    ['NoOutfits']           = "Du har ikke nogen gemte outfits",

    ['EnterHouse']          = "Gå ind i hus",
    ['KnockHouse']          = "Bank på",
    ['RaidHouse']           = "Ransag Hus",
    ['BreakIn']             = "Break In",
    ['InviteInside']        = "Inviter indefor",
    ['HouseKeys']           = "Hus Nøgler",
    ['UpgradeHouse2']       = "Opgrader Hus",
    ['UpgradeShell']        = "Upgrade Shell",
    ['SellHouse']           = "Sælg Hus",
    ['FurniUI']             = "Furni UI",
    ['SetWardrobe']         = "Set Gaderobe",
    ['SetInventory']        = "Set Inventar",
    ['SetGarage']           = "Set Garage",
    ['LockDoor']            = "Lås Dør",
    ['UnlockDoor']          = "Lås Hus op",
    ['LeaveHouse']          = "Forlad Hus",
    ['Mortgage']            = "Mortgage",
    ['Buy']                 = "Køb",
    ['View']                = "Se",
    ['Upgrades']            = "Opgrader",
    ['MoveGarage']          = "Flyt Garage",

    ['GiveKeys']            = "Giv Nøgler",
    ['TakeKeys']            = "Tag Nøgler",

    ['MyHouse']             = "Mit Hus",
    ['PlayerHouse']         = "Person Hus",
    ['EmptyHouse']          = "Forladt Hus",

    ['NoUpgrades']          = "Ingen tilgængelige opgraderinger",
    ['NoVehicles']          = "Ingen køretøjer",
    ['NothingToDisplay']    = "Intet at vise",

    ['ConfirmSale']         = "Ja, Sælg huset",
    ['CancelSale']          = "Nej, Ikke sælg mit hus",
    ['SellingHouse']        = "Sælg Hus ($%d)",

    ['MoneyOwed']           = "Skyldige penge: $%s",
    ['LastRepayment']       = "Sidste tilbagebetaling: %s",
    ['PayMortgage']         = "Betal realkreditlån",
    ['MortgageInfo']        = "Mortgage Info",

    ['SetEntry']            = "Set indgang",
    ['CancelGarage']        = "Annuller Garage",
    ['UseInterior']         = "Brug Interior",
    ['UseShell']            = "Brug Shell",
    ['InteriorType']        = "Set Interior Type",
    ['SetInterior']         = "Vælg Current Interior",
    ['SelectDefaultShell']  = "Vælg default house shell",
    ['ToggleShells']        = "Toggle shells available for this property",
    ['AvailableShells']     = "Available Shells",
    ['Enabled']             = "~g~ENABLED~s~",
    ['Disabled']            = "~r~DISABLED~s~",
    ['NewDoor']             = "Add Ny Dør",
    ['Done']                = "Færdig",
    ['Doors']               = "Døre",
    ['Interior']            = "Interior",

    ['CreationComplete']    = "Hus created.",

    ['HousePurchased'] = "Dit hus er købt $%d",
    ['HouseEarning']   = ", Du tjente $%d for og sælge dit hus."
  }
}

Labels = labels[Config.Locale]
