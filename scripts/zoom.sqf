//--- ZOOM penalty
// penaltize players for zooming
// credits: GlutenFreeVapes
if (hasInterface) then {
    // create zoom CC and return it
    zoom_fnc_cc_create = {
        private _zoom_CC_handle = missionNamespace getVariable ['mission_zoom_cc_handle',30000];
        if (ppEffectEnabled _zoom_CC_handle) exitWith {_zoom_CC_handle};
        call {

            private _priority = 30000;
            for '_i' from 0 to 1 step 0 do {
                if (ppEffectEnabled _zoom_CC_handle) exitWith {};
                _zoom_CC_handle = ppEffectCreate ['ColorCorrections',_priority];
                _priority = _priority + 1;
                _zoom_CC_handle ppEffectEnable true;
            };
            missionNamespace setVariable ['mission_zoom_cc_handle',_zoom_CC_handle];
        };
        _zoom_CC_handle
    };


    // create zoom dynamic blur and return it
    zoom_fnc_db_create = {
        private _zoom_db_handle = missionNamespace getVariable ['mission_zoom_db_handle',800];
        if (ppEffectEnabled _zoom_db_handle) exitWith {_zoom_db_handle};
        call {

            private _priority = 800;
            for '_i' from 0 to 1 step 0 do {
                if (ppEffectEnabled _zoom_db_handle) exitWith {};
                _zoom_db_handle = ppEffectCreate ['DynamicBlur',_priority];
                _priority = _priority + 1;
                _zoom_db_handle ppEffectEnable true;
            };
            missionNamespace setVariable ['mission_zoom_db_handle',_zoom_db_handle];
        };
        _zoom_db_handle
    };

    // reads value for the name from config, if no value found runs code and saves the return into the value
    zoom_fnc_readCache = {
        params ['_name','_code',['_params',[]]];

        private _value = mission_zoom_cache getVariable _name;
        if (!isNil '_value') exitWith {_value};
        _value = _params call _code;
        mission_zoom_cache setVariable [_name,_value];
        _value
    };

    // find the max zoom on the curren weapon(highest initzoom)
    zoom_fnc_maxZoom = {
        private _items = call {
            private _weapon = currentWeapon player;
            if (_weapon isEqualTo primaryWeapon player) exitWith {
                primaryWeaponItems player;
            };
            if (_weapon isEqualTo secondaryWeapon player)  exitWith {
                secondaryWeaponItems player;
            };
            if (_weapon isEqualTo handgunWeapon player)  exitWith {
                handgunItems player;
            };
            []
        };
        private _maxZoom = 1;
        if !(currentWeapon player isEqualTo '') then {
            _maxZoom = [(currentWeapon player),{(getNumber (configFile >> 'CfgWeapons' >> (currentWeapon player) >> 'opticsZoomInit'))}] call zoom_fnc_readCache;
        };
        {
            private _item = _x;
            if (_item != '') then {
                private _zoom = [_item,{
                    private _modes = ('true' configClasses (configFile >> 'CfgWeapons' >> _this >> 'ItemInfo' >> 'OpticsModes'));
                    private _maxZoom = 1;
                    {
                        private _zoom = getNumber(_x >> "opticsZoomInit");
                        if (_zoom < _maxZoom && _zoom != 0) then {_maxZoom = _zoom};
                    } count _modes;
                    _maxZoom
                },_item] call zoom_fnc_readCache;
                if (_zoom < _maxZoom && _zoom != 0) then {_maxZoom = _zoom};
            };
            false
        } count _items;
        _maxZoom
    };


    // add a mouse button up event to determine when the player has stopped pressing RMB
    zoom_fnc_onMouseUp = {
        params ["_displayorcontrol", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];


        // exit if not RMB
        if !(_button isEqualTo 1) exitWith {};

        // exit if in a scope
        if (cameraView isEqualTo 'GUNNER') exitWith {};

        missionNamespace setVariable ['mission_zoom_timeRMBUp',CBA_Missiontime];
    };

    (findDisplay 46) displayAddEventHandler ['mouseButtonUp',{call zoom_fnc_onMouseUp}];
    // to run each frame
    zoom_fnc_eachFrame = {
        private _nextCheck = missionNamespace getVariable ['mission_zoom_nextCheck',CBA_Missiontime];
        if (CBA_Missiontime < _nextCheck) exitWith {
            //systemChat ('t:' + str CBA_Missiontime + ' n:' + str _nextCheck);
        };
        private _disabledFor = 0.10;

        private _v = velocityModelSpace player;
        private _speed = ((abs(_v select 0)) + (abs (_v select 1)));
        private _maxBlur = linearConversion [0,6,_speed,0.2,2,true];

        private _zoom = (call CBA_fnc_getFov) select 1;
        call {
            // exit if zoom is less than 1.2 (no need to evaluate)
            if (_zoom <= 1.2) exitWith {};

            // zoom 0 if camera not on player or player in vehicle
            if ( (cameraOn != player) || !(isNull objectParent player)) exitWith {
                _zoom = 0;
                _disabledFor = 1;
            };


            // make sure camera is near my face
            if !((positionCameraToWorld [0,0,0]) inArea [(player modelToWorldVisual (player selectionPosition ["head",'Memory'])),0.5,0.5,0,false,0.5]) exitWith {
                _zoom = 0;
                _disabledFor = 1.5;
            };

            // if the RMB was released just now, pause
            if ((CBA_Missiontime - (missionNamespace getVariable ['mission_zoom_timeRMBUp',0])) < 0.2) exitWith {
                _zoom = 0;
                _disabledFor = 0.2;
            };
            //systemChat str ((CBA_Missiontime - (missionNamespace getVariable ['mission_zoom_timeRMBUp',0])));

            // exit if not in a scope
            if (cameraView != 'GUNNER') exitWith {};

            // if the speeed is high maxblur is high. This means player is moving so he will get blurred (because he is scoped)
            if (_maxBlur > 0.6) exitWith {};

            // zoom 0 if using binocs
            if (currentWeapon player isEqualTo binocular player) exitWith {
                _zoom = 0;
                _disabledFor = 1.5;
            };



            private _maxZoom = call zoom_fnc_maxZoom;

            // zoom 0 if max zoom for optics is < 0.2
            if (_maxZoom < 0.2) exitWith {
                _zoom = 0;
                _disabledFor = 1;
            };
        };


        private _coef = linearConversion [1.2,3,_zoom,1.5,0,true];
        private _blur = linearConversion [1.2,3,_zoom,0,_maxBlur,true];
        private _ccArr = [
            0.0, 0.0, 0.0,
            [
                0, 0, 0, 1
            ], [
                1, 1, 1, 0
            ], [
                1, 1, 1, 0
            ],[
                0.9,0.6,0,0,0,(_coef + random 0.1),1.0
            ]
        ];

        private _cc = missionNamespace getVariable ['mission_zoom_cc_handle',30000];
        private _db = missionNamespace getVariable ['mission_zoom_db_handle',800];

        // run the shake based on the current blur
        [_blur] call zoom_fnc_shake;

        if ((getStamina player) <= 15) then {
            private _mod = linearConversion [15,0,(getStamina player),1,2,true];
            //private _mod = ((getStamina player) / (15 * 0.01)) * 0.01;
            //_blur = _blur + (1 - _mod);
            //systemChat ('b:' + str _blur + ' m:' + str _mod);
            _blur = _blur * _mod;
        };


        _cc ppEffectAdjust _ccArr;
        _cc ppEffectCommit 0.1;

        _db ppEffectAdjust [_blur];
        _db ppEffectCommit 0.1;


        //[_blur] call zoom_fnc_stamina;

        missionNamespace setVariable ['mission_zoom_currentZoom', _blur];


        missionNamespace setVariable ['mission_zoom_nextCheck',CBA_Missiontime + _disabledFor];
    };

    zoom_fnc_staminaHandler = {
        private _currentZoom = missionNamespace getVariable ['mission_zoom_currentZoom',0];
        if (_currentZoom >= 0.05) then {
            [_currentZoom] call zoom_fnc_stamina;
        };
        missionNamespace setVariable ['mission_zoom_lastStaminaTime',cba_missiontime];
    };

    zoom_fnc_stamina = {
        private _coef = _this param [0];
        private _stamina = getStamina player;

        // calculate deltatiem
        private _lastStaminaTime = missionNamespace getVariable ['mission_zoom_lastStaminaTime', cba_missiontime];
        private _deltaTime = cba_missiontime - _lastStaminaTime;

        // get the amount that stamina shoudl change this tick
        private _staminaChange = 0;
        if (_coef > 0.2) then {
            _staminaChange = ((linearConversion [1,0.2,_coef,6,5,true])* _deltaTime);
        } else {
            _staminaChange = ((linearConversion [0.2,0,_coef,5,0,true])* _deltaTime);
        };

        player setStamina ((_stamina - _staminaChange) max 0);
    };

    zoom_fnc_shake = {
        params ['_size'];

        private _stamina = getStamina player;
        if (_stamina >= 20) exitWith {};
        private _coef = 0;
        if (_stamina > 5) then {
            _coef = linearConversion [20,7.5,_stamina,0,0.35];
        } else {
            _coef = linearConversion [7.5,0,_stamina,0.35,1];
        };
        addCamShake
        [
            (_size * (10 * _coef)),      // Power 1.0
            0.1,                // Duration
            1                   // Frequency
        ];

        private _originalAimCoef = player getVariable ['unit_zoom_originalAimCoef',-69];
        if (_originalAimCoef isEqualTo -69) then {
            _originalAimCoef = getCustomAimCoef player;
            player setVariable ['unit_zoom_originalAimCoef',_originalAimCoef];
        };
        player setCustomAimCoef (_originalAimCoef + (linearConversion [1,0,(_size * _coef),20,0,true]));
    };

    // init
    zoom_fnc_init = {

        // cache namespace
        private _cache = missionNamespace getVariable ['mission_zoom_cache',locationNull];
        if (isNull _cache) then {
            _cache = call CBA_fnc_createNamespace;
            missionNamespace setVariable ['mission_zoom_cache',_cache];
        };

        // create effects
        private _cc = call zoom_fnc_cc_create;
        private _db = call zoom_fnc_db_create;

        private _zoom_draw3d_handle = missionNamespace getVariable ['mission_zoom_draw3d_handle',nil];
        if (isNil '_zoom_draw3d_handle') then {
            _zoom_draw3d_handle = addMissionEventHandler ["Draw3D", {call zoom_fnc_eachFrame;}];
        };
        missionNamespace setVariable ['mission_zoom_draw3d_handle',_zoom_draw3d_handle];


        private _zoom_stamina_handle = missionNamespace getVariable ['mission_zoom_stamina_handle',nil];
        if (isNil '_zoom_stamina_handle') then {
            _zoom_stamina_handle = addMissionEventHandler ["EachFrame", {call zoom_fnc_staminaHandler;}];
        };
        missionNamespace setVariable ['mission_zoom_stamina_handle',_zoom_stamina_handle];
    };

    call zoom_fnc_init;
};
