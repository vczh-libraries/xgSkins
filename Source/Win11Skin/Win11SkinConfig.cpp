#include "Win11SkinConfig.h"

namespace win11skin
{
	ColorPackage CreateDefaultColorPackage()
	{
		return vl_workflow_global::Win11Skin::Instance().CreateDefaultColorPackage();
	}

	ColorPackage CreateDarkColorPackage()
	{
		return vl_workflow_global::Win11Skin::Instance().CreateDarkColorPackage();
	}

	void SetColorPackage(const ColorPackage& colors)
	{
		Theme::SetColorPackage(colors);
	}
}
