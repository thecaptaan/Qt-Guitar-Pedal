cmake_minimum_required(VERSION 3.16)

project(Learn VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appLearn
    main.cpp
)

qt_add_qml_module(appLearn
    URI Learn
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES assets/fonts/Prisma.ttf assets/fonts/RussoOne-Regular.ttf assets/images/Button-Pedal-Checked.png assets/images/Button-Pedal-Checked@2x.png assets/images/Button-Pedal.png assets/images/Button-Pedal@2x.png assets/images/Guitar-Pedal-Background.png assets/images/Guitar-Pedal-Background@2x.png assets/images/Knob-Dial.png assets/images/Knob-Dial@2x.png assets/images/Knob-Markings.png assets/images/Knob-Markings@2x.png assets/images/LED-Checked.png assets/images/LED-Checked@2x.png assets/images/LED.png assets/images/LED@2x.png assets/images/Screw.png assets/images/Screw@2x.png assets/images/Switch-Checked.png assets/images/Switch-Checked@2x.png assets/images/Switch.png assets/images/Switch@2x.png
        RESOURCES assets/fonts/Prisma.ttf assets/fonts/RussoOne-Regular.ttf
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appLearn PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appLearn
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appLearn
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appLearn
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
