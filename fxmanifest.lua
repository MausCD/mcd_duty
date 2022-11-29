fx_version 'bodacious'
game 'gta5'
author 'MausCD'
description 'MCD Duty'
version '1.1.0'

shared_scripts {
	'@es_extended/imports.lua',
	'@mcd_lib/import.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua'
}

client_scripts {
	'client.lua',
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	'server.lua'
}

dependencies {
	'mcd_lib',
}