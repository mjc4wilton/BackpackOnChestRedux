#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Called when backpack of arsenal unit changes. Updates Button icon / tooltip.
 *
 * Arguments:
 * 0: Arsenal Display <DISPLAY>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [_disp] call bocr_main_fnc_arsenal_updateUI;
 *
 * Public: No
 */
disableSerialization;
params ["_display"];

if (_display isEqualType controlNull) exitWith {  // the onSelChanged EH calls before the actual backpack changed so we have to wait a little bit
    [ctrlParent _display] spawn {sleep 0.05; _this call FUNC(ace_arsenal_updateUI)};
};

// the arsenal unit
private _center = missionnamespace getvariable ["ace_arsenal_center",player];

private _chestpack = [_center] call FUNC(chestpack);
private _backpack = backpack _center;

private _action = ["onBack", "onChest"] select (_chestpack isEqualTo "");
if (!(_backpack isEqualTo "") and !(_chestpack isEqualTo "")) then {_action = "swap";};

switch (_action) do {
    case ("onBack"): {
        (_display displayCtrl 9233) ctrlSetText QPATHTOF(ui\onback_ca.paa);
        (_display displayCtrl 9233) ctrlSetTooltip LLSTRING(OnBack);
    };
    case ("onChest"): {
        (_display displayCtrl 9233) ctrlSetText QPATHTOF(ui\onchest_ca.paa);
        (_display displayCtrl 9233) ctrlSetTooltip LLSTRING(OnChest);
    };
    case ("swap"): {
        (_display displayCtrl 9233) ctrlSetText QPATHTOF(ui\swap_ca.paa);
        (_display displayCtrl 9233) ctrlSetTooltip LLSTRING(Swap);
    };
};

if ((_backpack isEqualTo "") and (_chestpack isEqualTo "")) then {
    (_display displayCtrl 9233) ctrlEnable false;
    (_display displayCtrl 9233) ctrlSetTooltip "";
} else {
    (_display displayCtrl 9233) ctrlEnable true;
};
