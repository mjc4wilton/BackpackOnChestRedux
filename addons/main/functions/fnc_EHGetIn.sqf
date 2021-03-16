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
    [_chestpack, [_veh, [0, -0.03, -0.5]]] remoteExec ["attachTo", 0];
    [_chestpack, [[-0.25, -1, 0], [0, 0, 1]]] remoteExec ["setVectorDirAndUp", 0];
    [_chestpack, false] remoteExec ["hideObjectGlobal", 0];
} else {
    _chestpack remoteExec ["detach", 0];
    _chestpack remoteExec ["hideObjectGlobal", 0];
    [_chestpack, [-10000,-10000,-100]] remoteExec ["setPos", 0];
};
