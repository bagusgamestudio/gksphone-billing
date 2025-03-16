fx_version "cerulean"
game "gta5"
lua54 'yes'

title "GKSPHONE - APP Template"
description "APP Template GKSPHONE"
author "xenknight"

ui_page 'ui/index.html'

shared_script "@ox_lib/init.lua"
client_script "client/*.lua"
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/*.lua"
}
files {
    "ui/index.html",
    "ui/js/*.js",
    "ui/css/*.css"
}
