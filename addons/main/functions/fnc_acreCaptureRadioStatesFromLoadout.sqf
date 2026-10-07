#include "script_component.hpp"
/*
 * Author: BackpackOnChestRedux contributors
 * Capture ACRE2 radio states for radios referenced by a loadout cargo array
 * (typically: getUnitLoadout _unit select 5 select 1 for backpack contents).
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Loadout cargo array <ARRAY>
 *
 * Return Value:
 * Array of radio state arrays <ARRAY>
 *
 * Example:
 * [player, ((getUnitLoadout player) select 5) select 1] call bocr_main_fnc_acreCaptureRadioStatesFromLoadout;
 *
 * Public: No
 */

params ["_unit", "_cargoLoadout"];

if (!([_unit] call FUNC(acreIsInitialized))) exitWith {[]};
if !(_cargoLoadout isEqualType []) exitWith {[]};

private _unitRadios = [_unit] call FUNC(acreGetUnitRadioIds);
if (_unitRadios isEqualTo []) exitWith {[]};

// Extract classnames referenced by the cargo loadout.
private _classnames = [];
{
    if (_x isEqualType [] && {count _x > 0}) then {
        private _cargoClass = _x select 0;
        if (_cargoClass isEqualType "") then {
            _classnames pushBack _cargoClass;
        };
    };
} forEach _cargoLoadout;

// Radios are represented by their ID classnames; capture only those present in this cargo loadout.
private _radioIds = [];
private _unitRadiosLc = _unitRadios apply {toLower _x};
{
    // Loadout/cargo can contain ID classnames with different casing than ACRE returns (e.g. "ACRE_PRC343_ID_3"
    // vs "acre_prc343_id_3"), so match case-insensitively but store the actual carried ID string.
    private _idx = _unitRadiosLc find (toLower _x);
    if (_idx >= 0) then {_radioIds pushBackUnique (_unitRadios select _idx);};
} forEach _classnames;

private _states = [];
{
    private _state = [_x] call FUNC(acreGetRadioState);
    if (_state isNotEqualTo []) then {
        _states pushBack _state;
    };
} forEach _radioIds;

_states
