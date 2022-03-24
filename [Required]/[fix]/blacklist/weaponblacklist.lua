-- CONFIG --

-- Blacklisted weapons
weaponblacklist = {
	"WEAPON_AIRSTRIKE_ROCKET",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_COMBATMG",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_GRENADE",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_MG",
	"WEAPON_MOLOTOV",
	"WEAPON_PASSENGER_ROCKET",
	"WEAPON_PIPEBOMB",
	"WEAPON_PROXMINE",
	"WEAPON_RAILGUN",
	"WEAPON_RPG",
	"WEAPON_SMG_MK2",
	"WEAPON_STICKYBOMB",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_PISTOL_MK2",
	"WEAPON_MINIGUN",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_APPISTOL",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_MINISMG"
}

-- Don't allow any weapons at all (overrides the blacklist)
disableallweapons = false

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			nothing, weapon = GetCurrentPedWeapon(playerPed, true)

			if disableallweapons then
				RemoveAllPedWeapons(playerPed, true)
			else
				if isWeaponBlacklisted(weapon) then
					RemoveWeaponFromPed(playerPed, weapon)
				end
			end
		end
	end
end)

function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(weaponblacklist) do
		if model == GetHashKey(blacklistedWeapon) then
			return true
		end
	end

	return false
end