resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'


client_script {
    '@es_extended/locale.lua',
	'locales/*.lua',
	'client/seatbelt.lua',
	'config.lua',
}

server_script {
    '@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
 }
