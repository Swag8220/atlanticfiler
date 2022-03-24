Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 25, x = 1.5, y = 1.5, z = 0.5, r = 255, g = 255, b = 0, a = 100, rotate = false }

Config.ReviveReward               = 0  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 10 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 59 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.respawnpoints = {
	{ coords = vector3(299.0663, -584.5848, 43.26), heading = 68 }
}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(302.7883, -586.0794, 42.2),
			sprite = 61,
			scale  = 0.7,
			color  = 1
		},

		Blip2 = {
			coords = vector3(1837.36, 3676.4, 34.2),
			sprite = 61,
			scale  = 0.7,
			color  = 1
		},

		OpenCloakroomMenu = {
			vector3(299.1272, -598.7881, 42.3)
		},

		AmbulanceActions = {
			vector3(0, 0, 0)
		},
		AmbulanceBossActions = {
			vector3(334.8116, -594.0663, 43.28405)
		},

		jobStart = {
			vector3(303.693, -600.6847, 42.3)
		},

        AmbulanceActions1 = {
			vector3(300, 3676.74, 1)
		},

		Pharmacies = {
			vector3(306.7427, -601.80718, 42.3)
		},

		Vehicles = {
			{
				Spawner = vector3(337.15, -579.38, 28.8),
				InsideShop = vector3(228.5, -993.5, -99.99),
				Marker = { type = 36, x = 1.0, y = 0.5, z = 1.0, r = 255, g = 238, b = 0, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(333.22, -589.78, 28.8), heading = 160.0, radius = 4.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(343.38, -585.23, 73.8),
				InsideShop = vector3(350.9718, -587.8890, 73.2),
				Marker = { type = 34, x = 1.0, y = 0.5, z = 1.0, r = 255, g = 238, b = 0, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(350.9718, -587.8890, 73.2), heading = 142.7, radius = 10.0 }
				}
			}
		},

		FastTravels = {
			{
				From = vector3(327.1341, -603.8278, 42.3),
				To = { coords = vector3(343.38, -585.23, 73.17), heading = 0.0 },
				Marker = { type = 25, x = 2.0, y = 2.0, z = 0.5, r = 255, g = 238, b = 0, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(339.51, -584.03, 73.17),
				To = { coords = vector3(327.9373, -601.6695, 42.2), heading = 0.0 },
				Marker = { type = 25, x = 2.0, y = 2.0, z = 0.5, r = 255, g = 238, b = 0, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(332.34, -595.62, 42.3),
				To = { coords = vector3(345.61, -582.54, 27.8), heading = 250.0 },
				Marker = { type = 25, x = 1.5, y = 1.5, z = 0.5, r = 255, g = 238, b = 0, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(345.61, -582.54, 27.8),
				To = { coords = vector3(332.34, -595.62, 42.3), heading = 70.0 },
				Marker = { type = 25, x = 1.5, y = 1.5, z = 0.5, r = 255, g = 238, b = 0, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			}
		}

	}
}

Config.AuthorizedVehicles = {   

	ambulance = {
		{ model = 'vwtouaregambu', label = 'VW Touran - Læge', price = 0},
		{ model = 'vwcrafterambu', label = 'VW Crafter - Ambulance', price = 0},
		{ model = 'volvoambu', label = 'Volvo XC90 - Akut', price = 0},
		{ model = 'mbsprinterambu', label = 'Mercedes Sprinter - Ambulance', price = 0},
	},

	doctor = {
		{ model = 'vwtouaregambu', label = 'VW Touran - Læge', price = 0},
		{ model = 'vwcrafterambu', label = 'VW Crafter - Ambulance', price = 0},
		{ model = 'volvoambu', label = 'Volvo XC90 - Akut', price = 0},
		{ model = 'mbsprinterambu', label = 'Mercedes Sprinter - Ambulance', price = 0},
	},	

	chief_doctor = {
		{ model = 'vwtouaregambu', label = 'VW Touran - Læge', price = 0},
		{ model = 'vwcrafterambu', label = 'VW Crafter - Ambulance', price = 0},
		{ model = 'volvoambu', label = 'Volvo XC90 - Akut', price = 0},
		{ model = 'mbsprinterambu', label = 'Mercedes Sprinter - Ambulance', price = 0},
	},	

	boss = {
		{ model = 'vwtouaregambu', label = 'VW Touran - Læge', price = 0},
		{ model = 'vwcrafterambu', label = 'VW Crafter - Ambulance', price = 0},
		{ model = 'volvoambu', label = 'Volvo XC90 - Akut', price = 0},
		{ model = 'mbsprinterambu', label = 'Mercedes Sprinter - Ambulance', price = 0},
	}

}

Config.AuthorizedHelicopters = {

	ambulance = {
		{ model = 'ambumav', label = 'Læge Helikopter', price = 0},
	},

	doctor = {
		{ model = 'ambumav', label = 'Læge Helikopter', price = 0},
	},	

	chief_doctor = {
		{ model = 'ambumav', label = 'Læge Helikopter', price = 0},
	},	

	boss = {
		{ model = 'ambumav', label = 'Læge Helikopter', price = 0},
	}

}