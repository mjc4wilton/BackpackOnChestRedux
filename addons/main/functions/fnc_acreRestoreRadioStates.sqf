#include "script_component.hpp"
/*
 * Author: BackpackOnChestRedux contributors
 * Restore previously captured ACRE2 radio states after radios have been re-added.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Radio IDs present before restore <ARRAY>
 * 2: Saved radio states <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, _preRadios, _states] call bocr_main_fnc_acreRestoreRadioStates;
 *
 * Public: No
 */

params ["_unit", "_preRadios", "_states"];

if (!(missionNamespace getVariable [QGVAR(isACRELoaded), false])) exitWith {
};
if (isNil "acre_api_fnc_getCurrentRadioList") exitWith {
};
if (!local _unit) exitWith {
};
if !(_preRadios isEqualType []) exitWith {};
if (!(_states isEqualType []) || {_states isEqualTo []}) exitWith {};

// Wait a moment for ACRE to register the new radios (inventory changes are not always immediate).
[
    {
        params ["_unit", "_preRadios", "_states"];
        if (!([_unit] call FUNC(acreIsInitialized))) exitWith {false};
        private _postRadios = [_unit] call FUNC(acreGetUnitRadioIds);
        private _added = _postRadios - _preRadios;
        private _expected = count _states;
        (count _added) >= _expected
    },
    {
        params ["_unit", "_preRadios", "_states"];

        private _postRadios = [_unit] call FUNC(acreGetUnitRadioIds);
        private _added = _postRadios - _preRadios;
        if (_added isEqualTo []) exitWith {};

        private _remaining = +_added;
        private _applied = [];
        {
            private _state = _x;
            _state params ["_oldId", "_base"];
            private _idx = -1;
            {
                private _radioId = _x;
                if (([_radioId] call acre_api_fnc_getBaseRadio) isEqualTo _base) exitWith {
                    _idx = _forEachIndex;
                };
            } forEach _remaining;
            if (_idx >= 0) then {
                private _newId = _remaining deleteAt _idx;
                [_newId, _state] call FUNC(acreApplyRadioState);
                _applied pushBack [_newId, _state];
            };
        } forEach _states;

        // Best-effort second pass in case ACRE applies default setup after inventory sync.
        if (_applied isNotEqualTo []) then {
            [
                {
                    params ["_applied"];
                    {
                        _x params ["_newId", "_state"];
                        _state params ["_oldId", "_base", "_channel", "_volume", "_spatial", "_audioSource", "_onOff"];

                        private _needs = false;
                        if (([_newId] call acre_api_fnc_getRadioChannel) != _channel) then {_needs = true;};
                        if (([_newId] call acre_api_fnc_getRadioVolume) != _volume) then {_needs = true;};
                        if (([_newId] call acre_api_fnc_getRadioSpatial) != _spatial) then {_needs = true;};
                        if (([_newId] call acre_api_fnc_getRadioAudioSource) != _audioSource) then {_needs = true;};
                        if (([_newId] call acre_api_fnc_getRadioOnOffState) != _onOff) then {_needs = true;};

                        if (_needs) then {
                            [_newId, _state] call FUNC(acreApplyRadioState);
                        };
                    } forEach _applied;
                },
                [_applied],
                0.35
            ] call CBA_fnc_waitAndExecute;
        };
    },
    [_unit, _preRadios, _states],
    6,
    {
        // Timed out - best effort apply using whatever radios exist now.
        params ["_unit", "_preRadios", "_states"];
        if (!([_unit] call FUNC(acreIsInitialized))) exitWith {
        };
        private _postRadios = [_unit] call FUNC(acreGetUnitRadioIds);
        private _added = _postRadios - _preRadios;
        if (_added isEqualTo []) exitWith {};

        private _remaining = +_added;
        {
            private _state = _x;
            _state params ["_oldId", "_base"];
            private _idx = -1;
            {
                private _radioId = _x;
                if (([_radioId] call acre_api_fnc_getBaseRadio) isEqualTo _base) exitWith {
                    _idx = _forEachIndex;
                };
            } forEach _remaining;
            if (_idx >= 0) then {
                private _newId = _remaining deleteAt _idx;
                [_newId, _state] call FUNC(acreApplyRadioState);
            };
        } forEach _states;
    }
] call CBA_fnc_waitUntilAndExecute;
