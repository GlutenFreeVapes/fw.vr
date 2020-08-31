//--- Respawn in vehicle
// respawns players in a certain type of vehicle
[player,{
    player remoteExec ['ten_fnc_moveInTruck',2];
    titleText ["Respawning", "BLACK", 2];





},"onRespawnUnit",true] call respawn_fnc_scriptAddUnit;

ten_fnc_moveInTruck = {
    params ['_unit'];

    private _vehicles = [];

    // get all transports
    private _nil = {
        if (toLower (typeOf _x) find 'fmtv' != -1) then {
            _vehicles pushBack _x;
        };
        false
    } count vehicles;

    // find a vehicle with an empty spot
};