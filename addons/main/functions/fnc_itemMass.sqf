#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Finds mass of given item.
 *
 * Arguments:
 * 0: Item  <STRING>
 *
 * Return Value:
 * Item mass <NUMBER>
 *
 * Example:
 * ["FirstAidKit"] call bocr_main_fnc_itemMass;
 *
 * Public: No
 */
params ["_item"];

if (isClass (configFile>>"CfgWeapons">> _item >> "ItemInfo")) exitWith {
     getNumber(configFile>>"CfgWeapons">> _item >> "ItemInfo" >> "Mass");
};
if (isClass (configFile>>"CfgWeapons">> _item >> "WeaponSlotsInfo")) exitWith {
     getNumber(configFile>>"CfgWeapons">> _item >> "WeaponSlotsInfo" >> "Mass")
};
if (isClass (configFile>>"CfgMagazines">> _item)) exitWith {
     getNumber(configFile>>"CfgMagazines">> _item >> "Mass");
};
if (isClass (configFile>>"CfgVehicles">> _item)) exitWith  {
     getNumber(configFile>>"CfgVehicles">> _item >> "Mass");
};
if (isClass (configFile>>"CfgGlasses">> _item)) exitWith  {
     getNumber(configFile>>"CfgGlasses">> _item >> "Mass");
};
