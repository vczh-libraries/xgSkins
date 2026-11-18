#include "UI/Source/FullControlTest.h"
#include "FullControlTestEventHandlers.h"
#include "FullControlTestRawElement.h"

#if defined VCZH_MSVC
#include <GacUI.Windows.h>
#include <Shellapi.h>

#pragma comment(lib, "Shell32.lib")
#pragma comment(linker,"\"/manifestdependency:type='win32' name='Microsoft.Windows.Common-Controls' version='6.0.0.0' processorArchitecture='*' publicKeyToken='6595b64144ccf1df' language='*'\"")

using namespace vl;
using namespace vl::presentation;
using namespace vl::presentation::controls;

namespace fullcontroltest
{
	bool useHosted = true;
}

void GuiMain()
{
	demo::RegisterFctDarkSkin();

	demo::MainWindow window;
	demo::AttachFctEvents<demo::DocumentEditorBase, demo::FctSkinItem>(&window);
	auto touchingAttachment = demo::AttachFullControlTestTouchingElement(window.GetTouchingElement());
	window.ForceCalculateSizeImmediately();
	window.MoveToScreenCenter();

	Ptr<INativeAutomationService> automationService;
	if (fullcontroltest::useHosted)
	{
		automationService = Ptr(new windows::WindowsAutomationServiceHosted);
	}
	else
	{
		automationService = Ptr(new windows::WindowsAutomationService);
	}
	GetNativeServiceSubstitution()->Substitute(automationService.Obj(), false);
	windows::StartWindowsHttpAutomationService(WString::Unmanaged(L"Automation/FullControlTest"), 8888);
	GetApplication()->Run(&window);
	windows::StopWindowsHttpAutomationService();
	automationService->Stop();
	GetNativeServiceSubstitution()->Unsubstitute(automationService.Obj());
}

int CALLBACK WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int CmdShow)
{
	int count = 0;
	auto arguments = CommandLineToArgvW(GetCommandLineW(), &count);
	if (!arguments) return 1;

	bool hostedSpecified = false;
	bool multiWindowSpecified = false;
	bool d2dSpecified = false;
	bool gdiSpecified = false;
	bool valid = true;
	for (vint i = 1; i < count; i++)
	{
		WString argument(arguments[i]);
		if (argument == L"/Hosted") hostedSpecified = true;
		else if (argument == L"/MultiWindow") multiWindowSpecified = true;
		else if (argument == L"/D2D") d2dSpecified = true;
		else if (argument == L"/GDI") gdiSpecified = true;
		else valid = false;
	}
	LocalFree(arguments);
	if (!valid || (hostedSpecified && multiWindowSpecified) || (d2dSpecified && gdiSpecified)) return 1;

	fullcontroltest::useHosted = !multiWindowSpecified;
	auto result = gdiSpecified
		? (fullcontroltest::useHosted ? SetupHostedWindowsGDIRenderer() : SetupWindowsGDIRenderer())
		: (fullcontroltest::useHosted ? SetupHostedWindowsDirect2DRenderer() : SetupWindowsDirect2DRenderer());
#if defined _DEBUG && defined VCZH_CHECK_MEMORY_LEAKS
	_CrtDumpMemoryLeaks();
#endif
	return result;
}
#endif
