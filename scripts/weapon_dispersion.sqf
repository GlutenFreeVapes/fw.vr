//--- Vehicle Weapon Dispersion
// add on all clients, will make the specified weapon disperse
// credits: GlutenFreeVapes
ten_fnc_test = {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_pr", "_gunner"];
    if (!local _unit) exitWith {};
    call {
        if !(_weapon isEqualTo 'M134_minigun') exitWith {};
        _vel = velocityModelSpace _pr;
        _vel = _vel vectorAdd [10 - (random 20),0,10 - (random 20)];
        _pr setVelocityModelSpace _vel;
    };
};
["B_Heli_Light_01_dynamicLoadout_F", "Fired", {_this call ten_fnc_test;},true,[],true] call CBA_fnc_addClassEventHandler;