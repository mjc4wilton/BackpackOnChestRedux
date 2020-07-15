#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Removes item from unit's chestpack.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Item/magazine/weapon classname <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player,"FirstAidKit"] call bocr_main_fnc_removeItemFromChestpack;
 *
 * Public: No
 */
params ["_unit","_item"];

private _loadout = _unit call FUNC(chestpackLoadout);
private _itemFound = {
    if !(_x find _item isEqualTo -1) exitWith { [_x, _forEachIndex, true] };
} forEach _loadout;

//exit if no item found
if !(_itemFound select 2 isEqualTo true) exitWith {};

private _var = _unit getVariable [QGVAR(chestpack), nil];

(_var select 2) deleteAt (_itemFound select 1);

_unit setVariable [QGVAR(chestpack), _var, true];
