//--- More helicopter health
// Attempts to stop helicopters from exploding furiously
// barely works, helicopters still explode
// credits: GlutenFreeVapes
// heli more health
//--- V1
ten_fnc_handleDamage = {
    params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
    //systemChat str _hitPoint;
    //systemChat str _damage;
    if (!local _unit) exitWith {};

    // glass or rotor
    if (!(_hitPoint find 'glass' isEqualTo -1) || !((_hitPoint find 'rot') isEqualTo -1)) exitWith {
        if (_damage > 0.9) then {_damage = 0.9};
        _damage
    };


    private _varName = ('unit_race_dmg_last_' + _hitPoint);

    private _dmgList = _unit getVariable ['unit_race_dmg_list',[]];
    _dmgList pushBackUnique _varName;
    _unit setVariable ['unit_race_dmg_list',_dmgList];

    private _lastdamage = _unit getVariable [_varName, 0];
    private _realDamage = _damage - _lastdamage;
    private _newDamage = (_damage - (_realDamage / 1.25));
    _unit setVariable [_varName, _newDamage];

    //systemChat (str _damage + ' - > ' + str _newDamage);

    // return changed damage
    _newDamage
};


//--- V2

ten_fnc_handleDamage = {
    params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
    //systemChat str _hitPoint;
    //systemChat str _damage;
    if (!local _unit) exitWith {};

    // glass or rotor
    if (!(_hitPoint find 'glass' isEqualTo -1) || !((_hitPoint find 'rot') isEqualTo -1)) exitWith {
        if (_damage > 0.9) then {_damage = 0.9};
        //systemChat ("h:" + str _hitPoint + " d:" + str _damage);
        _damage
    };


    private _varName = ('unit_race_dmg_last_' + _hitPoint);

    private _dmgList = _unit getVariable ['unit_race_dmg_list',[]];
    _dmgList pushBackUnique _varName;
    _unit setVariable ['unit_race_dmg_list',_dmgList];

    private _lastdamage = _unit getVariable [_varName, 0];
    private _realDamage = _damage - _lastdamage;
    //private _newDamage = (_damage - (_realDamage / 1.25));
    // 3.4 - (3.4 / 1.25) ======= 0.69
    //
    //
    private _newDamage = _damage - (_realDamage * 0.95);
    //systemChat ("d:" + str _damage + " rD:" + str _realDamage + " nD" + str _newDamage);
    _unit setVariable [_varName, _newDamage];

    if (_newDamage > 0.9) then {

        //systemChat str _hitPoint;
        _unit allowDamage false;
        if (damage _unit > 0.9) then {
            _unit setDamage 0.8;
            //_unit setHitPointDamage ['hitEngine',0.8];
            //_unit setHitPointDamage ['hitHull',0.8];
        };
    };
    {
        if ((_unit getHitPointDamage _x) >= 0.9) then {
            _unit setHitPointDamage [_x,0.8];
        };
    } forEach ['hitEngine','hitEngine2','hitHull'];

    //systemChat (str _damage + ' - > ' + str _newDamage);

    // return changed damage
    _newDamage
};



//--- add to vehicles
ten_fnc_initPost = {
    params ['_unit'];
    _unit addEventHandler ["HandleDamage", {
        _this call ten_fnc_handleDamage;
    }];
};
["rhs_uh1h", "InitPost", {_this call ten_fnc_initPost},true,[],true] call CBA_fnc_addClassEventHandler;
["rhs_uh1h_hidf", "InitPost", {_this call ten_fnc_initPost},true,[],true] call CBA_fnc_addClassEventHandler;
