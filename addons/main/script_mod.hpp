// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp

#define MAINPREFIX z
#define PREFIX backpackonchestredux

#include "script_version.hpp"

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

#define BACKPACKONCHESTREDUX_TAG BACKPACKONCHESTREDUX

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.56

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(backpackonchestredux - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(backpackonchestredux - COMPONENT)
#endif
