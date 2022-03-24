Config = {}

Config.unemployed = "unemployed" --<-- enter here the name of the job that the player will be put in when it is kicked from the job
Config.maxDistance = 15.0
Config.speedMeasurement = 3.6 -- kmh
Config.speedMeasurementLabel = "kmh"

Config.useButtonToOpenJobTablet = true

-- README --



------------

Config.keybinds = {
	["OPENJOBTABLET"] = {
		key = 166, -- F5
		name = "",
	},
	["ARROW_UP"] = {
		key = 172,
		name = "~INPUT_CELLPHONE_UP~",
	},
	["ARROW_DOWN"] = {
		key = 173,
		name = "~INPUT_CELLPHONE_DOWN~",
	},
	["ARROW_LEFT"] = {
		key = 174,
		name = "~INPUT_CELLPHONE_LEFT~",
	},
	["ARROW_RIGHT"] = {
		key = 175,
		name = "~INPUT_CELLPHONE_RIGHT~",
	},
	["E"] = {
		key = 86,
		name = "~INPUT_VEH_HORN~",
	},
	["E"] = {
		key = 86,
		name = "~INPUT_VEH_HORN~",
	},
	["LSHIFT"] = {
		key = 209,
		name = "~INPUT_FRONTEND_LS~",
	},
	["LSHIFT"] = {
		key = 209,
		name = "~INPUT_FRONTEND_LS~",
	},
	["SCROLLUP"] = {
		key = 14,
		name = "~INPUT_WEAPON_WHEEL_NEXT~",
	},
	["SCROLLDOWN"] = {
		key = 15,
		name = "~INPUT_WEAPON_WHEEL_PREV~",
	},
	["ENTER"] = {
		key = 191,
		name = "~INPUT_FRONTEND_RDOWN~",
	},
	["V"] = {
		key = 236,
		name = "~INPUT_SCRIPT_SELECT~",
	},
	["BACKSPACE"] = {
		key = 194,
		name = "~INPUT_FRONTEND_RRIGHT~",
	},
}

-- Locations wher player can craft camtablets
Config.tabletCraftingLocations = {
	{
		coords = vector4(2329.153, 2571.5, 45.7, 0.0),
		markertype = 25,
		markersize = 2.0,
		markerheight = 0.3,
		markercolor = vector4(150, 0, 0, 255),
	},
	--[[{
		coords = vector4(40.33, -1478.25,30.0,0.0),
		markertype = 1,
		markersize = 2.0,
		markerheight = 0.5,
		markercolor = vector4(255,255,255,255),
	},]]
}
Config.vehiclespawns = {
	{
		coords = vector4(2324.58, 2574.3, 45.7, 340.0),
		markertype = 25,
		markersize = 2.0,
		markerheight = 0.3,
		markercolor = vector4(150, 0, 0, 255),
		vehiclemodel = "BobcatXL",
	}
}
Config.storage = {
	coords = vector4(2332.2, 2573.9, 40.7, 0.0),
	markertype = 25,
	markersize = 2.0,
	markerheight = 0.3,
	markercolor = vector4(150, 0, 0, 255),
}


-- This is for crafting --
Config.minigame = {
	minTaps = 5, -- How many times player need to tap key to get 1 product min
	maxTaps = 10, -- How many times player need to tap key to get 1 product max
	minSpeed = 3, -- How long player has time to press button min 
	maxSpeed = 6 -- How long player has time to press button max 
}





