#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Triggerd by GetInMan-Eventhandler
 *
 * Arguments:
 * 0: unit <OBJECT>
 * 1: position <STRING>
 * 2: vehicle <OBJECT>
 * 3: turret path <ARRAY>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * _this call bocr_main_fnc_EHGetIn;
 *
 * Public: No
 */
params ["_unit","_position","_veh"];

if (isNil "_unit" or isNil "_veh") exitWith {["No proper argument(s) given."] call BIS_fnc_error};

private _chestpack = [_unit] call FUNC(chestpackContainer);

if (_veh isKindOf "ParachuteBase") then {
    _chestpack attachTo [_veh, [0, -0.03, -0.5]];
    _chestpack setVectorDirAndUp [[-0.25, -1, 0], [0, 0, 1]];
    [QGVAR(hideObjectGlobal), [_chestpack, false]] call CBA_fnc_serverEvent;
} else {
    detach _chestpack;
    _chestpack setPos [-10000,-10000,-100];
    [QGVAR(hideObjectGlobal), [_chestpack, true]] call CBA_fnc_serverEvent;
};
