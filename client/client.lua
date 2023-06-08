ESX = nil

ESX = exports['es_extended']:getSharedObject()

local duty = false
local playerBlips = {}

RegisterCommand(Config.Command ,function()
    local playerPed = PlayerPedId()
    ESX.TriggerServerCallback('aduty:getGroup', function(group)
        if group == "admin" or group == 'mod'then
            if duty == true then
                duty = false
                if Config.Godmode then
                    SetEntityInvincible(GetPlayerPed(-1), false)
                end
                if Config.useESX then
                    ESX.ShowNotification(Translation[Config.Locale]['admin_off'])
                else
                    -- here you can add your custom notification before you must Config.useESX = false to this work
                    notify('default notify')
                end
                cleanPlayer(playerPed)
                if Config.Animation then
                    PlayEmote()
                    Citizen.Wait(1000)
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                else
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                end
            else
                duty = true
                if Config.Godmode then
                    SetEntityInvincible(GetPlayerPed(-1), true)
                end
                if Config.Uniform then
                    if Config.Animation then
                        PlayEmote()
                        Citizen.Wait(700)
                        setAduty()
                    else
                        setAduty()
                    end
                end
                if Config.useESX then
                    ESX.ShowNotification(Translation[Config.Locale]['admin_on'])
                else
                    -- here you can add your custom notification before you must Config.useESX = false to this work
                    notify('default notify')
                end
            end
        else
            if Config.useESX then
                ESX.ShowNotification(Translation[Config.Locale]['permission'])
            else
                notify(Translation[Config.Locale]['permission'])
            end
        end
    end)
end)

RegisterCommand('tpm', function(source, args, raw)
    ESX.TriggerServerCallback('aduty:getGroup', function(group)
        if group == "admin" or group == "mod" or group == "sup" then
            if duty then
                local position = GetBlipInfoIdCoord(GetFirstBlipInfoId(8))
                if DoesBlipExist(GetFirstBlipInfoId(8)) then
                    unnusedBool, spawnZ = GetGroundZFor_3dCoord(position.x, position.y, 99999.0, 1);
                    SetEntityCoords(PlayerPedId(), position.x, position.y, spawnZ+ 0.1);
                end
            else
                if Config.useESX then
                    ESX.ShowNotification(Translation[Config.Locale]['not_induty'])
                else
                    notify(Translation[Config.Locale]['not_induty'])
                end
            end
        end
    end)
end)

function setAduty()
    TriggerEvent('skinchanger:getSkin', function(skin)
    ESX.TriggerServerCallback('aduty:getGroup', function(group)
        if group == "admin" then
            if skin.sex == 0 then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Uniform_Male)
            elseif skin.sex == 1 then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Uniform_Female)
            end
            elseif group == "mod" then
                if skin.sex == 0 then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Uniform_Male)
                elseif skin.sex == 1 then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Uniform_Female)
                end
            elseif group == "sup" then
                if skin.sex == 0 then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Uniform_Male)
                elseif skin.sex == 1 then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Uniform_Female)
                end
            end
        end)
    end)
end

CreateThread(function()
    while true do
        
        if duty then
            -- Schleife durch alle Spieler
            for _, player in ipairs(ESX.Game.GetPlayers()) do
                -- Hole die ID und den Steamnamen des Spielers
                local playerID = GetPlayerServerId(player)
                local playerName = GetPlayerName(player)
                
                local playerCoords = GetEntityCoords(GetPlayerPed(player))

                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), x, y, z, true)
                
                -- Text über dem Kopf des Spielers rendern
                if distance <= 50 then
                    local onScreen, screenX, screenY = World3dToScreen2d(playerCoords .x, playerCoords .y, playerCoords .z + 1.0)
                    if onScreen then
                        SetTextScale(0.35, 0.35)
                        SetTextFont(4)
                        SetTextProportional(1)
                        SetTextColour(255, 255, 255, 255)
                        SetTextEntry("STRING")
                        SetTextCentre(1)
                        AddTextComponentString("[" .. playerID .. "]" .. playerName)
                        DrawText(screenX, screenY)
                    end
                end
            end
        else
            Wait(500)
        end
    end
end)

CreateThread(function()
    while true do
        if duty then
            for _, player in ipairs(ESX.Game.GetPlayers()) do
                if not playerBlips[player] then
                    local blip = AddBlipForEntity(GetPlayerPed(player))
                    

                    SetBlipSprite(blip, 1) -- Blip-Sprite
                    SetBlipColour(blip, 2) -- Blip-Farbe
                    SetBlipScale(blip, 0.8) -- Blip-Größe
                    
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Steamname: " .. GetPlayerName(player))
                    EndTextCommandSetBlipName(blip)
                    
                    playerBlips[player] = blip
                else
                    SetBlipCoords(playerBlips[player], GetEntityCoords(GetPlayerPed(player)))
                end
            end
        end
        
        Wait(0)
    end
end)

function cleanPlayer(playerPed)
    SetPedArmour(playerPed, 0)
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    ClearPedLastWeaponDamage(playerPed)
    ResetPedMovementClipset(playerPed, 0)
end

function PlayEmote()
    while not HasAnimDictLoaded("clothingtie") do RequestAnimDict("clothingtie") Wait(100) end
    TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_negative_a", 3.0,3.0,1200, 51, 0, false, false, false)
end

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true,false)
end
