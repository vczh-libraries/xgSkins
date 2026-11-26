#include "FullControlTest.h"
#include "FullControlTestEventHandlers.h"
#include "FullControlTestRawElement.h"
#include <Renderers/WGacRenderer.h>
#include <Services/WGacAutomationService.h>
#include <cstdio>
#include <cstring>

using namespace vl;
using namespace vl::presentation;
using namespace vl::presentation::controls;
using namespace vl::presentation::remoting;

int main(int argc, char* argv[])
{
	bool hostedSpecified = false;
	bool multiWindowSpecified = false;
	for (vint i = 1; i < argc; i++)
	{
		if (strcmp(argv[i], "/Hosted") == 0) hostedSpecified = true;
		else if (strcmp(argv[i], "/MultiWindow") == 0) multiWindowSpecified = true;
		else
		{
			std::fputs("Usage: FullControlTest [/Hosted | /MultiWindow]\n", stderr);
			return 1;
		}
	}
	if (hostedSpecified && multiWindowSpecified)
	{
		std::fputs("/Hosted and /MultiWindow are mutually exclusive.\n", stderr);
		return 1;
	}
	return multiWindowSpecified
		? elements::wgac::SetupWGacRenderer()
		: elements::wgac::SetupWGacHostedRenderer();
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
	if (GetHostedApplication())
	{
		automationService = Ptr(new wayland::WGacAutomationServiceHosted);
	}
	else
	{
		automationService = Ptr(new wayland::WGacAutomationService);
	}
	GetNativeServiceSubstitution()->Substitute(automationService.Obj(), false);
	auto socketServer = inter_process::async_tcp_socket::CreateDefaultAsyncSocketServer(8888);
	StartMiniHttpAutomationService(socketServer, WString::Unmanaged(L"FullControlTest"));
	GetApplication()->Run(&window);
	StopMiniHttpAutomationService();
	automationService->Stop();
	GetNativeServiceSubstitution()->Unsubstitute(automationService.Obj());
}
