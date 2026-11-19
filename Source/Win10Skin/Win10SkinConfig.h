#ifndef VCZH_PRESENTATION_WIN10SKINCONFIG
#define VCZH_PRESENTATION_WIN10SKINCONFIG

#include "Source/Win10Skin.h"

namespace win10skin
{
	extern ColorPackage CreateDefaultColorPackage();
	extern ColorPackage CreateDarkColorPackage();
	extern void SetColorPackage(const ColorPackage& colors);
}

#endif
