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
params ["_unit"];

private _chestpack = [_unit] call FUNC(chestpack);
private _chestpackLoadout = [_unit] call FUNC(chestpackLoadout);
private _chestpackVariables = [_unit] call FUNC(chestpackVariables);

private _shouldSwitchNVGs = currentVisionMode _unit != 0;

//make sure the player has a chestpack and no backpack
if ((_chestpack isEqualTo "") or (backpack _unit isNotEqualTo "")) exitWith {};

//add items
private _loadout = getUnitLoadout _unit;
_loadout set [5, [_chestpack, _chestpackLoadout]];
_unit setUnitLoadout _loadout;

if (GVAR(isACEAXLoaded)) then {
    [_unit, [_unit] call aceax_gearinfo_fnc_getTextureOptions] call aceax_gearinfo_fnc_setTextureOptions;
};

if (_shouldSwitchNVGs) then {
    _unit action ["NVGoggles", _unit];
};
//prefilled versions of backpacks (ammo bearer, engineer, explosives, medic, repair, etc)
//can be emptied and placed in unit's backpack
//they must each be emptied when added
//safe since game inventory won't let players add non-empty backpacks into their backpack
[QGVAR(clearCargoBackpacks), [backpackContainer _unit]] call CBA_fnc_globalEvent;

//add variables
private _backpack = backpackContainer _unit;
{
     _backpack setVariable [(_x select 0), (_x select 1), true];
} forEach _chestpackVariables;

[_unit] call FUNC(removeChestpack);
