-- CONFIG --

-- Blacklisted weapons
weaponblacklist = {
	"WEAPON_MINIGUN",
	"weapon_rpg",
	"weapon_raypistol",
	"weapon_autoshotgun",
	"weapon_grenadelauncher",
	"weapon_grenadelauncher_smoke",
	"weapon_firework",
	"weapon_railgun",
	"weapon_hominglauncher",
	"weapon_compactlauncher",
	"weapon_rayminigun",
	"weapon_stickybomb",
	"weapon_proxmine",
	"weapon_grenade",
	"weapon_molotov",
	"weapon_proxmine",
	"weapon_pipebomb",
	"weapon_ball",
	"weapon_flare",
	"weapon_bzgas",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_ASSAULTRIFLE_MK2"
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
					sendForbiddenMessage("This weapon is blacklisted!")
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