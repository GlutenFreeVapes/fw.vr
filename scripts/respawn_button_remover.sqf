//--- Respawn button remover
// Removes the respawn button when the player dies, to stop bugging or respawning insntaly
// credits: GlutenFreeVapes
ten_fnc_respawnButtonRemove = {
    waitUntil {
        if (!((findDisplay 49) isEqualTo displayNull)) then {
            private _ctrl = (findDisplay 49) displayCtrl 1010;
            _ctrl ctrlEnable false;
        };
        (false)
    };
};
ten_fnc_onRespawn = {
    if (!isNull (missionNamespace getVariable ['ten_handle_respawnButtonRemover',scriptNull])) then {
        terminate ten_handle_respawnButtonRemover;
    };
    ten_handle_respawnButtonRemover = [] spawn ten_fnc_respawnButtonRemove;
};
ten_fnc_onRespawnUnit = {
    if (!isNull (missionNamespace getVariable ['ten_handle_respawnButtonRemover',scriptNull])) then {
        terminate ten_handle_respawnButtonRemover;
    };
};
if (isServer && ("respawn" in mission_plugins)) then {
    [[""],{call ten_fnc_onRespawnUnit},"onRespawnUnit",true] call respawn_fnc_scriptAdd;
};
if (isServer && ("respawn" in mission_plugins)) then {
    [[""],{call ten_fnc_onRespawn},"onRespawn",true] call respawn_fnc_scriptAdd;
};
if (isServer && ("respawn" in mission_plugins)) then {
    [[""],{call ten_fnc_onRespawn},"onKilled",true] call respawn_fnc_scriptAdd;
};