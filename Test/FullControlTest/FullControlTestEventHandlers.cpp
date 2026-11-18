#include "FullControlTestEventHandlers.h"
#include <Skins/DarkSkin/DarkSkin.h>
#include "../../Source/Win7Skin/Win7SkinConfig.h"
#include "../../Source/Win8Skin/Win8SkinConfig.h"
#include "../../Source/WinXPSkin/WinXPSkinConfig.h"

using namespace vl;

namespace demo
{
	void RegisterFctTheme(Ptr<presentation::theme::ThemeTemplates> selected)
	{
		for (auto name : { L"DarkSkin", L"Win7Skin", L"Win8Skin", L"WinXPSkin" })
		{
			presentation::theme::UnregisterTheme(name);
		}
		presentation::theme::RegisterTheme(selected);

		// DarkSkin copies its stock menu template into popups when their owners create them.
		for (auto window : presentation::controls::GetApplication()->GetWindows())
		{
			if (window->GetControlThemeName() == presentation::theme::ThemeName::Menu &&
				window->GetControlTemplate() &&
				dynamic_cast<darkskin::ToolstripMenuTemplate*>(window->GetControlTemplateObject()))
			{
				window->SetControlTemplate({});
			}
		}
	}

	void RegisterFctDarkSkin()
	{
		darkskin::SetColorPackage(darkskin::CreateDefaultColorPackage());
		RegisterFctTheme(Ptr(new darkskin::Theme));
	}

	void InitializeFctSkinItems(const Func<void(const WString&, const Func<void()>&, bool)>& addItem)
	{
		addItem(L"DarkSkin", &RegisterFctDarkSkin, true);
		addItem(L"Win7Skin", []
		{
			win7skin::SetColorPackage(win7skin::CreateDefaultColorPackage());
			RegisterFctTheme(Ptr(new win7skin::Theme));
		}, false);
		addItem(L"Win8Skin", []
		{
			win8skin::SetColorPackage(win8skin::CreateDefaultColorPackage());
			RegisterFctTheme(Ptr(new win8skin::Theme));
		}, false);
		addItem(L"WinXPSkin", []
		{
			winxpskin::SetColorPackage(winxpskin::CreateDefaultColorPackage());
			RegisterFctTheme(Ptr(new winxpskin::Theme));
		}, false);
	}
}
