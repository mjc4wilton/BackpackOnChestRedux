// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp

#define MAINPREFIX x
#define PREFIX bocr

#include "script_version.hpp"

#define VERSION    MAJOR.MINOR
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.58

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(BOCR - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(BOCR - COMPONENT)
#endif
