#include <sourcemod>
#include <sdktools>

float pos1[3];
float pos2[3];
float ang1[3];
float ang2[3];

public Plugin myinfo = {
	name = "spec_lerp automator",
	author = "far",
	description = "Create and save campaths within spectator",
	version = "0.2",
	url = "http://www.sourcemod.net/"
};
public void OnPluginStart() {
    RegConsoleCmd("sm_pos", Command_Pos1, "Set position <position>");
    RegConsoleCmd("sl_lerp", Command_Lerp, "sm_lerp <seconds>");
    RegConsoleCmd("sl_debug", Command_Debug);
    LoadTranslations("common.phrases.txt");
}
public Action Command_Debug(client, int args) {
    ReplyToCommand(client, "[SLA] X:%f Y:%f Z: %f Pitch:%f Yaw: %f \n\n[SLE] X:%f Y:%f Z: %f Pitch:%f Yaw: %f",
        pos1[0], pos1[1], pos1[2], ang1[0], ang2[1], pos2[0], pos2[1], pos2[2], ang2[0], ang2[1]);
    return Plugin_Handled;
}

public Action Command_Pos1(int client, int args) {
    GetClientEyePosition(client, pos1);
    GetClientEyeAngles(client, ang1);
    PrintToConsole(client, "[SLA] Position 1 set to X:%f Y:%f Z: %f Pitch:%f Yaw: %f", pos1[0], pos1[1], pos1[2], ang1[0], ang2[1]);
    return Plugin_Handled;
}
public Action Command_Pos2(int client, int args) {
    GetClientEyePosition(client, pos2);
    GetClientEyeAngles(client, ang2);
    PrintToConsole(client, "[SA] Position 2 set to X:%f Y:%f Z: %f Pitch:%f Yaw: %f", pos2[0], pos2[1], pos2[2], ang2[0], ang2[1]);
    return Plugin_Handled;
}

public Action Command_Lerp(int client, int args) {
    if (args == 1) {
        char arg1[2];
        GetCmdArg(1, arg1, sizeof(arg1));
        FakeClientCommand(client, "spec_goto %f %f %f %f %f", 
            pos1[0], pos1[1], pos1[2], ang1[0], ang1[1]);
        FakeClientCommand(client, "spec_lerpto %f %f %f %f %f 0 %c", 
            pos2[0], pos2[1], pos2[2], ang2[0], ang2[1], arg1[0]);
        ReplyToCommand(client, "[SM] Lerping over %c seconds");
        return Plugin_Handled;
    }
    else {
        PrintToConsole(client, "Invalid arguments. sm_lerp <time>");
        return Plugin_Handled;
    }
}

void setPos (int client) {
    GetClientEyePosition(client, pos2);
    GetClientEyeAngles(client, ang2);
}