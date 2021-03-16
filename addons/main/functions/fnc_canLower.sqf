#include "script_component.hpp"
/*
 * Author: Ampersand
 * Checks if given unit can lower its chestpack
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Success <BOOLEAN>
 *
 * Example:
 * [_unit] call bocr_main_fnc_canLower;
 *
 * Public: No
 */

params ["_unit"];

if (GVAR(disabled)) exitWith {false};

vehicle _unit isKindOf "ParachuteBase"
&& {[_player] call FUNC(chestpack) != ''}
