cmake_minimum_required(VERSION 3.20)
project(xgSkinsLinux LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

find_package(PkgConfig REQUIRED)
find_package(Threads REQUIRED)
pkg_check_modules(WAYLAND REQUIRED IMPORTED_TARGET wayland-client wayland-cursor)
pkg_check_modules(XKB REQUIRED IMPORTED_TARGET xkbcommon)
pkg_check_modules(CAIRO REQUIRED IMPORTED_TARGET cairo pangocairo)
pkg_check_modules(FONTCONFIG REQUIRED IMPORTED_TARGET fontconfig)
pkg_check_modules(GIO REQUIRED IMPORTED_TARGET gio-2.0)
pkg_check_modules(URING REQUIRED IMPORTED_TARGET liburing)
pkg_check_modules(LIBDECOR REQUIRED IMPORTED_TARGET libdecor-0)

include("../CMakeLists.txt")
target_sources(GacUI PRIVATE
    "${RELEASE_ROOT}/Vlpp.Linux.cpp"
    "${RELEASE_ROOT}/VlppOS.Linux.cpp"
)
target_link_libraries(GacUI PUBLIC Threads::Threads PkgConfig::URING anl)

set(WGAC_ROOT "${REPO_ROOT}/Import/WGac")
set(WGAC_SHARED "${REPO_ROOT}/Import/WGacShared")
file(GLOB WGAC_SOURCES CONFIGURE_DEPENDS
    "${WGAC_ROOT}/Services/*.cpp"
    "${WGAC_ROOT}/Wayland/*.cpp"
    "${WGAC_ROOT}/Protocol/*.c"
)
add_library(WGac STATIC
    ${WGAC_SOURCES}
    "${WGAC_ROOT}/Renderers/WGacRendererImpl.cpp"
    "${WGAC_ROOT}/Renderers/GuiWaylandElement.cpp"
    "${WGAC_ROOT}/WGacController.cpp"
    "${WGAC_ROOT}/WGacNativeWindow.cpp"
    "${WGAC_ROOT}/WGacGacView.cpp"
    "${WGAC_ROOT}/WGacWindow.cpp"
    "${WGAC_ROOT}/WGacWindowView.cpp"
    "${WGAC_ROOT}/WGacCursor.cpp"
)
target_include_directories(WGac PUBLIC
    "${WGAC_ROOT}"
    "${WGAC_ROOT}/Renderers"
    "${WGAC_ROOT}/Services"
    "${WGAC_ROOT}/Protocol"
)
target_link_libraries(WGac PUBLIC
    GacUI
    PkgConfig::WAYLAND PkgConfig::XKB PkgConfig::CAIRO
    PkgConfig::FONTCONFIG PkgConfig::GIO PkgConfig::LIBDECOR
    Threads::Threads ${CMAKE_DL_LIBS} rt
)
# Keep resources and raw plugins directly in the executable to retain their
# static registrations when the framework and backend are linked as archives.
add_executable(FullControlTest
    ${FCT_SOURCES}
    "${REPO_ROOT}/Test/Linux/FullControlTest/Main.cpp"
    "${WGAC_SHARED}/FullControlTestRawElement.cpp"
    "${WGAC_SHARED}/FullControlTestRawClockInterpretor.cpp"
    "${WGAC_SHARED}/FullControlTestRawClockInterpretor_Wayland.cpp"
)
target_include_directories(FullControlTest PRIVATE
    "${FCT_ROOT}" "${FCT_ROOT}/UI/Source" "${WGAC_SHARED}"
)
target_link_libraries(FullControlTest PRIVATE WGac)
set_target_properties(FullControlTest PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)
