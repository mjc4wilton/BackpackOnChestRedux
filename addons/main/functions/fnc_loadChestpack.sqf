#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Returns current sum of mass from items stored in a chestpack.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Mass <NUMBER>
 *
 * Example:
 * [player] call bocr_main_fnc_loadChestpack;
 *
 * Public: No
 */
params ["_unit"];

private _items = [_unit] call FUNC(chestpackItems);
private _mass = 0;

{

     private _itemMass = 0;
     switch (_x select 0) do {
         case (0): {
             private _itemClass = _x select 1;
             if (isClass (configFile>>"CfgWeapons">> _itemClass >> "ItemInfo")) then {
                  _itemMass = getNumber(configFile>>"CfgWeapons">> _itemClass >> "ItemInfo" >> "Mass");
             };
             if (isClass (configFile>>"CfgWeapons">> _itemClass >> "WeaponSlotsInfo")) then {
                  _itemMass = getNumber(configFile>>"CfgWeapons">> _itemClass >> "WeaponSlotsInfo" >> "Mass")
             };
             if (isClass (configFile>>"CfgMagazines">> _itemClass)) then {
                  _itemMass = getNumber(configFile>>"CfgMagazines">> _itemClass >> "Mass");
             };
             if (isClass (configFile>>"CfgVehicles">> _itemClass)) then  {
                  _itemMass = getNumber(configFile>>"CfgVehicles">> _itemClass >> "Mass");
             };
             if (isClass (configFile>>"CfgGlasses">> _itemClass)) then  {
                  _itemMass = getNumber(configFile>>"CfgGlasses">> _itemClass >> "Mass");
             };
         };
         case (1): {
             private _itemClass = _x select 1;
             for "_i" from 0 to (_x select 3) do {
                 private _itemMassNest = 0;
                 if (isClass (configFile>>"CfgWeapons">> _itemClass >> "ItemInfo")) then {
                      _itemMassNest = getNumber(configFile>>"CfgWeapons">> _itemClass >> "ItemInfo" >> "Mass");
                 };
                 if (isClass (configFile>>"CfgWeapons">> _itemClass >> "WeaponSlotsInfo")) then {
                      _itemMassNest = getNumber(configFile>>"CfgWeapons">> _itemClass >> "WeaponSlotsInfo" >> "Mass")
                 };
                 if (isClass (configFile>>"CfgMagazines">> _itemClass)) then {
                      _itemMassNest = getNumber(configFile>>"CfgMagazines">> _itemClass >> "Mass");
                 };
                 if (isClass (configFile>>"CfgVehicles">> _itemClass)) then  {
                      _itemMassNest = getNumber(configFile>>"CfgVehicles">> _itemClass >> "Mass");
                 };
                 if (isClass (configFile>>"CfgGlasses">> _itemClass)) then  {
                      _itemMassNest = getNumber(configFile>>"CfgGlasses">> _itemClass >> "Mass");
                 };
                 _itemMass = _itemMass + _itemMassNest;
             };
         };
         case (2): {
             for "_i" from 1 to 7 do {
                 private _itemClass = if (!(i == 5 || i == 6)) then {_x select i} else {(_x select i) select 0};
                 private _itemMassNest = 0;
                 if (isClass (configFile>>"CfgWeapons">> _itemClass >> "ItemInfo")) then {
                      _itemMassNest = getNumber(configFile>>"CfgWeapons">> _itemClass >> "ItemInfo" >> "Mass");
                 };
                 if (isClass (configFile>>"CfgWeapons">> _itemClass >> "WeaponSlotsInfo")) then {
                      _itemMassNest = getNumber(configFile>>"CfgWeapons">> _itemClass >> "WeaponSlotsInfo" >> "Mass")
                 };
                 if (isClass (configFile>>"CfgMagazines">> _itemClass)) then {
                      _itemMassNest = getNumber(configFile>>"CfgMagazines">> _itemClass >> "Mass");
                 };
                 if (isClass (configFile>>"CfgVehicles">> _itemClass)) then  {
                      _itemMassNest = getNumber(configFile>>"CfgVehicles">> _itemClass >> "Mass");
                 };
                 if (isClass (configFile>>"CfgGlasses">> _itemClass)) then  {
                      _itemMassNest = getNumber(configFile>>"CfgGlasses">> _itemClass >> "Mass");
                 };
                 _itemMass = _itemMass + _itemMassNest;
             };
         };
     };
     _mass = _mass + _itemMass

} forEach _items;


_mass
