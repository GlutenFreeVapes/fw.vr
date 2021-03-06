/* ----------------------------------------------------------------------------
Function: respawn_round_fnc_update

Description:
	updates the sides

Parameters:
	none
Returns:
	_activeseids		- array of sides that are active
Examples:
	call respawn_round_fnc_update;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};

// Update variables every round

// sides
private _sides = + (missionNamespace getVariable ["mission_respawn_round_sides",RESPAWN_ROUND_SETTING_SIDES]);
private _sidesAmount = (count _sides); //missionNamespace getVariable ["mission_respawn_round_sidesAmount",RESPAWN_ROUND_SETTING_SIDESAMOUNT];

// locked sides
private _lockedSide = missionNamespace getVariable ['mission_respawn_round_sidesLocked',RESPAWN_ROUND_SETTING_SIDELOCKED];
private _lockedNames = [];

// check for locked
private _nil = {
	private _name = _x param [0,''];
	private _hide = _x param [3,false];
	if (_hide) then {
		_lockedNames pushBackUnique (toLower _name);
	};
	false
} count _lockedSide;


// initialize activesides array
private _sidesActive = missionNamespace getVariable "mission_respawn_round_sides_active";
if (isNil '_sidesActive') then {
	_sidesActive = [];
	missionNamespace setVariable ["mission_respawn_round_sides_active",_sidesActive];
};

private _availableUnits = (allUnits + allDeadMen) select {isPlayer _x && {!(_x isKindOf "HeadlessClient_F")}};
private _currentSides = [];

// update sides
// loop through all sides
for '_i' from 1 to _sidesAmount do {
	if (_sides isEqualTo []) exitWith {};
	private _sideArr = _sides deleteAt 0;
	private _sideName = _sideArr deleteAt 0;
	private _sideUnits = [];

	// check if sidename in lockednames
	if ((toLower _sideName) in _lockedNames) exitWith {};

	// loop through current side elements (units)
	private _nil = {
		private _member = _x;
		call {

			// if side is a side, add all units from that side
			if (_member isEqualType west) exitWith {

				// add all the units with matching side
				_sideUnits append (_availableUnits select {(_x call respawn_fnc_getSetUnitSide) isEqualTo _member});

				// remove used units from available units
				_availableUnits = _availableUnits - _sideUnits;
			};

			// if it's not a side, then it's a string (let's check it's value[unit/group])
			_member = missionNamespace getVariable [_member,objNull];

			// if nothing found, exit
			if (_member isEqualTo objNull) exitWith {};

			// if it's a group. Add all units from that group
			if (_member isEqualType grpNull) exitWith {

				// add all the units with matching group
				_sideUnits append (_availableUnits select {(group _x) isEqualTo _member});

				// remove used units from available units
				_availableUnits = _availableUnits - _sideUnits;

			};

			// add the unit to this group
			if (_member isEqualType objNull) exitWith {

				// add the matching unit
				_sideUnits pushBack (_availableUnits deleteAt (_availableUnits find _member));
			};
		};
		false
	} count _sideArr;


	private _side = [];
	private _found = false;
	{
		if ((_x param [0,'']) isEqualTo _sideName) exitWith {
			//_side = _sidesActive deleteAt _forEachIndex;
			_side = _x;
			_found = true;
		};
	} forEach _sidesActive;

	// add/update name and units
	_side set [0,_sideName];
	_side set [1,_sideUnits];

	private _sideData = _side param [2];
	if (isNil '_sideData') then {
		_sideData = [];
		_side set [2,_sideData];
	};

	// add site variable to units on the side
	private _nil = {
		_x setVariable ['unit_respawn_round_side',_sideName,true];
		false
	} count _sideUnits;

	// if there side units array is not empty, add the side to current sides
	//if !(_sideUnits isEqualTo []) then {
	if !(_found) then {
		_sidesActive pushBack _side;

		// add the side number
		_sideData set [0,_i];
	};
};

missionNamespace setVariable ["mission_respawn_round_sides_active",_sidesActive,true];
// return active sides
_sidesActive