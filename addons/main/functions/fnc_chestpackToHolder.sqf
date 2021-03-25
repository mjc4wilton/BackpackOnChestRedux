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

private _holder = createVehicle ["WeaponHolderSimulated", (getPos _unit), [], 0, "CAN_COLLIDE"];

//add pack
_holder addBackpackCargoGlobal [_chestpack, 1];
private _backpack = firstBackpack _holder;
[QGVAR(clearAllCargo), [_backpack]] call CBA_fnc_globalEvent;

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
                WARNING("chestpackToHolder timed out adding magazines");
                TRACE_1("Container: ", _this);
            }] call CBA_fnc_waitUntilAndExecute;
        } else {
            //backpacks
            _cfgCargoBackpack = _cfgVehicles >> _cargoClass;
            if (isClass _cfgCargoBackpack) then {
                _backpack addBackpackCargoGlobal [_cargoClass, 1];
                [QGVAR(clearCargoBackpacks), [_backpack]] call CBA_fnc_globalEvent;
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
