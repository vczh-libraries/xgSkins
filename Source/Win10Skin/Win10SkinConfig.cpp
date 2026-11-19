#include "Win10SkinConfig.h"

namespace win10skin
{
	ColorPackage CreateDefaultColorPackage()
	{
		return vl_workflow_global::Win10Skin::Instance().CreateDefaultColorPackage();
	}

	ColorPackage CreateDarkColorPackage()
	{
		return vl_workflow_global::Win10Skin::Instance().CreateDarkColorPackage();
	}

	void SetColorPackage(const ColorPackage& colors)
	{
		Theme::SetColorPackage(colors);
	}
}
