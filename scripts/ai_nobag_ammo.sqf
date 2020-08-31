//--- Ai no bag ammo
// Optimizes the ai by removing bags and weapon attachments
// Adds more ammo to the ai without the need of having a magazine
// allows ai to reload at without a bag (limited amount)

// ai init
ai_ammo_fnc_onInit = {
    params ['_unit'];

    // only run on non west/ non civis
    if ((side _unit) isEqualTo west) exitWith {};
    if ((side _unit) isEqualTo civilian) exitWith {};

    // add fired event
    _unit addEventHandler ["Fired", {
        call ai_ammo_fnc_onFired;
    }];

    // remove bag
    removeBackpack _unit;

    // remove attatchments
    removeAllPrimaryWeaponItems _unit;
    removeAllHandgunItems _unit;
    {
        _unit removeSecondaryWeaponItem _x;
    } forEach (secondaryWeaponItems _unit);
};


["All", "InitPost", {
   _this call ai_ammo_fnc_onInit;
}, true, nil, true] call CBA_fnc_addClassEventHandler;


ai_ammo_fnc_onFired = {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

    if (!local _unit) exitWith {};

    private _mags = 3;
    private _isAT = false;

    private _isGrenade = toLower _weapon isEqualTo 'throw';
    if (_isGrenade) exitWith {};

    // gl
    private _glTypeArr = [
        'vog',
        '40mm',
        'ugl',
        'grenade',
        'grd',
        'gdm',
        'vg',
        'm397',
        'm433',
        'm441',
        'm576',
        'm585',
        'm661',
        'm662',
        'm713',
        'm714',
        'm715',
        'm716'
    ];
    private _isGL = (_glTypeArr findIf {typeOf _projectile find _x != -1} != -1);
    if (_isGL) then {
        _mags = _unit getVariable ['ai_ammo_magsLeft',5];
        _isAT = true;
    };

    // if using at, get the amount of mags
    if ((currentWeapon _unit) isEqualTo (secondaryWeapon _unit)) then {
        _mags = _unit getVariable ['ai_ammo_magsLeft',3];
        _isAT = true;
    };

    // exit if no more resupply allowed
    if (_mags <= 0) exitWith {};

    private _ammoLeft = _unit ammo _muzzle;

    // exit if still has ammo
    if (_ammoLeft > 0) exitWith {};
    //systemchat 'ai_ammo: no ammo';

    // terminate any old handles for the ammo
    // todo make sure it does not fuck up, but in theory should be okay without terminating
    private _handle = _unit getVariable ["ai_ammo_handle", scriptNull];
    //terminate _handle;
    _handle = [_unit,_weapon,_magazine,_muzzle,_isAT] spawn {
        params [['_unit',objNull],'_weapon','_magazine','_muzzle','_isAT'];

        // give the ammo after 3 seconds
        sleep 3;

        // sleep more if it's at
        if (_isAT) then {
            sleep 3;
        };

        // make sure the unit still exists and still has no ammo
        if (isNull _unit) exitWith {};
        if ((_unit ammo _muzzle) > 0) exitWith {};

        // find the first container for the unit
        private _container = uniformContainer _unit;
        if (isNull _container) then {
            _container = vestContainer _unit;
        };

        if (isNull _container) exitWith {
            //systemchat 'ai_ammo: no container';
        };

        // add the magzine
        _container addMagazineCargo [_magazine,1];

        _unit removeWeapon _weapon;
        _unit addWeapon _weapon;
        //_unit setWeaponReloadingTime [_unit,_muzzle,1];


        //systemchat 'ai_ammo: added ammo';

        // if AT is being added, remove 1 from the amount of mags allowed
        if (_isAT) then {
            _mags = _unit getVariable ['ai_ammo_magsLeft', 3];
            _unit setVariable ['ai_ammo_magsLeft', _mags - 1];
            //systemchat 'ai_ammo: AT mags -1';
            //_unit setWeaponReloadingTime [_unit,_muzzle,1];
        };
    };
    _unit setVariable ["ai_ammo_handle", _handle];
};