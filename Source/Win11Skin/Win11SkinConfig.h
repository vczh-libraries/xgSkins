#ifndef VCZH_PRESENTATION_WIN11SKINCONFIG
#define VCZH_PRESENTATION_WIN11SKINCONFIG

#include "Source/Win11Skin.h"

namespace win11skin
{
	extern ColorPackage CreateDefaultColorPackage();
	extern ColorPackage CreateDarkColorPackage();
	extern void SetColorPackage(const ColorPackage& colors);
}

#endif
