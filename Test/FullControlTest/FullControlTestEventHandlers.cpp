#include "FullControlTestEventHandlers.h"
#include <Skins/DarkSkin/DarkSkin.h>
#include "../../Source/Win7Skin/Win7SkinConfig.h"
#include "../../Source/Win8Skin/Win8SkinConfig.h"
#include "../../Source/WinXPSkin/WinXPSkinConfig.h"
#include "../../Source/Win11Skin/Win11SkinConfig.h"
#include "../../Source/Win10Skin/Win10SkinConfig.h"
#include "../../Source/WinVistaSkin/WinVistaSkinConfig.h"

using namespace vl;

namespace demo
{
	void RegisterFctTheme(Ptr<presentation::theme::ThemeTemplates> selected)
	{
		for (auto name : { L"DarkSkin", L"Win7Skin", L"Win8Skin", L"WinXPSkin", L"WinVistaSkin", L"Win10Skin", L"Win11Skin" })
		{
			presentation::theme::UnregisterTheme(name);
		}
		presentation::theme::RegisterTheme(selected);
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
		addItem(L"WinVistaSkin", []
		{
			winvistaskin::SetColorPackage(winvistaskin::CreateDefaultColorPackage());
			RegisterFctTheme(Ptr(new winvistaskin::Theme));
		}, false);
		addItem(L"Win10Skin", []
		{
			win10skin::SetColorPackage(win10skin::CreateDefaultColorPackage());
			RegisterFctTheme(Ptr(new win10skin::Theme));
		}, false);
		addItem(L"Win10Skin/Dark", []
		{
			win10skin::SetColorPackage(win10skin::CreateDarkColorPackage());
			RegisterFctTheme(Ptr(new win10skin::Theme));
		}, false);
		addItem(L"Win11Skin", []
		{
			win11skin::SetColorPackage(win11skin::CreateDefaultColorPackage());
			RegisterFctTheme(Ptr(new win11skin::Theme));
		}, false);
		addItem(L"Win11Skin/Dark", []
		{
			win11skin::SetColorPackage(win11skin::CreateDarkColorPackage());
			RegisterFctTheme(Ptr(new win11skin::Theme));
		}, false);
	}
}
