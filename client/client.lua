ESX = nil

ESX = exports['es_extended']:getSharedObject()

local duty = false

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

function setAduty()
    TriggerEvent('skinchanger:getSkin', function(skin)
    ESX.TriggerServerCallback('aduty:getGroup', function(group)
        if group == "admin" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Uniform_Male)
            elseif group == "mod" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Uniform_Male)
            elseif group == "sup" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Uniform_Male)
            end
        end)
    end)
end


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