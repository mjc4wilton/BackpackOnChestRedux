#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Triggered by the onChest-action. Handles all the stuff.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player] call bocr_main_fnc_actionOnChest;
 *
 * Public: No
 */

params["_unit"];

private _backpack = backpack _unit;
private _backpackLoad = loadBackpack _unit;
private _unitLoadout = getUnitLoadout _unit;
private _backpackLoadoutRaw = (_unitLoadout select 5) select 1;
private _acreRadioStates = [];
private _backpackLoadout = _backpackLoadoutRaw;
private _backpackContainer = backpackContainer _unit;

if (!isNull _backpackContainer) then {
    _backpackLoadoutRaw = [_backpackContainer, _backpackLoadoutRaw] call FUNC(normalizeCargoLoadoutCounts);
    _backpackLoadout = _backpackLoadoutRaw;
};

// If ACRE is running, capture per-radio state before the backpack (and its contents) are removed.
// Also convert ACRE radio ID classnames to base classnames for safe restore.
if ([_unit] call FUNC(acreIsInitialized)) then {
    _acreRadioStates = [_unit, _backpackLoadoutRaw] call FUNC(acreCaptureRadioStatesFromLoadout);
    _backpackLoadout = [_backpackLoadoutRaw] call FUNC(acreFilterCargoLoadout);
};
private _backpackVariables = [];

//Variable Handling
{
    private _val = (backpackContainer _unit) getVariable _x;
    _backpackVariables pushBack [_x, _val];
} forEach ((allVariables (backpackContainer _unit) - GVAR(VarBlacklist)));

[_unit, _backpack, _backpackLoadout, _backpackVariables, _backpackLoad] call FUNC(addChestpack);
_unit setVariable [QGVAR(acreChestpackRadios), _acreRadioStates];

removeBackpackGlobal _unit;
