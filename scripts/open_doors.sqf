//--- Open doors
// open doors (fixes ai walkting through closed doors)
// credits: GlutenFreeVapes
[] spawn {
	sleep 1;

	// town_4 is an object
	private _houses = ((town_4 nearObjects ['House',750]) + (town_5 nearObjects ['House',750]));
	{
		this = _x;
		private _class = typeOf _x;
		private _configs = '(toLower(configName (_x))) find "open" != -1' configClasses (configFile >> 'CfgVehicles' >> _class >> 'UserActions');

		{
			private _code = getText (_x >> 'statement');
			call compile _code;
			sleep 0.01;
		} forEach _configs;
	} forEach _houses;
	this = nil;
};
