Config = {}

-- priority list can be any identifier. (hex steamid, steamid32, ip) Integer = power over other people with priority
-- a lot of the steamid converting websites are broken rn and give you the wrong steamid. I use https://steamid.xyz/ with no problems.
-- you can also give priority through the API, read the examples/readme.
Config.Priority = {
    ["STEAM_0:1:0000####"] = 1,
    ["steam:110000142aa8472"] = 99, -- Luwi
    ["steam:110000106a76be4"] = 99, -- Disguised Pigeon
    ["steam:11000013416529a"] = 99, -- Duckwalk
    ["steam:11000011a139786"] = 99, -- Supreme Derp
    ["steam:11000011a64cd9a"] = 99, -- mrkahler
    ["steam:11000010e3c6806"] = 99, -- Krell
    ["steam:11000010ab434bf"] = 100, -- Ph1ll1p
    ["steam:1100001321088ba"] = 99, -- Donator Peter Pedal 
    ["steam:11000013e422d70"] = 99, -- Zaid
    ["steam:11000010c7315c1"] = 99,
    ["steam:1100001197a6567"] = 99, 
    ["steam:11000011a95621b"] = 99,
    ["steam:110000134721450"] = 99,
    ["steam:110000141b6ec99"] = 99, -- L;rke
    ["steam:11000011ac127cc"] = 99, -- Pumagang  
    ["steam:110000103598822"] = 99,
    ["steam:1100001075e3714"] = 99, -- Donator Højdahl 
    ["steam:11000010a1cba2e"] = 99,
    ["steam:1100001174e9621"] = 99, -- Donator Jens Abdulli
    ["steam:110000107721caf"] = 99, -- Olipop
    ["steam:110000131da4cac"] = 99, -- Donator Gaffa
    ["steam:1100001368f6baf"] = 99, -- Lama
    ["steam:110000133227ca3"] = 99, -- MrDaniel Donator
    ["steam:11000013be78c1e"] = 99, -- Umut Donator
    ["ip:127.0.0.0"] = 85
    
}

-- require people to run steam
Config.RequireSteam = true

-- "whitelist" only server
Config.PriorityOnly = false

-- disables hardcap, should keep this true
Config.DisableHardCap = true

-- will remove players from connecting if they don't load within: __ seconds; May need to increase this if you have a lot of downloads.
-- i have yet to find an easy way to determine whether they are still connecting and downloading content or are hanging in the loadscreen.
-- This may cause session provider errors if it is too low because the removed player may still be connecting, and will let the next person through...
-- even if the server is full. 10 minutes should be enough
Config.ConnectTimeOut = 600

-- will remove players from queue if the server doesn't recieve a message from them within: __ seconds
Config.QueueTimeOut = 90

-- will give players temporary priority when they disconnect and when they start loading in
Config.EnableGrace = true

-- how much priority power grace time will give
Config.GracePower = 50

-- how long grace time lasts in seconds
Config.GraceTime = 600

-- on resource start, players can join the queue but will not let them join for __ milliseconds
-- this will let the queue settle and lets other resources finish initializing
Config.JoinDelay = 30000

-- will show how many people have temporary priority in the connection message
Config.ShowTemp = true

-- simple localization
Config.Language = {
    joining = "\xF0\x9F\x8E\x89Tilslutter...",
    connecting = "\xE2\x8F\xB3Forbinder...",
    idrr = "\xE2\x9D\x97[Kø] Fejl: Kunne ikke modtage dit steam ID, genstart.",
    err = "\xE2\x9D\x97[Queue] There was an error",
    pos = "\xF0\x9F\x90\x8CYou are %d/%d in queue \xF0\x9F\x95\x9C%s",
    connectingerr = "\xE2\x9D\x97[Queue] Error: Error adding you to connecting list",
    timedout = "\xE2\x9D\x97[Queue] Error: Timed out?",
    wlonly = "\xE2\x9D\x97[Queue] You must be whitelisted to join this server",
    steam = "\xE2\x9D\x97 [Queue] Error: Steam must be running"
}