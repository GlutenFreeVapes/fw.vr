/* ----------------------------------------------------------------------------
Function: revive_fnc_onBodyBag

Description:
	saves the unit that died for reviveing

Parameters:
0:	_unit		- unit that will be bagged
1:	_bag		- the bag

Returns:
	nothing
Examples:
	call revive_fnc_onBodyBag;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit",'_bag'];

private _newUnit = _unit getVariable ['unit_revive_newUnit',objNull];
private _canBeRevived = _unit getVariable ['unit_revive_canBeRevived',false];
private _lastGun = _unit getVariable ['unit_revive_lastGun',''];
private _lastLoadout = _unit getVariable ['unit_revive_oldLoadoutKilled',(getUnitLoadout _unit)];
	//_oldUnit setUnitLoadout (_oldUnit getVariable ['unit_revive_oldLoadoutKilled',[]]);

_bag setVariable ['unit_revive_canBeRevived',_canBeRevived,true];
_bag setVariable ['unit_revive_newUnit',_newUnit,true];
_bag setVariable ['unit_revive_oldLoadout',_lastLoadout,true];
_bag setVariable ['unit_revive_lastGun',_lastGun,true];

_newUnit setVariable ['unit_revive_oldUnit',_bag,true];
