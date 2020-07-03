/*
 * Author: DerZade, mjc4wilton
 * Triggered by the swap-action. Handles all the stuff.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player] call bocr_main_fnc_actionSwap;
 *
 * Public: No
 */
params ["_player"];

private _backpack = backpack _player;
private _backpackItemsRaw = backpackItems _player;
private _backpackItemsStorable = [];
private _backpackVariablesRaw = allVariables _backpack;
private _backpackVariablesStorable = [];

private _chestpack = [_player] call FUNC(chestpack);
private _chestpackItems =  [_player,false] call FUNC(chestpackItems);
private _chestpackVariables = [_player] call FUNC(chestpackVariables);

//make sure the player has chest- and backpack
if ((_backpack isEqualTo "") or ([_player] call FUNC(chestpack)) isEqualTo "") exitWith {};

//Backpack Variable Handling
{
    private _val = _backpack getVariable _x;
    _backpackVariablesStorable pushback [_x, _val];
} forEach _backpackVariablesRaw;

//Backpack Mag Handling
{
    _mag = _x;
    _classname = "";
    _displayname = "";

    {
        _displayName = getText (configFile >> "CfgMagazines" >> _x >> "DisplayName");
        if ((_mag find _displayname)!=(-1) and _displayName != "") exitWith {_classname = _x;};
    } forEach (backpackItems _player);

    _arr = _x splitString "(";
    _size = count _arr;
    _temp = (_arr select (_size-2)) splitString "/";
    _ammo = parseNumber (_temp select 0);
    _temp = (_arr select (_size-1)) splitString "x";
    _amount = parseNumber (_temp select 0);

    _backpackItemsStorable pushBack [1,_classname,_ammo,_amount];
} forEach (backpackMagazines _player);

//Remove mags from _backpackItemsRaw before they are duplicated
{
    if(_x select 0 == 1) do {
        for "_i" from 1 to (_x select 3) do {
            _backpackItemsRaw deleteAt (_backpackItemsRaw find (_x select 1));
        };
    };
} forEach _backpackItemsStorable;

//Backpack Weapon Handling
{
     //remove weapon
     _backpackItemsRaw deleteAt (_backpackItemsRaw find (_x select 0));

     //Handle individual items
     private _weapon = (_x select 0);
     private _muzzle = (_x select 1);
     private _flashlight = (_x select 2);
     private _optics = (_x select 3);
     private _primaryMuzzleMagazine = (_x select 4);
     private _secondaryMuzzleMagazine = (_x select 5);
     private _bipod = (_x select 6);

     _backpackItemsStorable pushBack [2, _weapon, _muzzle, _flashlight, _optics, _primaryMuzzleMagazine, _secondaryMuzzleMagazine, _bipod];

} forEach weaponsItems (backpackContainer _player);

//Backpack Item Handling
{
    _backpackItemsStorable pushBack [0, _x]
} forEach _backpackItemsRaw;

//remove packs and copy radio settings before removing backpack
[_player] call FUNC(removeChestpack);
removeBackpackGlobal _player;

//add backpack
_player addBackpackGlobal _chestpack;
clearAllItemsFromBackpack _player;
private _backpackNew = backpackContainer _player;

//add backpack items
{
    switch (_x select 0) do {
        case (0): {
            _backpackNew addItemCargoGlobal [(_x select 1),1];
        };
        case (1): {
            _backpackNew addMagazineAmmoCargo [(_x select 1), (_x select 3), (_x select 2)];
        };
        case (2): {
            _backpackNew addWeaponWithAttachmentsCargoGlobal [[(_x select 1), (_x select 2), (_x select 3), (_x select 4), (_x select 5), (_x select 6), (_x select 7)], 1];
        };
    };
} forEach _chestpackItems;

//add variables
{
     _backpack setVariable [(_x select 0), (_x select 1), true];
} forEach _chestpackVariables;

//add chestpack
[_player, _backpack, _backpackItemsStorable, _backpackVariablesStorable] call FUNC(addChestpack);
