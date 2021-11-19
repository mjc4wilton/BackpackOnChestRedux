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
_chute setVariable [QGVAR(loweringLine), objNull, true];

if (!isNull _ropeTop) then {
    private _rope = ropes _ropeTop # 0;
    private _attachedObjects = ropeAttachedObjects _ropeTop;
    if (_attachedObjects isEqualTo []) then {
        deleteVehicle _ropeTop;
    } else {
        private _holder = _attachedObjects # 0;
        _holder ropeDetach _rope;
        // ace_fastroping_helper is a helicopter and kind of autorotates down instead
        // of falling, much slower than a falling object. Attaching to the holder
        // also looks like the rope snapping under tension once cut
        [{
            params ["_ropeTop", "_holder"];
            _ropeTop attachTo [_holder, [0.1,-0.45,-0.6]];
        }, [_ropeTop, _holder]] call CBA_fnc_execNextFrame;
    };
};
