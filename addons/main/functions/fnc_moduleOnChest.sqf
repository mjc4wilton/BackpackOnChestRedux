#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Triggerd by OnChest-Module
 *
 * Arguments:
 * 0: module <OBJECT>
 * 1: synchronized units <ARRAY>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * n/a
 *
 * Public: No
 */
params ["_module","_syncedUnits"];

private _backpackClass = _module getVariable "classname";
private _delay = _module getVariable "delay";

//make sure there is no unit twice in the array
private _units = [];
{
     _units pushBackUnique _x;
} forEach _syncedUnits;

_null = [_units,_backpackClass,_delay] spawn {
     params ["_units","_backpackClass","_delay"];
     sleep _delay;
     {
          if ((backpack _x) isNotEqualTo "") then {
               [_x] call FUNC(actionOnChest);
          };
          if (_backpackClass != "") then {
               _x addBackpackGlobal _backpackClass;
          };
     } forEach _units;
};
