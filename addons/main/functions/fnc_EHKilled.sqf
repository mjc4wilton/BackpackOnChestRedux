#include "script_component.hpp"
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
private _chestpackLoadout =  [_unit] call FUNC(chestpackLoadout);
private _chestpackVariables = [_unit] call FUNC(chestpackVariables);

private _holder = createVehicle ["WeaponHolderSimulated", (getPos _unit), [], 0, "CAN_COLLIDE"];

//add pack
_holder addBackpackCargoGlobal [_chestpack, 1];
private _backpack = firstBackpack _holder;
clearAllItemsFromBackpack _backpack;

//add items
{
    if (typeName (_x select 0) == "Array") then {
        //weapon with attachments
        for "_i" from 0 to (_x select 1) do {
            _backpack addWeaponWithAttachmentsCargoGlobal (_x select 0);
        };
    } else {
        //mags
        if (isClass (configFile>>"CfgMagazines">> (_x select 0))) then {
            _backpack addMagazineAmmoCargo _x;
        } else {
            _backpack addItemCargoGlobal _x;
        };
    };
} forEach _chestpackLoadout;

//add variables
{
     _backpack setVariable [(_x select 0), (_x select 1), true];
} forEach _chestpackVariables;

//remove the backpack from the dead unit
[_unit] call FUNC(removeChestpack);
