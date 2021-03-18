#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton, Ampersand
 * Triggerd by Killed-Eventhandler
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * Weapon Holder <OBJECT>
 *
 * Example:
 * [player] call bocr_main_fnc_EHKilled;
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
[_backpack] call FUNC(clearCargo);


//add items
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgVehicles = configFile >> "CfgVehicles";
{
    if (typeName (_x select 0) == "Array") then {
        //weapon with attachments
        for "_i" from 1 to (_x select 1) do {
            _backpack addWeaponWithAttachmentsCargoGlobal _x;
        };
    } else {
        private _cargoClass = (_x select 0);
        //mags
        if (isClass (_cfgMagazines >> _cargoClass)) then {
            _backpack addMagazineAmmoCargo _x;
            [{
                params ["_backpack", "_mag", "_count", "_rounds"];
                private _countInBackpack = {_x isEqualTo [_mag, _rounds]} count magazinesAmmoCargo _backpack;
                if (_countInBackpack < _count) then {
                    _backpack addMagazineAmmoCargo [_mag, 1, _rounds];
                };
                _countInBackpack == _count
            }, {}, [_backpack] + _x, 1, {
                diag_log "bocr_main_fnc_EHKilled timed out adding magazines";
                diag_log _this;
            }] call CBA_fnc_waitUntilAndExecute;
        } else {
            //backpacks
            _cfgCargoBackpack = _cfgVehicles >> _cargoClass;
            if (isClass _cfgCargoBackpack) then {
                _backpack addBackpackCargoGlobal [
                    (configName ([_cfgCargoBackpack] call bocr_main_fnc_getBackpackEmptyAncestor)),
                    1
                ];
            } else {
                _backpack addItemCargoGlobal _x;
            }
        };
    };
} forEach _chestpackLoadout;

//add variables
{
     _backpack setVariable [(_x select 0), (_x select 1), true];
} forEach _chestpackVariables;

//remove the backpack from the dead unit
[_unit] call FUNC(removeChestpack);

_holder
