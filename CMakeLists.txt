cmake_minimum_required(VERSION 3.5)

project(SpeechRateMeter LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check http://doc.qt.io/qt-5/deployment-android.html for more information.
# They need to be set before the find_package(Qt5 ...) call.

add_subdirectory(inton-core)

if(ANDROID)
    find_package(Qt5 COMPONENTS Core Quick QuickControls2 Widgets Charts LinguistTools Multimedia MultimediaWidgets AndroidExtras REQUIRED)
else()
    find_package(Qt5 COMPONENTS Core Quick QuickControls2 Widgets Charts LinguistTools Multimedia MultimediaWidgets REQUIRED)
endif()

set(TS_FILES SpeechRateMeter_en_US.ts)

file(GLOB SOURCES src/*.cpp)
file(GLOB HEADERS src/*.h)

file(GLOB OTHER_SOURCES src/*/*.cpp)
file(GLOB OTHER_HEADERS src/*/*.h)

file(GLOB 3DPARTY_SOURCES 3party/*/*.cpp)
file(GLOB 3DPARTY_HEADERS 3party/*/*.h)

if(ANDROID)
    add_library(SpeechRateMeter SHARED
        ${OTHER_HEADERS}
        ${OTHER_SOURCES}
        ${3DPARTY_HEADERS}
        ${3DPARTY_SOURCES}
        ${HEADERS}
        ${SOURCES}
        qml.qrc
        ${TS_FILES}
    )
else()
    if (WIN32)
        set(WIN32_ON_OFF_SWITCH "WIN32")
    else ()
        set(WIN32_ON_OFF_SWITCH "")
    endif ()
    add_executable(SpeechRateMeter
        ${WIN32_ON_OFF_SWITCH}
        ${OTHER_HEADERS}
        ${OTHER_SOURCES}
        ${3DPARTY_HEADERS}
        ${3DPARTY_SOURCES}
        ${HEADERS}
        ${SOURCES}
        qml.qrc
        ${TS_FILES}
    )
endif()

target_compile_definitions(SpeechRateMeter
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

if(ANDROID)
    target_link_libraries(SpeechRateMeter
      PRIVATE IntonCore Qt5::Core Qt5::Quick Qt5::QuickControls2 Qt5::Widgets Qt5::Charts Qt5::Multimedia Qt5::MultimediaWidgets Qt5::AndroidExtras)
else()
    target_link_libraries(SpeechRateMeter
      PRIVATE IntonCore Qt5::Core Qt5::Quick Qt5::QuickControls2 Qt5::Widgets Qt5::Charts Qt5::Multimedia Qt5::MultimediaWidgets)
endif()


qt5_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})
