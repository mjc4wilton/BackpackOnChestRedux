class ace_arsenal_actions {
    class ADDON {
        displayName = CSTRING(ModuleOnChest_Displayname);
        condition = QUOTE(_player call FUNC(canMovePack));
        //scopeEditor = 0; // variables are reset between 3DEN and mission start
        tabs[] = {5};
        /*
        class GVAR(status) {
            textStatement = QUOTE([_this select 0] call FUNC(weaponName));
        };
        */
        class GVAR(onChest) {
            label = CSTRING(OnChest);
            condition = QUOTE(_player call FUNC(canMovePack) && {backpack _player != ''} && {_player call FUNC(chestpack) == ''});
            statement = QUOTE(_player call FUNC(actionOnChest));
        };
        class GVAR(onBack) {
            label = CSTRING(OnBack);
            condition = QUOTE(_player call FUNC(canMovePack) && {backpack _player == ''} && {_player call FUNC(chestpack) != ''});
            statement = QUOTE(_player call FUNC(actionOnBack));
        };
        class GVAR(swap) {
            label = CSTRING(Swap);
            condition = QUOTE(_player call FUNC(canMovePack) && {backpack _player != ''} && {_player call FUNC(chestpack) != ''});
            statement = QUOTE(_player call FUNC(actionSwap));
        };
    };
};
