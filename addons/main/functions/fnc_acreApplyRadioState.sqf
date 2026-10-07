#include "script_component.hpp"
/*
 * Author: BackpackOnChestRedux contributors
 * Apply a previously exported radio state to a (new) ACRE2 radio ID.
 *
 * Arguments:
 * 0: Radio ID <STRING>
 * 1: Radio state <ARRAY> (from fnc_acreGetRadioState)
 *
 * Return Value:
 * None
 *
 * Example:
 * [_newRadioId, _state] call bocr_main_fnc_acreApplyRadioState;
 *
 * Public: No
 */

params ["_radioId", "_state"];
if !(missionNamespace getVariable [QGVAR(isACRELoaded), false]) exitWith {};
if (_state isEqualTo []) exitWith {};

_state params ["_oldId", "_base", "_channel", "_volume", "_spatial", "_audioSource", "_onOff"];

// These API calls are client-side.
[_radioId, _channel] call acre_api_fnc_setRadioChannel;
[_radioId, _volume] call acre_api_fnc_setRadioVolume;
[_radioId, _spatial] call acre_api_fnc_setRadioSpatial;
[_radioId, _audioSource] call acre_api_fnc_setRadioAudioSource;
[_radioId, _onOff] call acre_api_fnc_setRadioOnOffState;
