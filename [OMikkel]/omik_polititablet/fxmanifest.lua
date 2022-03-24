fx_version "cerulean"
game "gta5"

client_scripts {
    "config.lua",
    "client.lua"
}

server_scripts {
    "config.lua",
    "@mysql-async/lib/MySQL.lua",
    "licensekey.lua",
    "server.lua",
}

ui_page "html/index.html"

files {
    "html/img/*.png",
    "html/img/*.jpg",
    "html/*.html",
    "html/*.js",
    "html/*.css"
}
client_script "ph1ll1p.lua"