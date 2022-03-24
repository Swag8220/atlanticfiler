Config 					= {}

Config.Impound 			= {
	Name = "MissionRow",
	RetrieveLocation = { X = 411.91, Y = -1621.29, Z = 29.29 },
	StoreLocation = {X = 399.52, Y = -1647.53, Z = 29.29 },

	SpawnLocations = {
		{ x = 818.21, y = -1334.90, z = 26.10 , h = 180.00 },
		{ x = 818.21, y = -1341.20, z = 26.10 , h = 180.00 },
		{ x = 818.21, y = -1349.00, z = 26.10 , h = 180.00 },
		{ x = 818.21, y = -1355.00, z = 26.10 , h = 180.00 },
		{ x = 818.21, y = -1363.00, z = 26.10 , h = 180.00 },
	},
	AdminTerminalLocations = {
		{ x = 402.7888, y = -1624.406, z = 29.29206 },
	}
}

Config.Rules = {
	maxWeeks		= 5,
	maxDays			= 6,
	maxHours		= 24,

	minFee			= 50,
	maxFee 			= 150000,

	minReasonLength	= 10,
}

--------------------------------------------------------------------------------
----------------------- SERVERS WITHOUT ESX_MIGRATE ----------------------------
---------------- This could work, it also could not work... --------------------
--------------------------------------------------------------------------------
-- Should be true if you still have an owned_vehicles table without plate column.
Config.NoPlateColumn = false
-- Only change when NoPlateColumn is true, menu's will take longer to show but otherwise you might not have any data.
-- Try increments of 250
Config.WaitTime = 250
