Config = {}

-- The language the script uses
Config.Locale = 'da'

-- Should there come an action text when equipping a weapon?
Config.Actiontxt = true

-- The text color of the action
Config.ActionColor = {r=250,g=140,b=0,a=255 }

-- The amount of time the action should be shown in seconds.
Config.ActionTime = 3

-- Should you could equip weapons from bags?
Config.AllowBag = true

-- Drawablenumber of the bags.
Config.Bags = {
    male = {12,40,41,42,43,44,45,46,47,51,52,81,82,83,84,85,86,87,88},
    female = {71,72,73,74,75,76,77,78},
}

-- The weapons that are needed to be equiped out of a car or bag.
-- The weapon name, not hash!
Config.Weps = {
    'weapon_bat',
    'weapon_crowbar',
    'weapon_golfclub',
    'weapon_hatchet',
    'weapon_machete',
    'weapon_wrench',
    'weapon_battleaxe',
    'weapon_poolcue',
    'weapon_stone_hatchet',
    'weapon_smg',
    'weapon_minismg',
    'weapon_sawnoffshotgun',
    'weapon_assaultrifle',
    'weapon_carbinerifle',
    'weapon_gusenberg',
    'weapon_dbshotgun',
    'weapon_revolver',
    'weapon_machinepistol',
    'weapon_pumpshotgun'
}