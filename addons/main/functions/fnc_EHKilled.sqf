/*
 * Author: DerZade, mjc4wilton
 * Triggerd by Killed-Eventhandler
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * _this call bocr_main_fnc_EHKilled;
 *
 * Public: No
 */
params ["_unit"];

private _chestpack = [_unit] call FUNC(chestpack);
private _chestpackItems =  [_unit] call FUNC(chestpackItems);
private _chestpackVariables = [_unit] call FUNC(chestpackVariables);

private _holder = createVehicle ["WeaponHolderSimulated", (getPos _unit), [], 0, "CAN_COLLIDE"];

//add pack
_holder addBackpackCargoGlobal [_chestpack, 1];
private _backpack = firstBackpack _holder;
clearAllItemsFromBackpack _backpack;

//add items
{
    switch (_x select 0) do {
        case (0): {
            _backpack addItemCargoGlobal [(_x select 1),1];
        };
        case (1): {
            _backpack addMagazineAmmoCargo [(_x select 1), (_x select 3), (_x select 2)];
        };
        case (2): {
            _backpack addWeaponWithAttachmentsCargoGlobal [[(_x select 1), (_x select 2), (_x select 3), (_x select 4), (_x select 5), (_x select 6), (_x select 7)], 1];
        };
    };
} forEach _chestpackItems;

//add variables
{
     _backpack setVariable [(_x select 0), (_x select 1), true];
} forEach _chestpackVariables;

//remove the backpack from the dead unit
[_unit] call FUNC(removeChestpack);
