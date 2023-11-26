#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_common"};
        author = "";
        authors[] = {"DerZade", "mjc4wilton"};
        authorUrl = "https://github.com/mjc4wilton/BackpackOnChestRedux";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgModuleCategories.hpp"
#include "CfgVehicles.hpp"
#include "CfgFunctions.hpp"

#include "ACE_Arsenal_Actions.hpp"
