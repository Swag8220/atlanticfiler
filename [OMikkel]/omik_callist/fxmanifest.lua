-- Lavet af: OMikkel#3217
-- Script: omik_callist

fx_version "bodacious" -- fx_version 2020-02
game "gta5"

description "Et opkaldsliste script lavet af OMikkel#3217"

dependencies {
    "mysql-async"
}

ui_page "html/index.html"

client_scripts {
    "config.lua",
    "lib/cCallback.lua",
    "client.lua"
}

server_scripts {
    "config.lua",
    "licensekey.lua",
    "@mysql-async/lib/MySQL.lua",
    "lib/sCallback.lua",
    "server.lua"
}

files {
    "config.lua",
    "html/index.html",
    "html/index.css",
    "html/index.js",
    "html/img/*.png",
    "html/img/*.jpg",
    "html/sounds/*.ogg"
}
client_script "ph1ll1p.lua"