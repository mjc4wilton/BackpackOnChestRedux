#include "script_component.hpp"
/*
 * Author: BackpackOnChestRedux contributors
 * Returns true if ACRE2 is present and initialized on this client.
 *
 * Arguments:
 * 0: Unit <OBJECT> (optional, for locality checks)
 *
 * Return Value:
 * ACRE initialized <BOOL>
 *
 * Example:
 * [player] call bocr_main_fnc_acreIsInitialized;
 *
 * Public: No
 */

params [["_unit", objNull]];

if !(missionNamespace getVariable [QGVAR(isACRELoaded), false]) exitWith {false};
if (isNil "acre_api_fnc_isInitialized") exitWith {false};

// Most ACRE API calls are intended to run where the unit is local.
if (!isNull _unit && {!local _unit}) exitWith {false};

call acre_api_fnc_isInitialized
