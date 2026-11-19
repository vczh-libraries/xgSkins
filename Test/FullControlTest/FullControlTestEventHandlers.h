#ifndef VCZH_DEMO_FULLCONTROLTESTEVENTHANDLERS
#define VCZH_DEMO_FULLCONTROLTESTEVENTHANDLERS

#include "SharedDocumentEditor.h"

namespace demo
{
	extern void RegisterFctDarkSkin();
	extern void InitializeFctSkinItems(const vl::Func<void(const vl::WString&, const vl::Func<void()>&, bool)>& addItem);

	// Each editor owns its viewer. Refreshing templates does not reattach these handlers.
	template<typename TEditor, typename TSkinItem, typename TWindow>
	void AttachFctEvents(TWindow* window)
	{
		auto updateEditorArtwork = [window]()
		{
			using namespace vl::presentation;
			controls::GuiLabel label(theme::ThemeName::Label);
			label.GetControlTemplateObject();
			auto ink = label.GetTextColor();
			bool lightInk = 299 * ink.r + 587 * ink.g + 114 * ink.b >= 128000;
			for (auto name : { L"editorRibbon", L"editorToolstrip" })
			{
				auto editor = dynamic_cast<TEditor*>(window->GetNamedObject(name).GetRawPtr());
				editor->SetLightIconInk(lightInk);
			}
		};
		updateEditorArtwork();
		InitializeFctSkinItems([window, updateEditorArtwork](const vl::WString& name, const vl::Func<void()>& action, bool selected)
		{
			auto item = vl::Ptr(new TSkinItem(name, [action, updateEditorArtwork]()
			{
				action();
				updateEditorArtwork();
			}));
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
