#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * This function is for backwards compatibility. It redirects any of the
 * old function with the prefix 'zade_boc' to the new 'bocr_main' function.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * N/A
 *
 * Example:
 * N/A
 *
 * Public: No
 */
if (_fnc_scriptName isEqualTo "") exitWith {};

private _newFunction = format["bocr_main%1",_fnc_scriptName select [8]];

private _warnMessage = format["'%1' is deprecated and no longer supported. Attempting to use '%2' instead. This may cause errors.", _fnc_scriptName, _newFunction];
WARNING(_warnMessage);
WARNING("Use of deprecated function detected. See https://github.com/mjc4wilton/BackpackOnChestRedux/wiki/Transitioning-from-zade_boc-to-bocr to help migrate to the new functions.");

_this call (missionNamespace getVariable [_newFunction,{}]);
