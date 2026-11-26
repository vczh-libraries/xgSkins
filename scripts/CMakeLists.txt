# Source inventory shared by the native test applications.
get_filename_component(REPO_ROOT "${CMAKE_CURRENT_LIST_DIR}/.." ABSOLUTE)
set(RELEASE_ROOT "${REPO_ROOT}/Import/Release")
set(FCT_ROOT "${REPO_ROOT}/Test/FullControlTest")

add_library(GacUI STATIC
    "${RELEASE_ROOT}/Vlpp.cpp"
    "${RELEASE_ROOT}/VlppOS.cpp"
    "${RELEASE_ROOT}/VlppRegex.cpp"
    "${RELEASE_ROOT}/VlppReflection.cpp"
    "${RELEASE_ROOT}/VlppGlrParser.cpp"
    "${RELEASE_ROOT}/VlppWorkflowLibrary.cpp"
    "${RELEASE_ROOT}/GacUI.cpp"
    "${RELEASE_ROOT}/Skins/DarkSkin/DarkSkin.cpp"
)
target_include_directories(GacUI PUBLIC "${RELEASE_ROOT}" "${REPO_ROOT}/Import/Release-Test")
target_compile_definitions(GacUI PUBLIC VCZH_DEBUG_NO_REFLECTION)
target_compile_features(GacUI PUBLIC cxx_std_20)

file(GLOB FCT_GENERATED_SOURCES CONFIGURE_DEPENDS "${FCT_ROOT}/UI/Source/*.cpp")
list(FILTER FCT_GENERATED_SOURCES EXCLUDE REGEX "Reflection\\.cpp$")
set(FCT_SOURCES
    "${FCT_ROOT}/FullControlTestEventHandlers.cpp"
    "${FCT_ROOT}/SharedDocumentEditor.cpp"
    ${FCT_GENERATED_SOURCES}
)

foreach(skin Win7Skin Win8Skin WinXPSkin WinVistaSkin Win10Skin Win11Skin UbuntuSkin)
    file(GLOB SKIN_GENERATED_SOURCES CONFIGURE_DEPENDS "${REPO_ROOT}/Source/${skin}/Source/*.cpp")
    list(FILTER SKIN_GENERATED_SOURCES EXCLUDE REGEX "Reflection\\.cpp$")
    list(APPEND FCT_SOURCES "${REPO_ROOT}/Source/${skin}/${skin}Config.cpp" ${SKIN_GENERATED_SOURCES})
endforeach()
