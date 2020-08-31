//--- Start car lights
// starts the car lights at mission start
// credits: GlutenFreeVapes
// start car lights (at start)
[] spawn {
    sleep 3;
    if (cba_missiontime > 30) exitWith {};

    private _cars = player nearObjects ['car',150];
    {
        player action ["LightOn", _x];
        false
    } count _cars;
};
