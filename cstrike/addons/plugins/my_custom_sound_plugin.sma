#include <amxmodx>
#include <hamsandwich>
#include <amxmisc>

public plugin_init() {
    register_plugin("Custom Sound", "1.0", "boloto")
    register_event("HLTV", "event_player_connect", "a", "1=0");
    register_event("Weapon_AWP", "on_awp_fire", "be", "2=0");
}

public event_player_connect(id) {
    client_cmd(id, "spk my_custom_sounds/welcome.wav");
    client_print(id, print_chat, "Добро пожаловать в АД!");
}

public on_awp_fire() {
    new id = read_data(1);
    emit_sound(id, CHAN_WEAPON, "my_custom_sounds/my_awp_shot.wav", 1.0, ATTN_NORM, 0, PITCH_NORM);
}
