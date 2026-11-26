cmake_minimum_required(VERSION 3.20)
project(xgSkins LANGUAGES CXX OBJCXX)

if(NOT APPLE)
    message(FATAL_ERROR "This build requires macOS.")
endif()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_OBJCXX_STANDARD 20)
set(CMAKE_OBJCXX_STANDARD_REQUIRED ON)
set(CMAKE_OBJCXX_EXTENSIONS OFF)

include("../CMakeLists.txt")
set(MAC_ROOT "${REPO_ROOT}/Import/Mac")
set(MAC_SHARED_ROOT "${REPO_ROOT}/Import/MacShared")

# These upstream files implement the shared POSIX layer, including macOS.
target_sources(GacUI PRIVATE "${RELEASE_ROOT}/Vlpp.Linux.cpp" "${RELEASE_ROOT}/VlppOS.Linux.cpp")

file(GLOB MAC_SOURCES CONFIGURE_DEPENDS
    "${MAC_ROOT}/GraphicsElement/CoreGraphics/*.cpp"
    "${MAC_ROOT}/GraphicsElement/CoreGraphics/*.mm"
    "${MAC_ROOT}/NativeWindow/OSX/*.mm"
    "${MAC_ROOT}/NativeWindow/OSX/CoreGraphics/*.mm"
    "${MAC_ROOT}/NativeWindow/OSX/ServicesImpl/*.mm"
)
add_library(GacOSX STATIC
    ${MAC_SOURCES}
    "${MAC_ROOT}/NativeWindow/CocoaAutomationService.cpp"
    "${MAC_SHARED_ROOT}/osx_shared.mm"
    "${MAC_SHARED_ROOT}/UnixFileSystemInfo.cpp"
)
set_source_files_properties("${MAC_ROOT}/NativeWindow/CocoaAutomationService.cpp" PROPERTIES LANGUAGE OBJCXX)
target_include_directories(GacOSX PUBLIC "${MAC_ROOT}" "${MAC_SHARED_ROOT}")
target_link_libraries(GacOSX PUBLIC GacUI)

foreach(framework CoreFoundation Quartz CoreGraphics Cocoa UniformTypeIdentifiers Carbon Network)
    find_library(${framework}_LIBRARY ${framework} REQUIRED)
    target_link_libraries(GacOSX PUBLIC "${${framework}_LIBRARY}")
endforeach()

add_executable(FullControlTest MACOSX_BUNDLE
    "${REPO_ROOT}/Test/macOS/FullControlTest/Main.mm"
    "${MAC_SHARED_ROOT}/FullControlTestRawClockInterpretor.cpp"
    "${MAC_SHARED_ROOT}/FullControlTestRawClockInterpretorCocoa.cpp"
    "${MAC_SHARED_ROOT}/FullControlTestRawElement.cpp"
    ${FCT_SOURCES}
)
target_include_directories(FullControlTest PRIVATE "${FCT_ROOT}" "${FCT_ROOT}/UI/Source")
target_link_libraries(FullControlTest PRIVATE GacOSX)
set_target_properties(FullControlTest PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    MACOSX_BUNDLE_INFO_PLIST "${REPO_ROOT}/Test/macOS/FullControlTest/Info.plist.in"
    MACOSX_BUNDLE_GUI_IDENTIFIER "org.gaclib.xgSkins.FullControlTest"
    MACOSX_BUNDLE_BUNDLE_NAME "FullControlTest"
)
