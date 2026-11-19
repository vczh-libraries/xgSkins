#include "UbuntuSkinConfig.h"

namespace ubuntuskin
{
	ColorPackage CreateDefaultColorPackage()
	{
		return vl_workflow_global::UbuntuSkin::Instance().CreateDefaultColorPackage();
	}

	void SetColorPackage(const ColorPackage& colors)
	{
		Theme::SetColorPackage(colors);
	}
}
