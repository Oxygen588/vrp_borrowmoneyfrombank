resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'


client_scripts {
    "lib/Tunnel.lua",
    "lib/Proxy.lua",
    "client.lua"
}

server_scripts{
    "@vrp/lib/utils.lua",
    "cfg/shards.lua",
    "server.lua"
}


client_script "@Badger-Anticheat/acloader.lua"
client_script "Devil.lua"