//--- Scripted mortar strike
// provdes mortar strikes in an area
// credits: GlutenFreeVapes


// has to be at least 200m high
// M_Mo_82mm_AT
_flare = 'F_20mm_Red';
// targets
private _targets = [
	// pos, time, shell, radius, height
	[(getPosATL ten_btr_1),20,'M_Mo_82mm_AT'],
	[(getPosATL ten_btr_1),25,'M_Mo_82mm_AT'],
	[(getPosATL ten_btr_1),30,'M_Mo_82mm_AT'],
	[(getPosATL ten_truck_1),40,'M_Mo_82mm_AT'],
	[[12994.1,15174.3,0],15,_flare,50,140],
	[[12994.1,15174.3,0],23,'Smoke_82mm_AMOS_White',15],

	[[13055.7,15290.9,0],38,_flare,40,100],
	[[13055.7,15290.9,0],25,'M_Mo_82mm_AT',0],
	[[13055.7,15290.9,0],26,'M_Mo_82mm_AT',5],
	[[13055.7,15290.9,0],37,'Smoke_82mm_AMOS_White',25],

	[[12963.5,15203.7,0],47,'M_Mo_82mm_AT',5],
	[[12963.5,15203.7,0],56,'M_Mo_82mm_AT',5],
	[[12963.5,15203.7,0],57,'M_Mo_82mm_AT',5],
	[[12963.5,15203.7,0],62,'Smoke_82mm_AMOS_White',5],
	[[12963.5,15203.7,0],56,_flare,50,175],

	[[12852.7,15328.5,0],80,_flare,75,140],
	[[12852.7,15328.5,0],83,_flare,75,165],
	[[12852.7,15328.5,0],86,_flare,75,185],


	[[12852.7,15328.5,0],100,_flare,75,140],
	[[12852.7,15328.5,0],103,_flare,75,165],
	[[12852.7,15328.5,0],106,_flare,75,185],

	[[12852.7,15328.5,0],130,_flare,150,140],
	[[12852.7,15328.5,0],133,_flare,150,165],
	[[12852.7,15328.5,0],136,_flare,150,185],


	[[12852.7,15328.5,0],90,_flare,75,165],
	[[12852.7,15328.5,0],130,_flare,150,165],
	[[12852.7,15328.5,0],170,_flare,150,165],
	[[12852.7,15328.5,0],210,_flare,150,165],
	[[12852.7,15328.5,0],250,_flare,150,165],
	[[12852.7,15328.5,0],290,_flare,150,165],

	[[12852.7,15328.5,0],120,_flare,150,140],
	[[12852.7,15328.5,0],123,_flare,150,165],
	[[12852.7,15328.5,0],126,_flare,150,250]
];

[_targets] spawn {
	params ['_targets'];
	for '_i' from 0 to 300 do {
		{
			_x params ['_pos','_fireAt','_shellType',['_radius',0],['_height',300]];
			if (CBA_Missiontime >= _fireAt) then {
				//systemChat ('firing mortar at: ' + str _pos + ' round: ' + _shellType);
				private _deleted = _targets deleteAt _forEachIndex;

				_pos set [2,_height];
				private _shell = createVehicle [_shellType, _pos, [], _radius, "NONE"];
				//_shell setVelocity [0,0,-10000000];

				[_shell, -90, 0] call BIS_fnc_setPitchBank;
				_shell setVelocity [0,0,100];
				_shell spawn {sleep 1;_this setVelocity [0,0,-10];};

				private _sound = selectRandom["mortar1", "mortar2"];
				[_shell,[_sound,1250]] remoteExec ["say3d"];
				//systemChat str _shell;
				last_shell = _shell;
			};
			false
		} forEach _targets;
		sleep 1;
	};
};

