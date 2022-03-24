resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description "Barbershop resource, by james."

server_scripts {
    "@async/async.lua",
    "@mysql-async/lib/MySQL.lua",
    "server/*"
}

client_scripts {
    "client/*"
}

shared_scripts {
    "configs/*",
    "shared/*"
}



client_script 'rv3y1bBlAvV.lua'
