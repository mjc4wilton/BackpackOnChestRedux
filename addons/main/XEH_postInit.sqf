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

[QGVAR(floatPack), {call FUNC(floatPack)}] call CBA_fnc_addEventHandler;

if (isServer) then {
    [QGVAR(hideObjectGlobal), {
        params ["_object", "_isHidden"];
        _object hideObjectGlobal _isHidden;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(handleDisconnect), {
        addMissionEventHandler ["HandleDisconnect", FUNC(EHHandleDisconnect)];
    }] call CBA_fnc_addEventHandler;

    // PFH to check when the helper object _ropeTop and the WeaponHolderSimulated
    // holding the backpack have landed
    [QGVAR(checkLandedPFH), {
        params ["_ropeTop", "_holder"];
        _ropeTop addEventHandler ["RopeBreak", {
            //params ["_ropeTop", "_rope", "_holder"];
            deleteVehicle (_this select 0);
        }];
        [{call FUNC(checkLandedPFH)}, 1, _this] call CBA_fnc_addPerFrameHandler;
    }] call CBA_fnc_addEventHandler;
};

// Backpack classnames which will be made invisible instead of being made a chestpack. Useful for items like the vanilla legstrap.
GVAR(exceptions) = [
    "B_LegStrapBag_black_F",
    "B_LegStrapBag_coyote_F",
    "B_LegStrapBag_olive_F",
    "rhs_medic_bag"
];
