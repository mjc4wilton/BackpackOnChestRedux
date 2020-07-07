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
 * [player,[0,"FirstAidKit"]] call bocr_main_fnc_addItemToChestpack;
 *
 * Public: No
 */
params ["_unit","_item"];

private _var = _unit getVariable [QGVAR(chestpack),nil];

switch (_item select 0) do {
    case (0): {
        //exit if there is not enough space left
        if !([_unit,(_item select 1),1] call FUNC(canAddItemToChestpack)) exitWith {};

        (_var select 2) pushBack _item;
    };
    case (1): {
        //exit if there is not enough space left
        if !([_unit,(_item select 1),(_item select 3)] call FUNC(canAddItemToChestpack)) exitWith {};

        (_var select 2) pushBack _item;
    };
    case (2): {
        //exit if there is not enough space left
        for "_i" from 1 to 7 do {
            private _itemClass = if (!(i == 5 || i == 6)) then {_x select i} else {(_x select i) select 0};
            if !([_unit,_itemClass,1] call FUNC(canAddItemToChestpack)) exitWith {};
        };

        (_var select 2) pushBack _item;
    };
};

//update variable
SETPVAR(_unit, GVAR(chestpack), _var);
