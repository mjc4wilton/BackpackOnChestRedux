#include "script_component.hpp"
/*
 * Author: BackpackOnChestRedux contributors
 * Returns saved ACRE2 radio states for the unit's chestpack, if present.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Saved radio states <ARRAY>
 *
 * Example:
 * [player] call bocr_main_fnc_chestpackAcreRadios;
 *
 * Public: No
 */

params ["_unit"];

private _acre = _unit getVariable [QGVAR(acreChestpackRadios), []];
if (_acre isEqualType []) exitWith {_acre};

[]
