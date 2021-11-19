#include "script_component.hpp"
/*
 * Author: Ampersand
 * Checks if given unit can discard its reserve parachute
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Success <BOOL>
 *
 * Example:
 * [_unit] call bocr_main_fnc_canDiscardParachute;
 *
 * Public: No
 */

params ["_unit"];

if (GVAR(disabled)) exitWith {false};

[_unit] call ace_common_fnc_isSwimming && // Can't move pack while in a parachute
{backpackContainer _unit isKindOf "B_Parachute"}
