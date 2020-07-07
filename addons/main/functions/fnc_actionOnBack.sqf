#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Triggered by the onBack-action. Handles all the stuff.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player] call bocr_main_fnc_actionOnBack;
 *
 * Public: No
 */
params ["_player"];

private _chestpack = [_player] call FUNC(chestpack);
private _chestpackItems =  [_player,false] call FUNC(chestpackItems);
private _chestpackVariables = [_player] call FUNC(chestpackVariables);

//make sure the player has a chestpack and no backpack
if ((_chestpack isEqualTo "") or !(backpack _player isEqualTo "")) exitWith {};

//add pack
_player addBackpackGlobal _chestpack;
clearAllItemsFromBackpack _player;
private _backpack = backpackContainer _player;

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

[_player] call FUNC(removeChestpack);
