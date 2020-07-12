#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Adds a chestpack to a unit. If a unit already has one, the old chestpack will be ignored and will be deleted completely.
 *
 * Arguments:
 * 0: Unit  <OBJECT>
 * 1: Backpack Classname <STRING>
 * 2: Backpack Loadout <ARRAY>
 * 3: Backpack Variables <ARRAY>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, "B_Kitbag_rgr", ["FirstAidKit", 5], ["ace_gunbag_gunbagWeapon", "srifle_GM6_F"]] call bocr_main_fnc_addChestpack;
 *
 * Public: No
 */
params ["_unit","_chestpackClass","_backpackLoadout","_backpackVariables", "_backpackLoad"];

//add HandleDisconnect-EH on server if not done yet
if !(GETMVAR(GVAR(HDCEHadded), false)) then {
     [[[],{addMissionEventHandler ["HandleDisconnect", FUNC(EHHandleDisconnect)];}], "BIS_fnc_call", false] call BIS_fnc_MP;
     GVAR(HDCEHadded) = true;
     publicVariable QGVAR(HDCEHadded);
};

//delete existing chestpack, if there is one
if ([_unit] call FUNC(chestpack) != "") then {
     [_unit] call FUNC(removeChestpack);
};

//add EHs
private _getInID = _unit addEventHandler ["GetInMan",FUNC(EHGetIn)];
private _getOutID = _unit addEventHandler ["GetOutMan",FUNC(EHGetOut)];
private _animID = _unit addEventHandler ["AnimDone",FUNC(EHAnimDone)];
private _killedID = _unit addEventHandler ["Killed",FUNC(EHKilled)];

//create chestpack itself
private _chestpack = createSimpleObject [_chestpackClass, getPos _unit];

[_unit, "forceWalk", "BackpackOnChest", true] call ace_common_fnc_statusEffect_set;

//set variable
SETPVAR(_unit, GVAR(chestpack), [[_chestpackClass, _chestpack], [_getInID, _getOutID, _animID, _killedID], _backpackLoadout, _backpackVariables, _backpackLoad]);

//execute vehicle shit
if !(vehicle _unit isEqualTo _unit) then {
    [_unit, "", vehicle _unit] call FUNC(EHGetIn);
} else {
    [_unit, "", objNull] call FUNC(EHGetOut);
};
