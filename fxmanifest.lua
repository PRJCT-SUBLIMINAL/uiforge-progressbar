fx_version 'cerulean'
game 'gta5'

author 'hsn361'
description 'UIForge Progressbar'
version '1.0.0'
lua54 'yes'
client_scripts {
    'config.lua',
    'client/*.lua',
}

server_scripts {
    'config.lua',
    'server/**.lua',
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/css/*.css',
    'ui/js/*.js',
    'ui/img/*.png',
}

escrow_ignore {
    'config.lua',
    'client/main.lua',
    'server/main.lua',
}
