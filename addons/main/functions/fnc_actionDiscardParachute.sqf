#include "script_component.hpp"
/*
 * Author: Ampersand
 * Triggered by the discard-reserve-action.
 * Puts the reserve parachute into WeaponHolderSimulated to sink and
 * moves the chestpack to back if present.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player] call bocr_main_fnc_actionDiscardParachute;
 *
 * Public: No
 */
params ["_unit"];

private _holder = createVehicle ["WeaponHolderSimulated", [0, 0, 0], [], 0, "CAN_COLLIDE"];
_holder addBackpackCargoGlobal [backpack _unit, 1];
removeBackpack _unit;
_holder setPosASL (getPosASL _unit vectorAdd vectorDir _unit);

[QGVAR(floatPack), [_holder]] call CBA_fnc_globalEvent;

private _chestpack = [_unit] call FUNC(chestpack);
if (_chestpack != "") then {
    [_unit] call FUNC(actionOnBack);
};
