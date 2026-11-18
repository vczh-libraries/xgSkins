#ifndef VCZH_DEMO_FULLCONTROLTESTEVENTHANDLERS
#define VCZH_DEMO_FULLCONTROLTESTEVENTHANDLERS

#include "SharedDocumentEditor.h"

namespace demo
{
	extern void InitializeFctSkinItems(const vl::Func<void(const vl::WString&, const vl::Func<void()>&, bool)>& addItem);

	// Each editor owns its viewer. Refreshing templates does not reattach these handlers.
	template<typename TEditor, typename TSkinItem, typename TWindow>
	void AttachFctEvents(TWindow* window)
	{
		InitializeFctSkinItems([window](const vl::WString& name, const vl::Func<void()>& action, bool selected)
		{
			auto item = vl::Ptr(new TSkinItem(name, action));
			if (selected) window->SetSelectedSkinItem(item);
			window->GetSkinItems()->Add(vl::reflection::description::BoxValue(item));
		});
		for (auto name : { L"editorRibbon", L"editorToolstrip" })
		{
			auto editor = dynamic_cast<TEditor*>(window->GetNamedObject(name).GetRawPtr());
			auto viewer = dynamic_cast<vl::presentation::controls::GuiDocumentViewer*>(editor->GetNamedObject(L"document").GetRawPtr());
			editor->LoadAsPrivateFormat.Add([viewer](const vl::WString& fileName) { viewer->SetDocument(gacui_demo::LoadDocument(fileName)); });
			editor->SaveAsPrivateFormat.Add([viewer](const vl::WString& fileName) { gacui_demo::SaveDocument(viewer->GetDocument(), fileName); });
			editor->SaveAsRTF.Add([viewer](const vl::WString& fileName)
			{
				viewer->SelectAll();
				gacui_demo::ExportDocumentRtf(viewer->GetSelectionModel(), fileName);
			});
			editor->SaveAsHTML.Add([viewer](const vl::WString& fileName)
			{
				viewer->SelectAll();
				gacui_demo::ExportDocumentHtml(viewer->GetSelectionModel(), fileName);
			});
		}
	}
}

#endif
