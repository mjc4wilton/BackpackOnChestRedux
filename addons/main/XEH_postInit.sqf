#include "script_component.hpp"

[] call FUNC(arsenal_postInit);

if (isServer) then {
    [QGVAR(handleDisconnect), {
        addMissionEventHandler ["HandleDisconnect", FUNC(EHHandleDisconnect)];
    }] call CBA_fnc_addEventHandler;
};

// Backpack classnames which will be made invisible instead of being made a chestpack. Useful for items like the vanilla legstrap.
GVAR(exceptions) = [
    "B_LegStrapBag_black_F",
    "B_LegStrapBag_coyote_F",
    "B_LegStrapBag_olive_F",
    "rhs_medic_bag"
];
