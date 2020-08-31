/* ----------------------------------------------------------------------------
Function: casualty_cap_fnc_postInit

Description:
	Runs the loop on the server and does everything casualty cap does

Parameters:
	none
Returns:
	nothing
Examples:
	call casualty_cap_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// server only
if !(isServer) exitWith {};

// TODO FUNCTION to process the sides which have this running
// - Make a task describing the situation and conditions
// - Make a sub-task for RETREAT/SUDDEN DEATH/LAST STAND
//		- This will activate once the condition to fail has been reached
//		- Will last for 3 minutes
//		- Gives the last remaining players a chance to do something spectacular before the mission is ended
//		- end the mission after the time has passed


// function to check a side for failure
casualty_cap_fnc_taskCondition = {
	params ['_side'];


	private _sides = missionNamespace getVariable ["mission_casualty_cap_sides",CASUALTY_CAP_SETTING_SIDES];
	private _empty = missionNamespace getVariable ["mission_casualty_cap_empty",CASUALTY_CAP_SETTING_EMPTY];
	private _percentage = missionNamespace getVariable ["mission_casualty_cap_limit",CASUALTY_CAP_PARAM_LIMIT];
	_percentage = _percentage * 10;

	// checkside needs to be an array
	if !(_side isEqualType []) then {
		_side = [_side];
	};

	// Get all players on the side
	private _players = (allPlayers - (entities "HeadlessClient_F")) select {(_x call respawn_fnc_getSetUnitSide) in _side};
	//_players = ((playableUnits + switchableUnits + allDeadMen) select {(_x call respawn_fnc_getSetUnitSide) in _side});

	// Check if empty should end it and if it's empty
	if (_empty && {_players isEqualTo []}) exitWith {
		//_side call _endMission;
		true
	};

	// Get count of alive and dead people
	private _playerCount = count _players;
	private _deadCount = {_x call respawn_fnc_deadCheck} count _players;
	//_deadCount = {!alive _x} count _players;

	//systemChat (str _playerCount + " - " + str _deadCount);

	// Check the percentage of dead dudes
	if (_playerCount > 0 && {(100/_playerCount)*_deadCount >= _percentage}) exitWith {
		//_side call _endMission;
		true
	};

	false
};
casualty_cap_fnc_endMission = {
	params ['_side'];

	// side needs to be an array
	if !(_side isEqualType []) then {
		_side = [_side];
	};

	private _winSides = [west,east,resistance,civilian] - _side;
	missionNamespace setVariable ["mission_tasks_winSides",_winSides,true];
	missionNamespace setVariable ['tasks_setting_ending_lose', 'end_15', true];

	call tasks_fnc_endSrv;
};

// make tasks for all factions which need it
call {

	// getvariables
	private _sides = missionNamespace getVariable ["mission_casualty_cap_sides",CASUALTY_CAP_SETTING_SIDES];
	private _empty = missionNamespace getVariable ["mission_casualty_cap_empty",CASUALTY_CAP_SETTING_EMPTY];
	private _percentage = missionNamespace getVariable ["mission_casualty_cap_limit",CASUALTY_CAP_PARAM_LIMIT];




	{
		private _side = _x;
		private _sidesStr = call {
			if (_side isEqualTo west) exitWith {
				'west'
			};
			if (_side isEqualTo east) exitWith {
				'east'
			};
			if (_side isEqualTo resistance) exitWith {
				'resistance'
			};
			if (_side isEqualTo civilian) exitWith {
				'civilian'
			};
			'west'
		};

		[("task_casulaty_cap_" + _sidesStr),[_side,[],
		[("Losing more than " + str (_percentage*10) + "% of the forces will result in mission failure."),
		"Casualty Cap"],
		[],"meet"],
		3,
		[{true},{
			false
		},
			compile (_sidesStr + " call casualty_cap_fnc_taskCondition")],
		[{
		},{
		},
			compile ("[] spawn {uiSleep 1;missionNamespace setVariable ['mission_casualty_cap_end_active_" + _sidesStr + "',true,true];};")
		,false]
		] call tasks_fnc_add;

		[("task_casulaty_cap_end_" + _sidesStr),[_side,[("task_casulaty_cap_" + _sidesStr)],
		[("Our forces have suffered too many casualties. We are combat ineffective. There is no coming back from this, the mission is forefit in 1 minute."),
		"Sudden Death"],
		[],"exit"],
		3,
		[
			compile ("missionNamespace getVariable ['mission_casualty_cap_end_active_" + _sidesStr + "',false]")
		,{
			false
		},
			compile ("(CBA_MissionTime - (missionNamespace getVariable ['mission_casualty_cap_end_time_" + _sidesStr + "',CBA_MissionTime])) >= 60")
		],
		[
			compile ("missionNamespace setVariable ['mission_casualty_cap_end_time_" + _sidesStr + "',CBA_MissionTime,true];"),
			compile (_sidesStr + " call casualty_cap_fnc_endMission;"),
			compile (_sidesStr + " call casualty_cap_fnc_endMission;"),
			false
		]
		] call tasks_fnc_add;
	} forEach _sides;
};

[] spawn {
	if (true) exitWith {};

	// wait until game has actually started
	sleep 10;

	// tiny local function, used twice, it ends the mission
	private _endMission = {
		private _side = _this;
		private _wavesLeft = false;
		call {
			private _nil = {
				private _wavesVar = format ["respawn_wave_count_%1",_x];
				private _availableWaves = missionNamespace getVariable [_wavesVar,0];
				if ("respawn_wave" in mission_plugins && {_availableWaves > 0}) exitWith {
					_wavesLeft = true;
					false
				};
				false
			} count _side;

		};
		if (_wavesLeft) exitWith {};

		private _winSides = [west,east,resistance,civilian] - _side;
		missionNamespace setVariable ["mission_tasks_winSides",_winSides,true];
		call tasks_fnc_endSrv;
		casualty_cap_stop = false;
	};

	// wait until there's atleast 1 player
	waitUntil {!(PLAYERLIST isEqualTo [])};

	// loop
	while {isNil "casualty_cap_stop"} do {

		// getvariables
		private _sides = missionNamespace getVariable ["mission_casualty_cap_sides",CASUALTY_CAP_SETTING_SIDES];
		private _empty = missionNamespace getVariable ["mission_casualty_cap_empty",CASUALTY_CAP_SETTING_EMPTY];
		private _percentage = missionNamespace getVariable ["mission_casualty_cap_limit",CASUALTY_CAP_PARAM_LIMIT];

		// if percentage is 0, it's disabled for 10 seconds
		if (_percentage isEqualTo 0) then {
			sleep 10;
		} else {
			_percentage = _percentage * 10;

			// loop through sides
			private _nil = {
				private _checkSide = _x;

				// checkside needs to be an array
				if !(_checkSide isEqualType []) then {
					_checkSide = [_checkSide];
				};

				// Get all players on the side
				private _players = (allPlayers - (entities "HeadlessClient_F")) select {(_x call respawn_fnc_getSetUnitSide) in _checkSide};

				// Check if empty should end it and if it's empty
				if (_empty && {_players isEqualTo []}) exitWith {
					_checkSide call _endMission;
				};

				// Get count of alive and dead people
				private _playerCount = count _players;
				private _deadCount = {_x call respawn_fnc_deadCheck} count _players;

				// Check the percentage of dead dudes
				if (_playerCount > 0 && {(100/_playerCount)*_deadCount >= _percentage}) exitWith {
					_checkSide call _endMission;
				};

				false
			} count _sides;
		};

		// small sleep, because it might be the difference of win/lose
		sleep 0.1;
	};

};