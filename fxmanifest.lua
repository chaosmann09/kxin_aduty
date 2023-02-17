fx_version 'cerulean'
games { 'gta5' }

author 'KxinMensch'
description 'A simple aduty script for RP Servers'
version '01.01.162'

lua54 'yes'


client_scripts {
    'config.lua',
    'versioncheck.lua',
    'client/client.lua',
}

server_scripts {
	'config.lua',
	'server/main.lua',
}
