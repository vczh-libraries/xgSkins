#include "WinVistaSkinConfig.h"

namespace winvistaskin
{
	ColorPackage CreateDefaultColorPackage()
	{
		return vl_workflow_global::WinVistaSkin::Instance().CreateDefaultColorPackage();
	}

	void SetColorPackage(const ColorPackage& colors)
	{
		Theme::SetColorPackage(colors);
	}
}
