fx_version 'bodacious'
game 'gta5'
author 'MausCD'
description 'MCD Duty'
version '1.0.0'

shared_script '@es_extended/imports.lua'
shared_script '@mcd_lib/import.lua'

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client.lua',
}

server_scripts {
	'@es_extended/locale.lua',
	"@mysql-async/lib/MySQL.lua",
	'locales/*.lua',
	'config.lua',
	'server.lua'
}

dependencies {
	'mcd_lib',
}