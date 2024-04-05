cmake_minimum_required(VERSION 3.16)

project(cooling_chamber VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick SerialBus Test)

qt_standard_project_setup()

qt_add_executable(appcooling_chamber
    main.cpp
)

add_library(CoolingChamberLibrary
    STATIC
    processitem.h processitem.cpp
    processmodel.h processmodel.cpp
    probedata.h probedata.cpp
    readprobes.h readprobes.cpp
    productsmodel.h productsmodel.cpp
    product.h product.cpp
    lamp.h lamp.cpp
)

target_link_libraries(CoolingChamberLibrary
    Qt6::Core
    Qt6::SerialBus
)

qt_add_qml_module(appcooling_chamber
    URI cooling_chamber
    VERSION 1.0
    QML_FILES Main.qml
    RESOURCES
        img/logo.png
        img/mode_0.svg
        img/mode_1.svg
        img/gear.svg
        img/machine.svg
        img/offline.svg
        img/battery.svg
        img/trash.svg
        img/edit.svg
    QML_FILES TargetMachine.qml
    QML_FILES ProcessItemDelegate.qml
    QML_FILES SettingsPanel.qml
    QML_FILES PopUpStop.qml
    QML_FILES PopUpStart.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appcooling_chamber PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appcooling_chamber
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appcooling_chamber
    PRIVATE CoolingChamberLibrary
    PRIVATE Qt6::Quick
    PRIVATE Qt6::SerialBus
)

include(GNUInstallDirs)
install(TARGETS appcooling_chamber
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)


add_subdirectory(tests)
