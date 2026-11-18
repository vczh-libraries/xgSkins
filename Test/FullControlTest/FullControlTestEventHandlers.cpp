#include "FullControlTestEventHandlers.h"
#include <Skins/DarkSkin/DarkSkin.h>

using namespace vl;

namespace demo
{
	void InitializeFctSkinItems(const Func<void(const WString&, const Func<void()>&, bool)>& addItem)
	{
		addItem(L"DarkSkin", [] { darkskin::SetColorPackage(darkskin::CreateDefaultColorPackage()); }, true);
	}
}
