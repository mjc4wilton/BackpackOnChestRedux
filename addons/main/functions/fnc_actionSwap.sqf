#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Triggered by the swap-action. Handles all the stuff.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player] call bocr_main_fnc_actionSwap;
 *
 * Public: No
 */
params ["_unit"];

private _backpack = backpack _unit;
private _backpackLoad = loadBackpack _unit;
private _unitLoadout = getUnitLoadout _unit;
private _backpackLoadoutRaw = (_unitLoadout select 5) select 1;
private _backpackLoadout = _backpackLoadoutRaw;
private _backpackVariables = [];
private _backpackAcreRadios = [];
private _backpackContainer = backpackContainer _unit;

if (!isNull _backpackContainer) then {
    _backpackLoadoutRaw = [_backpackContainer, _backpackLoadoutRaw] call FUNC(normalizeCargoLoadoutCounts);
    _backpackLoadout = _backpackLoadoutRaw;
};

private _chestpack = [_unit] call FUNC(chestpack);
private _chestpackLoadout = [_unit] call FUNC(chestpackLoadout);
private _chestpackVariables = [_unit] call FUNC(chestpackVariables);
private _chestpackAcreRadios = [_unit] call FUNC(chestpackAcreRadios);

private _shouldSwitchNVGs = currentVisionMode _unit != 0;
private _acreLoaded = (missionNamespace getVariable [QGVAR(isACRELoaded), false]) && {!isNil "acre_api_fnc_getCurrentRadioList"};

//make sure the player has chest-pack and backpack
if ((_backpack isEqualTo "") or ([_unit] call FUNC(chestpack)) isEqualTo "") exitWith {};

// If ACRE is running, capture per-radio state for radios inside the backpack that will become the new chestpack.
// Also convert ACRE radio ID classnames to base classnames for safe restore.
if (_acreLoaded) then {
    _backpackAcreRadios = [_unit, _backpackLoadoutRaw] call FUNC(acreCaptureRadioStatesFromLoadout);
    _backpackLoadout = [_backpackLoadoutRaw] call FUNC(acreFilterCargoLoadout);
};

//Backpack Variable Handling
{
    private _val = (backpackContainer _unit) getVariable _x;
    _backpackVariables pushBack [_x, _val];
} forEach ((allVariables (backpackContainer _unit) - GVAR(VarBlacklist)));

//remove packs
[_unit] call FUNC(removeChestpack);
removeBackpackGlobal _unit;

private _preRadios = [];
if (_acreLoaded && {_chestpackAcreRadios isNotEqualTo []}) then {
    _preRadios = [_unit] call FUNC(acreGetUnitRadioIds);
};

if (_acreLoaded) then {
    // Avoid setUnitLoadout when ACRE is running to prevent full radio re-init.
    _unit addBackpackGlobal _chestpack;
    private _backpackNew = backpackContainer _unit;
    [_backpackNew, _chestpackLoadout] call FUNC(setBackpackLoadout);
} else {
    //add backpack loadout
    private _loadout = getUnitLoadout _unit;
    _loadout set [5, [_chestpack, _chestpackLoadout]];
    _unit setUnitLoadout _loadout;
};

if (GVAR(isACEAXLoaded)) then {
    [_unit, [_unit] call aceax_gearinfo_fnc_getTextureOptions] call aceax_gearinfo_fnc_setTextureOptions;
};

if (!_acreLoaded && {_shouldSwitchNVGs}) then {
    _unit action ["NVGoggles", _unit];
};

//add backpack variables
private _backpackNew = backpackContainer _unit;
{
     _backpackNew setVariable [(_x select 0), (_x select 1), true];
} forEach _chestpackVariables;

// Restore ACRE radio settings for radios that were inside the chestpack.
if (_acreLoaded && {_chestpackAcreRadios isNotEqualTo []}) then {
    [_unit, _preRadios, _chestpackAcreRadios] call FUNC(acreRestoreRadioStates);
};

//add chestpack
[_unit, _backpack, _backpackLoadout, _backpackVariables, _backpackLoad] call FUNC(addChestpack);
_unit setVariable [QGVAR(acreChestpackRadios), _backpackAcreRadios];
