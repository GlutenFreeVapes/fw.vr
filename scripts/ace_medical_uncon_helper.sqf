//--- Ace Medical unconsicous helper info
// Tells unconsious players that they are being helped
// credits: g4rrus
{
    ["ace_medical_treatment_" + _x, {
        if (lifeState ace_player == "INCAPACITATED") then {
            titleText ["<t color='#FFBA26' size='2'>Someone is helping you!</t>","PLAIN",1,true,true];
        };
    }] call CBA_fnc_addEventHandler;
} foreach ["bandageLocal","cprLocal","ivBagLocal","medicationLocal","splintLocal","tourniquetLocal"];
