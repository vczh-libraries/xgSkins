#include "FullControlTestEventHandlers.h"
#include <Skins/DarkSkin/DarkSkin.h>
#include "../../Source/Win7Skin/Win7SkinConfig.h"

using namespace vl;

namespace demo
{
	void InitializeFctSkinItems(const Func<void(const WString&, const Func<void()>&, bool)>& addItem)
	{
		addItem(L"DarkSkin", []
		{
			darkskin::SetColorPackage(darkskin::CreateDefaultColorPackage());
			presentation::theme::UnregisterTheme(L"DarkSkin");
			presentation::theme::RegisterTheme(Ptr(new darkskin::Theme));
		}, true);
		addItem(L"Win7Skin", []
		{
			win7skin::SetColorPackage(win7skin::CreateDefaultColorPackage());
			presentation::theme::UnregisterTheme(L"Win7Skin");
			presentation::theme::RegisterTheme(Ptr(new win7skin::Theme));
		}, false);
	}
}
