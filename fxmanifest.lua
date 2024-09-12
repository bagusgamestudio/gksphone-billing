fx_version "cerulean"
game "gta5"

title "GKSPHONE - APP Template"
description "APP Template GKSPHONE"
author "xenknight"

ui_page 'ui/index.html'

shared_script "@ox_lib/init.lua"
client_script "client/*.lua"
server_script "server/*.lua"

files {
    "ui/index.html",
    "ui/js/*.js",
    "ui/css/*.css"
}
