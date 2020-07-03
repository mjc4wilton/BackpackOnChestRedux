class CfgVehicles
{
     class Man;
     class CAManBase: Man
     {
          class ACE_SelfActions
          {
               class ACE_Equipment
               {
                    class Wilton_BOCR_OnChest
                    {
                         displayName = CSTRING(onChest);
                         condition = "";
                         exceptions[] = {"isNotInside"};
                         statement = "[_player] call FUNC(actionOnChest)";
                         showDisabled = 0;
                         priority = 2.5;
                         icon = "\zade_boc\data\actions\onchest_ca.paa";
                    };
                    class Wilton_BOCR_OnBack : Wilton_BOCR_OnChest
                    {
                         displayName = CSTRING(onBack);
                         condition = "!(missionNamespace getVariable ['wilton_bocr_disabled',false]) && (backpack _player isEqualTo '') && !([_player] call wilton_bocr_fnc_chestpack isEqualTo '')";
                         statement = "[_player] call FUNC(actionOnBack)";
                         icon = "\zade_boc\data\actions\onback_ca.paa";
                    };
                    class Wilton_BOCR_Swap : Wilton_BOCR_OnChest
                    {
                         displayName = CSTRING(swap);
                         condition = "!(missionNamespace getVariable ['wilton_bocr_disabled',false]) && !(backpack _player isEqualTo '') && !([_player] call wilton_bocr_fnc_chestpack isEqualTo '')";
                         statement = "[_player] call FUNC(actionSwap)";
                         icon = "\zade_boc\data\actions\swap_ca.paa";
                    };
               };
          };
     };
};
