//--- Ai area suppression
// makes the ai suppress an area and allows to tune the accuracy and set the targets.
// credits: GlutenFreeVapes
ten_fnc_suppress = {
	params ['_unit',['_target',objNull,[objNull,[]]],['_doSuppression',true,[true]],['_suppressFor',15],['_suppressTimes',1],['_suppressBreak',5]];

    private _handle = _unit getVariable ['unit_suppress_handle',nil];
    if (!isNil '_handle') then {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

	if (!alive _unit) exitWith {};
	if (!local _unit) exitWith {};


    if (!_doSuppression || _suppressTimes < 1) exitWith {
		_unit enableAI "PATH";
		_unit doFollow leader group _unit;
		_unit setUnitPos 'AUTO';
    };
    _suppressTimes = _suppressTimes - 1;

    _unit setVariable ['unit_suppress_stopAt',CBA_Missiontime + _suppressFor];
    _unit setVariable ['unit_suppress_lastUpdate',nil];
	_unit setVariable ['unit_suppress_startAt',nil];

    // stop him
	doStop _unit;
	_unit disableAI "PATH";

    _handle = [
        {
            _this params ['_args','_handle'];
            _args params ['_unit',['_target',objNull],'_suppressFor','_suppressTimes','_suppressBreak'];


            // check if this handler is finished
            private _isOver = [call {
		        if (!alive _unit) exitWith {};
		        private _stopAt = _unit getVariable ['unit_suppress_stopAt',CBA_Missiontime];
		        if (CBA_Missiontime >= _stopAt) exitWith {};
		        if (_target isEqualTo objNull) exitWith {};
	            false

	        }] param [0,true];

	        if (_isOver) exitWith {

				private _pad = _unit getVariable ['unit_suppress_pad',objNull];
				deleteVehicle _pad;

	        	[_handle] call CBA_fnc_removePerFrameHandler;
	        	[ten_fnc_suppress, [_unit,_target,true,_suppressFor,_suppressTimes,_suppressBreak], _suppressBreak] call CBA_fnc_waitAndExecute;
	        };

            private _mag = _unit getVariable 'unit_suppress_mag';

            // if no mag saved, save a mag
            if (isNil '_mag' || {_mag isEqualTo ''}) exitWith {

            	// todo test vehicles with this
            	_mag = currentMagazine vehicle _unit;
            	_unit setVariable ['unit_suppress_mag',_mag];
            };

            // add magazines if none left
            if (({_x isEqualTo _mag} count (magazines _unit)) == 0) then {
            	(vehicle _unit) addMagazine _mag;
            };

            // get position


            private _lastUpdate = _unit getVariable ['unit_suppress_lastUpdate',0];
            private _timeSinceLastUpdate = CBA_Missiontime - _lastUpdate;

            // look at updated every 1 seconds
            if (_timeSinceLastUpdate > 0.1 && true) then {
	            private _pos = _target;
	            if (_target isEqualType objNull) then {
	            	_pos = getPosASL _target;
	            };
	            private _errorMod = _unit getVariable ['unit_suppress_distanceErrorMod',1];
	            private _distanceError = linearConversion[30,500,(_pos distance2D _unit),1,10,true];
	            _distanceError = _distanceError  * _errorMod;
	            _pos = ((_pos getpos [(random (_distanceError)),random 360]) vectorAdd [0,0,(0.5)]);
	            _pos set [2, 0.5+(random 2.5)];

				_unit doWatch _pos;
				_unit lookAt _pos;

				private _pad = _unit getVariable ['unit_suppress_pad',objNull];
				if (isNull _pad) then {
					_pad = 'Land_HelipadEmpty_F' createVehicleLocal [0,0,0];
					_unit setVariable ['unit_suppress_pad',_pad];
				};
				_pad setposATL _pos;
				_unit doTarget _pad;
            	_unit setVariable ['unit_suppress_lastUpdate',CBA_Missiontime];
			};


			// start after watching the target
            private _startAt = _unit getVariable 'unit_suppress_startAt';
            if (isNil '_startAt') exitWith {
				_unit setVariable ['unit_suppress_startAt',CBA_Missiontime + (0.5 + random 0.5)];
            };
            if (CBA_Missiontime < _startAt) exitWith {};
			private _weaponState = weaponState _unit;
			_unit setAmmo [_weaponState # 1, 100];
			_unit forceWeaponFire [_weaponState # 1,  _weaponState # 2];


        }, 0, [_unit,_target,_suppressFor,_suppressTimes,_suppressBreak]
    ] call CBA_fnc_addPerFrameHandler;
    _unit setVariable ['unit_suppress_handle',_handle];
};

// suppression logic / FSM
[] spawn {
	private _group = ten_inf_1;
	sleep 6;

	private _targets = allPlayers select {_x inArea [ten_target,300,300,0,false]};
	if (_targets isEqualTo []) exitWith {};
	{
		private _target = selectRandom _targets;
		private _arr = selectRandom [
			[_x,_target,true,(3 + random 3),14,(0.3 + random 1)],
			[_x,_target,true,(15 + random 15),4,(5 + random 5)],
			[_x,_target,true,(5 + random 15),8,(3 + random 5)]
		];
		_arr call ten_fnc_suppress;

		_x disableAI "PATH";
		_x setVariable ['unit_suppress_distanceErrorMod',50];
		_x setSkill ['aimingAccuracy',0.3];
		_x setSkill ['aimingSpeed',0.5];

		false
	} count units _group;

	_group setSpeedMode 'FULL';

	sleep 20;
	{
		_x setVariable ['unit_suppress_distanceErrorMod',10];
		false
	} count units _group;

	// move in first attack wave
	attack_1 setPos (getpos town_1);

	sleep 40;
	{
		_x setVariable ['unit_suppress_distanceErrorMod',5];
		false
	} count units _group;

	sleep 180;
	//sleep 300;
};