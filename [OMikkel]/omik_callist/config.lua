Config = {}

Config.hotkey = {true, 344} -- F7 {Hotkey aktiveret true/false, hotkeyknap https://docs.fivem.net/docs/game-references/controls/}

Config.newcallnotify = true -- Skal folk modtage en notify når et nyt call bliver addet
Config.gpsnotify = true -- Skal folk modtage en notify når i trykker sæt gps
Config.takenotify = true -- Skal folk modtage en notify når i trykker tag opkald

Config.newcall = { -- pNotify til når en betjent modtager et nyt opkald
    text = "Der er kommet et nyt opkald - Åben menuen for at se",
    type = "success",
    queue = "global",
    timeout = 4000,
    layout = "centerLeft"
}
Config.setgpstext = { -- Den tekst som afsenderen til opkaldet modtager når der bliver sat gps til opkaldet
    text = "En gps blev sat til dit opkald",
    type = "success",
    queue = "global",
    timeout = 4000,
    layout = "centerLeft"
}
Config.taketext = { -- Den tekst som afsenderen til opkaldet modtager når opkaldet bliver taget
    text = "Dit opkald blev taget - Hjælpen er på vej",
    type = "success",
    queue = "global",
    timeout = 4000,
    layout = "centerLeft"
}

Config.timezone = 0 -- Config, du skal indsætte hvor mange timer du er foran eller bag UTC

Config.jobs = {
    "police",
    "ambulance",
    "mechanic",
    "taxi",
    "advokat",

}

return Config
