#include "script_component.hpp"
/*
 * Author: Ampersand
 * Returns WeaponHolderSimulated with copy of chestpack
 *
 * Arguments:
 * 0: Backpack <OBJECT>
 * 1: Loadout <ARRAY>
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * [_backpack, (getUnitLoadout _unit) select 5 select 1] call bocr_main_fnc_setBackpackLoadout;
 *
 * Public: No
 */

params ["_backpack", "_loadout"];
if (isNull _backpack) exitWith {false};

[QGVAR(clearAllCargo), [_backpack]] call CBA_fnc_globalEvent;

private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgVehicles = configFile >> "CfgVehicles";
private _cfgWeapons = configFile >> "CfgWeapons";

private _cfgAcreRadios = configFile >> "CfgAcreRadios";
private _hasCfgAcreRadios = isClass _cfgAcreRadios;

private _isAcreClass = {
    params ["_cls"];
    (_cls isEqualType "") && {(toLower _cls) find "acre_" == 0}
};

private _isRadioClass = {
    params ["_cls", "_cfgAcreRadios", "_hasCfgAcreRadios", "_isAcreClass"];
    ([_cls] call _isAcreClass) || {(_hasCfgAcreRadios && {isClass (_cfgAcreRadios >> _cls)})}
};

private _isBackpackClass = {
    params ["_cls", "_cfgVehicles", "_cfgWeapons"];
    private _cfg = _cfgVehicles >> _cls;
    isClass _cfg && {getNumber (_cfg >> "isBackpack") == 1} && {!isClass (_cfgWeapons >> _cls)}
};

private _coerceCount = {
    params ["_entry"];
    if !(_entry isEqualType [] && {count _entry > 1}) exitWith {_entry};
    private _cnt = _entry select 1;
    if (_cnt isEqualType true) exitWith {
        private _new = +_entry;
        _new set [1, [0, 1] select _cnt];
        _new
    };
    _entry
};

private _loadoutOther = [];
private _loadoutRadios = [];
{
    private _entry = [_x] call _coerceCount;
    if (_entry isEqualType [] && {count _entry > 0} && {(_entry select 0) isEqualType ""}) then {
        private _cls = _entry select 0;
        if ([_cls, _cfgAcreRadios, _hasCfgAcreRadios, _isAcreClass] call _isRadioClass) then {
            _loadoutRadios pushBack _entry;
        } else {
            _loadoutOther pushBack _entry;
        };
    } else {
        _loadoutOther pushBack _entry;
    };
} forEach _loadout;

private _expectedItems = [];
{
    private _entry = _x;
    if (_entry isEqualType [] && {count _entry > 1} && {(_entry select 0) isEqualType ""} && {(_entry select 1) isEqualType 0}) then {
        private _cls = _entry select 0;
        private _cnt = _entry select 1;
        if (
            _cnt > 0
            && {!isClass (_cfgMagazines >> _cls)}
            && {!([_cls, _cfgVehicles, _cfgWeapons] call _isBackpackClass)}
            && {!([_cls] call _isAcreClass)}
            && {!(_hasCfgAcreRadios && {isClass (_cfgAcreRadios >> _cls)})}
        ) then {
            private _idx = _expectedItems findIf {(_x select 0) isEqualTo _cls};
            if (_idx < 0) then {
                _expectedItems pushBack [_cls, _cnt];
            } else {
                _expectedItems set [_idx, [_cls, (_expectedItems select _idx select 1) + _cnt]];
            };
        };
    };
} forEach _loadoutOther;

private _addEntry = {
    params ["_backpack", "_entry", "_cfgMagazines", "_cfgVehicles", "_cfgWeapons", "_isBackpackClass"];

    if (typeName (_entry select 0) == "Array") exitWith {
        for "_i" from 1 to (_entry select 1) do {
            _backpack addWeaponWithAttachmentsCargoGlobal _entry;
        };
    };

    private _cargoClass = _entry select 0;

    if (isClass (_cfgMagazines >> _cargoClass)) exitWith {
        _backpack addMagazineAmmoCargo _entry;
        // Above command sometimes fails on its own; retry until the expected count matches.
        [{
            params ["_backpack", "_mag", "_count", "_rounds"];
            private _countInBackpack = {_x isEqualTo [_mag, _rounds]} count magazinesAmmoCargo _backpack;
            if (_countInBackpack < _count) then {
                _backpack addMagazineAmmoCargo [_mag, 1, _rounds];
            };
            _countInBackpack == _count
        }, {}, [_backpack] + _entry, 1, {
            WARNING("chestpackToHolder timed out adding magazines");
            TRACE_1("Container: ",_this);
        }] call CBA_fnc_waitUntilAndExecute;
    };

    if ([_cargoClass, _cfgVehicles, _cfgWeapons] call _isBackpackClass) exitWith {
        _backpack addBackpackCargoGlobal [_cargoClass, 1];
        [QGVAR(clearCargoBackpacks), [_backpack]] call CBA_fnc_globalEvent;
    };

    _backpack addItemCargoGlobal _entry;
};

// Add non-radio items first; add radios last (ACRE may convert them asynchronously).
{
    [_backpack, _x, _cfgMagazines, _cfgVehicles, _cfgWeapons, _isBackpackClass] call _addEntry;
} forEach _loadoutOther;
{
    [_backpack, _x, _cfgMagazines, _cfgVehicles, _cfgWeapons, _isBackpackClass] call _addEntry;
} forEach _loadoutRadios;

// Retry any missing normal items once after the inventory has settled.
if (_expectedItems isNotEqualTo []) then {
    [
        {
            params ["_backpack", "_expectedItems"];
            if (isNull _backpack) exitWith {};

            private _cargo = getItemCargo _backpack;
            private _classes = _cargo select 0;
            private _counts = _cargo select 1;

            private _missing = [];
            {
                _x params ["_cls", "_want"];
                private _idx = _classes find _cls;
                private _have = if (_idx < 0) then {0} else {_counts select _idx};
                if (_have < _want) then {
                    private _need = _want - _have;
                    _missing pushBack [_cls, _need, _have, _want];
                    _backpack addItemCargoGlobal [_cls, _need];
                };
            } forEach _expectedItems;
        },
        [_backpack, _expectedItems],
        1.0
    ] call CBA_fnc_waitAndExecute;
};

true
