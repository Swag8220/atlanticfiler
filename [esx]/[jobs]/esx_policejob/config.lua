Config                            = {}

Config.DrawDistance = 20.0
Config.MarkerType                 = {Cloakrooms = 25, Armories = 21, BossActions = 22, Vehicles = 36, Helicopters = 34}
Config.MarkerSize = {x = 1.5, y = 1.5, z = 1.0}
Config.MarkerColor = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true -- Enable if you want society managing.
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableLicenses             = true -- Enable if you're using esx_license.

Config.EnableHandcuffTimer        = true -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableJobBlip              = true -- Enable blips for cops on duty, requires esx_society.
Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.

Config.EnableESXService           = true -- Enable esx service?
Config.MaxInService               = 40 -- How much people can be in service at once?

Config.Locale                     = 'da'

Config.PoliceStations = {

	LSPD = {

        Blip = {
            Coords  = vector3(425.1, -979.5, 30.7),
            Sprite  = 60,
            Display = 4,
            Scale   = 1.2,
            Colour  = 29
        },

		Cloakrooms = {
			vector3(463.02, -996.56, 29.72),
		},
		
		Armories = {
			vector3(482.48, -995.57, 30.71),
		},
		
        Vehicles = {
            {
				Spawner = vector3(459.53, -986.77, 25.69),
                Deleters = {
                    {coords = vector3(435.93, -975.74, 24.7)},
                    {coords = vector3(450.57, -975.74, 24.75)}
                },
                SpawnPoints = {
					{coords = vector3(458.92, -993.07, 25.22), heading = 0.5, radius = 6.0}
                }
            },
        },

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 43.6),
				Deleters = {
					vector3(449.5, -981.2, 42.6),
				},
				SpawnPoints = {
					{coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0}
				}
			}
		},

		BossActions = {
			vector3(463.32, -985.01, 30.69)
		}

    },

    DAVIS = {

		Blip = {
			Coords  = vector3(371.86, -1592.78, 36.95),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(360.75375366211,-1593.0554199219,24.45153427124)
		},

		Armories = {
			vector3(364.69866943359,-1603.8981933594,25.451557159424)
		},

		Vehicles = {
			{
				Spawner = vector3(383.63430786133,-1616.9631347656,29.292081832886),
				Deleters = {
					{coords = vector3(386.67669677734,-1615.0172119141,29.292081832886)}
				},
				SpawnPoints = {
					{coords = vector3(386.67669677734,-1615.0172119141,29.292081832886), heading = 225.61, radius = 6.0}
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(0,0,0),
				Deleters = {
					vector3(0,0,0),
				},
				SpawnPoints = {
					{coords = vector3(0,0,0), heading = 312.83, radius = 10.0}
				}
			}
		},

		BossActions = {
			vector3(358.69873046875,-1590.9788818359,31.051420211792)
		}

	},
    
    SANDYSHORES = {

		Blip = {
			Coords  = vector3(1853.52, 3691.06, 39.05),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(1849.27, 3695.87, 34.26)
		},

		Armories = {
			vector3(1842.67, 3691.41, 34.26)
		},

		Vehicles = {
			{
				Spawner = vector3(1863.57, 3693.24, 34.27),
				Deleters = {
					{coords = vector3(1868.62, 3696.2, 32.58)},
					{coords = vector3(1863.6, 3703.39, 32.55)}
				},
				SpawnPoints = {
					{coords = vector3(1868.62, 3696.2, 33.56), heading = 209.0, radius = 3.0},
					{coords = vector3(1863.6, 3703.39, 33.46), heading = 209.0, radius = 3.0}
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(1881.78, 3705.71, 33.21),
				Deleters = {
					vector3(1887.34, 3708.98, 31.93),
				},
				SpawnPoints = {
					{coords = vector3(1887.34, 3708.98, 32.93), heading = 211.45, radius = 10.0}
				}
			}
		},

		BossActions = {
			vector3(1862.39, 3690.16, 34.26)
		}

    },

	PET = {

		Blip = {
			Coords  = vector3(2517.1032714844,-341.96139526367,101.89339447021),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(2517.6130371094,-346.07080078125,100.89338684082)
		},

		Armories = {
			vector3(2525.427734375,-342.71353149414,101.89337158203)
		},

		Vehicles = {
			{
				Spawner = vector3(2517.8125,-454.69638061523,92.992897033691),
				Deleters = {
					{coords = vector3(2521.4372558594,-459.93054199219,91.992935180664)},
				},
				SpawnPoints = {
					{coords = vector3(2521.4372558594,-459.93054199219,92.992935180664), heading = 196.0, radius = 6.0},
					-- {coords = vector3(-450.91, 5998.13, 31.34), heading = 86.0, radius = 6.0}
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(2515.6931152344,-336.70455932617,118.02433013916),
				Deleters = {
					vector3(2510.5881347656,-341.85906982422,117.28534851074),
				},
				SpawnPoints = {
					{coords = vector3(2510.5881347656,-341.85906982422,118.18534851074), heading = 226.45, radius = 10.0}
				}
			}
		},

		BossActions = {
			vector3(2495.9111328125,-424.94409179688,99.112274169922)
		}

	},
    
    PALETOBAY = {

		Blip = {
			Coords  = vector3(-447.54, 6015.8, 31.72),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(-438.18225097656,6012.517578125,35.995674133301)
		},

		Armories = {
			vector3(-449.3860168457,6015.1591796875,36.995655059814)
		},

		Vehicles = {
			{
				Spawner = vector3(-456.29763793945,6019.9506835938,31.489635467529),
				Deleters = {
					{coords = vector3(-468.60079956055,6038.69921875,31.340393066406)},
				},
				SpawnPoints = {
					{coords = vector3(-472.73162841797,6035.4716796875,31.340402603149), heading = 230.0, radius = 6.0},
					-- {coords = vector3(-450.91, 5998.13, 31.34), heading = 86.0, radius = 6.0}
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(-468.29, 6002.11, 31.3),
				Deleters = {
					vector3(-475.28, 5988.47, 30.34),
				},
				SpawnPoints = {
					{coords = vector3(-475.28, 5988.47, 31.34), heading = 319.45, radius = 10.0}
				}
			}
		},

		BossActions = {
			vector3(-432.82095336914,6005.9765625,36.995666503906)
		}

	}

}

Config.IllegalItems = {
	'marijuana',
	'weed20g',
	'weed4g',
	'weedbrick',
	'weed_packaged',
	'weed_untrimmed',
	'cocaine_cut',
	'cocaine_packaged',
	'cocaine_uncut',
	'coke10g',
	'coke1g',
	'cokebrick',
	'heroin',
	'lsd',
	'lsa',
	'strips',
	'MountedScope',
	'suppressor',
	'bank_c4',
	'cokeplante',
	'cannabis',
}

Config.AuthorizedArmory = {
	{label = _U('combatpistol'), weapon = 'WEAPON_COMBATPISTOL'},
	{label = _U('stungun'), weapon = 'WEAPON_STUNGUN', ammo = 1},
	{label = _U('flashlight'), weapon = 'WEAPON_FLASHLIGHT', ammo = 1},
	{label = _U('nightstick'), weapon = 'WEAPON_NIGHTSTICK', ammo = 1},
	{label = _U('fireextinguisher'), weapon = 'WEAPON_FIREEXTINGUISHER', ammo = 4000},
	{label = _U('heavypistol'), weapon = 'WEAPON_HEAVYPISTOL'},
	{label = _U('smg'), weapon = 'WEAPON_SMG'},
	{label = _U('carbinerifle'), weapon = 'WEAPON_CARBINERIFLE'},
	{label = _U('smokegrenade'), weapon = 'WEAPON_SMOKEGRENADE', ammo = 5},
	{label = _U('weapon_suppressor'), item = 'suppressor'},
	{label = _U('weapon_clip_extended'), item = 'magasin'},
	{label = _U('weapon_flashlight'), item = 'flashlight'},
	{label = _U('weapon_radio'), item = 'radio'},
	{label = _U('weapon_scope'), item = 'scope'},
	{label = 'Skudsikker vest', item = 'skudsikkervest'},
}
Config.AuthorizedVehicles = {
	car = {
		{model = 'gle450politi', label = 'Mercedes GLE - Markeret'},
		{model = '2020passat', label = '2020 Volkswagen Passat - Markeret'}, 
		{model = '2021arteon', label = '2021 Volkswagen Arteon - Markeret'},
		{model = 'e63politi', label = 'E63 Mercedes - Markeret'},
		{model = 'gle450politi', label = 'Mercedes GLE - Markeret'},
		{model = '2016touran', label = '2016 Volkswagen Touran - Markeret'},
		{model = 'ToyotaPrado3Blink', label = 'Toyota Prado - Markeret'},
		{model = '2016TouranHund', label = '2016 Volkswagen Touran - Hundepatrluje'},
		{model = '2016MondeoHund', label = '2016 Ford Mondeo - Hundepatrulje'}, 
        {model = 'YamahaPOLITI', label = 'Yamaha FJR1300 - MC'},
		{model = 'F700Politi', label = 'BMW 800 GS - MC'},
		{model = 'R1200POLITI', label = 'Bmw R1200 - MC'},
		{model = 'tailgatercivil', label = 'Tailgater - Civil', randomColor = true, windowTint = 1},
		{model = 'ocelotcivil', label = 'Ocelot - Civil', randomColor = true, windowTint = 1},
		{model = 'oraclecivil', label = 'Oracle - Civil', randomColor = true, windowTint = 1},
		{model = 'schaftercivil', label = 'Schafter V12 - KRIM', randomColor = true, windowTint = 1},
        {model = 'T6Indsatsleder', label = 'Volkswagen T6 - Indsatsleder'},
		{model = 'touragpol', label = 'Volkswagen - 2020 Tourag'},
		{model = 'krimpol', label = 'Volkswagen T6 - KTA Vogn'},
        {model = 'xlscivil', label = 'XLS - Romeo', color = 0, windowTint = 1},
		{model = 'ToyotaPradoAKSCIVIL', label = 'Toyota Prado - AKS', color = 0, windowTint = 1},
	},

	helicopter = {
		{model = 'polmav', label = 'Politi Helikopter'}
	}
}

Config.CustomPeds = {
	shared = {
		{label = 'Sheriff Ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'},
		{label = 'Police Ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'}
	},

	recruit = {},

	officer = {},

	sergeant = {},

	lieutenant = {},

	boss = {
		{label = 'SWAT Ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
    uniform_mc = {
        male = {
            tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 81,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 57,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
            shoes_1 = 25,   shoes_2 = 0,
            bproof_1 = 25,  bproof_2 = 0,
			helmet_1 = 3,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 122,     mask_2 = 0,
			glasses_1 = 0,    glasses_2 = 0
        },
        female = {
            tshirt_1 = 15,  tshirt_2 = 1,
			torso_1 = 81,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 17,      arms_2 = 0,
			pants_1 = 49,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 2,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			mask_1 = 122,     mask_2 = 0,
        }
    },
    uniform_mik = {
        male = {
            tshirt_1 = 61,  tshirt_2 = 0,
			torso_1 = 275,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 4,      arms_2 = 0,
			pants_1 = 9,   pants_2 = 7,
            shoes_1 = 12,   shoes_2 = 6,
            bproof_1 = 0,  bproof_2 = 0,
			helmet_1 = 125,  helmet_2 = 5,
			chain_1 = 8,    chain_2 = 0,
			glasses_1 = 0,    glasses_2 = 0,
			mask_1 = 0,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
	uniform_krim = {
        male = {
            tshirt_1 = 23,  tshirt_2 = 1,
			torso_1 = 15,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 4,      arms_2 = 0,
			pants_1 = 9,   pants_2 = 7,
           shoes_1 = 12,   shoes_2 = 6,
            bproof_1 = 0,  bproof_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			glasses_1 = 0,    glasses_2 = 0,
			mask_1 = 0,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
	uniform_aks = {
        male = {
            tshirt_1 = 130,  tshirt_2 = 0,
			torso_1 = 80,   torso_2 = 1,
			decals_1 = 0,   decals_2 = 1,
			arms = 16,      arms_2 = 0,
			pants_1 = 47,   pants_2 = 1,
            bproof_1 = 10,  bproof_2 = 0,
            shoes_1 = 12,   shoes_2 = 6,
			helmet_1 = 96,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			glasses_1 = 25,    glasses_2 = 0,
			mask_1 = 110,     mask_2 = 3,
			bags_1 = 83,      bags_2 = 3
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 10,   decals_2 = 1,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
    uniform_romeo_1 = {
        male = {
            tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,      arms_2 = 0,
			pants_1 = 99,   pants_2 = 0,
            bproof_1 = 6,  bproof_2 = 1,
            shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 5,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			glasses_1 = 15,    glasses_2 = 0,
			mask_1 = 0,     mask_2 = 0,
			bags_1 = 51,      bags_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 10,   decals_2 = 1,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
    uniform_romeo_2 = {
        male = {
            tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,      arms_2 = 0,
			pants_1 = 99,   pants_2 = 0,
            bproof_1 = 6,  bproof_2 = 1,
            shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 5,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			glasses_1 = 15,    glasses_2 = 0,
			mask_1 = 0,     mask_2 = 0,
			bags_1 = 51,      bags_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 10,   decals_2 = 1,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
    uniform_romeo_3 = {
        male = {
            tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,      arms_2 = 0,
			pants_1 = 99,   pants_2 = 0,
            bproof_1 = 6,  bproof_2 = 1,
            shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 5,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			glasses_1 = 15,    glasses_2 = 0,
			mask_1 = 0,     mask_2 = 0,
			bags_1 = 51,      bags_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 10,   decals_2 = 1,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
    uniform_romeo_4 = {
        male = {
            tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,      arms_2 = 0,
			pants_1 = 99,   pants_2 = 0,
            bproof_1 = 6,  bproof_2 = 1,
            shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 5,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			glasses_1 = 15,    glasses_2 = 0,
			mask_1 = 0,     mask_2 = 0,
			bags_1 = 51,      bags_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 10,   decals_2 = 1,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
    uniform_romeo_5 = {
        male = {
            tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,      arms_2 = 0,
			pants_1 = 99,   pants_2 = 0,
            bproof_1 = 6,  bproof_2 = 1,
            shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 5,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			glasses_1 = 15,    glasses_2 = 0,
			mask_1 = 0,     mask_2 = 0,
			bags_1 = 51,      bags_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 10,   decals_2 = 1,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
    uniform_romeo_6 = {
        male = {
            tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,      arms_2 = 0,
			pants_1 = 99,   pants_2 = 0,
            bproof_1 = 6,  bproof_2 = 1,
            shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 5,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			glasses_1 = 15,    glasses_2 = 0,
			mask_1 = 0,     mask_2 = 0,
			bags_1 = 51,      bags_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 10,   decals_2 = 1,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
    uniform_romeo_7 = {
        male = {
            tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,      arms_2 = 0,
			pants_1 = 99,   pants_2 = 0,
            bproof_1 = 6,  bproof_2 = 1,
            shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 5,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			glasses_1 = 15,    glasses_2 = 0,
			mask_1 = 0,     mask_2 = 0,
			bags_1 = 51,      bags_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 10,   decals_2 = 1,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
    uniform_romeo_8 = {
        male = {
            tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,      arms_2 = 0,
			pants_1 = 99,   pants_2 = 0,
            bproof_1 = 6,  bproof_2 = 1,
            shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 5,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			glasses_1 = 15,    glasses_2 = 0,
			mask_1 = 0,     mask_2 = 0,
			bags_1 = 51,      bags_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 10,   decals_2 = 1,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
    uniform_romeo_9 = {
        male = {
            tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,      arms_2 = 0,
			pants_1 = 99,   pants_2 = 0,
            bproof_1 = 6,  bproof_2 = 1,
            shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 5,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			glasses_1 = 15,    glasses_2 = 0,
			mask_1 = 0,     mask_2 = 0,
			bags_1 = 51,      bags_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 10,   decals_2 = 1,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
    uniform_romeo_10 = {
        male = {
            tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,      arms_2 = 0,
			pants_1 = 99,   pants_2 = 0,
            bproof_1 = 6,  bproof_2 = 1,
            shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 5,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			glasses_1 = 15,    glasses_2 = 0,
			mask_1 = 0,     mask_2 = 0,
			bags_1 = 51,      bags_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 10,   decals_2 = 1,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
	uniform_romeo_11 = {
        male = {
            tshirt_1 = 44,  tshirt_2 = 0,
			torso_1 = 14,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 53,      arms_2 = 0,
			pants_1 = 99,   pants_2 = 0,
            bproof_1 = 6,  bproof_2 = 1,
            shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 5,  helmet_2 = 0,
			chain_1 = 1,    chain_2 = 0,
			glasses_1 = 15,    glasses_2 = 0,
			mask_1 = 0,     mask_2 = 0,
			bags_1 = 51,      bags_2 = 0
        },
        female = {
            tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 10,   decals_2 = 1,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
        }
    },
    uniform_blue_long_0 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 25,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_long_1 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 25,   torso_2 = 1,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_long_2 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 25,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_long_3 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 3,
			torso_1 = 25,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_long_4 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 4,
			torso_1 = 25,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_long_5 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 25,   torso_2 = 5,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_long_6 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 25,   torso_2 = 6,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_long_7 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 25,   torso_2 = 7,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_long_8 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 25,   torso_2 = 8,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_long_9 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 25,   torso_2 = 9,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_long_10 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 25,   torso_2 = 9,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	uniform_blue_long_11 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 25,   torso_2 = 9,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

    uniform_strik_1 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 1,
			torso_1 = 10,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_strik_2 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 10,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_strik_3 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 10,   torso_2 = 3,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_strik_4 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 10,   torso_2 = 4,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_strik_5 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 10,   torso_2 = 5,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_strik_6 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 10,   torso_2 = 6,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_strik_7 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 10,   torso_2 = 7,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 8,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_strik_8 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 10,   torso_2 = 8,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_strik_9 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 10,   torso_2 = 9,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 10,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_strik_10 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 10,   torso_2 = 10,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	uniform_strik_11 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 10,   torso_2 = 11,
			decals_1 = 0,   decals_2 = 0,
			arms = 33,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	uniform_blue_short_0 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 26,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 37,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_short_1 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 26,   torso_2 = 1,
			decals_1 = 0,   decals_2 = 0,
			arms = 37,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 143,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_short_2 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 26,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 37,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 143,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_short_3 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 26,   torso_2 = 3,
			decals_1 = 0,   decals_2 = 0,
			arms = 37,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 143,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_short_4 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 4,
			torso_1 = 26,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 37,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_short_5 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 26,   torso_2 = 5,
			decals_1 = 0,   decals_2 = 0,
			arms = 37,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_short_6 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 26,   torso_2 = 6,
			decals_1 = 0,   decals_2 = 0,
			arms = 37,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_short_7 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 26,   torso_2 = 7,
			decals_1 = 0,   decals_2 = 0,
			arms = 37,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 11,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_short_8 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 26,   torso_2 = 8,
			decals_1 = 0,   decals_2 = 0,
			arms = 37,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_short_9 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 26,   torso_2 = 9,
			decals_1 = 0,   decals_2 = 0,
			arms = 37,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
    uniform_blue_short_10 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 26,   torso_2 = 10,
			decals_1 = 0,   decals_2 = 0,
			arms = 37,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 8,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	uniform_blue_short_11 = {
		male = {
			tshirt_1 = 40,  tshirt_2 = 0,
			torso_1 = 26,   torso_2 = 11,
			decals_1 = 0,   decals_2 = 0,
			arms = 37,      arms_2 = 0,
			pants_1 = 87,   pants_2 = 1,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 8,    chain_2 = 0,
			mask_1 = 121,     mask_2 = 0,
			bags_1 = 0,      bags_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,      arms_2 = 0,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	bullet_wear_0 = {
		male = {
			bproof_1 = 2,  bproof_2 = 0
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},
	bullet_wear_1 = {
		male = {
			bproof_1 = 2,  bproof_2 = 0
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},
	bullet_wear_2 = {
		male = {
			bproof_1 = 2,  bproof_2 = 0
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},
	bullet_wear_3 = {
		male = {
			bproof_1 = 2,  bproof_2 = 0
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},
	bullet_wear_4 = {
		male = {
			bproof_1 = 2,  bproof_2 = 0
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},
	bullet_wear_5 = {
		male = {
			bproof_1 = 2,  bproof_2 = 0
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},
	bullet_wear_6 = {
		male = {
			bproof_1 = 2,  bproof_2 = 0
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},
	bullet_wear_7 = {
		male = {
			bproof_1 = 2,  bproof_2 = 0
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},
	bullet_wear_8 = {
		male = {
			bproof_1 = 2,  bproof_2 = 0
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},
	bullet_wear_9 = {
		male = {
			bproof_1 = 2,  bproof_2 = 0
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},
	bullet_wear_10 = {
		male = {
			bproof_1 = 2,  bproof_2 = 0
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},
	bullet_wear_11 = {
		male = {
			bproof_1 = 2,  bproof_2 = 0
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},	

	gilet_wear = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}
