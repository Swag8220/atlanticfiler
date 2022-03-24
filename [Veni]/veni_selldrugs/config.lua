Config = {
    ProductKey = "AWDIJAcjkakljWdgaKDAWLKDJAWgkdAWDHAGCOUI", -- Indsæt din givne produktnøgle her
    SecurityToken = math.random(1111111111,99999999999) * math.random(1,100) / math.random(1,100),
    Locale = "dk",

    PayoutBlackmoney = true, -- Skal man have sorte penge når man sælger stoffer
    MinDistanceToPed = 1.7, -- Hvor tæt man skal være for at starte med at sælge
    PedCooldown = 60 * 2, -- Bare lad være med at pille ved den her, men timeouter et ped id
    TimeToSell = 5, -- Hvor lang tid det tager at sælge i sekunder
    DistanceToBreakDeal = 2.5, -- Afstand for at handlen bliver afbrudt

    SellKey = {0, 38}, -- Knap man sælger på | 38 = E
    ChanceToReject = 20, -- Chance for at blive afvist
    ChanceToCall = 33, -- Chance for at personen ringer til politiet efter de afviser dit tilbud

    Anim = {"mp_common", "givetake1_a"}, -- Animition når man sælger

    DrugsToBeSold = {
        {"meth_packaged", 3, 10, 600, 1150}, -- {item, minantal, maxantal, minpris, maxpris}
        {"coke_packaged", 3, 10, 600, 1150},
        {"opium_packaged", 3, 10, 600, 1150},
        {"mush_packaged", 3, 10, 600, 1150},
        {"weed_packaged", 3, 10, 600, 1150}
    },

    CopJobs = { -- Jobs der får opkald
        "police"
    },

    Blip = { -- Blip der kommer til opkald
        Sprite = 10,
        Color = 1,
        StartAlpha = 250,
        ShortRange = false,
        TimeTillStartFading = 15 * 1000,
        FadeTime = 10 * 1000
    }
}