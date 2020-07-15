#include "script_component.hpp"
#define REDIRECT_PATH QPATHTOF(functions\fnc_legacyRedirect.sqf)

class CfgFunctions {
    class zade_boc {
        tag = "zade_boc";
        class zade_boc {
            class actionOnBack{file=REDIRECT_PATH};
            class actionOnChest{file=REDIRECT_PATH};
            class actionSwap{file=REDIRECT_PATH};
            class addChestpack{file=REDIRECT_PATH};
            class addItemToChestpack{file=REDIRECT_PATH};
            class addMagToChestpack{file=REDIRECT_PATH};
            class canAddItemToChestpack{file=REDIRECT_PATH};
            class chestpack{file=REDIRECT_PATH};
            class chestpackContainer{file=REDIRECT_PATH};
            class chestpackItems{file=REDIRECT_PATH};
            class chestpackMagazines{file=REDIRECT_PATH};
            class clearAllItemsFromChestpack{file=REDIRECT_PATH};
            class loadChestpack{file=REDIRECT_PATH};
            class removeChestpack{file=REDIRECT_PATH};
            class removeItemFromChestpack{file=REDIRECT_PATH};
            class removeMagFromChestpack{file=REDIRECT_PATH};

            class moduleAdd{file=REDIRECT_PATH};
            class moduleOnChest{file=REDIRECT_PATH};
            class moduleDisable{file=REDIRECT_PATH};
        };
    };
};
