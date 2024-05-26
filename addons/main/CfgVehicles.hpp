class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class ArgumentsBaseUnits {
            class Units;
        };
        class ModuleDescription {
            class AnyBrain;
        };
    };
    class GVAR(ModuleAdd): Module_F {
        scope = 2;
        displayName = CSTRING(ModuleAdd_Displayname);
        icon = QPATHTOF(data\moduleAdd.paa);
        category = "bocr";
        function = QFUNC(moduleAdd);
        functionPriority = 0;
        isGlobal = 0;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
        author = "DerZade & mjc4wilton";
        class Arguments : ArgumentsBaseUnits {
            class Units: Units {};
            class classname {
                displayName = "Chestpack classname"; // Argument label
                description = "Classname of the disered chestpack"; // Tooltip description
                typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = "B_Carryall_cbr";
            };
            class items {
                displayName = "Chestpack Loadout Array";
                description = "items stored within the chestpack formatted as a sub-array of a Unit Loadout Array.";
                typeName = "STRING";
                defaultValue = "[]";
            };
            class variables {
                displayName = "Chestpack variables";
                description = "Variables assigned to the chestpack as [""var_name"", var_value]";
                typeName = "STRING";
                defaultValue = "[]";
            };
            class code {
                displayName = "Additional code";
                description = "Any addition code to modify the chestpack. '_this' referes to the chestpack itself."; // Argument label
                typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = "";
            };
        };
        class ModuleDescription : ModuleDescription {
            sync[]={"AnyPerson1","AnyPerson2"};
            description = CSTRING(ModuleAdd_Description);
            class AnyPerson1 {
                description = "Short description";
                displayName = "Any BLUFOR unit"; // Custom name
                icon = "iconMan"; // Custom icon (can be file path or CfgVehicleIcons entry)
                side = 1; // Custom side (will determine icon color)
            };
            class AnyPerson2 : AnyPerson1 {};
        };
    };
    class GVAR(ModuleOnChest): Module_F {
        scope = 2;
        displayName = CSTRING(ModuleOnChest_Displayname);
        icon = QPATHTOF(data\moduleOnChest.paa);
        category = "bocr";
        function = QFUNC(moduleOnChest);
        functionPriority = 0;
        isGlobal = 0;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
        author = "DerZade & mjc4wilton";
        class Arguments : ArgumentsBaseUnits {
            class Units: Units {};
            class classname {
                displayName = "Backpack classname"; // Argument label
                description = "Classname of the backpack which should be added after putting the backpack on chest."; // Tooltip description
                typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = "B_Parachute";
            };
            class delay {
                displayName = "Delay"; // Argument label
                description = ""; // Tooltip description
                typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = 0;
            };
        };
        class ModuleDescription : ModuleDescription {
            sync[]={"AnyPerson1","AnyPerson2"};
            description = CSTRING(ModuleOnChest_Description);
            class AnyPerson1 {
                description = "Short description";
                displayName = "Any BLUFOR unit"; // Custom name
                icon = "iconMan"; // Custom icon (can be file path or CfgVehicleIcons entry)
                side = 1; // Custom side (will determine icon color)
            };
            class AnyPerson2 : AnyPerson1 {};
        };
    };
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class GVAR(onChest) {
                    displayName = CSTRING(OnChest);
                    condition = QUOTE([_player] call FUNC(canMovePack) && {!(backpack _player isEqualTo '') && (([_player] call FUNC(chestpack)) isEqualTo '')});
                    exceptions[] = {"isNotInside"};
                    statement = QUOTE([_player] call FUNC(actionOnChest));
                    showDisabled = 0;
                    priority = 2.5;
                    icon = QPATHTOF(ui\onchest_ca.paa);
                };
                class GVAR(onBack) : GVAR(onChest) {
                    displayName = CSTRING(OnBack);
                    condition = QUOTE([_player] call FUNC(canMovePack) && {(backpack _player isEqualTo '') && !(([_player] call FUNC(chestpack)) isEqualTo '')});
                    statement = QUOTE([_player] call FUNC(actionOnBack));
                    icon = QPATHTOF(ui\onback_ca.paa);
                };
                class GVAR(swap) : GVAR(onChest) {
                    displayName = CSTRING(Swap);
                    condition = QUOTE([_player] call FUNC(canMovePack) && {!(backpack _player isEqualTo '') && !(([_player] call FUNC(chestpack)) isEqualTo '')});
                    statement = QUOTE([_player] call FUNC(actionSwap));
                    icon = QPATHTOF(ui\swap_ca.paa);
                };
                class GVAR(lower) : GVAR(onChest) {
                    displayName = CSTRING(lower);
                    condition = QUOTE([_player] call FUNC(canLower));
                    statement = QUOTE([_player] call FUNC(actionLower));
                };
                class GVAR(cutLoweringLine) : GVAR(onChest) {
                    displayName = CSTRING(cutLoweringLine);
                    condition = QUOTE([_player] call FUNC(canCutLoweringLine));
                    statement = QUOTE([_player] call FUNC(actionCutLoweringLine));
                };
            };
        };
    };
};
