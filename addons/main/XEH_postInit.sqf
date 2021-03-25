#include "script_component.hpp"

[] call FUNC(arsenal_postInit);

// These events try to optimize network usage
// by sending a single CBA Event then each machine running local commands,
// as opposed to 4 global commands for a single backpack when using
//      clearItemCargoGlobal _container;
//      clearWeaponCargoGlobal _container;
//      clearMagazineCargoGlobal _container;
//      clearBackpackCargoGlobal _container;
// and 4 per backpack when clearing backpacks created inside a backpack.
// Clear inventory of a container
[QGVAR(clearAllCargo), {call FUNC(clearAllCargo)}] call CBA_fnc_addEventHandler;
// Clear inventory of every backpack in a container
[QGVAR(clearCargoBackpacks), {call FUNC(clearCargoBackpacks)}] call CBA_fnc_addEventHandler;

if (isServer) then {
    [QGVAR(handleDisconnect), {
        addMissionEventHandler ["HandleDisconnect", FUNC(EHHandleDisconnect)];
    }] call CBA_fnc_addEventHandler;

    // PFH to check when the helper object _ropeTop and the WeaponHolderSimulated
    // holding the backpack have landed
    [QGVAR(checkLandedPFH), {
        params ["_ropeTop", "_holder"];
        [{
            params ["_ropeTop", "_pfhID"];
            if (speed _ropeTop < 1 && {getPos _ropeTop # 2 < 1}) exitWith {
                deleteVehicle _ropeTop;
                [_pfhID] call CBA_fnc_removePerFrameHandler;
            };
        }, 1, _ropeTop] call CBA_fnc_addPerFrameHandler;
        [{
            params ["_holder", "_pfhID"];
            if (speed _holder < 1 && {getPos _holder # 2 < 1}) exitWith {
                private _pos = getPos _holder;
                _pos set [2, 0];
                _holder setPos _pos;
                [_pfhID] call CBA_fnc_removePerFrameHandler;
            };
        }, 1, _holder] call CBA_fnc_addPerFrameHandler;
    }] call CBA_fnc_addEventHandler;
};

// Backpack classnames which will be made invisible instead of being made a chestpack. Useful for items like the vanilla legstrap.
GVAR(exceptions) = [
    "B_LegStrapBag_black_F",
    "B_LegStrapBag_coyote_F",
    "B_LegStrapBag_olive_F",
    "rhs_medic_bag"
];
