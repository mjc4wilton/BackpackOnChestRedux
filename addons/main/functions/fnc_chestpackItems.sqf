#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Returns array with all items in chestpack of the given unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Items <ARRAY>
 *
 * Example:
 * [player] call bocr_main_fnc_chestpackItems;
 *
 * Public: No
 */
params ["_unit"];

private _var = GETVAR(_unit, GVAR(chestpack), nil);
private _items = +(_var select 2);

//return objNull
if (isNil "_var" or isNil "_items") exitWith {[]};

//return items
_items
