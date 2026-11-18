#include "Win7SkinConfig.h"

namespace win7skin
{
	ColorPackage CreateDefaultColorPackage()
	{
		return vl_workflow_global::Win7Skin::Instance().CreateDefaultColorPackage();
	}

	void SetColorPackage(const ColorPackage& colors)
	{
		Theme::SetColorPackage(colors);
	}
}
