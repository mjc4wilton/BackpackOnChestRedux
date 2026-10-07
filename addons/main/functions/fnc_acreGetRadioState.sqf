#include "script_component.hpp"
/*
 * Author: BackpackOnChestRedux contributors
 * Export ACRE2 state for a single radio ID so it can be restored later.
 *
 * Arguments:
 * 0: Radio ID <STRING>
 *
 * Return Value:
 * Radio state <ARRAY>:
 * 0: Old radio ID <STRING>
 * 1: Base radio classname <STRING>
 * 2: Channel <NUMBER>
 * 3: Volume <NUMBER>
 * 4: Spatial (LEFT/RIGHT/CENTER) <STRING>
 * 5: Audio source <STRING>
 * 6: On/Off <BOOL>
 *
 * Example:
 * ["ACRE_PRC152_ID_1"] call bocr_main_fnc_acreGetRadioState;
 *
 * Public: No
 */

params ["_radioId"];

if !(missionNamespace getVariable [QGVAR(isACRELoaded), false]) exitWith {[]};

[
    _radioId,
    [_radioId] call acre_api_fnc_getBaseRadio,
    [_radioId] call acre_api_fnc_getRadioChannel,
    [_radioId] call acre_api_fnc_getRadioVolume,
    [_radioId] call acre_api_fnc_getRadioSpatial,
    [_radioId] call acre_api_fnc_getRadioAudioSource,
    [_radioId] call acre_api_fnc_getRadioOnOffState
]
