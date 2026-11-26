#include "FullControlTest.h"
#include "FullControlTestEventHandlers.h"
#include "FullControlTestRawElement.h"
#include "NativeWindow/CocoaAutomationService.h"
#include "NativeWindow/OSX/CoreGraphics/CoreGraphicsApp.h"
#include <cstdio>
#include <cstring>

using namespace vl;
using namespace vl::presentation;
using namespace vl::presentation::controls;
using namespace vl::presentation::remoting;

int main(int argc, const char* argv[])
{
	bool hostedSpecified = false;
	bool multiWindowSpecified = false;
	for (int i = 1; i < argc; i++)
	{
		if (strcmp(argv[i], "/Hosted") == 0 || strcmp(argv[i], "--hosted") == 0)
		{
			hostedSpecified = true;
		}
		else if (strcmp(argv[i], "/MultiWindow") == 0 || strcmp(argv[i], "--multiwindow") == 0)
		{
			multiWindowSpecified = true;
		}
		else
		{
			std::fprintf(stderr, "Usage: FullControlTest [/Hosted | /MultiWindow]\n");
			return 1;
		}
	}
	if (hostedSpecified && multiWindowSpecified)
	{
		std::fprintf(stderr, "/Hosted and /MultiWindow are mutually exclusive.\n");
		return 1;
	}
	return multiWindowSpecified ? SetupOSXCoreGraphicsRenderer() : SetupOSXHostedCoreGraphicsRenderer();
}

void GuiMain()
{
	demo::RegisterFctDarkSkin();
	demo::MainWindow window;
	demo::AttachFctEvents<demo::DocumentEditorBase, demo::FctSkinItem>(&window);
	auto touchingAttachment = demo::AttachFullControlTestTouchingElement(window.GetTouchingElement());
	window.ForceCalculateSizeImmediately();
	window.MoveToScreenCenter();

	auto run = [&](INativeAutomationService& automationService)
	{
		GetNativeServiceSubstitution()->Substitute(&automationService, false);
		auto socketServer = inter_process::async_tcp_socket::CreateDefaultAsyncSocketServer(8888);
		StartMiniHttpAutomationService(socketServer, WString::Unmanaged(L"FullControlTest"));
		GetApplication()->Run(&window);
		StopMiniHttpAutomationService();
		automationService.Stop();
		GetNativeServiceSubstitution()->Unsubstitute(&automationService);
	};
	if (GetHostedApplication())
	{
		osx::CocoaAutomationServiceHosted automationService;
		run(automationService);
	}
	else
	{
		osx::CocoaAutomationService automationService;
		run(automationService);
	}
}
