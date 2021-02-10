#include "script_component.hpp"
/*
 * Author: DerZade, mjc4wilton
 * Triggerd by HandleDisconnect-Eventhandler on Server.
 * Handles deleting the chestpack of old units form disconnected players.
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * _this call bocr_main_fnc_EHHandleDisconnect;
 *
 * Public: Yes
 */
params ["_unit", "_id", "_uid", "_name"];

if !([_unit] call FUNC(chestpack) isEqualTo "") then {
     [[_unit] call FUNC(chestpackContainer), _unit] spawn {
          params ["_container","_unit"];
          sleep 1.5;
          if !(alive _unit) then {
               deleteVehicle _container;
          };
     };
};
