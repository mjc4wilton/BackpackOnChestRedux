#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Returns the classname of a unit's chestpack.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Classname <STRING>
 *
 * Example:
 * [player] call bocr_main_fnc_chestpack;
 *
 * Public: No
 */
params ["_unit"];

private _var = GETVAR(_unit, GVAR(chestpack), nil);

//return ""
if (isNil "_var") exitWith {""};
private _chestpackClass = (_var select 0) select 0;

//return classname
_chestpackClass
