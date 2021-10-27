#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton, GhostIsSpooky
 * Called by XEH_postInit. Creates button.
 *
 * Arguments:
 * 0: Arsenal Display <DISPLAY>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [_disp] call bocr_main_fnc_arsenal_opened;
 *
 * Public: No
 */
params ["_display"];

#define IDC_tabLeft 20
#define IDC_buttonPrimaryWeapon 2002

#define pixelScale  0.25
#define GRID_W (pixelW * pixelGridNoUIScale * pixelScale)
#define GRID_H (pixelH * pixelGridNoUIScale * pixelScale)

// exit if BOC is disabled
if (GVAR(disabled)) exitWith {};

private _btn = _display ctrlCreate ["RscButtonArsenal", 9233];

// set position
ctrlPosition (_display displayCtrl IDC_buttonPrimaryWeapon) params ["_xPos", "", "_wPos", "_hPos"];
_btn ctrlSetPosition [safeZoneX + GRID_W, (safeZoneY + (8 * GRID_H)) + (200 * GRID_H), _wPos, _hPos];
_btn ctrlCommit 0;

// set color
_btn ctrlSetBackgroundColor [0,0,0,0.5];

// add EH to backpack list and to newly created button
(_display displayCtrl IDC_leftTabContent) ctrlAddEventHandler ["LBSelChanged",FUNC(ace_arsenal_updateUI)];
_btn ctrlAddEventHandler ["ButtonClick",FUNC(ace_arsenal_onButtonClick)];

// this is for hiding the button when the rest of the ui is hidden (e.g. by pressing BACKSPACE)
_display displayAddEventHandler ["KeyDown", "0 = _this spawn {sleep 0.02; ((_this select 0) displayCtrl 9233) ctrlShow (ctrlShown ((_this select 0) displayCtrl 20));};"];
_display displayAddEventHandler ["MouseButtonUp", "0 = _this spawn {sleep 0.02; ((_this select 0) displayCtrl 9233) ctrlShow (ctrlShown ((_this select 0) displayCtrl 20));};"];

[_display] call FUNC(ace_arsenal_updateUI);
