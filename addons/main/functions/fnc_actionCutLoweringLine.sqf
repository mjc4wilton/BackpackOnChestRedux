#include "script_component.hpp"
/*
 * Author: Ampersand
 * Triggered by the CutLoweringLine-action. Detaches the lowering line top
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player] call bocr_main_fnc_actionCutLoweringLine;
 *
 * Public: No
 */

params ["_unit"];
private _chute = vehicle _unit;
private _ropeTop = _chute getVariable [QGVAR(loweringLine), objNull];

if (!isNull _ropeTop) then {
    private _rope = ropes _ropeTop # 0;
    private _holder = ropeAttachedObjects _ropeTop # 0;
    _holder ropeDetach _rope;
    _ropeTop attachTo [_holder, [0.1,-0.45,-0.6]];

    _chute setVariable [QGVAR(loweringLine), objNull, true];
};
