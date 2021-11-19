#include "script_component.hpp"
/*
 * Author: Ampersand
 * Called on server when chestpack is lowered.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [_ropeTop, _holder] call bocr_main_fnc_checkLandedPFH;
 *
 * Public: No
 */

 params ["_args", "_pfhID"];
 _args params ["_ropeTop", "_holder"];

 private _pos = getPos _holder;
 private _alt = _pos # 2;
 if (speed _holder < 1 && {_alt < 1}) exitWith {
     deleteVehicle _ropeTop;
     _alt = getPosASL _holder # 2;
     if (_alt < 1 && {surfaceIsWater _pos}) then {
         // Make pack float
         private _float = QGVAR(float) createVehicle [0, 0, 0];
         _float setPosASL (_pos vectorAdd [0, 0, -2]);
         _holder attachTo [_float, [0, 0, 1.5]];
         _holder setVariable [QGVAR(float), _float];
         _holder addaction ["Discard", {
             params ["_holder"];
             deleteVehicle _holder;
         }, nil, 7, true, true, "", "backpackCargo _target isEqualTo ['ACE_ReserveParachute']"];
         _holder addEventHandler ["Deleted", {
             params ["_holder"];
             deleteVehicle (_holder getVariable QGVAR(float));
         }];
     } else {
         _holder setVectorUp [0,0,1];
         _holder setPosASL (_pos vectorAdd [0,0,0.1]);
     };
     [_pfhID] call CBA_fnc_removePerFrameHandler;
 };
