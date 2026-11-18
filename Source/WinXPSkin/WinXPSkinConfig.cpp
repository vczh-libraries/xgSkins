#include "WinXPSkinConfig.h"

namespace winxpskin
{
	ColorPackage CreateDefaultColorPackage()
	{
		return vl_workflow_global::WinXPSkin::Instance().CreateDefaultColorPackage();
	}

	void SetColorPackage(const ColorPackage& colors)
	{
		Theme::SetColorPackage(colors);
	}
}
