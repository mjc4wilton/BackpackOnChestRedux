#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Triggered by the onButtonClick-EventHandler.
 *
 * Arguments:
 * 0: Button Ctrl <CONTROL>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [_ctrl] call bocr_main_fnc_arsenal_onButtonClick;
 *
 * Public: No
 */
params ["_ctrl"];

private _center = missionnamespace getvariable ["ace_arsenal_center", player];

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
ace_arsenal_currentItems set [6, backpack _center];
[ctrlParent _ctrl, (ctrlParent _ctrl) displayCtrl ace_arsenal_currentLeftPanel] call ace_arsenal_fnc_fillLeftPanel;
