Config                            = {}
Config.Locale                     = 'en'

Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.DamageNeeded = 100.0 -- 100.0 being broken and 1000.0 being fixed a lower value than 100.0 will break it
Config.MaxWidth = 5.0 -- Will complete soon
Config.MaxHeight = 5.0
Config.MaxLength = 5.0

Config.Zones = {

	MechanicActions = {
		Pos   = {
			{544.31, -200.75, 53.58}
		},
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 25
	},

	VehicleSpawnPoint = {
		Pos   = {
			{x = 548.1,  y = -207.85,  z = 53.98}
		},
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 27
	},

	VehicleDeleter = {
		Pos   = {
			{548.1, -207.85, 53.20}
		},
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 25
	},

	VehicleDelivery = {
		Pos   = {
			{-382.925,-133.748,37.685 }
		},
		Size  = { x = 20.0, y = 20.0, z = 3.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}
}

Config.RepairPoints = {
	Pos   = {
		{1143.095, -778.3971, 56.68, veh = nil}
	},
	Size  = { x = 2.5, y = 2.5, z = 1.0 },
	Color = { r = 204, g = 204, b = 0 },
	Type  = 25
}

Config.lifts = {
	
}