/* ----------------------------------------------------------------------------
Function: loot_fnc_findLoot

Description:
	Finds what loot should be spawned based on priority
	Loot tables are in this file

Parameters:
0:	_lootCat				- What category of loot? 'military', 'residential', 'industrial'

Returns:
	Array of spawnable loot
Examples:
	// used in loot_fnc_create
	[5] call loot_fnc_findLoot;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params [['_lootCat','default']];

// todo add per house variable

// here test test test
private _priority = 3;

private _lootTables = missionNamespace getVariable ['mission_loot_tables',[]];

// if no loot table found, use default one:
if (_lootTables isEqualTo []) then {
	_lootTables = [

		// military
		[
			// items
			['item',[5,0.5,5,4],'H_HelmetHBK_headset_F'],
			['item',[3,0.25,5,4],'H_HelmetAggressor_F'],
			['item',[5,0.27,5,3],'ACE_NVG_Gen1'],
			['item',[30,0.4,3,4],'H_HelmetSpecB_wdl'],
			['item',[1,0.35,4,4],'H_Hat_Tinfoil_F'],
			['item',[30,0.7,3,4],'H_Booniehat_wdl'],

			['item',[25,0.35,5,12],'V_SmershVest_01_F'],
			['item',[20,0.3,5,12],'V_CarrierRigKBT_01_heavy_EAF_F'],
			['item',[25,0.4,5,9],'V_PlateCarrierSpec_wdl'],
			['item',[25,0.3,5,12],'V_CarrierRigKBT_01_light_EAF_F'],
			['item',[25,0.4,5,9],'V_PlateCarrier1_wdl'],
			['item',[25,0.2,5,13],'V_CarrierRigKBT_01_EAF_F'],
			['item',[30,0.2,2,12],'V_CarrierRigKBT_01_Olive_F'],


			['mag',[30,0.5,5,3],'rhs_mag_m67'],
			['item',[5,0.6,5,5],'APERSTripMine_Wire_Mag'],
			['item',[10,0.6,5,5],'DemoCharge_Remote_Mag'],
			['item',[50,0.7,5,2],'acc_flashlight'],
			['item',[50,0.7,5,2],'optic_arco_ak_blk_f'],
			['item',[50,0.7,5,2],'optic_holosight_blk_f'],
			['item',[150,0.8,6,1],'ACE_fieldDressing'],
			['item',[150,0.8,7,1],'ACE_morphine'],
			['item',[150,0.8,8,1],'ACE_epinephrine'],

			// magazines
			['mag',[150,0.7,8,2],'30Rnd_762x39_AK12_Mag_F'],
			['mag',[100,0.6,5,2],'1Rnd_HE_Grenade_shell'],
			['mag',[100,0.5,5,2],'6Rnd_12Gauge_Pellets'],
			['mag',[200,0.7,8,2],'30rnd_762x39_AK12_Lush_Mag_F'],
			['mag',[100,0.7,8,2],'30Rnd_65x39_caseless_msbs_mag_Tracer'],
			['mag',[100,0.7,8,2],'30Rnd_65x39_caseless_msbs_mag'],
			['mag',[10,0.5,8,3],'75rnd_762x39_AK12_Mag_Tracer_F'],
			['mag',[3,0.3,5,4],'RPG7_F'],
			['mag',[10,0.4,8,4],'200Rnd_65x39_cased_Box_Tracer'],

			// weapons
			// weapon / weapon mag array / weapon attachment array
			['kit',[50,0.10,8,7],'arifle_AK12U_F',[['30Rnd_762x39_AK12_Mag_F',2]]],
			['kit',[25,0.11,5,8],'arifle_AK12_lush_F',[['30rnd_762x39_AK12_Lush_Mag_F']],['acc_flashlight']],
			['kit',[30,0.13,6,8],'arifle_MSBS65_F',[['30Rnd_65x39_caseless_msbs_mag_Tracer',2]]],
			['kit',[5,0.09,7,9],'arifle_MSBS65_GL_F',[['30Rnd_65x39_caseless_msbs_mag'],['1Rnd_HE_Grenade_shell',3]]],
			['kit',[5,0.09,6,9],'arifle_MSBS65_UBS_camo_F',[['30Rnd_65x39_caseless_msbs_mag'],['6Rnd_12Gauge_Pellets',3]]],
			['kit',[1,0.04,5,15],"launch_RPG7_F",[["RPG7_F",3]]],
			['kit',[3,0.07,5,7],'LMG_Mk200_black_F',[['200Rnd_65x39_cased_Box_Tracer']]],
			['kit',[2,0.06,5,13],"arifle_RPK12_F",[["75rnd_762x39_AK12_Mag_Tracer_F",2],["75rnd_762x39_AK12_Mag_F",1]]],

			// bags
			['bag',[50,0.3,4,14],'B_AssaultPack_eaf_F'],
			['bag',[50,0.3,2,13],'B_Carryall_wdl_F']
		],

		// residential
		[
			// items
			['item',[30,0.7,4,5],'V_HarnessO_gry'],


			['mag',[350,0.8,2,2],'ACE_HandFlare_Green'],
			['mag',[350,0.8,2,2],'ACE_HandFlare_Red'],
			['mag',[300,1.0,3,1],'ACE_Chemlight_HiRed'],
			['item',[50,0.7,4,2],'ACE_Flashlight_XL50'],
			['item',[150,0.7,4,2],'acc_flashlight_pistol'],
			['item',[150,0.8,6,1],'ACE_fieldDressing'],
			['item',[150,0.8,7,1],'ACE_morphine'],
			['item',[150,0.8,8,1],'ACE_epinephrine'],
			['item',[300,0.1,8,1],'ACE_Banana'],

			// magazines
			['mag',[350,1.15,3,0.5],'rhsusf_mag_17Rnd_9x19_FMJ'],
			['mag',[150,0.9,5,2],'rhsusf_8Rnd_00Buck'],
			['mag',[150,0.8,5,2],'hlc_10rnd_12g_buck_S12'],

			// weapons
			// weapon / weapon mag array / weapon attachment array
			['kit',[60,0.13,2,8],"rhs_weap_M590_8RD",[["rhsusf_8Rnd_00Buck",8]]],
			['kit',[40,0.10,4,7],'hlc_rifle_saiga12k',[['hlc_10rnd_12g_buck_S12'],['hlc_10rnd_12g_slug_S12']]],
			['kit',[100,0.30,5,4],'rhsusf_weap_glock17g4',[['rhsusf_mag_17Rnd_9x19_JHP']]],

			// bags
			['bag',[50,0.3,1,10],'B_AssaultPack_blk'],
			['bag',[50,0.3,3,10],'B_AssaultPack_mcamo']
		],

		// industrial
		[
			// items
			['item',[80,0.7,4,5],'V_HarnessO_gry'],

			['mag',[250,0.8,2,2],'ACE_HandFlare_Green'],
			['mag',[250,0.8,2,2],'ACE_HandFlare_Red'],
			['mag',[250,1.0,3,1],'ACE_Chemlight_HiRed'],
			['item',[50,0.7,4,2],'ACE_Flashlight_XL50'],
			['item',[15,0.5,5,5],'DemoCharge_Remote_Mag'],
			['item',[50,1.15,5,1],'ACE_CableTie'],
			['item',[300,0.1,8,1],'ACE_Banana'],
/*
			// magazines
			['mag',[250,1.1,3,0.5],'rhsusf_mag_17Rnd_9x19_FMJ'],
			['mag',[150,0.8,5,2],'hlc_10rnd_12g_buck_S12'],
			['mag',[150,0.7,5,2],'rhs_30Rnd_545x39_AK_green'],
			['mag',[200,0.7,5,2],'hlc_30Rnd_762x39_t_ak'],

			// weapons
			// weapon / weapon mag array / weapon attachment array
			['kit',[50,0.10,4,7],'rhs_weap_akms',[['hlc_30Rnd_762x39_t_ak']]],
			['kit',[30,0.13,2,8],"rhs_weap_M590_8RD",[["rhsusf_8Rnd_00Buck",8]]],
			['kit',[50,0.11,5,9],'rhs_weap_akm',[['hlc_30Rnd_762x39_t_ak']],['rhs_acc_2dpZenit']],
			['kit',[40,0.1,4,8],"rhs_weap_aks74u",[["rhs_30Rnd_545x39_AK_green"]]],
*/
			// bags
			['bag',[50,0.5,1,10],'B_AssaultPack_blk'],
			['bag',[50,0.5,3,10],'B_AssaultPack_mcamo']
		]
	];

	// amout left / chance / priority / cost

	{
		{
			_x#1 set [0, (_x#1#0)*10];
		} forEach _x;
	} forEach _lootTables;
};

private _lootTable = call {
	if (_lootCat isEqualTo 'military') exitWith {
		_priority = 13;
		_lootTables # 0
	};
	if (_lootCat isEqualTo 'residential') exitWith {
		_priority = 8;
		_lootTables # 1

	};
	if (_lootCat isEqualTo 'industrial') exitWith {
		_priority = 5;
		_lootTables # 2
	};
	_lootTables # 1;
};

_lootTable = _lootTable call BIS_fnc_arrayShuffle;

private _weights = _lootTable apply {
	private _lootArr = (_x param [1,[]]);
	private _weight = _lootArr param [1,0.5];
	private _weightMod = _lootArr param [2,3];
	(_weight * (1 max (abs(_weightMod - _priority))))
};

private _toSpend = (random (_priority * 6));

private _returnArray = [];

while {_toSpend > 0} do {

	private _loot = _lootTable selectRandomWeighted _weights;
	call {

		if (_loot isEqualTo []) exitWith {
			_toSpend = _toSpend - 1;
		};


		_loot params [['_type','item'],['_lootArr',[]],['_class',''],['_mags',[]],['_attachments',[]]];
		_lootArr params [['_amount',0],['_weight',0.5],['_weightMod',3],['_cost',5]];

		if (_amount <= 0) exitWith {

			// delete the loot from the table
			private _index = _lootTable find _loot;
			_lootTable deleteAt _index;
			_weights deleteAt _index;
		};

		_amount = _amount - 1;
		_lootArr set [0,_amount];


		if (_toSpend < _cost) exitWith {
			_toSpend = _toSpend - 0.5;
		};

		_toSpend = _toSpend - _cost;

		if (_type isEqualTo 'kit') then {
			_returnArray pushBack ['gun',_class];
			if !(_mags isEqualTo []) then {
				{
					_x params ['_mag',['_max',6]];
					for '_i' from 0 to ceil(random _max) do {
						_returnArray pushBack ['mag',(_mag)];
					};
					false
				} count _mags;
			};
			if !(_attachments isEqualTo []) then {
				{
					_returnArray pushBack ['item',(_x)];
					false
				} count _attachments;
			};
		} else {

			_returnArray pushBack [_type,_class];
		};
	};

	// always remove 2 to make sure the loop doesn't go on forever.
	_toSpend = _toSpend - 2;
};
call {
	if (_lootCat isEqualTo 'military') exitWith {
		_lootTables set [0, _lootTable];
	};
	if (_lootCat isEqualTo 'residential') exitWith {
		_lootTables set [1, _lootTable];
	};
	if (_lootCat isEqualTo 'industrial') exitWith {
		_lootTables set [2, _lootTable];
	};
	_lootTables set [1,_lootTable];
};

// save loot table
missionNamespace setVariable ['mission_loot_tables',_lootTables];

_returnArray