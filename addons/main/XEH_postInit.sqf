#include "script_component.hpp"

[] call FUNC(arsenal_postInit);

// Clear inventory of a container
[QGVAR(clearAllCargo), {call FUNC(clearAllCargo)}] call CBA_fnc_addEventHandler;
// Clear inventory of every backpack in a container
[QGVAR(clearCargoBackpacks), {call FUNC(clearCargoBackpacks)}] call CBA_fnc_addEventHandler;

if (isServer) then {
    [QGVAR(handleDisconnect), {
        addMissionEventHandler ["HandleDisconnect", FUNC(EHHandleDisconnect)];
    }] call CBA_fnc_addEventHandler;

    [QGVAR(initHelper), {
        params ["_ropeTop"];
        [{
            params ["_ropeTop", "_pfhID"];
            if (speed _ropeTop < 1 && {getPos _ropeTop # 2 < 1}) exitWith {
                deleteVehicle _ropeTop;
                [_pfhID] call CBA_fnc_removePerFrameHandler;
            };
        }, 1, _ropeTop] call CBA_fnc_addPerFrameHandler;
    }] call CBA_fnc_addEventHandler;
};

// Backpack classnames which will be made invisible instead of being made a chestpack. Useful for items like the vanilla legstrap.
GVAR(exceptions) = [
    "B_LegStrapBag_black_F",
    "B_LegStrapBag_coyote_F",
    "B_LegStrapBag_olive_F",
    "rhs_medic_bag"
];
