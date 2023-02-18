Config = {}

Config.Godmode = true -- godmode when the player is onduty | default: true

Config.useESX = true -- if you want to use esx notification | default: true

Config.Animation = true -- if you want to have a animation when you go/left the aduty | default: true

Config.Command = "aduty" -- command /aduty for go in duty | default: "aduty"

Config.Keybinds = "E" -- Press a key to be in Duty | Not function!!!

Config.Locale = 'en'

Config.Uniform = true -- default: true

-- This work if Config.Uniform = true

Config.Uniform_Male = {
    arms = 8,
    pants_1 = 25, pants_2 = 0,
    shoes_1 = 25, shoes_2 = 0,
    tshirt_1 = 27, tshirt_2 = 0,
    torso_1 = 130, torso_2 = 0,
    mask_1 = 0, mask_2 = 0,
    hat_1 = 12, hat_2 = 0,
}

Config.Uniform_Female = {
    arms = 30,
    pants_1 = 126, pants_2 = 0,
    shoes_1 = 24, shoes_2 = 0,
    tshirt_1 = 38, tshirt_2 = 0,
    torso_1 = 102, torso_2 = 0,
}

Translation = {
    ['de'] = {
        ['admin_on'] = 'Du bist nun im ~r~Administrator~s~ Díenst!',
        ['admin_off'] = 'Du bist nun nicht mehr im ~r~Administrator~s~ Díenst!',
        ['permission'] = '~r~Du bist kein Teamler!',
        ['not_induty'] = '~r~Du bist nicht im Aduty system',
        ['suc_telport'] = '~r~Du hast dich zum Wegpunkt teleportiert!',
    },
    ['en'] = {
        ['admin_on'] = 'You are now on ~r~Duty~s~!',
        ['admin_off'] = 'You are now out of ~r~Duty~s~!',
        ['permission'] = '~r~You are not a member from the Server-Team',
        ['not_induty'] = '~r~Your are not in Duty!',
        ['suc_telport'] = '~y~You been Teleport',
    },
}