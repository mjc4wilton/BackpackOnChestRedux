#include "script_component.hpp"
/*
 * Author: BackpackOnChestRedux contributors
 * Returns carried ACRE2 radio IDs for a given unit.
 *
 * Notes:
 * - acre_api_fnc_getAllRadios returns base radio classnames from CfgAcreRadios, not carried IDs.
 * - This helper enumerates all base radios and queries IDs by type for the given unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Radio IDs <ARRAY>
 *
 * Example:
 * [player] call bocr_main_fnc_acreGetUnitRadioIds;
 *
 * Public: No
 */

params ["_unit"];

if (!([_unit] call FUNC(acreIsInitialized))) exitWith {[]};

// Fast-path for the local player when available.
if (hasInterface && {!isNull player} && {_unit isEqualTo player} && {!isNil "acre_api_fnc_getCurrentRadioList"}) exitWith {
    [] call acre_api_fnc_getCurrentRadioList
};

if (isNil "acre_api_fnc_getAllRadiosByType") exitWith {[]};

private _bases = [] call acre_api_fnc_getAllRadios;
if !(_bases isEqualType []) exitWith {[]};

private _ids = [];
{
    if (_x isEqualType "") then {
        _ids append ([_x, _unit] call acre_api_fnc_getAllRadiosByType);
    };
} forEach _bases;

_ids

