Config = {
    ProductKey = "AWJDBAJHKCBAWIHDAWDADHUAWKDHAWADWWA", -- Indsæt din givne produktnøgle her.
    SecurityToken = math.random(100000,999999) * math.random(1, 100) / math.random(1, 100), -- Lad vær med at pille her, hvis du ikke ved hvad du laver.

    Blip = { -- Indstillinger for cirkelen hvor man farmer
        Type = 25,
        X = 5.0,
        Y = 5.0,
        Z = 0.5,
        R = 100,
        G = 204,
        B = 100,
        A = 230,
        DrawDistance = 20.0,
        InteractDistance = 5.1
    },
    
    Farms = {
        -- Kokainfarm
        {
            startlabel = "Tryk ~INPUT_CONTEXT~ for at høste kokainblade",
            stopLabel = "Tryk ~INPUT_CONTEXT~ for at stoppe høsten af kokainblade",
            coords = vector3(-514.11328125,2505.4558105469,53.664514160156),
            timeToMake = 4,

            input = {

            },

            output = {
                {"coke", 1}
            }
        },
        -- Kokainomdan
        {
            startlabel = "Tryk ~INPUT_CONTEXT~ for at omdanne kokainblade",
            stopLabel = "Tryk ~INPUT_CONTEXT~ for at stoppe omdanningen af kokainblade",
            coords = vector3(1343.5832519531,4385.482421875,43.443738555908),
            timeToMake = 4,

            input = {
                {"coke", 2}
            },

            output = {
                {"coke_pooch", 1}
            }
        },
        -- Kokain pakning
        {
            startlabel = "Tryk ~INPUT_CONTEXT~ for at pakke kokain",
            stopLabel = "Tryk ~INPUT_CONTEXT~ for at stoppe med at pakke kokain",
            coords = vector3(900.13513183594,3564.6672363281,32.897443389893),
            timeToMake = 4,

            input = {
                {"coke_pooch", 1},
                {"pose", 1}
            },

            output = {
                {"coke_packaged", 1}
            }
        },

        ----------------

        -- Methfarm
        {
            startlabel = "Tryk ~INPUT_CONTEXT~ for at lave rå metamfetamin",
            stopLabel = "Tryk ~INPUT_CONTEXT~ for at stoppe med at lave rå metamfetamin",
            coords = vector3(31.395713806152,3671.779296875,39.540586090088),
            timeToMake = 4,

            input = {

            },

            output = {
                {"meth", 1}
            }
        },
        -- Methomdan - Route 68 mlo .. skal fixes
        {
            startlabel = "Tryk ~INPUT_CONTEXT~ for at omdanne rå metamfetamin",
            stopLabel = "Tryk ~INPUT_CONTEXT~ for at stoppe omdanningen af rå metamfetamin",
            coords = vector3(1120.4624023438,-1231.7142617188,16.418586730938),
            timeToMake = 4,

            input = {
                {"meth", 2}
            },

            output = {
                {"meth_pooch", 1}
            }
        },
        -- Meth pakning
        {
            startlabel = "Tryk ~INPUT_CONTEXT~ for at pakke metamfetamin",
            stopLabel = "Tryk ~INPUT_CONTEXT~ for at stoppe med at pakke metamfetamin",
            coords = vector3(2476.8994140625,3761.90625,41.001958465576),
            timeToMake = 4,

            input = {
                {"meth_pooch", 1},
                {"pose", 1}
            },

            output = {
                {"meth_packaged", 1}
            }
        },

        -------------

        -- Opiumfarm
        {
            startlabel = "Tryk ~INPUT_CONTEXT~ for at plukke opiumvalmue",
            stopLabel = "Tryk ~INPUT_CONTEXT~ for at stoppe plukningen af opiumvalmue",
            coords = vector3(1513.8239746094,-2612.3706054688,46.791318511963),
            timeToMake = 4,

            input = {

            },

            output = {
                {"opium", 1}
            }
        },
        -- opiumomdan - Route 68 mlo
        {
            startlabel = "Tryk ~INPUT_CONTEXT~ for at omdanne opiumvalmue",
            stopLabel = "Tryk ~INPUT_CONTEXT~ for at stoppe omdanningen af opiumvalmue",
            coords = vector3(1389.1998291016,3604.3479003906,38.041890716553),
            timeToMake = 4,

            input = {
                {"opium", 2}
            },

            output = {
                {"opium_pooch", 1}
            }
        },
        -- opium pakning
        {
            startlabel = "Tryk ~INPUT_CONTEXT~ for at sætte opium i sprøjter",
            stopLabel = "Tryk ~INPUT_CONTEXT~ for at stoppe med at sætte opium i sprøjter",
            coords = vector3(2477.1625976562,3441.16796875,49.064740753174),
            timeToMake = 4,

            input = {
                {"opium_pooch", 1},
                {"kanyle", 1}
            },

            output = {
                {"opium_packaged", 1}
            }
        },

        -------------

        -- Mushfarm
        {
            startlabel = "Tryk ~INPUT_CONTEXT~ for at plukke svampe",
            stopLabel = "Tryk ~INPUT_CONTEXT~ for at stoppe plukningen af svampe",
            coords = vector3(-284.0041809082,2219.9973144531,130.03658447266),
            timeToMake = 4,

            input = {

            },

            output = {
                {"mush", 1}
            }
        },
        -- mushomdan - Route 68 mlo
        {
            startlabel = "Tryk ~INPUT_CONTEXT~ for at koge svampe",
            stopLabel = "Tryk ~INPUT_CONTEXT~ for at stoppe kogningen af svampe",
            coords = vector3(2434.6274414062,4968.5375976562,41.447553253174),
            timeToMake = 4,

            input = {
                {"mush", 2}
            },

            output = {
                {"mush_pooch", 1}
            }
        },
        -- mush pakning
        {
            startlabel = "Tryk ~INPUT_CONTEXT~ for at pakke svampe",
            stopLabel = "Tryk ~INPUT_CONTEXT~ for at stoppe med at pakke svampe",
            coords = vector3(2194.6889648438,5595.9418945312,52.863408660889),
            timeToMake = 4,

            input = {
                {"mush_pooch", 1},
                {"pose", 1}
            },

            output = {
                {"mush_packaged", 1}
            }
        }
    },
    
    BlacklistedJobs = { -- Jobs der ikke kan lave stoffer
        "ambulance",
        "cardealer",
        "fisherman",
        "fueler",
        "lawyer",
        "lumberjack",
        "mcdealer",
        "mecano",
        "miner",
        "police",
        "realestateagent",
        "reporter",
        "slaughterer",
        "tailor",
        "taxi"
    }
}