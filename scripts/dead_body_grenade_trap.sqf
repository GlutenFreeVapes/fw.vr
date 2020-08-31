//--- Dead body grenade trap
// requires sound file and description.ext
// credits: GlutenFreeVapes
//--- description.ext
class CfgSounds
{
	sounds[] = {};
	class ten_pin
	{
		// how the sound is referred to in the editor (e.g. trigger effects)
		name = "pin_sound";

		// filename, volume, pitch, distance (optional)
		sound[] = { "pin.ogg", 2, 1, 30 };

		// subtitle delay in seconds, subtitle text
		titles[] = { 1, "" };
	};
};



//--- script
ten_fnc_trap = {
    params ["_unit", "_container"];
    private _isBomber = _container getVariable ['unit_bomber',false];
    if (_isBomber) then {
        if (random 100 > 99)  then {
            private _g = 'Grenade' createVehicle [0,0,0];
            [_unit,'ten_pin'] remoteExec ['say3d'];
            _g setpos getpos _container;
        };
        _container setVariable ['unit_bomber',false,true];
    };

};

// grenade trap
player addEventHandler ["InventoryOpened", {_this call ten_fnc_trap;}];
