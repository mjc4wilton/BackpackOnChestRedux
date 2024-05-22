// CBA Settings [ADDON: bocr_main]:

[
    QGVAR(disabled), "CHECKBOX",
    [LSTRING(Disable), LSTRING(Disable_Description)],
    "Backpack On Chest",
    false, // default value
    true // isGlobal
] call CBA_fnc_addSetting;

[
    QGVAR(walk), "CHECKBOX",
    [LSTRING(Walk), LSTRING(Walk_Description)],
    "Backpack On Chest",
    true, // default value
    true // isGlobal
] call CBA_fnc_addSetting;

// Blacklisted variables for mods that don't want variables to be transferred. Useful for very particular cases.
GVAR(VarBlacklist) = [

];
