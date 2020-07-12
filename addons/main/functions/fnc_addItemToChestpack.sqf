#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Creates a new item and stores it in the soldier's chestpack.
 * The item(s) won't be added, if adding them would cause an overflow of the backpack.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Item <ARRAY>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player,"FirstAidKit"] call bocr_main_fnc_addItemToChestpack;
 *
 * Public: No
 */
params ["_unit","_item"];

private _var = GETVAR(_unit, GVAR(chestpack), nil);

//exit if there is not enough space left
if !([_unit, _item] call FUNC(canAddItemToChestpack)) exitWith {};
(_var select 2) pushBack [_item, 1];

//update public variable
SETPVAR(_unit, GVAR(chestpack), _var);
