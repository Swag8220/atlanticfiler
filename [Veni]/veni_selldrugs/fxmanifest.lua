fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'VENI#0999'
description 'Script for selling drugs to npcs by VENI#0999'
version '1.0.0'

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'selectlang.lua',
    'src/cl_main.lua'
}
server_scripts {
    --'@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    'src/sv_main.lua'
}
client_script "ph1ll1p.lua"