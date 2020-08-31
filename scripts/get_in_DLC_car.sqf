//--- Get in DLC car
// Allows players to drive DLC cars by using ace interaction
// credits: GlutenFreeVapes
_getIn = [
    "dlc_getin",
    "Get in driver",
    "",
    {
        [
            (1),
            [_target],
            {
                _target = ((_this param [0]) param [0,objNull]);
                if (!(vehicle player isEqualTo player) || !(isNull(driver _target)) || !(alive _target)) exitWith {systemChat "Can't get in.";};

                player moveInDriver _target;
            },
            {
            },
            "Getting in", {
                _target = ((_this param [0]) param [0,objNull]);
                (vehicle player isEqualTo player) && isNull(driver _target) && alive _target && _target inArea [player,5,5,0,false]
            }
        ] call ace_common_fnc_progressBar;
    },
    {
        (vehicle player isEqualTo player) && isNull(driver _target) && alive _target && _target inArea [player,5,5,0,false]
    }
] call ace_interact_menu_fnc_createAction;
["I_C_Van_02_transport_F", 0, ["ACE_MainActions"], _getIn, true] call ace_interact_menu_fnc_addActionToClass;