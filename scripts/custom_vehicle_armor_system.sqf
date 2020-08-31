//--- Custom Vehicle armor system
// adds a custom armor system to a vehicle
// custom repair system which allows to repair the vehicle
// credits: GlutenFreeVapes
// TODO
// - Needs to have the EWS changes to only be running on one of the crew members
//			- Otherwise the EWS might get out of sync
// - EWS hud should still run the same, just be called from Remote (probably commander -> Gunner -> driver)
//			- Just have the script exit if at least 1 person is running
//			- needs to have a serverside setter and EWS start request function

["All", "InitPost", {
   _this call armor_fnc_onInit;
}, true, nil, true] call CBA_fnc_addClassEventHandler;

//--- INIT
// only works for sertain vehicles!
armor_fnc_onInit = {
    params ['_unit'];
    _vehicleType = toLower (typeOf _unit);

    // only run on the tank
    if ((_vehicleType find 'm1a2') == -1) exitWith {

        // run code for supply vehicles:
        if (_vehicleType find 'fmtv' != -1) then {
            [_unit] call armor_fnc_resupplyInit;
        };



        // exit if it's not an enemy tank
        if (
            (mission_armor_ews_dangerVehicles findIf {
                (_vehicleType find _x) > -1
            }) == -1
        ) exitWith {};

        _unit addEventHandler ['HandleDamage',{
            _this call armor_fnc_onHandleDamageEnemy;
        }];
        _unit addEventHandler ['fired',{
            _this call armor_fnc_onFiredEnemy;
        }];


    };

    if (local _unit) then {
        [
            _unit,
            nil,
            ["DUKE_Hide",0,"IFF_Panels_Hide",0,"Miles_Hide",1]
        ] call BIS_fnc_initVehicle;

        // loadout
        _unit setVariable ["unit_loadout_faction",west,true];
        _unit setVariable ["unit_loadout_cargoType",['empty'],true];
        //[_unit] spawn loadout_fnc_cargo;
    };



    // fired event
    _unit addEventHandler ['fired',{
        _this call armor_fnc_onFired;
    }];

    // handle damage event
    _unit addEventHandler ['HandleDamage',{
        _this call armor_fnc_onHandleDamage;
    }];

    // get in event to enable ews
    _unit addEventHandler ['GetIn',{
        _this call armor_fnc_onGetIn;
    }];

    // get out event to disable ews
    _unit addEventHandler ['GetOut',{
        _this call armor_fnc_onGetOut;
    }];
};

//--- handle damage
armor_fnc_onHandleDamage = {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
    private _oldParams = _this;
    if (!local _unit) exitWith {};

    // exit if unit died
    if (!alive _unit) exitWith {};

    //systemChat str _this;
    // exit if ERA hit
    if (toLower _hitPoint find 'era' != -1) exitWith {
        _damage
    };

    // damage for tank shell
    _damageDone = call {

        // exit if selection exists
        if !(_selection isEqualTo '') exitWith {0};

        // 34
        if (_projectile isEqualTo 'UK3CB_Sh_BR365') exitWith {0.1};
        if (_projectile isEqualTo 'rhs_ammo_3bm26_penetrator') exitWith {0.1};


        // no selection and tank shell (0.2) 55
        if (_projectile isEqualTo 'UK3CB_Sh_BM8') exitWith {0.2};
        if (_projectile isEqualTo 'rhs_ammo_bk5_penetrator') exitWith {0.2};

        // no selection and rpg (vanilla)
        if (_projectile isEqualTo 'ammo_Penetrator_PG7') exitWith {0.1};
        if (_projectile isEqualTo "rhs_rpg7v2_pg7vl_penetrator") exitWith {0.1};

        // static launcher ammo
        if (_projectile isEqualTo 'rhs_ammo_pg9v_penetrator') exitWith {0.15};

        if (_projectile isEqualTo 'rhs_ammo_3ubr11') exitWith {0.01};
        if (_projectile isEqualTo 'rhs_ammo_3ubr8') exitWith {0.02};

        // t72 shell
        if (_projectile isEqualTo 'rhs_ammo_3bm26_penetrator') exitWith {0.25};

        // t80 shell
        if (_projectile isEqualTo 'rhs_ammo_3bm46_penetrator') exitWith {0.25};

        0
    };


    // exit if 0 damage
    if (_damage == 0 && _damageDone == 0) exitWith {};

    // exit if hitpoint has light in it
    if ((toLower _hitPoint) find 'light' != -1) exitWith {
        _damage
    };


    // only allow hits every 1 seconds (lower if damage less than 0.1
    private _delay = 1;

    if (_damageDone < 0.1) then {
        _delay = 0.15;
    };

    private _nextHitAt = _unit getVariable ['unit_armor_nextHitAt',0];


    // todo, RIGHT now only exits if timer not met and no hitpoint (scripted damage)
    //if (CBA_MissionTime < _nextHitAt) exitWith {};
    if (CBA_MissionTime < _nextHitAt && {_hitPoint isEqualTo ''}) exitWith {};


    _unit setVariable ['unit_armor_nextHitAt', CBA_MissionTime + _delay, true];
    _unit setVariable ['unit_armor_lastHitAt', CBA_MissionTime, true];
    if (!isNull _source) then {
        _unit setVariable ['unit_armor_lastHitBy', _source, true];
    };


    // terminate the old handle, so damage does not duplicate
    private _handle = _unit getVariable ['unit_armor_delay_handle',scriptNull];
    terminate _handle;

    // modded hitpoint, to cause scripted damage on hits that normally don't damage at all
    private _hitPointModded = _hitPoint;

    // if no hitpoint, use hithull
    if (_hitPointModded isEqualTo '') then {

        // selected random part to hit
        _hitPointModded = selectRandomWeighted [
            'hitHull',100,
            'hitrtrack',20,
            'hitltrack',20,
            'hitturret',50,
            'hitgun',5,
            'hitengine',5
        ];
    };

    // make variable name based on hitpoint
    private _varName = ('unit_armor_dmg_last_' + _hitPointModded);

    private _dmgList = _unit getVariable ['unit_armor_dmg_list',[]];
    _dmgList pushBackUnique _varName;
    _unit setVariable ['unit_armor_dmg_list',_dmgList];

    // get the saved last damage
    private _lastdamage = _unit getVariable [_varName, 0];


    // if hitpoint was empty, a modded hitpoint was used, then use damageDone (based on ammo type) instead
    if (_hitPoint isEqualTo '') then {
        _damage = _lastdamage + _damageDone;
    };

    // calculate the real damage inflicted by this damage event
    private _realDamage = _damage - _lastdamage;

    private _damageMod = 0.5;

    // calculate the damage modifier
    if (_realDamage > 0.1) then {

        // based on the last time big damage was recieved
        private _lastBigDmgTime = _unit getVariable ['unit_armor_lastBigDmgTime',0];
        _unit setVariable ['unit_armor_lastBigDmgTime',CBA_MissionTime];

        // time passed 90 seconds or bigger means only 10% of damage
        // time passed 0 means 50% damage
        private _timePassed = CBA_MissionTime - _lastBigDmgTime;
        _damageMod = linearConversion [0,90,_timePassed,0.5,0.8,true];
        //systemChat ('damageMod: ' + str _damageMod);
    };
    if (_realDamage > 1) then {
        //systemChat 'Loads of damage (>1)';
        //_realDamage = _realDamage / 2;
        //_damage = _damage / 2;
        _damageMod = (_damageMod + 0.25) min 0.9;
    };

    // calculate new damage after modifer
    private _newDamage = (_damage - ((abs _realDamage) * _damageMod));
    //systemChat ('D: ' + str _damage + ' - '  + str _realDamage + ' * ' + str _damageMod  + ' = '  + str _newDamage);

    // use scripted damage if it's not 0
    if (_damageDone != 0) then {

        // use last damage as damage (because it was 0)
        _damage = _lastdamage;

        // add damage
        _newDamage = _damage + _damageDone;

    };
    _newdamage = _newdamage max _lastdamage;

    // no explosion: attempt 1
    if (_hitPointModded isEqualTo 'hitHull' && _newDamage > 0.8)  then {
        //systemChat 'hull > 0.8';
        _newDamage = 0.8;

        //--- since we are removing damage from the hull, we will re-locate to a random part
        // copy old params (from the main handleDamage _this)
        private _params = + _oldParams;

        // select new hitpoint
        private _newHitPoint = selectRandomWeighted [
            'hitrtrack',20,
            'hitltrack',20,
            'hitturret',50,
            'hitgun',5,
            'hitengine',5
        ];
        _params set [7,_newHitPoint];

        // re-do damage event (next frame)
        [{_params call armor_fnc_onHandleDamage}] call CBA_fnc_execNextFrame;
    };



    //systemChat format ["%1 - %2 - %3 - %4",_damage, _newDamage, _realDamage,_damageMod];
    //systemChat (str _damage + ' - > ' + str _newDamage + ' |' + str _hitPointModded);

    // cause damage if hitpoint was empty
    if (_hitPoint isEqualTo '') exitWith {

        // spawn the damage in 0.1 seconds to make sure it does not duplicate
        private _handle = [_unit,_hitPointModded,_newDamage,_damage,_varName] spawn {
            params ['_unit','_hitPointModded','_newDamage','_damage','_varName'];
            sleep 0.1;
            _unit setHitPointDamage [_hitPointModded,_newDamage];
            _unit setVariable [_varName, _newDamage];

            //systemChat (str _damage + ' - > ' + str _newDamage);
        };

        _unit setVariable ['unit_armor_delay_handle',_handle];

        // since damage is done via command, no need to cause any more
        0
    };

    _unit setVariable [_varName, _newDamage];
    //systemChat (str _damage + ' - > ' + str _newDamage);

    // return changed damage
    _newDamage
};


armor_fnc_onGetOut = {
	params ["_vehicle", "_role", "_unit", "_turret"];

    // only run if player exists and is getting in
    if (isNull player) exitWith {};
    if !(_unit isEqualTo player) exitWith {};

    // update player damage threshold
    private _dmgThreshold = player getVariable ["unit_armor_player_dmgThreshold",nil];
    if (isNil '_dmgThreshold') then {
        _dmgThreshold = player getVariable ["ace_medical_unitDamageThreshold",3];
        player setVariable ["unit_armor_player_dmgThreshold",_dmgThreshold];
    };
    // double damage threshold inside the tank
    player setVariable ['ace_medical_unitDamageThreshold',_dmgThreshold, true];
    player setVariable ['ace_medical_preventInstaDeath',nil,true];

    // get the handle for this pfh
    private _ews_PFH_handle = missionNamespace getVariable ['mission_armor_ews_pfh_handle',nil];

    // if it doesn't exist, exit
    if (isNil '_ews_PFH_handle') exitWith {};
    [_ews_PFH_handle] call CBA_fnc_removePerFrameHandler;
    missionNamespace setVariable ['mission_armor_ews_pfh_handle',nil];
};

armor_fnc_onGetIn = {
	params ["_vehicle", "_role", "_unit", "_turret"];

    // only run if player exists and is getting in
    if (isNull player) exitWith {};
    if !(_unit isEqualTo player) exitWith {};


    // update player damage threshold
    private _dmgThreshold = player getVariable ["unit_armor_player_dmgThreshold",nil];
    if (isNil '_dmgThreshold') then {
        _dmgThreshold = player getVariable ["ace_medical_unitDamageThreshold",3];
        player setVariable ["unit_armor_player_dmgThreshold",_dmgThreshold];
    };

    // double damage threshold inside the tank
    player setVariable ['ace_medical_unitDamageThreshold',(_dmgThreshold param [0,5]) * 2, true];
    //player setVariable ['ace_medical_preventInstaDeath',true,true];

    // get the handle for this pfh
    private _ews_PFH_handle = missionNamespace getVariable ['mission_armor_ews_pfh_handle',nil];

    // if it exists, exit
    if (!isNil '_ews_PFH_handle') exitWith {};
    [{
        params ["_args", "_handle"];
        call armor_fnc_ews_PFH;
    }, 0, []] call CBA_fnc_addPerFrameHandler;
    missionNamespace setVariable ['mission_armor_ews_pfh_handle',_ews_PFH_handle];
};


// resupply vehicle init
armor_fnc_resupplyInit = {
    params ['_unit'];
    _unit setVariable ['ace_rearm_isSupplyVehicle',true];
    [_unit] call ace_rearm_fnc_initSupplyVehicle;
    [_unit,10000] call ace_rearm_fnc_setSupplyCount;

    if (!local _unit) exitWith {};
    ["ACE_Wheel", _unit] call ace_cargo_fnc_addCargoItem;
    ["ACE_Wheel", _unit] call ace_cargo_fnc_addCargoItem;
    ["ACE_Wheel", _unit] call ace_cargo_fnc_addCargoItem;
    ["ACE_Track", _unit] call ace_cargo_fnc_addCargoItem;


    _unit setVariable ["unit_loadout_faction",west,true];
    _unit setVariable ["unit_loadout_cargoType",["ammoBig",'rifle','meds','at'],true];
    //[_unit] spawn loadout_fnc_cargo;
};


armor_fnc_onHandleDamageEnemy = {
    params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
    //systemChat str _this;
    if (!local _unit) exitWith {};

    // exit if less than 0.1 damage
    if (_damage < 0.1) exitWith {};

    // update last shot at to 0 (extra miss
    _unit setVariable ['unit_armor_lastShot',0];
};

armor_fnc_onFiredEnemy = {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    if (!local _unit) exitWith {};
    private _vehicleType = typeOf _unit;

    // don't run if FCS
    if (toLower _muzzle find 'fcs' != -1) exitWith {};

    //systemchat str _muzzle;
    //systemChat typeOf _projectile;

    //systemChat 'fired';
    private _nearestTank = (nearestObjects [_unit, ["rhsusf_m1a2sep1tuskiid_usarmy"], 1500]) param [0,objNull];

    // check if isAimingAt returns true
    if (!([_unit,(_nearestTank)] call armor_fnc_ews_isAimingAt)) exitWith {
        //(str _this + ' X ' + str _nearestTank) remoteExec ['systemchat',-2];
    };


    private _target = _nearestTank;
    //private _target = assignedTarget gunner _unit;
    private _targetType = typeOf _target;

    //(str _this + ' - ' + str _nearestTank) remoteExec ['systemchat',-2];

    // only run if target is m1a2
    //if (_targetType find 'm1a2' == -1) exitWith {};

    private _missRate = 15;

    // for 9 seconds after being hit, the target will be missed more
    private _lastHitAt = _target getVariable ['unit_armor_lastHitAt',0];
    private _lastHitBy = _target getVariable ['unit_armor_lastHitBy',objNull];
    private _lastHitAtLimit = 5;
    if (_lastHitBy isEqualTo _unit) then {
        _lastHitAtLimit = 15;
    };

    private _sinceLastHitAt = CBA_MissionTime - _lastHitAt;
    if (_sinceLastHitAt < _lastHitAtLimit) then {
        _missRate = _missRate + 100;
        //systemChat 'last hit at';
    };


    private _lastShotAt = _target getVariable ['unit_armor_lastShotAt',0];
    _target setVariable ['unit_armor_lastShotAt',CBA_MissionTime,true];

    private _sinceLastShotAt = CBA_MissionTime - _lastShotAt;

    // every 60 seconds this target will be missed at more
    if (_sinceLastShotAt > 60) then {
        _missRate = _missRate + 50;
        //systemChat 'last shot at';
    };

    // every 20 seconds the shot will miss more
    private _lastShot = _unit getVariable ['unit_armor_lastShot',0];
    _unit setVariable ['unit_armor_lastShot',CBA_MissionTime];

    private _sinceLastShot = CBA_MissionTime - _lastShot;
    if (_sinceLastShot > 20) then {
        _missRate = _missRate + 50;
        //systemChat 'last shot';
    };

    // miss rate added for smokes/scripted from the tank
    private _extraMissUntil = _target getVariable ['unit_armor_extraMissUntil',0];
    if (CBA_MissionTime < _extraMissUntil) then {
        _missRate = _missRate + 100;
        //systemChat 'extra';
    };

    _missRate = _missRate min 250;

    private _vel = velocity _projectile;
    private _missBase = -(_missRate/2);

    // miss rate
    _vel = [
        _vel # 0 + (_missBase + random _missRate),
        _vel # 1 + (_missBase + random _missRate),
        _vel # 2 + (_missBase + random _missRate)
    ];
    _projectile setVelocity _vel;
};

armor_fnc_onFired = {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    if (!local _unit) exitWith {};
    if (toLower _weapon find 'm250' != -1) then {
        (vehicle _unit) setVariable ['unit_armor_extraMissUntil', CBA_MissionTime + 10, true];
    };
};

//--- REPAIRING


armor_fnc_onRepair = {
    //systemChat str _this;
    params ['_vehicle','_subHitIndex','_subPointNewDamage'];

    // only run on the tank
    if ((toLower (typeOf _vehicle) find 'm1a2') == -1) exitWith {};

    // hitPoint name
    private _hitPointName = '';

    // if the subHitIndex is a number (from EH1) get the hitpoint name
    if (_subHitIndex isEqualType 0) then {

        // get a hitpointname from the all hitpoints array
        _hitPointName = ((getAllHitPointsDamage _vehicle) #0) param [_subHitIndex,''];
    };
    if (_subHitIndex isEqualType '') then {
        _hitPointName = _subHitIndex;
    };

    if (_hitPointName isEqualTo '') exitWith {};

    private _varName = ('unit_armor_dmg_last_' + _hitPointName);
    _vehicle setVariable [_varName, _subPointNewDamage];
};

//--- repair EH for tank (because new damage system with handledamage)
["ace_repair_setVehicleHitPointDamage", {
    _this call armor_fnc_onRepair;
}] call CBA_fnc_addEventHandler;

["ace_repair_setWheelHitPointDamage", {
    _this call armor_fnc_onRepair;
}] call CBA_fnc_addEventHandler;


// todo individual part repair (ace event)
_repair = [
	"armor_repair",
	"Full Repair Vehicle",
	"",
	{
        _this call armor_fnc_repair_onAction;
	},
	{
		((((getAllHitPointsDamage _target) param [2,[]]) findIf {_x != 0} != -1) || (fuel _target <= 0.05)) && (vehicle player isEqualTo player) && isNull(driver _target) && alive _target
	}
] call ace_interact_menu_fnc_createAction;
["rhsusf_m1a2sep1tuskiid_usarmy", 0, ["ACE_MainActions"], _repair, true] call ace_interact_menu_fnc_addActionToClass;


armor_fnc_repair_onAction = {

    // todo const. time for repair
    private _defaultTime = 60;
    private _repairTimeLeft = _target getVariable ['unit_armor_repair_timeLeft',_defaultTime];
    private _lastRepairAttemptAt = _target getVariable ['unit_armor_repair_lastRepairAttemptAt',0];
    private _sinceLastRepairAttempt = CBA_MissionTime - _lastRepairAttemptAt;

    // if the vehicle hasn't been repaired for 2 minutes, reset the repairs
    if (_sinceLastRepairAttempt > 180) then {
        _repairTimeLeft = _defaultTime;
        systemChat ('Starting repairs: time left: ' + str (round _repairTimeLeft) + ' seconds');
    } else {
        systemChat ('Continuing repairs, time left: ' + str (round _repairTimeLeft) + ' seconds');
    };

    // update last attempt timer
    _target setVariable ['unit_armor_repair_lastRepairAttemptAt', CBA_MissionTime, true];

    [
        ([_repairTimeLeft,_repairTimeLeft / 2] select (currentWeapon player isEqualTo '')),
        [_target,_repairTimeLeft],
        {
            params ['_args', '_elapsedTime', '_totalTime', '_errorCode'];
            _args params ['_target','_repairTimeLeft'];
            //_target = ((_this param [0]) param [0,objNull]);
            _target setDamage 0;

            private _dmgList = _target getVariable ['unit_armor_dmg_list',[]];
            {
                _target setVariable [_x,nil];
            } forEach _dmgList;

            // remove timeLeft
            _target setVariable ['unit_armor_repair_timeLeft', nil, true];

            private _fuel = fuel _target;
            _target setFuel (_fuel + 0.1);


            player playAction "medicStop";
        },
        {
            params ['_args', '_elapsedTime', '_totalTime', '_errorCode'];
            _args params ['_target','_repairTimeLeft'];

            // update time left
            _target setVariable ['unit_armor_repair_timeLeft', (_repairTimeLeft - _elapsedTime), true];


            player playAction "medicStop";
        },
        "Repairing", {
            params ['_args', '_elapsedTime', '_totalTime', '_errorCode'];
            _args params ['_target','_repairTimeLeft'];


            (_target inArea [player,7,7,0,false]) &&
            isNull(driver _target)
        }
    ] call ace_common_fnc_progressBar;
    player playAction "medicStart";
};


//--- EWS
// Early warning system
// Alerts the vehicle crew of threats
// todo missile target EH onfired

mission_armor_ews_dangerVehicles = [
    'bmp',
    '34',
    '55',
    '72',
    '80',
    '90',
    'spg'
];

// create the ui for warning

armor_fnc_ews_createHUD = {
    disableSerialization;

    // todo make sure this won't overwrite
    //"ews_layer" cutRsc ["","PLAIN"];
    // crate display
    "mission_ews_layer" cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
    //"ews_layer" cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
    private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

    // save display
    uiNamespace setVariable ['mission_ews_display',_display];

    // create the displays
    private _ctrlBg = _display ctrlCreate ['RscPicture',-1];
    private _ctrl = _display ctrlCreate ['RscPicture',-1];

    // save the control so it's faster to access it
    uiNamespace setVariable ['mission_ews_ctrl',_ctrl];

    //_ctrl ctrlSetStructuredText parseText 'X';
    // todo add picture
    _ctrl ctrlSetText 'fg.paa';
    _ctrlBg ctrlSetText 'bg.paa';

    private _color = [1,1,1,0];
    _ctrl setVariable ['ctrl_ews_color',_color];
    _ctrl ctrlSetTextColor _color; // todo picture color: ctrlSetTextColor

    // todo maybe smoothly enable the BG control's alpha (inside the normal alpha change loop)
    _ctrlBg ctrlSetTextColor [1,1,1,1];

    private _x = safeZoneX;
    private _y = safeZoneY;
    private _w = safeZoneW/40;
    private _h = safeZoneH/25;

    private _pos = [
        (_x + (_w * 30)),
        (_y + (_h * 17)),
        (_w*1.5),
        (_h*1.5)
    ];
    _ctrl ctrlSetPosition _pos;
    _ctrlBg ctrlSetPosition _pos;
    _ctrl ctrlCommit 0;
    _ctrlBg ctrlCommit 0;
};

armor_fnc_ews_hud_PFH = {
    params ["_args", "_handle"];
    disableSerialization;

    private _vehicle = vehicle player;

    // maybe do the checks and exit the loop if checks fail
    private _isAlertOver = call {

        private _display = uiNamespace getVariable ['mission_ews_display',displayNull];
        if (isNull _display) then {

            // no display, stop loop
            // maybe create display instead ??? (then not exitWith)
            //[_handle] call CBA_fnc_removePerFrameHandler;
            //true
            call armor_fnc_ews_createHUD;
        };

        // make sure player is in ews vehicle
        if ((toLower (typeOf _vehicle) find 'm1a2') == -1) exitWith {
            // delete hud and stop
            true
        };

        // make sure there is still an alert on-going
        private _alertUntil = _vehicle getVariable ['unit_ews_alertUntil',0];
        if (CBA_MissionTime > _alertUntil) exitWith {
            // delete hud and stop
            true
        };
        false
    };

    // delete and stop the loop
    if (_isAlertOver) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;

        "mission_ews_layer" cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
        //("ews_layer" call BIS_fnc_rscLayer) cutRsc ["", "PLAIN"];
        //"ews_layer" cutRsc ["","PLAIN"]; // todo test

        // remove pfh handle
        missionNamespace setVariable ['mission_ews_hud_PFH',nil];
    };

    private _playSoundAt = missionNamespace getVariable ['mission_ews_playSoundAt',CBA_MissionTime];
    if (CBA_MissionTime >= _playSoundAt) then {
        // todo soundtime const.
        private _soundTime = 0.25;

        // play sound
        // todo use a const. for sound file
        //private _soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
        //_soundToPlay = _soundPath + "beep4.ogg";
		//playSound3D [_soundToPlay, _vehicle, true, getPos _vehicle, 3, 1, 0];
        playsound ['beep4',true];


        // update next sound time
        missionNamespace setVariable ['mission_ews_playSoundAt',CBA_MissionTime + _soundTime];
    };

    // update the opacity of the control/image
    call {
        // ctrl should not be null (checked to see if display exists before)
        private _ctrl = uiNamespace getVariable ['mission_ews_ctrl',ctrlNull];

        // ctrlTick is used to tick the ctrl alpha (alpha is calculated to be smooth)
        private _ctrlTick = _ctrl getVariable ['ctrl_ews_tick',-1];

        private _color = _ctrl getVariable 'ctrl_ews_color';

        // reset tick when it reaches 1
        if (_ctrlTick >= 1) then {
            _ctrlTick = -1;
        };
        private _alpha = ((-(_ctrlTick ^ 2))+1);
        //systemChat str [_alpha,_ctrlTick];
        _color set [3,_alpha];
        _ctrl ctrlSetTextColor _color;    // todo picture alpha

        // todo const. for tick size
        private _tickSize = 0.075;

        // update tick
        _ctrlTick = _ctrlTick + _tickSize;
        _ctrl setVariable ['ctrl_ews_tick',_ctrlTick];
    };
};

armor_fnc_ews_PFH = {
    private _unit = player;
    private _vehicle = vehicle _unit;

    // pause until the pause time
    private _pauseUntil = _vehicle getVariable ['unit_ews_pauseUntil',0];
    if (CBA_MissionTime < _pauseUntil) exitWith {};


    // get pause time
    private _pauseFor = call {
        // only run if player is in the tank

        if ((toLower (typeOf _vehicle) find 'm1a2') == -1) exitWith {
        //if (!((typeOf _vehicle) isEqualTo 'rhsusf_m1a2sep1tuskiid_usarmy')) exitWith {

            // sleep for 5 seconds
            5
        };

        // check the threat units for this tank
        private _threats = _vehicle getVariable ['unit_ews_threats',[]];

        // get new threats if no threats found
        if (_threats isEqualTo []) exitWith {

            // find threats
            call {
                private _center = getPosASL _vehicle;
                private _unitSide = side group _unit;

                // find threats from vehicles
                // todo switch to inAreaArray?
                _threats = vehicles select {
                    private _vehicleType = (toLower (typeOf _x));

                    // check if the class of the current vehicle is in list of dangerous vehicles
                    // todo arr???

                    // check side
                    (side (group (gunner _x))) != _unitSide && {
                        (mission_armor_ews_dangerVehicles findIf {
                            (_vehicleType find _x) > -1
                        }) != -1 && {
                            // check to see if the vehicle is in 1500m range
                            _x inArea [_center,1500,1500,0,false];
                        }
                    }
                };

                // add ground units to the list
                // todo switch to inAreaArray?
                _threats = _threats + (allUnits select {
                    // check side
                    (side (group (driver _x))) != _unitSide && {

                        // must have a secondary weapon
                        !(secondaryWeapon _x isEqualTo '') && {

                            // and has to be in 1000m radius
                            _x inArea [_center,1000,1000,0,false];
                        }
                    }
                });
            };

            // save threats
            _vehicle setVariable ['unit_ews_threats',_threats];

            // no sleep(quitting with the targets this frame)
            0
        };

        // get a new threat
        private _threat = _threats deleteAt 0;

        // make sure the threat is alive
        if (!alive _threat) exitWith {
            0
        };

        // make sure threat has at out or is not a unit(is vehicle)
        if (
            (!((currentWeapon _threat) isEqualTo (secondaryWeapon _threat))) && {
                (_threat isKindOf 'man')
            }
        ) exitWith {
            0
        };

        // make sure threat knows about the unit or the units vehicle
        if ((_threat knowsAbout _unit <= 0.1) && (_threat knowsAbout _vehicle <= 0.1)) exitWith {
            0
        };

        // check if isAimingAt returns true
        if (!([_threat,_unit] call armor_fnc_ews_isAimingAt)) exitWith {
            0
        };


        // here we have passed all checks and this threat is a real threat
        // time to alert the vehicle!
        [_vehicle,_threat] call armor_fnc_ews_aimedAt;

        // pause for a bit, the alarm is going, so no need to waste resources checking more stuff atm
        1
    };

    _vehicle setVariable ['unit_ews_pauseUntil',(CBA_missiontime + _pauseFor)];
};


armor_fnc_ews_aimedAt = {
    // todo maybe only run this on driver or commander and then RE the functions to alert to other players in the vehicle

    // + Set alert true for this vehicle
    //  + set alertUntil variable
    //  + if the loop is not running (hud_pfh)
    //      + run it
    //  + create loop (hud_pfh)
    // - Get the direction of the alert
    //  - could make a indicator to the direction
    //      - or just display dir

    params [['_vehicle',objNull],['_threat',objNull]];

    // todo const. for alert length
    private _alertLength = 3;
    _vehicle setVariable ['unit_ews_alertUntil', CBA_MissionTime + _alertLength];

    // if the PFH is running, don't re-add it
    private _hud_PFH = missionNamespace getVariable ['mission_ews_hud_PFH',nil];
    if !(isNil '_hud_PFH') exitWith {};

    _hud_PFH = [{
        _this call armor_fnc_ews_hud_PFH;
    }, 0, []] call CBA_fnc_addPerFrameHandler;
    missionNamespace setVariable ['mission_ews_hud_PFH',_hud_PFH];
};

// check if unit is aiming at target
armor_fnc_ews_isAimingAt = {
    params [['_unit',objNull],['_target',objNull],['_isReturnBool',true]];

    // targetPos (above target)
    private _targetPosASL = (getPosASL _target) vectorAdd [0,0,1.5];

    // get the eyepos
    private _unitEyePosASL = (eyePos _unit);
    private _unitEyePos = ASLToAGL _unitEyePosASL;

    private _distance = _unitEyePosASL distance _targetPosASL;

    // get the predicted weapon position
    private _unitTargetPosASL = _unitEyePosASL vectorAdd (((vehicle _unit) weaponDirection (currentWeapon (vehicle _unit))) vectorMultiply _distance);

    // check if unit is aiming near the target
    if !(_unitTargetPosASL inArea [_targetPosASL,25,25,0,false]) exitWith {
        if (_isReturnBool) exitWith {
            false
        };
        [0,_targetPosASL,_unitTargetPosASL]
    };

    // check with checkVis(can unit see it's target) (accounts for smoke/grass and everything!)
    private _checkVis = [(vehicle _target), 'VIEW',(vehicle _unit)] checkVisibility [_unitEyePosASL,_unitTargetPosASL];
    _checkVis = round(_checkVis * 100);
    //[_checkVis,_targetPosASL,_unitTargetPosASL]

    // if more than 0.05 visiblity, return true
    if (_isReturnBool) exitWith {

        //systemChat str _checkVis;
        _checkVis > 5
    };
    [_checkVis,_targetPosASL,_unitTargetPosASL]
};