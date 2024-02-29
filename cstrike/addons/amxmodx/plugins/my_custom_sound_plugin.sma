#include <amxmodx>
#include <amxmisc>
#include <hamsandwich>

new g_Enable

new const PLUGIN[] = "Custom Sounds Plugin",
            VERSION[] = "1.0",
            AUTHOR[] = "nivolk";

new const g_WelcomeSound[] = "my_custom_sounds/welcome.wav";
new const g_NewRoundSound[] = "my_custom_sounds/newRound.wav";
new const g_RoundStartSound[] = "my_custom_sounds/roundStart.wav";
new const g_ChangeMapSound[] = "my_custom_sounds/changeMap.wav";
new const g_DropBombSound[] = "my_custom_sounds/dropBomb.wav";
new const g_PlantedBombSound[] = "my_custom_sounds/plantedBomb.wav";
new const g_GranadeKillSound[] = "my_custom_sounds/granadeKill.wav";
new const g_KillSound[] = "my_custom_sounds/kill.wav";

public plugin_init() {
    register_plugin(PLUGIN, VERSION, AUTHOR);

    g_Enable = register_cvar("gk_enable", "1")

    // новый раунд
    register_event("HLTV", "NewRound", "a", "1=0", "2=0")

    // старт раунда
    register_logevent("StartRound", 2, "1=Round_Start")

    // смена карты
    register_event("30", "ChangeMap", "a")

    // потеря бомбы
    register_event("BombDrop","DropBomb","abe")

    // убийство
    register_event("DeathMsg", "playerDeath", "a", "1>0")
}

public plugin_precache() {
    precache_sound(g_WelcomeSound);
    precache_sound(g_NewRoundSound);
    precache_sound(g_RoundStartSound);
    precache_sound(g_ChangeMapSound);
    precache_sound(g_DropBombSound);
    precache_sound(g_PlantedBombSound);
    precache_sound(g_GranadeKillSound);
    precache_sound(g_KillSound);
}

public client_putinserver(id) {
    client_cmd(id, "spk %s", g_WelcomeSound);
    client_print(id, print_chat, "Добро пожаловать в АД!");
}

public NewRound() {
    for (new i = 1; i <= get_maxplayers(); i++) {
        if (is_user_connected(i)) {
            client_cmd(i, "spk %s", g_NewRoundSound);
        }
    }
}

public StartRound() {
    for (new i = 1; i <= get_maxplayers(); i++) {
        if (is_user_connected(i)) {
            client_cmd(i, "spk %s", g_RoundStartSound);
        }
    }
}

public ChangeMap() {
    for (new i = 1; i <= get_maxplayers(); i++) {
        if (is_user_connected(i)) {
            client_cmd(i, "spk %s", g_ChangeMapSound);
        }
    }
}

public DropBomb() {
    new type = read_data(4)

    if(type == 0){
        // тут уходит в цикл надо исправить
        // client_print(0,print_chat,"Bomb drop")
        // client_cmd(i, "spk %s", g_DropBombSound);
    }else if(type == 1){
        for (new i = 1; i <= get_maxplayers(); i++) {
            if (is_user_connected(i)) {
                client_print(0,print_chat,"Bomb planted")
                client_cmd(i, "spk %s", g_PlantedBombSound);
            }
        }
    }
}

public playerDeath()
{
        new killer = read_data(1)
        new victim = read_data(2)
        new weapon[8]
        read_data(4, weapon, 7)
 
        if (get_pcvar_num(g_Enable) && killer != victim && equal(weapon, "grenade"))
        {
            client_cmd(0, "spk %s", g_GranadeKillSound)
        }
        else{
            client_cmd(0, "spk %s", g_KillSound)
        }
}