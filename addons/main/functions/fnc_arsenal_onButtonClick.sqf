#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Triggered by the onButtonClick-EventHandler.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [] call bocr_main_fnc_arsenal_onButtonClick;
 *
 * Public: No
 */
private _center = missionnamespace getvariable ["BIS_fnc_arsenal_center", player];

private _chestpack = [_center] call FUNC(chestpack);
private _backpack = backpack _center;

private _action = ["onback", "onchest"] select (_chestpack isEqualTo "");
if (!(_backpack isEqualTo "") and !(_chestpack isEqualTo "")) then {_action = "swap";};

//execute action
switch (_action) do {
    case ("onback"): {
        [_center] call FUNC(actionOnBack);
    };
    case ("onchest"): {
        [_center] call FUNC(actionOnChest);
    };
    case ("swap"): {
        [_center] call FUNC(actionSwap);
    };
};

//update arsenal
["ListSelectCurrent"] call BIS_fnc_arsenal;
