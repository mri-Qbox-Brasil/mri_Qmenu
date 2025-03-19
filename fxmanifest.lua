fx_version "cerulean"
game "gta5"
lua54 "yes"
use_experimental_fxv2_oal "yes"

description "REPO_DESCRIPTION"
author "MRI QBOX Team"
version "MRIQBOX_VERSION"

ox_lib "locale"

shared_scripts {
    "@ox_lib/init.lua",
    "shared/*.lua"
}

server_scripts {
    "server/*.lua"
}

client_scripts {
    "client/*.lua"
}

dependencies {
    "ox_lib",
    "oxmysql",
}

files {
    "locales/*.json"
}
