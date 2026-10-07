#include "script_component.hpp"
/*
 * Author: BackpackOnChestRedux contributors
 * Normalize cargo loadout entries by fixing invalid/zero counts using the actual container cargo.
 *
 * Motivation:
 * - Some mods/engine edge-cases can yield cargo entries like ["SomeVest", 0] even though the item exists in the container.
 * - Restoring from such a loadout would drop the item silently. This fixes the count based on getItemCargo.
 *
 * Arguments:
 * 0: Container <OBJECT>
 * 1: Cargo loadout <ARRAY>
 *
 * Return Value:
 * Normalized cargo loadout <ARRAY>
 *
 * Example:
 * [backpackContainer player, ((getUnitLoadout player) select 5) select 1] call bocr_main_fnc_normalizeCargoLoadoutCounts;
 *
 * Public: No
 */

params ["_container", "_cargoLoadout"];
if (isNull _container) exitWith {_cargoLoadout};
if !(_cargoLoadout isEqualType []) exitWith {_cargoLoadout};

private _itemCargo = getItemCargo _container;
private _itemClasses = _itemCargo select 0;
private _itemCounts = _itemCargo select 1;

private _out = [];
{
    private _entry = _x;

    if (_entry isEqualType [] && {count _entry > 1} && {(_entry select 0) isEqualType ""}) then {
        private _cls = _entry select 0;
        private _cntRaw = _entry select 1;
        private _cnt = _cntRaw;

        if (_cntRaw isEqualType true) then {
            _cnt = [0, 1] select _cntRaw;
        };

        if (_cnt isEqualType 0 && {_cnt <= 0}) then {
            private _idx = _itemClasses find _cls;
            if (_idx >= 0) then {
                private _actual = _itemCounts select _idx;
                if (_actual > 0) then {
                    private _new = +_entry;
                    _new set [1, _actual];
                    _entry = _new;
                };
            };
        };
    };

    _out pushBack _entry;
} forEach _cargoLoadout;

_out
