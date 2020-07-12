#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Returns Unit Loadout Array of chestpack of the given unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Items <ARRAY>
 *
 * Example:
 * [player] call bocr_main_fnc_chestpackLoadout;
 *
 * Public: No
 */
params ["_unit"];

private _var = GETVAR(_unit, GVAR(chestpack), nil);
private _loadout = +(_var select 2);

//return objNull
if (isNil "_var" or isNil "_loadout") exitWith {[]};

//return items
_loadout
