ESX = nil
ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('aduty:getGroup', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)

    cb(xPlayer.getGroup())

end)