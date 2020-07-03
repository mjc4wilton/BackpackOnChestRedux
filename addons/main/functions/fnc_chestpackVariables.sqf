/*
 * Author: DerZade, mjc4wilton
 * Returns array with all variables in chestpack of the given unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * variables <ARRAY>
 *
 * Example:
 * [player] call bocr_main_fnc_chestpackVariables;
 *
 * Public: No
 */
params ["_unit"];

private _var = GETVAR(_unit, GVAR(chestpack), nil);
private _variables = +(_var select 3);

//return objNull
if (isNil "_var" or isNil "_items") exitWith {[]};

//return items
_variables
