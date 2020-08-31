//--- Custom squad tracker
// displays all squad memebers (except leader) on the map and shows their names when hoviner the mouse over
// credits: g4rrus
//--- squad tracker
call {

    ten_fnc_squadTracker = {
        if (!visibleMap || {(units group player - [leader group player]) isEqualTo []}) exitWith {};
        private _map = _this#0;
        {
            private _color = assignedTeam _x call {
                if (_this == "RED") exitwith {[1,0,0,1]};
                if (_this == "GREEN") exitwith {[0,1,0,1]};
                if (_this == "BLUE") exitwith {[0,0,1,1]};
                if (_this == "YELLOW") exitwith {[1,1,0,1]};
                [1,1,1,1]
            };
            private _mousePos = getMousePosition;
            private _mousePosWorld = _map ctrlMapScreenToWorld _mousePos;
            private _posUnit = getPosASL _x;
            private _name = '';
            private _dist = _posUnit distance2D _mousePosWorld;
            if (_dist < 5) then {
                _name = name _x;
            };
            private _sizeMod = linearConversion [25,1,_dist,1,1.5,true];
            private _sizeA = 20 * _sizeMod;
            private _sizeB = 16 * _sizeMod;
            (_map) drawIcon ["iconMan",[0,0,0,1],_posUnit,_sizeA,_sizeA,getDir _x];
            (_map) drawIcon ["iconMan",_color,_posUnit,_sizeB,_sizeB,getDir _x,_name,2];
        } count (units group player - [leader group player]);
    };

    [] spawn {

        if !(hasinterface) exitWith {};
        waitUntil {time > 10 && {!isNull ((findDisplay 12) displayCtrl 51)}};


        // TRACKING MAGIC /////////////////////////////////////////////////////////////////////////////////
        private _trackingEH = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",{
            call ten_fnc_squadTracker;
        }];
    };
};