#include "script_component.hpp"
/*
 * Author: Ampersand
 * Returns WeaponHolderSimulated with copy of chestpack
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * 0: WeaponHolderSimulated <OBJECT>
 *
 * Example:
 * [player] call bocr_main_fnc_chestpackToHolder;
 *
 * Public: No
 */

params ["_unit"];

private _chestpack = [_unit] call FUNC(chestpack);
if (_chestpack isEqualTo "") exitWith {objNull};
private _chestpackLoadout =  [_unit] call FUNC(chestpackLoadout);
private _chestpackVariables = [_unit] call FUNC(chestpackVariables);

private _holder = createVehicle ["WeaponHolderSimulated", [0, 0, 0], [], 0, "CAN_COLLIDE"];
_holder setPosASL getPosASL _unit;

//add pack
_holder addBackpackCargoGlobal [_chestpack, 1];
private _backpack = firstBackpack _holder;

[_backpack, _chestpackLoadout] call FUNC(setBackpackLoadout);

//add variables
{
     _backpack setVariable [(_x select 0), (_x select 1), true];
} forEach _chestpackVariables;

//remove the backpack from the dead unit
[_unit] call FUNC(removeChestpack);

_holder
