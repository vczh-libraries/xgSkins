#include "FullControlTestEventHandlers.h"
#include <Skins/DarkSkin/DarkSkin.h>
#include "../../Source/Win7Skin/Win7SkinConfig.h"
#include "../../Source/Win8Skin/Win8SkinConfig.h"
#include "../../Source/WinXPSkin/WinXPSkinConfig.h"

using namespace vl;

namespace demo
{
	// DarkSkin supplies its ordinary menu factory to buttons. GacUI copies that
	// factory into each new popup, which would pin it across showcase skin changes.
	template<typename T>
	void UseThemeMenu(presentation::TemplateProperty<T>& createTemplate)
	{
		createTemplate = [createTemplate](const reflection::description::Value& value)
		{
			auto controlTemplate = createTemplate(value);
			controlTemplate->SetSubMenuTemplate({});
			return controlTemplate;
		};
	}

	void RegisterFctDarkSkin()
	{
		darkskin::SetColorPackage(darkskin::CreateDefaultColorPackage());
		auto skin = Ptr(new darkskin::Theme);
		UseThemeMenu(skin->ComboBox);
		UseThemeMenu(skin->DateComboBox);
		UseThemeMenu(skin->MenuBarButton);
		UseThemeMenu(skin->MenuItemButton);
		UseThemeMenu(skin->ToolstripButton);
		UseThemeMenu(skin->ToolstripDropdownButton);
		UseThemeMenu(skin->ToolstripSplitButton);
		UseThemeMenu(skin->RibbonSmallButton);
		UseThemeMenu(skin->RibbonSmallDropdownButton);
		UseThemeMenu(skin->RibbonSmallSplitButton);
		UseThemeMenu(skin->RibbonLargeButton);
		UseThemeMenu(skin->RibbonLargeDropdownButton);
		UseThemeMenu(skin->RibbonLargeSplitButton);
		presentation::theme::UnregisterTheme(L"DarkSkin");
		presentation::theme::RegisterTheme(skin);
	}

	void InitializeFctSkinItems(const Func<void(const WString&, const Func<void()>&, bool)>& addItem)
	{
		addItem(L"DarkSkin", &RegisterFctDarkSkin, true);
		addItem(L"Win7Skin", []
		{
			win7skin::SetColorPackage(win7skin::CreateDefaultColorPackage());
			presentation::theme::UnregisterTheme(L"Win7Skin");
			presentation::theme::RegisterTheme(Ptr(new win7skin::Theme));
		}, false);
		addItem(L"Win8Skin", []
		{
			win8skin::SetColorPackage(win8skin::CreateDefaultColorPackage());
			presentation::theme::UnregisterTheme(L"Win8Skin");
			presentation::theme::RegisterTheme(Ptr(new win8skin::Theme));
		}, false);
		addItem(L"WinXPSkin", []
		{
			winxpskin::SetColorPackage(winxpskin::CreateDefaultColorPackage());
			presentation::theme::UnregisterTheme(L"WinXPSkin");
			presentation::theme::RegisterTheme(Ptr(new winxpskin::Theme));
		}, false);
	}
}
