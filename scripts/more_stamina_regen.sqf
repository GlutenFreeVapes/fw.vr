//--- More stamina regen
// increases stamina regen when moving at a slow jog
// credits: GlutenFreeVapes
if (!hasInterface) exitWith {};
ten_fnc_stamina = {
    if (vehicle player != player || cba_missiontime < 1) exitWith {};
    private _time = cba_missiontime;
    private _dir = getDir player;
    private _oldTime = player getVariable ['ten_stamina_oldTime',_time];
    private _timeSpent = _time - _oldTime;
    private _v = velocityModelSpace player;
    private _speed = ((abs(_v select 0)) + (abs (_v select 1)));
    private _stamina = getStamina player;
    player setStamina call {

        // get a lot more stamina when walking or standing still
        if (_speed < 1.7) exitWith {
            (_stamina + (_timeSpent)*0.75)
        };

        // get some stamina when running with gun down
        if (_speed < 3.5) exitWith {
            (_stamina + (_timeSpent)*0.5)
        };

        // default value
        _stamina
    };

    player setVariable ['ten_stamina_oldTime',_time];
};
ten_stamina_handle = [{[] call ten_fnc_stamina}, 0] call CBA_fnc_addPerFrameHandler;