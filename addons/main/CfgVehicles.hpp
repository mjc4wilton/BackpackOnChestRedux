class CfgVehicles
{
     class Man;
     class CAManBase: Man
     {
          class ACE_SelfActions
          {
               class ACE_Equipment
               {
                    class BOCR_OnChest
                    {
                         displayName = CSTRING(onChest);
                         condition = QUOTE(!(GETMVAR(bocr_disabled, false)) && !(backpack _player isEqualTo '') && ([_player] call FUNC(chestpack) isEqualTo ''));
                         exceptions[] = {"isNotInside"};
                         statement = QUOTE([_player] call FUNC(actionOnChest));
                         showDisabled = 0;
                         priority = 2.5;
                         icon = QPATHOF(ui\onchest_ca.paa);
                    };
                    class BOCR_OnBack : BOCR_OnChest
                    {
                         displayName = CSTRING(onBack);
                         condition = QUOTE(!(GETMVAR(bocr_disabled, false)) && (backpack _player isEqualTo '') && !([_player] call FUNC(chestpack) isEqualTo ''));
                         statement = QUOTE([_player] call FUNC(actionOnBack));
                         icon = QPATHOF(ui\onback_ca.paa);
                    };
                    class BOCR_Swap : BOCR_OnChest
                    {
                         displayName = CSTRING(swap);
                         condition = QUOTE(!(GETMVAR(bocr_disabled, false)) && !(backpack _player isEqualTo '') && !([_player] call FUNC(chestpack) isEqualTo ''));
                         statement = QUOTE([_player] call FUNC(actionSwap));
                         icon = QPATHOF(ui\swap_ca.paa);
                    };
               };
          };
     };
};
