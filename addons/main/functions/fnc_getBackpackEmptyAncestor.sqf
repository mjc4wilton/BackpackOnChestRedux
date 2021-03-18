#include "script_component.hpp"
/*
 * Author: Ampersand
 * Returns the config of the empty ancestor of the given non-empty backpack
 *
 * Arguments:
 * 0: Backpack <CONFIG>
 *
 * Return Value:
 * 0: Ancestor <CONFIG>
 *
 * Example:
 * [configOf backpackContainer player] call bocr_main_fnc_getBackpackEmptyAncestor;
 *
 * Public: No
 */

params ["_cfgBackpack"];

if ([_cfgBackpack] call bocr_main_fnc_isBackpackConfigEmpty) then {
    _cfgBackpack
} else {
    [inheritsFrom _cfgBackpack] call bocr_main_fnc_getBackpackEmptyAncestor
}
