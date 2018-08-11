/* ----------------------------------------------------------------------------
Function: guns_fnc_postInit

Description:
	runs everything for the guns

Parameters:
	none
Returns:
	nothing
Examples:
	call guns_fnc_postInit;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
/*
  Function: diw_unknownwp_fnc_init
  Description:
    Initiliases punish unknown weapon script
  Parameters:
    none
  Returns:
    nothing
  Author:
  diwako 2018-06-24
*/

diw_unknownwp_briefing = true;
diw_unknownwp_add_weapons = [];
diw_unknownwp_weapon_whitelist = ['SG553','SG551','SG550','ACR','M240','mk48','glock','1911','SMG_03','m72','awmagnum'];
diw_unknownwp_weapon_whitelist = diw_unknownwp_weapon_whitelist apply {toLower _x};
diw_unknownwp_jam_explosion = 5;
diw_unknownwp_reload_failure = 9;
diw_unknownwp_jamchance_add = 3.5;
diw_unknownwp_dispersion_add = 200;
diw_unknownwp_cooldown = 6;
diw_unknownwp_enable = true;


if !(diw_unknownwp_enable) exitWith {};

if !(isClass(configFile >> "CfgPatches" >> "ace_overheating")) exitWith {hintC "ACE Overheating not found! Punishing unknown weapons cannot be used!"};
if !(ace_overheating_enabled) exitWith {hintC "ACE Overheating not enabled! Punishing unknown weapons cannot be used!"};

if(missionNamespace getVariable ["diw_unknownwp_init",false]) exitWith {};
missionNamespace setVariable ["diw_unknownwp_init",true];

if !(ace_overheating_overheatingDispersion) then {systemChat "===Punishable weapons: Warning, ACE dispersion not enabled!==="};

if (isNil "diw_unknownwp_local_weapons") then {
  diw_unknownwp_local_weapons = [];
};


if !(hasInterface) exitWith {};

if(diw_unknownwp_briefing) then {
  player createDiaryRecord ["Diary", ["Picking up enemy weapons",
  "<font size='25'>Warning: Punish unknown weapons is active!</font><br/><font size='15'>Picking up unknown weapons, such as enemy weapons, will result in degraded weapon efficiency!<br/>Symptoms can be less accuracy, higher jamming chance and reload failures due to poor weapon maintenance or handling.<br/><br/>In extreme cases ammunition can misfire and cause weapon destruction and possible injury to the current user!"
  ]];
};

player addEventHandler["Fired",{
  _weapon = _this select 1;
  if(!(primaryWeapon ace_player == _weapon)) exitWith {};
  if(isNil "diw_unknownwp_weapon_whitelist") exitWith {};

  private _doneList = missionNamespace getVariable ['diw_unknownwp_weapon_donelist',[]];
  if (_weapon in _doneList) exitWith {};
  _doneList pushBack _weapon;
  missionNamespace setVariable ['diw_unknownwp_weapon_donelist',_doneList];

  private _cacheWeaponData = missionNamespace getVariable ['ace_overheating_cacheWeaponData',objNull];
  if (isNull _cacheWeaponData) exitWith {};

  private _weaponData = _cacheWeaponData getVariable _weapon;
  //if !(isNil "_weaponData") exitWith {};
  private _weaponLower = toLower(_weapon);
  if ((diw_unknownwp_weapon_whitelist findIf {(_weaponLower find _x) != -1}) != -1) exitWith {};

  // weapon not in whitelist
  if (isNil '_weaponData') then {
    _weaponData = [_weapon] call ace_overheating_fnc_getWeaponData;
  };
    /*
    * 0: dispresion <NUMBER>
    * 1: slowdownFactor <NUMBER>
    * 2: jamChance <NUMBER>
    */
  _weaponData set[0,(_weaponData#0 + diw_unknownwp_dispersion_add)];
  _weaponData set[2,(_weaponData#2 + (diw_unknownwp_jamchance_add / 100))];
  _cacheWeaponData setVariable [_weapon, _weaponData];
}];

player addEventHandler["Reloaded", {
  params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

  if(!(primaryWeapon ace_player == _weapon)) exitWith {};
  if(isNil "diw_unknownwp_weapon_whitelist") exitWith {};

  private _weaponLower = toLower(_weapon);
  if ((diw_unknownwp_weapon_whitelist findIf {(_weaponLower find _x) != -1}) != -1) exitWith {};
  // weapon not in whitelist
  if( (random 100) <= diw_unknownwp_reload_failure ) then {
    // reload failed
    ace_player addMagazine [_newMagazine#0, _newMagazine#1];
    ace_player setAmmo [_weapon, 0];

    [{["Reload failed"] call ace_common_fnc_displayTextStructured;}, []] call CBA_fnc_execNextFrame;
  };
}];

["ace_weaponJammed", {
  params["_unit","_weapon"];
  if (_unit != ace_player) exitWith {};
  if (primaryWeapon ace_player != _weapon) exitWith {};
  private _weaponLower = toLower(_weapon);
  if ((diw_unknownwp_weapon_whitelist findIf {(_weaponLower find _x) != -1}) != -1) exitWith {};

  if ((random 100) > diw_unknownwp_jam_explosion) exitWith {};
  private _model = getText(configfile >> "cfgweapons" >> _weapon >> "model");
  if ((_model find ".") == -1) then {
    _model = _model + ".p3d";
  };
  if(_model find "\" == 0) then {
    _model = [_model, 1] call CBA_fnc_substr;
  };
  private _groundHolder = createVehicle ["WeaponHolderSimulated", position ace_player, [], 0.5, "CAN_COLLIDE"];
  private _ammo = 1;
  // private _ammo = (ace_player ammo (primaryWeapon ace_player)) max 1;
  {
    _groundHolder addMagazineAmmoCargo [_x, 1, _ammo];
  } forEach (primaryWeaponMagazine ace_player);
  {
    if(_x != "") then {
      _groundHolder addItemCargoGlobal [_x,1];
    };
  } forEach (primaryWeaponItems ace_player);

  // [_groundHolder, true] remoteExec ["hideObjectGlobal", 2];
  private _dummy = createSimpleObject[_model,getPosATL ace_player];
  _dummy hideSelection ["zasleh",true];
  _dummy hideSelection ["magazine",true];
  _dummy hideSelection ["bolt",true];
  _dummy hideSelection ["magrelease",true];
  _dummy attachTo [_groundHolder,[0,0,-0.5]];

  private _dir = getdir ace_player;
  _groundHolder disableCollisionWith ace_player;
  _groundHolder setPos (ace_player modelToWorld [0.25,0.4,1.2]);
  _groundHolder setDir (_dir + 90);

  private _speed = 2.5;
  // private _speed = 1.5;
  _groundHolder setVelocity [_speed * sin(_dir), _speed * cos(_dir),1];
  ace_player removeWeapon _weapon;
  [{
    {
      deleteVehicle _x;
      false
    } count _this;
  }, [_dummy], 300] call CBA_fnc_waitAndExecute;
  playSound3D["A3\Sounds_F\arsenal\explosives\mines\Mine_closeExp_0" + str( (floor random 3) + 1 ) + ".wss",objNull,false,getPosATL ace_player,10,1,150];
  addCamShake[20,2,2];
  ["Weapon has been destroyed"] call ace_common_fnc_displayTextStructured;
  private _dam = 1;
  if(!isNil "ace_medical_fnc_addDamageToUnit") then {
    // Ace medical is enabled
    if(isPlayer ace_player) then {
      _dam = (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]) / 10;
    } else {
      private _res = ace_player getVariable ["ace_medical_unitDamageThreshold", [1, 1, 1]];
      _dam = ((_res#0 + _res#1 + _res#2) / 3) / 5;
    };
    [ace_player, _dam, selectRandom ["head", "body", "hand_l", "hand_r"], "stab"] call ace_medical_fnc_addDamageToUnit;
  } else {
    // Ace medical is not enabled
    _dam = damage ace_player;
    ace_player setDamage (_dam + 0.1);
  };
}] call CBA_fnc_addEventHandler;