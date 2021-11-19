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
         [_holder] call bocr_main_fnc_floatPack;
     } else {
         _holder setVectorUp [0,0,1];
         _holder setPosASL (_pos vectorAdd [0,0,0.1]);
     };
     [_pfhID] call CBA_fnc_removePerFrameHandler;
 };
