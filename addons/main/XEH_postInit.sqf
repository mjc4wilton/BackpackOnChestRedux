#include "script_component.hpp"

[] call FUNC(arsenal_postInit);

if (isServer) then {
    [QGVAR(handleDisconnect), {
        addMissionEventHandler ["HandleDisconnect", FUNC(EHHandleDisconnect)];
    }] call CBA_fnc_addEventHandler;

    [QGVAR(initHelper), {
        params ["_ropeTop", "_holder"];
        _ropeTop addEventHandler ["EpeContactStart", {
            params ["_object1"];
            deleteVehicle _object1;
        }];
        _holder addEventHandler ["EpeContactStart", {
            params ["_object1"];
            {
                detach _x;
            } forEach attachedObjects _object1;
            _object1 removeEventHandler ["EpeContactStart", _thisEventHandler];
        }];
    }] call CBA_fnc_addEventHandler;
};

// Backpack classnames which will be made invisible instead of being made a chestpack. Useful for items like the vanilla legstrap.
GVAR(exceptions) = [
    "B_LegStrapBag_black_F",
    "B_LegStrapBag_coyote_F",
    "B_LegStrapBag_olive_F",
    "rhs_medic_bag"
];
