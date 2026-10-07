#include "script_component.hpp"
/*
 * Author: BackpackOnChestRedux contributors
 * Filter a cargo loadout array for ACRE2 so radios can be safely restored.
 *
 * Converts ACRE radio ID item classnames (e.g. "ACRE_PRC152_ID_2") to their base radio classnames
 * (e.g. "ACRE_PRC152") while leaving all other cargo unchanged.
 *
 * Arguments:
 * 0: Cargo loadout <ARRAY>
 *
 * Return Value:
 * Filtered cargo loadout <ARRAY>
 *
 * Example:
 * [((getUnitLoadout player) select 5) select 1] call bocr_main_fnc_acreFilterCargoLoadout;
 *
 * Public: No
 */

params ["_cargoLoadout"];
if !(_cargoLoadout isEqualType []) exitWith {_cargoLoadout};

private _cfgAcreRadios = configFile >> "CfgAcreRadios";
private _hasCfgAcreRadios = isClass _cfgAcreRadios;

private _out = [];
{
    private _entry = _x;
    if !(_entry isEqualType [] && {count _entry > 0}) then {
        _out pushBack _entry;
    } else {
        private _first = _entry select 0;
        if (_first isEqualType "") then {
            private _cls = _first;
            private _clsUc = toUpper _cls;

            private _pos = _clsUc find "_ID_";
            if (_pos > 0) then {
                private _base = _cls select [0, _pos];
                if (!_hasCfgAcreRadios || {isClass (_cfgAcreRadios >> _base)}) then {
                    private _new = +_entry;
                    _new set [0, _base];
                    // ACRE radios are always 1 per entry; ensure numeric count if present.
                    if (count _new > 1 && {(_new select 1) isEqualType 0} && {(_new select 1) < 1}) then {
                        _new set [1, 1];
                    };
                    _entry = _new;
                };
            };
        };

        _out pushBack _entry;
    };
} forEach _cargoLoadout;

_out

