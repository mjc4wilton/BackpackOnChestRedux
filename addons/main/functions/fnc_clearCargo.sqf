#include "script_component.hpp"
/*
 * Author: Ampersand
 * Clears all the cargo of a container.
 *
 * Arguments:
 * 0: Container <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [_container] call bocr_main_fnc_clearCargo;
 *
 * Public: No
 */

params ["_container"];

clearItemCargoGlobal _container;
clearWeaponCargoGlobal _container;
clearMagazineCargoGlobal _container;
clearBackpackCargoGlobal _container;
