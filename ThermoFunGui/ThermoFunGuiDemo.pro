#-------------------------------------------------
#
# Project created by QtCreator 2016-02-08T16:01:53
#
#-------------------------------------------------


TARGET = ThermoFunDemoGui
TEMPLATE = app

CONFIG += thread
CONFIG += c++11
CONFIG += warn_on

#QMAKE_CXXFLAGS_RELEASE = -Wpedantic
#QMAKE_CFLAGS_RELEASE = -Wno-unknown-pragmas -Wpedantic

DEFINES += FROM_SRC

win32:DEFINES  +=  NO_QWEBENGINE

!win32 {
    DEFINES += __unix
} else
{
    DEFINES  +=  IMPEX_OFF
}

QT   += core gui widgets
QT   += svg printsupport concurrent
QT   += charts

!contains(DEFINES, NO_QWEBENGINE) {
    QT   += webenginewidgets
}


# Define the directory where source code is located
#THRIFT_DIR    = ./thrift
FUN_DIR       = ../ThermoFun
FUN_CPP       = $$FUN_DIR
FUN_H         = $$FUN_DIR
GUI_DIR       = ./src
GUI_CPP       = $$GUI_DIR
GUI_H         = $$GUI_DIR
CLIENT_DIR = ../ThermoHubClient
CLIENT_CPP = $$CLIENT_DIR
CLIENT_H   = $$CLIENT_DIR
#GUI_CPP       =  ./GUI
#GUI_H         =  $$GUI_CPP

DEPENDPATH   += $$GUI_H
DEPENDPATH   += $$GUI_DIR

INCLUDEPATH   += $$GUI_H
INCLUDEPATH   += $$GUI_DIR

DEPENDPATH   += $$FUN_H
DEPENDPATH   += $$FUN_DIR

INCLUDEPATH   += $$FUN_H
INCLUDEPATH   += $$FUN_DIR

DEPENDPATH   += $$CLIENT_H
DEPENDPATH   += $$CLIENT_DIR

INCLUDEPATH   += $$CLIENT_H
INCLUDEPATH   += $$CLIENT_DIR

macx-clang {
  DEFINES += __APPLE__
  CONFIG -= warn_on
  CONFIG += warn_off
  INCLUDEPATH   += "/usr/local/include"
  DEPENDPATH   += "/usr/local/include"
  LIBPATH += "/usr/local/lib/"
}

!win32 {

    INCLUDEPATH   += "/usr/local/include"
    DEPENDPATH   += "/usr/local/include"
    LIBPATH += "/usr/local/lib"

    ## Markdown editor
    contains(DEFINES, USE_MARKDOWN) {
        LIBS +=  -lmarkdown
    }
    else
    {
        contains(DEFINES, NO_QWEBENGINE) {
        LIBS +=  -lmarkdown
        }
    }

    LIBS +=  -ljsonui -ljsonio -ljsonimpex
    LIBS +=  -lyaml-cpp  -lpugixml
    LIBS +=  -lboost_regex -lboost_system -lboost_filesystem
    LIBS +=  -lcurl  -lvelocypack -lthrift

    !macx-clang:LIBS += -llua5.3
}

MOC_DIR = tmp
UI_DIR        = $$MOC_DIR
UI_SOURSEDIR  = $$MOC_DIR
UI_HEADERDIR  = $$MOC_DIR
OBJECTS_DIR   = obj

#include($$THRIFT_DIR/thrift.pri)
#include($$GEN_DIR/generator.pri)
include($$GUI_DIR/ThermoFunGui.pri)
include($$CLIENT_DIR/ThermoHubClient.pri)
include($$FUN_DIR/ThermoFun.pri)

RESOURCES += \
    ThermoFunGuiDemo.qrc

#thrift -r -v --gen cpp

SOURCES += \
    demo/main.cpp \
    demo/ThermoFunMainWindow.cpp

HEADERS += \
    demo/ThermoFunMainWindow.h

FORMS += \
    demo/ThermoFunMainWindow.ui

win32 {
    QT   += webenginewidgets
    QMAKE_CXXFLAGS_WARN_ON = -wd4068 -wd4138
}

win32:DEFINES += IMPEX_OFF
win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../dependencies/lib-dll-release-x64/ -llibcurl
win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../dependencies/lib-static-release-x64/ -lvelocypack -llibboost_regex* -llibboost_filesystem-vc-mt* -llibboost_system* -llibjsonio -llibjsonui

win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../dependencies/lib-dll-debug-x64/ -llibcurl_debug
win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../dependencies/lib-static-debug-x64/ -lvelocypack -llibboost_regex* -llibboost_filesystem* -llibboost_system* -llibjsonio -llibjsonui
win32:INCLUDEPATH += $$PWD/../../dependencies/include
win32:DEPENDPATH += $$PWD/../../dependencies/include
