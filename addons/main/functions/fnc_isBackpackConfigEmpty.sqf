#include "script_component.hpp"
/*
 * Author: Ampersand
 * Checks if the given backpack's config TransportXXXX are empty
 *
 * Arguments:
 * 0: Backpack <CONFIG>
 *
 * Return Value:
 * 0: IsConfigEmpty <BOOLEAN>
 *
 * Example:
 * [configOf backpackContainer player] call bocr_main_fnc_isBackpackConfigEmpty;
 *
 * Public: No
 */

params ["_cfgBackpack"];

private _isConfigEmpty = true;
{
    _cfgTransport = _cfgBackpack >> _x;
    if (
        isClass _cfgTransport &&
        {count ("true" configClasses _cfgTransport) > 0} //has config content
    ) exitWith {
        _isConfigEmpty = false;
    };
} forEach ["TransportMagazines", "TransportWeapons", "TransportItems", "TransportBackpacks"];

_isConfigEmpty
