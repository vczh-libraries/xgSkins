#include "Win8SkinConfig.h"

namespace win8skin
{
	ColorPackage CreateDefaultColorPackage()
	{
		return vl_workflow_global::Win8Skin::Instance().CreateDefaultColorPackage();
	}

	void SetColorPackage(const ColorPackage& colors)
	{
		Theme::SetColorPackage(colors);
	}
}
