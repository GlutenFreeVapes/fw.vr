//--- zoom map at the start of the game
// this allows the positioning or randomization of the map to avoid players locating their position in the beginning of the game (map usually centers to player position)
// credits: GlutenFreeVapes
[] spawn {
    if (!hasInterface) exitWith {};
    //[11977.9,18202.5,0]
    for '_i' from 0 to 1 do {
        waitUntil {

            private _mapControl = (findDisplay getNumber (configFile >> "RscDisplayMainMap" >> "idd")) displayCtrl (getNumber (configfile >> "RscDisplayMainMap" >> "controlsBackground" >> "CA_Map" >> "idc"));

            (visibleMap || time < 1)
        };
        if (time < 1) then {
            {
                _x ctrlmapAnimAdd [0, ((2000/worldSize)/safeZoneW), [11977.9,18202.5,0]];
                ctrlmapAnimCommit _x;
            } forEach (allControls findDisplay 52);
        };
        [[1000,1000],[11977.9,18202.5,0],0] call BIS_fnc_zoomOnArea;
        sleep 0.1;
    };
};