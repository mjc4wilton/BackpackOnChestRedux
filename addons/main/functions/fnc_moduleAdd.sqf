#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Triggerd by Add-Module
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

params ["_module","_units"];

private _class = _module getVariable "classname";
private _loadout = call compile format ["[%1]",_module getVariable "items"];
private _variables = call compile format ["[%1]",_module getVariable "variables"];
private _code = compile (_module getVariable "code");

{
     private _unit = _x;

     //add chestpack
     [_unit, _class, _loadout, _variables] call FUNC(addChestpack);

     //execute extra code
     ([_unit] call FUNC(chestpackContainer)) spawn _code;
} forEach _units;
