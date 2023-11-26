#include "script_component.hpp"
/*
 * Author: Ampersand
 * Attaches a backpack's weaponholder to a floating helper
 *
 * Arguments:
 * 0: Weapon Holder <OBJECT>
 *
 * Return Value:
 * Float <OBJECT>
 *
 * Example:
 * [_holder] call bocr_main_fnc_floatPack;
 *
 * Public: No
 */

params ["_holder"];

// Float model is too big =/ Can't get it to be stable with a smaller model
_pos = getPosASL _holder;
_pos set [2, 0];
private _depth = ASLToATL (_pos select 2);
if (_depth < 5) exitWith {};

// Make pack float
if (isServer) then {
    private _float = QGVAR(float) createVehicle [0, 0, 0];
    _float setPosASL (getPosASL _holder vectorAdd [0, 0, -2]);
    _holder attachTo [_float, [0, 0, 1.5]];
    _holder setVariable [QGVAR(float), _float, true];

    _holder addEventHandler ["Deleted", {
        params ["_holder"];
        deleteVehicle (_holder getVariable QGVAR(float));
    }];
    _float addEventHandler ["EpeContact", {
        //params ["_object1", "_object2", "_selection1", "_selection2", "_force"];
        params ["_float", "_object2"];
        if (isNull _object2) then {
            {
                deleteVehicle _x;
            } forEach attachedObjects _float;
            deleteVehicle _float; // Delete when on ocean bottom
        };
    }];
};

if (hasInterface) then {
    _holder addaction ["Discard", {
        // Make pack sink
        ((_this # 0) getVariable QGVAR(float) setMass 10000);
    }, nil, 7, true, true, "", "firstBackpack _target isKindOf 'B_Parachute'"];
};
