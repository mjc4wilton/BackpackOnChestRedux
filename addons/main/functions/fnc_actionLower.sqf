#include "script_component.hpp"
/*
 * Author: Ampersand
 * Triggered by the lower-action. Attaches chestpack to a dummy and connects dummy to parachute by rope.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player] call bocr_main_fnc_actionLower;
 *
 * Public: No
 */

params ["_unit"];

private _vehicle = vehicle _unit;
private _pos = getPosASL _vehicle;

// Rope top helper, workaround parachute rope visual bug, allow cut
private _ropeTop = createVehicle ["ace_fastroping_helper", [0, 0, 100], [], 0, "CAN_COLLIDE"];
_vehicle setVariable [QGVAR(loweringLine), _ropeTop, true];
_ropeTop allowDamage false;
_ropeTop disableCollisionWith _vehicle;
_ropeTop setPosASL _pos;

// Weapon holder with backpack
private _holder = [_unit] call FUNC(chestpackToHolder); // Chestpack to holder
_holder disableCollisionWith _vehicle;
_holder attachTo [_chute, [0, 1, -1]];
detach _holder;
_holder setVelocity velocity _chute;

private _rope = ropeCreate [
    _ropeTop, [0,0,0],
    _holder, [0.1,-0.2,-0.55],
    5
];

[{
    params ["_chute", "_ropeTop"];
    _ropeTop attachTo [_chute, [0, 0, 0]];
}, [_chute, _ropeTop]] call CBA_fnc_execNextFrame;

[QGVAR(checkLandedPFH), [_ropeTop, _holder]] call CBA_fnc_serverEvent;
